From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 08 Jul 2013 08:29:43 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSF0gQVJNOiBkdHM6IGkuTVg1MTogQWRkIFdFSU0gbm9k?=
 =?UTF-8?B?ZQ==?=
In-Reply-To: <20130708023304.GA22636@S2101-09.ap.freescale.net>
References: <1373094142-24173-1-git-send-email-shc_work@mail.ru>
 <20130708023304.GA22636@S2101-09.ap.freescale.net>
Message-ID: <1373257783.211316847@f137.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Jul 06, 2013 at 11:02:22AM +0400, Alexander Shiyan wrote:
> > This patch adds the missing (Wireless External Interface Module) WEIM
> > devicetree node for i.MX51 CPUs.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> > index 0ca62be..e71976e4 100644
> > --- a/arch/arm/boot/dts/imx51.dtsi
> > +++ b/arch/arm/boot/dts/imx51.dtsi
> > @@ -745,6 +745,23 @@
> >  				status = "disabled";
> >  			};
> >  
> > +			weim: weim at 83fda000 {
> > +				#address-cells = <2>;
> > +				#size-cells = <1>;
> > +				compatible = "fsl,imx51-weim";
> > +				reg = <0x83fda000 0x1000>;
> > +				clocks = <&clks 0>;
> 
> Is it correct?  I think there should be a physical clock for weim.

Yes, but properly clock for weim is missing in the clk subsystem,
so I think at this point it is OK. Adding a properly clock should be a separate patch.
Thanks.

---
