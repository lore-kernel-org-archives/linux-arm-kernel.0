From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 26 Jul 2012 13:20:44 +0200
Subject: [PATCH v2 4/4] fbdev: sh_mobile_lcdc: use dma_mmap_coherent if
 available
In-Reply-To: <1343301191-26001-5-git-send-email-hdk@igel.co.jp>
References: <1343301191-26001-1-git-send-email-hdk@igel.co.jp>
 <1343301191-26001-5-git-send-email-hdk@igel.co.jp>
Message-ID: <1820152.JumtPU1V17@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eiraku-san,

On Thursday 26 July 2012 20:13:11 Hideki EIRAKU wrote:
> fb_mmap() implemented in fbmem.c uses smem_start as the physical
> address of the frame buffer.  In the sh_mobile_lcdc driver, the
> smem_start is a dma_addr_t that is not a physical address when IOMMU is
> enabled.  dma_mmap_coherent() maps the address correctly.  It is
> available on ARM platforms.
> 
> Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
