From: yao.yuan@nxp.com (Yao Yuan)
Date: Tue, 2 Feb 2016 11:10:41 +0000
Subject: [PATCH] dts/ls1021a: add the DTS for QSPI support
In-Reply-To: <20160202074907.GK8307@tiger>
References: <1453970006-46509-1-git-send-email-yao.yuan@freescale.com>
 <20160202074907.GK8307@tiger>
Message-ID: <AM2PR04MB07222EF8C4A2B70D383D621789DF0@AM2PR04MB0722.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 03:49PM, Shawn Guo wrote:
> On Thu, Jan 28, 2016 at 04:33:26PM +0800, Yuan Yao wrote:
> > From: Yuan Yao <yao.yuan@nxp.com>
> >
> > Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> > ---
> > Add in v1:
> > Can merge, but the function depend on the patch:
> > https://patchwork.kernel.org/patch/8118251/
> 
> Please send me dts patch only after the driver part gets applied.

Ok, I will resend the patch after the driver part gets applied.
I just only want to speed up my upstream.

> 
> >
> > mtd: spi-nor: fsl-quadspi: add support for ls1021a
> >
> > LS1021a also support Freescale Quad SPI controller.
> > Add fsl-quadspi support for ls1021a chip and make SPI_FSL_QUADSPI
> > selectable for LS1021A SOC hardwares.
> >
> > ---
> >  arch/arm/boot/dts/ls1021a.dtsi | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi
> > b/arch/arm/boot/dts/ls1021a.dtsi index 9430a99..c764fa5 100644
> > --- a/arch/arm/boot/dts/ls1021a.dtsi
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -252,6 +252,21 @@
> >  			status = "disabled";
> >  		};
> >
> > +		qspi: quadspi at 1550000 {
> > +			compatible = "fsl,ls1021a-qspi";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x0 0x1550000 0x0 0x10000>,
> > +				<0x0 0x40000000 0x0 0x4000000>;
> > +			reg-names = "QuadSPI", "QuadSPI-memory";
> > +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> > +			clock-names = "qspi_en", "qspi";
> > +			clocks = <&platform_clk 1>, <&platform_clk 1>;
> > +			big-endian;
> > +			amba-base = <0x40000000>;
> 
> What is this property?  I cannot find it in any bindings doc.  Is it added by your
> patches on driver code?

Sorry, it's the legacy property, after the latest discussion we will remove this property.
So I will remove it in the next version.
Thanks for your review.

Yuan Yao.
