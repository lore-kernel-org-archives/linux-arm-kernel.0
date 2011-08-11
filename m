From: davidb@codeaurora.org (David Brown)
Date: Thu, 11 Aug 2011 14:11:06 -0700
Subject: [PATCHv4 1/2] ARM: Set proper TEXT_OFFSET for newer MSMs
In-Reply-To: <1311794355-26988-1-git-send-email-sboyd@codeaurora.org>
References: <1311794355-26988-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110811211106.GA14101@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 12:19:14PM -0700, Stephen Boyd wrote:
> MSMs post 8x50 have 2Mb at the beginning of RAM reserved for
> shared memory. Since the kernel hasn't typically been told this
> RAM exists, PHYS_OFFSET has been set to 0xN0200000 and the memory
> atags passed to the kernel have matched. This doesn't play nicely
> with things such as AUTO_ZRELADDR, which doesn't work at all, and
> dynamic phys to virt, which requires an MSM specific workaround.
> 
> Work around these issues by telling the kernel RAM starts at
> 0xN0000000 (it actually does) and fixup the atags from the
> bootloader (if necessary) to say the same. In addition, make sure
> to set TEXT_OFFSET at least 2Mb beyond the start of RAM so that
> the kernel doesn't end up being decompressed into shared memory.
> 
> After doing this, AUTO_ZRELADDR should work on MSM with no
> problems and ARM_PATCH_PHYS_VIRT_16BIT should no longer be
> necessary.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
