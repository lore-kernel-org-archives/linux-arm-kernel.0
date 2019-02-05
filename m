Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEECC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:35:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AADFF20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RcxM8BWX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="UvRZyPdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADFF20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qlu9z8DfUCPRN25MYx2M2eXxPipHgu033HoKQ9dGS68=; b=RcxM8BWXTNhkhyaVEZKPAPW1K
	DV+MnNwhLU4xU4RhIZJgbe3nWgmDj1r/RCaxIHPZnclZmgXztVqDKnsWCygiWVSp5q60vVQlA2xsT
	P7m9fbWYRjp4D9pM5QSorP7Rs6/GAMZpd7SOWUhO0XoRHPn86rbi7zpubgl6GUK7RbeOBQfrwGGGT
	Q1+QaWItNERk9Fw6sp99X1/azdycYzU0VbC6+VPQDLxibNR50wg8Q4D7Mb0tcP85zN2thK+Nanz4d
	E9vHgtFLM/yBXY0JAru0XvPD0LovaPjMrxWrOwC0m1IOAw+ygFzfIkFAYdW/muNrtAgW9RcXUAxFh
	yRh9gnAsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqqZo-0000zw-Vp; Tue, 05 Feb 2019 02:35:08 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqqZk-0000Nu-Qj
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 02:35:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o8gGRWf59cyRZsvPEqA4uv74EkuRfZCPhPw5Hbj5SIs=; b=UvRZyPdUu9FGf9Qdg3dBMqAlgy
 Yy6ZIHqbfoz7fWdzlH+cRQ9dj/J3+1SEK4vAnLgTJPCo+YMDYGYltk6qP8MCOG70Dnqp4YTc0bIwi
 EvcGMgqTbabXeWfKwFSCZkqYsaHAv5UA+VJ8vn1yLI0o+8OM79QflBS8DkvkyFkiLaI6teseOzkSN
 SUWfdNDe0VTQjvR4P6Q1QVDgxn8pB0sprVL4rtyAgrXxIMh3XqrS5nj032KrtyuzdKOJA/I+UtrLI
 VYp0NOS3sljPcis+IHq8Yzhlo5LIoxk8ezS0n2o4J3WtCVC8Dut/qZT5CXe2m+RFfsGu2/Pgs6rbL
 Cn4xn+oQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:34516 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqqWF-0007z5-1j; Mon, 04 Feb 2019 21:31:27 -0500
Subject: Re: [PATCH v2 05/12] ARM: davinci: da850: switch to using the
 clocksource driver
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-6-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <8baa1707-aaea-ef83-839f-be23787d0312@lechnology.com>
Date: Mon, 4 Feb 2019 20:35:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-6-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_183505_037694_702EE900 
X-CRM114-Status: GOOD (  18.58  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/4/19 11:17 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now have a proper clocksource driver for davinci. Switch the platform
> to using it.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/da850.c | 56 ++++++++++++++---------------------
>   1 file changed, 22 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index beb34ee42e3a..66c2ffd4885b 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -34,7 +34,8 @@
>   #include <mach/da8xx.h>
>   #include <mach/irqs.h>
>   #include <mach/pm.h>
> -#include <mach/time.h>
> +
> +#include <clocksource/timer-davinci.h>
>   
>   #include "mux.h"
>   
> @@ -436,38 +437,24 @@ static struct davinci_id da850_ids[] = {
>   	},
>   };
>   
> -static struct davinci_timer_instance da850_timer_instance[4] = {
> -	{
> -		.base		= DA8XX_TIMER64P0_BASE,
> -		.bottom_irq	= IRQ_DA8XX_TINT12_0,
> -		.top_irq	= IRQ_DA8XX_TINT34_0,
> -	},
> -	{
> -		.base		= DA8XX_TIMER64P1_BASE,
> -		.bottom_irq	= IRQ_DA8XX_TINT12_1,
> -		.top_irq	= IRQ_DA8XX_TINT34_1,
> -	},
> -	{
> -		.base		= DA850_TIMER64P2_BASE,
> -		.bottom_irq	= IRQ_DA850_TINT12_2,
> -		.top_irq	= IRQ_DA850_TINT34_2,
> -	},
> -	{
> -		.base		= DA850_TIMER64P3_BASE,
> -		.bottom_irq	= IRQ_DA850_TINT12_3,
> -		.top_irq	= IRQ_DA850_TINT34_3,
> +static const struct davinci_timer_cfg da850_timer_cfg = {
> +	.reg = {
> +		.start		= DA8XX_TIMER64P0_BASE,
> +		.end		= DA8XX_TIMER64P0_BASE + SZ_4K,

Missing minus one?

+		.end		= DA8XX_TIMER64P0_BASE + SZ_4K - 1,


> +		.flags		= IORESOURCE_MEM,
>   	},
> -};
> -
> -/*
> - * T0_BOT: Timer 0, bottom		: Used for clock_event
> - * T0_TOP: Timer 0, top			: Used for clocksource
> - * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
> - */
> -static struct davinci_timer_info da850_timer_info = {
> -	.timers		= da850_timer_instance,
> -	.clockevent_id	= T0_BOT,
> -	.clocksource_id	= T0_TOP,
> +	.irq = {
> +		{

It would be nice to use the enum values from <clocksource/timer-davinci.h>
here so we know which IRQ is which.

		[DAVINCI_TIMER_CLOCKEVENT_IRQ] = {

> +			.start	= IRQ_DA8XX_TINT12_0,
> +			.end	= IRQ_DA8XX_TINT12_0,

Can .end be omitted since it is the same as .start?

> +			.flags	= IORESOURCE_IRQ,
> +		},
> +		{

		[DAVINCI_TIMER_CLOCKSOURCE_IRQ] = {

> +			.start	= IRQ_DA8XX_TINT34_0,
> +			.end	= IRQ_DA8XX_TINT34_0,
> +			.flags	= IORESOURCE_IRQ,
> +		}
> +	}
>   };
>   
>   #ifdef CONFIG_CPU_FREQ
> @@ -742,7 +729,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
>   	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
>   	.intc_irq_prios		= da850_default_priorities,
>   	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
> -	.timer_info		= &da850_timer_info,
>   	.emac_pdata		= &da8xx_emac_pdata,
>   	.sram_dma		= DA8XX_SHARED_RAM_BASE,
>   	.sram_len		= SZ_128K,
> @@ -765,6 +751,7 @@ void __init da850_init_time(void)
>   	void __iomem *pll0;
>   	struct regmap *cfgchip;
>   	struct clk *clk;
> +	int rv;

bikeshed: int ret; and int err; are used way more often, so rv looks
strange to me.

>   
>   	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
>   
> @@ -779,7 +766,8 @@ void __init da850_init_time(void)
>   		return;
>   	}
>   
> -	davinci_timer_init(clk);
> +	rv = davinci_timer_register(clk, &da850_timer_cfg);
> +	WARN(rv, "Unable to register the timer: %d\n", rv);
>   }
>   
>   static struct resource da850_pll1_resources[] = {
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
