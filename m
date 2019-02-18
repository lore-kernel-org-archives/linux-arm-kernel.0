Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D511FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:53:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4198218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qELoQk7w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBXtpmA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4198218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CAY4ob2ZFQA0oxUrQieKJW7eRagQcedwY/TOw1lApAE=; b=qELoQk7wDDr90H
	6dg/UrO/4epxZIYKyJnO7qDcS/GCsPk7uDo++Pa2p7dDqT8GPObGokJpg7YI3GmyxyyDIsSH9YXFe
	fAJFD+mB+ZG4p4lh1eYC00pvJ/HoVVNQbH9kcl3H5PZU/Igd9RZbjLAu+VX6dANmaQR/1FcEL4qPf
	DxxaGi1LyrKIfkKZ8Fw38ZWBsCHG5AYczJPT/Pb5o5CpSly65vo3WgbqMTNyILWqIu8cn43DCxJXk
	9g7JexrJmSxnBWTRC8E66X+RL4SY666prop+7DLuYx76/t+Fk5JkP/8NbMn9rTgn5yLWzkoV6B//I
	IWQ64RrV154pUEjGS1OQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvavx-0001gk-Q0; Mon, 18 Feb 2019 04:53:37 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvavu-0001gP-HG
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 04:53:36 +0000
Received: by mail-pl1-x644.google.com with SMTP id c4so3090259pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 20:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=j86UcfahKzsFa6NJtZ03NxMBaTCekIZNcioiQ8oFeYU=;
 b=LBXtpmA60N52gDa+seH5jDoL6QW2F6DebYVZbyyEucVuLun4F+/SozFJgjl45In7da
 41E2RJsX19yQX08JQDc/HdQPGqsFHFxPGoH1yc+n0ApRgj2Z8GaVBr5WLcwZ0nOzpA/d
 /kwtLrg+G1akRLc5gJggcmD9Fss1BKza+ul0NjBhiP8Y6em9c/as8OZWbEuvVEspbxmI
 62mBYR+Xo/mg+DtG2zU2GPVuMdTXJl9BV4utFK0zbkDp8wrr1Eu+Jl6V071TMBMWfuhA
 gzAVWEFv6zEvn/U7EqeMFYUtPSJpDd1IH4FYVIPXTTU/Mp2hk1x5sWknO7Di/xI9hLj0
 qSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=j86UcfahKzsFa6NJtZ03NxMBaTCekIZNcioiQ8oFeYU=;
 b=mZDkhAfa+LQakzxg55Byhcnu6JQUBaaMv7jOZKlZIQ55Pg585mCEMbuFloo0I54t7P
 FyZCO0qzUEHNs7aOM7htAPianrAXSFrevTENRpB6/qTUD360loHxvKqFjTBCRuPbzPbT
 HPhecBmy2DmDy4i4Di9TEm/bkXp0MWNHWbHYhyFGA8RiL1lj7HHg0Io5k2D9Lwqu2Az2
 NzlmXyIOl4+ZUWOjKAPtRjNS4cpD6NLvZbpetoZ8NdI68nyZwb1qNTsBcnhpdVql0qoJ
 iCoXNYm8C8QIvP68qThibMT+VOBMHSWJa/5TWSZOtPP2M1rSwluCm8xz3qu4cOUFDvtV
 eA+g==
X-Gm-Message-State: AHQUAuYK/bX93ITmDZt1F7gQs4F6INyd+o5lrkhad76qmsq1TpZaLRgV
 9nvNWJR9pWuXPGGBy2mkOXPs+w==
X-Google-Smtp-Source: AHgI3IbuhWpSM85Pnea4k/eny8phFUFt9I/rmezmrqyac75qyM2gu4PG5aDj3K9H6Qh5rgZEwegekA==
X-Received: by 2002:a17:902:be15:: with SMTP id
 r21mr21220479pls.143.1550465613006; 
 Sun, 17 Feb 2019 20:53:33 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id y21sm14522494pfe.57.2019.02.17.20.53.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 20:53:32 -0800 (PST)
Date: Mon, 18 Feb 2019 10:23:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] cpufreq: scmi: fix use-after-free in scmi_cpufreq_exit()
Message-ID: <20190218045330.zpiivw7mvv4hzctq@vireshk-i7>
References: <20190216163148.12375-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190216163148.12375-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_205334_604272_A1BEAC38 
X-CRM114-Status: GOOD (  17.00  )
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
 linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 16-02-19, 11:31, Yangtao Li wrote:
> This issue was detected with the help of Coccinelle. So
> change the order of function calls to fix it.
> 
> Fixes: 1690d8bb91e37 (cpufreq: scpi/scmi: Fix freeing of dynamic OPPs)
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 242c3370544e..9ed46d188cb5 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -187,8 +187,8 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
>  
>  	cpufreq_cooling_unregister(priv->cdev);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> -	kfree(priv);
>  	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
> +	kfree(priv);
>  
>  	return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: Please pick it up for 5.0-rc8 as the bug was introduced
during 5.0 cycle only.

The patch it fixes had this tag:

    Cc: 4.20 <stable@vger.kernel.org> # v4.20

And so will get applied to 4.20.N, I guess we need to mark this patch
as well for stable then.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
