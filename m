From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Mon, 04 Apr 2011 13:03:13 -0700
Subject: [PATCH] ARM: hw_breakpoint: clear DBGVCR out of reset
In-Reply-To: <1301833374.5022.9.camel@jazzbox>
References: <1301657056-30065-1-git-send-email-will.deacon@arm.com>	
	<4D9820D6.5040502@codeaurora.org> <1301833374.5022.9.camel@jazzbox>
Message-ID: <4D9A2401.70504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2011 5:22 AM, Will Deacon wrote:
> Hi Stephen,
>
> On Sun, 2011-04-03 at 08:25 +0100, Stephen Boyd wrote:
>> On 4/1/2011 4:24 AM, Will Deacon wrote:
>>> The DBGVCR, used for configuring vector catch debug events, is UNKNOWN
>>> out of reset on ARMv7. When enabling monitor mode, this must be zeroed
>>> to avoid UNPREDICTABLE behaviour.
>>>
>>> This patch adds the zeroing code to the debug reset path.
>>>
>>> Reported-by: Stepan Moskovchenko<stepanm@codeaurora.org>
>>> Signed-off-by: Will Deacon<will.deacon@arm.com>
>> Please Cc stable as this fix should go to the 37 and 38 stable trees.
> Will do. If you could please confirm that it fixes the problems reported
> initially then that would be great.
>
> Thanks,
>
> Will
>

I confirm that this fixes the problem I was seeing.

Thanks
Steve

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
