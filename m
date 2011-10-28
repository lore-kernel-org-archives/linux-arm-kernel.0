From: Barry.Song@csr.com (Barry Song)
Date: Fri, 28 Oct 2011 01:49:35 +0000
Subject: [PATCH v4] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <1319703535.20054.30.camel@vkoul-udesk3>
References: <1318907324-17046-1-git-send-email-Barry.Song@csr.com>
	<1319703535.20054.30.camel@vkoul-udesk3>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E98419F7FF@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Also, Please ensure you send patches which compile with ZERO warnings:
> drivers/dma/sirf-dma.c: In function 'sirfsoc_dma_probe':
> drivers/dma/sirf-dma.c:616: warning: assignment from incompatible pointer
> type
> drivers/dma/sirf-dma.c:617: warning: assignment from incompatible pointer
> type
> which comes from the fact that your prep_interleaved_dma does not have
> last argument of flags.
> On the second one you have not rebased to patch from Jassi which I
> applied after converting direction stuff.


I rebased to both yours and Jassi by my merging manually. I remember you have changed the last param of device_prep_dma_cyclic from dma_data_direction to dma_transfer_direction. After checking the tree interleaved_dma @ git://git.infradead.org/users/vkoul/slave-dma.git, it doesn't. then make another compiling warning in sirfsoc_dma_prep_cyclic(). so I'll still use dma_data_direction in sirfsoc_dma_prep_cyclic().
> 
> --
> ~Vinod
> 
-barry


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
