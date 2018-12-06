Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4505C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:13:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78974208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ITIqw/fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78974208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6gxzzVARyeeIDlyKfzOrwGpBwfy1xbVNiDqUck2oY4U=; b=ITIqw/fz0PqG2E
	rzSbR0kkA/LJqOYxc/WTWZCI/gz/ftujP9ZpvvWrW25AOfdSqaJyiLaGz2bIKKCXfQ1KabI3E2WMn
	y44NcrY/8TkNPs+nYXdXbbU4A3G34RAAOapAMgnABEV7JcIa0e/b6XOyW701TVpMilOVdIEdzT67Z
	qyqDuQHO9sXT0cNDoEsLlx94AmGd/rzHkuffydMkd8MLyLDCepo8TN59xBFBpfzuJ4WHfxVcujBSv
	7AuYCHvLPWMM87vwuwRTw9wRTA2RHf611a4cVgB+5bLt2w8fnRLOfpe0BeHW5T8Bubj9+a9whnkg7
	B3CRm7H6xycPiOcMDcEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUz5n-0001y0-0z; Thu, 06 Dec 2018 19:13:47 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUz5k-0001ww-52
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 19:13:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4791EA78;
 Thu,  6 Dec 2018 11:13:33 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 16FC63F59C;
 Thu,  6 Dec 2018 11:13:33 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 37A601AE0BAD; Thu,  6 Dec 2018 19:13:54 +0000 (GMT)
Date: Thu, 6 Dec 2018 19:13:54 +0000
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: sunxi: Fix PMU compatible strings
Message-ID: <20181206191353.GA20680@arm.com>
References: <20181206191142.14118-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206191142.14118-1-robh@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_111344_194170_C50CD5E6 
X-CRM114-Status: GOOD (  16.24  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, devicetree@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 01:11:42PM -0600, Rob Herring wrote:
> "arm,cortex-a15-pmu" is not a valid fallback compatible string for an
> Cortex-A7 PMU, so drop it.
> 
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 2 +-
>  arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index a960b8ef7822..9e7931d5e42a 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -202,7 +202,7 @@
>  	};
>  
>  	pmu {
> -		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> +		compatible = "arm,cortex-a7-pmu";
>  		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 3c571dc599c3..5e413a5d9f6d 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -199,7 +199,7 @@
>  	};
>  
>  	pmu {
> -		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> +		compatible = "arm,cortex-a7-pmu";
>  		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;

Acked-by: Will Deacon <will.deacon@arm.com>

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
