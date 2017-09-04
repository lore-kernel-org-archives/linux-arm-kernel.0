From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Sep 2017 13:40:59 +0200
Subject: [linux-sunxi][PATCH] ARM: dts: sunxi: h3/h5 :Add DAI nodes
In-Reply-To: <CAEKpxB=MF-8BPS_Jc=qgj9sTCfn9EKWxdtJQD4goRGSv0xnHMw@mail.gmail.com>
References: <20170903150806.3451-1-codekipper@gmail.com>
 <2581170.20QKPVRcId@jernej-laptop>
 <CAEKpxB=MF-8BPS_Jc=qgj9sTCfn9EKWxdtJQD4goRGSv0xnHMw@mail.gmail.com>
Message-ID: <20170904114059.cqvs4kh4esrzfxo5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 12:51:38PM +0200, Code Kipper wrote:
> On 3 September 2017 at 18:35, Jernej ?krabec <jernej.skrabec@siol.net> wrote:
> > Hi Marcus!
> >
> > Dne nedelja, 03. september 2017 ob 17:08:06 CEST je codekipper at gmail.com
> > napisal(a):
> >> From: Marcus Cooper <codekipper@gmail.com>
> >>
> >> Add the new DAI blocks to the device tree. I2S0 and I2S1 are for
> >> connecting to an external codec whereas I2S2 is used for HDMI
> >> audio.
> >>
> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >> ---
> >>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 39
> >> ++++++++++++++++++++++++++++++++++++++ 1 file changed, 39 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> >> b/arch/arm/boot/dts/sunxi-h3-h5.dtsi index 11240a8313c2..cf6fcc857324
> >> 100644
> >> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> >> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> >> @@ -450,6 +450,45 @@
> >>                       status = "disabled";
> >>               };
> >>
> >> +             i2s0: i2s at 01c22000 {
> >> +                     #sound-dai-cells = <0>;
> >> +                     compatible = "allwinner,sun8i-h3-i2s";
> >> +                     reg = <0x01c22000 0x400>;
> >> +                     interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> >> +                     clocks = <&ccu CLK_BUS_I2S0>, <&ccu CLK_I2S0>;
> >> +                     clock-names = "apb", "mod";
> >> +                     dmas = <&dma 3>, <&dma 3>;
> >> +                     resets = <&ccu RST_BUS_I2S0>;
> >> +                     dma-names = "rx", "tx";
> >> +                     status = "disabled";
> >> +             };
> >> +
> >> +             i2s1: i2s at 01c22400 {
> >> +                     #sound-dai-cells = <0>;
> >> +                     compatible = "allwinner,sun8i-h3-i2s";
> >> +                     reg = <0x01c22400 0x400>;
> >> +                     interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> >> +                     clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
> >> +                     clock-names = "apb", "mod";
> >> +                     dmas = <&dma 4>, <&dma 4>;
> >> +                     resets = <&ccu RST_BUS_I2S1>;
> >> +                     dma-names = "rx", "tx";
> >> +                     status = "disabled";
> >> +             };
> >> +
> >> +             i2s2: i2s at 01c22800 {
> >> +                     #sound-dai-cells = <0>;
> >> +                     compatible = "allwinner,sun8i-h3-i2s";
> >> +                     reg = <0x01c22800 0x400>;
> >> +                     interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> >> +                     clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
> >> +                     clock-names = "apb", "mod";
> >> +                     dmas = <&dma 5>, <&dma 5>;
> >> +                     resets = <&ccu RST_BUS_I2S2>;
> >> +                     dma-names = "rx", "tx";
> >> +                     status = "disabled";
> >> +             };
> >> +
> >
> > I don't want to be a pain, but shouldn't we skip this one for now? It is only
> > for HDMI and has different capabilities (8 channels supported and slighlty
> > different formula to calculate oversample rate.
> I'll have a look into this..maybe this can be handled by the
> simple-audio-card binding that we use. The other thing with the
> padding which you mentioned I can add a field for. Maxime, what's your
> thoughts on this?..I can re-submit without i2s2.

Yes, please do so.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/de4520fc/attachment.sig>
