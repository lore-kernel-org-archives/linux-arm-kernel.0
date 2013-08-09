From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 9 Aug 2013 16:05:42 +0800
Subject: [PATCH 1/1] ARM: dtsi: imx6qdl-sabresd: Add USB host 1 VBUS
 regulator
In-Reply-To: <CAOMZO5AXprz7MsxmyWB_nH8pc0GX3sbcZUtDqEVkf0W9myBbxA@mail.gmail.com>
References: <1376007824-16325-1-git-send-email-peter.chen@freescale.com>
 <CAOMZO5AXprz7MsxmyWB_nH8pc0GX3sbcZUtDqEVkf0W9myBbxA@mail.gmail.com>
Message-ID: <20130809080540.GA23876@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 11:22:43PM -0300, Fabio Estevam wrote:
> On Thu, Aug 8, 2013 at 9:23 PM, Peter Chen <peter.chen@freescale.com> wrote:
> > We enabled USB host 1, so host 1's vbus should be on to let
> > host 1 work.
> >
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > index 6e5dfdb..6e9d4d7 100644
> > --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > @@ -27,6 +27,15 @@
> >                         enable-active-high;
> >                 };
> >
> > +               reg_usb_h1_vbus: usb_h1_vbus {
> > +                       compatible = "regulator-fixed";
> > +                       regulator-name = "usb_h1_vbus";
> > +                       regulator-min-microvolt = <5000000>;
> > +                       regulator-max-microvolt = <5000000>;
> > +                       gpio = <&gpio1 29 0>;
> 
> You should also add en entry into pinctrl_hog for this gpio.
> 

Thanks, Fabio. What's the rule for adding gpio function for pinctrl
at dts? At pinctrl_hog or the device's pinctrl group?

-- 

Best Regards,
Peter Chen
