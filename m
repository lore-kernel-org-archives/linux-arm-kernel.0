Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DAEC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:35:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F11821872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eSqpCmmw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tq9ww657"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F11821872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qf68rPfHDDa1MbkFncQmCnKUC0IxT7SMn6Bt604suwc=; b=eSqpCmmwinKGUm
	G9qN1iLSBvSM7SDFdMzWOjMjvD7UmF8HOjbmG8s9yfMb5pgQ6qygcy1/sJaqUghZklJqYpAmwF46Z
	NbFUV87PnW7Jrk4fUFCUXNKZ7Oc67SIQ1uzTmM27SAw6muthkM7Xpec/qzyhn9Q30nrN7kq6ScwRa
	wQQZcIOFiw+E5NaPY4hY37uI4dR/aeI9rilCp3Ic7G86kwabF5HBCN/bDGWw9fn3B1v5qlWunIy1D
	5R7g+keEuE+Q+kKczcCtb9r31VZlyNuLZhmwi76U8ecVahyuaUVImp5V7YtuqdMtnc+Nlu5m/PPjN
	6RSDtsTNtx0GG1Ewjxnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmcMD-0006Dx-C3; Thu, 24 Jan 2019 10:35:37 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmcM9-0006Cu-QW
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:35:35 +0000
Received: by mail-it1-x141.google.com with SMTP id a6so3653121itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DxbJL4ZzcPGmo3x32HRFW7MZrbBGNIu7eISt3vQRymM=;
 b=Tq9ww657YOwU12AEbCe37UjZ4NLzUL24vEbQxQrQ6o++y+pyJvRiFIUUYDsdrUB6fp
 /4wt8YoVZ+GcxepKy/eOukDXHRve4ys1xTW+8Es8wSLuXpgCDQLiP3n87Qe49GhK2Nhn
 4IU7VIMUpQC5gbf6Ww1QJG97CNsU1ZumhGAsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DxbJL4ZzcPGmo3x32HRFW7MZrbBGNIu7eISt3vQRymM=;
 b=d4e5NrP4EQxJdz5nK0LNdKh36C1HynpZC24OYpaAHTAoZuNbN8Z02IhvpPDI2FE4f5
 zszvOksPMqJkGO3kFlfdXOcxmhdMPPmcaIB3IEBaVSNFFtjJ6czxuvaoSvQv4hPYYgym
 VxWaPtvDhq1iPZf8etfUU54lN9j9IpQbJOtT0G9hTTo8ZECFjhcTjRbSUM3LeI9yuVca
 RdS7K/AKIzz6r+81QRp7LJ0Te0TxxaakNk+SZD59poywvwrl8MFt4YN2vmmpGOYoYjVh
 TjOSwGUUti32MXypnxjVkRPSNqt0nUB4QyVT0wAVOCRCy7HRrVNqZMN6gKFtcS8hXNA+
 fVNw==
X-Gm-Message-State: AJcUukdvBVH3gx1AFvmM+OFUFCVVIiVf5seW6jjJ++hoQ7G3jvBhN5MM
 wkEJ+h8S4GWi/sVJ0uGR5ZWE
X-Google-Smtp-Source: ALg8bN4OtsPTuqWnMQqX6ejMX/LeJMhDLMZBstV0CXMlDbTm/au6/Yh7KxfKb8oUh8HtDx4S+X/n5w==
X-Received: by 2002:a24:55d4:: with SMTP id e203mr1008435itb.36.1548326132324; 
 Thu, 24 Jan 2019 02:35:32 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:73c6:b855:b411:39cd:c90d:867f])
 by smtp.gmail.com with ESMTPSA id y8sm10626613ita.5.2019.01.24.02.35.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 24 Jan 2019 02:35:31 -0800 (PST)
Date: Thu, 24 Jan 2019 16:05:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH][RESEND] arm64: dts: hikey: Add DMA entries for Bluetooth
 UART
Message-ID: <20190124103523.GA20854@Mani-XPS-13-9360>
References: <1548275437-6022-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548275437-6022-1-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_023534_119966_306D81E9 
X-CRM114-Status: GOOD (  16.31  )
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
 Ryan Grachek <ryan@edited.us>, lkml <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 12:30:37PM -0800, John Stultz wrote:
> Add dma0 references for bluetooth uart to enable dma
> for bt transfers.
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Ryan Grachek <ryan@edited.us>
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
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index aec9e37..fa15a08 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -319,6 +319,8 @@
>  			clock-names = "uartclk", "apb_pclk";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func1 &uart1_cfg_func2>;
> +			dmas = <&dma0 8 &dma0 9>;
> +			dma-names = "rx", "tx";
>  			status = "disabled";
>  		};
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
