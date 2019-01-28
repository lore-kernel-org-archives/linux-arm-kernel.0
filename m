Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7B7C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:06:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E503620882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k4j0xuJB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjhfuOYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E503620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ck3tbYlFP7fNw5VNQDxjpavsOYpb//mhN530dDSnbiA=; b=k4j0xuJBB5VXWk
	EBM9LQiGpg7c0veLfs8tv/5C5cY5ce0aCKfZzE/VO1KsKOxRxiaTjLmqNIvomSo/ITV905y9Jrppu
	YbGa2e0KTJG+/eNFQ20Cp0KYvxrQfE5S3rb/XoEEm4H8PhBtubIUfB8xE7fYJgQQ0Cm9chZqS+a88
	vsDWKZ2mKVX15tn3mHLNbFKrJX20Woyceipal94m+sKm2SgdfNxSN4cWlE+SunbEqzJv/F1chR5xs
	8x3NX8wZFHopNaq4tDlreLXHAi0Rcj2i8SZfUB2f0XI5TGviY/EFww1Am9vvO8xmBfZUrxkUAEZKg
	TQQlu6WrQRGezGDI7w6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4jm-0005tF-QW; Mon, 28 Jan 2019 11:05:58 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4ji-0005sR-67
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:05:55 +0000
Received: by mail-wm1-x342.google.com with SMTP id g67so13395445wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 03:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PB5pA5GKrN7y5OVHQcaOfdCOpg8Wl9SqU/L08GFqYsk=;
 b=QjhfuOYV8OofV2CJMprEm3LwJBR/f9YUZUpjS7rDuSciyY7uWnNShK1A++iahgx4oH
 DoTb9pj01Y/TP5Rve3jO7oOVmuUFW0GmrkGX95iwdENhUntGrHOZAYjLzUzOx2NKKtE0
 tVOzbnCavJskGdU7gJskYdCkL86j7WAmLeSEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PB5pA5GKrN7y5OVHQcaOfdCOpg8Wl9SqU/L08GFqYsk=;
 b=H1JA+sB1tyOJhtT1KHSkOAu9j6pc02nHX3EkfmZA1OhhHOrSiphO/1LJEalLnU3tFB
 NgmyXVsqRipFGSN/+tj3JL4SiHa1ydMqFp6EEkRL7HEJYpiU/LTT+UdKG3W1hOTNYJvz
 EqFbwcpUz3k++/V46Vy0maKygxnGJyAC8sso8GoJQ+GIsRNT+NO0jatWuQHwXQSEBdAs
 aGx+jO37xWW2kG/HwzQOPaPf5Rzm/OxNyIhD1vhNAMfEKBHCw29AZbow071W/JWm39C8
 PFD0n7Gfq/K9jDgPMso2ZdktxQu9oIuKQdScbLp0eT4UBKAztZxBPooVE6ZNiMfJ0eV1
 qNmQ==
X-Gm-Message-State: AJcUukeHXrffycg4oMk1Q3+2vdHYEpofR1ZCh3Yga+hB3/WfBJ49oPyI
 f6HE1hdL8GttbSUEuNuK79YWmQ==
X-Google-Smtp-Source: ALg8bN4WCVRmPU+sOcpK9CFgRVVrDrZS1cFJuVU5CYSXY3XhObbuAVvbTj8r2rgPWdNW0QyfKTofDA==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr16506937wmf.22.1548673551767; 
 Mon, 28 Jan 2019 03:05:51 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id j24sm139989260wrd.86.2019.01.28.03.05.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 03:05:50 -0800 (PST)
Date: Mon, 28 Jan 2019 11:05:48 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] backlight: pwm_bl: Use gpiod_get_value_cansleep() to get
 initial state
Message-ID: <20190128110548.lqjgzxrppmezwtki@holly.lan>
References: <20190127145054.3770-1-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190127145054.3770-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_030554_234055_7CB71CC3 
X-CRM114-Status: GOOD (  19.83  )
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
Cc: linux-pwm@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 27, 2019 at 10:50:54PM +0800, Chen-Yu Tsai wrote:
> gpiod_get_value() gives out a warning if access to the underlying gpiochip
> requires sleeping, which is common for I2C based chips:
> 
>     WARNING: CPU: 0 PID: 77 at drivers/gpio/gpiolib.c:2500 gpiod_get_value+0xd0/0x100
>     Modules linked in:
>     CPU: 0 PID: 77 Comm: kworker/0:2 Not tainted 4.14.0-rc3-00589-gf32897915d48-dirty #90
>     Hardware name: Allwinner sun4i/sun5i Families
>     Workqueue: events deferred_probe_work_func
>     [<c010ec50>] (unwind_backtrace) from [<c010b784>] (show_stack+0x10/0x14)
>     [<c010b784>] (show_stack) from [<c0797224>] (dump_stack+0x88/0x9c)
>     [<c0797224>] (dump_stack) from [<c0125b08>] (__warn+0xe8/0x100)
>     [<c0125b08>] (__warn) from [<c0125bd0>] (warn_slowpath_null+0x20/0x28)
>     [<c0125bd0>] (warn_slowpath_null) from [<c037069c>] (gpiod_get_value+0xd0/0x100)
>     [<c037069c>] (gpiod_get_value) from [<c03778d0>] (pwm_backlight_probe+0x238/0x508)
>     [<c03778d0>] (pwm_backlight_probe) from [<c0411a2c>] (platform_drv_probe+0x50/0xac)
>     [<c0411a2c>] (platform_drv_probe) from [<c0410224>] (driver_probe_device+0x238/0x2e8)
>     [<c0410224>] (driver_probe_device) from [<c040e820>] (bus_for_each_drv+0x44/0x94)
>     [<c040e820>] (bus_for_each_drv) from [<c040ff0c>] (__device_attach+0xb0/0x114)
>     [<c040ff0c>] (__device_attach) from [<c040f4f8>] (bus_probe_device+0x84/0x8c)
>     [<c040f4f8>] (bus_probe_device) from [<c040f944>] (deferred_probe_work_func+0x50/0x14c)
>     [<c040f944>] (deferred_probe_work_func) from [<c013be84>] (process_one_work+0x1ec/0x414)
>     [<c013be84>] (process_one_work) from [<c013ce5c>] (worker_thread+0x2b0/0x5a0)
>     [<c013ce5c>] (worker_thread) from [<c0141908>] (kthread+0x14c/0x154)
>     [<c0141908>] (kthread) from [<c0107ab0>] (ret_from_fork+0x14/0x24)
> 
> This was missed in commit 0c9501f823a4 ("backlight: pwm_bl: Handle gpio
> that can sleep"). The code was then moved to a separate function in
> commit 7613c922315e ("backlight: pwm_bl: Move the checks for initial power
> state to a separate function").
> 
> The only usage of gpiod_get_value() is during the probe stage, which is
> safe to sleep in. Switch to gpiod_get_value_cansleep().
> 
> Fixes: 0c9501f823a4 ("backlight: pwm_bl: Handle gpio that can sleep")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>


Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index feb90764a811..53b8ceea9bde 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -435,7 +435,7 @@ static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
>  	 */
>  
>  	/* if the enable GPIO is disabled, do not enable the backlight */
> -	if (pb->enable_gpio && gpiod_get_value(pb->enable_gpio) == 0)
> +	if (pb->enable_gpio && gpiod_get_value_cansleep(pb->enable_gpio) == 0)
>  		return FB_BLANK_POWERDOWN;
>  
>  	/* The regulator is disabled, do not enable the backlight */
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
