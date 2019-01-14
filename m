Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA4BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:31:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE64F20660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bbLYdKe2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9GeBFGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE64F20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wE9K+dOgWEPrfRQRW7oT/nbIU7gjFy9mrFeNeA4r2mc=; b=bbLYdKe2XtTeQ1
	2cowFYFko1qfClc5FgqxeRGKwe+9mlf63Xc3761tMX79PVAAJW6sjCwJFRRTG8wC5xbkIlLiC+rk8
	JEpHxu4LfpBV4eAudlquoinmBI2rFsZgbl2oCDQOuyuXoWAoNlfYY/Z7Lzqkstio44kr1dHDJpXEg
	EgJbKSp1Z/YLIZRklznTAOMryvKe0wyofg36hqobL9p82kSP47aYPdcpvhsuGBU/fPkz03Chv3d1l
	FMfc6AmRVNBewQSb8HY6zvH4TgCrUXkXZzqDdz2ouwwiAkq4wCi/VOvxf+mRkPRIoXzeBJOhjT7bS
	zNaboJsTQ4pWlbbw45GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gixeD-0005io-3x; Mon, 14 Jan 2019 08:31:05 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gixeA-0005i9-1g
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 08:31:03 +0000
Received: by mail-lj1-x243.google.com with SMTP id k15-v6so18163057ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Az3RWfoCMnwLEWeFUMYgt99Up9yY7m/91dl1FDieLog=;
 b=D9GeBFGb5KvAyiFLcJYkLpwS1Tlfsqeek/gn7IuX4j44mg4Y0KByDfET0XlHRIjmBY
 Plao1hgMRpba5m2NmhWDI4aQAJkjytNjgimTZ6rk8XL2CXXaV8jWmtwx4MDoMXPtCeld
 SNxgqg7khvRSgrDW7y4/UFiV0Y/of6P5S9zaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Az3RWfoCMnwLEWeFUMYgt99Up9yY7m/91dl1FDieLog=;
 b=CVEs7RksLx1MSgbpJWFHT1D5SISrYhtsXnkIfhnL3DE+y6oWwoOJco7e4k6vRc+MmE
 bpd6UWgGodJFuSm8GbXbCD607UH93r9OCJnxV02wc9t2geoQPYCdEv7N0THvQe1zozXa
 ADrlRPdZY77yPFp9kXD/vZa2v1dXTk0gKT8zDOzYLuRdoigympeDgExat6u+5o0zosz6
 oLQ1DZcAXI/vBCDv8KrIVR3QvmB1lefw5X71PNg0EQGzxzOWn4yEz7OLFBzZHZ8gbHS2
 jHV09GcTipStQ+o4Pn5ixoVyNyRJGFIpPwNbduB4AbqbBRo7CT/yfwHjaGCB4VF9JNMI
 M/WQ==
X-Gm-Message-State: AJcUukcps+vfF2+mIkjhBZrs90ye4RzxKskDuJULwJ+ohBxm//uTOX+O
 rB3kXonCVKsfWE4x0gB23v4SCtQU5ueOBhT+QYqY/g==
X-Google-Smtp-Source: ALg8bN4SUTOnWgb4TYSpLNqt0Lowq23so4y3Fb42XRTmhlgKnHWLlJZn6azgZcYCmUw3INNs3u3UsKOdhTqBcWN02/A=
X-Received: by 2002:a2e:9e16:: with SMTP id
 e22-v6mr13587618ljk.4.1547454659122; 
 Mon, 14 Jan 2019 00:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20190112125913.22085-1-martin.blumenstingl@googlemail.com>
 <20190112125913.22085-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190112125913.22085-2-martin.blumenstingl@googlemail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Jan 2019 09:30:47 +0100
Message-ID: <CACRpkdar33+on8Ve6-+5VD6OtSD=Pa8rdEHYkE6G8_XwXYp1TQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] pinctrl: meson: meson8b: add the eth_rxd2 and
 eth_rxd3 pins
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_003102_100585_F977D844 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: Jianxin Pan <jianxin.pan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 ingrassia@epigenesys.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 1:59 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> Gigabit Ethernet requires the Ethernet TXD0..3 and RXD0..3 data lines.
> Add the missing eth_rxd2 and eth_rxd3 definitions so we don't have to
> rely on the bootloader to set them up correctly.
>
> The vendor u-boot sources for Odroid-C1 use the following Ethernet
> pinmux configuration:
>   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_6, 0x3f4f);
>   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_7, 0xf00000);
> This translates to the following pin groups in the mainline kernel:
> - register 6 bit  0: eth_rxd1 (DIF_0_P)
> - register 6 bit  1: eth_rxd0 (DIF_0_N)
> - register 6 bit  2: eth_rx_dv (DIF_1_P)
> - register 6 bit  3: eth_rx_clk (DIF_1_N)
> - register 6 bit  6: eth_tx_en (DIF_3_P)
> - register 6 bit  8: eth_ref_clk (DIF_3_N)
> - register 6 bit  9: eth_mdc (DIF_4_P)
> - register 6 bit 10: eth_mdio_en (DIF_4_N)
> - register 6 bit 11: eth_tx_clk (GPIOH_9)
> - register 6 bit 12: eth_txd2 (GPIOH_8)
> - register 6 bit 13: eth_txd3 (GPIOH_7)
> - register 7 bit 20: eth_txd0_0 (GPIOH_6)
> - register 7 bit 21: eth_txd1_0 (GPIOH_5)
> - register 7 bit 22: eth_rxd3 (DIF_2_P)
> - register 7 bit 23: eth_rxd2 (DIF_2_N)
>
> All functions except eth_rxd2 and eth_rxd3 are already supported by the
> pinctrl-meson8b driver.
>
> Suggested-by: Jianxin Pan <jianxin.pan@amlogic.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
> Reviewed-by: Emiliano Ingrassia <ingrassia@epigenesys.com>

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
