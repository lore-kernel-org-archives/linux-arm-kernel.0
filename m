From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 8 Mar 2016 15:46:20 +0100
Subject: [PATCH 5/7] mtd: provide helper to prepare buffers for DMA
 operations
In-Reply-To: <20160308141853.GQ11154@localhost>
References: <1457435715-24740-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457435715-24740-6-git-send-email-boris.brezillon@free-electrons.com>
 <20160308141853.GQ11154@localhost>
Message-ID: <20160308154620.3d64d02b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Mar 2016 19:48:53 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Tue, Mar 08, 2016 at 12:15:13PM +0100, Boris Brezillon wrote:
> >  
> > +#ifdef CONFIG_HAS_DMA
> 
> Shouldn't this be CONFIG_DMA_ENGINE as you are preparing these descriptors
> for DMA transfer?
> 

Nope, scatterlist users are not necessarily using a dmaengine, some IPs
are directly embedding a dedicated DMA engine, which has no driver in
drivers/dma/.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
