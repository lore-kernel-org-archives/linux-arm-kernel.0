From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 16 Nov 2015 18:19:14 -0500
Subject: [RFC] User space to kernel space copy optimization
In-Reply-To: <1447714667.83864.212.camel@intel.com>
References: <564A5057.9080203@codeaurora.org>
 <1447714667.83864.212.camel@intel.com>
Message-ID: <564A6472.5010100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2015 5:57 PM, Jiang, Dave wrote:
>> One of the things I'm interested in is to use a memcpy capable DMA
>> > engine HW to optimize user space and kernel space parameter copying.
> Have you looked at why NET_DMA was deprecated and using DMA engine to
> do kernel->user copy could be a problem?
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/
> ?id=77873803363c
> 

As far as I know, the problem was the TCP/IP stack trying to work on a
buffer that was given to the DMA engine for moving. It was causing stale
data problems.

The goal was to let DMA engine move the data while TCP/IP stack was
working on something else. Then, synchronize on a known point. Of
course, when above violation happens; things break.

Are you expecting a similar problem on user space to kernel space
interaction? I think the ownership buffers are pretty much defined,
isn't it?


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
