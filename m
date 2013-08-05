From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Aug 2013 22:33:27 +0200
Subject: [PATCH 2/2] ARM: sun5i: dt: Use the A10s gates in the DTSI
In-Reply-To: <51FBC4CE.8090009@elopez.com.ar>
References: <1374618504-19391-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618504-19391-3-git-send-email-maxime.ripard@free-electrons.com>
 <51FBC4CE.8090009@elopez.com.ar>
Message-ID: <20130805203327.GY2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Fri, Aug 02, 2013 at 11:40:14AM -0300, Emilio L?pez wrote:
> El 23/07/13 19:28, Maxime Ripard escribi?:
> > The A10s has only a subset of the A10 gates. Now that the clock driver
> > has support for this gates set, switch to it in the DTSI.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> As I mentioned on the other patch, my board boots, so
> 
> Tested-by: Emilio L?pez <emilio@elopez.com.ar>

Thanks.

> > ---
> >  arch/arm/boot/dts/sun5i-a10s.dtsi | 36 ++++++++++++++----------------------
> >  1 file changed, 14 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> > index 0f0881a..b8fc1c2 100644
> > --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> > +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> > @@ -95,20 +95,16 @@
> >  
> >  		ahb_gates: ahb_gates at 01c20060 {
> >  			#clock-cells = <1>;
> > -			compatible = "allwinner,sun4i-ahb-gates-clk";
> > +			compatible = "allwinner,sun5i-a10s-ahb-gates-clk";
> >  			reg = <0x01c20060 0x8>;
> >  			clocks = <&ahb>;
> > -			clock-output-names = "ahb_usb0", "ahb_ehci0",
> > -				"ahb_ohci0", "ahb_ehci1", "ahb_ohci1", "ahb_ss",
> > -				"ahb_dma", "ahb_bist", "ahb_mmc0", "ahb_mmc1",
> > -				"ahb_mmc2", "ahb_mmc3", "ahb_ms", "ahb_nand",
> > -				"ahb_sdram", "ahb_ace",	"ahb_emac", "ahb_ts",
> > -				"ahb_spi0", "ahb_spi1", "ahb_spi2", "ahb_spi3",
> > -				"ahb_pata", "ahb_sata", "ahb_gps", "ahb_ve",
> > -				"ahb_tvd", "ahb_tve0", "ahb_tve1", "ahb_lcd0",
> > -				"ahb_lcd1", "ahb_csi0", "ahb_csi1", "ahb_hdmi",
> > -				"ahb_de_be0", "ahb_de_be1", "ahb_de_fe0",
> > -				"ahb_de_fe1", "ahb_mp", "ahb_mali400";
> > +			clock-output-names = "ahb_usbotg", "ahb_ehci", "ahb_ohci",
> > +				"ahb_ss", "ahb_dma", "ahb_bist", "ahb_mmc0",
> > +				"ahb_mmc1", "ahb_mmc2",
> 
> I noticed the vendor code also has "ahb_ms" here, it might be worth
> keeping it in mind.

What is this clock used for?

I couldn't find an IP in the user manual that could fit this MS
abbreviation.

> 
> > "ahb_nand", "ahb_sdram",
> > +				"ahb_emac", "ahb_ts", "ahb_spi0", "ahb_spi1",
> > +				"ahb_spi2", "ahb_gps", "ahb_stimer", "ahb_ve",
> > +				"ahb_tve", "ahb_lcd", "ahb_csi", "ahb_hdmi",
> > +				"ahb_de_be", "ahb_de_fe", "ahb_iep", "ahb_mali400";
> >  		};
> >  
> >  		apb0: apb0 at 01c20054 {
> > @@ -120,12 +116,11 @@
> >  
> >  		apb0_gates: apb0_gates at 01c20068 {
> >  			#clock-cells = <1>;
> > -			compatible = "allwinner,sun4i-apb0-gates-clk";
> > +			compatible = "allwinner,sun5i-a10s-apb0-gates-clk";
> >  			reg = <0x01c20068 0x4>;
> >  			clocks = <&apb0>;
> > -			clock-output-names = "apb0_codec", "apb0_spdif",
> > -				"apb0_ac97", "apb0_iis", "apb0_pio", "apb0_ir0",
> > -				"apb0_ir1", "apb0_keypad";
> > +			clock-output-names = "apb0_codec", "apb0_iis", "apb0_pio",
> > +				"apb0_ir", "apb0_keypad";
> >  		};
> >  
> >  		/* dummy is pll62 */
> > @@ -145,15 +140,12 @@
> >  
> >  		apb1_gates: apb1_gates at 01c2006c {
> >  			#clock-cells = <1>;
> > -			compatible = "allwinner,sun4i-apb1-gates-clk";
> > +			compatible = "allwinner,sun5i-a10s-apb1-gates-clk";
> >  			reg = <0x01c2006c 0x4>;
> >  			clocks = <&apb1>;
> >  			clock-output-names = "apb1_i2c0", "apb1_i2c1",
> > -				"apb1_i2c2", "apb1_can", "apb1_scr",
> > -				"apb1_ps20", "apb1_ps21", "apb1_uart0",
> > -				"apb1_uart1", "apb1_uart2", "apb1_uart3",
> > -				"apb1_uart4", "apb1_uart5", "apb1_uart6",
> > -				"apb1_uart7";
> > +				"apb1_i2c2", "apb1_uart0", "apb1_uart1",
> > +				"apb1_uart2", "apb1_uart3";
> >  		};
> >  	};
> >  
> > 
> 
> An update to the documentation mentioning these compatibles[1] and
> gates[2] would be great :)
> 
> [1] Documentation/devicetree/bindings/clock/sunxi.txt
> [2] Documentation/devicetree/bindings/clock/sunxi/sun5i-a10s-gates.txt

Ah, right.

I'll send a v2 with the documentation. And I'll do the same for the A31
clock patches that also lacked this part.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/5c0cc4e4/attachment.sig>
