From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 16 Jan 2012 10:30:23 -0800
Subject: [PATCH 1/2] ARM: vmlinux.lds.S: do not hardcode cacheline size
 as 32 bytes
In-Reply-To: <20120116182622.GC11088@mudshark.cambridge.arm.com>
References: <1326728658-10029-1-git-send-email-will.deacon@arm.com>
 <4F146AEA.90600@codeaurora.org>
 <20120116182622.GC11088@mudshark.cambridge.arm.com>
Message-ID: <4F146CBF.6030104@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/12 10:26, Will Deacon wrote:
> On Mon, Jan 16, 2012 at 06:22:34PM +0000, Stephen Boyd wrote:
>>
>> What do you think about aligning the exception fixup table to the same
>> value?
> Hmm, I'm not sure I see what that gains us over the current 32-byte
> alignment. Are you seeing any measurable performance difference with it being
> cacheline-aligned?
>

I haven't measured anything yet. I just see that it's another value
hard-coded to 32 in the linker script and that tile has decided to use
L1_CACHE_BYTES for it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
