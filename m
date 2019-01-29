Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:14:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316F921473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yus0K2LQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDQaRPr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316F921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jAeZzik/hAGjIJMmfX42sRnQhTTRWFZNdLtpeOmv+hM=; b=Yus0K2LQjIW1H+
	0XE8ht3zH9nqDVV7x6C+2yslBtpm67hS/fb6qsdJzqyZZD81jA7oOVU/CSArGUl2yM7mi+tu0QB0f
	ruS7Zt8heDJmAsaEw3qtJk7w47K1384w/8gVGqCA0nf5HA1LNnD1KnuXE0m01vXs/sdY831+mvUQW
	obumEQDmXCPsGixWyFWyPdNin8jvPElc3fkR7jqJRx0rMWssk2Wt6LXRphsNuk8OA199v2PjLniMd
	s0PG6lvymvIvAoJUwO4xCrDdedY9PVnfNxAs7/rSHDt2bcqUWpKYvZOsMrzgIzQsK2M3FNYiYA+EA
	RLbX2J2zVtueJANbGgEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQOz-0003nl-P2; Tue, 29 Jan 2019 10:13:57 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQOv-0003lE-D0
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 10:13:55 +0000
Received: by mail-pg1-x544.google.com with SMTP id j10so8564282pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 02:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=L49h9QkNpx56q8oRbtd1NcnocQ6XxJWs8GSZnc/Zph4=;
 b=XDQaRPr93DDmkZEmzuJ+TObX882ASIJojbiUZq2HzpG6cr0Ejn6xCtoH8l0c273eBP
 frKjTruEPxlhxzCi5M44Z54W8Rh1E6wNJK/Wjzu+8zwvuk6JwRouFOi3yI0JOwIvsmxm
 0hBy6i9KHBaMdL5EHVbQHyHMmsUsEHrXWbLOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=L49h9QkNpx56q8oRbtd1NcnocQ6XxJWs8GSZnc/Zph4=;
 b=dHEL/a1P1xiMgon/Nga8hyGMnUV5SvxmZ90mEcdWXkWGiCyXsVAvOx7pVcNQJI5N2S
 ASCVDKdaJitNKnyEnjXvRvlv7hn1sTsh1qNoVHDYld/D5fT8zawuPNBsLnv7202X5Pjf
 0iqvlroYVEXZd/ftQpSeoBrazxJPcvAL3LlKmNJ8L8KRuB1OcKfWGSYlsXc1O65Hme82
 1DBr3cLLyw4VCVBFVUx7bUn1u3Ovgcb28omAFoGMKxZmQzA3wjXSTW71aQZ5/P+LmghS
 qxN2zuE/E91BuI53IihmBPn+y8cSD+RgKI6cQpsNJ2PgkxvsvCnpX+I4d0YJTVN69I+7
 EjBA==
X-Gm-Message-State: AJcUukd4Kb9qNKNph149wMjr1TZPdTXtjf4BaXWUHhzIgNRU1g8HxC9m
 SvLoJBblT3tEhA4nXzugV1VMgA==
X-Google-Smtp-Source: ALg8bN46Hih6fDtXHr4hYfD3+O5Kms3cLJ2qozDpyOBc6SSOuts7EIkQraPQoRySbp7+DrqmvQsIuQ==
X-Received: by 2002:a62:798f:: with SMTP id
 u137mr25766277pfc.168.1548756832251; 
 Tue, 29 Jan 2019 02:13:52 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id w6sm29978653pga.72.2019.01.29.02.13.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 02:13:50 -0800 (PST)
Date: Tue, 29 Jan 2019 15:43:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH 1/3] cpufreq: mediatek: add mt8183 cpufreq support
Message-ID: <20190129101348.7oxqerszhcopanzr@vireshk-i7>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-2-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548743704-16821-2-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_021353_448816_B7604EEA 
X-CRM114-Status: GOOD (  21.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, fan.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 29-01-19, 14:35, Andrew-sh Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> For new mediatek chip mt8183,
> cci and little cluster share the same buck,
> so need to modify the attribute of regulator from exclusive to optional
> 
> Intermediate clock is not always enabled by ccf in different projects,
> so cpufreq should always enable it by itself.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/mediatek-cpufreq.c   | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index b1c5468..5a1c588 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -117,6 +117,7 @@
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> +	{ .compatible = "mediatek,mt8183", },
>  
>  	{ .compatible = "nvidia,tegra124", },
>  
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index eb8920d..e956248 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -355,7 +355,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  		goto out_free_resources;
>  	}
>  
> -	proc_reg = regulator_get_exclusive(cpu_dev, "proc");
> +	proc_reg = regulator_get_optional(cpu_dev, "proc");
>  	if (IS_ERR(proc_reg)) {
>  		if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
>  			pr_warn("proc regulator for cpu%d not ready, retry.\n",
> @@ -385,6 +385,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  		goto out_free_resources;
>  	}
>  
> +	ret = clk_prepare_enable(inter_clk);
> +	if (ret)
> +		goto out_free_resources;

Add a blank line here please.

Also out_free_resources isn't enough here and you need to free OPP table as
well.


>  	/* Search a safe voltage for intermediate frequency. */
>  	rate = clk_get_rate(inter_clk);
>  	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
> @@ -412,6 +415,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  
>  out_free_opp_table:
>  	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
> +	clk_disable_unprepare(inter_clk);

Clock was enabled after adding the table, and so it must be disabled before
removing the table. Just the opposite sequence.

>  
>  out_free_resources:
>  	if (!IS_ERR(proc_reg))
> @@ -551,6 +555,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> +	{ .compatible = "mediatek,mt8183", },
>  
>  	{ }
>  };
> -- 
> 1.8.1.1.dirty

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
