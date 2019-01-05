Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1310C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:49:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DAA20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K5Q1Y8v0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EURyhjwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DAA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=njEQaQET8Bv5nZG8J+S3LcOnDnmLxAM4yd8frLEDP/M=; b=K5Q1Y8v0DJJjz/
	PFfUG4voMdTUnp5RMFE8ahuk1Z+Jfs2GN3thORkd/qlTGW4UUYHx/90POBhfUbH8fXLI72HaH9xvU
	67pz4ZgSZSWLxrthprUaxuoYJPCOs4NIW7xR4iQo3NViKcDcWzmnedY1dQwAqybCokRw5YEYMcMmr
	cNqusOSq+I4/LxD2OKVmjaanm5m3URsGOsCWi3G7xuKJR10q4UFo/sZ6FeI93dUQRZt6NuofKxGBL
	k68XVoGMzgl11dcYCchLrRd38hu/vlKGM1Knj6SfKekN0bhk7LVt8LvCdHzN4v0Rzgal5RvEeqLd3
	CHO/C6IHDb2THMb/xt7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfcxb-0008Pi-1a; Sat, 05 Jan 2019 03:49:19 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfcxX-0008PB-Sz
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 03:49:17 +0000
Received: by mail-pg1-x543.google.com with SMTP id w6so18274207pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 19:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oh50aT9Sm9VnfXmqmWbMsRDFspd7GJSylxhc9oS4/Qc=;
 b=EURyhjweHJqqa+dKma1VEUtLypc/mK4igi8UtQXoSOONVxpzuF1h0coWAGB3uB6XYz
 31+/81TC3AWDMqDi96YziOUTciRNx3N9FueVUTDz/+o+5Yxt1mqWBOhYV3CMEqlaSuiJ
 g8zcjihaiphltJAL9Eg4ee8XJ7CpHfshxf+30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oh50aT9Sm9VnfXmqmWbMsRDFspd7GJSylxhc9oS4/Qc=;
 b=WEQV1Vr5Yiqdb5hJXc55l4XH0WSR+DDYsnt1G3UeRgjeS8iGcSVtkfv0yEoWjtQJsE
 5BlIwwO8/ZYN3PgKpNVb4CrxHVJHJT842h0oWFhhaSzBbUgwkPb57cTyMI12gyGzJkf4
 XDCxPGZPZGdKfrPXV6x0OTcPK5Zz+5aKg5nHEtAXfDxWNhfDm2e1zsJkN8rX3WS/ivQi
 Ctvcriqy1eSrf1Xma9e1ti0/UqNp2CvwrKqc6KZLJGpqOxqAGzfQtfw23X/PBNidD81X
 aQVOerQ8mvmmaZWxg9DHB/WmrYA1UD9Q6iB6OsngMoJYy1yV+pn1WkDcns+dDouF461l
 Gq4Q==
X-Gm-Message-State: AJcUukdDzboFGmpX9XWL37LtwQo9xyQPUrQLzY7TlLZSHDMoylWL0E9g
 8eZqpJ1FhksqqvPygSejP30W
X-Google-Smtp-Source: ALg8bN5BrW898r7Ty7GQPu1+6XNIBpb+oq5zjcatPS2++069oAXEU6KqP7CLCDCVroV3r+iMh4GWaw==
X-Received: by 2002:a63:7f4f:: with SMTP id p15mr23024050pgn.296.1546660154870; 
 Fri, 04 Jan 2019 19:49:14 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
 by smtp.gmail.com with ESMTPSA id w184sm68960902pgd.34.2019.01.04.19.49.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 19:49:14 -0800 (PST)
Date: Sat, 5 Jan 2019 09:19:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 6/8 v2] arm64: dts: hi3660: Add dma to uart nodes
Message-ID: <20190105034904.GD2477@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-7-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546635388-13795-7-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_194915_933862_FBD0CD6C 
X-CRM114-Status: GOOD (  17.75  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Ryan Grachek <ryan@edited.us>, Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi John,

On Fri, Jan 04, 2019 at 12:56:26PM -0800, John Stultz wrote:
> Try to add DMA support to the uart nodes following
> the assignments made in the dts from the victoria vendor kernel
> here:
> https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1
> 
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 20ae40d..aaa2b04 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -466,6 +466,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf02000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 0 &dma0 1>;

Usage of DMA channel 0 contradicts with the description provided in
patch, "dma: k3dma: Add support to dma_avail_chan".

Thanks,
Mani

>  			clocks = <&crg_ctrl HI3660_CLK_MUX_UART0>,
>  				 <&crg_ctrl HI3660_PCLK>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -478,6 +480,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf00000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 2 &dma0 3>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -490,6 +494,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf03000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 4 &dma0 5>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
>  				 <&crg_ctrl HI3660_PCLK>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -514,6 +520,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf01000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 6 &dma0 7>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -526,6 +534,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf05000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 8 &dma0 9>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART5>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART5>;
>  			clock-names = "uartclk", "apb_pclk";
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
