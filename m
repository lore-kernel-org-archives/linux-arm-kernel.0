From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 17 Jan 2013 15:31:01 -0700
Subject: [PATCH] ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC
 active
In-Reply-To: <alpine.DEB.2.00.1301171919420.14118@utopia.booyaka.com>
References: <alpine.DEB.2.00.1212301828590.8175@utopia.booyaka.com>
 <alpine.DEB.2.00.1301081916190.18536@utopia.booyaka.com>
 <20130108204347.GC1876@animalcreek.com>
 <alpine.DEB.2.00.1301171919420.14118@utopia.booyaka.com>
Message-ID: <20130117223101.GB32446@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 07:21:42PM +0000, Paul Walmsley wrote:
> Hi Mark
> 
> On Tue, 8 Jan 2013, Mark A. Greer wrote:
> 
> > Sorry to nag but I think the comment needs to be updated to remove the
> > sentence about the missing EMAC hwmod.
> 
> You are absolutely right, and the correction is very much appreciated.  
> Updated patch follows.
> 
> 
> - Paul
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Sun, 30 Dec 2012 10:36:36 -0700
> Subject: [PATCH] ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC active
> 
> According to Mark Greer, on OMAP AM3517/3505 chips, the EMAC is unable
> to wake the ARM up from WFI:
> 
>     http://www.spinics.net/lists/arm-kernel/msg174734.html
> 
> Further troubleshooting was unable to narrow the problem down.  So we
> don't have much choice other than to block WFI when the EMAC is active
> with the HWMOD_BLOCK_WFI flag.
> 
> Based on Mark's original patch.  We're removing the omap_device-based
> pm_lats code, so a different approach was needed.
> 
> This third version contains some corrections thanks to Mark's review.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> ---

FWIW,

Acked-by: Mark A. Greer <mgreer@animalcreek.com>
