From: dave.jiang@intel.com (Jiang, Dave)
Date: Mon, 16 Nov 2015 22:57:47 +0000
Subject: [RFC] User space to kernel space copy optimization
In-Reply-To: <564A5057.9080203@codeaurora.org>
References: <564A5057.9080203@codeaurora.org>
Message-ID: <1447714667.83864.212.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 2015-11-16 at 21:53 +0000, Sinan Kaya wrote:
> One of the things I'm interested in is to use a memcpy capable DMA
> engine HW to optimize user space and kernel space parameter copying.

Have you looked at why NET_DMA was deprecated and using DMA engine to
do kernel->user copy could be a problem?
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/
?id=77873803363c

> 
> Of course, this will not be viable for all parameter sizes but I can
> see
> this being useful. The goal is to save power in the cost of little
> performance.
> 
> Before I go and invent my own mechanism, I'd like to have ideas on
> what
> an acceptable solution would look like. Especially, I'm looking for a
> generic implementation that could plug into any DMA engine HW.
> 
> -- 
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center,
> Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
