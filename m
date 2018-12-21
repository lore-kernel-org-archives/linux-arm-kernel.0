Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946CCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:37:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627DE218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eVFgnLLU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NM1c+Qfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627DE218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sb1rEklpAdZh6aV503K41u1/Dm++iTdAMni5F1kEGsc=; b=eVFgnLLUMjalCd
	GYFp+LSYUbwhQStwIqU6+99u9N8Rj1lG7kME7XZBhkhsXTyDUAe48eJPhls+cTmQsZrzTKEmpabJn
	wzbMXNDDSg7oJWLWKoacpE/deL4OuDWE5k1rVFmjyPLASoaRqYRe+989lwkjAU8ObYXrbgOi4JQgG
	CT43ahJfS0pHmUyl+H0lE6kkgVDb+ukpVk34fdrojwi5q/4V8vSF6vEn1+f4zWGO0SVGXBEMzbEhD
	h6NzVkoEE6kIp5HIM1Ma7WS53ujsst58ze4DnsAnLz5PmLeWxZSsxoyljnLN/tb6wEPHP4G/WGVsS
	BSMGoALlfsbwpb8ttcPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaAgv-0003Jj-6V; Fri, 21 Dec 2018 02:37:33 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaAgr-0003Hr-Dz
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 02:37:30 +0000
Received: by mail-pf1-x443.google.com with SMTP id z9so1844511pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 18:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1FKU2VnaVUrF8mvg01F+2EVZF5Lm4oPl3ZBbFPmuK/8=;
 b=NM1c+Qfgs2DBiCnB+WYwV6wHbMgf1+IWcn+gFarudTc0Dj2xDoVCFI4lvmcuHadkD7
 OL7jv4Umes3O9GdjTv1d1mooZfPvUFBCaf+o5eNvkeMSRCZbElcYUfZ3bbuO4u3P/kte
 AKwtP6OXQA1LQYURTcEtxfG5NGtqkdwpBp374=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1FKU2VnaVUrF8mvg01F+2EVZF5Lm4oPl3ZBbFPmuK/8=;
 b=QbWpmtHl2B+EHH2b9wxTQZmhzjp84oFH9VnxcQO+u61tu3O7tmu/NsUoZfGF4CZYht
 1satulLUQXd4fqgCvVJP03ROdJc9JvUOPKGUOIEhSiqeb7TmSfz0hwiEpNHPF0KY/FTU
 N1iVxxRcoj1knnTG9i0fn7bZn9B7ZqRqTpPSbBXAs2dTD/GbF9N5WRgTbZiTvB6Nlaqq
 FZmwmK1orxUinvbH9kBU5m0n4nBQrfnESrkT0YmKLQwE0ykRgDC1Y10hOql1vmgdZEVI
 RAb1P8ZKiuY8rNa41+gJOfFCfRgV3Lo0S2fOxWUBO796EFLZrm/fTkTTMoTd0uPltNsX
 WOxQ==
X-Gm-Message-State: AA+aEWavynpd7dOxa13kf8AbLgyRvJag1e+YGwuJMNepTvGANUo0+4Mn
 3Ai4rEIdqPQTvAKlqBGtTOzK
X-Google-Smtp-Source: AFSGD/WlLo0zGagcnWNYzQMDNTBeirR3zEMHwrIqI6NLk7AccGxdgC2IBeSk5L4M3qWiuyLW8bQW1w==
X-Received: by 2002:a62:75d1:: with SMTP id q200mr678265pfc.254.1545359838693; 
 Thu, 20 Dec 2018 18:37:18 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:810:d868:55e9:25e8:dbda:255b])
 by smtp.gmail.com with ESMTPSA id a195sm14667864pfa.7.2018.12.20.18.37.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 18:37:18 -0800 (PST)
Date: Fri, 21 Dec 2018 08:07:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: michal.simek@xilinx.com
Subject: Re: [PATCH v3 6/7] arm64: dts: xilinx: ultra96: Standardize LED
 labels and triggers
Message-ID: <20181221023708.GC3233@Mani-XPS-13-9360>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-7-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181029094245.7886-7-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_183729_496431_24EA19E6 
X-CRM114-Status: GOOD (  15.50  )
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
Cc: devicetree@vger.kernel.org, daniel.thompson@linaro.org,
 linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-rockchip@lists.infradead.org, koen.kooi@linaro.org,
 linux-leds@vger.kernel.org, nicolas.dechesne@linaro.org,
 linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Oct 29, 2018 at 03:12:44PM +0530, Manivannan Sadhasivam wrote:
> For all 96Boards, the following standard is used for onboard LEDs.
> 
> green:user1  default-trigger: heartbeat
> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> green:user3  default-trigger: mmc1 (SD-card)
> green:user4  default-trigger: none, panic-indicator
> yellow:wlan  default-trigger: phy0tx
> blue:bt      default-trigger: hci0-power
> 
> So lets adopt the same for Ultra96, which is one of the 96Boards
> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
> consolidate only User LEDs.
> 

Hello,

Any update on this patch?

Regards,
Mani

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index eb5e8bddb610..c08a8753215b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -57,29 +57,30 @@
>  	leds {
>  		compatible = "gpio-leds";
>  		ds2 {
> -			label = "ds2";
> +			label = "green:user1";
>  			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "heartbeat";
>  		};
>  
>  		ds3 {
> -			label = "ds3";
> +			label = "green:user2";
>  			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "phy0tx"; /* WLAN tx */
> +			linux,default-trigger = "mmc0";
>  			default-state = "off";
>  		};
>  
>  		ds4 {
> -			label = "ds4";
> +			label = "green:user3";
>  			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "phy0rx"; /* WLAN rx */
> +			linux,default-trigger = "mmc1";
>  			default-state = "off";
>  		};
>  
>  		ds5 {
> -			label = "ds5";
> +			label = "green:user4";
>  			gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "bluetooth-power";
> +			linux,default-trigger = "none";
> +			panic-indicator;
>  		};
>  
>  		vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
