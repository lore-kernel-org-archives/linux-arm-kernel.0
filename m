Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:03:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82992147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YUOyRZwJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRBY/IU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82992147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u7/G8s9/lJfv+Q4tcHooZEo9moChtXscD8yhWxypZjM=; b=YUOyRZwJS6zOOe
	ZRWdEwz8GNXO2tW0KApARBHUgWVcSrF2YzzyQQj1kvvNCUvN9T/mxbNNjjwospAs7UVPFDsQqcM/9
	PDlioL4wSjjFLOQ44iljifQcnaevgYIRqLITomZhcbJoR/gvuHyd7gxHKjxVDeXaupv2xj9a20lKC
	LkYvABG01dI8Q6WW4GO5k2dH1K8iGBrRYGtPuFPg1UndC+wmui3K7hH8w1OJhQKZ/oZwUMcEmr1Hx
	pOKaFuURSJDAfNHgRCf/yERHMb7Hth6v9yigfHH/KyOWlni7QZKoRh0tPDrje3jFMDShXqNZNc3uK
	Dbk+qw18AKZFxt84ycVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwclx-0002KP-Tk; Thu, 21 Feb 2019 01:03:33 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwclu-0002Jr-9E
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 01:03:31 +0000
Received: by mail-pl1-x642.google.com with SMTP id y5so7631751plk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 17:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fX5lDMwjodCprOzdzhSKvUSF4n4+hIb+niLlnQ9OeKo=;
 b=lRBY/IU7WsBSrcphwbe6e3B8XZj20VdIIfNiVOcHPIvKalQtGl3q84NDmkjQd4azS+
 FbcjrdXQmpZ7/WQA+6HqZYJpYIzBUadnxZjHnAP+T2hYzqvVgtr3OcbTJUcjbqpHAiTi
 1JmEXc5d4k1V4cb3mCG2T0M5NzboLNNpOYyKbcKmwFmCChO2M88iLlccXlL6DNw9RQqZ
 J2id0yl6iSG76nBrWQWul9MflyTaAMw/eq3g1Fh9kxtxA+Mm1MrxC6KeDPjsU8oApFgS
 rQpAVPZwC/hDMdTPCxxJZZfyq8gOnkT0GeyT0ZoiXaZysEFYI0Mb8w3po0ftqZt1Jt+e
 PXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fX5lDMwjodCprOzdzhSKvUSF4n4+hIb+niLlnQ9OeKo=;
 b=OK9HOItiAMeSd6Q75pwX/8E6ZPW5xjZrG/F/xjDPyEq5kXADU+vrdl8y9amBfCpE1w
 byjt9q9aRLoDTxzb3MqrmrGhITwFVv0QFtcyBy2FpwKyiUQwAMdZGihS/IXjkvmufn6w
 ewsnhg4w0c4hN53hui6qI4mvEuos0R3nhHeu7pFqvKhprfjAW+lVOjJL2BT1gClDkmxD
 c4dUtbZX/GmPbqDeads1yrFU6zRXVsForRMN/zCdC352B11zO+P787YXXIHtEjO+bGnM
 yvl6XPnPuFeYAADeHatZ8BWwpReegwwTKaj8RG1UDg20dDn964SnYdw3uoVKpPkZ9Xer
 jvSg==
X-Gm-Message-State: AHQUAuaceiQPUC/8ij1bp7gXS5SVcEatCqFgDeAX46qXH9T3ZeSGIntL
 kcyyHey3hWbVBbkcMDmVHOs=
X-Google-Smtp-Source: AHgI3IaZCRxuP8L+aMl6njyUESwTH2Bjr5v0umsSDtSPlGG72sSPBa8XYpjjgsizTpUXqOh1b9Kt/w==
X-Received: by 2002:a17:902:8d94:: with SMTP id
 v20mr39549510plo.194.1550711009409; 
 Wed, 20 Feb 2019 17:03:29 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id z67sm14883787pfi.152.2019.02.20.17.03.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 17:03:28 -0800 (PST)
Date: Wed, 20 Feb 2019 17:03:26 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V7 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Message-ID: <20190221010324.GD31479@localhost.localdomain>
References: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
 <1550645332-2907-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550645332-2907-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_170330_612743_91DAB0DF 
X-CRM114-Status: GOOD (  16.98  )
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
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 06:53:58AM +0000, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V6:
> 	- add fallback compatible string "fsl,imx-sc-thermal" according to i.MX SC thermal driver
> 	  update.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4c3dd95..24b03d6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -116,6 +117,12 @@
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +			tsens-num = <1>;
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	timer {
> @@ -443,4 +450,25 @@
>  			power-domains = <&pd IMX_SC_R_GPIO_7>;
>  		};
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tsens 0>;
> +			imx,sensor-resource-id = <355>;
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "passive";

Please add your cooling maps for a passive trip point.

> +				};
> +				cpu_crit0: trip1 {
> +					temperature = <127000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
