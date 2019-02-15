Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDAFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503F821934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4+373+T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="N5ipxKWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503F821934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:From:Date:
	MIME-Version:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pZQFvMkTd0sl7CCtX7GXBkhR4/ksBVZhBbtG/YcyNrg=; b=U4+373+Tn5nSTTDE49B+fNBHr
	Ae9O4/T1/v1kIzZky00a3scG8J0qDvjy599PsDVWt4gPIGmCu1smaZQpmXsQw67PEGkaYf+jOeiFp
	eDc5GkWAA4tgo6IFgOcGS4j4rB24ciegp6KvulBZOkc7aqfcwrzljTMovX+kHg5zLoIUoCvGFBpIH
	2Pyi/gwwtXTKBhmOQYYs4t+1VF0bxPbkUTSVo2o1k/vEvg01TAqOGEFjTCapOQW0uzAXsoFUaie7B
	bnMQs/rjokR1kUHmMm2nSjHLwpiy35uYz+iGQJYbsHNJhrIviACfokrXvXhfMdiF3gPK+cSzHzeHq
	qmV/NrU+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRmp-000258-KO; Fri, 15 Feb 2019 00:55:27 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRmm-00024l-0I
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:55:25 +0000
Received: by node.akkea.ca (Postfix, from userid 33)
 id 596B14E204B; Fri, 15 Feb 2019 00:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1550192122; bh=qSYSF5tg4Vn7jx47Iv7ML8cSM06NsDF/modrxQLizVc=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References;
 b=N5ipxKWrXTvT+NhI5NrX1tuYBkKBpvZJGKLD17D9W7bxE7zwCh0v0+gipg3zclkfm
 nnMCjcgg3jpJhwROmbYj1u+VegxyL9WdYTxvTsaWY3gcztQ56bMHuyHQusMa3+VFrQ
 gxURbPTuTjt0VpwJErMV5ptEdbyP5GUcuPML0wfU=
To: Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Date: Thu, 14 Feb 2019 16:55:22 -0800
From: Angus Ainslie <angus@akkea.ca>
In-Reply-To: <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
Message-ID: <76b2c0e4a61d022f7f798990af4dfd8b@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_165524_091815_0EB4BD96 
X-CRM114-Status: GOOD (  10.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Anson Huang <anson.huang@nxp.com>, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Mike Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-kernel-owner@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Angus Ainslie <angus.ainslie@puri.sm>,
 Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-02-13 11:05, Abel Vesa wrote:
> Add the opp table containing only non over drive opps.
> Also add the cpu-supply nodes for the A53 cores in the EVK board.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 23 
> +++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 54737bf..114359e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -31,6 +31,23 @@
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&sw1a_reg>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&sw1a_reg>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&sw1a_reg>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&sw1a_reg>;
>  };
> 
>  &fec1 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 1a89062..89b2d5f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -91,6 +91,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
> 
>  		A53_1: cpu@1 {
> @@ -101,6 +102,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
> 
>  		A53_2: cpu@2 {
> @@ -111,6 +113,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
> 
>  		A53_3: cpu@3 {
> @@ -121,6 +124,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
> 
>  		A53_L2: l2-cache0 {
> @@ -666,6 +670,25 @@
>  			status = "disabled";
>  		};
> 
> +
> +		a53_0_opp_table: opp-table {
> +			compatible = "operating-points-v2";
> +			opp-shared;
> +
> +			opp-800000000 {
> +				opp-hz = /bits/ 64 <800000000>;
> +				opp-microvolt = <900000>;
> +				clock-latency-ns = <150000>;
> +			};
> +
> +			opp-1000000000 {
> +				opp-hz = /bits/ 64 <1000000000>;
> +				opp-microvolt = <900000>;

Shouldn't this be

opp-microvolt = <1000000>;

> +				clock-latency-ns = <150000>;
> +				opp-suspend;
> +			};
> +		};
> +
>  		gic: interrupt-controller@38800000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x38800000 0x10000>,	/* GIC Dist */


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
