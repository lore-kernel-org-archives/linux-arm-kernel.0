From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 13:48:49 +0000
Subject: [PATCH 2/2] ASoC: sgtl5000: clean up sgtl5000_enable_regulators()
In-Reply-To: <20131217131612.GO6691@S2101-09.ap.freescale.net>
References: <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
 <20131217015939.GM3185@sirena.org.uk>
 <20131217021610.GA7172@S2101-09.ap.freescale.net>
 <20131217113705.GP3185@sirena.org.uk>
 <20131217123946.GN6691@S2101-09.ap.freescale.net>
 <20131217124657.GW3185@sirena.org.uk>
 <20131217131612.GO6691@S2101-09.ap.freescale.net>
Message-ID: <20131217134849.GD3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 09:16:15PM +0800, Shawn Guo wrote:
> On Tue, Dec 17, 2013 at 12:46:57PM +0000, Mark Brown wrote:

> > It tells the core that it now knows about all regulator mappings so it
> > knows if it's not got a mapping none will ever appear.

> Okay, it sounds like what we need.  But I searched all the occurrences
> of have_full_constraints() in core.c, and haven't found how it
> influences the regulator_map_list searching.  I'm looking at function
> regulator_dev_lookup().  Can you point me the correct place of the code?

For platform data it can't influence the map searching since we rely on
the driver registering outbound supplies, all it does is change if we
defer or error.  Though the erroring code seems to have gone AWOL at
some point and it'd never have been robust for modular drivers anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/9fe1bf2a/attachment.sig>
