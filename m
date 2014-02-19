From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Feb 2014 13:58:29 +0800
Subject: [PATCH v3 1/4] Phytec phyFLEX-i.MX6 : Added USB_OTG Support
In-Reply-To: <20140219022307.GL15716@S2101-09.ap.freescale.net>
References: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
 <20140219022307.GL15716@S2101-09.ap.freescale.net>
Message-ID: <20140219055824.GB3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 10:23:09AM +0800, Shawn Guo wrote:
> > @@ -18,6 +18,14 @@
> >  	memory {
> >  		reg = <0x10000000 0x80000000>;
> >  	};
> > +
> > +	reg_usb_otg_vbus: regulator at 0 {
> 
> You do not have a 'reg' property in the node, so you shouldn't have
> '@num' in node name.  You may want to name it 'regulator-0'.

I just saw the talk between Stephen and Mark [1], and I'm with Stephen
that neither regulator-0 nor regulator_0 is a good name.  Since Mark is
giving up the argument on the container, please follow the way we do in
other IMX dts today.

Shawn

[1] http://thread.gmane.org/gmane.linux.drivers.devicetree/61894/focus=62405

> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb_otg_vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		gpio = <&gpio4 15 0>;
> > +	};
> >  };
