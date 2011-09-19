From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 19 Sep 2011 16:44:38 +0530
Subject: [PATCH v2] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E9840F3B18@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1316166960-20964-1-git-send-email-Baohua.Song@csr.com>
	<1316422774.26662.30.camel@vkoul-udesk3>
	<5EB3BFCD089AD643B9BB63439F5FD5E9840F3A8D@SHAASIEXM01.ASIA.ROOT.PRI>
	<1316425277.26662.41.camel@vkoul-udesk3>
	<5EB3BFCD089AD643B9BB63439F5FD5E9840F3B18@SHAASIEXM01.ASIA.ROOT.PRI>
Message-ID: <1316430878.26662.46.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-09-19 at 09:56 +0000, Barry Song wrote:
> > > > Not sure why you support this, there seem to be no DMA_SLAVE
> support in
> > > > this version ate least
> > >
> > > Not. I support dma_slave. But I have no prep_slave_sg function
> since I can
> > use the gen xfer to replace it.
> > Yes thats okay...
> > 
> > Then I have questions on genxfer function...
> > where are you copying either src or dstn_start address, you seem to
> > completely ignore them?
> 
> Since I only support memory->device or device ->memory, and channel
> number is fixed to every device. Then I actually don't care device
> address at all. Either src or dst is fixed to the device's address.
peripheral address can be fixed, not the memory, where do you copy the
memory address?
> 
> > 
> > Do you support only slave transfers or M2M as well for this driver?
> > If only slave you might want to check if dma_config_slave is set for
> > this channel or not.
> 
> I support only slave transfer. Actually I have dma_config_slave. do
> you mean I need to check whether slave config cmd is really called
> before executing dma?
Yes


-- 
~Vinod
