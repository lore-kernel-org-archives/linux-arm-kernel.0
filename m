Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67973C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:30:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383312148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hvU/G1E/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlysjKYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383312148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WmGbkvnjqo0MsXyEoJXx0oYYDg+n8sAVPM5+FRkWDwE=; b=hvU/G1E/KlCADH
	GocUqe2CpNADHfjhAIjUAuV8NWO7lzMWE+TkFpxiC89K/tNDqHwh85iwJGYknX30VGO/skDuIFbA1
	0WzpnbeXqRoF/c9dDvehIdrBSwPnCC9117DqW11X4SXAUBsI0TwaOfNIbgw0VSCLuv0P25WU9KlaF
	7nqdje0aCwxT0/nF7fsN0MkhhnafITrWXGRN41Ujj5bNoFkGMIpvlnGWmJZO1ltIhAIA9jN2vyL4j
	I5wi72uUamr7PTLggEGdvkvg5QYZne1HTYhBYuo7JSsJVqrO9l9PQH39th11p5YGT1Zx004Akod1q
	u9ql/5Zc0WHVDWVE0N7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goLyy-0006vj-Un; Tue, 29 Jan 2019 05:30:48 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goLyv-0006vH-Gp
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 05:30:47 +0000
Received: by mail-pg1-x541.google.com with SMTP id j10so8288493pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 21:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lLtNXSuhfQ2a5ic9Oh5vSesrlVFA1pyWAIE7zBbCCXs=;
 b=UlysjKYV5FpjsXM/z43czmFiIOlLsRVxflQicHVxiJv1c4pZLAiF8SxaDclUQubbbs
 2Nrhy+iVlDdkXBdsywB9q5w7FuwecdPYI0bqWLD2HeFBTkvXlvDTm0CD8h2fDUkehM6a
 fNBpvaa7tHe2amAzNoXSEmYkRFd9rBLi4kSKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lLtNXSuhfQ2a5ic9Oh5vSesrlVFA1pyWAIE7zBbCCXs=;
 b=bBUKcco1LmJojipgMtRnvE9Vuolo+DQvH/xMKMUb971EAu2ICGZ/IFT6wxQScH98JM
 6fBwq2ME76X8tIsSFHJ53nOXCZ/SXmUFNwT/2gFBfLIXhNHm7Z7zD2lFntZAmIxkX1yt
 KueS+jLIqrAxHAeWJeoMnSAXs0XiqxZ1GMihUhZTXbVXfx0YcEwwLBBgkpIgUM327w3D
 pVe+uGEDr4EJ/kTfay5tveZSLgPGmj1FSrOXdAboJEdLIonS4uOw6efPsvu8/J2drFSU
 UeRJ1iIB/s+VIbe1z9F4jq5v3SNEy+E5HBcaRRiHkz0LEny5ZbWZuZlQZ3fkru5sDdsI
 lWAQ==
X-Gm-Message-State: AJcUukcev/shfSg7hTze3puQcmZPQZrRbNWTQLVrr7tTA7XdqbgveKwD
 rKR6SjoS6eOTvhXlAldyFPiOlA==
X-Google-Smtp-Source: ALg8bN7S80eAeaLyRknarNnMGbTRRAqMUdweWiSpaCtKH/p6fF8r571jOKvmjABuNzvPQXShdcCtwA==
X-Received: by 2002:a65:4784:: with SMTP id e4mr21998619pgs.12.1548739844424; 
 Mon, 28 Jan 2019 21:30:44 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id 4sm43829983pfq.10.2019.01.28.21.30.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 21:30:43 -0800 (PST)
Date: Tue, 29 Jan 2019 11:00:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190129053041.ymyhfusj6eimpxfu@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-3-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_213045_564643_1E34AA30 
X-CRM114-Status: GOOD (  17.94  )
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

Hmm, so all the earlier comments regarding prototype of this routine are invalid
because of this.

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

Instead use nr_opp instead of ret while calling dev_pm_opp_get_opp_count().

>  
>  	if (fallback) {
>  		cpumask_setall(policy->cpus);
> @@ -280,6 +283,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> +
>  	return 0;
>  
>  out_free_cpufreq_table:
> -- 
> 2.20.1

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
