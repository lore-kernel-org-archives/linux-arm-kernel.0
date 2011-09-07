From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Sep 2011 20:01:21 +0100
Subject: [PATCH 1/5] ARM: Samsung: PWM: Allow to differentiate SoCs
	based on platform device name.
In-Reply-To: <20110906120430.GO6619@n2100.arm.linux.org.uk>
References: <1731819.jJi37IsjvJ@flatron> <1660939.8M3FnZsmga@flatron>
	<20110906110311.GM6619@n2100.arm.linux.org.uk>
	<5725201.5LdnvaEu1n@flatron>
	<20110906120430.GO6619@n2100.arm.linux.org.uk>
Message-ID: <20110907190120.GA24703@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 01:04:30PM +0100, Russell King - ARM Linux wrote:

> Pros to platform driver name:
> 1. Can re-use existing names if feature compatible without driver mods.
> 2. Scales well with an increasing number of SoCs.

> Cons:
> 1. People will hate having SoC names which don't refer to their exact SoC.
> 2. Probably requires storage of a set of flags in driver private data
>    to identify SoC specific features.
> 3. Requires additional string space to identify each driver name.

There's also an issue with actually getting the devices together to
register which causes fragility here.

> However, thinking about this more wrt DT, there's another aspect to this.
> Rather than encoding into the driver "this SoC has features and quirks
> X,Y,Z" maybe that information should be in the device tree itself.  For
> example, SoC 1 has X and Z, SoC 2 has Y.  Then a new SoC 3 comes along
> with X and Y but not Z.  If X, Y, Z are encoded into DT then there's no
> need to touch the kernel to support SoC 3, not even to change driver
> names or soc_is_xxx macros etc.

This does depend pretty strongly on making sure that the SoC DT is
distributed separately to the board DT - that should be solved now.
