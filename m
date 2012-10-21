From: michael@walle.cc (Michael Walle)
Date: Sun, 21 Oct 2012 15:59:38 +0200
Subject: [PATCH 2/2] ARM: kirkwood: use gpio-fan DT binding on lsxl
In-Reply-To: <20121021065552.GH21046@lunn.ch>
References: <1350776094-16778-1-git-send-email-michael@walle.cc>
 <1350776094-16778-2-git-send-email-michael@walle.cc>
 <20121021065552.GH21046@lunn.ch>
Message-ID: <201210211559.38628.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 21 Oktober 2012, 08:55:52 schrieb Andrew Lunn:
> On Sun, Oct 21, 2012 at 01:34:54AM +0200, Michael Walle wrote:
> > Remove board specific gpio-fan driver registration. Moved into device
> > tree.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> > 
> >  arch/arm/boot/dts/kirkwood-lsxl.dtsi |   11 ++++++++
> >  arch/arm/mach-kirkwood/board-lsxl.c  |   47
> >  ---------------------------------- 2 files changed, 11 insertions(+),
> >  47 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> > b/arch/arm/boot/dts/kirkwood-lsxl.dtsi index 8fea375..798e60e 100644
> > --- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> > +++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> > @@ -94,4 +94,15 @@
> > 
> >  			gpios = <&gpio1 16 1>;
> >  		
> >  		};
> >  	
> >  	};
> > 
> > +
> > +	gpio_fan {
> > +		compatible = "gpio-fan";
> > +		gpios = <&gpio0 19 1
> > +		         &gpio0 18 1>;
> > +		gpio-fan,speed-map = <0    3
> > +		                      1500 2
> > +		                      3250 1
> > +		                      5000 0>;
> > +		alarm-gpios = <&gpio1 8 0>;
> > +	};
> > 
> >  };
> > 
> > diff --git a/arch/arm/mach-kirkwood/board-lsxl.c
> > b/arch/arm/mach-kirkwood/board-lsxl.c index 64e5cc6..7e18cad 100644
> > --- a/arch/arm/mach-kirkwood/board-lsxl.c
> > +++ b/arch/arm/mach-kirkwood/board-lsxl.c
> > @@ -16,7 +16,6 @@
> > 
> >  #include <linux/platform_device.h>
> >  #include <linux/mv643xx_eth.h>
> >  #include <linux/gpio.h>
> > 
> > -#include <linux/gpio-fan.h>
> > 
> >  #include "common.h"
> >  #include "mpp.h"
> 
> Hi Michael
> 
> You might also be able to remove platform_device.h.

Mh, pm_power_off, although defined in linux/pm.h, is somehow pulled with this 
include. So either we leave it that way (looking at other boards only a few 
has included pm.h) or i'll post a third patch which replaces that include.

-- 
Michael
