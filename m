From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 12 Jun 2017 09:14:20 +0200
Subject: [PATCH] clocksource: fix read and iounmap of incorrect variable
In-Reply-To: <87r2ysgojz.fsf@arm.com>
References: <1497054392-13783-1-git-send-email-frowand.list@gmail.com>
 <87r2ysgojz.fsf@arm.com>
Message-ID: <beaa049c-98df-5e9a-d0b5-09b2946e6766@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2017 11:49, Marc Zyngier wrote:
> On Fri, Jun 09 2017 at  5:26:32 pm BST, frowand.list at gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Fix boot warning 'Trying to vfree() nonexistent vm area'
>> from arch_timer_mem_of_init().
>>
>> Refactored code attempts to read and iounmap using address frame
>> instead of address ioremap(frame->cntbase).
>>
>> Fixes: c389d701dfb70 ("clocksource: arm_arch_timer: split MMIO timer probing.")
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---

[ ... ]

> Ah, nice find.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thomas, Daniel: Can you queue this for the next -rc please?

Yep, applied to my tree.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
