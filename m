From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jun 2014 17:10:55 +0100
Subject: [Nouveau] [PATCH v2 2/3] drm/ttm: introduce dma cache sync helpers
In-Reply-To: <CAAVeFuLU04rk1DWMhVJV=ktVCpq4js38p1ipCr1jh1x72b=GZw@mail.gmail.com>
References: <1403603667-11302-1-git-send-email-acourbot@nvidia.com>
 <1403603667-11302-3-git-send-email-acourbot@nvidia.com>
 <20140624100220.GK32514@n2100.arm.linux.org.uk> <53A953E6.2030503@nvidia.com>
 <53A95910.20104@nvidia.com>
 <CAAVeFu+rbCViC87kYCLfxGV18iYq=Pa0ABb+L=iNiYPLn+mR8Q@mail.gmail.com>
 <53A96EC5.3030701@canonical.com>
 <1403616338.4230.8.camel@weser.hi.pengutronix.de>
 <CACP_E+KECMyusuZd6hpzthL-RpfUOJpWh0EABf1DGAeaXc00aA@mail.gmail.com>
 <CAAVeFuLU04rk1DWMhVJV=ktVCpq4js38p1ipCr1jh1x72b=GZw@mail.gmail.com>
Message-ID: <20140626161055.GX32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 11:53:20PM +0900, Alexandre Courbot wrote:
> We don't plan to rely on CMA for too long. IOMMU support is on the way
> and should make our life easier, although no matter the source of
> memory, we will still have the issue of the lowmem mappings.

When it comes to DMA memory, talking about lowmem vs highmem is utterly
meaningless.

The lowmem/highmem split is entirely a software concept and is completely
adjustable.  An extreme example is that you can boot any platform with
more than 32MB of memory with 32MB of lowmem and the remainder as
highmem.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
