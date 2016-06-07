From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 7 Jun 2016 06:13:49 +0000
Subject: [PATCH v2 3/4] dmaengine: vdma: Add 64 bit addressing support
 for the axi dma
In-Reply-To: <20160607061701.GG16910@localhost>
References: <1463557653-1687-1-git-send-email-appanad@xilinx.com>
 <1463557653-1687-4-git-send-email-appanad@xilinx.com>
 <20160607061701.GG16910@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5B4A40@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> On Wed, May 18, 2016 at 01:17:32PM +0530, Kedareswara rao Appana wrote:
> > +		if (chan->cyclic) {
> > +			if (chan->ext_addr)
> > +				dma_writeq(chan,
> XILINX_DMA_REG_TAILDESC,
> > +					   chan->cyclic_seg_v->phys);
> > +			else
> > +				dma_ctrl_write(chan,
> XILINX_DMA_REG_TAILDESC,
> > +					       chan->cyclic_seg_v->phys);
> > +		} else {
> > +			if (chan->ext_addr)
> > +				dma_writeq(chan,
> XILINX_DMA_REG_TAILDESC,
> > +					   tail_segment->phys);
> > +			else
> > +				dma_ctrl_write(chan,
> XILINX_DMA_REG_TAILDESC,
> > +					       tail_segment->phys);
> 
> this looks ugly and repeated few times. Why not have xilinx_write() which does
> either dma_writeq or dma_ctrl_write based on channel..

Ok sure will fix in the next version...

> 
> > +			if (chan->ext_addr) {
> > +				hw->buf_addr = lower_32_bits(buf_addr +
> > +						sg_used + (period_len * i));
> > +				hw->buf_addr_msb = upper_32_bits(buf_addr +
> > +						sg_used + (period_len * i));
> > +			} else {
> > +				hw->buf_addr = buf_addr + sg_used +
> > +					       (period_len * i);
> > +			}
> 
> similar wrapper here would make code more readable

Ok Sure will fix in the next version...

Thanks,
Kedar.
