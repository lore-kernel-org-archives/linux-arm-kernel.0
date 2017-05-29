From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 May 2017 11:26:30 +0200
Subject: [PATCH 3/3] ARM: sun8i: v3s: add backlight device node for
 Lichee Pi Zero LCD
In-Reply-To: <CAGb2v66X2mAiEVnsj_aE8RV7DdRa_Pe41E-O-GOPe-+cjiw4PA@mail.gmail.com>
References: <20170524121320.4171-1-icenowy@aosc.io>
 <20170524121320.4171-3-icenowy@aosc.io>
 <20170529074117.x7pm2k2lbznl2n5j@flea.home>
 <CAGb2v66X2mAiEVnsj_aE8RV7DdRa_Pe41E-O-GOPe-+cjiw4PA@mail.gmail.com>
Message-ID: <20170529092630.z3brclkxoiyeq4ok@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 29, 2017 at 04:16:51PM +0800, Chen-Yu Tsai wrote:
> On Mon, May 29, 2017 at 3:41 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Wed, May 24, 2017 at 08:13:20PM +0800, Icenowy Zheng wrote:
> >> The 40-pin LCD connector on Lichee Pi Zero has backlight pins, which is
> >> controlled by the PWM0 controller of the V3s SoC, and the controlling
> >> part is on the board.
> >>
> >> Add the PWM and backlight device nodes in the device tree file, but
> >> leave them disabled, as they can only be useful when the LCD is
> >> attached. The LCD device tree overlay files can enable these controllers
> >> and make use of them.
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >>  arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> >> index 387fc2aa546d..e0721bf725d1 100644
> >> --- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> >> +++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> >> @@ -52,6 +52,14 @@
> >>               serial0 = &uart0;
> >>       };
> >>
> >> +     backlight: backlight {
> >> +             compatible = "pwm-backlight";
> >> +             pwms = <&pwm 0 50000 0>;
> >> +             brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
> >
> > This is unlikely, the perceived brightness by the human eye is not
> > linear, and is actually much closer to a logarithmic function, which
> > means you should have use an exponential function here in order to
> > appear that your brightness increase is linear.
> 
> I think the backlight is a functional part of the panel. It probably
> belongs in the panel's overlay.

Yeah, that's also true.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/f4ee98e5/attachment.sig>
