From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 Jul 2012 08:36:45 +0200
Subject: [PATCH 15/16] ARM: Kirkwood: Describe iConnect LEDs in DT.
In-Reply-To: <5016FE26.8090509@baker-net.org.uk>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-16-git-send-email-andrew@lunn.ch>
 <5016FE26.8090509@baker-net.org.uk>
Message-ID: <20120731063645.GO18016@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 10:35:34PM +0100, Adam Baker wrote:
> On 20/07/12 18:35, Andrew Lunn wrote:
> 
> Sorry it's taken a while to spot this but I've got one comment below
> 
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >---
> >  arch/arm/boot/dts/kirkwood-iconnect.dts |   34 +++++++++++++++++++++++
> >  arch/arm/mach-kirkwood/board-iconnect.c |   46 -------------------------------
> >  2 files changed, 34 insertions(+), 46 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
> >index a7dd07b..b77b38f 100644
> >--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
> >+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
> >@@ -31,4 +31,38 @@
> >  			status = "ok";
> >  		};
> >  	};
> >+	gpio-leds {
> >+		compatible = "gpio-leds";
> >+
> >+		led-level {
> >+			label = "led_level";
> >+			gpios = <&gpio1 9 0>;
> >+			linux,default-trigger = "default-on";
> >+		};
> >+		power-blue {
> >+			label = "power:blue";
> >+			gpios = <&gpio1 11 0>;
> >+			linux,default-trigger = "timer";
> >+		};
> 
> Is there any reason that power:red is missing here?

The monkey driving the keyboard is not reliable at monkey work...

Please create a patch and i will try to get it into rc1.

       Thanks
  	 Andrew
