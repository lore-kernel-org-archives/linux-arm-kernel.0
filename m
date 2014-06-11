From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 11 Jun 2014 11:13:11 -0700
Subject: [PATCH 07/24] ARM: shmobile: Drop dev_irq_safe from r8a7779 genpd
 config
In-Reply-To: <1402397497-26737-8-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Tue, 10 Jun 2014 12:51:20 +0200")
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
 <1402397497-26737-8-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7ha99jiabs.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The dev_irq_safe configuration is redundant, genpd don't have any
> special treatmeant for handling it.  Let's remove it.

Why?

The genpd core needs to handle irq_safe properly eventully (right now it
just doesn't call power_off/power_on callbacks, but that needs to be
implmenented.  c.f commit 0aa2a22169)

If we remove these flags from platforms, we're taking away information
that the platform maintainers have specified tha will be useful when
full support is avialble.

Kevin
