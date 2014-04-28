From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 21:56:52 +0100
Subject: [PATCH 71/97] ARM: l2c: convert tegra to generic l2c
 initialisation
In-Reply-To: <535EB900.6010506@wwwdotorg.org>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerHi-0001YW-Oi@rmk-PC.arm.linux.org.uk> <535EB900.6010506@wwwdotorg.org>
Message-ID: <20140428205652.GW26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 02:24:32PM -0600, Stephen Warren wrote:
> On 04/28/2014 01:32 PM, Russell King wrote:
> 
> > diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> 
> >  DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
> > -	.map_io		= tegra_map_common_io,
> > +	.l2c_aux_val	= 0x3c400001,
> > +	.l2c_aux_mask	= 0xc20fc3fe,
> 
> I assume those values are simply ignored for CPUs without an l2c (or
> with an architected one?) i.e. A15. If so,
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

l2x0_of_init() only does something when your DT file specifies that
there's a L2C cache controller of the appropriate type present.  So
yes, when there's no L2C cache controller mentioned, it's a no-op.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
