From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 11 Apr 2018 19:26:56 +0300
Subject: [PATCH v2] media: omap3isp: fix unbalanced dma_iommu_mapping
In-Reply-To: <e0151287-f294-3540-9b12-a96e05db61c0@ti.com>
References: <20180314154136.16468-1-s-anna@ti.com> <5767280.aLITpzbm0N@avalon>
 <e0151287-f294-3540-9b12-a96e05db61c0@ti.com>
Message-ID: <20180411162655.gigmuzna624xcxx2@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 11:40:58AM -0500, Suman Anna wrote:
> Hi Mauro,
> 
> On 03/21/2018 05:26 AM, Laurent Pinchart wrote:
> > Hi Suman,
> > 
> > Thank you for the patch.
> > 
> > On Wednesday, 14 March 2018 17:41:36 EET Suman Anna wrote:
> >> The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
> >> ARM DMA backend. The current code creates a dma_iommu_mapping and
> >> attaches this to the ISP device, but never detaches the mapping in
> >> either the probe failure paths or the driver remove path resulting
> >> in an unbalanced mapping refcount and a memory leak. Fix this properly.
> >>
> >> Reported-by: Pavel Machek <pavel@ucw.cz>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I don't see this patch in -next yet, can you pick up this patch at your
> earliest?

Here:

<URL:https://patchwork.linuxtv.org/patch/48599/>

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
