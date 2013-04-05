From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 5 Apr 2013 10:08:23 +0200
Subject: [PATCH] ARM: dts: OMAP4+: Correct L3 interrupts
In-Reply-To: <515E6EAE.9000107@ti.com>
References: <1365098790-9078-1-git-send-email-jon-hunter@ti.com>
 <515E6EAE.9000107@ti.com>
Message-ID: <515E8677.40404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 08:26 AM, Santosh Shilimkar wrote:
> On Thursday 04 April 2013 11:36 PM, Jon Hunter wrote:
>> The L3 interrupt numbers are incorrect for OMAP4+ and are conflicting
>> with some of the timer interrupts causing the allocation of timer
>> interrupts to fail.
>>
>> The problem is caused by adding 32 to the interrupt number for the L3
>> interrupts to account for per processor interrupts (PPI) and software
>> generated interrupts (SGI) which typically are mapped to the first 32
>> interrupts in the ARM GIC. This is not necessary because the first
>> parameter of the ARM GIC interrupt property specifies the GIC interrupt
>> type (ie. SGI, PPI, etc). Hence, fix the interrupt number fo the L3
>> interrupts by substracting 32.
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>
>> Please note that this problem is observed in Benoit's for_3.10/dts branch [1].
>>
>> [1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git
>>
> Thats correct. I overlooked the 32 addition part. This patch should
> also be pulled into Benoit's 3.10 tree.

Done. I've just applied it. But I will probably merge it with the
original patch, because having a broken patch and the fix in the same
pull request does not look right.

> For the patch,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks,
Benoit
