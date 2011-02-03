From: smuckle@codeaurora.org (Steve Muckle)
Date: Thu, 03 Feb 2011 08:56:15 -0800
Subject: barriers in mutexes?
In-Reply-To: <20110203110837.GA14627@n2100.arm.linux.org.uk>
References: <4D4A0D7A.9090005@codeaurora.org>
	<20110203110837.GA14627@n2100.arm.linux.org.uk>
Message-ID: <4D4ADE2F.50105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/11 03:08, Russell King - ARM Linux wrote:
> On Wed, Feb 02, 2011 at 06:05:46PM -0800, Steve Muckle wrote:
>> Looking at kernel/mutex.c and arch/arm/include/asm/mutex.h, it appears
>> there aren't any memory barriers in the fast path of mutexes. I see this
>> was discussed here a long time back:
>>
>> http://patchwork.kernel.org/patch/25856/
>>
>> How was this resolved?
> 
> bac4e96 ([ARM] barriers: improve xchg, bitops and atomic SMP barriers)

The fast path of mutexes on ARM >= v6 doesn't seem to use these
operations - it's just ldrex/strex. Looking at the v7 ARM ARM it seems
barriers are still required with ldrex/strex.

thanks,
Steve

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
