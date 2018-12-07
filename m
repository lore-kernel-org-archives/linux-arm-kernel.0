Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BE6C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:58:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C282B20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S294rzyn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R0c+7fnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C282B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T7XmHRwQd9QybN4Dd0nMLOMjlqLAgvhi559hGraNMPA=; b=S294rzynMHLgB6
	iboHI5fGumTLtQcI5EiFZTbkN43wlzObQyE/Mp47EKJ6rF246oQjGYYbXuNT5v7OqgpO6NIoai4co
	lsG3Qj3NOd+g/MAi235yY39hogVwFUm4y6VOIw2TCl5Q77cagZvSK22WIxc5DiLE175Zl2CpGfRlc
	/x5RPwm2isMi7FCAxUHs4JeH4ON6q1SgITkV6avu4uRf057rKGYURwa0pbufxTwlbwzCsoDh8GMFa
	I3syU6D7Axmai6d6kP3PBHvI8wKD97JgCyuPJN33rWeWfOMV8SxzLy7fD8ILuURTEuK7VlB1mwyiI
	TizTi/mReJfNh5EGIk6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHaC-0006UB-Iz; Fri, 07 Dec 2018 14:58:24 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHZw-0006Fx-Jn
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:58:12 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0a8a740000>; Fri, 07 Dec 2018 06:57:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 06:57:58 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 06:57:58 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 14:57:56 +0000
Subject: Re: [PATCH 16/19] arm64: dts: tegra210-p2371-2180: enable DFLL clock
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-17-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <827e05c8-13b9-fb5e-7bca-1a34b81763b1@nvidia.com>
Date: Fri, 7 Dec 2018 14:57:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-17-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544194676; bh=TNEe3kQ464dHXwoDAnrfkKikSkHe9SI3XZd3DG+gh1M=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=R0c+7fnvs48nrGLhoACMAvWze2YNieLqqlxVKQ9eKj0/LnWgN01e2Zy82g+lHv5wi
 VvIVM8BqFCa6AGunnOAAoWuDDg8g/z+d0hwmiavc6n4d++hZw3qRHloZ9HWfC7nanG
 y9bXJRYriOIAgN7bK5qsl2J5ooZaDHZUT08HR4Z5A9iHFKlYpsanVXB0cSVQL5rydj
 SElUtzggs9fQtnRAr+TKLfyV1p59Pb0FggpedX3ItsrKFrqvRCkrldt9u4Lhb7FDMR
 AZgBanoLIQP3Ax5Rkty1F8AseEOWVvbKlNWF0KtRwre36nDstYRXfgSvsYe0UrwgbK
 3Vw4rY1uVmSGw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_065808_869310_A2651765 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 04/12/2018 09:25, Joseph Lo wrote:
> Enable DFLL clock for Jetson TX1 platform.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  .../boot/dts/nvidia/tegra210-p2371-2180.dts   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> index 37e3c46e753f..53f497c2b3ff 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> @@ -78,4 +78,24 @@
>  			};
>  		};
>  	};
> +
> +	clock@70110000 {
> +		status = "okay";
> +		nvidia,pwm-to-pmic;
> +		nvidia,init-uv = <1000000>;
> +		nvidia,align-offset-uv = <708000>;
> +		nvidia,align-step-uv = <19200>;
> +		nvidia,sample-rate = <25000>;
> +		nvidia,droop-ctrl = <0x00000f00>;
> +		nvidia,force-mode = <1>;
> +		nvidia,cf = <6>;
> +		nvidia,ci = <0>;
> +		nvidia,cg = <2>;
> +		nvidia,idle-override;
> +		nvidia,one-shot-calibrate;

I don't see any Documentation for or usage of the above two properties.

Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
