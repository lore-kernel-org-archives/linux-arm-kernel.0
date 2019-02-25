Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF06DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:29:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847CD20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lYY+kHNp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVFYCP50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847CD20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B10aoQrkJ45lu7kooibj9MCCk2kkT2+PWd5iL3HkRz4=; b=lYY+kHNpwN59Jj
	5dKQnDmmmnPWjhXGE/3ECcMjfcrpXdhiTHPtBMvRgEEgvOMTI9eDuosttBbk3H2C/r495xntaBkAG
	W3cmYFISnDiUSfACCtnqLOLGMUs1fYx5KtcP9C7za824epwEhoyClLFqfejAAajNSrUJaUyiZr/xS
	zaOs/bO3/8/tb1DDKoYKYd/uaWoMfUil3O+/fp3o3km9uAmTusJ6D88tt2CfdfmLTskAyQVzFcefT
	VTuSSAPHlVKtjlbGe0qWJRQIaumbOUWwgImg8AJbO8uH1MDzF+ucmarEXlydXPKQeBbBb8hfE5vj9
	h/11ynuI41ktlcSu4M2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy7to-0004OD-3Q; Mon, 25 Feb 2019 04:29:52 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy7tl-0004NZ-1T
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 04:29:50 +0000
Received: by mail-pl1-x642.google.com with SMTP id r14so3842109pls.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 24 Feb 2019 20:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KWbWGTi5tHb6cmq9IznZT7SeUjiAOg830SMnYdOj7uc=;
 b=bVFYCP50PkWgrR9VqclOQcFW/NABe8gsTw4DDrIMC/2ypUVfc5MKvrjopu73q0wMzC
 Fx4CLHiZLXXGhZxqUQv2rsb8x/aPRcMMpqGijxtBbNav/qB+VaYFM5Po6TYBpQeF6v3Z
 3AN7sRUU9LZKgUTafRTzgSrvJ5MvdEQQb0DcFqw+UHhyHzoKmD5YcrJMlEwtPdUnrzar
 /AtzVUzD/XK0chdW63yePg5zZLDSXfL1mussXNGFC8BIZyrrvo8060/LVbSbgF+mGHZj
 1kLnokK1nIcZU9qFZgJZAqWUd+mZ5uQY9t4bsAg98nP3XkYB+UPq6fy6z4NGO4YVeN1L
 zUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KWbWGTi5tHb6cmq9IznZT7SeUjiAOg830SMnYdOj7uc=;
 b=ZlvBbdAIAgbatgL92BoaTgcIwRJuVr0db7KRkViK+XOFct3akqjWwUOEU2gThU4+Y9
 me31ANNAy3U9M3HxNqN8TlbWx29xw1jRQpAasLc9rpHwT+Gsj619EnjD8q5D2ohn1CjT
 2gvAbGDfP/w6jlmOwQGA0ekdlAwRV2syJRByKRhNY2mLOHjwP2F6+fzYVR9CFfmKGOuH
 d6mkARnJJH7whp0+e9PIUfxHOWBg3HMP+/0g1SbvPcNS+jooBOTPmaL+/PTM8uW7U09t
 7kmHSwy1BObzXw3v0MX8hzonD5KdE/QzUMgv3hp2mDA6r5PNZodHILGo/4Kr4Pvx9ZYH
 UGaA==
X-Gm-Message-State: AHQUAuYBhiCgLR+Vh+YE/60xgc9sCTGsS6+1HBlRaFild8B6uUJT33KO
 Xm2HNBFkI3tqNjZpBu8A8ABwRg==
X-Google-Smtp-Source: AHgI3IZxMTma/p6weHVt3VXm6ibtrP/psN+Q2ngbJ9K+reISoNwz49+RLntDnxj/8fsz+RYEksVBBA==
X-Received: by 2002:a17:902:64:: with SMTP id
 91mr18745132pla.229.1551068986348; 
 Sun, 24 Feb 2019 20:29:46 -0800 (PST)
Received: from localhost ([122.167.168.92])
 by smtp.gmail.com with ESMTPSA id h79sm18526929pfj.186.2019.02.24.20.29.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 Feb 2019 20:29:44 -0800 (PST)
Date: Mon, 25 Feb 2019 09:59:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 10/12] cpufreq: ap806: add missing of_node_put after
 of_device_is_available
Message-ID: <20190225042941.wypmh4kikcgmebn3@vireshk-i7>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-11-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550928043-14889-11-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_202949_114930_D9A17930 
X-CRM114-Status: GOOD (  17.43  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 23-02-19, 14:20, Julia Lawall wrote:
> Add an of_node_put when a tested device node is not available.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
> 
> e = f(...);
> ... when != of_node_put(e)
>     when != x = e
>     when != e = x
>     when any
> if (<+...of_device_is_available(e)...+>) {
>   ... when != of_node_put(e)
> (
>   return e;
> |
> + of_node_put(e);
>   return ...;
> )
> }
> // </smpl>
> 
> Fixes: f525a670533d9 ("cpufreq: ap806: add cpufreq driver for Armada 8K")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff -u -p a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
> --- a/drivers/cpufreq/armada-8k-cpufreq.c
> +++ b/drivers/cpufreq/armada-8k-cpufreq.c
> @@ -128,8 +128,10 @@ static int __init armada_8k_cpufreq_init
>  	struct cpumask cpus;
>  
>  	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
> -	if (!node || !of_device_is_available(node))
> +	if (!node || !of_device_is_available(node)) {
> +		of_node_put(node);
>  		return -ENODEV;
> +	}
>  
>  	nb_cpus = num_possible_cpus();
>  	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);

Applied. Thanks.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
