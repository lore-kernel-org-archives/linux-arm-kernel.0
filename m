Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF80C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:37:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD68B2171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TAFMpx/Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VQgargok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD68B2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M253I91P20X4fEt/Bcpjhj1W3Jspg0z1Szazt4vrOV4=; b=TAFMpx/YlDc+vz
	ghGn60KWHUw0pKYCtRjwweRnFH1O3o06a1beGWclp+8oVC/3Cdzu5d9Eg+uvuRdWd9dRZvzUqH9PM
	4AwgN1T7Ts9FRzyqyCZXK4nC1F0uyCaEo7IDSB7M0FCGmqKrq0i+IT9eBhNXc8hh97Iu8Suh6aarY
	Ow7G3paKmITN8kUMt0MHsvQtJDy0WuMfP1HYYkBjj1o/I7UqOF0M3OaYgEGjScgqkYcFQ9NR5jCCO
	u6LS/ClhZg+lEn9r8rlmQQbVVQ7ZSCBahzsxjVMvrv+SmqagSR588w5z17bWcRHz0cRaET7fD1z8O
	xu4eswJ3atc5j0j3oQFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCiM-0003Or-Q9; Mon, 28 Jan 2019 19:37:02 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCiI-0003OQ-RR
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:37:00 +0000
Received: by mail-pl1-x641.google.com with SMTP id w4so8215632plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 11:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fNUJ09BCIZ3YVWy/Ji5fieGPR7dMwabmPYhcIO/fyFg=;
 b=VQgargokXjtIdGA1PK+y73iiIC+deS807thO0SWlB8K2cezAE6Xo+lsNWbu84PfpW8
 zcN9EFl4XsaY3Zr/Tn3+DvFvYg5rN6UeRJ1yJp75VJPYVfFcu9ncX91x+TyxSD1mSRWM
 lFKgi6UF84qekMTQrbaBWf9/kLNdg1IuS9/z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fNUJ09BCIZ3YVWy/Ji5fieGPR7dMwabmPYhcIO/fyFg=;
 b=pBiVszUGDvh6OfU4HjwZS02EfEBfbuDlIi0+qkTgteIHa9Jr9tkZjt//uaPKFXzvWs
 SBUVbPhuIQI4rQTnecND/4nMB/rzc+n3iYIkNGkL62Yrp7JfjGdVi5EZgRGu/aGhITiZ
 Hul7Rjvj5GU9x95qKUOGXzBpdoDdhmFdjme+aj1gG3fZ7yCjmmpxkpHE3F/FTjfI1YXe
 QxCKSAWFdCmU/At/iepmy/i1lyRdHu0p5uBEW0PIUjK9pNyT675IlL6JI46Xy3JKRite
 3aJS4rII9Ezd+sYph6k6UbmbYb6vH5OXMrzENyOXKO3+gcI6o15HApu1t7v6kIgHa2lb
 s3Gg==
X-Gm-Message-State: AJcUukfyfdPURpFIW5Jh2zR82VZJx60au9zot0C5dVHpmv9jxte9kpCz
 aTzfgO7grQZqiB2JEhTmnIA7oA==
X-Google-Smtp-Source: ALg8bN6N18gNvICoXmmf/LmIw4oTBamfgrQCK9BROI5ovoz2+Uisd8OY1O/8j5x/CleV8Ye1HArcJA==
X-Received: by 2002:a17:902:7296:: with SMTP id
 d22mr23520246pll.265.1548704217884; 
 Mon, 28 Jan 2019 11:36:57 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id t13sm39064565pgr.42.2019.01.28.11.36.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 11:36:57 -0800 (PST)
Date: Mon, 28 Jan 2019 11:36:56 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190128193656.GI81583@google.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-3-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_113658_912989_F123C3CE 
X-CRM114-Status: GOOD (  19.84  )
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
Cc: mark.rutland@arm.com, rjw@rjwysocki.net, nm@ti.com,
 lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, liviu.dudau@arm.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 04:55:17PM +0000, Quentin Perret wrote:
> Now that PM_OPP provides a helper function to estimate the power
> consumed by CPUs, make sure to try and register an Energy Model (EM)
> from cpufreq-dt, hence ensuring interested subsystems (the task
> scheduler, for example) can make use of that information when available.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e58bfcb1169e..7556e07e7a9f 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -16,6 +16,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> +#include <linux/energy_model.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -152,6 +153,7 @@ static int resources_available(void)
>  
>  static int cpufreq_init(struct cpufreq_policy *policy)
>  {
> +	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
>  	struct cpufreq_frequency_table *freq_table;
>  	struct opp_table *opp_table = NULL;
>  	struct private_data *priv;
> @@ -160,7 +162,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	unsigned int transition_latency;
>  	bool fallback = false;
>  	const char *name;
> -	int ret;
> +	int ret, nr_opp;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -237,6 +239,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		ret = -EPROBE_DEFER;
>  		goto out_free_opp;
>  	}
> +	nr_opp = ret;
>  
>  	if (fallback) {
>  		cpumask_setall(policy->cpus);
> @@ -280,6 +283,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);

The perf domain is registered here but not unregistered in exit()
(there is currently no API do do this). When init() is called for the
second (or third, ...) time em_register_perf_domain() is called again,
though it skips the registration. To make things more explicit and not
rely on internal behavior of em_register_perf_domain() you could place
the registration inside an 'if (!em_cpu_get(cpu))' branch.

You should probably check the return value of em_register_perf_domain()
and at least print a warning in case of failure. This would require to
call em_register_perf_domain() only when CONFIG_ENERGY_MODEL=y (the
function returns -EINVAL otherwise).

I think this patch will result in error messages at registration on
platforms that use the cpufreq-dt driver and don't specify
'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
a problem as long as the cpufreq initialization succeeds regardless,
it could be seen as a not-so-gentle nudge to add the values.

Cheers

Matthias

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
