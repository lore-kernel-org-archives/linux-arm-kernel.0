Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C648C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:11:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AC220844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bF7cX4Ty";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGf3et6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AC220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mg8ZjKeLOXnI5dS/JVtXGuX50RLXovQlrlOGz9mT9bA=; b=bF7cX4Tyo2sRUD
	hLlo28F3UOn97FFcRcP7koIgW/LOLfX6O3EKmF9xAhVP97zJM2Jo2PolmsHqmEQQmXoLH1ogC2m9Z
	RxIPr31+CHHDulfDzky7k3y+DhTiNsSOGgvK3/vo8yJjQNYg23n9bV8UvG4TjK4zwMRhC0R16jdr0
	l09bDp1PdUpYIeJFNuAlq42N3K464uUYETJjQlCO1dYlI2fpjvlQuGCY+T1Z3UXXl74FkCFfn04n/
	Kqn6U1w1LpPJkez/xrY9LwZuLiPjq+9sfZTfXS9ZFgT/Ly/Hlc97AJCuvkTfldjz15Lk5mmBpSqbL
	wRGuAeHu+uA+i/QmG0vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxgs-0000ST-Pm; Tue, 05 Feb 2019 10:10:54 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxgo-0000SA-NO
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:10:52 +0000
Received: by mail-wm1-x344.google.com with SMTP id f188so2917941wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fXd6DbXSx8O30DE77NsjshJqWksv0B74q6S2C+obTY4=;
 b=XGf3et6zvH1XRd8xzd/9CgQF+y/UQkLvR9OqCbbfHOspCFUE5zwOaGIp6rhCDfee6k
 QVvaLbm/5XV8DQSOInVQ2mr1qK8/AMPOcXcgW98RZbgenEwtEhopHcfNF5iGk5VGZIf+
 hdIiRtZTy/hGJoiPZhkCzK33Aarfiv/zxv06WaPZlGlQcqryiv3kGrx0HjbjIEbdAc1V
 oxdAw4xTliVCH868SoRfS1+wFUp+ENGuTMbJ+QAF/6w6Rs5xX7yn0aqPZUbiLnhBRzAI
 rvVV5J/dzz2BUK8ZhoF5RuBxhe5MNz9j+hrNn/TunVisPVzodyGSjijY6IuFKvfJkxCg
 2FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fXd6DbXSx8O30DE77NsjshJqWksv0B74q6S2C+obTY4=;
 b=a91abocGyTMKZclSCgbYoCv6bnGdC5FH0msaGn9Lb7C1svrofvX2uNYwBVpmwVRvV8
 91Tq1kZAFmvWLGJtXtgu9NJiG0EWZjw7ZPRBKDhVul49sOvLSUD2Y/aAOS+GlsJ88nIo
 k/MpTXS+DH64xRHBpIknNdR8EiH947eqNFsx4PkOsoktxo8242MrQxR+a+bEGtfWkBxF
 6y/cfj2sHFIpIhCXm5gKc6wfa8DU9uAsZJR5Y9m9agDldKQJ/ZR/soI1yrICm8umOQ0D
 aoPMj+hE/XL63OBVQ+nUdchm1CKoyonVx1HPdyRbnxN/v37Dot6vZ+UmWoHrE2DyEz16
 WzdQ==
X-Gm-Message-State: AHQUAuZs3ETWMPDK88xkiZsmWlKHM+WZ4nurudg61bFA1DGk96Z9VNg1
 2E8dZ+rwgYhckE1O4ifF+Og=
X-Google-Smtp-Source: AHgI3IZT/s15wuBzS8Luay+LFzBvf01xJRRWD3Xk961FXSknAExQY0BIe6UKJ/jEYq86mQ3h2e2Zjg==
X-Received: by 2002:a7b:c24c:: with SMTP id b12mr2810014wmj.29.1549361448578; 
 Tue, 05 Feb 2019 02:10:48 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
 by smtp.googlemail.com with ESMTPSA id c18sm11868785wre.32.2019.02.05.02.10.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 02:10:47 -0800 (PST)
Date: Tue, 5 Feb 2019 11:10:45 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/5] perf/arm-cci: Fix CPU hotplug race avoidance
Message-ID: <20190205101045.GB27918@Red>
References: <cover.1549299188.git.robin.murphy@arm.com>
 <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_021050_786259_202C6EB7 
X-CRM114-Status: GOOD (  23.04  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, peterz@infradead.org,
 bigeasy@linutronix.de, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, "Li, Meng" <Meng.Li@windriver.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 05:09:04PM +0000, Robin Murphy wrote:
> The arm-cci probe logic faces a cyclic dependency wherein it has to pick
> a valid CPU to associate with before registering the PMU device, has to
> have the PMU state initialised before handling hotplug events in case it
> must be migrated, but has to have the hotplug notifier registered before
> the chosen CPU may go offline lest things get out of sync. The present
> code has tried to solve the races by using get_cpu() to pick the current
> CPU and prevent it from disappearing while the other two registrations
> are performed, but that results in taking mutexes with preemption
> disabled, which makes certain configurations very unhappy:
> 
> [ 1.983337] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:2004
> [ 1.983340] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
> [ 1.983342] Preemption disabled at:
> [ 1.983353] [<ffffff80089801f4>] cci_pmu_probe+0x1dc/0x488
> [ 1.983360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.20-rt8-yocto-preempt-rt #1
> [ 1.983362] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [ 1.983364] Call trace:
> [ 1.983369] dump_backtrace+0x0/0x158
> [ 1.983372] show_stack+0x24/0x30
> [ 1.983378] dump_stack+0x80/0xa4
> [ 1.983383] ___might_sleep+0x138/0x160
> [ 1.983386] __might_sleep+0x58/0x90
> [ 1.983391] __rt_mutex_lock_state+0x30/0xc0
> [ 1.983395] _mutex_lock+0x24/0x30
> [ 1.983400] perf_pmu_register+0x2c/0x388
> [ 1.983404] cci_pmu_probe+0x2bc/0x488
> [ 1.983409] platform_drv_probe+0x58/0xa8
> 
> However, we don't actually mind being preempted or migrated at this
> point; all that really matters is that whichever CPU we pick does not
> get offlined before we're done. Thus, do the robust thing and instead
> take the lock to inhibit CPU hotplug for the duration. This also
> revealed an additional race in assigning the global pointer too late
> relative to the hotplug notifier, so that gets fixed in the process.
> 
> Reported-by: "Li, Meng" <Meng.Li@windriver.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cci.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index 1bfeb160c5b1..f6d9df07ec9b 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -1692,21 +1692,23 @@ static int cci_pmu_probe(struct platform_device *pdev)
>  	raw_spin_lock_init(&cci_pmu->hw_events.pmu_lock);
>  	mutex_init(&cci_pmu->reserve_mutex);
>  	atomic_set(&cci_pmu->active_events, 0);
> -	cci_pmu->cpu = get_cpu();
> +
> +	cpus_read_lock();
> +	cci_pmu->cpu = smp_processor_id();
>  
>  	ret = cci_pmu_init(cci_pmu, pdev);
> -	if (ret) {
> -		put_cpu();
> -		return ret;
> -	}
> +	if (ret)
> +		goto out;
>  
> -	cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_CCI_ONLINE,
> -				  "perf/arm/cci:online", NULL,
> -				  cci_pmu_offline_cpu);
> -	put_cpu();
>  	g_cci_pmu = cci_pmu;
> +	cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_PERF_ARM_CCI_ONLINE,
> +					     "perf/arm/cci:online", NULL,
> +					     cci_pmu_offline_cpu);
> +
>  	pr_info("ARM %s PMU driver probed", cci_pmu->model->name);
> -	return 0;
> +out:
> +	cpus_read_unlock();
> +	return ret;
>  }
>  
>  static int cci_pmu_remove(struct platform_device *pdev)
> -- 
> 2.20.1.dirty

Hello

Thanks, this patch fix my issue that I has reported here:
https://lkml.org/lkml/2017/12/29/139
https://lkml.org/lkml/2018/11/12/1901

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-a83t-bananapi-m3

Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
