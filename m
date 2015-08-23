From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 23 Aug 2015 19:09:33 +0530
Subject: [PATCH] dmaengine: vdma: Add 64 bit addressing support to the
 driver
In-Reply-To: <2348343.VuhoH7scrX@avalon>
References: <1438775257-3511-1-git-send-email-anuragku@xilinx.com>
 <2214014.FVHbR3JRBK@avalon>
 <3802E9A6666DF54886E2B9CBF743BA9801BF8264@XAP-PVEXMBX01.xlnx.xilinx.com>
 <2348343.VuhoH7scrX@avalon>
Message-ID: <20150823133933.GY13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 02:01:59AM +0300, Laurent Pinchart wrote:
> > > How is 64 bit DMA addressing implemented ? Can you use a 64-bit VDMA on
> > > a 32- bit platform with LPAE ? Can you use a 32-bit VDMA on a 64-bit
> > > platform ? Given that VDMA is an IP core you can instantiate in the
> > > programmable logic I expect some level of flexibility to be possible, but
> > > this patch doesn't seem to support it. Please provide more context to
> > > allow a proper review (and please include it in the commit message of v2).
> > 
> > The VDMA core is a soft ip, which can be programmed to support both 32 bit
> > and 64 bit addressing.When the VDMA core is configured for 32 bit address
> > space , transfer start address is specified by a single register.
> > 
> > When the  VDMA core is configured for an address space greater than 32, each
> > start address is specified by a combination of two registers.The first
> > register specifies the LSB 32 bits of address, while the next register
> > specifies the MSB 32 bits of address.For example,5Ch will specify the LSB
> > bits while 60h will specify the MSB bits of the first start address. So we
> > need to program two registers at a time.
> > 
> > Yes,64 bit vdma can be used on 32 bit platform and 32 bit vdma can also be
> > used on 64 bit platform.As far as i know , there is no use case where 64
> > bit dma can be used on 32 bit platform.Please correct me if i am wrong.
> 
> I'm not sure what the use cases would be, but it makes me feel uncomfortable 
> to decide on whether the VDMA is 32 or 64 bits based on the type of CPU.
> 
> As the VDMA flavour is selected at synthesis time, how about specifying it in 
> DT instead ? You could just add an address-width property.
That would be saner thing to do. People wont check which IP and will mix and
match. So you may have a 64 bit system with your 32 bit IP...

-- 
~Vinod
