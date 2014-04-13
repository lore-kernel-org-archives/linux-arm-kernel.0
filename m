From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 13 Apr 2014 12:33:31 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwMi8xMF0gQVJNOiBkdHM6IGlteDUxLWJhYmJhZ2U6IFVz?=
 =?UTF-8?B?ZSBzZXBhcmF0ZSBwaW5ncm91cCBmb3IgZml4ZWQtY2xvY2s=?=
In-Reply-To: <20140413081806.GH24180@dragon>
References: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
 <1397366353-29395-2-git-send-email-shc_work@mail.ru>
 <20140413081806.GH24180@dragon>
Message-ID: <1397378011.695010899@f215.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sun, 13 Apr 2014 16:18:07 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> On Sun, Apr 13, 2014 at 09:19:05AM +0400, Alexander Shiyan wrote:
> > This patch moves GPIOs definitions for "fixed-clock" into a separate
> > pingroup.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/boot/dts/imx51-babbage.dts | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> > index eddb62d..651a8c8 100644
> > --- a/arch/arm/boot/dts/imx51-babbage.dts
> > +++ b/arch/arm/boot/dts/imx51-babbage.dts
> > @@ -125,6 +125,8 @@
> >  
> >  		clk_26M: codec_clock {
> >  			compatible = "fixed-clock";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&pinctrl_clkcodec>;
> 
> Are you sure that pinctrl-* settings work for a fixed-clock?  My
> impression is that it only works for the device that Linux creates
> struct device and probes for.

Hmm, you are right.
In this case, it would be logical to move the pinctrl definition for this GPIO
to the codec node.

---
