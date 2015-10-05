From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 5 Oct 2015 16:26:30 +0100
Subject: [PATCH v9] dmaengine: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <1440432666-10310-1-git-send-email-appanad@xilinx.com>
References: <1440432666-10310-1-git-send-email-appanad@xilinx.com>
Message-ID: <20151005152628.GE13501@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 09:41:06PM +0530, Kedareswara rao Appana wrote:
> This is the driver for the AXI Direct Memory Access (AXI DMA)
> core, which is a soft Xilinx IP core that provides high-
> bandwidth direct memory access between memory and AXI4-Stream
> type target peripherals.

Okay reviewing this after the other Xilinx driver with very similar name, I
am very concerned about code duplication. Both codes seems to be pretty much
copy paste and some modifications for IP. In Linux kernel we reuse!

Please create common lib for Xilinx drivers to use and
have HW diff is two drivers, or manage those with different driver ops

Pls justify why we should have two drivers. Looking at code makes me think
otherwise

-- 
~Vinod
