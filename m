Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC47CC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:52:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992752133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ETa6zHRb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMdYNz68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992752133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NYAZIJc4PM3Ik5lGU35euK3kBw2O1jas7MiC2yA7nPY=; b=ETa6zHRbgi+X+K
	m3/07RnSAxvnY084IXvUbR11QtHwTrWb45QWX1YSGlYLtI776b3q+CIgR9LUdyRDizcP9v1JJ01px
	44LJkGJJj+YVUTp3VKr/5cxOAgDUf3wLQ1117uK3eEPzJMN0r9m3enGx7wY6XFSMxo7Juv7Sl1dFO
	SevE3hGnfW4DlQPTiJtRdGVx1fx6HG59XHG+K2SfSTObjp/qY62RNfzLAxHbeTNf3APytmuyepq/8
	cQ7d5v1t7eRMKIKIGAy8KuEwgacLqmny8tM65F5Trw8BCD9a9heXfYxQIOV5Zm2p92mm+KGtgZOiW
	SwUSxIVSGgA7X6rVoFuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1vE-0007UV-Up; Fri, 11 Jan 2019 18:52:48 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1vC-0007U5-4Q
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:52:47 +0000
Received: by mail-pg1-x543.google.com with SMTP id w7so6651169pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fkP7KSO3NnYaf3RE7vBcqke3e+ie8uaZNN3XWfX5JfI=;
 b=MMdYNz68V2eQ6qhbcfnjC4OwK9noyptl3TDZvf4dSghRT0U9vhTUoOwPnClglF2MEW
 9iVgPlsm7QPFulsP8Hb9j51goHvpUSc4i1nAaQNE/hCb8w6llaItEk60qwO2ixqRPyef
 TcyZdDcG3htPagLln/iZQhjrA24E/KPNJanXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fkP7KSO3NnYaf3RE7vBcqke3e+ie8uaZNN3XWfX5JfI=;
 b=cP/xcmQY8UcPiRf156yAJg8I7zGNV1d3IDdrKAUeLQCbSheBkrupGwp5Teh/P/2+HC
 94bzHPTDSO5gkv1+coLsSBTE4yG/LHmGyrkWGbfQc8CuxZjNIn0mon68xXJVnlQS8HdE
 oG8LpoEbsdaYZoxH4D7QMFMLltRXE8pfNUy1wEK9Ylr2o3sOdRF1vpXQM8HHgEHhmTkO
 4PkXWs/wpXtAqCEs4216uppylgrj7RS3dxESsfFg8DT1l6MD99lZONg/hMDsl1YK52n3
 nMI56ID6WnY4U3JZqJahvvdMJ5jHVkeezJ7zluQgTbr+oDMPlT0oWclyQA2MCgxH0/K9
 4dJQ==
X-Gm-Message-State: AJcUuke77cu7P0c77ZJyD133FpuiYGT5zDU/rmgDLqyLl1sG+Em8x4hu
 7CfWJ5R9QXsURFn438WZFOqbFg==
X-Google-Smtp-Source: ALg8bN62UX24xjnS6ISv4Cp7pxuePTmaXC70wW5Kaq3x0/29OMmmT6QAos1AyloFhHl22LDT1Bk/Bw==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr14153015pgh.394.1547232765484; 
 Fri, 11 Jan 2019 10:52:45 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id f67sm118770644pfc.141.2019.01.11.10.52.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 10:52:44 -0800 (PST)
Date: Fri, 11 Jan 2019 11:52:42 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 2/3] coresight: etm4x: Add support to enable ETMv4.2
Message-ID: <20190111185242.GB22691@xps15>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <4cb23e3bc414f3a1cac555d27b93e7e8cfeb68c9.1547054308.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4cb23e3bc414f3a1cac555d27b93e7e8cfeb68c9.1547054308.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_105246_179126_D044B722 
X-CRM114-Status: GOOD (  20.86  )
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
 Rajendra Nayak <rnayak@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 11:16:48PM +0530, Sai Prakash Ranjan wrote:
> SDM845 has ETMv4.2 and can use the existing etm4x driver.
> But the current etm driver checks only for ETMv4.0 and
> errors out for other etm4x versions. This patch adds this
> missing support to enable SoC's with ETMv4x to use same
> driver by checking only the ETM architecture major version
> number.
> 
> Without this change, we get below error during etm probe:
> 
> / # dmesg | grep etm
> [    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
> [    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
> [    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
> [    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
> [    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
> [    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
> [    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
> [    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22
> 
> With this change, etm probe is successful:
> 
> / # dmesg | grep coresight
> [    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
> [    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
> [    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
> [    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
> [    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
> [    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
> [    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
> [    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 53e2fb6e86f6..40cf17df5023 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1021,7 +1021,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	cpus_read_unlock();
>  
> -	if (etm4_arch_supported(drvdata->arch) == false) {
> +	if (etm4_arch_supported(drvdata->arch >> 4) == false) {

I think it would be better to simply mask out the minor version number bits in
function etm4_arch_supported().  That way we can add more intelligence in there 
in the future if we have to and we don't have to touch the calling code again.

Thanks,
Mathieu

>  		ret = -EINVAL;
>  		goto err_arch_supported;
>  	}
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 52786e9d8926..05d4bd330881 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -136,7 +136,7 @@
>  #define ETM_MAX_RES_SEL			16
>  #define ETM_MAX_SS_CMP			8
>  
> -#define ETM_ARCH_V4			0x40
> +#define ETM_ARCH_V4			0x4
>  #define ETMv4_SYNC_MASK			0x1F
>  #define ETM_CYC_THRESHOLD_MASK		0xFFF
>  #define ETM_CYC_THRESHOLD_DEFAULT       0x100
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
