From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 28 Oct 2011 09:39:42 +0530
Subject: [PATCH v4] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E98419F7FF@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1318907324-17046-1-git-send-email-Barry.Song@csr.com>
	<1319703535.20054.30.camel@vkoul-udesk3>
	<5EB3BFCD089AD643B9BB63439F5FD5E98419F7FF@SHAASIEXM01.ASIA.ROOT.PRI>
Message-ID: <1319774982.20054.228.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-10-28 at 01:49 +0000, Barry Song wrote:
> > Also, Please ensure you send patches which compile with ZERO warnings:
> > drivers/dma/sirf-dma.c: In function 'sirfsoc_dma_probe':
> > drivers/dma/sirf-dma.c:616: warning: assignment from incompatible pointer
> > type
> > drivers/dma/sirf-dma.c:617: warning: assignment from incompatible pointer
> > type
> > which comes from the fact that your prep_interleaved_dma does not have
> > last argument of flags.
> > On the second one you have not rebased to patch from Jassi which I
> > applied after converting direction stuff.
> 
> 
[pls wrap 80chars within paragraphs, i have reformatted below)
> I rebased to both yours and Jassi by my merging manually. I remember
> you have changed the last param of device_prep_dma_cyclic from
> dma_data_direction to dma_transfer_direction. After checking the tree
> interleaved_dma @ git://git.infradead.org/users/vkoul/slave-dma.git,
> it doesn't. then make another compiling warning in
> sirfsoc_dma_prep_cyclic(). so I'll still use dma_data_direction in
> sirfsoc_dma_prep_cyclic().
Yes for cyclic, I have missed to fix that. I will push the fixed version
now

-- 
~Vinod
