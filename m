Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A59C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:45:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612752190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y9UUtFgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612752190C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=urOGC5ih4AyUO2OTyaa8hN0OiapImZ1PRhNTFRz7YNE=; b=Y9UUtFgZ92a4pQ
	3dD8wUbnUrp9VWb9sDXAyIa1uP9K0jiFz7F7IoaCmz+zc/jb1CRGGs2X1xVNTeVNFCANO9QOGIjCk
	Z6etaJOdgxf1Rfa0AB+N9sbvxVHf5kPg/cKGlLGUl7jPh/lFRbUTTOU85U3rgqxwqy3gLhp2CzG14
	pImxoavqBj2VIejQYXxN8krSL85JFHkLifEbGmeqFYG6u05Lf3y1fdJ1+gO9Ts3290u5VKfxBGJ/5
	YzbDPUu9994MXFDFQ5gCXAGj52hqZjStBUIUe9sMGDrKP/ozHbzIKB96BnKftfFCDk8S7HVKRAdlq
	Rnyr/uQy5gamsh+/CFzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guffq-0001AR-FH; Fri, 15 Feb 2019 15:45:10 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guffm-0000YV-AA
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:45:08 +0000
Received: by mail-qk1-f195.google.com with SMTP id r21so5908144qkl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y6s3IwoXv7j1dAi3PRDD2CkqfUPTvMHgcgvQtlOjYy8=;
 b=oUzLzhiHw01I3kM900U8dlZn/4Qs5iMUziUgaOBPtElGL5oBmwjfu5UDDAq3Bh6jM4
 0nmhRchNH87iJWC3/rRuNFOa8mvJAkB1Q0tw3Ezs4gEHYENaG+CTLnjr43r4cyEn2VAH
 XE1KsC+tEci/LwC/Njr/ebeWBNmQaIqyJPlBWHWmCAlin83xbiFIq9rCsK3XhpUS2+/l
 3GAR+oo2j8L2CO3T6528rFPeq4MQed6N9VFNG9vBCLShZqUXh2B+jCn0R0X/dACqDvRL
 kMlHkRFLCK2NdN/IOSJ92x/298PKRpdDbNy5t7zWomtv1O/tTseRuorCyMLUfgHSKvEo
 sujg==
X-Gm-Message-State: AHQUAubTBB1MD2OUlv+HaiK/FTRCX4JFeRiwvZ3Rpw2HqLj4j9CmB/86
 wEYYWZqgEieFpc2A64qSyUM+Aaii3oi/NsqxMoE=
X-Google-Smtp-Source: AHgI3Ia/V920ENZRsmlP9MJSNszoqStoHZE51s1UJxGnkvcyXp/I97Abi5yzbroQXXRD6WpPjl2T8uHh0MF44/komoA=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7499604qkh.173.1550245505275; 
 Fri, 15 Feb 2019 07:45:05 -0800 (PST)
MIME-Version: 1.0
References: <87k1ia561h.fsf@FE-laptop>
In-Reply-To: <87k1ia561h.fsf@FE-laptop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:44:49 +0100
Message-ID: <CAK8P3a1+anoAJvXmU8xCVnyuEAVC-Hs055ybZjmUmfJRdd0x=w@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mvebu: dt for v5.1 (#1)
To: Gregory CLEMENT <gregory.clement@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_074506_926644_C61F98E8 
X-CRM114-Status: UNSURE (   8.69  )
X-CRM114-Notice: Please train this message.
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 10:22 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

>
> ----------------------------------------------------------------
> Andrew Lunn (1):
>       arch: arm: dts: Remove disabled marvell,dsa properties
>
>  arch/arm/boot/dts/armada-370-rd.dts            | 42 -------------------
>  arch/arm/boot/dts/armada-388-clearfog.dts      | 58 --------------------------
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts  | 47 ---------------------
>  arch/arm/boot/dts/kirkwood-dir665.dts          | 47 ---------------------
>  arch/arm/boot/dts/kirkwood-linksys-viper.dts   | 47 ---------------------
>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 47 ---------------------
>  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi      | 41 ------------------
>  7 files changed, 329 deletions(-)

Could you have a look at these warnings and send a follow-up pull request?

../arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:21.4-16: Warning
(reg_format): /dsa/switch@0:reg: property has invalid length (8 bytes)
(#address-cells == 2, #size-cells == 1)
../arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:23.5-15: Warning
(reg_format): /dsa/switch@0/port@4:reg: property has invalid length (4
bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb: Warning
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb: Warning (i2c_bus_reg):
Failed prerequisite 'reg_format'
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb: Warning (spi_bus_reg):
Failed prerequisite 'reg_format'
../arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:20.12-26.5: Warning
(avoid_default_addr_size): /dsa/switch@0: Relying on default
#address-cells value
../arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:20.12-26.5: Warning
(avoid_default_addr_size): /dsa/switch@0: Relying on default
#size-cells value
../arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:22.11-25.6: Warning
(avoid_default_addr_size): /dsa/switch@0/port@4: Relying on default
#address-cells value
../arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:22.11-25.6: Warning
(avoid_default_addr_size): /dsa/switch@0/port@4: Relying on default
#size-cells value

Thanks,

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
