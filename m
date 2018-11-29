Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE6C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F6A21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BJCUW4mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F6A21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iShmveZISRfqq47DSBbzNUQhAgkMa5AyHQnGOcBC8Rc=; b=BJCUW4mRiJC1b1
	Vx/NxmhDuvikApuHoDGwAgaLP//U8WZZ+owNvd2Smf1loKtJRpB1vxOBOvmyk1wz6bZRcAyq1BqVB
	DaTKGtJgM2TpmNYq63KWaRy2gvvvHFdgD/vrch4GK5QNVvRtdh/XzBy38/XIkQCI1SSaZjG6rzMWT
	fdZBd8XtCH1feiyNwAmvBlJxl0/JeURQ9DWHnOb84mtZKOqnA3s3Rsoit9ozgG8wSoJY7CUUGmbBf
	CSwAwcgZU8yuEH1ztJiuuNXsfJC7an5Bq4QFYIjwc2x8nh9gg3Kc1QjCGEbuI0VW39s5s3up3t3L8
	1fwk4odwY4zkpcuVaQSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSO95-0002nk-8U; Thu, 29 Nov 2018 15:22:27 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSO91-0002mi-MS
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:22:25 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5F62C4E3FA20E;
 Thu, 29 Nov 2018 23:22:01 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:21:57 +0800
Subject: Re: [PATCH 2/4] arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
 <20180921060103.21370-3-manivannan.sadhasivam@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C00040F.4080507@hisilicon.com>
Date: Thu, 29 Nov 2018 15:21:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180921060103.21370-3-manivannan.sadhasivam@linaro.org>
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_072223_909792_4B3D63F1 
X-CRM114-Status: GOOD (  10.86  )
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
> Add clock nodes for HiSilicon Hi3670 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 43 +++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index c90e6f6a34ec..8a0ee4b08886 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/hi3670-clock.h>
>  
>  / {
>  	compatible = "hisilicon,hi3670";
> @@ -144,6 +145,48 @@
>  		#size-cells = <2>;
>  		ranges;
>  
> +		crg_ctrl: crg_ctrl@fff35000 {
> +			compatible = "hisilicon,hi3670-crgctrl", "syscon";
> +			reg = <0x0 0xfff35000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pctrl: pctrl@e8a09000 {
> +			compatible = "hisilicon,hi3670-pctrl", "syscon";
> +			reg = <0x0 0xe8a09000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pmuctrl: crg_ctrl@fff34000 {
> +			compatible = "hisilicon,hi3670-pmuctrl", "syscon";
> +			reg = <0x0 0xfff34000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sctrl: sctrl@fff0a000 {
> +			compatible = "hisilicon,hi3670-sctrl", "syscon";
> +			reg = <0x0 0xfff0a000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		iomcu: iomcu@ffd7e000 {
> +			compatible = "hisilicon,hi3670-iomcu", "syscon";
> +			reg = <0x0 0xffd7e000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		media1_crg: media1_crgctrl@e87ff000 {
> +			compatible = "hisilicon,hi3670-media1-crg", "syscon";
> +			reg = <0x0 0xe87ff000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		media2_crg: media2_crgctrl@e8900000 {
> +			compatible = "hisilicon,hi3670-media2-crg","syscon";
> +			reg = <0x0 0xe8900000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		uart6_clk: clk_19_2M {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
