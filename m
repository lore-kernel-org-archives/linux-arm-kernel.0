From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 21 Jun 2014 15:28:46 -0400
Subject: [PATCHv4 2/4] ARM: Kirkwood: Add DT descriptions for net2big
 and net5big.
In-Reply-To: <20140621095001.GW20207@kw.sim.vm.gnt>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
 <1401132591-26305-3-git-send-email-andrew@lunn.ch>
 <20140620233718.GV20207@kw.sim.vm.gnt>
 <20140621095001.GW20207@kw.sim.vm.gnt>
Message-ID: <20140621192846.GG21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 11:50:02AM +0200, Simon Guinot wrote:
> On Sat, Jun 21, 2014 at 01:37:18AM +0200, Simon Guinot wrote:
> > On Mon, May 26, 2014 at 09:29:49PM +0200, Andrew Lunn wrote:
...
> > > +&regulators {
> > > +	regulator at 3 {
> > > +		compatible = "regulator-fixed";
> > > +		reg = <3>;
> > > +		regulator-name = "hdd2power";
> > > +		regulator-min-microvolt = <5000000>;
> > > +		regulator-max-microvolt = <5000000>;
> > > +		enable-active-high;
> > > +		regulator-always-on;
> > > +		regulator-boot-on;
> > > +		gpio = <&gpio0 19 GPIO_ACTIVE_HIGH>;
> > 
> > 19 must be replaced with 9.
> 
> And gpio0 must replaced with gpio1.
> 
> > 
> > > +	};
> > > +
> > > +	regulator at 4 {
> > > +		compatible = "regulator-fixed";
> > > +		reg = <4>;
> > > +		regulator-name = "hdd3power";
> > > +		regulator-min-microvolt = <5000000>;
> > > +		regulator-max-microvolt = <5000000>;
> > > +		enable-active-high;
> > > +		regulator-always-on;
> > > +		regulator-boot-on;
> > > +		gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>;
> > 
> > 20 must be replaced with 10.
> 
> Here too.
> 
> > 
> > > +	};
> > > +
> > > +	regulator at 5 {
> > > +		compatible = "regulator-fixed";
> > > +		reg = <5>;
> > > +		regulator-name = "hdd4power";
> > > +		regulator-min-microvolt = <5000000>;
> > > +		regulator-max-microvolt = <5000000>;
> > > +		enable-active-high;
> > > +		regulator-always-on;
> > > +		regulator-boot-on;
> > > +		gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> > 
> > 21 must be replaced with 11.
> 
> And here too.
> 

I've pushed the following to mvebu/dt:

--------->8--------------
commit d854fa8a1500bec982ed9cb26b82d96bd5ae8dab
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Sat Jun 21 19:21:13 2014 +0000

    ARM: kirkwood: fix net5big regulator gpio assignments
    
    Late correction from Simon's testing.
    
    Reported-by: Simon Guinot <simon.guinot@sequanux.org>
    Link: https://lkml.kernel.org/r/20140621095001.GW20207 at kw.sim.vm.gnt
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/arch/arm/boot/dts/kirkwood-net5big.dts b/arch/arm/boot/dts/kirkwood-net5big.dts
index 51c56a9490b3..d2887ed493f2 100644
--- a/arch/arm/boot/dts/kirkwood-net5big.dts
+++ b/arch/arm/boot/dts/kirkwood-net5big.dts
@@ -40,7 +40,7 @@
 		enable-active-high;
 		regulator-always-on;
 		regulator-boot-on;
-		gpio = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 	};
 
 	regulator at 4 {
@@ -52,7 +52,7 @@
 		enable-active-high;
 		regulator-always-on;
 		regulator-boot-on;
-		gpio = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 	};
 
 	regulator at 5 {
@@ -64,7 +64,7 @@
 		enable-active-high;
 		regulator-always-on;
 		regulator-boot-on;
-		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 	};
 };
 
