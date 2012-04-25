From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 25 Apr 2012 15:01:28 +0200
Subject: [PATCHv3 1/4] ARM: tegra: Add AHB driver
In-Reply-To: <20120425112519.GB3564@arwen.pp.htv.fi>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com><20120425112519.GB3564@arwen.pp.htv.fi>
Message-ID: <20120425.160128.1314575000242024123.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv3 1/4] ARM: tegra: Add AHB driver
Date: Wed, 25 Apr 2012 13:25:20 +0200
Message-ID: <20120425112519.GB3564@arwen.pp.htv.fi>

> * PGP Signed by an unknown key
> 
> On Wed, Apr 25, 2012 at 02:07:36PM +0300, Hiroshi DOYU wrote:
> > The AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> > High-performance Bus (AHB) architecture.
> >
> > The AHB Arbiter controls AHB bus master arbitration. This effectively
> > forms a second level of arbitration for access to the memory
> > controller through the AHB Slave Memory device. The AHB pre-fetch
> > logic can be configured to enhance performance for devices doing
> > sequential access. Each AHB master is assigned to either the high or
> > low priority bin. Both Tegra20/30 have this AHB bus.
> >
> > Some of configuration param could be passed from DT too.
> >
> > Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v4:
> > Fixed the comments from Felipe/Russell.
> > This is now located under drivers/platform/arm.
> > v3:
> > Use platform_device to get info from dt dynamically.(Felipe/Arnd)
> >
> > Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> 
> Just one thing, you seem to have missed Russell's comment about this
> driver being generic. You still add a TEGRA_AHB driver,

For generalization, there seems to be many parts in this driver
depending on SoC implementation, and I'm not so sure how much S/W
compatibility can be kept from H/W spec. Is there any other similar
SoC AHB driver in kernel?

> also, you don't need <mach/iomap.h>. Apart from those, you can add:

Ok, I'll fix and add your Reviewed-by:. Thank you for your review.
