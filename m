From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 17 Jan 2014 17:32:17 +0200
Subject: [PATCH] Add Xilinx AXI Video DMA Engine driver
In-Reply-To: <1389894803-4147-1-git-send-email-sthokal@xilinx.com>
References: <1389894803-4147-1-git-send-email-sthokal@xilinx.com>
Message-ID: <1389972737.7619.14.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-16 at 23:23 +0530, Srikanth Thokala wrote:
> Hi,
> 
> This is the driver for Xilinx AXI Video Direct Memory Access Engine.
> It is a soft IP core, which provides high-bandwidth direct memory
> access between memory and AXI4-Stream video type target peripherals 
> including peripherals which support AXI4-Stream Video Protocol. The
> core provides efficient two dimensional DMA operations with independent
> asynchronous read and write channel operation.
> 
> For more information on the IP, please refer to
> http://www.xilinx.com/support/documentation/ip_documentation/axi_vdma/v6_1/pg020_axi_vdma.pdf
> 
> This patch also provides a test client, which assumes read and write channels
> of the core are configured in a back-to-back connection.  It transfers 
> data on the write channel, read and verify the data on the read channel. 
> 
>  drivers/dma/xilinx/xilinx_vdma_test.c              |  629 ++++++++

What about to modify dmatest.c accordingly to your needs?
I see no much sense to have another copy of that in the tree.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
