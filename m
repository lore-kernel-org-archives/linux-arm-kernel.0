Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5840C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:18:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EB72175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FvhtBU+j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="baffNN5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EB72175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0gKuw1rGrZpl3uQVa6fVKl4D3vhMnUJqmGFZKQq2ofE=; b=FvhtBU+j3ByYKmYiNtjInMeUt
	9VN+MoY5ulJhNCaabsavamE1nLbU1wiEUfjhhKRfjmRURSWOJ+Vqt9z3PWHWC9Z0jYOdVelgNwYTI
	QTzc+H8/L2Mq+qHXRprPOlmEmS+XG6VO7d2ez52DRaQXXGGSBRz5G0PgO1jPiHYlUsATOylR+PGBv
	XHYiiTvqA9yRpmrGgNo1JW0RJyTxAvFh4aYiAafBCqnyGC+pMrKs2/vi/ybW8JfW7ATMS7UzQ/5am
	gKhHlutJFsCKxLDDmKyA4UDYVyCusvrHHgrgE/mbpZRVSooB35hsyu/yxwXkP0qqtmVhb2vWUuef9
	BIXySo2bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqqJx-0003FA-VJ; Tue, 05 Feb 2019 02:18:45 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqqJu-0003Ee-TD
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 02:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8yKYhikQZxCUa/cCc0k1fLcffd+7gOuz7prbBCzKXrw=; b=baffNN5q3Q/aiNryDJRQaOooJP
 OJKUJUiGzX2IZm0+MlVdeh21v43M7OI8ApJOmjOdwWEeZ5cSWR9c5I2j4r10oH84lTtfpdH8vFCI8
 EXmZgqVW38jiW06rDLzm1gvXBUokTRxl5yN0/AmRSFTfIHmOza4PyiDo9QeKJ3G7UQ71rt+aZ1xPu
 Z2p6k4372eh8tjDouLYFXTC6tVQ+e9Gpr1OqnpSxqyczuPOUicDOL67gJRPg4EbaVTvSYvN4Zwc4t
 +Pe1fKXM8bfKHGUM1p0I8MLy735I5sfIdH8XkQUOUuJMUI9+a6BLgFHjEiZMmmjpfpNYfaFGF8o6E
 FrDEEx+Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:34230 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqqGO-0004Oe-Mm; Mon, 04 Feb 2019 21:15:04 -0500
Subject: Re: [PATCH v2 04/12] ARM: davinci: WARN_ON() if clk_get() fails
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-5-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <0750392d-e298-b467-24c0-3c2779ead3f7@lechnology.com>
Date: Mon, 4 Feb 2019 20:18:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-5-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190204_181843_029653_E3DEF38C 
X-CRM114-Status: GOOD (  14.61  )
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
> Currently the timer code checks if the clock pointer passed to it is
> good (!IS_ERR(clk)). The new clocksource driver expects the clock to
> be functional and doesn't perform any checks so emit a warning if
> clk_get() fails. Apply this to all davinci platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/da830.c  | 4 ++++
>   arch/arm/mach-davinci/da850.c  | 4 ++++
>   arch/arm/mach-davinci/dm355.c  | 4 ++++
>   arch/arm/mach-davinci/dm365.c  | 4 ++++
>   arch/arm/mach-davinci/dm644x.c | 4 ++++
>   arch/arm/mach-davinci/dm646x.c | 4 ++++
>   6 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
> index 2cc9fe4c3a91..9a4b749cbb6b 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
> @@ -834,6 +834,10 @@ void __init da830_init_time(void)
>   	da830_pll_init(NULL, pll, NULL);
>   
>   	clk = clk_get(NULL, "timer0");
> +	if (WARN_ON(IS_ERR(clk))) {
> +		pr_err("Unable to get the timer clock\n");

Do we really need a warning _and_ an error?

> +		return;
> +	}
>   
>   	davinci_timer_init(clk);
>   }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
