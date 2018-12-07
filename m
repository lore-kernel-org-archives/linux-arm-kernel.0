Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B6C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:55:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABA02081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HBFA1wjF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kAYGhslp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABA02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3wxAsKPYY0ERqgF/K+ihcbchlmVdf5GGBOy5z2G03Gg=; b=HBFA1wjFFBXCQ8
	KoqGBxkWoBVU8o9LbfLyz6auSMM/g096Sf5naiTAspZS3Gn9mo2aEIA/xy/Vq6EPwUdQfLmr+0AqM
	eZOTe4qeF1vVR3j5fF8TMFnmmGdONO/EIc4G89bXIQwn62OighyBupvtxSxcU3Ihfg49vkUzzVw9w
	shXw8CLojE+reJ2A0vWctHL7xNXMNk9+8TNCZfoKzFKklRzD9TG8p+K8Q0ky9jiX/iyUiX0ab/ySA
	DEw4sFU4rq6alJONS5U+2anL99BXVms3DeUIj8XkWXED6rqFtmJ9TfYK2gvpTSV88UU8rLmef7kvh
	dQZINp6T74O1Ism2K/NA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHXk-0005UF-P2; Fri, 07 Dec 2018 14:55:52 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHXe-0005TB-MZ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:55:50 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0a89e70001>; Fri, 07 Dec 2018 06:55:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 06:55:36 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 06:55:36 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 14:55:34 +0000
Subject: Re: [PATCH 15/19] arm64: dts: tegra210-p2597: add pinmux for
 PWM-based DFLL support
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-16-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <42aa5b73-cd1f-5a2f-249f-589bb1319fc0@nvidia.com>
Date: Fri, 7 Dec 2018 14:55:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-16-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544194536; bh=a1QclYpHK8Ge4XDuB5UtBQksdbhLVdRoWZFyc7FRLtw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=kAYGhslpAL4DfDzG/yWp9virSCQIJP0+qGGyIvtA0voFL5u/uYBKIZzB5nYcJJHhW
 q622fWvvyiC5nBSqikVlsa/B3S1vWb/YoY/BqxljP+tbWvze5Qq2yl3bR8qwVHAr27
 t9zaMch8L0RrpnCe3t9bx2pQRhCbeAq5TE9jowXdnscb1aF/0/8GOsHEZWrdxp+Qu7
 qqQD6hJn31v37V/8DaPQmURLFUfZsMvgcIAJKGtBG32+IF4olEWrK7lAJ7TYJKBO5G
 TbC0RmVfgkH4ChS1ZI4jeLjjzLLAlizakxdUccwqZQgO6GkO1yGQi2R2tpo8bv9uCX
 kvaN9eIsOTN8w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_065546_750648_280FA144 
X-CRM114-Status: GOOD (  12.24  )
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
> Add pinmux for PWM-based DFLL support.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> index 365726ddd418..db5dc0ad466d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> @@ -1278,6 +1278,20 @@
>  				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
>  			};
>  		};
> +
> +		dvfs_pwm_active_state: dvfs_pwm_active {
> +			dvfs_pwm_pbb1 {
> +				nvidia,pins = "dvfs_pwm_pbb1";
> +				nvidia,tristate = <TEGRA_PIN_DISABLE>;
> +			};
> +		};
> +
> +		dvfs_pwm_inactive_state: dvfs_pwm_inactive {
> +			dvfs_pwm_pbb1 {
> +				nvidia,pins = "dvfs_pwm_pbb1";
> +				nvidia,tristate = <TEGRA_PIN_ENABLE>;
> +			};
> +		};
>  	};
>  
>  	pwm@7000a000 {
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
