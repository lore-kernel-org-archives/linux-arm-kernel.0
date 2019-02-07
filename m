Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C92C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:36:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4458C21900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xpmxzjwd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxSWDdMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4458C21900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fcFVBTsqn58aIdyNGoivbsbGVfpOwNp4SAZ4YbdXzOU=; b=XpmxzjwdIp9A+I
	naEVwyk6UwpZrY54Zgi6d6OCKFKorVhJV1IywaWuawhMQsiHNC3T5hdLN3IHHulKZV3gVZHy6uVaS
	vB+be/guONJUSgueT/0f6gIPouIoxhAAerszS5hDd5kJMFNkmE8uTLMCvzLNxVtW8+SsnbulHGBfq
	y6HIz196AHIDLIrpGS99L2IFfMcyBypjeAMHMIpMqbYFxI3S20B+11L2Trwd6eI3Oc0R4cxV9Fsuy
	jGw4UvNOWm1WVqd/r718WiU7fcBFFu/wL2LAp03JOShSD+/c7bBW18nUaDI9jLtLaBOaFnHUS0oT0
	Y1yqkDe7wGfI75+3xgdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grbQA-0000us-6O; Thu, 07 Feb 2019 04:36:18 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grbQ6-0000tw-ST
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 04:36:16 +0000
Received: by mail-pf1-x442.google.com with SMTP id u6so4198707pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 20:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RsXSbB+Bjl+cSk9pwJ6L5xDb66kE12kgkww+d+U/sWs=;
 b=jxSWDdMnFuRUNbyCsSvxMKbdmGu33k4J4gU9igkwLne+o1ComGaKf31ZPIvt4yvUCk
 PZsagSqKTOW+Itj58/M6Co1pw+8XmSdwKmi74oqRlPbeFbTALSqJGzldQCfaL+lnzXQT
 jYM9rG2L7u4MnEgb+6WcIholSNpgvm/KSW3jzH5QwFOfRqqYSHfEmZKU3d+kZpzwEtv1
 DGyGH+dA6hyF5/bn8cQ6OsRQbWKQGcBTZbE/ibMQiznHKuFFcPePgbCr67ZQMZ7XCXWz
 AA6D54JiDJIJ9N2tUqVyueRcdyHFd5RyJ3a/U6NpA61Qii0nQ7Fto8orkQ+PsIfNtDAl
 SxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RsXSbB+Bjl+cSk9pwJ6L5xDb66kE12kgkww+d+U/sWs=;
 b=NgzcZ6kCMNfakqJDjCiHb2VVVAr7duJV6wSY3AFzDngUUqBy4KxcGIZTqZc6v1PrNS
 MfnykF8v/65dx794fHAlfhYI5rS6EvzDjyNoAdV1in3C/M7vI+HQL/fZV/4goyUQb722
 fkx4FoikK18ppIyPeSSTq9bQPx9r6DAO9iY7J9zIDTUYF2QawF3DZC7oKQeeIOtKHhke
 VbIGNkv3ElzFzXSYKKgzTT/1JlVdOKAH3hKg+E4K7a/MvxILj1pssC/INCwcT9NBDwtc
 jf++x5rjjC5y84Z9ao6ug3HsVxffG0wHvTrZjAt/qNGDMnAbPeZFW++DbPb+5ztUiudv
 dqGw==
X-Gm-Message-State: AHQUAuYyRpuVusoYXN7ZYjXqxAYPi53q3xzKT2v/oh/PcI0fLj/c2Vzn
 mSUSFNhHDaqNXKdXIfVGLzMMlQ==
X-Google-Smtp-Source: AHgI3Ia3Va5ooa3J/3btynNGsO33ZRUhsUzQ7Ac2pTOMXShH4o8Hj4yjIWx33kWnxN/9ngMQB3ZonQ==
X-Received: by 2002:a63:f241:: with SMTP id d1mr13194289pgk.2.1549514173610;
 Wed, 06 Feb 2019 20:36:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id v184sm12093970pfb.182.2019.02.06.20.36.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 20:36:12 -0800 (PST)
Date: Thu, 7 Feb 2019 10:06:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2] cpufreq: mediatek: Register an Energy Model
Message-ID: <20190207043610.dy5nf5e3vujtmzgn@vireshk-i7>
References: <20190206185004.54779-1-mka@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206185004.54779-1-mka@chromium.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_203614_931578_028F8DEE 
X-CRM114-Status: GOOD (  15.72  )
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
Cc: Taniya Das <tdas@codeaurora.org>, Nicolas Boichat <drinkcat@chromium.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Quentin Perret <quentin.perret@arm.com>, CK Hu <ck.hu@mediatek.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06-02-19, 10:50, Matthias Kaehlcke wrote:
> Try and register an Energy Model from mediatek-cpufreq to allow
> interested subsystems like the task scheduler to use the provided
> information.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - register the EM after setting the cpumask
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index eb8920d398181..5250df762814e 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -465,6 +465,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->driver_data = info;
>  	policy->clk = info->cpu_clk;
>  
> +	dev_pm_opp_of_register_em(policy->cpus);
> +
>  	return 0;
>  }

Applied it after rebasing over the change in cpufreq/arm/linux-next
branch. Thanks.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
