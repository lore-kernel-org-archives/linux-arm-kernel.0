Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:31:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE23A20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CUpl2hVf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtQx1dAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE23A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P2J7V2HpzjKG60v58W/Fd0SDnB2LtFYXvAUp+dPwFoo=; b=CUpl2hVfpYWqkr
	oDzMi5tX7L134D5GU4UYh4uzKV/mMIX+gNAVgSwvLMSuQYbINa44yfuredTl2s2Cz4Mc/pylGZ+ov
	5zlQfO3PWlL9xJgvkqu/X6FF2R/wfU+2OIKMMOWJU5T/QXeCD9f8jjISjn0uzT09XBc86xFzi3KeW
	1UBI/97YVATrBNmGegjkeqW/UqGTsJb47/j7SC3BN33Ie2RPYAhE+m/6sGkz9QhXqSxZALUaf06Us
	/IzxuQTzIq5Vlwg+6JONRV7/YitWjrON0OdO7ppgt56uSRETP7soaWemaioEZqnivVlyam+ljSuaX
	LYVKtDEiAFlh4KP0SRWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU72t-0004bu-Fy; Tue, 04 Dec 2018 09:31:11 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU72o-0004bB-Ta
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:31:10 +0000
Received: by mail-pf1-x444.google.com with SMTP id b7so7918086pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ksi5DC9S8xu/2FKg8Dsc/QBQ4RCmaSIIb9GmFJwD2uk=;
 b=XtQx1dAxxGzhscT5ugYeXJtp/kPnmkAJ7U+IXdF5omPTrIoeFkXSQnLgdc/hx+Wzh2
 Fzzp2x+9BM1auERkemo5Df0RkiKHMZ93v81D1MKTkn2AB71fAM5BCl2mOGdeqgqO/hFt
 9BBUMEI6+hzjqyir+PGUpldDKGTHfv9wjnLcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ksi5DC9S8xu/2FKg8Dsc/QBQ4RCmaSIIb9GmFJwD2uk=;
 b=FiMYAPDuOExfAU+KDEOL0gGjPaNqowaIVfwvRBloXUvnRxs/cslQ6xELIIS4uKFhBJ
 MkPYacfiRunNSiaMuOo3x/s/7NI4M2jkbFBPjrdOYlPFwyD6FG8V34SpQlO76svxZ6r+
 gUoDX7viB55GPYCbRqOlaVLrdDH4MzPonnGUeeZIE0tCMY2hP3QWXEukayt2065UGp3O
 0/aCvSbu+zkTrPHoFDHbszuXiBA3638aWCKhtW3ZVDirh6A5O886I43iYhNACFthVlh5
 RlthMCSnwV6B1pExnF/Yg3AE6hXSiCfumeC0Q9g6+0bN0ozT1cWJGLUL59bgFr11BzYM
 wJ6w==
X-Gm-Message-State: AA+aEWZuivpuVodtjfrFSNU+Wi24tds2VlEgq0QDHFNQne75es+92OlG
 Oo8igWmEDWV44wCAIQ3uXmjEmg==
X-Google-Smtp-Source: AFSGD/UjIGxS4RgL4ty2Fua3NNl/cYDltdXjjG8/2kTv2PpqTnioIiCm5yaPtBIgZH3l8RasI4cSOA==
X-Received: by 2002:a63:db02:: with SMTP id e2mr16298362pgg.419.1543915856388; 
 Tue, 04 Dec 2018 01:30:56 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id z127sm26914124pfb.80.2018.12.04.01.30.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 01:30:55 -0800 (PST)
Date: Tue, 4 Dec 2018 15:00:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 12/19] cpufreq: tegra124: extend to support Tegra210
Message-ID: <20181204093053.pkwv5yeyjezbw5ay@vireshk-i7>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-13-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204092548.3038-13-josephl@nvidia.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_013108_652310_77D4DF7F 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: linux-pm@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04-12-18, 17:25, Joseph Lo wrote:
> Tegra210 uses the same methodology as Tegra124 for CPUFreq controlling
> that based on DFLL clock. So extending this driver to support Tegra210.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 448d00763d00..1af955fb715c 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -159,7 +159,8 @@ static int __init tegra_cpufreq_init(void)
>  	int ret;
>  	struct platform_device *pdev;
>  
> -	if (!of_machine_is_compatible("nvidia,tegra124"))
> +	if (!(of_machine_is_compatible("nvidia,tegra124") ||
> +		of_machine_is_compatible("nvidia,tegra210")))
>  		return -ENODEV;
>  
>  	/*

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
