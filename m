Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CAEC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:22:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3472146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hOS6Qeh8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvfmLVQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3472146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fhFsWVLIDgTylCQSbY6pIflfiVfk2luNBkI3Pio/5no=; b=hOS6Qeh8wysNLP
	K/y5r26rj83mC/bbJI0rky9otSzrk1nUY8tuziIwjDke7AhWuLeZ0an4BmilhkQdBAU2yH+R11p4j
	F7urZYn5zQziVaSiJMCAH2a7zkTFM0R3RGctUOb9mSc0s9KARdwuI8g5Nxei4ymer0lwbIksKBN+J
	EEG04zpzY3J3jkrfek9e/8mk3nqyBbtItKJstoaGMdv4VCosZftTLTMr9Bq4FGThZmM1FnI5CoDkE
	ZWz5hSkWAXwl/XR8sggIPz7b0+5TEHIvOMmwp4sho9udyXlUjZOBEV+QEeHOeM8X9fnIgWYpQ7e9X
	BT9w9wVTEhYy+mDbInPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8my-0002ir-2P; Tue, 04 Dec 2018 11:22:52 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8mt-0002iK-BW
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:22:49 +0000
Received: by mail-it1-x143.google.com with SMTP id a6so13786542itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3P1d5DDIqUFxdjGVz7UNRAh88NVQDvbfKe5TEQrIqh8=;
 b=dvfmLVQNGi2t8nbRsNtKEl8bqDkR/wLUQ2uht/NtAmjXnR9i8CTpi2hmJUl7m5w2Kn
 F34Ly9d8zgXQoKFs2KavJkGPvWo5OhMSjqBVp/8WAhNrrqihjXeQdR0n14DLpNjv6Hy0
 Tdas0YeLMwEzBeQplvT/8ek+jqavbt6IC9NGar7jFpewzRO7VRSOBry4gNg2B+BE7kl4
 jEbZQQh6mJGKQ967alF42vGBDDvY/9Blp7qDfgK4F2IESIKopY7p4mLIrRCCnSWgLgCn
 ZhCxsAtOxfqej2dmgp3vAZj0g7VzVShLnjibSCMgcYXAvWt/1+RXhjFNdvrAwFTtox63
 m1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3P1d5DDIqUFxdjGVz7UNRAh88NVQDvbfKe5TEQrIqh8=;
 b=ejJ+vnXTviMjBA6LNZx3DDq9+GndhajDzT7EOYBGb8XvPdcVKLTRwifsJ8f8F1RTVb
 8zt8VZwl/63LTXbJArpJ4Cm3nZe98RwmNlZo4OSaNAhaZeLRCzWWP3Fj3jlrzhQNFcop
 NRHVnmii67EFJ4RB6JnjEiBFjAvtpRBcBXuSzpKkVW7gBwb3PTspyPOeTecEfq+C4Mar
 J2lJ2EkE363PhGfpcfuFqezErHTinewl7E5BdwhjaXY4tZ44WQQBtOmI3vCw0XjIkez4
 IlviRKFrW6yNaxuCac+Z9SOgLrMNFEwv4dgEekoRWwd7E9xlgJYhF2vktbgVp1zzcNVQ
 GFLQ==
X-Gm-Message-State: AA+aEWbNPRjJVOCwO3ITsoLnVUV/3ddJrA4nNVevbueO4/uMpdrjtw/K
 79KY/n3s+fky9fZXJeknUWQ=
X-Google-Smtp-Source: AFSGD/XCM6bm8sojSMqOSC2M/56CoNhESJbEO1G5zRYIpkHn3FDr0TDb2qMsZ95SLxLp2r0t5v97iw==
X-Received: by 2002:a02:89dd:: with SMTP id e29mr18658617jak.21.1543922556160; 
 Tue, 04 Dec 2018 03:22:36 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-165-221.pppoe.mtu-net.ru.
 [91.79.165.221])
 by smtp.googlemail.com with ESMTPSA id r11sm6631108iog.46.2018.12.04.03.22.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 03:22:35 -0800 (PST)
Subject: Re: [PATCH 12/19] cpufreq: tegra124: extend to support Tegra210
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-13-josephl@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c4f34e85-052b-f3a3-a6ea-715d1971335c@gmail.com>
Date: Tue, 4 Dec 2018 14:22:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-13-josephl@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_032247_415953_93732BEF 
X-CRM114-Status: GOOD (  18.49  )
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
Cc: linux-tegra@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04.12.2018 12:25, Joseph Lo wrote:
> Tegra210 uses the same methodology as Tegra124 for CPUFreq controlling
> that based on DFLL clock. So extending this driver to support Tegra210.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 448d00763d00..1af955fb715c 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -159,7 +159,8 @@ static int __init tegra_cpufreq_init(void)
>  	int ret;
>  	struct platform_device *pdev;
>  
> -	if (!of_machine_is_compatible("nvidia,tegra124"))
> +	if (!(of_machine_is_compatible("nvidia,tegra124") ||
> +		of_machine_is_compatible("nvidia,tegra210")))
>  		return -ENODEV;
>  
>  	/*
> 

Seems that's not enough, you also need to blacklist "nvidia,tegra210" in the drivers/cpufreq/cpufreq-dt-platdev.c

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
