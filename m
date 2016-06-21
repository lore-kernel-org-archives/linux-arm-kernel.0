From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 21 Jun 2016 11:05:52 +0530
Subject: [PATCH v3 1/2] dmaengine: vdma: Add 64 bit addressing support
 for the axi dma
In-Reply-To: <1465307476-15936-1-git-send-email-appanad@xilinx.com>
References: <1465307476-15936-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160621053551.GX16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 07:21:15PM +0530, Kedareswara rao Appana wrote:
> The AXI DMA is a soft ip, which can be programmed to support
> 32 bit addressing or greater than 32 bit addressing.
> 
> When the AXI DMA ip is configured for 32 bit address space
> in simple dma mode the buffer address is specified by a single register
> (18h for MM2S channel and 48h for S2MM channel). When configured in SG mode
> The current descriptor and tail descriptor are specified by a single
> Register(08h for curdesc 10h for tail desc for MM2S channel and 38h for
> Curdesc and 40h for tail desc for S2MM).
> 
> When the  AXI DMA core is configured for an address space greater
> than 32 then each buffer address or descriptor address is specified by
> a combination of two registers.
> 
> The first register specifies the LSB 32 bits of address,
> while the next register specifies the MSB 32 bits of address.
> 
> For example, 48h will specify the LSB 32 bits while 4Ch will
> specify the MSB 32 bits of the first start address.
> So we need to program two registers at a time.
> 
> This patch adds the 64 bit addressing support for the axidma
> IP in the driver.

Applied both, thanks

-- 
~Vinod
