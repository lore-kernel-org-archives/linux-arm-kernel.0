Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0549C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:31:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6099D2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fqsPcnk/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nh91QHfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6099D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EIz2nBdALXZNYIdUWVOQwxTcHgxlPcUD4OncmAauKDM=; b=fqsPcnk/r/ZKG2
	cC99u54qeOgLZOBy3scgo0xSC4xJnDAl53E9Q90d61GhYQ0dWtKoa2V/uwTxmMrXNqbAavtl97bWL
	iHRRIZtSRIQzS+bFAI93jI+OQu4M4V51WnlThuWWPqL4YU4gJp6KjG4Sc2czuCh9ADJd/bacLalQF
	kKc6y/wNbM+abs/1KqgRgd+bHb72gNwn+TECTSLmYTOjSBmTPPeAnF/ugw/5D2gWSi01ZxgnsISkE
	CRphFGZofvcTuHZkFBiCt9NQDpDalcqiuGIDW1IZdvbMk1uQV3nUqSoMFlvwji9xSOgMlsAatu5o+
	lqW7j2bUMiWlafACwJ1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbjB-0005tC-3L; Fri, 01 Feb 2019 16:31:41 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbj8-0005sp-OS
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:31:40 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c54744d0000>; Fri, 01 Feb 2019 08:31:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 08:31:38 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 08:31:38 -0800
Received: from [10.26.11.142] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 16:31:35 +0000
Subject: Re: [PATCH V6 2/7] clocksource: tegra: add Tegra210 timer support
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-3-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0272983e-bbff-601e-67fa-2cb9e852a68c@nvidia.com>
Date: Fri, 1 Feb 2019 16:31:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201161654.18315-3-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549038669; bh=Z3TBZLUsIQJVIrzd6oArMDFQiN6OmVKCFtkPHZXblVQ=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=nh91QHfT/JL0gSkjMgFgDnxjZWeOdzBhKay+bXhrwYzZx0fouti5KJ9Tq7fo+wqDp
 cLMA3LXvTurBCd8vAK8Z9GpfKWh+NNw3/p6y79IkCXDMk0usKMnTcZGtUhBboQPBY/
 iIXCFj5qaHkFIc/2fVnZwER4jeiCeAoc1qvnSfoMcUAkur1EJId+QwjWdr4+rMSVsz
 cbUzESKU2bfjRrUfga04dECuOoMOGsDKldmM8GVIKvrdgRwqOxOJMrHMqo//dCVArc
 mdg+DeRs1zjxOUf4xve+7YqO1+A+L02gkQAyP8QJtr5Bp8Pyp2Il62MrpDxsTSV1l4
 vIbyPo4YHvVzA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_083138_807930_F9F07275 
X-CRM114-Status: GOOD (  18.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 01/02/2019 16:16, Joseph Lo wrote:
> Add support for the Tegra210 timer that runs at oscillator clock
> (TMR10-TMR13). We need these timers to work as clock event device and to
> replace the ARMv8 architected timer due to it can't survive across the
> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
> source when CPU suspends in power down state.
> 
> Also convert the original driver to use timer-of API.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> v6:
>  * refine the timer defines
>  * add ack tag from Jon.
> v5:
>  * add ack tag from Thierry
> v4:
>  * merge timer-tegra210.c in previous version into timer-tegra20.c
> v3:
>  * use timer-of API
> v2:
>  * add error clean-up code
> ---
>  drivers/clocksource/Kconfig         |   2 +-
>  drivers/clocksource/timer-tegra20.c | 371 ++++++++++++++++++++--------
>  include/linux/cpuhotplug.h          |   1 +
>  3 files changed, 270 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a9e26f6a81a1..6af78534a285 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -131,7 +131,7 @@ config SUN5I_HSTIMER
>  config TEGRA_TIMER
>  	bool "Tegra timer driver" if COMPILE_TEST
>  	select CLKSRC_MMIO
> -	depends on ARM
> +	select TIMER_OF
>  	help
>  	  Enables support for the Tegra driver.
>  
> diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
> index 4293943f4e2b..f66edd63d7f4 100644
> --- a/drivers/clocksource/timer-tegra20.c
> +++ b/drivers/clocksource/timer-tegra20.c
> @@ -15,21 +15,24 @@
>   *
>   */
>  
> -#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/time.h>
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/clockchips.h>
> -#include <linux/clocksource.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/sched_clock.h>
> -#include <linux/delay.h>
> +#include <linux/percpu.h>
> +#include <linux/syscore_ops.h>
> +#include <linux/time.h>
> +
> +#include "timer-of.h"
>  
> +#ifdef CONFIG_ARM
>  #include <asm/mach/time.h>
> +#endif
>  
>  #define RTC_SECONDS            0x08
>  #define RTC_SHADOW_SECONDS     0x0c
> @@ -39,74 +42,145 @@
>  #define TIMERUS_USEC_CFG 0x14
>  #define TIMERUS_CNTR_FREEZE 0x4c
>  
> -#define TIMER1_BASE 0x0
> -#define TIMER2_BASE 0x8
> -#define TIMER3_BASE 0x50
> -#define TIMER4_BASE 0x58
> -
> -#define TIMER_PTV 0x0
> -#define TIMER_PCR 0x4
> -
> +#define TIMER_PTV		0x0
> +#define TIMER_PTV_EN		BIT(31)
> +#define TIMER_PTV_PER		BIT(30)
> +#define TIMER_PCR		0x4
> +#define TIMER_PCR_INTR_CLR	BIT(30)
> +
> +#ifdef CONFIG_ARM
> +#define TIMER_CPU0		0x50 /* TIMER3 */
> +#else
> +#define TIMER_CPU0		0x90 /* TIMER10 */
> +#define TIMER10_IRQ_IDX		10
> +#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
> +#endif
> +#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)

So maybe I was not being clear, but what I meant was you replace
'IRQ_IDX_FOR_CPU(cpu)' with 'TIMER_FOR_CPU(cpu), because technically, we
just need to know the timer index being used for a given CPU to lookup
the associated interrupt. And so I was suggesting you make a generic
macro that could be used for both 32-bit and 64-bit ARM. However, given
that currently we do not need/use this for 32-bit ARM it is really a
mute point.

However, don't bother changing this now and you have included my ACK, so
we are all good.

Thanks!
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
