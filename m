From: cbz@baozis.org (Chen Baozi)
Date: Thu, 23 Apr 2015 10:33:08 +0800
Subject: [Xen-devel] [PATCH] xen: Add __GFP_DMA flag when
 xen_swiotlb_init gets free pages.
In-Reply-To: <alpine.DEB.2.02.1504211203520.3112@kaball.uk.xensource.com>
References: <1429526904-27176-1-git-send-email-cbz@baozis.org>
 <5534DABB.5060305@citrix.com> <20150420110729.GA27707@cbz-thinkpad>
 <5534EAE3.8060403@citrix.com>
 <alpine.DEB.2.02.1504201828380.30125@kaball.uk.xensource.com>
 <1429603030.6174.21.camel@citrix.com>
 <alpine.DEB.2.02.1504211115300.3112@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1504211203520.3112@kaball.uk.xensource.com>
Message-ID: <20150423023308.GB7783@cbz-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 12:11:01PM +0100, Stefano Stabellini wrote:
> Chen,
> could you please try the patch below in your repro scenario?
> I have only build tested it.
> 
> ---
> 
> xen: Add __GFP_DMA flag when xen_swiotlb_init gets free pages on ARM
> 
> From: Chen Baozi <baozich@gmail.com>
> 
> Make sure that xen_swiotlb_init allocates buffers that are DMA capable
> when at least one memblock is available below 4G. Otherwise we assume
> that all devices on the SoC can cope with >4G addresses.
> 
> No functional changes on x86.
> 
> Signed-off-by: Chen Baozi <baozich@gmail.com>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Tested-by: Chen Baozi <baozich@gmail.com>

Cheers,

Baozi
