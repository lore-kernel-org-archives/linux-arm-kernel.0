From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 02:10:10 +0300
Subject: [PATCH 12/37] ARM: dts: dove-sbc-a510: Fix regulator enable GPIO
 polarity
In-Reply-To: <20151012225009.GP13247@io.lakedaemon.net>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1444684386-17094-13-git-send-email-laurent.pinchart@ideasonboard.com>
 <20151012225009.GP13247@io.lakedaemon.net>
Message-ID: <2803928.h4I9c13V32@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Monday 12 October 2015 22:50:09 Jason Cooper wrote:
> On Tue, Oct 13, 2015 at 12:12:41AM +0300, Laurent Pinchart wrote:
> > The enable GPIO is active low, but is flagged as active high in the gpio
> > property. As the gpio property flags are currently unused by the driver
> > this doesn't cause any issue for now, but will break later if the driver
> > starts making use of the flags. Fix it.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  arch/arm/boot/dts/dove-sbc-a510.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > 
> > diff --git a/arch/arm/boot/dts/dove-sbc-a510.dts
> > b/arch/arm/boot/dts/dove-sbc-a510.dts index 288e707dea99..3bc5c96483be
> > 100644
> > --- a/arch/arm/boot/dts/dove-sbc-a510.dts
> > +++ b/arch/arm/boot/dts/dove-sbc-a510.dts
> > @@ -82,7 +82,7 @@
> >  			regulator-name = "USB Power";
> >  			regulator-min-microvolt = <5000000>;
> >  			regulator-max-microvolt = <5000000>;
> > -			gpio = <&gpio_ext 0 GPIO_ACTIVE_HIGH>;
> > +			gpio = <&gpio_ext 0 GPIO_ACTIVE_LOW>;
> 
> I'd feel a lot better about this if the commit log made a strong
> reference back to some documentation or other hardware description.
> Just because Linux doesn't use it or uses it wrong doesn't necessarily
> mean the DT is wrong.

It looks like I might be wrong, see Stephen's reply to patch 37/37. Let's 
discuss the issue there.

> >  		};
> >  		
> >  		mmc_power: regulator at 3 {
> > @@ -90,7 +90,7 @@
> >  			regulator-name = "MMC Power";
> >  			regulator-min-microvolt = <3300000>;
> >  			regulator-max-microvolt = <3300000>;
> > -			gpio = <&gpio_ext 13 GPIO_ACTIVE_HIGH>;
> > +			gpio = <&gpio_ext 13 GPIO_ACTIVE_LOW>;
> >  		};
> >  	};
> >  };

-- 
Regards,

Laurent Pinchart
