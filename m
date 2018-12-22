Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583B8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:58:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4B421A48
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o/qK4slt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="e22OQZEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4B421A48
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aGb+EE+K/39qTnADePRdaGA7uH843QC/8hhzCxSi2O0=; b=o/qK4sltp83u5l
	Y1WTLgT3S9L95cvWUOY4CZ6MwC3sywKAHS0y1icHOaT+ep/ETwNWFHnvuvS7RHgH+T1VzHEXBQwir
	kkxsTxhq5TEdPF0r1FEB49IBLu/U2rNnruUrsP3DRljGSPLqhsOceH7z1kLZ2hRg3i25O/UdtCD9J
	b7RJUUqGNSTA1cOuh3tdl4SG72n/P6SxoXiqsTxQOw2HLvXERnlEuRTFbZLQQ4DZdKVx+EqLvEGeH
	17xGJ3wVHjkF+ujgfTlgGJFljxqA+o8GfC7GCCPM0akDCzze9Yw8sUUas24PYExXuDhMIsst43ATQ
	KAJBzthPXK22ko2BuPpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gakbJ-0004io-EW; Sat, 22 Dec 2018 16:58:09 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gakbE-0004gk-K7; Sat, 22 Dec 2018 16:58:06 +0000
Received: by mail-oi1-x243.google.com with SMTP id x23so7288922oix.3;
 Sat, 22 Dec 2018 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W+FY5uVdvefc69zcc3y+RpEVQPA9ZZbsI3BgO1aNN3A=;
 b=e22OQZEBFXs6Za15VH7PmnsuuDKsAOnJUSRHfsD+2QVFVVHhPUxkxIM4phkr8TuSoE
 A+57kOF2ILJGP40jX8kZxt41pNdxIi7YTJv/+brcVzRyq9hX1AJFAv/nb0pNnk+tgL8H
 Ll4CGw74k1Rp9wLIIzjckGrJJvqg6DIkWBnwfpRwD6smIp15wLTl33PszDq3jvLcnKHO
 9AVwrT0ZSMjk9ZDPh1H0GieOCYFRQ8Eadm6pmSxvTMsFpoQcFIzIiIshtNKO8yMkvesG
 iHTgdv3EQJyYdUdywsuCspy+wMvasUzx65p4szpHAFTItKGWtJg111NSeLq5gsQgFoSS
 1isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W+FY5uVdvefc69zcc3y+RpEVQPA9ZZbsI3BgO1aNN3A=;
 b=CCXFBZVjUTKZIEZL5yOUuYWd4Id00Y6JsLKQ9l+3316+s+lYqfX8/uWyZyOFKrlHw8
 cFYFyFRDOib7xgisT7I6LjaIwsA8jcAjtvzvYiil4uFqdTEKedLBfg7xrSF1EYoBX9fe
 xeuBwbHFWenWK6cCtJ2I+NLx7Rv7Er8D18nrEWHZVylFcrOU9/HtidEEkIoFxjqA3NpB
 wCusS8IAfIG656mDZ7sx6EgZcC869kDjUJyVY5MbTgtWu1rdwbu7eQYNzJThreC5Mc8d
 OHvzIEv+L9wEPVwfNAiYiYqX29ZZsSHk2Us7Hp9Mw3W1qyswbZ+7Kjf6emz6HdkDEH2l
 vfWg==
X-Gm-Message-State: AJcUukdawz+qAzx3nHR/93uUfuSbnbykPxZSJWz7c8zltdRkfL1k+Oot
 AkW07MdNJ8HjJ9vp+W4mx6WXLnB62D/Q9/LuSaE=
X-Google-Smtp-Source: AFSGD/X1ORpvflMiFFXqmruZgTvZYUl5CCeBM4C1YWT53n1yYuuQZ5Asavw1ISCmsiPPOO0lzKHkm+QxGURyZASzAFo=
X-Received: by 2002:aca:4ace:: with SMTP id x197mr4438895oia.129.1545497873170; 
 Sat, 22 Dec 2018 08:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20181219002620.12138-1-khilman@baylibre.com>
 <20181219002620.12138-2-khilman@baylibre.com>
In-Reply-To: <20181219002620.12138-2-khilman@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 22 Dec 2018 17:57:42 +0100
Message-ID: <CAFBinCCbPbSQZeF1mzfBfLt+cJ0P=ajHznZM2prn600NO7G3sA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: add g12a x96 max board
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_085804_692293_0BEA71DA 
X-CRM114-Status: GOOD (  19.08  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

On Wed, Dec 19, 2018 at 1:26 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Add the G12a (S905X2) based X96 Max board[1].
>
> There is no branding for the manufacturer anywhere on the product, so it
> took some digging to find the manufacturer.  But since there's nothing
> about the maker on the product I've left it out of the DT name because
> 1) nobody will no that name and 2) keeps the DT filename shorter.
based on the cnx-soft article and my own board I would add the
following section:
-----
There are three variants of this device:
- 2GB LPDDR4, 16GB flash, 2.4G WiFi, 100M Ethernet
- 4GB LPDDR4, 32GB flash, dual band AC WiFi, Bluetooth 4.x, Gigabit Ethernet
- 4GB LPDDR4, 64GB flash, dual band  AC WiFi, Bluetooth 4.x, Gigabit Ethernet

Presumably the 4GB variants are identical except for the eMMC chip.

This patch is tested on the 4GB LPDDR4 32GB eMMC variant.
The WiFi / Bluetooth chip is an AP6356S. The Ethernet PHY is a Realtek RTL8211F.
-----

While writing this a question came up:
should we rename the board if there's a variant using the internal 100M PHY?
for example: "meson-g12a-x96-max-gbit"
this will allow us to add a "meson-g12a-x96-max-100m" (or any better
name) later on

> [1] https://www.cnx-software.com/2018/09/25/x96-max-amlogic-s905x2-tv-box/
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
(with the Makefile adjustments, see below)

> ---
> Special thanks to Martin Blumenstingl for extra digging for the manufacturer
>
>  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
it doesn't build the .dtb for me without adding the board to
arch/arm64/boot/dts/amlogic/Makefile

>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> new file mode 100644
> index 000000000000..fe94765b671e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-g12a.dtsi"
> +
> +/ {
> +       compatible = "amediatech,x96-max", "amlogic,u200", "amlogic,g12a";
did you leave the u200 compatible in there on purpose?

> +       model = "Shenzhen Amediatech Technology Co., Ltd X96 Max";
> +
> +       aliases {
> +               serial0 = &uart_AO;
> +       };
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x40000000>;
according to that cnx-soft report the smalles RAM size is 2GiB
however the bootloader will update it anyways so I believe this is fine


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
