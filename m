Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF05C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:45:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB12621783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iHCxBBvg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5TAwlET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB12621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hs1ORx98Nl/uXUNxEgETL3xMkyywTMU+FmC4pARuFXo=; b=iHCxBBvgonPivK
	6gP8+360KZ2ctqoC0ZVu1Pe7kgkA9tDzDqONxWX937udVo70DxA3W4oCkFSM1yDalRxNSeV9HHgEl
	BM/Xb1DXgkWbjnN/tcXKksQ37YqRSFMLC6dWW9U+Mh8PktOTSwS02ilBdYXdHdPlumvgPUBVJP1VU
	eugz+L9PjOWBVAHrROINFlID4VkxL/PY24KUSy2vX9T7zql9p/k1mxZEHY1xHNbZUmIt4F81FFaC9
	ZeS04wF6A18a4ZgoHxr0efxD5pkpJKSATOPrL+2UaFZDYuMSqFZrJDNr+E4dF2X5MUGAGS4iO/X3J
	8NhrWOU8dBXXKm910gkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBMN-0004fR-A8; Wed, 09 Jan 2019 10:45:19 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBMJ-0004eq-9Q
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:45:17 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so3135093pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 02:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=67GrVLf7hFi9VONq8bTSm/8BTwQn+GCaptdda3hBrtA=;
 b=N5TAwlETy5C2HosyyXtrGopuNGBfWBLXK2DNG5mSSJxLOjJK8PRvwExsX3XUv4CLzM
 cY4UQc3nTBoEt5vOk2+ierhTQWTFnfH1IK1JCsHuO6bGoV7mgHaLeuul8RKpjortFRNz
 Agmt9sgnJKdSipg0jVWkhMN9u5mAzOUrgW0EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=67GrVLf7hFi9VONq8bTSm/8BTwQn+GCaptdda3hBrtA=;
 b=FpIUtk0IysomNZcdbw3ywLL7vU/+eXm7dNjcc++4YKLmD/NcTzI15A4zk/kOkf5sWp
 xWQXmctOSR59NA097nrR8XhTBVmhqjOJaTLbjovVPH71m44s96jEo6Af7xQUpCdCuk/k
 TPqJ2YtcJA3rkvdzVdEtdEvfZUtvMOX4e0Ss0RsooubrW3NXmhpw4TUTmHhnNquOorUX
 u/6k2kMOg37QEdKt/sXsBoK7k/+MseAzfj8aCu4lii5uS9PO3yyyjNizZNiMoiS9RWUs
 NxWCTX29KRhCCfq9NBT5rAbS0QM7B9KiP5PBqse9tBsib6KA5N+JjpwZUnE3WsD1TvGD
 QV4Q==
X-Gm-Message-State: AJcUukdSmxPiU938eGU8O/RSpdn+NXxFL3EPtRgkAhHCPGUou7OTMz7n
 x2Xdepv/tq4OAEcp5hdYlZZNDA==
X-Google-Smtp-Source: ALg8bN4S90W6A9tOkdCZTh7Jpa0HU0vimgVjXgqikQK3BpZn6qJnDfaBAwBFIrc4C4XDzTEjH3s+GA==
X-Received: by 2002:a62:cd44:: with SMTP id o65mr5435769pfg.222.1547030714197; 
 Wed, 09 Jan 2019 02:45:14 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id a4sm81235549pgv.70.2019.01.09.02.45.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 02:45:13 -0800 (PST)
Date: Wed, 9 Jan 2019 16:15:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Message-ID: <20190109104511.mi3gtdcytkky4eyn@vireshk-i7>
References: <20190109104236.6532-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109104236.6532-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_024515_347188_414F5B5D 
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
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 qais.yousef@arm.com, sudeep.holla@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09-01-19, 10:42, Quentin Perret wrote:
> The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> frequency changes to provide scale-invariant load-tracking signals to
> the scheduler. However, in the slow path, it does so while specifying
> the current and max frequencies in different units, hence resulting in a
> broken freq_scale factor.
> 
> Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> frequency table.
> 
> Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> message protocol")
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 50b1551ba894..3f0693439486 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	int ret;
>  	struct scmi_data *priv = policy->driver_data;
>  	struct scmi_perf_ops *perf_ops = handle->perf_ops;
> -	u64 freq = policy->freq_table[index].frequency * 1000;
> +	u64 freq = policy->freq_table[index].frequency;
>  
> -	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
> +	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
>  	if (!ret)
>  		arch_set_freq_scale(policy->related_cpus, freq,
>  				    policy->cpuinfo.max_freq);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
