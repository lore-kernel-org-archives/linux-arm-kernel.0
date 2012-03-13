From: kumarrav@codeaurora.org (Ravi Kumar V)
Date: Tue, 13 Mar 2012 18:16:39 +0530
Subject: [PATCH v3 2/2] DMAEngine: Add DMAEngine driver based on old MSM
 DMA APIs
In-Reply-To: <20120312201421.GA3459@fifo99.com>
References: <1331548364-27845-1-git-send-email-kumarrav@codeaurora.org>
 <20120312201421.GA3459@fifo99.com>
Message-ID: <4F5F41AF.1090907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/2012 1:44 AM, Daniel Walker wrote:
> On Mon, Mar 12, 2012 at 04:02:44PM +0530, Ravi Kumar V wrote:
>> Add DMAEngine based driver using the old MSM DMA APIs internally.
>
> What do you mean by this?
>
There is a MSM DMA driver in arch/arm/mach-msm/ which is not in
dmaengine framework standards, but that driver is been used by client 
drivers nand, eMMC and serial drivers. Now if we implement the whole dma 
driver using dmaengine framework then nand, eMMC like drivers will be 
failed as they are using old dma driver API's, so instead of 
implementing new driver from scratch we are keeping the old dma API's as 
it is and using those API's in new dmaengine framework.So that we can 
convert clients drivers to use dma engine framework.

>> The benefit of this approach is that not all the drivers
>> have to get converted to DMAEngine APIs simultaneosly while
>> both the drivers can stay enabled in the kernel. The client
>> drivers using the old MSM APIs directly can now convert to
>> DMAEngine one by one.
>
> Which drivers?

client drivers which are using dma.
>
> Daniel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
