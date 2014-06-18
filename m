From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Jun 2014 18:23:27 -0500
Subject: [PATCH v2 2/2] arm: dts: add support for AM437x StarterKit
In-Reply-To: <20140618231923.GA9855@saruman.home>
References: <1403106200-777-1-git-send-email-balbi@ti.com>
 <1403106200-777-3-git-send-email-balbi@ti.com>
 <53A1BADD.7050309@ti.com> <20140618193113.GC4570@saruman.home>
 <53A20A7D.3060508@ti.com> <20140618231923.GA9855@saruman.home>
Message-ID: <20140618232327.GC9855@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(side note)

On Wed, Jun 18, 2014 at 06:19:23PM -0500, Felipe Balbi wrote:
> > >>>+		interrupt-controller;
> > >>>+		#interrupt-cells = <2>;
> > >>>+
> > >>>+		dcdc1: regulator-dcdc1 {
> > >>>+			compatible = "ti,tps65218-dcdc1";
> > >>>+			/* VDD_CORE limits min of OPP50 and max of OPP100 */
> > >>>+			regulator-name = "vdd_core";
> > >>>+			regulator-min-microvolt = <912000>;
> > >>>+			regulator-max-microvolt = <1144000>;
> > >>>+			regulator-boot-on;
> > >>>+			regulator-always-on;
> > >>>+		};
> > >>>+
> > >>>+		dcdc2: regulator-dcdc2 {
> > >>>+			compatible = "ti,tps65218-dcdc2";
> > >>>+			/* VDD_MPU limits min of OPP50 and max of OPP_NITRO */
> > >>>+			regulator-name = "vdd_mpu";
> > >>>+			regulator-min-microvolt = <912000>;
> > >>>+			regulator-max-microvolt = <1378000>;
> > >>>+			regulator-boot-on;
> > >>>+			regulator-always-on;
> > >>>+		};
> > >>>+
> > >>>+		dcdc3: regulator-dcdc3 {
> > >>>+			compatible = "ti,tps65218-dcdc3";
> > >>>+			regulator-name = "vdds_ddr";
> > >>no voltage ?
> > >
> > >has no users in kernel. Also, it comes out with default, and correct,
> > >voltage.
> > 
> > Device tree is description of hardware, not just who uses what in OS
> > of interest.
> 
> then we should start "fixing" every single DTS in the kernel because I'm
> sure even LEDs and keypads are tied to some sort of supply, as is the
> case with this board. No driver will use it though.
> 
> Also, I couldn't find anywhere which voltage is dcdc3 outputing and
> there's no shunt anywhere (other than a 0 ohm resistor) to measure
> voltage. So I kinda have my hands tied here.
> 
> (goes review schematics)
> 
> actually there's 0.05 ohm sense resistor. Hopefully it's easy to access.

1.35v

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/de3bf90a/attachment.sig>
