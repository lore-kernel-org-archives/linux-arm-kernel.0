Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD59C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:39:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891962081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mrUHOt0a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuXGc6eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891962081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2fRu2jH2k1hqxNEvaxFig6SK2520mq//8ii3bobGYoE=; b=mrUHOt0aqjXhgx
	f9RLvnhw4zLZ0jcnvyZpCHmwA8kssF+4z16jQqojOF5bhkFVfSZW69X174G6XJ0QzOQ4eBvWbnSjg
	T3nlHzn6P2dmfp+Vcpew4/TtYpSL2IKMX0RweRrGADTRXnveK3sulx9ieFq1bEEuOjNAxWUBAKZg1
	i+k82J9BRYwNUSlPCYGmyCov2RTWmyIjGp5tCWlMP7MmgDZXc1PdKD6U8FZ5M4fDk2TgEhvq4NNfK
	kZ/n3plsbgYdyuXtSm4w4a+6UdHZu1sEz6SPHi67PmgF1dTB0+gRJoyoeCdC+Avo0IY7soRo0yrue
	VZdvkdOkOxDcM6TEeLMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gULE9-0002Kc-3p; Wed, 05 Dec 2018 00:39:45 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gULE6-0002GA-Au
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 00:39:44 +0000
Received: by mail-wr1-x441.google.com with SMTP id p4so17834582wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 16:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=k/3cE4rCN9+eLwAO3lu4KxUEsOiK0ad9DJriKIqnR6I=;
 b=RuXGc6eqXjW/8RKLBuVemvjuppJ3H1T/mMRQX+H34B/tu51HFV68Wvxpwmk9OuD9zq
 MeBtlcQmBT6v2KRVEh8xZufbJYttn06dLMD4LVhtfI8gGJW5l1BXI97MvhlezUT3KCGc
 1uExx4jy4BvRaVCeU0GUfTsFfstdr/HPBZOXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=k/3cE4rCN9+eLwAO3lu4KxUEsOiK0ad9DJriKIqnR6I=;
 b=Ev2zkjKlyeZg5Xyg2XUQdRk/aDHlK/kJ8DbpT3aJFmErL7lySSBMp7lAma8ngTtQgM
 VOm0i3roXS8OQVPwoBEiRrpXVMaVL+fLv9AZ15F2AFZOLqdkJSI8S8mL3UypqwEfv7Xm
 mQd+rGPVwl+qccueyhN3NVR3+qbzWwOy2QMd6o6TUxqw1TZjmw4OgbZqZEpdRdj7x37t
 YMFlwLa2JquL26pp3ETSYSjy82bukvcVZaimZ89ptsqCRQYx1c1CzxbYk3eY/UdGu+hy
 eqe+UXHDaDOAuQnB3KngtFsTUuYFYcT1z2OE96Z0n3i5JEqXhl1VjEwwUVEHjz//m8XG
 QZPA==
X-Gm-Message-State: AA+aEWac2sf5WWcpAD8ATMW7aF2ZCduuQuz7G6jerorCC+9LwciJ0kn6
 1FNRJcFVLbCNaszrcn58nEWmuA==
X-Google-Smtp-Source: AFSGD/XV5wE3XWClPP3b249uQPUL8fKgBt5VQEPysWjKCWernyOQ9wlo3GbJRODNCYpZlZFZ7+1Kyw==
X-Received: by 2002:adf:fa90:: with SMTP id h16mr4609495wrr.326.1543970368643; 
 Tue, 04 Dec 2018 16:39:28 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id j8sm15329980wmd.0.2018.12.04.16.39.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 16:39:27 -0800 (PST)
Date: Wed, 5 Dec 2018 08:39:21 +0800
From: leo.yan@linaro.org
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] coresight: stm: remove set but not used variable
 'res_size'
Message-ID: <20181205003921.GC11628@leoy-ThinkPad-X240s>
References: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_163942_377644_B1229B52 
X-CRM114-Status: GOOD (  15.47  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 01, 2018 at 08:39:45AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/hwtracing/coresight/coresight-stm.c: In function 'stm_probe':
> drivers/hwtracing/coresight/coresight-stm.c:796:9: warning:
>  variable 'res_size' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit
> 237483aa5cf4 ("coresight: stm: adding driver for CoreSight STM component")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

FWIW, Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index ef339ff..f07825d 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -793,7 +793,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct stm_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct resource ch_res;
> -	size_t res_size, bitmap_size;
> +	size_t bitmap_size;
>  	struct coresight_desc desc = { 0 };
>  	struct device_node *np = adev->dev.of_node;
>  
> @@ -833,15 +833,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	drvdata->write_bytes = stm_fundamental_data_size(drvdata);
>  
> -	if (boot_nr_channel) {
> +	if (boot_nr_channel)
>  		drvdata->numsp = boot_nr_channel;
> -		res_size = min((resource_size_t)(boot_nr_channel *
> -				  BYTES_PER_CHANNEL), resource_size(res));
> -	} else {
> +	else
>  		drvdata->numsp = stm_num_stimulus_port(drvdata);
> -		res_size = min((resource_size_t)(drvdata->numsp *
> -				 BYTES_PER_CHANNEL), resource_size(res));
> -	}
> +
>  	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
>  
>  	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
> 
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
