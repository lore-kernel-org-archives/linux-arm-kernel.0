From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 3 Nov 2017 09:12:04 +0100
Subject: Performance issues writing to PCIe in a Zynq
In-Reply-To: <1509636637116.27702@axon.tv>
References: <1509636637116.27702@axon.tv>
Message-ID: <eca01e58-3da1-d5c4-00f7-71dd6a926870@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2.11.2017 16:30, Ruben Guerra Marin wrote:
> Hi,
> 
> 
> I have the a Zynq board running petalinux, and it is connected through PCIe to a Virtex Ultrascale board. I configured the Ultrascale for Tandem PCIe, which the second stage bitstream is being programmed from the Zynq board (I crossed compiled the mcap application that Xilinx provides).
> 
> 
> 
> This works perfectly, but takes around ~12 seconds to program the second stage bitstream (compressed is ~12 MB), which is quite slow. We also tried debugging the mcap application and pciutils. We found out the operation that takes long to execute: In pciutils, the instruction to actually call the write to the driver (pwrite) takes approximately 6uS, so if you add up this for 12 MB then you can see why it takes so long. Why is this so slow? Is this maybe a problem with the driver?
> 
> 
> For testing, I added an ILA to the AXI bus in between the Zynq GP1 and the PCIe IP control registers port. I triggered halfway the programming of the bitstream using the mcap program provided by Xilinx. I can see that it is writing to address x358, which according to the *datasheet* (https://www.xilinx.com/Attachment/Xilinx_Answer_64761__UltraScale_Devices.pdf) is the Write Data Register, which is correct (and again, I know the whole bitstream gets programmed correctly).
> 
> 
> 
> But what I also see is that a "awvalid" being asserted to the next one it takes 245 cycles, and I can imagine this is why it takes 12 seconds to program a 12MB bitstream.
> 
> ?

Bharat: Can you please take a look at this?

Thanks,
Michal
