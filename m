Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64525C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:28:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317FC217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FznMHOko";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JKvmMgI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317FC217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MBg4NL9YBRpQHJ2F60IykhPXEWnli6WGVXRaeghc0uQ=; b=FznMHOkozyUQMo
	RVjwwL5lXIE4qjZyBHTivHvYB4I7sWvPacvx42RvURW1UYjC5b6vbpy95cCgaS1V7IcUo9FVLOPpt
	Reqy4EH67iOYyWz5Ea3085bzatOD43WBaUt9DDflA9fjEXUAIs4Dv1EiAkGrJZJa51b7bp3fBwG5s
	IxsY+wdJ0B4UJg2BYH9HESeTmuGzPFhuv1wH2WWTDD3162a/9Dfo7EWh+X0I3lN7CjIRZtPH3JzxT
	WXmk4cG0eECHSTO0L5dvD/8H+rFih/vO/Wau/yglNQQJRVbgCvkcXJQ74F5kWoNFi28PNb773/Vjy
	4vAEk6PG+52gEDrIWojA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grLNo-0004Yw-Df; Wed, 06 Feb 2019 11:28:48 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grLNl-0004XE-1x; Wed, 06 Feb 2019 11:28:46 +0000
Received: by mail-ot1-x344.google.com with SMTP id 32so11181022ota.12;
 Wed, 06 Feb 2019 03:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q6uxksyd4B7vRqtlr+5W33DQQzfWzcoKK5+Un05MXvs=;
 b=JKvmMgI+O1towSFvmv+w7YwuBdOXO83XUBp6QYktR92TUzh8aIowl6PndOc+O5C4j8
 7X6ycgstGT/8U3ovsoEee9vcNkHpj7FIl1m1mydaP9USlGjBXSb3dX4B1fsS+wOYah1a
 fGOBlcxau8uFofrQhWjqovEAcKpR/9Rn3ACNmwIux9Ntnqt0VjoJ0p6gENEyO5GB65d/
 rO55pqUdPubYOr3+XH6EhOGgV5IakJ5JGI1xfQpddy7ldNEEP6IK2jmtwygN85rNBr46
 +P0aX0oWOe+3Tawz2xGAiJUpZahJ763qLccUXcWMmVJNj6hwI0XOOkpq/BJb4t/MGzbj
 hgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q6uxksyd4B7vRqtlr+5W33DQQzfWzcoKK5+Un05MXvs=;
 b=EhhKxY5kFsJaMUoRb+2+be1Joj2NB7rDaW9zApNI7iXoOytBYPFdoRvUpnXsmWDOj8
 mlE/LDPjHrk16RilxNdMp6dBW5FQTn8OfMbkeNDoshtEPWl5KELQZiystDXqO1zQux0w
 TObsnN24FsnoWvRnBxzGVV+MdX6T2fdrR5I6SKy78S/ZdpRS5YdR2IaMbk1oFPeJp6t2
 FvH3HsN/jhd3RsP682+nFvWXjkncOFXneiahQnSWlmm3Zyps6k6yLAZlFtXYx/5Swci9
 Y8S4n3DpNXiRvx2fhPH8zEx5lb+OoS/MXQdqsWLY2TcHwt9/7ojWGKVRcNbt4E+O10/M
 Ds+g==
X-Gm-Message-State: AHQUAuYnzX6dl4B8QJ9tlrGxv0i32hpjVqmSLEF4NrgQWbtlvPz4Q0Ap
 p2iTyoRFh5l/Iem8XdrpOrmp2yDlNc15cL/UibQ=
X-Google-Smtp-Source: AHgI3IZnKAjfMiHnkbT1AerxK1Z3q8GXLb3dcvennBaAEK4TzTIhYlxFXLgzTkIO0igglWD4KIBL9R61Ep+UKiYnEgI=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr5428844otj.148.1549452522210; 
 Wed, 06 Feb 2019 03:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-3-linux.amoon@gmail.com>
 <CAFBinCAdf0rtt-7tON_LRNH_cpvGJXX3LX8g-i4xsC3wahZSVA@mail.gmail.com>
 <CANAwSgQ4=Vn6RM4Kpd20UWkQNW81=mfg-qB0G73dsRem3qwjcA@mail.gmail.com>
 <CAFBinCB=3kmuFb_xXzhW+m8dTasVrCHQp2wti+=5UjrAHk5TTg@mail.gmail.com>
 <CANAwSgQnMkXECkCVjFKwNKB+2JoiPtVPQbateppmtgfPYCutZg@mail.gmail.com>
In-Reply-To: <CANAwSgQnMkXECkCVjFKwNKB+2JoiPtVPQbateppmtgfPYCutZg@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 6 Feb 2019 12:28:31 +0100
Message-ID: <CAFBinCCFoBkbf-HvEoMk7mTYTBV27nJ9TF1X-DrLuHR9qDVDSA@mail.gmail.com>
Subject: Re: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies
 for phy
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_032845_119173_D79290FC 
X-CRM114-Status: GOOD (  13.56  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Tue, Feb 5, 2019 at 8:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > my interpretationfor the Amlogic SoCs is:
> > - vusb_a and vusb_d are generated internally, not sure if there's an
> > external fixed regulator
> > - there is no phy-supply (the PHY itself is powered by clock-gating
> > using the CLKID_USB clock)
> > - usb0 VBUS is controlled by GPIOAO_5
> >
>
> But as per the device tree binding
>
> [0] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> [1] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/phy-bindings.txt
>
> its uses phy-supply to enable power to usb phy which seem to be correct option.
phy-bindings.txt states that "phy-supply" is a "Phandle to a regulator
that provides power to the PHY".
I have written the example in meson8b-usb2-phy.txt and I think it's
wrong (back when I wrote it I didn't know about the "vbus-supply"
property on the controller and I didn't know about the VBUS
constraints).

I believe that the phy-supply property is intended for PHYs which need
an external power supply (for example because they are not embedded
into a SoC or if the SoC has separate voltage inputs for the PHY).
I'm not aware of any PHY supply voltage on the Amlogic SoCs (I believe
this is done internally within the SoC). instead they use clock gating
to power down the PHY.

as far as I understand the VBUS signal it depends on the USB mode:
- host provides VBUS
- peripheral devices are powered using this voltage
- with OTG VBUS needs to be turned on or off depending on the current
mode (host or peripheral)
with the "phy-supply" property there's no way to manage the regulator
depending on the USB mode (host or peripheral), it will always be
"on".


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
