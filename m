Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01751C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:53:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C2D20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ia/28hRO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="s4q6dvmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C2D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lH8NTj7JkBusNm7iwbrf5D299OTMQN2JY8aBQsk8mTI=; b=Ia/28hRO4U6oUi
	FAQdOA6PZo2tnQsjdE9ODj4yJWZhUu6y25Q5EwP5IQhPmf0QxBXEG4pPdIloE6vGACUnPZgRbt1fj
	GMVAUtNBLC2md6+D/M+MdqSRo2TM5B61hxf8Mx6/qsQ5TtiTs3zzGVYPUe3jjuGFval1iIt9RA3ad
	HY7eazXDBp+y3txnvdwDV5pCQ2vjnqiaWdBCu0W8DR9zJlaL3/ipFS5HrPw4ZjfSbCnt8xhEnYHAE
	xLrVzq9s/5gCbMjkDfyKqWryr/4gsUXrlJNY6a+jktnF7OJOUOPjsR7TCnkAuzkAQ1v54fudU8A8z
	sMKv0qwHwbRkYjBFO+0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxzpZ-0001fe-BI; Sun, 24 Feb 2019 19:52:57 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxzpV-0001eU-35; Sun, 24 Feb 2019 19:52:54 +0000
Received: by mail-oi1-x243.google.com with SMTP id u128so5658327oie.2;
 Sun, 24 Feb 2019 11:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MYQcmmvOWPoSOeQLQkGxZasGkeWzPpVbLTX8A4pezEg=;
 b=s4q6dvmV8vzyo06grp4cC+jC04xPsR8+JpkdIPVXUy45VgdXNnGRcaFxBKuURWkBUb
 p6ddlpeIaURXH91qcCtIpHOiUmVD40NLv0LSb70q48NMh76kJN2Wo2gxhAVec670W47K
 28uZyPp1Shy73IVAlvqvGGQ+HIJQ6WTGqvXdLczF/p4YhxpDHYV++DtYdU6RdP2ZQv2t
 uoWynKM/57sKPB592SsOLBeByczmtqnsHCeh1hYh7tZCrHIcS8mRZ7SLQfBvaiZKxWL/
 zLsvaB+7A4IXljqaoQrEHDKEMfMfmg54USMV1rBVp1mxyYAuoxw4lGrUrw/a8U+uJioj
 SUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MYQcmmvOWPoSOeQLQkGxZasGkeWzPpVbLTX8A4pezEg=;
 b=erxl3/Uvf9O0B5t6GF8uwuKBPV+7OWbxyB+11iGb/aS0sMOsNul0pR6jNI4cScxHrl
 AA1aDD1dBW1q2T2XFJQxI6IhN4vbkscaLTNgPaRRH16zPZMYKnS+xw1wrGv4xxEobgvP
 v3ixcAuFMMUdLBvfQOgIpeVRG9d7mthCnV8ZoyLFISDEm9+mSA/tdEW2xAhlUF0ZR3Kg
 fDawdvrKfX+sgd7k1bjF8o3cBEfefb+W4yUt9ElPrqOqgudpvAIUvsGhz/hMakMSiSNN
 X1T4Nmd+qPZn9qd3QiURcMcpAdyMfdLAJjWdAhV7BuBAneZkQ6bRSwh6mfq2N7WkJiRS
 Yf9g==
X-Gm-Message-State: AHQUAuZt0BthRsDFMntaajAubuUMl5WCCkk36fmiobU5pxuiw/k9Gh2D
 +FxibrTA4NMXN/5tHc3gLAxwnvBQoBmDtAK6USo=
X-Google-Smtp-Source: AHgI3IbIeKx3wATaNvdtt2nNjW6v0A+ktUiVw6Fniny1gw2+4boGchyewPpYn/tjfrbZtpEjSJl6SsL2In8Jigb70hE=
X-Received: by 2002:aca:5d87:: with SMTP id r129mr9232994oib.39.1551037971667; 
 Sun, 24 Feb 2019 11:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-5-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-5-narmstrong@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 24 Feb 2019 20:52:40 +0100
Message-ID: <CAFBinCC87H+Do3dGooYMpFjozBTCv2agmS_p5cJRbFQ7QCiuiA@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue
 Bindings
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_115253_159167_8210C666 
X-CRM114-Status: GOOD (  10.35  )
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
Cc: devicetree@vger.kernel.org, balbi@kernel.org, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 hminas@synopsys.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Neil,

On Tue, Feb 12, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +
> +Example device nodes:
> +       usb: usb@ffe09000 {
> +                       compatible = "amlogic,meson-g12a-usb-ctrl";
> +                       reg = <0x0 0xffe09000 0x0 0xa0>;
> +                       interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +
> +                       clocks = <&clkc CLKID_USB>;
> +                       clock-names = "usb";
> +                       resets = <&reset RESET_USB>;
> +                       reset-names = "usb";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               /* USB2 Port 0 */
> +                               usb20: port@0 {
> +                                       reg = <0>;
> +                                       phys = <&usb2_phy0>;
> +                               };
> +
> +                               /* USB2 Port 1 */
> +                               usb21: port@1 {
> +                                       reg = <1>;
> +                                       phys = <&usb2_phy1>;
> +                               };
> +
> +                               /* USB3 Port 0 */
> +                               usb3: port@4 {
> +                                       reg = <4>;
> +                                       phys = <&usb3_pcie_phy PHY_TYPE_USB3>;
> +                               };
> +                       };
> +
> +                       dwc2: usb@ff400000 {
> +                               compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
> +                               reg = <0x0 0xff400000 0x0 0x40000>;
> +                               interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
> +                               clock-names = "ddr";
> +                               dr_mode = "peripheral";
> +                               g-rx-fifo-size = <192>;
> +                               g-np-tx-fifo-size = <128>;
> +                               g-tx-fifo-size = <128 128 16 16 16>;
> +                       };
you suggested (off-list) that the OTG capable PHY should be passed to
the dwc2 instance
I'm aware that this is an example - could you please still add it for
consistency?

> +
> +                       dwc3: dwc3@ff500000 {
> +                               compatible = "snps,dwc3";
> +                               reg = <0x0 0xff500000 0x0 0x100000>;
> +                               interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +                               dr_mode = "host";
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,quirk-frame-length-adjustment;
> +                       };
maybe the phys should also be passed to the dwc3 instance?


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
