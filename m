From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 23 Aug 2011 16:35:52 -0700
Subject: [RFC PATCH v2 11/13] arm/tegra: Add device tree support to
	pinmux driver
In-Reply-To: <20110816034509.GG8044@S2100-06.ap.freescale.net>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<1313440100-17131-12-git-send-email-swarren@nvidia.com>
	<20110816034509.GG8044@S2100-06.ap.freescale.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A3A38@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote at Monday, August 15, 2011 9:45 PM:
> On Mon, Aug 15, 2011 at 02:28:18PM -0600, Stephen Warren wrote:
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> >  arch/arm/mach-tegra/pinmux.c |  249 ++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 249 insertions(+), 0 deletions(-)
> >
> Same question here, since we are moving over to device tree anyway,
> is it necessarily to keep these "#ifdef CONFIG_OF" all over the files?
> Can we manage to get rid of them, since we have a suite of empty OF API
> created for this?

Yes, the ifdefs can all be eliminated. I'll need to add a couple other
empty functions to <linux/of.h>. I also folded the foo_probe_dt()
functions into foo_probe(), since the need for the ifdefs is gone.

-- 
nvpublic
