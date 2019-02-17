Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFA0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:32:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BF3218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="erske30e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/VBGQ15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BF3218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JjGRXguwOMYx/II7avWYes1FMUBabeuCVBK3ILmcJxo=; b=erske30ezmfRVb
	wZRy8Feug0v13G12i0k6abQczqbek3FVlZW2XmjQNNNatTQqFdvd18pdn6MROgnODaKYGKumwRuJs
	/WzJTWAzPQQcJwL7vPCOCKcAVsYGe26oT8I+BRvFXB01o8XbigL2bH8GBUX7wL7jKoyvmxmctJ43z
	czjRPmJcKCMLoYO1eP1XT8lmGEO8Ig5SS3gglvqEsXPbUG4JrzrUh5ZMabnbUBms0TYCHlCtXhQ9y
	EbkcDYsBzBTyziy/wq8r9vkQ1Ptj8L1x3/3xKLsjTMFFGnftIbg8Z90Jmei8CBMeIyQ/j4nUX5IHR
	t0KZ5V2BNJoNPO2DwJdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvNUU-0008GZ-D6; Sun, 17 Feb 2019 14:32:22 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvNUP-0008Fk-RE; Sun, 17 Feb 2019 14:32:19 +0000
Received: by mail-ot1-x344.google.com with SMTP id n71so24120610ota.10;
 Sun, 17 Feb 2019 06:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Axn+bdHHvS79AngtGUmm0FGHsAlpruO23C0ZFh5eebA=;
 b=T/VBGQ157VsvMlxuvNqXHc8Mb/1npjML27FiNaUuyTuJjVgeyGxvyTS1F1OFA2XOQS
 u1oG0ksBDwIVpenowbpXTaV28Qg1kR3smB8jsQwS8/1USK18BKhxCkDqwSpy4l+AyHNR
 Gzl7Tpn1eHTkvuLqB5Zdi9CL8SZOMeVEyhQ4C+RGqtwwAvU3ySG62MisKxhccu8m/jw9
 EfcCsmfc7WADUAXie2yHScKGNAKNQKBlfrqV6AUWeDBPi+PwdnQPLnmCK3exbXRfyT0I
 +lpl5CBbKgexriLzmops7XlxjZqyg4whN6NYXfpo78uLDo82QnvmrUBzlz+fhhOTbrXi
 4vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Axn+bdHHvS79AngtGUmm0FGHsAlpruO23C0ZFh5eebA=;
 b=f05P2885wPKaIghG1EuWRW2xww65AZCZXHBR0M0kfqThHvh6mv05WtcgMSeWI22KBQ
 Xe95NPjHNvPFwNKDISvQ6fCocgmYksq/+N/p9btBaz5LBZqrt+9c4X+HHOD3LsF4IqDa
 +yphM+SfDykTX0ILmjA1ZCnTcBCmrBHwDvAaf4yNvh1cTLNu3tw2AB4U7EJb7cRjaDZj
 ZKJcSBn3mHECqFqbm01WclDH45dSzeAC/fJNSfbDV3u+/44DT/m5NwWhKTiYik5f9tgq
 NtBPgywvSJmR6shdXD1Z5qws55W6BJweHbHIj4LmS8x9G1h6askgxvwwS9n08jX6yf9L
 XDhg==
X-Gm-Message-State: AHQUAubrJBbghIkbAVwh+Xj9drlvH2lTdoJyV8QPUap1BM2NjmL9ka0W
 rwQNClPM1qyrI9Ctap26IOpplAw0yd75W1DcM5Q=
X-Google-Smtp-Source: AHgI3IYK6YW/3iJSv3ChYB1zRPvCnxbI3Z4qrdyQtdQhIm/Grz1k7G5CKdBzRHtiOrvlhC5WsZxBt/ddkSO4wYk6M8E=
X-Received: by 2002:aca:1e09:: with SMTP id m9mr10718710oic.107.1550413936357; 
 Sun, 17 Feb 2019 06:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
In-Reply-To: <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
From: Tony McKahan <tonymckahan@gmail.com>
Date: Sun, 17 Feb 2019 09:32:04 -0500
Message-ID: <CAERgokmpHQb2czJdx++qFoogFRmkvXZm=4BNOsVuCz-ZvgTEaw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
To: David Summers <beagleboard@davidjohnsummers.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_063217_908849_39AF998F 
X-CRM114-Status: GOOD (  22.89  )
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
Cc: mark.rutland@arm.com, Stefan Wahren <stefan.wahren@i2se.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A similar configuration has been in use on Armbian images since kernel
4.14, but not in a clean enough format for submission. I will test
this, but the only differences I see compared to ours are combination
of the mystery "chip_h" power domain/reset with the Wifi one and the
inclusion of sd_uhs_ddr50.

-Tony

On Sun, Feb 17, 2019 at 7:16 AM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
>
> This patch adds the wifi to the ASUS Tinker Board (S) machines.
>
> Unfortunatly neither the Tinker Board nor the Tinker Board S schematic
> indicate how the WiFi is wired up on these devices. The WiFi is
> provided by the RTL8723BS device, that has sdio WiFi and UART
> Bluetooth. This patch just adds the WiFi interface.
>
> With no schematic, most of the wiring has been derived from the ASUS
> patch to Debian:
>
> https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678
>
> In conjunction with the pin out of the RTL8723BS device:
>
> http://files.pine64.org/doc/datasheet/pine64/RTL8723BS.pdf
> http://cit.odessa.ua/media/pdf/Intel-Compute-Stick/FN-Link_F23BDSM25-W1.pdf
>
> The only unusual part is that to bring the card up, both the pins
> RK_PD3 and RK_PD4 need to be pulled. Why this needs to be done is not
> clear, best explaination is that they are connected to the RTL8723BS
> pins WL_DIS# and BT_DIS#, which the data sheet vaguely says:
>
> Shared with GPIO9 This Pin Can Externally Shutdown the RTL8723BS WLAN
> function when BT_DISn is Pulled Low. When this pin deasserted, SDIO
> interface will be disabled. This pin can also support the WLAN Ra
> dio-off function with host interface remaining connected.
>
> Anyway extensive testing the TheSaint on ArchLinux Arm Forum
>
> https://archlinuxarm.org/forum/viewtopic.php?f=44&t=13064&start=120#p60548
>
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/rk3288-tinker.dtsi | 39 +++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index fceaeed44e34..e1796f340eef 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -3,8 +3,9 @@
>   * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
>   */
>
>  #include "rk3288.dtsi"
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/clock/rockchip,rk808.h>
>
>  / {
>         chosen {
> @@ -98,6 +97,15 @@
>                 startup-delay-us = <100000>;
>                 vin-supply = <&vcc_io>;
>         };
> +
> +       sdio_pwrseq: sdio-pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               clocks = <&rk808 RK808_CLKOUT1>;
> +               clock-names = "ext_clock";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wifi_enable>;
> +               reset-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_LOW>, <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
> +       };
>  };
>
>  &cpu0 {
> @@ -337,8 +345,8 @@
>
>  &io_domains {
>         status = "okay";
> -
>         sdcard-supply = <&vccio_sd>;
> +       wifi-supply = <&vcc_18>;
>  };
>
>  &pinctrl {
> @@ -417,6 +425,12 @@
>                         rockchip,pins = <7 8 RK_FUNC_GPIO &pcfg_pull_none>;
>                 };
>         };
> +
> +       sdio {
> +               wifi_enable: wifi-enable {
> +                       rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>, <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
>  };
>
>  &pwm0 {
> @@ -440,6 +454,25 @@
>         vqmmc-supply = <&vccio_sd>;
>  };
>
> +&sdio0 {
> +       bus-width = <4>;
> +       cap-sd-highspeed;
> +       cap-sdio-irq;
> +       keep-power-in-suspend;
> +       mmc-pwrseq = <&sdio_pwrseq>;
> +       non-removable;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_int>;
> +       max-frequency = <50000000>;
> +       sd-uhs-sdr12;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr50;
> +       sd-uhs-ddr50;
> +       vmmc-supply = <&vcc_io>;
> +       vqmmc-supply = <&vcc_18>;
> +       status = "okay";
> +};
> +
>  &tsadc {
>         rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
>         rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
> --
> beagleboard@davidjohnsummers.uk
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
