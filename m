From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 22 Jul 2015 14:45:52 +0800
Subject: [PATCH 0/5] Making the generic ACPI GSI layer irqdomain aware
In-Reply-To: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <55AF3C20.2060103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/21/2015 06:07 PM, Marc Zyngier wrote:
> The irqdomain code is not entierely really ACPI friendly, as it has
> some built-in knowledge of the device-tree. Nothing too harmful, but
> enough to scare the ARM ACPI developpers which end up with their own
> version of the square wheel.
>
> This small patch series adapt the irqdomain code to remove the hurdles
> that prevent the full blown irqdomain subsystem to be used on ACPI,
> creates an interface between the GSI layer and the irqdomain, and as
> an example, convert the ARM GIC ACPI support to use irqdomains as
> originally intended.
>
> Overall, this gives us a way to use irqdomains on both DT and ACPI
> enabled platforms, having very little changes made to the actual
> drivers (other than the probing infrastructure). Because we keep the
> flow of information between the various layers identical between ACPI
> and DT, we immediately benefit from the existing infrastructure.
>
> I'd really like to hear what people think of that approach, as it
> looks to me a lot simpler than the other approaches currently put on
> the list. The "convert the GSI information to be DT friendly" is
> admitedly not very pretty, but I see it as a stepping stone towards
> unifying the two structures.
>
> This has been test-booted on Juno, and is based on my irq/ncpi-msi-2
> branch.

Thank you very much for putting them together, really appreciated. I
will comment on each patch and test them.

Thanks
Hanjun
