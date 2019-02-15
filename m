Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EC1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F178F2192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DmuUfnux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F178F2192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5LDykxcYU8DCfwYnS5ff/MBydsapTTrHDMNth/naonw=; b=DmuUfnux4LaBe5
	ao1U4m1ijD5BTSSccSs8FkO6Zd3sU4zTAQjLE9FRWVuWlwEUxZRBsCYHKA0l67XRW65a0nlRKWsFn
	AUo45XlQ1YGY3oVVZ4lTnqGEW/wd/xBZXfZjodf0e5AziEiSsj1NWHdH0HwuiSMZAHlZzHQ/jlmd3
	tbKOEB2qztv88/LecUZhimSOS1KwQ49KlZXx/MHeHN4N7pw/8HB6ct2YOuWF2rnTXkKXRWQPEVCIf
	VYN01RyVHvqWfRTtl5+VlR8+E6GwmaE7O1d61+q6MaJlANqm2IQDgQ9hwmiMdL5kFehPTnN4WDcb8
	sveKSMv7TeRzmFt/IMFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZhL-0003ME-Ou; Fri, 15 Feb 2019 09:22:19 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZhJ-0003Lr-D5; Fri, 15 Feb 2019 09:22:18 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1guZgx-0000DU-91; Fri, 15 Feb 2019 10:21:55 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Akash Gajjar <Akash_Gajjar@mentor.com>
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: rockpro64 dts rename LED labels
 and default trigger
Date: Fri, 15 Feb 2019 10:21:54 +0100
Message-ID: <2294853.gTMg7XEmWK@diego>
In-Reply-To: <20190213170651.3210-4-Akash_Gajjar@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
 <20190213170651.3210-4-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_012217_596225_44F752BF 
X-CRM114-Status: GOOD (  15.39  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shohei Maruyama <cheat.sc.linux@outlook.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Levin Du <djw@t-chip.com.cn>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 13. Februar 2019, 18:06:39 CET schrieb Akash Gajjar:
> rename white and red LEDs with status and heartbeat respectively.
> replace red LED default state off with default-trigger heartbeat.
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

Hmm, in the schematics the leds are named work + diy as in the current
devicetree, so I'd like to keep node names + pinctrl matching schematics
please.

And changing the functionality of the LEDs would require a bit more
rationale in the commit message on why that is something we want.


Heiko

> ---
>  .../arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts index
> c9a2b26d7cad..dab53d2eb676 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -43,17 +43,17 @@
>  	leds {
>  		compatible = "gpio-leds";
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&work_led_gpio>, <&diy_led_gpio>;
> +		pinctrl-0 = <&status_led_gpio>, <&heartbeat_led_gpio>;
> 
> -		work-led {
> -			label = "work";
> +		status-led {
> +			label = "rockpro64:white:status";
>  			default-state = "on";
>  			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
>  		};
> 
> -		diy-led {
> -			label = "diy";
> -			default-state = "off";
> +		heartbeat-led {
> +			label = "rockpor64:red:heartbeat";
> +			linux,default-trigger = "heartbeat";
>  			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
> @@ -502,11 +502,11 @@
>  	};
> 
>  	leds {
> -		work_led_gpio: work_led-gpio {
> +		status_led_gpio: status-led-gpio {
>  			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
> 
> -		diy_led_gpio: diy_led-gpio {
> +		heartbeat_led_gpio: heartbeat-led-gpio {
>  			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
