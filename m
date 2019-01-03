Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABBCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:47:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0885221479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KdnSQOsa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnqfJVL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0885221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X6bTKkXGBblVLMAnxYuhCwtn/DeeYFU9bYrc9sJvxiA=; b=KdnSQOsaADnRUy
	uIq2/gqeWEC1lkhVRR9N9AW2BgrPKEvmxIL09pApcLaJg56Z2n5QEMJLp47ARqv568KqXbPKq99Z8
	sxfwapVJ1V1Li+FshPRr1fLKE38vuM6zE6QXA1QtLq8MPvN36hdUayymAb2IUNGFhJ+OQ2fctWIIs
	6DF0+BMQqMYN1MvIxeTCB2GFIoQqnpLV05bF/1m/+JgPxbDIGSef4tdzlVMKm3disjuGiGlZ25Sv9
	fXwx+errbwtDKHClhDLt7toE7ncf/z6YYfXdj5ptP2xLzitANqR9l8nM4hgIy7T1X2L71sov5U6lX
	2y8Tg3jo6xY7kZel18Kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geyf4-00052I-DB; Thu, 03 Jan 2019 08:47:30 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geyf0-00051t-QA
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 08:47:28 +0000
Received: by mail-lf1-x141.google.com with SMTP id n18so22665090lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 00:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HzroYmbHTX0P7rPqzoPnQrxpze81Q3g0jag3lHlC7ME=;
 b=nnqfJVL8qBAuEsmLP9hKXZS8cIeskhjvvroyyIcsigzlrOomnSCfTWBk8UzO4lyFDC
 tf0h8Be2+AwNWOSLVwzxhrx1Fc6mPjwK6vPrnpivWm0IG6LsfJycCPVTCZSvpLtbUCWt
 hs/aJtiJMyM/Q3uWgSLHgMyjZh3OAwt/dsSW5Ifa1SYeTsxOosec2NKJllDQ1JGoG4OK
 rBiNX4BrSM5KeX4SOjsajIhrNeHL53S732ZXUo3HOmoQrLpQBzMSaJ37RudSwkCNKcnJ
 0QIuCdLj3wEgWcuWVsdQyuPhfzeTf5b3t/xL34q53UFyjaj4OK8baixZbkb6+Ado3Ox5
 T4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HzroYmbHTX0P7rPqzoPnQrxpze81Q3g0jag3lHlC7ME=;
 b=nUniERktgZZypvoGHUvxfFpRhzUu05iWHbbkfykbewonH8ieQwu98xXtx3ywta9Ata
 gJ9J7TsdDpSfCaLAaEIylvaRb8X4T9UQLX2mn321X9j+xZBmj3ODKhmc+lPvhvLQg+qV
 jra8s0hLx+kF5NaqFvkzqE0bR8hFSiIPzfHS9qi0JPk+Z47+tNuejfthXSiff/OeP8DB
 aQ8eZQn5E3G2RnCvMX8UwX0krK/HGbnu7qUwJqxCrgdcR9OMTxSP9rC3wen78/WoTB3M
 4cJ2rE4RQz7UtdlTeYE0X64umTXS7GeqQZ6M/j7pK5UFPrtCupIpFyjdXP496KRaoadn
 jmRQ==
X-Gm-Message-State: AA+aEWYR2Qek/wUjpgtgMNReEoKJD45CfgKIzDyiwTpT0ySrtARUtzR7
 S64uR48zjARNxOcXbbWcHYP1qSEp63e0t7Cp+tpTjTd3
X-Google-Smtp-Source: AFSGD/UGkYGiX3Xc/elHKpFZaf5M0pXIOSdWcScKRsf0+Gn5LDsoSmMqxEAk3LILYH9TeDKbw9AN9nYuLlOq8CrFQLE=
X-Received: by 2002:a19:982:: with SMTP id 124mr22177933lfj.138.1546505243954; 
 Thu, 03 Jan 2019 00:47:23 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5CF5uYDm_XM8m-+9ARQPsxVqNqUJuuHwEF-CRu2DNDOdQ@mail.gmail.com>
 <20190102221441.GA22974@ripley>
In-Reply-To: <20190102221441.GA22974@ripley>
From: Oliver Graute <oliver.graute@gmail.com>
Date: Thu, 3 Jan 2019 09:47:12 +0100
Message-ID: <CA+KjHfZj9b4hekz0TU=BkijcQHd0vdqPvPsr3qxAqs3Kq20kHA@mail.gmail.com>
Subject: Fwd: Re: [PATCH 1/3] ARM: dts: Add support for Variscite DART-6UL
 board
To: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_004726_849638_89A2966A 
X-CRM114-Status: GOOD (  10.47  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Oliver Graute <oliver.graute@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

hope this message come through:

>> +&lcdif {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_lcdif_dat
>> +                    &pinctrl_lcdif_ctrl>;
>> +       display = <&display0>;
>> +       status = "okay";
>> +
>> +       display0: display {
>> +               bits-per-pixel = <16>;
>> +               bus-width = <24>;
>> +
>> +               display-timings {
>> +                       native-mode = <&timing0>;
>> +                       timing0: timing0 {
>> +                               clock-frequency =<35000000>;
>> +                               hactive = <800>;
>> +                               vactive = <480>;
>> +                               hfront-porch = <40>;
>> +                               hback-porch = <40>;
>> +                               hsync-len = <48>;
>> +                               vback-porch = <29>;
>> +                               vfront-porch = <13>;
>> +                               vsync-len = <3>;
>> +                               hsync-active = <0>;
>> +                               vsync-active = <0>;
>> +                               de-active = <1>;
>> +                               pixelclk-active = <0>;

> Don't add timing parameters in the device tree. Add the panel support
> in the simple panel driver and use the drm mxsfb bindings.

can you point me to an example? I don't have any clue how to do this.
which panel driver code do you mean?

>> +                               MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT
>> 0x03029

>Is this for Wifi? If so you could add a pwrseq entry that could take
>care of it.

yes this PAD is for wifi. Do you have an pwrseq example?

Best Regards,

Oliver

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
