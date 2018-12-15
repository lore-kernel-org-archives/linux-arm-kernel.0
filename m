Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:48:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B040206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XDLi6NBj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOjZhyXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B040206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ECc86yuA/TllIC5teq1aDfgkB35x1yGoizf2mOuTCPs=; b=XDLi6NBjWiuMRn
	RiN7amSbwSqLhblYrq04FHDl5/Z5Kps9RMl0WKKic0V35ThBbl2+z9Pn+2pdxzWGAeXuQV9k5XUIo
	pchKSm1+uCeidQR2fvVApKxpUkX2/5RUaU/O+JRnAptfhTizqLoc4xo173I3Ct/yWkxxEraqa/inI
	M0+E6Z7NqmCK0YXXTOhQrEN+qXC4UiWNcUS8C6ZldE4BNqQqj2D6s0CLKb8nup44KxVkZccPCjPtf
	e+WixrnHH73r3pmsdoTPYi02KMmAHq0Q5IqWt1ow6tDBuggeEq1fuuPv4ATpEDrDzl5PaYI/DJrcu
	z2kDpS9DA2dwgAvpp8Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXz3Z-0007eK-RQ; Sat, 15 Dec 2018 01:47:53 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXz3W-0007dM-6m
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 01:47:51 +0000
Received: by mail-pf1-x441.google.com with SMTP id c123so3654288pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 17:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TzfGt5gJofimzxV/+FAhN7Dc4mIJAhSYfyF+BnGPH0g=;
 b=cOjZhyXZfCAokPxhv7k00zi5qoamBGK1r2CYoDfpW87kBm0nrz9+CCugoIskU59umh
 CzXlxS/yDU2ZwO3R14VJkBa0MtB5tIPwLLCXKu+6nfIgOGGJzBx+WhAhD2KpkjyQpCnn
 0lkzI1Y7ENg/lPiQavGCttcvQ3StQlpkb3UhbWosOyo20DQuyh4Owi6ONYBsSnAlxgPt
 fx7pyxlzSYyNukY3WUeJjfenewf2tsJTLhzIodtGVD3CQ+1CypHI8TIo7MhH9q8Jsqki
 yd54z3pxSAIY6OompjeHaAvT4oCRfTWVEhxLAs1E8tmFKQFAyqkD8boJ7KXI8Tq0cCz4
 jerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TzfGt5gJofimzxV/+FAhN7Dc4mIJAhSYfyF+BnGPH0g=;
 b=T+qNFyh9hdMQBD9D1sfa0GAxKqmuC7FsIGGsNoUi/aYij7mDTgFqHrmoS7J+7DCE6C
 rJrXzQExRdPX7C/LIEv1Cp3m0Sc7a4cgRID69rHCQpPQZefT4VhvAT3C/+m4kIwxtNW+
 3O4TLD77JksP+C7J+mMMC6YjAOEOdyZ3VYfgALnh119K/z8EhvYg5uRIGCkB0CkvgwX6
 Nx7NdVh5WepoDux9xaYVih8jN2QqVd0xrMcOqzcmvEnmFuxBmu3f6DIY8uFJYw7dqU6s
 LJu0SRwmHo6vHwjWcaMBZdJgCTYlxRqAQFPMUcpapArh36aRQT8WoNn07GPJUgMm+CIr
 dbeQ==
X-Gm-Message-State: AA+aEWZyzmGyBKXYj+aYJmMRLDImeZnWWOmYpZ1EEh19hwa+7u+ZjY7k
 0P2a/J1NuYa+Y4v76M4653A=
X-Google-Smtp-Source: AFSGD/Wbh8uz18SAZt9axHooUikpQWfT4I0ZpQjPUVfZICbIfybkrF3FiEULWbGalgAO+Hy2txzqmg==
X-Received: by 2002:a62:64d7:: with SMTP id y206mr4996281pfb.84.1544838458911; 
 Fri, 14 Dec 2018 17:47:38 -0800 (PST)
Received: from localhost.localdomain ([73.93.152.175])
 by smtp.gmail.com with ESMTPSA id w136sm9687953pfd.169.2018.12.14.17.47.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 17:47:37 -0800 (PST)
Date: Fri, 14 Dec 2018 17:47:34 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Subject: Re: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
Message-ID: <20181215014732.GA24528@localhost.localdomain>
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
 <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_174750_251454_80A9D9A1 
X-CRM114-Status: GOOD (  19.00  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Thu, Dec 06, 2018 at 01:23:32PM +0000, David HERNANDEZ SANCHEZ wrote:
> Calling stm_thermal_read_factory_settings before clocking
> internal peripheral causes bad register values and makes
> temperature computation wrong.
> 
> Calling stm_thermal_read_factory_settings inside
> stm_thermal_prepare fixes this problem as internal
> peripheral is well clocked at this stage.
> 
> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> Fixes: 1d693155 ("thermal: add stm32 thermal driver")

Please append patch version in the title next time to help tracking it.

> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index 47623da..daa1257 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -532,6 +532,10 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  	if (ret)
>  		return ret;
>  
> +	ret = stm_thermal_read_factory_settings(sensor);
> +	if (ret)
> +		goto thermal_unprepare;
> +
>  	ret = stm_thermal_calibration(sensor);
>  	if (ret)
>  		goto thermal_unprepare;
> @@ -636,10 +640,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
>  	/* Populate sensor */
>  	sensor->base = base;
>  
> -	ret = stm_thermal_read_factory_settings(sensor);
> -	if (ret)
> -		return ret;
> -
>  	sensor->clk = devm_clk_get(&pdev->dev, "pclk");
>  	if (IS_ERR(sensor->clk)) {
>  		dev_err(&pdev->dev, "%s: failed to fetch PCLK clock\n",
> -- 
> 2.7.4

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
