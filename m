From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 14 Jun 2018 12:28:42 +0200
Subject: [PATCH v1] ARM: dts: imx6sx: fix irq for pcie bridge
In-Reply-To: <20180614094527.25905-1-o.rempel@pengutronix.de>
References: <20180614094527.25905-1-o.rempel@pengutronix.de>
Message-ID: <1528972122.21021.38.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 14.06.2018, 11:45 +0200 schrieb Oleksij Rempel:
> Without this patch MSI interrupts are not routed from Intel
> i350 PCIe adapter.

This has nothing to do with the attached endpoint device, so the commit
message should read something like:

Use the correct IRQ line for the MSI controller in the PCIe host
controller. Apparently a different IRQ line is used compared to other
i.MX6 variants. Without this change MSI IRQs aren't properly propagated
to the the upstream interrupt controller.

With this fixed:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> ?arch/arm/boot/dts/imx6sx.dtsi | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 49c7205b8db8..77fdad65e2bb 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -1351,7 +1351,7 @@
> > ?			ranges = <0x81000000 0 0??????????0x08f80000 0 0x00010000 /* downstream I/O */
> > ?				??0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
> > ?			num-lanes = <1>;
> > -			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> > ?			interrupt-names = "msi";
> > ?			#interrupt-cells = <1>;
> > ?			interrupt-map-mask = <0 0 0 0x7>;
