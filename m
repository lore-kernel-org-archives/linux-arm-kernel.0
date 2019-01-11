Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6FCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:52:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A5C206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DiM5ANPc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XBmdOYir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A5C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=70aDKDVCxG+kQUCdMPB65SRdgtBaNcj9GlVUsPlpDO4=; b=DiM5ANPcq0p9Op
	7h16EnR2NzqsR4pEOlsEM30lqg9tzehaSJVFgvuvM2/1zhOaJjKWjFDxDjsHJ7I5PY3G2tbvlI3Kx
	8tqIG9YcSe5qc4ItaAqqhLK0SjRsvab8vekWYTif1zJsNzcRDg2dGfpfrzCEx7aIFMhDqyZ3B8kRp
	Mvg7J2TaSLvEzqBQEi2orrxyh9Zm01jY2ojmeWDdkAJV1pwA2aOVwQBNFyZu7Zyq/Zt6Sb265SEjx
	qE7oEOSqn94YLv0EDLZ6M2SRduNlaUBXrTh1mu2lQR0miUv1SKjrK3UJDoxk/DZNbNphDr2V28Vsz
	OA3bf4fQ+NassQGXdPmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2qs-0000H0-1X; Fri, 11 Jan 2019 19:52:22 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2qo-0000G0-31; Fri, 11 Jan 2019 19:52:19 +0000
Received: by mail-oi1-x242.google.com with SMTP id x23so13182919oix.3;
 Fri, 11 Jan 2019 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xlwQkgyNwlUr5Jjz4XNzir1Eeh82iUGOAQkdFKFSUPg=;
 b=XBmdOYirXjcuvUZxXQQMn7t3KNJOL/6qXpGSeoGclD6mRe8xHHONelyIXYVscs812W
 pyUwJm0Yjzzicg8a1QIDyIm7OI1dMSxjTt/wgoxXsxfzkGgFoCJ1ff4aT+GIyOfpFZG5
 diKNYJwfGLthWb27PdC7giVHdMe77rVoWKvMeUEQ0oDKtt+hcbQU6jWb0R6eFcCzOHaI
 WXxHhGTOzNHtXfYzhzsT+LbwpTGsD8r3USMXSHn7qZPYoXWftFp6U0TLXiOlx2CkAO7g
 3fM3qCVZCkVAV6eLZWB7IE0DPqUgNb/JK+AVdN/hL67k7GHSkAvddKJM1Yp8JlzAIdTx
 RZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xlwQkgyNwlUr5Jjz4XNzir1Eeh82iUGOAQkdFKFSUPg=;
 b=LpIxRdfLFNMDnmhKQ+MOe/m/ueS6bHkxfmsc0D1i5/2DDSRbSEcpL+laDlSh0lRiJG
 ipWDwdwLkKG8e4Yo+w7bsCoKAXpWv+A4aMYom43z6kc61/ZYAmghyYLLayJeuwdM+nzv
 xIOQrkoziqBYSR0HW6fiEvv2G5lsZjZQce9649lpr1opuXMlbegI9Fb8VeA6OjlZKILU
 K7sTnJ6UKeS7waF4cizQ23aLRkFi4ffoOMWsCeqfPCFaYTXTNhGOggibEfjujgtyNuee
 yxKnvB+HyrU9VPQ+NF1MRvHHHkCm+fdQsBCejvTlYByG+OUs+i89bA7lZY87KfK4fZSi
 CkAg==
X-Gm-Message-State: AJcUukfK9ma5cEZ9YYQEEntM2CXvcH6hn/GEiOcxTrvZc2rCcTuz2qPL
 Cp1ngr6czYLgp5UHMy3O5+Kw6B8G/LK4cQJytU0=
X-Google-Smtp-Source: ALg8bN79rynvo1Vl7drC9biJf9lXxlfHsJLs60Dc1QworIZ2SOFoshUxkeKGzFMrSXkF+ZG3zpAhrgsbpXo9SDWVVHU=
X-Received: by 2002:aca:e884:: with SMTP id
 f126mr10323054oih.181.1547236336666; 
 Fri, 11 Jan 2019 11:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
 <20181229143556.27339-2-martin.blumenstingl@googlemail.com>
 <7hzhs8ovag.fsf@baylibre.com>
In-Reply-To: <7hzhs8ovag.fsf@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 11 Jan 2019 20:52:05 +0100
Message-ID: <CAFBinCB41iRf-5AdUir9Z9AYPGP4-yfD4B3Yn9+v+dxSFJoELA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pinctrl: meson: meson8b: add the eth_rxd2 and
 eth_rxd3 pins
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_115218_138943_0EB3EC30 
X-CRM114-Status: GOOD (  13.21  )
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
Cc: linus.luessing@c0d3.blue, jianxin.pan@amlogic.com, linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org, ingrassia@epigenesys.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

On Fri, Jan 11, 2019 at 2:08 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > Gigabit Ethernet requires the Ethernet TXD0..3 and RXD0..3 data lines.
> > Add the missing eth_rxd2 and eth_rxd3 definitions so we don't have to
> > rely on the bootloader to set them up correctly.
> >
> > The vendor u-boot sources for Odroid-C1 use the following Ethernet
> > pinmux configuration:
> >   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_6, 0x3f4f);
> >   SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_7, 0xf00000);
> > This translates to the following pin groups in the mainline kernel:
> > - register 6 bit  0: eth_rxd1 (DIF_0_P)
> > - register 6 bit  1: eth_rxd0 (DIF_0_N)
> > - register 6 bit  2: eth_rx_dv (DIF_1_P)
> > - register 6 bit  3: eth_rx_clk (DIF_1_N)
> > - register 6 bit  6: eth_tx_en (DIF_3_P)
> > - register 6 bit  8: eth_ref_clk (DIF_3_N)
> > - register 6 bit  9: eth_mdc (DIF_4_P)
> > - register 6 bit 10: eth_mdio_en (DIF_4_N)
> > - register 6 bit 11: eth_tx_clk (GPIOH_9)
> > - register 6 bit 12: eth_txd2 (GPIOH_8)
> > - register 6 bit 13: eth_txd3 (GPIOH_7)
> > - register 7 bit 20: eth_txd0_0 (GPIOH_6)
> > - register 7 bit 21: eth_txd1_0 (GPIOH_5)
> > - register 7 bit 22: eth_rxd3 (DIF_2_P)
> > - register 7 bit 23: eth_rxd2 (DIF_2_N)
> >
> > All functions except eth_rxd2 and eth_rxd3 are already supported by the
> > pinctrl-meson8b driver.
> >
> > Suggested-by: Jianxin Pan <jianxin.pan@amlogic.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
thank you for reviewing this!

I just realized that I forgot to CC the linux-gpio mailing list as
well as Linus Walleij on this patch (fixing that with this mail) -
sorry for that.
right now this patch is applied to linux-amlogic.git's v5.1/dt branch.
please let me know whether you would like to keep it in your tree or
if you would like me to re-send it (including Linus and the linux-gpio
list this time...)


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
