Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0777BC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:31:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B722148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PZoSW5aL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECy16EZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B722148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V7D5PRz5OOmY25LWHfL66x5qJM+ZkBzyyydxwkvQ/jg=; b=PZoSW5aLdrDM/N
	GZ+rnqP2NTl6HPBW9OIAbiYvxzdMsdD0az9ec5a+RIzeH5qTygt27sQpSdsstmESF7qekDDGMS+i6
	HSw390Z5YuoPDfw8j+dtnMiAxgKucBPrnm7rnqu8pbnTaBeN1u2fhlKleJmXH77pjKK/fcAhiTjYw
	USTUaF5Izr6Kkck60hIcY5hsexmeQzfjRYhEwgoKTWuocP5eTDbaqXDg4ZRRaa9xK84e6GbsKtl4V
	iZ/AJVHzUg1dmw32Xb6vTNShc+x0zL3JqMFV1YsMl95VHD4viazu0U40YNq7jyqDqd/zOrWKF1GsZ
	oqrt7f5qOJs9U9A0W9YA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goLzo-0007EI-BS; Tue, 29 Jan 2019 05:31:40 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goLzk-0007Dr-Ut
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 05:31:38 +0000
Received: by mail-pl1-x641.google.com with SMTP id g9so8861253plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 21:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vlg5RKRyPLWXTBq2LOJACwgaidg3unYs3d3ZnrY1INg=;
 b=ECy16EZ/Y6jE+aah4EZBoP9nZOEXtsKfUWIryo38B6bgh6TVGV9dDCHanABhvtGZVX
 ffJib29zhxcAq5wViyxusDnC/DTkY9Oc73fErmpRFl9txBMHeXO26ChZ+7JrlpUM0x1S
 2u5Dv23rssSMZt4BK3bQ9Zu6sqFaWt9XJxvDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vlg5RKRyPLWXTBq2LOJACwgaidg3unYs3d3ZnrY1INg=;
 b=cefMg+T7n3Prc0ITt+f4kboPzarfFJZ1FT1dd9pD0mC/Ox+Z+LDRorHhk3YZbindB6
 mQhOurRxL2wEqV42tozCAXp2mnCzqaTqzzgEaKcmqdN54DSHxcwsiX7er4Xe9Ns14KUQ
 Afu95Hw/K6LWUdPx2Fu98VYZvQnUeHVA5nMOTkSvqaz9TP35QorIEkfugkJrhyJWuY4M
 faa4rBj3R7PZ3gQIXjl6NB7NrK9Kb3aACSkQSsBjoGYOl90XHAPR8uATE4e7VDO0E8bM
 mILkUaw26Nyh03r0RHl4FIkN8eyY+LW+J1E64U4tdGYDGNP4VdPHDuGXCiAmQF7m6jaH
 Q48g==
X-Gm-Message-State: AJcUukcRLfHki9Y0Oei0DbdoAalWTO064TzVs30/MqjcLwz6ef2MZqG8
 YHuLd7FNGJIEYIw45aZQxskKuA==
X-Google-Smtp-Source: ALg8bN75XfWs0sEQP9p9INBUSDRQFrbDis5v2xtNgT6H/5XHiIo7Z6C8xD+kW/R+/RqQiO3gpW/7Ng==
X-Received: by 2002:a17:902:29ab:: with SMTP id
 h40mr24527616plb.238.1548739896184; 
 Mon, 28 Jan 2019 21:31:36 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id 15sm59474176pfr.55.2019.01.28.21.31.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 21:31:35 -0800 (PST)
Date: Tue, 29 Jan 2019 11:01:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 3/7] cpufreq: scpi: Register an Energy Model
Message-ID: <20190129053133.l5wix4qgvty7bzig@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-4-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_213137_006922_E95F7807 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: mark.rutland@arm.com, nm@ti.com, lorenzo.pieralisi@arm.com,
 devicetree@vger.kernel.org, sboyd@kernel.org, rjw@rjwysocki.net,
 mka@chromium.org, linux-pm@vger.kernel.org, liviu.dudau@arm.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28-01-19, 16:55, Quentin Perret wrote:
> Now that PM_OPP provides a helper function to estimate the power
> consumed by CPUs, make sure to try and register an Energy Model (EM)
> from scpi-cpufreq, hence ensuring interested subsystems (the task
> scheduler, for example) can make use of that information when available.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 87a98ec77773..05fc7448f5cb 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -23,6 +23,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_cooling.h>
> +#include <linux/energy_model.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
> @@ -98,11 +99,12 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>  
>  static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  {
> -	int ret;
> +	int ret, nr_opp;
>  	unsigned int latency;
>  	struct device *cpu_dev;
>  	struct scpi_data *priv;
>  	struct cpufreq_frequency_table *freq_table;
> +	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -135,6 +137,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>  		ret = -EPROBE_DEFER;
>  		goto out_free_opp;
>  	}
> +	nr_opp = ret;

Same comment here.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
