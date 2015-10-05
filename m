From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 5 Oct 2015 15:48:39 +0000
Subject: [PATCH v9] dmaengine: Add Xilinx AXI Direct Memory Access
 Engine driver support
In-Reply-To: <20151005152628.GE13501@vkoul-mobl.iind.intel.com>
References: <1440432666-10310-1-git-send-email-appanad@xilinx.com>
 <20151005152628.GE13501@vkoul-mobl.iind.intel.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A4EC2DE@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,


> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Monday, October 05, 2015 8:57 PM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; Michal Simek; Soren Brinkmann;
> moritz.fischer at ettus.com; Appana Durga Kedareswara Rao;
> anirudha at xilinx.com; dmaengine at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v9] dmaengine: Add Xilinx AXI Direct Memory Access Engine
> driver support
> 
> On Mon, Aug 24, 2015 at 09:41:06PM +0530, Kedareswara rao Appana wrote:
> > This is the driver for the AXI Direct Memory Access (AXI DMA) core,
> > which is a soft Xilinx IP core that provides high- bandwidth direct
> > memory access between memory and AXI4-Stream type target peripherals.
> 
> Okay reviewing this after the other Xilinx driver with very similar name, I am very
> concerned about code duplication. Both codes seems to be pretty much copy
> paste and some modifications for IP. In Linux kernel we reuse!
> 
> Please create common lib for Xilinx drivers to use and have HW diff is two
> drivers, or manage those with different driver ops
> 
> Pls justify why we should have two drivers. Looking at code makes me think
> otherwise


I agree with you and even initially we had a common driver with the similar implementation as you were mentioning. 
Later on, being soft IPs, new features were added and the IPs became diversified. As an example, this driver has a residue
Calculation whereas the other driver (VDMA) is not applicable and the way interrupts are handled is completely different.
Briefly, they are two complete different IPs with a different register set and descriptor format. Eventually, it became too complex
To manage the common driver as the code became messy with lot of conditions around. Mainly the validation process is a big concern, as every change
In the IP compels to test all the complete features of both IPs.  So, we got convinced to the approach of separating the drivers to overcome this and it comes with
Few addition lines of common code.

Please let me know if I am not clear.

Regards,
Kedar.

> 
> --
> ~Vinod
