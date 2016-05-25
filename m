From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 May 2016 14:33:04 +0200
Subject: [PATCH 14/20] ARM: sun5i: a13: Add LCD pins
In-Reply-To: <CAGb2v66g_xZEyOf8ky_TKpT70D_EQwirVKNMQbubT5U2cD8rnw@mail.gmail.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-15-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66g_xZEyOf8ky_TKpT70D_EQwirVKNMQbubT5U2cD8rnw@mail.gmail.com>
Message-ID: <20160525123304.GD9232@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 01:13:01AM +0800, Chen-Yu Tsai wrote:
> >  arch/arm/boot/dts/sun5i-a13.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> > index 263d46dbc7e6..79b5d513c142 100644
> > --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> > +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> > @@ -237,6 +237,16 @@
> >  &pio {
> >         compatible = "allwinner,sun5i-a13-pinctrl";
> >
> > +       lcd_rgb666_pins: lcd_rgb666 at 0 {
> > +               allwinner,pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
> > +                                "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
> > +                                "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
> > +                                "PD24", "PD25", "PD26", "PD27";
> > +               allwinner,function = "lcd0";
> > +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> 
> Just a thought: would we ever need to increase the drive strength for very high
> resolutions?

I don't think we need to, but we can always change that later.

Applied, thanks!
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160525/48adf3f9/attachment-0001.sig>
