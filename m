From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 13 Jan 2017 06:33:33 +0000
Subject: [PATCH v5 3/3] dmaengine: xilinx_dma: Fix race condition in the
 driver for multiple descriptor scenario
In-Reply-To: <20170113062225.GR3573@localhost>
References: <1483771530-8545-1-git-send-email-appanad@xilinx.com>
 <1483771530-8545-4-git-send-email-appanad@xilinx.com>
 <20170110084917.GA3573@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A6662F1@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20170113053627.GQ3573@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A6666CF@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20170113062225.GR3573@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A6666F3@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,
	
	Thanks for the review...

[Snip]
> > > Btw how and when does DMA stop, assuming it is circular it never
> > > would, isn't there a valid/stop flag associated with a descriptor
> > > which tells DMA engine what to do next
> >
> > There are two registers that controls the DMA transfers.
> > Current descriptor and tail descriptor register.
> > When current descriptor reaches tail descriptor dma engine will pause.
> >
> > When reprogramming the tail descriptor the DMA engine will starts fetching
> descriptors again.
> >
> > But with the existing driver flow if we reprogram the tail descriptor
> > The tail descriptor next descriptor field is pointing to an invalid
> > location Causing data corruption...
> 
> So the solution is..?

This patch.
I mean if we have a set of descriptors in chain (in circular manner last descriptor points to first descriptor)
It always points to valid descriptors. 

Will update the patch commit description in the next version...

> 
> > > Btw there is something wrong with your MUA perhaps line are
> > > titlecased for no reason. This is typically behavious of non linux
> > > tool which may not be great tool for this work.
> >
> > Thanks for pointing it out.
> > I usually replies from outlook from a windows machine.
> > Will check with others in my team how they configured their mail client.
> 
> Yeah that isnt right tool for the job. See Documentation/process/email-
> clients.rst
> 
> FWIW, I use mutt, vim as editor with exchange servers, seems to work well for
> me now.

Thanks for pointing it out will go through it.
Will install mutt in my Linux machine will start replying from that

Regards,
Kedar.

> 
> --
> ~Vinod
