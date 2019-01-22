Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764FFC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:08:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416A420823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kwhuRC+P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og2ZjSM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416A420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ib32RflifHwnRUZ3NchPKseBn6VsAKcVzZ7nTvA+w5I=; b=kwhuRC+PbG94zz
	fddp+uQQak7LnE7PKFI9QZXxDoHvCOSlLz8KJmfyHnsixeK9r1CVF21gkIjfd5TM8IqwgnB9Fj1qV
	3ykUZXDrV2esuYjsHKGY3H+JI9iCT4UDa/3HH0iI1aUivCTWV5gxcqhkP5QVG6epE5IK80Exn3Ai/
	Pn+lWsJm1G3b5FMG+DZj3BR5/xO/vmfTxn3xEnrFEOkiwL4noudph5SHiC7flfico9I1vUPtMQKM1
	AwbO73ulg2JD8Y5+DcaOuzmxtDJiGhdi5LxJpqGEPvaXjjzPkZpIfKNYlwXSF9HcSWfcT/Vg3UCtg
	oCGsEb21i0yXO53YWdlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glyb0-0002Ru-MD; Tue, 22 Jan 2019 16:08:14 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glyax-0002RT-5X
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 16:08:12 +0000
Received: by mail-it1-x141.google.com with SMTP id h65so20799710ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XQnukHJhUtN1zC6XGrh1yFMwJ3zuZecoXCMtbRf1T7Y=;
 b=Og2ZjSM0MCqw7jQobZ07XPEH90DayF53y6b8+4nLyXdZXQ9WneE0C9mLL0HP8201rG
 csAViWw13AlM1Qb4E9B50fxOjf407tjOXfneYeP+e1h7UruJb1RuxH4ndm+mEmmpMYcQ
 tELpUibHUE6o25ajvo42HFCE09xj8yE8uA0RIc4DekX1fnQm8b2GEXMRk/j3Mu4kI3Gf
 iwtM4lRjGHBiHI+4y2BkOk/hBm7d9jesUu0oGu07SrY9lF8i+hVPyDOj1uU2c7qq9NkH
 bnQYoVEOFvrNepOBUPGOJSZyWseV+R0fNo+XtvYmszYAfxHWMuAO+KKEXRetSk1l4Z07
 wInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XQnukHJhUtN1zC6XGrh1yFMwJ3zuZecoXCMtbRf1T7Y=;
 b=hqKxGOyfKG/gCnt1Jr053y/l8jeyEA2p1oIAD+20hHnETGX5C2zn4tMZmW8L/6c7vL
 5wzYfX/KPS+nQMzBtJaVctd1SAd4GlYde+uIkvPs4jkLR54i1seoiaEFYtEv49DMfpbD
 eVGhu0JwVo9M0qRvRQ1/Ayimxo1Eyj/5dHqfoVfhg3JsPrL98de7DOQTDNw1UPIVhW63
 L3FMgtYCh8tjnGHN/acA2bGP3dpZvZu6HgB/R/jYo5rvKSObbUYwyBtGfE80faqv/VQG
 bz/k2cCsEyqqMszkp6kfaiY27aaKLMJlE1m2f6lt5V9VSROaqvt6ubOhbPwMOnbsc1XB
 Ktog==
X-Gm-Message-State: AHQUAuZMFJzFi9NIVH82BZEY9pCxG8gdagmX0JYUKy5GMX5dxjw4btNs
 1RikI+KlipV1w7DUvdnTsT42n/ObBt3s0Dkx4f0=
X-Google-Smtp-Source: AHgI3IbFPWICymMoiUMUhZUiSEU0UlY9I3qWRypXhY0OXznkV/nwBJb7whv14bbPs/8b1AcVV7clHr7wLLsLtGQSYLw=
X-Received: by 2002:a24:2452:: with SMTP id f79mr2643559ita.143.1548173289827; 
 Tue, 22 Jan 2019 08:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20190122140705.4918-1-aford173@gmail.com>
 <CAOMZO5D1bNjBkRbVukDCgXYOO6wqAEiBgj17dmW22Zstcj3e7w@mail.gmail.com>
In-Reply-To: <CAOMZO5D1bNjBkRbVukDCgXYOO6wqAEiBgj17dmW22Zstcj3e7w@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 22 Jan 2019 10:07:58 -0600
Message-ID: <CAHCN7x+uSyejYrJWBFyyy7eLwu05OT7Gf-9y+5MORaEVFcHOZg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Add support for Logic PD i.MX6QD EVM
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_080811_246744_24750A61 
X-CRM114-Status: GOOD (  18.39  )
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

On Tue, Jan 22, 2019 at 9:19 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Tue, Jan 22, 2019 at 12:07 PM Adam Ford <aford173@gmail.com> wrote:
>
> > +       reg_audio: regulator-audio {
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_reg_audio>;
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "3v3_aud";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +               regulator-always-on;
>
> It seems that the 'regulator-always-on' property is not needed in this case.
>
> > +&i2c1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c1>;
> > +       clock-frequency = <400000>;
> > +       status = "okay";
> > +
> > +       codec: wm8962@1a {
>
> Node name should be generic and label name should be specific, so:
>
> wm8962: codec@1a {
>
> > +       chosen {
> > +               stdout-path = &uart1;
> > +       };
> > +
> > +       memory@10000000 {
>
> Need to pass device_type = "memory";
>
> > +               reg = <0x10000000 0x80000000>;
> > +       };
> > +
> > +       reg_wl18xx_vmmc: regulator-wl18xx {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "vwl1837";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               gpio = <&gpio7 0 GPIO_ACTIVE_HIGH>;
> > +               startup-delay-us = <70000>;
> > +               enable-active-high;
> > +       };
> > +
>
> No need for this blank line.
>
> > +};
>
> > +&i2c3 {
> > +       clock-frequency = <100000>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c3>;
> > +       status = "okay";
> > +
> > +       pmic: pfuze100@8 {
>
> pfuze100: pmic@8
>
> > +       tmp102_0: tmp102@4a {
>
> generic node name, please.

I have two temperature sensors.  Should I just call them tempsense0
and tempsense1?

>
> > +               compatible = "ti,tmp102";
> > +               reg = <0x4a>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_tempsense>;
> > +               interrupt-parent = <&gpio6>;
> > +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> > +               #thermal-sensor-cells = <1>;
> > +       };
> > +
> > +       tmp102_1: tmp102@49 {
>
> Ditto
>
> > +               compatible = "ti,tmp102";
> > +               reg = <0x49>;
> > +               interrupt-parent = <&gpio6>;
> > +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> > +               #thermal-sensor-cells = <1>;
> > +       };
> > +
> > +       at24c64_mfg: at24@51 {

I have two eeproms.  One is a programmed by the factory with info like
serial number, model name, etc.  The other is blank and available for
users.

Should I name them something like 'eeprom_mfg' and 'eeprom_usr'?
>
> Ditto
>
> > +               compatible = "atmel,24c64";
> > +               pagesize = <32>;
> > +               read-only;      /* Manufacturing EEPROM programmed at factory */
> > +               reg = <0x51>;
> > +       };
> > +
> > +       at24c64_usr: at24@52 {
>
> Ditto
>
> > +       panel-lvds0 {
> > +               compatible = "ampire,am800480b3tmqw";
>
> Could not found this compatible documented.

I'll pull this out in V2.  I pushed a patch a while ago for this
display, but it's not been accepted yet, and I need to follow up on
this.
>
> > +&i2c1 {
> > +       ili_touch: ilitouch@26 {
>
> Generic node name, please.
>
> > +               compatible = "ili,ili2117a";
>
> Could not found this compatible documented.

I'll pull this out in V2.  I have a working driver, but I haven't
pushed it yet.  I'll add them back in once the driver's been pushed
and accepted.

thanks for reviewing this so quickly.

adam

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
