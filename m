From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 3 May 2016 09:12:24 +0000
Subject: [PATCH v7 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
 device tree binding documentation
In-Reply-To: <20160502100953.GJ2274@localhost>
References: <1461740729-30715-1-git-send-email-appanad@xilinx.com>
 <57206632.7010508@metafoo.de>
 <C246CAC1457055469EF09E3A7AC4E11A4A57B840@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5720B333.4000804@metafoo.de>
 <C246CAC1457055469EF09E3A7AC4E11A4A57C2E2@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5721D38A.8010501@metafoo.de> <20160502100953.GJ2274@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A57E033@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Vinod,

> 
> PLEASE strip the crap from your MUA, better use a linux MUA

OK will fix Sorry for the noise...

> 
> 
> > >>>>> +- xlnx,include-sg	: Indicates the controller to operate in simple
> or
> > >>>>> +			  scatter gather dma mode
> > >>>>> +- xlnx,ratectrl		: Scheduling interval in terms of clock cycles for
> > >>>>> +			  source AXI transaction
> > >>>>> +- xlnx,overfetch	: Tells whether the channel is allowed to over
> > >>>>> +			  fetch the data
> > >>>>> +- xlnx,src-issue	: Number of AXI outstanding transactions on source
> > >>>> side
> > >>>>> +- xlnx,src-burst-len	: AXI length for data read. Support only power
> of
> > >>>>> +			  2 byte values.
> > >>>>> +- xlnx,dst-burst-len	: AXI length for data write. Support only power
> of
> > >>>>
> > >>>> These are all software runtime configuration parameters that you'd
> > >>>> want to change at runtime depending on which peripheral you are
> > >>>> targeting with a specific DMA transfer. These really do not belong into

> > Sorry, but that is just as broken. You need to derive those parameters from
> > the DMA transfer as they are transfer specific.
> 
> Right, for memcpy you should derive the parameters. Frankly burst size
> and lengths, rate control should be set to maximun to achives best
> performance on mecpy.  People want memcpy to be done asap

Ok Will fix in the next version of the patch...

Regards,
Kedar.
