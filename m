From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 24 Jul 2015 16:27:52 +0800
Subject: [PATCH v2 0/7] Making the generic ACPI GSI layer irqdomain aware
In-Reply-To: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <55B1F708.3010804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/23/2015 09:05 PM, Marc Zyngier wrote:
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
> This has been test-booted on Juno, is based on my irq/ncpi-msi-v3
> branch, and available at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gsi-irq-domain-v2

Pulled and rebased my self-probing and GICv3 ACPI support patches on
top of it, tested on FVP and QEMU, booted OK, for this patch set,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

I will sync with Suravee to prepare a single patch for
ACPI self-probing, GICv2m and GICv3 support.

Thank you for putting thing together!
Hanjun
