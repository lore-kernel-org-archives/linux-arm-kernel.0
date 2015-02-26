From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 27 Feb 2015 05:59:05 +0900
Subject: [PATCH] ARM: exynos: Fix wrong hwirq of RTC interrupt for
 Exynos3250 SoC
In-Reply-To: <CAJKOXPcaOVC5Rpoi+27Letk4sAuoaW6vheZnCPHJgPktA-RM4g@mail.gmail.com>
References: <1423537745-11994-1-git-send-email-cw00.choi@samsung.com>
 <CAJKOXPcaOVC5Rpoi+27Letk4sAuoaW6vheZnCPHJgPktA-RM4g@mail.gmail.com>
Message-ID: <54EF8919.9010703@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/15 17:05, Krzysztof Kozlowski wrote:
> 2015-02-10 4:09 GMT+01:00 Chanwoo Choi <cw00.choi@samsung.com>:
>> This patch fixes wrong hwirq of RTC irq for Exynos3250 SoC. When entering
>> suspend state, 'enable_irq_wake fail' happen because of the mismatch of RTC hwirq.
>>
>>         [ 429.200937] Freezing user space processes ... (elapsed 0.002 seconds) done.
>>         [ 429.203383] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>>         [ 429.209914] Suspending console(s) (use no_console_suspend to debug)
>>         [ 429.370685] wake enabled for irq 65
>>         [ 429.370837] wake enabled for irq 64
>>         [ 429.370868] wake enabled for irq 79
>>         [snip]
>>         [  429.372120] s3c-rtc 10070000.rtc: enable_irq_wake failed
>>
>> Fixes: a4f582f5c5fe3 (ARM: EXYNOS: Add exynos3250 suspend-to-ram support)
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-exynos/suspend.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Yeah, I remember now Jonghwa's patches back in 2014 August and September :)
> https://lkml.org/lkml/2014/8/26/40
> https://lkml.org/lkml/2014/9/26/92
> 
> Anyway now this looks good:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
Thanks, applied.

- Kukjin
