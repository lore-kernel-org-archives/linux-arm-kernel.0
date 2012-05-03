From: ylmao@marvell.com (Yilu Mao)
Date: Thu, 3 May 2012 21:02:56 +0800
Subject: [PATCH v5] ARM: cache-l2x0.c: save the final aux ctrl value for
 resuming
In-Reply-To: <20120503125955.GE27872@arm.com>
References: <1336046857-24133-1-git-send-email-ylmao@marvell.com>
 <20120503125955.GE27872@arm.com>
Message-ID: <4FA28200.7020508@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2012 08:59 PM, Catalin Marinas wrote:
> On Thu, May 03, 2012 at 01:07:37PM +0100, Yilu Mao wrote:
>> There is a bug if l2x0 controller has been enabled when calling
>> l2x0_init, the aux ctrl register will not be saved in l2x0_saved_regs.
>> Therefore we will use uninitialized l2x0_saved_regs.aux_ctrl for
>> resuming later.
>>
>> In this patch, the aux ctrl value is read and saved after it is
>> initialized. So we have the real value being set for resuming.
>>
>> Signed-off-by: Yilu Mao<ylmao@marvell.com>
>
> Acked-by: Catalin Marinas<catalin.marinas@arm.com>
Hi Catalin,

Thanks for reviewing.
I have another question:
There are a lot of registers in l2x0 controller.
Why we only save so small amount of registers?
Base on l2x0 spec, they suggest to save/restore all of them.

-- 
Thanks.

Best Wishes,
Yilu Mao
