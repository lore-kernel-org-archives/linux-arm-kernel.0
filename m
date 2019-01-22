Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D8EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:36:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6515020870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RceOGPMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6515020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YYNicz/fr5jaB0MH7SY1E5J+mFeSf67jkI5HGdO9FmY=; b=RceOGPMVZx3ZY97zbT45NZGqbe
	Ttz7iZ0KJkgyVZTt4vP/ODiSRyN3umYunmPDejRZ9GcGPMlgSNYu/IjUxKFlzyJyYrUt0QoPVXVph
	gGEjLfxHbPWj+UfqimhBPbJn1VRH0fV7y3tLFsi+gPRrbAv3y8V4FnmAWa1/Ups3guBhInEEe81Sc
	7NRSLOyx5ozHH5jhz/ZyFnXUckiO+a66xPT/3bvQTFV3McfqtKeDFt36/viPsjZAuP/mo9ReoEzUw
	uFjxFZGGAvWh0jwmylzd0fpano2V0k2g+/3C9AMV4OVUo+wla87DT5T3RxPZADEuKWABIkHLIZlBc
	YB3QRbJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwET-0004CV-JT; Tue, 22 Jan 2019 13:36:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwEG-0004Bk-Rr
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:36:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A359EBD;
 Tue, 22 Jan 2019 05:36:36 -0800 (PST)
Received: from [10.1.29.146] (e121487-lin.cambridge.arm.com [10.1.29.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC6893F614;
 Tue, 22 Jan 2019 05:36:35 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: vexpress: use list instead of tuple for mmci
 interrupts
To: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20190122121850.10120-1-sudeep.holla@arm.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <39d7c460-3ead-34a0-75ad-732089cd9ffc@arm.com>
Date: Tue, 22 Jan 2019 13:36:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122121850.10120-1-sudeep.holla@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_053637_139896_AE80315E 
X-CRM114-Status: GOOD (  16.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/22/19 12:18 PM, Sudeep Holla wrote:
> Vexpress motherboard MMCI requires dedicated interrupts for CMD and PIO,
> which obviously should be expressed as a list. Current form uses tuple
> and it works fine since interrupt-cells equal to 1.
> 
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi | 2 +-
>  arch/arm/boot/dts/vexpress-v2m.dtsi     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> index a9569d15de41..d3963e9eaf48 100644
> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> @@ -133,7 +133,7 @@
>  				mmci@50000 {
>  					compatible = "arm,pl180", "arm,primecell";
>  					reg = <0x050000 0x1000>;
> -					interrupts = <9 10>;
> +					interrupts = <9>, <10>;
>  					cd-gpios = <&v2m_mmc_gpios 0 0>;
>  					wp-gpios = <&v2m_mmc_gpios 1 0>;
>  					max-frequency = <12000000>;
> diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
> index fd42e1194179..798c97aff7fa 100644
> --- a/arch/arm/boot/dts/vexpress-v2m.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
> @@ -133,7 +133,7 @@
>  				mmci@5000 {
>  					compatible = "arm,pl180", "arm,primecell";
>  					reg = <0x05000 0x1000>;
> -					interrupts = <9 10>;
> +					interrupts = <9>, <10>;
>  					cd-gpios = <&v2m_mmc_gpios 0 0>;
>  					wp-gpios = <&v2m_mmc_gpios 1 0>;
>  					max-frequency = <12000000>;
> --
> 2.17.1
> 
> 

FWIW

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
