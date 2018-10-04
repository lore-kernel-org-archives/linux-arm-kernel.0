From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 4 Oct 2018 16:57:37 +0200
Subject: [PATCH v9 03/11] PM / Domains: Document flags for genpd
In-Reply-To: <20181004134839.GZ5662@atomide.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-4-ulf.hansson@linaro.org>
 <20181004134839.GZ5662@atomide.com>
Message-ID: <CAPDyKFr1H_ah3OYqghQgADs8fwNd+HpjWw9VfGR1T1-K5KbnhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 October 2018 at 15:48, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Ulf Hansson <ulf.hansson@linaro.org> [181003 14:43]:
>> + * GENPD_FLAG_IRQ_SAFE:              This informs genpd that its backend callbacks,
>> + *                           ->power_on|off(), doesn't sleep. Hence, these
>> + *                           can be invoked from within atomic context, which
>> + *                           enables genpd to power on/off the PM domain,
>> + *                           even when pm_runtime_is_irq_safe() returns true,
>> + *                           for any of its attached devices. Note that, a
>> + *                           genpd having this flag set, requires its
>> + *                           masterdomains to also have it set.
>> + *
>
> Let's try to avoid adding more irq_safe stuff because of having that
> propagate to the masterdomains..

I am not sure I get your point. This is just documenting existing
functionality in genpd, there is nothing new here.

>
> I think you can just flag the power_on/off in genpd, then have cpu_pm
> callbacks do it.

Not really sure what you propose, but feel free to send a patch.

Do note, genpd has since the beginning of its time tried to cope with
pm_runtime_irq_safe() devices. I admit it's quite complicated, however
GENPD_FLAG_IRQ_SAFE greatly improved the support for such devices and
their PM domains. Moreover, we need this functionality, in one way or
the other, as long as there users of pm_runtime_irq_safe().

Kind regards
Uffe
