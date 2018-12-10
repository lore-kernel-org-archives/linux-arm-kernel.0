Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB60C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:51:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CF82086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c2Ri0IeL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qs57w5LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CF82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dQHdAfuCpkYs9QkPokvE15ScpicDPqOr8QePScwTH8Q=; b=c2Ri0IeLO+91kp
	49i+7qRHzIe467iFNYTarWhyuyRzGmtyeEbFGpk7ayjM823mtane2BCtoZPkDpGvmskS1Jamsvhvq
	mXUBkgYlcVqIpKRXtWz1OzZb0uxd6WtOw45w9098jfJnM++u79qplc9LFQNQjP5coSYNhi16hAPqj
	gnhMCxoDhMj4X2L6rCV/p48kfzevdDBx7U2MYZ92eBn1Bel3xGPjPE410oItXSuJW8D3Jrjp65n2O
	1oOFACMe8UQDKGxhKu3rtcB5D89FuENqPQjhjHWZUpv09gV3tWWTt+VkQPpmGCdOurWaM0a8zQE3B
	ApxskpzeUr8URxevNnzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLy1-0001s0-Qm; Mon, 10 Dec 2018 13:51:25 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLxh-0001du-77
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:51:07 +0000
Received: by mail-pf1-x441.google.com with SMTP id b7so5430369pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SBdbElkSsuxiJQRSGESbx+Xf6yhcdgnkMiGKWGdWGtE=;
 b=Qs57w5LXNjqnx9UvhDeVj6IrtrtMq9/C/EfYG6BTG3ghpnTZw2sPO0x5OiTZPNcIkL
 m7VhJBdtrtt2Myz4ZX3pW4QpESDBOtjnis+3GDcmTCRmGlLR1aSVLIa3MU3e3NqM0HLX
 lISs05220aRBKxgBlMTwGdhszyVAyBN7h3gRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SBdbElkSsuxiJQRSGESbx+Xf6yhcdgnkMiGKWGdWGtE=;
 b=COG/Q7V+ev+GyqJMdIIIkN4ydv3ta38bqBUNKK/Tsc9d0VP+sM1wG4UKpRD/WF1/Oj
 PKvwJ5iDEJWluNBgykLJEZNjcj7sbvkQvAG0BZwmcr6iGnm8Fh+m/V1xYMbcjXwoeAUl
 rCAq3ox22AwFiWHc8S3QUSee0Ulx9L8VYAPymDxNiGX1C9LjIcegcStKcFSsBD9S/924
 PCBwpCyr8KzWPJHffr2uAx92DaG+nPwJ6fxtYCAoRn0ew3D1SloB9ZP8bc+YaA+TCHS4
 JNAtZjb4BfC/bJvxUdg8ySzN0OHDsDhKPo2+Kfg+sSyOSvlSaPJJ/LVFsTTsfjL4jI3r
 kq9A==
X-Gm-Message-State: AA+aEWY3vBlmImWMIMSaCo68fBFTuvsWwykFN1Qxg29uTrHOb29EFM1Z
 WZS8Y7xHA6+MZtJlN15ef2tVyWtagA==
X-Google-Smtp-Source: AFSGD/WRN9DxD23CGCXNxUtHE5bj28B4H5f9z//4I4qwP2cN265CKncSfDaHUKTyJ/a/WhZkBwsGCQ==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr10963759pgn.112.1544449854687; 
 Mon, 10 Dec 2018 05:50:54 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id e65sm22571248pfc.74.2018.12.10.05.50.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 05:50:53 -0800 (PST)
Date: Mon, 10 Dec 2018 19:20:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v2 4/4] arm64: dts: actions: s700-cubieboard7: Enable
 I2C0 and I2C1
Message-ID: <20181210135044.GC25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-5-pn@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-5-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_055105_471238_437A87F8 
X-CRM114-Status: GOOD (  17.05  )
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
 wsa@the-dreams.de, linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
 robh+dt@kernel.org, linux-i2c@vger.kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Parthiban,

On Mon, Nov 26, 2018 at 07:58:21PM +0100, Parthiban Nallathambi wrote:
> Add pinctrl definitions for Actions Semiconductor S700 I2C controllers.
> Pinctrl definitions are only available for I2C0, I2C1 and I2C2.
> Enable I2C0 (PMIC), I2C1 (gyro, touchscreen) in cubieboard7.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index 28f3f4a0f7f0..6a75fdd7ab42 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -37,3 +37,56 @@
>  &uart3 {
>  	status = "okay";
>  };
> +
> +&i2c0 {

On the board DTS, node names should be sorted alphabetically!

Regards,
Mani

> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_default>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_default>;
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_default>;
> +};
> +
> +&pinctrl {
> +	i2c0_default: i2c0_default {
> +		pinmux {
> +			groups = "i2c0_mfp";
> +			function = "i2c0";
> +		};
> +		pinconf {
> +			pins = "i2c0_sclk", "i2c0_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c1_default: i2c1_default {
> +		pinmux {
> +			groups = "i2c1_dummy";
> +			function = "i2c1";
> +		};
> +		pinconf {
> +			pins = "i2c1_sclk", "i2c1_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c2_default: i2c2_default {
> +		pinmux {
> +			groups = "i2c2_dummy";
> +			function = "i2c2";
> +		};
> +		pinconf {
> +			pins = "i2c2_sclk", "i2c2_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +};
> -- 
> 2.17.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
