From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jan 2017 10:17:36 +0100
Subject: [PATCH v3 8/13] arm64: allwinner: a64: Add MMC nodes
In-Reply-To: <20170116191641.GA11718@Red>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <ac77b9e25e7633886822cd1f1ebafd5985751ae4.1484585798.git-series.maxime.ripard@free-electrons.com>
 <20170116191641.GA11718@Red>
Message-ID: <20170125091736.drdon6yjyjwngtja@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

On Mon, Jan 16, 2017 at 08:16:41PM +0100, Corentin Labbe wrote:
> On Mon, Jan 16, 2017 at 05:56:58PM +0100, Maxime Ripard wrote:
> > From: Andre Przywara <andre.przywara@arm.com>
> > 
> > The A64 has 3 MMC controllers, one of them being especially targeted to
> > eMMC. Among other things, it has a data strobe signal and a 8 bits data
> > width.
> > 
> > The two other are more usual controllers that will have a 4 bits width at
> > most and no data strobe signal, which limits it to more usual SD or MMC
> > peripherals.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 ++++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index 99b6bb1e141c..143e9706438f 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -299,6 +299,45 @@
> >  			#size-cells = <0>;
> >  		};
> >  
> > +		mmc0: mmc at 1c0f000 {
> > +			compatible = "allwinner,sun50i-a64-mmc";
> > +			reg = <0x01c0f000 0x1000>;
> > +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> > +			clock-names = "ahb", "mmc";
> > +			resets = <&ccu RST_BUS_MMC0>;
> > +			reset-names = "ahb";
> > +			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		mmc1: mmc at 1c10000 {
> > +			compatible = "allwinner,sun50i-a64-mmc";
> > +			reg = <0x01c10000 0x1000>;
> > +			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
> > +			clock-names = "ahb", "mmc";
> > +			resets = <&ccu RST_BUS_MMC1>;
> > +			reset-names = "ahb";
> > +			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		mmc2: mmc at 1c11000 {
> > +			compatible = "allwinner,sun50i-a64-emmc";
> > +			reg = <0x01c11000 0x1000>;
> > +			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
> > +			clock-names = "ahb", "mmc";
> > +			resets = <&ccu RST_BUS_MMC2>;
> > +			reset-names = "ahb";
> > +			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> >  		gic: interrupt-controller at 1c81000 {
> >  			compatible = "arm,gic-400";
> >  			reg = <0x01c81000 0x1000>,
> 
> Hello
> 
> It seems that mmc node is after i2c at 1c2b400 so not in address order.

You're right, I'll fix this in the v3.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/b21e783c/attachment.sig>
