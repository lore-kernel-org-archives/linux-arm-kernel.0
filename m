From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 10 Mar 2017 10:03:11 +0530
Subject: [PATCH] dma: xilinx: Make Xilinx VDMA support ARC
In-Reply-To: <c1285d07-f925-2c3a-c90c-1ef9ee948b80@synopsys.com>
References: <ec057c7b16c414a1cf9a9eba87c33f8bcf9f01f9.1488803103.git.roliveir@synopsys.com>
 <1ff465a7-69ed-6cd1-0e02-4b9ff752b3cd@topic.nl>
 <c1285d07-f925-2c3a-c90c-1ef9ee948b80@synopsys.com>
Message-ID: <20170310043311.GV2843@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 09:55:59AM +0000, Ramiro Oliveira wrote:
> Hi Mike
> 
> On 3/9/2017 7:37 AM, Mike Looijmans wrote:
> > On 06-03-17 13:27, Ramiro Oliveira wrote:
> >> Add option in Kconfig to use Xilinx VDMA in ARC processors.
> >>
> >> Signed-off-by: Ramiro Oliveira <roliveir@synopsys.com>
> >> ---
> >>  drivers/dma/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> >> index 263495d0adbd..b6b6c0581ad7 100644
> >> --- a/drivers/dma/Kconfig
> >> +++ b/drivers/dma/Kconfig
> >> @@ -546,7 +546,7 @@ config XGENE_DMA
> >>
> >>  config XILINX_DMA
> >>      tristate "Xilinx AXI DMAS Engine"
> >> -    depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
> >> +    depends on (ARCH_ZYNQ || MICROBLAZE || ARM64|| ARC)
> > 
> > One can put a Xilinx FPGA on a PCIe card, instantiate a PCIe-AXI bridge and then
> > use it on any platform that supports PCIe.
> > 
> > I've had to remove this line in order to be able to use the engine on an x86
> > desktop.
> > 
> > How about plainly removing this "depends on" line and be done with it, instead
> > of adding platforms one by one?
> > 
> > 
> 
> I agree with you. From my point of view it would be better to remove this line
> entirely. I'm just not sure if everyone agrees.

if it works on others, compiles fine then there should not be an issue to
remove.

Feel free to send the patch.

-- 
~Vinod
