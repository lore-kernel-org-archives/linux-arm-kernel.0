Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B93EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:36:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC60F2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hX+P6ZfK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="fygHnP8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC60F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rxEvpTji4dn1SjVm25FlZ2dQsZXC6/nXXBDUYK1qTo0=; b=hX+P6ZfKunh4/rClUp7KomRQw
	K9AzRA0GY+pWtKWSgP7fMiZpTHyM781EoacZZedQj5z32wVbNynAJr4en0zZftA+2Sba3qpFZ0eYG
	7FFCkvtVuKBhxCmzOtkFucRwigZtrlzo4IpJZVnocUzUopgu6XvVdzqlfXNWAei6xHBAm0WPtVPyu
	ToNob3M9/enUqzc7tVhzfewPx0MwQrYIIrUNWeoC+V7XoD9FHITfvSrWOFF9BQ6cp6tqsB8+W4OEp
	X93nN0rlpDFSJ0W0CHVAiWlyqBhAed2F3Kwn7t3BuSUBhX7qsCdL8UOu40vYimN3QuxTBQ9KODmF4
	rtPrLOX4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqnmr-0007Fd-Qm; Mon, 04 Feb 2019 23:36:25 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqnmo-0007FD-Hq
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:36:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eb0ZG8v8r3bCjDvb54kSzX+h/kvulFzQqLtjuHRPPBs=; b=fygHnP8cORb+5p4iCytIl/0NMl
 rwIsy0yO4euvPRloZL+9xntVfysf+W1hBlSs7pvdOa1LlDGD8o9y4DiZmxdVEZo3Tn/EIVBTkth8m
 XQWBxRB9J6pdDwYh/XPKqlOBLF8uJxZksGHgB82B/OHmcml0554zAhIpExYl6U72lSdOQWoytVjlf
 zRyWRcspDjtBEX827S0Pet1jcop9xWRgh2J6uy5JppuYqgbx3GlSSuQ0Xs/vlSMb+WUrlFi6/tM88
 0uCnGfIXjfISiWuJOr+TvXet+dmlwvLjdXlEe1iHM81j4RKLaivKp5t1tiVhQRFB+sbFQ3UgJtV1f
 SWOdMfSw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:59464 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqnjJ-0004FJ-9A; Mon, 04 Feb 2019 18:32:45 -0500
Subject: Re: [PATCH 16/35] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-17-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <52207e26-e02e-c903-d057-9473e9ee2828@lechnology.com>
Date: Mon, 4 Feb 2019 17:36:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-17-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190204_153622_673693_F2D2C875 
X-CRM114-Status: GOOD (  17.97  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> I've been unable to figure out exactly why, but it seems that the
> IRQ_TINT1_TINT34 interrupt for timer 1 needs to be handled as a
> level irq, not edge like all others.
> 
> This timer is used by the dsp on dm64* boards only.
> 
> Let's move the handler setup out of the aintc driver where it's lived
> since the beginning and into the dm64* SoC-specific files where it
> belongs.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/dm644x.c | 4 ++++
>   arch/arm/mach-davinci/dm646x.c | 4 ++++
>   arch/arm/mach-davinci/irq.c    | 1 -
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
> index 24ad7a09aa15..beb97101c881 100644
> --- a/arch/arm/mach-davinci/dm644x.c
> +++ b/arch/arm/mach-davinci/dm644x.c
> @@ -14,6 +14,7 @@
>   #include <linux/clkdev.h>
>   #include <linux/dmaengine.h>
>   #include <linux/init.h>
> +#include <linux/irq.h>
>   #include <linux/irqchip/irq-davinci-aintc.h>
>   #include <linux/platform_data/edma.h>
>   #include <linux/platform_data/gpio-davinci.h>
> @@ -616,6 +617,9 @@ void __init dm644x_init_time(void)
>   	void __iomem *pll1, *psc;
>   	struct clk *clk;
>   
> +	/* Needed by the dsp. */
> +	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);

Does this actually need to be called before the clocks are inited?
If not, it would seem more logical to have this right before
davinci_timer_init().

Also, since the IRQ_TINT1_TINT34 macro is removed later, the comment
could do a better job explaining what it is doing.


> +
>   	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
>   
>   	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_1K);
> diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
> index ab02cc93813a..70505c92d5fb 100644
> --- a/arch/arm/mach-davinci/dm646x.c
> +++ b/arch/arm/mach-davinci/dm646x.c
> @@ -15,6 +15,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/dmaengine.h>
>   #include <linux/init.h>
> +#include <linux/irq.h>
>   #include <linux/irqchip/irq-davinci-aintc.h>
>   #include <linux/platform_data/edma.h>
>   #include <linux/platform_data/gpio-davinci.h>
> @@ -599,6 +600,9 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
>   	void __iomem *pll1, *psc;
>   	struct clk *clk;
>   
> +	/* Needed by the dsp. */
> +	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);

same here.

> +
>   	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
>   	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
>   
> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index d67f443a471d..2e114ad83adc 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -142,6 +142,5 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
>   		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
>   				       irq_base + irq_off, 32);
>   
> -	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
>   	set_handle_irq(davinci_aintc_handle_irq);
>   }
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
