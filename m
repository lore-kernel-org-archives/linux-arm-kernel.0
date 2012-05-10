From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 10 May 2012 12:08:06 -0700
Subject: [PATCH 1/3] ARM: OMAP AM35xx: clock and hwmod data: fix AM35xx
 HSOTGUSB hwmod
In-Reply-To: <20120510172913.13418.66154.stgit@dusk>
References: <20120510172449.13418.66815.stgit@dusk>
 <20120510172913.13418.66154.stgit@dusk>
Message-ID: <20120510190806.GC20494@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 11:29:17AM -0600, Paul Walmsley wrote:
> Partially fix the hwmod data for the AM35xx USB OTG hwmod.  This
> should resolve the following boot warning on AM35xx platforms:
> 
> omap_hwmod: am35x_otg_hs: cannot be enabled for reset (3)
> 
> While here, also fix the clkdev records, to avoid warnings about
> duplicate clock aliases.
> 
> The hwmod is also connected to the wrong interconnect.  It should be
> connected to the IPSS, not the L4 CORE.  But that is left for a future
> fix, since it probably has a dependency on some hwmod core changes.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Hema HK <hemahk@ti.com>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Acked-by: Mark A. Greer <mgreer@animalcreek.com>
(on an am3517evm)
