From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Jul 2014 16:14:43 +0200
Subject: [PATCH 1/2] Added dts defintion for Lenovo ix4-300d nas
In-Reply-To: <20140723134534.GF23220@titan.lakedaemon.net>
References: <1406117232-5962-1-git-send-email-yahoo@perenite.com>
 <20140723134534.GF23220@titan.lakedaemon.net>
Message-ID: <20140723141443.GC2856@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

> 
> > +			};
> > +
> > +			serial at 12000 {
> > +				clocks = <&coreclk 0>;

I don't think you need the clocks property. It should be already set
in armada-xp.dtsi.

> > +				adt7473 at 2e {
> > +					compatible = "adt7473";

Please include a vendor prefix here. 


> > +					reg = <0x2e>;
> > +				};
> > +
> > +				pcf8563 at 51 {
> > +					compatible = "pcf8563";

and a vendor prefix here.

> > +	/* warning: you need both eth1 & 0 to be initialize for poweroff to shutdown otherwise it reboots */

What do you mean by initialized? Driver loaded? Interface up? 

> This is a great first version

I agree with Jason, well done.

  Andrew
