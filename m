Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76380C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:13:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443CB222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cpOXzKzC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LstBb9Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443CB222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H6dmJErQr5L504/ga9ylH63DwjNvb7cwpBoXH74FtZ0=; b=cpOXzKzCSuAhCn
	XuZS1h/O14qYayFyVEO4vvCFoRSsArMW3tOjMkdQelV0C+51joqDQjCgHSpnWiD1d/ggnfSde3nrp
	lbb0eNPVpJwi+LmrMJ+/+gHCFWcFruOW8l4sSS62yXHJa2+aXfZU+rtkkwnVDFiFGuhYf0RcVj4MV
	FLm5O8EiWxUSPu1k8Xy7RGEyd3bXP/mYrgK+phOfM6esng2F0uD/VwX6CnKnVJLMjsiIkCv5XIsMs
	jzIp0T+zg43MbcA2c8DpZPAtyTxH6ISkfpAT7u91mhJDWe/z0LSI9aT/1c4rLDLaC0Ncz9QGMtkXH
	f10rARFx5peBx/Jv/toQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guBCR-0003D5-3y; Thu, 14 Feb 2019 07:12:47 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guBCK-0003CD-J4
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 07:12:42 +0000
Received: by mail-pl1-x642.google.com with SMTP id bj4so2655473plb.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 23:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UFUxl+Fljm7yqlfrAchzNpMXHkNbSIOG02QGuZvFWpc=;
 b=LstBb9Pwynk2kwzMvrgXvs01+bT8CIfvaeQWBGiPjcTgGkiZG3EBCQ1e3WAJuAJ0XA
 Rjp/z13BhWFFiNsKmyf+kqdTy8ob4ULuXOpP6B1dIUADF+NF/F2589qkuO7TdJ4KZJWX
 1R9Na5rIPM4dxxlAdsspWrYFOw6iJtWKylQaEmoRCAU6gUyIhBG/5lJcCLyIpiqPkGZ6
 9alBpsHe75yhfA+Ih1hrUfZ3GquiFKfA8x1kufhWyampHnUIEEw5vw8o8MR1kcZO65OS
 bpFyPZO7pFN3xhuvNBE4zeLurmt1b3zjnJ9PJ3jjKKLd61XgC1C4U9l/IQLncUgedIel
 /huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UFUxl+Fljm7yqlfrAchzNpMXHkNbSIOG02QGuZvFWpc=;
 b=AoHAQCllsNjiVYgQoxUrWz7i8H9cPcAn/yC+xPZ3zQ/q6Mn4ovJTIZRCQwMQzreIgs
 pf+ELmls66a7oWcJXhYDFtulHxbanm2lmDTYVSZBqJ4ZU5NwoEknaYFCSxBNFf0Ur+1H
 8lQmU2SXuXnrhcWnA/IWLX9A/abypBdbWGpPLzdnq2YI719+hy7/6CqKBHhA+FyoT8yl
 I8U7CK9eSzKzDnxhI1ioPTnGYg30gYrj7Pzj8nLgSatu5TkRajzOr97d5dCs9tWbLGjD
 jDjf98NFxz8+A70hANaNwTQ0jk3r+tVBhPgpPfPgedRuGxL+JfvljwVubaKS24uaB2ry
 UmJw==
X-Gm-Message-State: AHQUAuZ/85AGbaxgkpMxznanBzSu0PKULAH6PrmtCE1Y/iYK+j9+T+YO
 0aObczhywhtR+f5rZpL4ytN+Mw==
X-Google-Smtp-Source: AHgI3Ib4ToWIHPDvYuqj7oSDLZt95BaIPm9ck5ZYpZgPoYIFFOk+ystVUKtsvCu42axUckdhp+vXuA==
X-Received: by 2002:a17:902:e087:: with SMTP id
 cb7mr2585329plb.313.1550128359043; 
 Wed, 13 Feb 2019 23:12:39 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id y12sm1937330pgh.38.2019.02.13.23.12.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 23:12:38 -0800 (PST)
Date: Thu, 14 Feb 2019 12:42:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V4 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Message-ID: <20190214071233.7uypqihkfasxqyw6@vireshk-i7>
References: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_231240_636978_9DD6A8BE 
X-CRM114-Status: GOOD (  16.42  )
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

On 14-02-19, 01:54, Anson Huang wrote:
> Add i.MX8QXP CPU opp table to support cpufreq.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change since V3.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4021f25..593e2db 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -34,6 +34,10 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			clocks = <&clk IMX_A35_CLK>;
> +			clock-latency = <61036>;

Who uses this value ? And why is it different from the one mentioned
in the OPP table ?

> +			#cooling-cells = <2>;

clocks and cooling-cells must be defined for all the CPUs.

> +			operating-points-v2 = <&a35_0_opp_table>;
>  		};
>  
>  		A35_1: cpu@1 {
> @@ -42,6 +46,7 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
>  		};
>  
>  		A35_2: cpu@2 {
> @@ -50,6 +55,7 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
>  		};
>  
>  		A35_3: cpu@3 {
> @@ -58,6 +64,7 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
>  		};
>  
>  		A35_L2: l2-cache0 {
> @@ -65,6 +72,24 @@
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

You want to go to a higher frequency on suspend ?

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
