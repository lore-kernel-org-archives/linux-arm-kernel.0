From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 28 Feb 2014 10:10:07 +0800
Subject: [PATCH 1/3] PCI: designware: add legacy PCI interrupt mapping
In-Reply-To: <1393550394-11071-2-git-send-email-tharvey@gateworks.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <1393550394-11071-2-git-send-email-tharvey@gateworks.com>
Message-ID: <20140228021005.GI13537@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 05:19:52PM -0800, Tim Harvey wrote:
> The IMX6 maps INTA/B/C/D to ARM GIC IRQ 155/154/153/152 respectively.
> This allows a PCIe-to-PCI bridge to function properly.
> 
> The irq field of the pcie_host struct is expanded to 4 interrupts to
> allow for INTA/B/C/D and the IMX6 PCIe host driver will populate them
> all from devicetree.  I'm not clear if the Exynos driver has this
> capability so it places the same interrupt in all 4 slots.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi     |  2 +-

This change should be in a separate patch that goes to IMX tree.  And
please be aware of Arnd's comment [1] there.

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg311615.html
