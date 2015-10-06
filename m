From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 6 Oct 2015 08:45:02 +0100
Subject: [PATCH v9] dmaengine: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A4EC2DE@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1440432666-10310-1-git-send-email-appanad@xilinx.com>
 <20151005152628.GE13501@vkoul-mobl.iind.intel.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A4EC2DE@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20151006074459.GA23420@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 03:48:39PM +0000, Appana Durga Kedareswara Rao wrote:
> > Pls justify why we should have two drivers. Looking at code makes me think
> > otherwise
> 
>
[pls wrap your messages within 80 chars, I have reflowed below]
 
> I agree with you and even initially we had a common driver with the
> similar implementation as you were mentioning.  Later on, being soft IPs,
> new features were added and the IPs became diversified. As an example,
> this driver has a residue Calculation whereas the other driver (VDMA) is
> not applicable and the way interrupts are handled is completely different.
> Briefly, they are two complete different IPs with a different register set
> and descriptor format. Eventually, it became too complex To manage the
> common driver as the code became messy with lot of conditions around.
> Mainly the validation process is a big concern, as every change In the IP
> compels to test all the complete features of both IPs.  So, we got
> convinced to the approach of separating the drivers to overcome this and
> it comes with Few addition lines of common code.

No it is not that hard, bunch of people already do that.

You need is a smart probe or perhaps invoke IP specfic method to
initialize dma controller.

In above case no one forces you to register status callback for both, you
can do based on the controller probed...

I am sorry but validation is not a strong point here. I have a driver which
manages bunch of different generations. Reuse helps in having lesser code
and bug fixes across generations easily..

We cant have two drivers pretty much doing same thing in kernel

Please fix this and come back

-- 
~Vinod
