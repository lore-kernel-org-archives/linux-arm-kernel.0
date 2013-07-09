From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Jul 2013 11:27:33 +0800
Subject: [PATCH] ARM: dts: i.MX51: Add WEIM node
In-Reply-To: <1373257783.211316847@f137.mail.ru>
References: <1373094142-24173-1-git-send-email-shc_work@mail.ru>
 <20130708023304.GA22636@S2101-09.ap.freescale.net>
 <1373257783.211316847@f137.mail.ru>
Message-ID: <20130709032731.GA16656@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 08:29:43AM +0400, Alexander Shiyan wrote:
> > > @@ -745,6 +745,23 @@
> > >  				status = "disabled";
> > >  			};
> > >  
> > > +			weim: weim at 83fda000 {
> > > +				#address-cells = <2>;
> > > +				#size-cells = <1>;
> > > +				compatible = "fsl,imx51-weim";
> > > +				reg = <0x83fda000 0x1000>;
> > > +				clocks = <&clks 0>;
> > 
> > Is it correct?  I think there should be a physical clock for weim.
> 
> Yes, but properly clock for weim is missing in the clk subsystem,
> so I think at this point it is OK. Adding a properly clock should be a separate patch.

I've seen emi_slow and emi_fast clocks implemented in clk-imx51-imx53.c.
Neither is the clock for weim?

Shawn
