Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63575C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:39:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32531218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uYaDowrp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hMwyHfxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32531218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Cqv5C7eVumQi01tY2wj5BTC3yHY9wF4RBrT2pvI+86I=; b=uYaDowrpIy4izu4LpsldypLiE
	pdxMqpGZnQcDm3Sczreb0OAph/ChoVCpJyVysAbhX6FrDDiX5avJPl5FJXbEDV3856KZI1ypbk0yu
	t1/2wMk7Rs8Leq0FeAQ9v8SlR7BmbimKjKqdgxZn1IWU4DMLhWNHdaUjfeFD2+FOtcKfI0Uzmit26
	meM4DOmeq21OhHQyCqgPADtkwg2UCIawzNfDWG9r+bbp8I22+eSFt2lW5jD1j7ElBxXD0gH56HHdg
	yOgAbg+GKgxBbv+HcJZ66DmyzaLEl9dWBNx7tzjruzaTaHbLPAsWwTvWuQBLHuvLuHbaf5oX5YoYL
	KweTyFS7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZyz-0004Kg-VZ; Fri, 01 Feb 2019 14:39:53 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZyx-0004KL-3q
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:39:52 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c545a0c0000>; Fri, 01 Feb 2019 06:39:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 06:39:50 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 06:39:50 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 14:39:48 +0000
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <5490ad66-7d20-7093-7025-1d0ec8da6dec@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <3c9b86ba-32dd-76b2-9a51-6cd86782cadf@nvidia.com>
Date: Fri, 1 Feb 2019 22:39:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5490ad66-7d20-7093-7025-1d0ec8da6dec@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549031948; bh=EL4s8J9EU1lgweojudTQigL7fn7EhHyYwrggAt8RS8Y=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=hMwyHfxanluywANsNqTLCc+bZZS1DSp1Fu/B1V8K6xV0wsqWaNZdn6zjZjeQBgWpN
 hgdHCb38NlobVxsk7HnXLvPyqG3aut2Q2KnInPoxvb5u6YVrZ7nT6JAA5gbHTG6a92
 Anc6aIDkthHPZsug+hl19+V50C/RrEApGzNvVBaaP7BHNMin9KdrKfuaVYKmiE0LIF
 HhFTy+xXQ9l2y3k6aiz9+V69XRfQWRMjfGJBRNqWGBubetZUoRiux0fYAkUN/7FQnf
 ObKiO06CLaNjX5idF50MCCSBvTwDybB4u1ZtBUHAFGsNn6+VJoYnJ4JjGigFAte/LE
 jnZA6sM4CIgUA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_063951_169364_6AF0F87B 
X-CRM114-Status: GOOD (  20.18  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/1/19 8:44 PM, Jon Hunter wrote:
> 
> On 01/02/2019 03:36, Joseph Lo wrote:
>> Add support for the Tegra210 timer that runs at oscillator clock
>> (TMR10-TMR13). We need these timers to work as clock event device and to
>> replace the ARMv8 architected timer due to it can't survive across the
>> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
>> source when CPU suspends in power down state.
>>
>> Also convert the original driver to use timer-of API.
> 
> It may have been nice to split this into 2 patches to make it easier to
> see what is going on but not a big deal.
> 
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>> v5:
>>   * add ack tag from Thierry
>> v4:
>>   * merge timer-tegra210.c in previous version into timer-tegra20.c
>> v3:
>>   * use timer-of API
>> v2:
>>   * add error clean-up code
>> ---
>>   drivers/clocksource/Kconfig         |   2 +-
>>   drivers/clocksource/timer-tegra20.c | 369 ++++++++++++++++++++--------
>>   include/linux/cpuhotplug.h          |   1 +
>>   3 files changed, 272 insertions(+), 100 deletions(-)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index a9e26f6a81a1..6af78534a285 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -131,7 +131,7 @@ config SUN5I_HSTIMER
>>   config TEGRA_TIMER
>>   	bool "Tegra timer driver" if COMPILE_TEST
>>   	select CLKSRC_MMIO
>> -	depends on ARM
>> +	select TIMER_OF
>>   	help
>>   	  Enables support for the Tegra driver.
>>   
>> diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
>> index 4293943f4e2b..96a809341c9b 100644
>> --- a/drivers/clocksource/timer-tegra20.c
>> +++ b/drivers/clocksource/timer-tegra20.c
>> @@ -15,21 +15,24 @@
>>    *
>>    */
>>   
>> -#include <linux/init.h>
>> +#include <linux/clk.h>
>> +#include <linux/clockchips.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/delay.h>
>>   #include <linux/err.h>
>> -#include <linux/time.h>
>>   #include <linux/interrupt.h>
>> -#include <linux/irq.h>
>> -#include <linux/clockchips.h>
>> -#include <linux/clocksource.h>
>> -#include <linux/clk.h>
>> -#include <linux/io.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_irq.h>
>> -#include <linux/sched_clock.h>
>> -#include <linux/delay.h>
>> +#include <linux/percpu.h>
>> +#include <linux/syscore_ops.h>
>> +#include <linux/time.h>
>> +
>> +#include "timer-of.h"
>>   
>> +#ifdef CONFIG_ARM
>>   #include <asm/mach/time.h>
>> +#endif
>>   
>>   #define RTC_SECONDS            0x08
>>   #define RTC_SHADOW_SECONDS     0x0c
>> @@ -43,70 +46,147 @@
>>   #define TIMER2_BASE 0x8
>>   #define TIMER3_BASE 0x50
>>   #define TIMER4_BASE 0x58
>> -
>> -#define TIMER_PTV 0x0
>> -#define TIMER_PCR 0x4
>> -
>> +#define TIMER10_BASE 0x90
>> +
>> +#define TIMER_PTV		0x0
>> +#define TIMER_PTV_EN		BIT(31)
>> +#define TIMER_PTV_PER		BIT(30)
>> +#define TIMER_PCR		0x4
>> +#define TIMER_PCR_INTR_CLR	BIT(30)
>> +
>> +#ifdef CONFIG_ARM
>> +#define TIMER_BASE TIMER3_BASE
>> +#else
>> +#define TIMER_BASE TIMER10_BASE
>> +#endif
>> +#define TIMER10_IRQ_IDX		10
>> +#define TIMER_FOR_CPU(cpu) (TIMER_BASE + (cpu) * 8)
>> +#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
> 
> TIMER10_IRQ_IDX and IRQ_IDX_FOR_CPU are only applicable to ARM64 and so
> we should probably not defined for ARM to avoid any confusion.
Okay, will do.
> 
> Furthermore, a lot of these TIMERx_BASE definitions are unused AFAICT.
> Would be good to get rid of these.

Okay.
> 
> Maybe we could just have ...
> 
>   +#ifdef CONFIG_ARM
>   +#define TIMER_CPU0 3
>   +#else
>   +#define TIMER_CPU0 10
>   +#endif
>   +#define TIMER_BASE_FOR_CPU(cpu) ((TIMER_CPU0 + cpu) * 8)
>   +#define TIMER_FOR_CPU(cpu) (TIMER_CPU0 + cpu)
> 
This can't get the timer base address. I think you mean ...

+#ifdef CONFIG_ARM
+#define TIMER_CPU0 0x50 /* TIMER3 */
+#else
+#define TIMER_CPU0 0x90 /* TIMER10 */
+#endif
+#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)

This doesn't need.
+#define TIMER_FOR_CPU(cpu) (TIMER_CPU0 + cpu)

Will fix above accordingly and adding your ack tag.

Thanks,
Joseph

> Otherwise looks good to me.
> 
> Cheers
> Jon
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
