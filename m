From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 22 Oct 2013 19:23:10 +0530
Subject: [PATCH v2] ARM: OMAP2+: wakeupgen: AM43x adaptation
In-Reply-To: <525922CE.6080200@ti.com>
References: <1381302753-7045-1-git-send-email-afzal@ti.com>
 <525922CE.6080200@ti.com>
Message-ID: <52668346.7010608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Saturday 12 October 2013 03:52 PM, Afzal Mohammed wrote:
> On Wednesday 09 October 2013 12:42 PM, Afzal Mohammed wrote:

>> AM43x has 224 interrupts and 7 banks, make it as maximum values. Keep
>> default values as earlier, if am43x is detected, update interrupts and
>> banks accordingly.
>>
>> Also AM43x has only one cpu, ensure that clearing bitmask at wakeupgen
>> is done only for the single existing cpu, existing code assumes that
>> there are two cpu's.
>>
>> If bitmask is cleared in wakeupgen for the nonexistent second cpu,
>> an imprecise abort happens as soon as Kernel switches to user space.
>> It was rootcaused by Sekhar Nori <nsekhar@ti.com>.
>>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> ---
>>
>> v2:
>> 1. make AM43x adaptation such that changes required for new SoC addition is less
>> 2. avoid usage of am43x local variable, use soc_is_am43xx() instead
> 
> Seems you missed this one, please consider this for the coming merge
> window. Without this AM43x would not boot to prompt.

Ping

Regards
Afzal
