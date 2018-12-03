Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D245C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:41:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3002082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HUrGvnps";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FPAZVOmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3002082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M6mwRL1LGh8stLt5bYxpnw6ghtuGqB/DTXnlJQNWRto=; b=HUrGvnpso/zFw8
	y8FlHXznqAukQcQbxZoRxbXlVJdvgLvo7+/n7QoUkxMCCidHUV9eM9Sml2iSgQoWY/fmy5AOkUce5
	O2Ic/MxJJSVu8uMi1Sym7+FfCiiumACyuiKPpCXGdZIrZJA61dpnc45svMJSvHMqVFh+Ol+k5rnc4
	8Qb3v+8235dna3m6QvAvu0wG11NuohJ2zeImt0IyjnXOVsJ5edSkV0YOuv8oTUvVThLAy0oVew2N0
	mxWQk9AFgqd8P9uREenXKPD1wmWSu5ZvxYMRENK3mMVRh92k8XeDurszuDZADx8JebVPBMTK9Xhdx
	STvx7KXbRPDUP+OvPvmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToT6-0003bC-3u; Mon, 03 Dec 2018 13:41:00 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToSz-0003HG-BS
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:40:57 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id BEF825C0836;
 Mon,  3 Dec 2018 14:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1543844438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdJxECu7jOlBkeisMfoe0uVTo6qCwSx5kWcgXPtSuWA=;
 b=FPAZVOmr+dA+HMh53VaRDzdc7tCC3lGMl3GAVg/9GZgQYNsgjAqt+cEu8up3JGpTtNqmEW
 y6WaWC2ZLFtpfFFAHy6a7tVY7NFfPB9ALqiC8gZzs+uwFE3heAWPA8q+wt0M5UgOl1VfH9
 //UScBHIosUwk8pY4bIpAvW8xoRH8cs=
MIME-Version: 1.0
Date: Mon, 03 Dec 2018 14:40:38 +0100
From: Stefan Agner <stefan@agner.ch>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: vf: Fix memory node duplication
In-Reply-To: <1543625092-24498-1-git-send-email-festevam@gmail.com>
References: <1543625092-24498-1-git-send-email-festevam@gmail.com>
Message-ID: <d055ad83728d3fe5f7d7cd4403158987@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_054055_127877_C93E52F8 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01.12.2018 01:44, Fabio Estevam wrote:
> Boards based on vf500/vf600 have duplicate memory nodes:
> 
> - One coming from the board dts file: memory@
> 
> - One coming from the vf500.dtsi/vf610m4.dtsi files.
> 
> Fix the duplication by removing the memory node from the dtsi file
> and by adding 'device_type = "memory";' in the board dts.

Looks good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm/boot/dts/vf500-colibri.dtsi      | 1 +
>  arch/arm/boot/dts/vf500.dtsi              | 1 -
>  arch/arm/boot/dts/vf610-bk4.dts           | 1 +
>  arch/arm/boot/dts/vf610-colibri.dtsi      | 1 +
>  arch/arm/boot/dts/vf610-cosmic.dts        | 1 +
>  arch/arm/boot/dts/vf610-twr.dts           | 1 +
>  arch/arm/boot/dts/vf610-zii-cfu1.dts      | 1 +
>  arch/arm/boot/dts/vf610-zii-dev.dtsi      | 1 +
>  arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 1 +
>  arch/arm/boot/dts/vf610m4-colibri.dts     | 1 +
>  arch/arm/boot/dts/vf610m4.dtsi            | 1 -
>  11 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi
> b/arch/arm/boot/dts/vf500-colibri.dtsi
> index 2e7e3ce..237b024 100644
> --- a/arch/arm/boot/dts/vf500-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf500-colibri.dtsi
> @@ -47,6 +47,7 @@
>  	compatible = "toradex,vf610-colibri_vf50", "fsl,vf500";
>  
>  	memory@80000000 {
> +		device_type = "memory";
>  		reg = <0x80000000 0x8000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
> index 76a0949..b0ec475 100644
> --- a/arch/arm/boot/dts/vf500.dtsi
> +++ b/arch/arm/boot/dts/vf500.dtsi
> @@ -10,7 +10,6 @@
>  	#size-cells = <1>;
>  	chosen { };
>  	aliases { };
> -	memory { device_type = "memory"; };
>  
>  	cpus {
>  		#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
> index cab9571..689c893 100644
> --- a/arch/arm/boot/dts/vf610-bk4.dts
> +++ b/arch/arm/boot/dts/vf610-bk4.dts
> @@ -16,6 +16,7 @@
>  	};
>  
>  	memory@80000000 {
> +		device_type = "memory";
>  		reg = <0x80000000 0x8000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi
> b/arch/arm/boot/dts/vf610-colibri.dtsi
> index aeaf99f..05c9a39 100644
> --- a/arch/arm/boot/dts/vf610-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf610-colibri.dtsi
> @@ -47,6 +47,7 @@
>  	compatible = "toradex,vf610-colibri_vf61", "fsl,vf610";
>  
>  	memory@80000000 {
> +		device_type = "memory";
>  		reg = <0x80000000 0x10000000>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/vf610-cosmic.dts
> b/arch/arm/boot/dts/vf610-cosmic.dts
> index a3014e8..ea1b996 100644
> --- a/arch/arm/boot/dts/vf610-cosmic.dts
> +++ b/arch/arm/boot/dts/vf610-cosmic.dts
> @@ -20,6 +20,7 @@
>  	};
>  
>  	memory@80000000 {
> +		device_type = "memory";
>  		reg = <0x80000000 0x10000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index 59fceea..dbb5ffc 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -14,6 +14,7 @@
>  	};
>  
>  	memory@80000000 {
> +		device_type = "memory";
>  		reg = <0x80000000 0x8000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> index b76c3d04..7cdcc5f 100644
> --- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> +++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> @@ -16,6 +16,7 @@
>  	};
>  
>  	memory@80000000 {
> +		device_type = "memory";
>  		reg = <0x80000000 0x20000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi
> b/arch/arm/boot/dts/vf610-zii-dev.dtsi
> index 5ae5abf..19eb4a8 100644
> --- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
> +++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
> @@ -50,6 +50,7 @@
>  	};
>  
>  	memory@80000000 {
> +		device_type = "memory";
>  		reg = <0x80000000 0x20000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> index fe35766..757af56 100644
> --- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> @@ -24,6 +24,7 @@
>  	};
>  
>  	memory@80000000 {
> +		device_type = "memory";
>  		reg = <0x80000000 0x20000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts
> b/arch/arm/boot/dts/vf610m4-colibri.dts
> index ca62495..d4bc0e3 100644
> --- a/arch/arm/boot/dts/vf610m4-colibri.dts
> +++ b/arch/arm/boot/dts/vf610m4-colibri.dts
> @@ -55,6 +55,7 @@
>  	};
>  
>  	memory@8c000000 {
> +		device_type = "memory";
>  		reg = <0x8c000000 0x3000000>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/vf610m4.dtsi b/arch/arm/boot/dts/vf610m4.dtsi
> index 8293276..76bbfd5 100644
> --- a/arch/arm/boot/dts/vf610m4.dtsi
> +++ b/arch/arm/boot/dts/vf610m4.dtsi
> @@ -50,7 +50,6 @@
>  	#size-cells = <1>;
>  	chosen { };
>  	aliases { };
> -	memory { device_type = "memory"; };
>  };
>  
>  &mscm_ir {

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
