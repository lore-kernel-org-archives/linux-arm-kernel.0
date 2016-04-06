From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 6 Apr 2016 08:42:26 -0700
Subject: [RESEND PATCH v3 1/2] dmaengine: vdma: Add 64 bit addressing
 support to the driver
In-Reply-To: <1459919289-5654-1-git-send-email-appanad@xilinx.com>
References: <1459919289-5654-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160406154142.GB29770@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 10:38:08AM +0530, Kedareswara rao Appana wrote:
> This VDMA  is a soft ip, which can be programmed to support
> 32 bit addressing or greater than 32 bit addressing.
> 
> When the VDMA ip is configured for 32 bit address space
> the buffer address is specified by a single register
> (0x5C for MM2S and 0xAC for S2MM channel).
> 
> When the  VDMA core is configured for an address space greater
> than 32 then each buffer address is specified by a combination of
> two registers.
> 
> The first register specifies the LSB 32 bits of address,
> while the next register specifies the MSB 32 bits of address.
> 
> For example, 5Ch will specify the LSB 32 bits while 60h will
> specify the MSB 32 bits of the first start address.
> So we need to program two registers at a time.
> 
> This patch adds the 64 bit addressing support to the vdma driver.

Applied both, thanks

-- 
~Vinod
