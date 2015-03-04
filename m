From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 4 Mar 2015 17:32:50 +0530
Subject: [PATCH] dma: xilinx-dma: move header file to common location
In-Reply-To: <2793259.VbbYy9Imif@wuerfel>
References: <4c3e2425e14646cb86c20d6aebdcfe22@BY2FFO11FD004.protection.gbl>
 <2793259.VbbYy9Imif@wuerfel>
Message-ID: <20150304120250.GO2613@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 08:28:01PM +0100, Arnd Bergmann wrote:
> On Monday 02 March 2015 23:24:24 Kedareswara rao Appana wrote:
> > This patch moves the xilinx_dma.h header file
> > to the include/linux/dma.
> > 
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> 
> Please move this header file to drivers/dma/xilinx/ directly to
> make it inaccessible by other driver. No driver should pass extra
> data structures to a dmaengine driver.
Actually that is not true. Few of the drivers need some additional
parameters to be set which are not covered by the common set, hence an
additional API is exposed by this driver to do so...

If ever we could get rid of these...

-- 
~Vinod
