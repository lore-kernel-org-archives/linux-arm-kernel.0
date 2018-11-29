Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB3C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:45:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6922082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZsNaY3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6922082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=whGJlFXRh59/SXKvzILUYK0O+8cg3w/84oNbqKdTjSA=; b=aZsNaY3oZJmiXM
	cIFaetLcuFSSyWKW9cfRhg1VN8y0VEbbXMf61RMhX1E134BpWbJwBJ/f1T/2fIBBNLHek8d1WQfYQ
	o4C5PxwdDrwiCOWuJBJACmFCVukZHUhDM6GQBD5HfBV+sNkSdsPC3PU3sArNq3/tIg0+UyMkX47Zy
	FvmnFtyzzLSwirotqJqhAIhHZ6uR9kKUzz1eNnFUAwK26ZiXSI1VbIgc5cBLVpWuWJwVxDSl4rT7P
	xzFwe5vPU9/On+niBUeFfUwiDPLf0SDgUTwVGERHbvfmgV6VJYElTOn+jkNJow1whkzO2kf4D3Ffr
	neOjSaOC4iNR9KPkdxlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOVV-0003on-D3; Thu, 29 Nov 2018 15:45:37 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOVO-0003gI-Vx
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:45:35 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 061C188CC4085;
 Thu, 29 Nov 2018 23:45:14 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:45:14 +0800
Subject: Re: [PATCH 05/10] ARM64: dts: hisilicon: Add all CPUs in cooling maps
To: Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, <arm@kernel.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <89bb8c62404aa875d597da89c18852ce81fb9f26.1542362530.git.viresh.kumar@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C000983.3030609@hisilicon.com>
Date: Thu, 29 Nov 2018 15:45:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <89bb8c62404aa875d597da89c18852ce81fb9f26.1542362530.git.viresh.kumar@linaro.org>
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_074531_182661_C179E010 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Viresh,

On 2018/11/16 10:04, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
> 
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
> 
> Update cooling maps to include all devices affected by individual trip
> points.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++--
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  9 ++++++++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index d943a96eedee..20ae40df61d5 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1118,12 +1118,18 @@
>  					map0 {
>  						trip = <&target>;
>  						contribution = <1024>;
> -						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					};
>  					map1 {
>  						trip = <&target>;
>  						contribution = <512>;
> -						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					};
>  				};
>  			};
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 97d5bf2c6ec5..aec9e371c2a7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -893,7 +893,14 @@
>  				cooling-maps {
>  					map0 {
>  						trip = <&target>;
> -						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					};
>  				};
>  			};
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
