From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 17 Aug 2011 12:43:55 +0100
Subject: [RFC PATCH v2 06/13] docs/dt: Document nvidia,tegra20-pinmux
	binding
In-Reply-To: <201108171337.26166.arnd@arndb.de>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<201108161551.31389.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04AEA2537D@HQMAIL01.nvidia.com>
	<201108171337.26166.arnd@arndb.de>
Message-ID: <20110817114355.GC2909@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Aug 17, 2011 at 01:37:25PM +0200, Arnd Bergmann wrote:
> The split I had in mind is more to the effect that the .dtsi file
> describes the set of pins that is there with their names and addresses,
> while the board specific file describes how they are set up. Does that
> make sense? I think I'm still missing some essential aspect of what the
> pinmux code actually does ;-)
> 
> I now saw that you have the full description in the
> arch/arm/mach-tegra/pinmux-t2-tables.c and arch/arm/mach-tegra/pinmux.c
> files, with all the names again, and apparently your patch set leaves
> these around. Do you think it's possible to actually move the static
> tables from there into the device tree and do the entire setup based
> on that?

The platform I'm working on has a different method of muxing for almost 
every pin (some aren't even memory mapped registers) so defining the SoC 
pin definitions in the DTS could result in some pretty horrible 
bindings.

Stephens bindings for configuring the muxing of the pins works quite 
nicely for our platform though, and I'm just about to post patches that 
abstract the tegra specific bits out.

Jamie
