Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B24AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:59:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF590206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dGckpp2Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPHIOcd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF590206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1m2GkwwZJIHkoV8cK9aY+RURM5m9j3QLrE6bG6TmQBY=; b=dGckpp2Y5xSWkd
	eTejjv0Ge/+tvTSnAHBvHPJrTbUrmmqSBjUmAu0d2C9Jrx1x3OagozMk1rXKT3pQrkM2+fxeDZfNx
	Eiv1DAEpalNJghlYkLtpjcJy79IRj8dc8lni1waQgDqbm5O+F+A43QhbKA5KbGhVScx/JmwEUDRHs
	hKHFUqenDSxOzPQS+cLJmWEoOodqLW8RKlsCfmsHtD1EadFC3nzzzgXV5ED1X9kZJg8FChNO93hsT
	/EsIHfAgfYkHla7YTt2VTaHk6a5O1aQnYWH7lkW97AUFGpRe8bk6HtReV0YTQ5gOB/Ha3y2yefwg7
	/bjjvoD/ASdDuZxfp15Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfqDp-0001yi-Ln; Sat, 05 Jan 2019 17:58:57 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfqDm-0001xt-5u
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 17:58:55 +0000
Received: by mail-pg1-x544.google.com with SMTP id s198so18860052pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 05 Jan 2019 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ohiuwu+4fFi2Xqw/cg+brZezIhJHfENYsWXOA0F+BMQ=;
 b=IPHIOcd4rAkqCt3+Jyn57TbHyVU+RDQ8hMFcSg3nahFHk3/QNcGcPAToBNhbuHvTqs
 lEsd2KOdU640LZhkAlMobekWiM1Q9FPluY8G5q4Jcc4HUqjqlX56eJcdqgW1h3vXxAtr
 kbzbJwCV2d0niFADHLv/QePGz/9xec6g56x68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ohiuwu+4fFi2Xqw/cg+brZezIhJHfENYsWXOA0F+BMQ=;
 b=QPNROpGAS7V7WXJcyYUpEVe832gA568McIo1d0r7UDU//KqcjT9a4XBUqz+UdJAFL0
 WhVABK+nmxLGKvBAeHoinPwy2/SrDY2J7P4ICEu5VdXCU1jc74GKtvFy2iQj1I0+qodd
 79I5ZE6pjQzmyDGAOYVtsFvKd2DEkOQyLPft48TaUIO/mBlQiwFfiX7OcstDha9IHXcE
 IFYt/jQ4cutlKUBFSAHjuhRS8ezuy9oj+hLj2kyqc4RunW7leuo7ZFrF8pDbcmeaTpPo
 WRCp1n4l5E8EuPH8m13CuVgQiUVsFRCSYDJ1sMxitRAt/5BlpXQSsgSR60yBesS7d1ME
 Nelw==
X-Gm-Message-State: AA+aEWa6sGDQOkBYrHfQ/BGs055FX01vv0BFdsuqXUsefGfhkq7EzBhR
 52lJpCphOP0ZcmWQ9sbrnpd2
X-Google-Smtp-Source: AFSGD/WtyICefWI7Is2rAi3RAcPXcy86wRAjHZmKXwYMAKIJXHZiZAX7wPiTn/pE3MXOSniklnuBhw==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr56976184pff.211.1546711132779; 
 Sat, 05 Jan 2019 09:58:52 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:730c:d904:406c:3ac8:e78f:4779])
 by smtp.gmail.com with ESMTPSA id w88sm104457994pfk.11.2019.01.05.09.58.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 05 Jan 2019 09:58:51 -0800 (PST)
Date: Sat, 5 Jan 2019 23:28:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v3 2/4] arm64: dts: actions: s700: Add I2C controller nodes
Message-ID: <20190105175843.GA32306@Mani-XPS-13-9360>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-3-pn@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-3-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_095854_230282_8A9E3CB7 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 wsa@the-dreams.de, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com, robh+dt@kernel.org,
 linux-i2c@vger.kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 09:04:46AM +0100, Parthiban Nallathambi wrote:
> Add I2C controller nodes for Actions Semiconductor S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to dt-next branch where I have been collecting patches for
Andreas.

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 192c7b39c8c1..35fddba2af1c 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -174,6 +174,46 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		i2c0: i2c@e0170000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe0170000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C0>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@e0174000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe0174000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C1>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@e0178000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe0178000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C2>;
> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@e017c000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe017c000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C3>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		sps: power-controller@e01b0100 {
>  			compatible = "actions,s700-sps";
>  			reg = <0x0 0xe01b0100 0x0 0x100>;
> -- 
> 2.17.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
