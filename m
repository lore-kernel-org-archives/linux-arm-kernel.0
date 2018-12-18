Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB4FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:33:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C948217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VjtJLQ1J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eovQR+VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C948217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=We8qF8ygVYWZppK0YA9v10uCc+4jTJZCvGNqlKHybFo=; b=VjtJLQ1JXPXBSu
	bvAfh+kSjikfqIxToZd6o6kmje29ukeE7pYlOXTYiDfK9qnl5dzx+wmD5TccvJCTgFcHTA41+Tyzh
	d1hdRhVBJy89hKC+wlgR2CLjHiDHzwrtbXD8BeM75I8RAFFnRZvfiABZwKml6Iv7s6fsV58GqD6Ez
	/xOXUQYE93Dccn2kr+R3v/XTy5TfyP7yGpw6mtQd8CG6oohxo32WUJm86rKJkvUs0IjId6lSfUNdC
	2yExlYsVWFJhTGXNzwLyynlbRGPvNZbldnZWwnT7+/cKKH6M32+cqCGQ/hef+VGyQCdyUUeMOwNyD
	dx2luUJ8QpuOKmojMuRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ80u-0006PB-9l; Tue, 18 Dec 2018 05:33:52 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ80q-0006O5-KU
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 05:33:50 +0000
Received: by mail-pf1-x444.google.com with SMTP id c123so7577133pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 21:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KfqIkLeu2m5/AiyRCmid2VCatuc3NoK4silY2Vg5r64=;
 b=eovQR+VA1BqotdlxY1myyFmhBc9cnl20G1dhm+peLfbQS6O3AjhVK+Q6fW0jIm0hPB
 AZV+QLxGs772IHdGukc3OxwEOsVFponusnFIxB9X/Ui4KgvTob8Wkv/SP6CJqWloJVNU
 H21N1Zu/Ac1tI9GpC5zoByRidk+jR12yLW+Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KfqIkLeu2m5/AiyRCmid2VCatuc3NoK4silY2Vg5r64=;
 b=L4jshtDFRPG/YED+YXpjsKJBGNj18j/85UY0cgQo1pY2GTFNjPKKTr2/Tps4bEy0eS
 C6+1iUo9Z1FuYTN9JjQborITK5rHW17bspauTxelO4+TwRGd9IYMgNleBd7gzcG4XaBU
 X2k5cGdezxgwK9sfrZj0z1mN/jTP5Dk5XBS2rrd/n1XR8kRj7aeTQKSHvle56CMDPVZp
 qUSrBeLvXkYvsV3SxIW0jBtv4bl2VKFYBiX/H8EMCbkpoaZKsctN7Nw2umf1TaZf8/uV
 2Kbck0FqXiLeC+QrA+MpsqqESz82A0sWQ8GbwsxIdaOvtfETFMWSS+e+iNyjCPSRQcUY
 L8Jg==
X-Gm-Message-State: AA+aEWaWGQJeBg4x0pQunFODWxk/k1zhYhjIsY9A+qBe+ht1Qw2cWikN
 W74/UCD4pocVZZwjvmf/rdudWw==
X-Google-Smtp-Source: AFSGD/VqaYSgfM557ZXkezuEQLE19awWxL8cGX9MVBJT/xlZpr75J/yvDXHtcw7uclpXg+oTlk78zA==
X-Received: by 2002:a62:6cc8:: with SMTP id h191mr16167410pfc.89.1545111217495; 
 Mon, 17 Dec 2018 21:33:37 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id q1sm20270307pfb.96.2018.12.17.21.33.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 21:33:36 -0800 (PST)
Date: Tue, 18 Dec 2018 11:03:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V2 14/21] cpufreq: dt-platdev: add Tegra210 to blacklist
Message-ID: <20181218053333.5qqz4gerxs6vd3wx@vireshk-i7>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-15-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213093438.29621-15-josephl@nvidia.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_213348_681788_FD9D958C 
X-CRM114-Status: GOOD (  16.45  )
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
Cc: linux-pm@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13-12-18, 17:34, Joseph Lo wrote:
> Tegra210 uses "tegra124-cpufreq" platform driver to register device data
> for "cpufreq-dt" driver. So add it in the blacklist for
> "cpufreq-dt-platdev" driver to drop that.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V2:
>  - new added in V2
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index b1c5468dca16..47729a22c159 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -119,6 +119,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "mediatek,mt8176", },
>  
>  	{ .compatible = "nvidia,tegra124", },
> +	{ .compatible = "nvidia,tegra210", },
>  
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
