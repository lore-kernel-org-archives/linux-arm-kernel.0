From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 16 Jan 2012 10:22:34 -0800
Subject: [PATCH 1/2] ARM: vmlinux.lds.S: do not hardcode cacheline size
 as 32 bytes
In-Reply-To: <1326728658-10029-1-git-send-email-will.deacon@arm.com>
References: <1326728658-10029-1-git-send-email-will.deacon@arm.com>
Message-ID: <4F146AEA.90600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/12 07:44, Will Deacon wrote:
> The linker script assumes a cacheline size of 32 bytes when aligning
> the .data..cacheline_aligned and .data..percpu sections.
>
> This patch updates the script to use L1_CACHE_BYTES, which should be set
> to 64 on platforms that require it.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>
> v2: incorporated suggestions from Stephen Boyd

What do you think about aligning the exception fixup table to the same
value?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
