From: Barry.Song@csr.com (Barry Song)
Date: Fri, 28 Oct 2011 08:08:27 +0000
Subject: [PATCH v4] dmaengine: add CSR SiRFprimaII DMAC driver
References: <1318907324-17046-1-git-send-email-Barry.Song@csr.com>
	<1319703535.20054.30.camel@vkoul-udesk3>
	<5EB3BFCD089AD643B9BB63439F5FD5E98419F7FF@SHAASIEXM01.ASIA.ROOT.PRI>
	<1319774982.20054.228.camel@vkoul-udesk3>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E98419FAC0@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Barry Song
> Sent: 2011?10?28? 13:04
> To: 'Vinod Koul'
> Cc: Arnd Bergmann; Jassi Brar; Linus Walleij; linux-kernel at vger.kernel.org;
> DL-SHA-WorkGroupLinux; Rongjun Ying; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH v4] dmaengine: add CSR SiRFprimaII DMAC driver
> 
> > -----Original Message-----
> > From: Vinod Koul [mailto:vinod.koul at intel.com]
> > Sent: 2011?10?28? 12:10
> > To: Barry Song
> > Cc: Arnd Bergmann; Jassi Brar; Linus Walleij; linux-kernel at vger.kernel.org;
> > DL-SHA-WorkGroupLinux; Rongjun Ying; linux-arm-kernel at lists.infradead.org
> > Subject: RE: [PATCH v4] dmaengine: add CSR SiRFprimaII DMAC driver
> >
> > On Fri, 2011-10-28 at 01:49 +0000, Barry Song wrote:
> > > > Also, Please ensure you send patches which compile with ZERO warnings:
> > > > drivers/dma/sirf-dma.c: In function 'sirfsoc_dma_probe':
> > > > drivers/dma/sirf-dma.c:616: warning: assignment from incompatible
> > pointer
> > > > type
> > > > drivers/dma/sirf-dma.c:617: warning: assignment from incompatible
> > pointer
> > > > type
> > > > which comes from the fact that your prep_interleaved_dma does not have
> > > > last argument of flags.
> > > > On the second one you have not rebased to patch from Jassi which I
> > > > applied after converting direction stuff.
> > >
> > >
> > [pls wrap 80chars within paragraphs, i have reformatted below)
> > > I rebased to both yours and Jassi by my merging manually. I remember
> > > you have changed the last param of device_prep_dma_cyclic from
> > > dma_data_direction to dma_transfer_direction. After checking the tree
> > > interleaved_dma @ git://git.infradead.org/users/vkoul/slave-dma.git,
> > > it doesn't. then make another compiling warning in
> > > sirfsoc_dma_prep_cyclic(). so I'll still use dma_data_direction in
> > > sirfsoc_dma_prep_cyclic().
> > Yes for cyclic, I have missed to fix that. I will push the fixed version
> 
> Ok. note my v5 is still using dma_data_direction. You might take care too :-)

Vinod, as I have acked interleaved dma API explicitly before, could you pls add: 
Acked-by: Barry Song <Baohua.Song@csr.com>
in the commit of " DMAEngine: Define interleaved transfer request api" in your tree too. I didn't find it after I fetch your tree :-)

> 
> > now
> >
> > --
> > ~Vinod
-barry



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
