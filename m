From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 12 Oct 2013 17:26:42 +0200
Subject: [PATCHv2 1/9] ARM: kirkwood: convert d2net_v2 to DT
In-Reply-To: <20130802143139.GZ9916@kw.sim.vm.gnt>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130802143139.GZ9916@kw.sim.vm.gnt>
Message-ID: <20131012172642.0a507069@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Guinot,

I'm resuming work on this platform on other Kirkwood boards, so it's
time to finally answer this e-mail.

On Fri, 2 Aug 2013 16:31:39 +0200, Simon Guinot wrote:

> Thanks for this patch. I have tested on by d2net_v2 board and it is
> almost good. Please, see below for my comments.

Thanks for testing!

> > +	memory {
> > +		device_type = "memory";
> > +		/* TODO: verify memory installed on board */
> > +		reg = <0x00000000 0x20000000>;
> 
> The board only provides 256MB of memory (0x100000000).

Will fix.

> > +			pmx_leds: pmx-leds {
> > +				marvell,pins = "mpp12";
> > +				marvell,function = "gpo";
> 
> "gpo" is not valid for the 6281 SoC. You could use "gpio" instead.

Will fix.


> > +		fail {
> > +			label = "d2net_v2:red:fail";
> > +			gpios = <&gpio0 12 0>;
> > +			default-state = "on";
> 
> "keep" is a better default-state. Else, blue and red are melted for the
> front LED.

Ok, will change.

> > +		sata0_power: regulator at 1 {
> > +			compatible = "regulator-fixed";
> > +			reg = <1>;
> > +			regulator-name = "SATA0 Power";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			enable-active-high;
> > +			regulator-always-on;
> > +			regulator-boot-on;
> > +			gpio = <&gpio0 16 0>;
> 
> I don't know the regulator API at all. But is that possible to allow a
> user to enable/disable the SATA0 power ? If yes, then it should be great
> to have the appropriate setting.

The regulator subsystem has a userspace interface in sysfs. See
Documentation/ABI/testing/sysfs-class-regulator. I don't think there's
anything special needed in the DT to get the regulator exposed in sysfs.

> > -config MACH_D2NET_V2
> > -	bool "LaCie d2 Network v2 NAS Board"
> > -	select KIRKWOOD_LEGACY
> > -	help
> > -	  Say 'Y' here if you want your kernel to support the
> > -	  LaCie d2 Network v2 NAS.
> 
> Before removing this option, we need to fix the Kconfig dependencies for
> the LED driver leds-ns2. I will send a patch to do that.

Your patch has been taken and is part of 3.12-rc, so this part is fixed.

I'll resend soon an updated version with the changes.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
