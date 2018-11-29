Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2EDC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:23:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC7421019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T1dRhalI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC7421019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uGY6vJtQH1/PcW1PCakXvIeDvyAHTTx6U4465eNArKk=; b=T1dRhalIJh5XcG
	bPW/oFNYWkL90riT1R7sODZc6qsgBi6L21dzmAOZIpedrNUwXdOi+n2iyWvvj0aR8I/2UMWTith8A
	QAVSvQDsq6cY4aF4OTA3/V2jeH53xkLMMaSdvERO0GWU053xSI83d4xDDNWWUGy4HGL/+69NI6sNb
	qmpUiYKxlaceMErLT+BVv/9k7kVDHIOPmJUl6Ws6luFLQQ92B8OWNnNXWk7nHqyugjvZ9eKdq7QRq
	B9Drr4VC1hYlkjPIvAu27uQf09ARVctbb/QjBJ4vSKmtNEGIoBKfE3llhTGDpC/lvo+Edj0KZmi0j
	VG/S6EWMS7Cazc54DHpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSO9i-00035M-Vj; Thu, 29 Nov 2018 15:23:06 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSO9f-00033Z-16
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:23:04 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 02247F9663462;
 Thu, 29 Nov 2018 23:22:48 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:22:45 +0800
Subject: Re: [PATCH 3/4] arm64: dts: hisilicon: Source SoC clock for UART6
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
 <20180921060103.21370-4-manivannan.sadhasivam@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C00043E.2070607@hisilicon.com>
Date: Thu, 29 Nov 2018 15:22:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180921060103.21370-4-manivannan.sadhasivam@linaro.org>
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_072303_239225_52D9DE5C 
X-CRM114-Status: GOOD (  11.00  )
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
Cc: devicetree@vger.kernel.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Manivannan,

On 2018/9/21 7:01, Manivannan Sadhasivam wrote:
> Remove fixed clock and source SoC clock for UART6 for
> HiSilicon Hi3670 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 8a0ee4b08886..34a2f0dbc6f7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -187,17 +187,12 @@
>  			#clock-cells = <1>;
>  		};
>  
> -		uart6_clk: clk_19_2M {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <19200000>;
> -		};
> -
>  		uart6: serial@fff32000 {
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfff32000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&uart6_clk &uart6_clk>;
> +			clocks = <&crg_ctrl HI3670_CLK_UART6>,
> +				 <&crg_ctrl HI3670_PCLK>;
>  			clock-names = "uartclk", "apb_pclk";
>  			status = "disabled";
>  		};
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
