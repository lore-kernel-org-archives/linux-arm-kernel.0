From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 11 Jun 2014 22:34:48 +0200
Subject: [PATCH 07/24] ARM: shmobile: Drop dev_irq_safe from r8a7779 genpd
 config
In-Reply-To: <7ha99jiabs.fsf@paris.lan>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
 <1402397497-26737-8-git-send-email-ulf.hansson@linaro.org>
 <7ha99jiabs.fsf@paris.lan>
Message-ID: <CAPDyKFq7hdK=3jtni=nr4R6LVXubZZH3xc7=VkP5_CLQ4xaRQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 June 2014 20:13, Kevin Hilman <khilman@linaro.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> The dev_irq_safe configuration is redundant, genpd don't have any
>> special treatmeant for handling it.  Let's remove it.
>
> Why?
>
> The genpd core needs to handle irq_safe properly eventully (right now it
> just doesn't call power_off/power_on callbacks, but that needs to be
> implmenented.  c.f commit 0aa2a22169)
>
> If we remove these flags from platforms, we're taking away information
> that the platform maintainers have specified tha will be useful when
> full support is avialble.

For sure this is needed in _some_ form. But before we even figured out
how to support irq_safe genpd's, why even bother to support a
configuration for it?

Currently I think it good enough to use the per device irq_safe
option, and then let's see how handling of these devices evolves.

Kind regards
Uffe
