Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5A6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:38:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF85F20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wur0+Ifc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="blDRwHh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF85F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ESNU4PMnXuGpMEnSprBc1qsdr4iny6nGopuqvsqZRYs=; b=Wur0+Ifc0qacMRJ/HEBmIVecU
	sKFEfHHGMcfefDkMFy/HTF/8oXEYNKjaLzU2zamK/U9BdWzLpOxTdOthasCy2hIzdkForZpS4A2Qr
	1HJc38iv5zJvmaJraQKLOe1rb8e5KWsIXiWuqLbTVht7RsxcRlOm7MZq1hGN0dLUn2FCnvzsZZGSF
	tHiRXtKahQdgo9pLXslCIOL1f10tBWUmBbt2fz8AlTEyyfzXPWrDALPK6LjL/ZA/Wb5/e1knMHVVO
	YI/iTBRq97FTk2g6OWPv55VJDHR3SLI9Ehn9YJKQj2WRFziFCL17XqJDbr7rEcs8GG6DMPps82wNh
	5Uw4z83Qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqmsY-0000Qx-Gw; Mon, 04 Feb 2019 22:38:14 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqmsV-0000Qc-GH
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 22:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XhKOl4CdXzp63gFI5VYkC/AWTzTO9B2+72xRjsqsRDA=; b=blDRwHh82m1iKcNJz03nLKB6SP
 a+xrnHdlLlgcWUD9Rk6s101En+k5I61TMbVDsnWzI0BXf3GBlrO85LATzwKphSB/4cS5pht9wupIY
 8JA9H6omidnd0UHrZxhg2PK43AaJFlU+KlAbOQe0J4071vSewYY4tmD/C0U/WZT+QqKcy0Ff9fWSs
 MMuVbKo4LtKV3LTBGNAPhdac/Q9SmX7Bj7U7vhe4P/7xnI6GYzPUGMmTMZ/sKo6qGpQoDyg+5Jr3T
 Zo5FjZZCTNYcWmS4bQ0du04NEovIo/ey2sGkghNOnd5agQ5/4WxM8auzjDy6J3uVwvIHEKNhNYXFm
 KTf8Zrdw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:58010 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqmYc-0007Iz-Sn; Mon, 04 Feb 2019 17:17:38 -0500
Subject: Re: [PATCH 05/35] ARM: davinci: drop irq defines from
 default_priorites
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-6-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <3038ba79-f411-9aa1-00ec-689060ed13d4@lechnology.com>
Date: Mon, 4 Feb 2019 16:21:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-6-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190204_143811_701528_3273F49F 
X-CRM114-Status: GOOD (  11.17  )
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

On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to select SPARSE_IRQ we need to make the interrupt numbers
> dynamic (at least at build-time for the top-level controller). The
> interrupt numbers are used as array indexes for irq priorities.
> 
> Drop the defines and just initialize the arrays in a linear manner.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

...

> -static u8 dm355_default_priorities[DAVINCI_N_AINTC_IRQ] = {
> -	[IRQ_DM355_CCDC_VDINT0]		= 2,
> -	[IRQ_DM355_CCDC_VDINT1]		= 6,
> -	[IRQ_DM355_CCDC_VDINT2]		= 6,
> -	[IRQ_DM355_IPIPE_HST]		= 6,
> -	[IRQ_DM355_H3AINT]		= 6,
> -	[IRQ_DM355_IPIPE_SDR]		= 6,
> -	[IRQ_DM355_IPIPEIFINT]		= 6,
> -	[IRQ_DM355_OSDINT]		= 7,
> -	[IRQ_DM355_VENCINT]		= 6,
> -	[IRQ_ASQINT]			= 6,
> -	[IRQ_IMXINT]			= 6,
> -	[IRQ_USBINT]			= 4,
> -	[IRQ_DM355_RTOINT]		= 4,
> -	[IRQ_DM355_UARTINT2]		= 7,
> -	[IRQ_DM355_TINT6]		= 7,
> -	[IRQ_CCINT0]			= 5,	/* dma */
> -	[IRQ_CCERRINT]			= 5,	/* dma */
> -	[IRQ_TCERRINT0]			= 5,	/* dma */
> -	[IRQ_TCERRINT]			= 5,	/* dma */
> -	[IRQ_DM355_SPINT2_1]		= 7,
> -	[IRQ_DM355_TINT7]		= 4,
> -	[IRQ_DM355_SDIOINT0]		= 7,
> -	[IRQ_MBXINT]			= 7,
> -	[IRQ_MBRINT]			= 7,
> -	[IRQ_MMCINT]			= 7,
> -	[IRQ_DM355_MMCINT1]		= 7,
> -	[IRQ_DM355_PWMINT3]		= 7,
> -	[IRQ_DDRINT]			= 7,
> -	[IRQ_AEMIFINT]			= 7,
> -	[IRQ_DM355_SDIOINT1]		= 4,
> -	[IRQ_TINT0_TINT12]		= 2,	/* clockevent */
> -	[IRQ_TINT0_TINT34]		= 2,	/* clocksource */
> -	[IRQ_TINT1_TINT12]		= 7,	/* DSP timer */
> -	[IRQ_TINT1_TINT34]		= 7,	/* system tick */
> -	[IRQ_PWMINT0]			= 7,
> -	[IRQ_PWMINT1]			= 7,
> -	[IRQ_PWMINT2]			= 7,
> -	[IRQ_I2C]			= 3,
> -	[IRQ_UARTINT0]			= 3,
> -	[IRQ_UARTINT1]			= 3,
> -	[IRQ_DM355_SPINT0_0]		= 3,
> -	[IRQ_DM355_SPINT0_1]		= 3,
> -	[IRQ_DM355_GPIO0]		= 3,
> -	[IRQ_DM355_GPIO1]		= 7,
> -	[IRQ_DM355_GPIO2]		= 4,
> -	[IRQ_DM355_GPIO3]		= 4,
> -	[IRQ_DM355_GPIO4]		= 7,
> -	[IRQ_DM355_GPIO5]		= 7,
> -	[IRQ_DM355_GPIO6]		= 7,
> -	[IRQ_DM355_GPIO7]		= 7,
> -	[IRQ_DM355_GPIO8]		= 7,
> -	[IRQ_DM355_GPIO9]		= 7,
> -	[IRQ_DM355_GPIOBNK0]		= 7,
> -	[IRQ_DM355_GPIOBNK1]		= 7,
> -	[IRQ_DM355_GPIOBNK2]		= 7,
> -	[IRQ_DM355_GPIOBNK3]		= 7,
> -	[IRQ_DM355_GPIOBNK4]		= 7,
> -	[IRQ_DM355_GPIOBNK5]		= 7,
> -	[IRQ_DM355_GPIOBNK6]		= 7,
> -	[IRQ_COMMTX]			= 7,
> -	[IRQ_COMMRX]			= 7,
> -	[IRQ_EMUINT]			= 7,
> +static u8 dm355_aintc_prios[] = {
> +	2, 6, 6, 6, 6, 6, 6, 7,
> +	6, 6, 6, 4, 4, 7, 7, 5,
> +	5, 5, 5, 7, 4, 7, 7, 7,
> +	7, 7, 7, 7, 7, 4, 2, 2,
> +	7, 7, 7, 7, 7, 3, 3, 3,
> +	3, 3, 3, 7, 4, 4, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 0, 0,
>   };

Hmm... this makes it harder to see what is going on here.
You can no longer see which priority corresponds to which
IRQ without consulting a manual.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
