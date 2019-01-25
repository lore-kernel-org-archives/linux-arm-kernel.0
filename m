Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6B9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:21:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A518218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o0rSG4rl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ARkmH9zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A518218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GdeCHPRQdTw7/0AGfNkyNVkFtkSd2va0+bxBQHuGwbc=; b=o0rSG4rligl15NDfRqq8DlXle
	Y2lOt+ylsAutPjfxMmD2kveXaS7J7c2YqMKe4lLerX5E5kJTntY3SWRfD7XezIyp2IQ6M0iFRgX/5
	XQIc0NUPhyCXigV2nAh1azZigRU8eJFi0iQZMbiJSFIRImYvyZ0bFZS6GVq+WGOk3Zl6goABkdS4E
	Zs/qW7gGwyKXpgKJjtAM2gQLfmxk9fTfCXy1mGQuvTcdh7fTGLWvASUJm4FBCdEZEfRzUu2SkSodV
	zxp64jlbb1SsikYdzSHlxSiawdqRXvwklPYXJkjUpP7fqh4rPOV2AMnnH4kw+FJVyR+7I/z7XDOUt
	WB1aD8g8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmszP-0005jm-IO; Fri, 25 Jan 2019 04:21:11 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmszD-0005hy-91
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 04:21:01 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4a8e860000>; Thu, 24 Jan 2019 20:20:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 24 Jan 2019 20:20:58 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 24 Jan 2019 20:20:58 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 04:20:57 +0000
Subject: Re: [PATCH] arm64: dts: tegra210-smaug: fix IRQ type of PMIC
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
References: <20190104071646.15828-1-josephl@nvidia.com>
 <20190104071646.15828-2-josephl@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <2ec955f0-b666-cdea-264b-460a87dc9847@nvidia.com>
Date: Fri, 25 Jan 2019 12:20:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104071646.15828-2-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548390022; bh=U8x2QCVpcdKSE8IZ4a28u6RKRjsHBcO92TuGm5bcJRw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ARkmH9zWE2wMCmZl7CuWdkHrp1AhC36vtoxT+VsJHygGWViEYyY6mukRZgas6BWO7
 YkS3zn8C/1dCTaXQTpfkWEjXAeTqhUOHuMATGj1DrLyyydVtSZABE1zwrIb8LnmWh2
 BRJrwk0FTTBNqsWSZnG7Onam/IxQc9EtdObxafMTyJc+bG8RTa+3XD2JFLsEellPiY
 7Bs51WhSy0WBQ/LWFUserEw1/X+BZC302Cq1Jylho2wde5vs87Ku6xTieL/Yfy7DUU
 R3VmB5AvUXYLBbwuEztuLcv7ryB/PG8FTaFkC8T0MLzOMbigY7hndaVHeFdTswTCsm
 Gy2f9djwE+QFw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_202059_429991_117EDDA6 
X-CRM114-Status: GOOD (  13.50  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jon,

Could you help me to review this patch?

Thanks,
Joseph

On 1/4/19 3:16 PM, Joseph Lo wrote:
> Fix IRQ type of PMIC which should be configured as high-level trigger.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> index c08c5471b974..5a67890cfb7a 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> @@ -1362,7 +1362,7 @@
>   		max77620: max77620@3c {
>   			compatible = "maxim,max77620";
>   			reg = <0x3c>;
> -			interrupts = <0 86 IRQ_TYPE_NONE>;
> +			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
>   
>   			#interrupt-cells = <2>;
>   			interrupt-controller;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
