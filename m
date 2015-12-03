From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 3 Dec 2015 09:43:53 +0100
Subject: [linux-sunxi] [PATCH 0/4] ARM: sun9i: Support Allwinner A80 NMI
 controller
In-Reply-To: <1449130813-22400-1-git-send-email-wens@csie.org>
References: <1449130813-22400-1-git-send-email-wens@csie.org>
Message-ID: <566000C9.3070307@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03-12-15 09:20, Chen-Yu Tsai wrote:
> Hi everyone,
>
> This series extends irqchip-sunxi-nmi to add support for the NMI
> controller found in Allwinner's A80 SoC.
>
> All Allwinner SoCs have an external NMI pin which the PMIC uses to
> signal interrupts to the processor. On multi-core chips, there's an
> NMI controller handling this pin and chaining interrupts to the GIC.
> We already have support for this on previous sun[678]i family chips.
>
> This series extends support to the A80 SoC. This is needed to add
> support for the PMICs. A complete series, including PMIC support,
> can be found here:
>
>      https://github.com/wens/linux/tree/axp809
>
> Patch 1 renames the binding doc, to remove the SoC specific bits from
> the filename.
>
> Patch 2 adds a new compatible string for the A80 variant.
>
> Patch 3 adds driver support for the A80 variant.
>
> Patch 4 adds the NMI controller device node to the A80 dtsi file.
>
> Chen-Yu Tsai (4):
>    irqchip/sunxi-nmi: Rename binding doc filename to
>      allwinner,sunxi-nmi.txt
>    irqchip/sunxi-nmi: Add sun9i-a80 variant to binding doc
>    irqchip/sunxi-nmi: Support sun9i A80 NMI controller
>    ARM: dts: sun9i: Add NMI controller device node

Series looks good to me and is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
