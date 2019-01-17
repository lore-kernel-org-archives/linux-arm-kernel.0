Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E87C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A413320652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VorYFHtv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddUrGFlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A413320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/tKrKKwWTwUWt5bzz2+4z58aoO/5qWYw0o83Jnk4FY8=; b=VorYFHtvc0MWsZ
	sNpgkRvHWELlDqNzraVs2LjvQXV25txVMMcLJDH6sdhUkPfyU6SgK9GX9GWTvJNDMcnDvHB37Jrok
	VVLZXGyMElTpRnjR0Cv+6vq7AHWQHxRwA+rkOafsT6O1C212RPvKk89VvVQIUu44G36GmVXWtr47l
	X1MliVkpCoU+lxzotIHCmmB9Bc5csh4hrATJXmCUJx6yUq5bZBKwIbQmp5TvUd/pdPQQvdyDPp/xa
	1PlthkYqvDaBHiq6on6Mp4esnSt7LtUKRLIkSPX4RjUKHbOzZEyOibs0zUXj8jR9rDZR+/kxDUbM3
	GklRIKuJtxQrC1bedqrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAyM-00054M-EG; Thu, 17 Jan 2019 16:56:54 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAy6-0004wI-AH
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:56:52 +0000
Received: by mail-pg1-x543.google.com with SMTP id z11so4706716pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 08:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=O0BZItxe72NDpqOUQeNAUH+rms79uSn5IzgLs/SIvig=;
 b=ddUrGFlWNS19wXFM4STS7+RiydNFM8v99ueCqW5IcmOvhrTSmLwj6ET+IH/E+neALK
 CkaygvdZADzRaPiDrbXEM02C2hZuLTDYE5chAtlt6fL8Zn0kf7yAfpCU5IXCrN424hnn
 K37bnxzs8gw+9D65rTdeJhtOl0MoaSFK0PX3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=O0BZItxe72NDpqOUQeNAUH+rms79uSn5IzgLs/SIvig=;
 b=KyliPZZpCjZyguf1mXFrgxkq9clLwL14rAdEgcOY8kbOEEaw8jmZ5J1PWP36BS9yln
 Wpv5adim6hr6lwb5XQes+OyjRtxbt9VOkYLLvaA9yfd4b6/3PKrt9xsAeqI8WHJPLWqj
 v7eNv+GsE/gmSvRIM52lxpGkoB5lnqrfL1UrWqT3yAuJEg100GJ8EarwnZDzZs2Kb2Mx
 LSiGwJLVlaL+/N5f90G8HAhIqK4ukgZNG/qzDzSvj5NwoJrQd7leWPMzO5sepBD6zqHR
 iuCNhidG4MJISCq6EQCEyfFO4bbvNy7N5g4FAe4JHk2lvOMRfZtQg1Kxucz8avnsKxg5
 xskQ==
X-Gm-Message-State: AJcUukewCYnwoWrM8NXpt2eIsxatLqwsbig0P2Ce8n3zSKRizFw0uXsQ
 U3r9GlNhXf0vnegp4DV1SbBx
X-Google-Smtp-Source: ALg8bN63FEKZyB2rzG3V9pv9AcxURMuzrFF+wCB4YpcNM14RpdbIDE04FTvpddG2Yvwt0yxAE0tJZA==
X-Received: by 2002:a62:824c:: with SMTP id w73mr5105470pfd.150.1547744196768; 
 Thu, 17 Jan 2019 08:56:36 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:7344:aef4:e89a:577b:dc0a:3144])
 by smtp.gmail.com with ESMTPSA id g3sm3828317pfe.37.2019.01.17.08.56.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 08:56:36 -0800 (PST)
Date: Thu, 17 Jan 2019 22:26:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 6/8 v3] arm64: dts: hi3660: Add dma to uart nodes
Message-ID: <20190117165629.GI5283@Mani-XPS-13-9360>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
 <1547141652-8660-7-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547141652-8660-7-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_085638_530175_F7BA1653 
X-CRM114-Status: GOOD (  16.63  )
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

On Thu, Jan 10, 2019 at 09:34:10AM -0800, John Stultz wrote:
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

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> v3:
> * Remove dma enablment on uart0 which would use reserved channel 0
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 20ae40d..4c8d682 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -478,6 +478,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf00000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 2 &dma0 3>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -490,6 +492,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf03000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 4 &dma0 5>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
>  				 <&crg_ctrl HI3660_PCLK>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -514,6 +518,8 @@
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf01000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-names = "rx", "tx";
> +			dmas =  <&dma0 6 &dma0 7>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
>  				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
>  			clock-names = "uartclk", "apb_pclk";
> @@ -526,6 +532,8 @@
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
