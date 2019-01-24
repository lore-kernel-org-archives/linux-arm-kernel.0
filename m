Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DF7C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:16:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4409021872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Af2iZ432";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ygoi/SBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4409021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nxR3f7Q7dBYapJfniZJfQPUQplbG/h88smj0e0IL0qs=; b=Af2iZ4329Xh1BF
	vWaqcS2sxbWRyR9trCAmvOteM2s0CamZfqBxgsNq2hnyQaD7vy9wiDYPoE3VxYv/gS5pXatmmZeNm
	kGlApwH9ki3h7r/Wl/Uq1u0A0YsC6VSr6dFWhQsmltTKU1pmq8TAY5YFv4uUC600LS7CZensEuYjt
	0XA00IgXvITk45sSQ8+YQMQkzoDM+jwuiJWwS3zQKpKiNThsCECQ5jrp8KQ/q33xucDVI1jTw9CwV
	0cw0ZqpU0J1/kCOy/AEAPguZ2sKYRj7TUcWC0nR7bsElge38w9vxNI7ZgCOtBti5EhC3pvTQLrFgS
	ZnM09CmXuobOAT+n8TKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmczb-0004BY-6y; Thu, 24 Jan 2019 11:16:19 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmczX-0004BC-W1
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:16:17 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c499e5b0000>; Thu, 24 Jan 2019 03:15:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 24 Jan 2019 03:16:15 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 03:16:15 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 11:16:14 +0000
Subject: Re: [PATCH 3/6] arm64: dts: tegra210: fix timer node
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-4-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <867b5168-e3cb-6423-b3d2-c075d1701c88@nvidia.com>
Date: Thu, 24 Jan 2019 11:16:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107032810.13522-4-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548328540; bh=wukT3fhtTy6AxJ1st3q4P4uDJj4L5i4e8TiPulGOpKU=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Ygoi/SBTgrGXtzLeHJxC9BCg1szcy9VnhdctXAj12VBAb+zZ9tX5EOtzEHivRkgLa
 2IpxO5Kta8XnQz9kFvcJNbZ00+IVU2CCiSAntywlj4OlVV49QBlRhjDlj3dhD+idr0
 /3iA6GOY5m02AwEqOyrKcVSNEfe8LEHqP+nDOQ4Cy0NddqEnz0AQsEeny2QSlrHpAc
 Vf8nyLHkxtX6kkfnW7jyl+H22QZ1OSdHPYCc1qKBVE0NtE2DWGz19kKbfq3f8+7csl
 wkKhuqnHGN67vcY7fYoZCtw3OOSamYrV3lBN8v8y2eoeCZG+iv6fvMloyWnMEV0UYw
 rVrzPaj7/6s9A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_031616_042588_8718427B 
X-CRM114-Status: GOOD (  13.72  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 07/01/2019 03:28, Joseph Lo wrote:
> Fix timer node to make it work with Tegra210 timer driver. And backward
> compatible with the Tegra watchdog driver.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index b5858b5ea052..143bd103c923 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -384,14 +384,12 @@
>  	};
>  
>  	timer@60005000 {
> -		compatible = "nvidia,tegra210-timer", "nvidia,tegra20-timer";
> +		compatible = "nvidia,tegra210-timer", "nvidia,tegra30-timer";
>  		reg = <0x0 0x60005000 0x0 0x400>;
> -		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&tegra_car TEGRA210_CLK_TIMER>;
>  		clock-names = "timer";
>  	};

Hmmm ... I can't say I understand this. So now the timer devices are
compatible with two different drivers?

Begs the question why did we not just extend the existing tegra20-timer
rather than adding a new one?

Also you did not explain why we make them compatible with the watchdog
driver? We have other watchdogs timer and so why do we need to make them
compatible?

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
