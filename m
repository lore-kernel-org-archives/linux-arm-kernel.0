Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4C2C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:19:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CAFB20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YGzPNz1K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe4uCC1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAFB20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QwHFRf+gOSSoLkb/SA5XxIudRdsg+ah6hjrRUGI/YuE=; b=YGzPNz1KluzF/S
	mYpxPdidNAHcpEVTxkRfEa0aHxr6w07uqsuBgGI0iGeRMdOpq0/xGqIGbv7K/SuECnr2eRgJeM3WJ
	w/QYVPkM/2xRtG+CvKcF/pseize6LJS5lrVgWp5z52el7DxIW66Ld3s2JkMRO4nSZROou0ZtLJ25Y
	nIlQwdnpa9ywQEzCOL5FdYOfiYckoV1QxbLtTh8sJ/oyI1BekqgyqhnvAG3wfwfeJak91lLWDXFVi
	GJks15cBWlyXwAaeqQohllVs9aF8W3s44582kwyjUyWql9vjgZ1rbWjRjBZq78HE8+OvFC6yIxwCq
	G8/KKYKfyHXakU5bIfjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxpo-0002M1-4j; Tue, 22 Jan 2019 15:19:28 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxpl-0002LN-0L
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:19:26 +0000
Received: by mail-oi1-x243.google.com with SMTP id y23so17667464oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 07:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P2T84Tfc/ZuRQBZY1S8DPTdz+esS77Fl4v/tE2CDlTA=;
 b=pe4uCC1CDIj7U6wC6lglbLU9O8yOVv7KeO0yLqQgh+TB1/UJAd8bBtiHY/75CznAzR
 Vhe5T6zdYXzY+RZkZ+I7JI9Vpzwks2A+X9waTG98OOEZJjLkAsOw4MDe0WrkTkS44kGC
 bCZwuyXvNBe9DcLOtgho6TrqtoCT4jBo6WSHyIOfIRwSIV6dwEFVGNrKf6wAj6pKWbSi
 TDE31VmhhCpvonqkMn7xh9STCnYYsYgCfVvgHDDcb/U1aObzThS3x3FflDbERLN5G4Yv
 xSTKVD+G6NN/+242BaDSZtOxC/1ZYUaDsnmm49eB5eRxsZTu8Tgz8rD3XzLw1TyG5jna
 0x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P2T84Tfc/ZuRQBZY1S8DPTdz+esS77Fl4v/tE2CDlTA=;
 b=nUdVJWhoPnEe1tjIuKGha2XWSbmDwROXE0XoojjxzaPxINL5KqEHJHZ/c8GyWH00PP
 qkCZjZgalWfY5tUFwGO/8Na4ZT5bmsV5ClNzapYtvQuNHidROjpJKSq9bvqNu8SL191u
 qMachsqXENv3mYh9FahfLgzV4mwckhLmT7O0BuGWOq1Xe7QFjKrXjJu6jzTGECMJ+LxF
 bPJC2jSZOTEfjsn6zKtYopiCxWE/5ahSTR3aG9xsikYEBCIA2cNtpyojLpi4S0CNUEOJ
 g/Sa7celx3wxsuhm8eU8qp+VEeYHfjCiNRkR/IT9pzDnzLikhpoaAMJaQNiXqWgDgUq9
 hvpw==
X-Gm-Message-State: AJcUukcT50jHxZF5ekZAZ1rcVsMPTikl+cf12wJZ6aWK7nVCqN7t3jWd
 50ZtxdznVnXFUwVWNQk6zJFb3PM/xNgGDrY4B2Y=
X-Google-Smtp-Source: ALg8bN6toZ8jCBNh4tMWTuyjtgGFXn0+QGP0sDTTgzgORD2MEn1csrNenITQZX+Xmqhw4zEXUlYtl1p8Bq2aXNdohws=
X-Received: by 2002:aca:6155:: with SMTP id v82mr8785678oib.259.1548170362828; 
 Tue, 22 Jan 2019 07:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20190122140705.4918-1-aford173@gmail.com>
In-Reply-To: <20190122140705.4918-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 Jan 2019 13:19:17 -0200
Message-ID: <CAOMZO5D1bNjBkRbVukDCgXYOO6wqAEiBgj17dmW22Zstcj3e7w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Add support for Logic PD i.MX6QD EVM
To: Adam Ford <aford173@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_071925_073097_80080A8D 
X-CRM114-Status: GOOD (  11.77  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Adam,

On Tue, Jan 22, 2019 at 12:07 PM Adam Ford <aford173@gmail.com> wrote:

> +       reg_audio: regulator-audio {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_reg_audio>;
> +               compatible = "regulator-fixed";
> +               regulator-name = "3v3_aud";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;

It seems that the 'regulator-always-on' property is not needed in this case.

> +&i2c1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       clock-frequency = <400000>;
> +       status = "okay";
> +
> +       codec: wm8962@1a {

Node name should be generic and label name should be specific, so:

wm8962: codec@1a {

> +       chosen {
> +               stdout-path = &uart1;
> +       };
> +
> +       memory@10000000 {

Need to pass device_type = "memory";

> +               reg = <0x10000000 0x80000000>;
> +       };
> +
> +       reg_wl18xx_vmmc: regulator-wl18xx {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vwl1837";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio7 0 GPIO_ACTIVE_HIGH>;
> +               startup-delay-us = <70000>;
> +               enable-active-high;
> +       };
> +

No need for this blank line.

> +};

> +&i2c3 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>;
> +       status = "okay";
> +
> +       pmic: pfuze100@8 {

pfuze100: pmic@8

> +       tmp102_0: tmp102@4a {

generic node name, please.

> +               compatible = "ti,tmp102";
> +               reg = <0x4a>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_tempsense>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +
> +       tmp102_1: tmp102@49 {

Ditto

> +               compatible = "ti,tmp102";
> +               reg = <0x49>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +               #thermal-sensor-cells = <1>;
> +       };
> +
> +       at24c64_mfg: at24@51 {

Ditto

> +               compatible = "atmel,24c64";
> +               pagesize = <32>;
> +               read-only;      /* Manufacturing EEPROM programmed at factory */
> +               reg = <0x51>;
> +       };
> +
> +       at24c64_usr: at24@52 {

Ditto

> +       panel-lvds0 {
> +               compatible = "ampire,am800480b3tmqw";

Could not found this compatible documented.

> +&i2c1 {
> +       ili_touch: ilitouch@26 {

Generic node name, please.

> +               compatible = "ili,ili2117a";

Could not found this compatible documented.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
