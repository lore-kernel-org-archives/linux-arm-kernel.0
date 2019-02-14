Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5145C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858262229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOkydhZR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ndzx3w67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858262229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QBbc3mv6/wTVz2gGDf1dt4UNxdqPPU6K/+y2d1nyOTw=; b=XOkydhZRFje33S
	jQGUW6wpzlaOZ/0nlA2/N+WQeJh9yaaDpBeKfhABH/YVI+5pA1Gh6CMBOMrpjSHYTGiJiNSKWr0QM
	SlDOQ1XSdPtjH+m26GcDeuEmyhlF2izVkGP1TQOqcavGPcFoZ1BrMlupyPIsELMKZOeyDC4TvXozq
	tJY8EFG3/efN0zcIRxWZGyEaVO8K1xsBkoJW4Hi+sBsa9DK0/47LMa+navyxRxWf08w4D2fr1dhU0
	UNBkDPK7XWoZJ6S0gW/ERj0zTewvOzJ7YRU8Fh+Kj2HS9GM4LAH/256nzmL/OD3962zDJ17hM3ko1
	7DJ8rBQDea9z7tnShD1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCTS-0002i2-BF; Thu, 14 Feb 2019 08:34:26 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCTO-0002gd-QI
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:34:24 +0000
Received: by mail-pg1-x542.google.com with SMTP id i130so2706907pgd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 00:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bpd8PA3u3JrSVmuhmsHW2bxdpcyCmZx0PS6GlvD0wGA=;
 b=Ndzx3w67x7NWqoTwPDLzFK/8piJRNsTTOBDhdiKTA4T5wGgcaf0c07P26qOtXV4UrC
 76JcFtP4+/0bTTMaJsQppoTUJK94tfFsyw+EKdP/mjXSyxQCKrRa9IRNYDvLdbzKU36E
 OPHfyjz6S4QzNCeGKkKlbc/WlENEoLoexoVe2aCZa+WNEn4KDs3+ad3t42qoC5cnJRPF
 JfWY25cnwTg8ULl1MOSDshtKeQcPbesyPcIXNrKNh9KocvDY9b5nR3mg3wVRTdiZhk43
 pUpJNAJZxR1rwe8ekq6hRYanPcMz8INM4zmABpdoz1TpzCpe2olFkCYJvxr3PDun3FpH
 tj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bpd8PA3u3JrSVmuhmsHW2bxdpcyCmZx0PS6GlvD0wGA=;
 b=DA9fWt2mfKhLsEwaeOoG6ePdCcv1tDfWwjjRX36Zv82zdrQ57PGuYzBfrV5atpXwNY
 zfpke+fsP116XTocFqUze2vgD/9UgTVkojtEEbsCaA01ZP9r59JyUeQRzicZPm1q0hL3
 Y5KJ7+akHPDQdy4KZeplMxIpgtBc6v9Uwds9m57DYp2IEsF6lUXkZFEjB4qQacZAqeQG
 ho6qC2hoJfZE32E6lBeqVX0NRh+4vHtxR9D/3/8zY3+V+4tMFfSZzuDHrwykBvu+Wqc8
 P6AX1i3U+RW2M/19axV/Q8eM7yYmA8Vt6CuqPQLfP1PVQToTFqT0T6LFdOKneNaGQK7w
 A4vA==
X-Gm-Message-State: AHQUAubqm9iOjvxttRRG5UwJokD04ocvq5BCXtfNfQnOMHFu4Yx8p2Lu
 Hrl00sbFO9hiKbDLAdJnR194VA==
X-Google-Smtp-Source: AHgI3IbVmCDf7+SMTXCPLQ5MmQj3W6jsZDsBvTmZvZ/Ip1kbcT7u+IRJSuILIjHyEGtMiQcY9ptF+g==
X-Received: by 2002:a63:516:: with SMTP id 22mr2525276pgf.353.1550133262179;
 Thu, 14 Feb 2019 00:34:22 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id d16sm1789033pgj.21.2019.02.14.00.34.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 00:34:21 -0800 (PST)
Date: Thu, 14 Feb 2019 14:04:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V5 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Message-ID: <20190214083419.slnuolyy5xhz4szy@vireshk-i7>
References: <1550131046-2069-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550131046-2069-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_003422_877933_FEC717F8 
X-CRM114-Status: GOOD (  16.08  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14-02-19, 08:02, Anson Huang wrote:
> Add i.MX8QXP CPU opp table to support cpufreq.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V4:
> 	- remove redundant clock-latency property in A35_0;
> 	- add #cooling-cells for all A35 core.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4021f25..fad1259 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -34,6 +34,9 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			clocks = <&clk IMX_A35_CLK>;

As I said in my previous email, mentioning clocks is important too for
other CPUs.

> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_1: cpu@1 {
> @@ -42,6 +45,8 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_2: cpu@2 {
> @@ -50,6 +55,8 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_3: cpu@3 {
> @@ -58,6 +65,8 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_L2: l2-cache0 {
> @@ -65,6 +74,24 @@
>  		};
>  	};
>  
> +	a35_0_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-900000000 {
> +			opp-hz = /bits/ 64 <900000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <150000>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <150000>;
> +			opp-suspend;
> +		};
> +	};
> +
>  	gic: interrupt-controller@51a00000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> -- 
> 2.7.4

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
