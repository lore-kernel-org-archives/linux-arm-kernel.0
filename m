Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD0C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F89A2063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YcvmrY+6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAy676/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F89A2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rEprWmaE3QEUucdm2DuNrcI6nY0fHPUv2dihQpE6AUs=; b=YcvmrY+6QASJJO
	oObZHM5BKhnF9usHEPFJyciNoGAzaPWi5DCX/VxZPSp8flh3fBnLMu/i7Kry65RMDcZGVnPGo+hzN
	r1zR9tUvY5hkzKAmOHwCnVpo3i0GH6tCM2AvAPtMMyVkGDm6SqhqLtI3uqWZ8NjZ01Lko7Ywosxs0
	mHPg8e1QlCj1LRYTSsSrP1cM1EfAXFgdzHHxJ1lEOcfIGE6CpLsd0/ONQZ41dgf43ucGmCet7bN+n
	U2ac3t6HxjU/2Fz2STW0c3IQyHlxbfdUrzf7J8X8l7knUm+VAz1dFxJr3T694jKde/opM8eKWEVAq
	KNKn7g3hwcLAMbu5iVDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBaI-0001zf-Sy; Wed, 09 Jan 2019 10:59:42 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBaE-0001z0-OZ
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:59:40 +0000
Received: by mail-pg1-x543.google.com with SMTP id z10so3155002pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 02:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7HgFKsLiUgBeihUScDY1oQjjwPiunzVz0A+BLsr/TRU=;
 b=QAy676/ObLHJ6NSwOKj7KKzoBlE1mXWIaz56TtLwUFGw8IjgIRxxuSUsxD7rnRyyOP
 +gHiw5Ycvez0pMVeZB/ZJqTwhruP03Plaa7fCsjhnA38JJ2wDYFVyjkzkMKNCm3qFayD
 dHycGTGbSoV7bzQFtKVyPAbw2JZ7w72g8Ml1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7HgFKsLiUgBeihUScDY1oQjjwPiunzVz0A+BLsr/TRU=;
 b=Wu6p49dykQjpQxe1dl1haJcHI1aOg4wyoimXtS8noU4R543VgXIVBNinIt5IzBs5gu
 85CHnIPlr/a2fIXBkK07pWP/D8c/0Hg9y/eiAPw+/T1j1UHTOZov7JenvfNo33BPkBRo
 txYnWlBHkIZOxFS+hI98X/A/mkXK/VKr1hX20Pl7Tahg9Ex/3gy1+BtEjaxYSB+rUgvK
 wZ51Fo/l590+GwmhhJm3qejDoH/HCO4CPVPSA8vhlH4uP/vk/MZedNMyMcjjOyzh2HZ3
 z5ndj4tmTG0TRWUhXstKLrpzTnGrlamM9kThiMqaBLVluYYXJTAA6xSoAuPjg+uroNdG
 8eaQ==
X-Gm-Message-State: AJcUukdHry596DHORqE8PJj0l++dws/kVWO9LB4arTvTMPwr7CC9zTDF
 BB/2RnWmVONM7GcTv2sDPSZFOd/kruI=
X-Google-Smtp-Source: ALg8bN6VnETbEN5HDDqTt7VdQ5JnvaBwwyjmEXQMe6CnI2pmYLP2gnKknEo4S8CUg0Jxc6MbqCgPlQ==
X-Received: by 2002:a63:8043:: with SMTP id j64mr5022414pgd.405.1547031578087; 
 Wed, 09 Jan 2019 02:59:38 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id 196sm282580768pfc.77.2019.01.09.02.59.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 02:59:37 -0800 (PST)
Date: Wed, 9 Jan 2019 16:29:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Message-ID: <20190109105935.i4f7wpedvk5wynwr@vireshk-i7>
References: <20190109104236.6532-1-quentin.perret@arm.com>
 <20190109104511.mi3gtdcytkky4eyn@vireshk-i7>
 <5435767.4D6MIGYIVi@aspire.rjw.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5435767.4D6MIGYIVi@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_025938_804785_1FE4622B 
X-CRM114-Status: GOOD (  18.70  )
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
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, qais.yousef@arm.com,
 Quentin Perret <quentin.perret@arm.com>, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09-01-19, 11:56, Rafael J. Wysocki wrote:
> On Wednesday, January 9, 2019 11:45:11 AM CET Viresh Kumar wrote:
> > On 09-01-19, 10:42, Quentin Perret wrote:
> > > The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> > > frequency changes to provide scale-invariant load-tracking signals to
> > > the scheduler. However, in the slow path, it does so while specifying
> > > the current and max frequencies in different units, hence resulting in a
> > > broken freq_scale factor.
> > > 
> > > Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> > > frequency table.
> > > 
> > > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> > > message protocol")
> > > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > > ---
> > >  drivers/cpufreq/scmi-cpufreq.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > > index 50b1551ba894..3f0693439486 100644
> > > --- a/drivers/cpufreq/scmi-cpufreq.c
> > > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > > @@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> > >  	int ret;
> > >  	struct scmi_data *priv = policy->driver_data;
> > >  	struct scmi_perf_ops *perf_ops = handle->perf_ops;
> > > -	u64 freq = policy->freq_table[index].frequency * 1000;
> > > +	u64 freq = policy->freq_table[index].frequency;
> > >  
> > > -	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
> > > +	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
> > >  	if (!ret)
> > >  		arch_set_freq_scale(policy->related_cpus, freq,
> > >  				    policy->cpuinfo.max_freq);
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> This would be stable-candidate I guess?

Cc: 4.17+ <stable@vger.kernel.org> # v4.17+

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
