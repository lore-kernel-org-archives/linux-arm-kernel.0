From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 7 Dec 2014 16:14:59 +0100
Subject: [PATCH 02/10] ARM: dts: sun9i: Add mmc module clock nodes for A80
In-Reply-To: <CAGb2v64S7Wa5La5gS3yR2uvhc+y5szrUvapMK=cCZvHHRAPT0g@mail.gmail.com>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-3-git-send-email-wens@csie.org>
 <20141206172449.GC12434@lukather>
 <CAGb2v64S7Wa5La5gS3yR2uvhc+y5szrUvapMK=cCZvHHRAPT0g@mail.gmail.com>
Message-ID: <20141207151459.GI12434@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 07, 2014 at 09:11:17AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sun, Dec 7, 2014 at 1:24 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Wed, Dec 03, 2014 at 02:35:57PM +0800, Chen-Yu Tsai wrote:
> >> The mmc module clocks are A80 specific module 0 (storage) type clocks.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> >> ---
> >>  arch/arm/boot/dts/sun9i-a80.dtsi | 32 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 32 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> >> index 494714f..33d18dc 100644
> >> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> >> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> >> @@ -215,6 +215,38 @@
> >>                       clock-output-names = "cci400";
> >>               };
> >>
> >> +             mmc0_clk: clk at 06000410 {
> >> +                     #clock-cells = <0>;
> >> +                     compatible = "allwinner,sun9i-a80-mod0-clk";
> >> +                     reg = <0x06000410 0x4>;
> >> +                     clocks = <&osc24M>, <&pll4>;
> >> +                     clock-output-names = "mmc0";
> >> +             };
> >> +
> >> +             mmc1_clk: clk at 06000414 {
> >> +                     #clock-cells = <0>;
> >> +                     compatible = "allwinner,sun9i-a80-mod0-clk";
> >> +                     reg = <0x06000414 0x4>;
> >> +                     clocks = <&osc24M>, <&pll4>;
> >> +                     clock-output-names = "mmc1";
> >> +             };
> >> +
> >> +             mmc2_clk: clk at 06000418 {
> >> +                     #clock-cells = <0>;
> >> +                     compatible = "allwinner,sun9i-a80-mod0-clk";
> >> +                     reg = <0x06000418 0x4>;
> >> +                     clocks = <&osc24M>, <&pll4>;
> >> +                     clock-output-names = "mmc2";
> >> +             };
> >> +
> >> +             mmc3_clk: clk at 0600041c {
> >> +                     #clock-cells = <0>;
> >> +                     compatible = "allwinner,sun9i-a80-mod0-clk";
> >> +                     reg = <0x0600041c 0x4>;
> >> +                     clocks = <&osc24M>, <&pll4>;
> >> +                     clock-output-names = "mmc3";
> >> +             };
> >> +
> >
> > How is the phase stuff supposed to work? Is this still used on the A80?
> 
> It is. This time, the register bits are actually documented.

Ok, cool.

Depending on when the patches are coming in, that might conflict with
the last bits of the MMC clocks rework I'm about to send.

> > Also, wasn't the mux supposed to have 4 bits (so something like at
> > least 9 parent clocks?) given your previous patch?
> 
> The mux has 4 bits of valid settings. But only the first 2 have
> valid parent clocks. I suppose I should make it clear in the bindings?

Not really, this is an implementation detail, it shouldn't leak in the
DT. What you have is fine.

> Some of the other module clocks have parents on the first 2 and last
> 2 valid settings, so we'll need to use a mux table for them.

Ok.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141207/c4f67af3/attachment-0001.sig>
