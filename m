Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280B1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:59:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6762082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fF9vu7uF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HzhvLDVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6762082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n4h2Nq3zi3+DLnTzNkkzApeQS3nwOWCKw82BYv6FBtA=; b=fF9vu7uFaFGUgG
	6w/Oj8kK5A41FS8O1MFwgDWnLUV4AsDibOzPGaM8oWWcYpMUCeEKvfLIrKQ8+p+M5TxRSzFq5VayJ
	3uVgE61oi/jh3GMr0potQAMf4g9jR5BQ383KD10OQ1y8+0oOCpvvFySxSjeh3bx1/EYyQZaLaS3la
	hnJLw2U44imuwniNRcQ6ZSItDTRV8UKQPNGFCFOw683aVR9KaN4rWgJT+nb0SZC9B+ThgkIgaXvzN
	TrrFQN+LGHwccxu5ldyiwTerWZmard87ZAsDBRiNWl4rtmoR8UHr2Vt4/bnsrYxFcAOChvGZu60rq
	fZZ7PvtNhXP5tKbMjiiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqemH-0006Qt-Vm; Mon, 04 Feb 2019 13:59:14 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqemE-0006QV-TD; Mon, 04 Feb 2019 13:59:12 +0000
Received: by mail-ot1-x343.google.com with SMTP id u16so13028645otk.8;
 Mon, 04 Feb 2019 05:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KF1X/3cj948PjMeFbZfRlquxhga99uxMWr3+oeJo3s0=;
 b=HzhvLDVCyjAlYQIP9Q99PYJ+n6RKuxMfJDeP/Xg8EYZJOrfoFS/vbUYy7rA2WFcSHQ
 xsL9MWk536KDRcU/JY8zguE0848nvpan9b7tk9o8g6ZccbN/XYRpZrSMQx/HNkTvFunc
 590R/45JEiKFOxrSUGRzMuI57rCsjfuGP4WhJS4YVYThyk6e7xiSEr9vwD2vfAIfZvL9
 78+d8MwK/ZMVjtIkZ7yI7I7NEYdkVtcf0u/0bAXds0+sbKMloMhNLAXwEiJcFle32BVn
 3pKfdbx96V8Jay8+VH/IFz6fKWDWrOopXfCIbDxE9sqNEN4lQwgzRzA6ndj8e4gemnwL
 EmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KF1X/3cj948PjMeFbZfRlquxhga99uxMWr3+oeJo3s0=;
 b=qeghRZzFOp7A/SuqFq1i8ZRQoMbJooEkaxtsTj+u4waX7K2ouENhkNfRsFUfhbAXFb
 SRkfupWS9b3ko3al+Ogr5+jq7ZZ1otRekzuPN+7uPem/oL/aTtn79wPUBCyqVyMeRZCX
 J27njeAhaFQ4P7JA4nF6EAR2c2ceDZuynj9LHS6+OGaJrs4COaoVJn/NMMoI6xvzWKKM
 EYopGL3eeTcdCIPaP9SHnWYmwd20S7BA0sFyik4l23ggcVtj9uizOkAu9tarXw9GNoy1
 bUTztIKCNnt8sxPlsA8z38qJkmTokPXLB3pgIJGZKUE74Aokro7IuXAjym9fFOTko2tY
 1agQ==
X-Gm-Message-State: AJcUukdWQPYELUCL/FmmPrF46Rpr5hI/vkw7rHRXlOvzvyYWaHMlabLt
 PgUG0gLNIWbSIkQ3xRJTKVrz9MrfsZ7Lzl4ycoY=
X-Google-Smtp-Source: ALg8bN7FU8oOdQZnUAXmiYPg3p0yWdVj2YngiQneYml9cjWV6TAYvY+/AgfilrX2oHq7gRPWkDTlYkWQK1Q+kior4os=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr37903772otj.148.1549288749719; 
 Mon, 04 Feb 2019 05:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com>
 <20190129102521.4141-2-linux.amoon@gmail.com>
In-Reply-To: <20190129102521.4141-2-linux.amoon@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Feb 2019 14:58:58 +0100
Message-ID: <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset
 warning
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_055910_942554_84C5EE8F 
X-CRM114-Status: GOOD (  16.77  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Tue, Jan 29, 2019 at 11:25 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add missing vin-supply node 5.0V regulator setting to power
> to usb ports, changes help fix the usb reset warning.
>
> [  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2
>
> Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> changes from prevoius
>
>  regulator                      use open bypass  opmode voltage current     min     max
> ---------------------------------------------------------------------------------------
>  regulator-dummy                  5    4      0 unknown     0mV     0mA     0mV     0mV
>     c9100000.usb                  1                                 0mA     0mV     0mV
>     c9100000.usb                  1                                 0mA     0mV     0mV
>     c9000000.usb                  1                                 0mA     0mV     0mV
>     c9000000.usb                  1                                 0mA     0mV     0mV
>  P5V0                             1    1      0 unknown  5000mV     0mA  5000mV  5000mV
>     USB_OTG_PWR                   4    2      0 unknown  5000mV     0mA  5000mV  5000mV
>        phy-c0000020.phy.1         2                                 0mA     0mV     0mV
>        phy-c0000000.phy.0         2                                 0mA     0mV     0mV
> --
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 2e1cd5e3a246..da729ed00408 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -28,6 +28,13 @@
>                 reg = <0x0 0x0 0x0 0x80000000>;
>         };
>
> +       p5v0: regulator-p5v0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "P5V0";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +       };
> +
>         usb_otg_pwr: regulator-usb-pwrs {
>                 compatible = "regulator-fixed";
>
> @@ -36,6 +43,8 @@
>                 regulator-min-microvolt = <5000000>;
>                 regulator-max-microvolt = <5000000>;
>
> +               vin-supply = <&p5v0>;
did you find out why this patch fixes the USB_OTG_PWR regulator?
based on just reading the patch I can't find an explanation myself

have you tested without this patch to rule out that you hit some bug
in the regulator framework back when you wrote the patch?
(I don't have an Odroid-C2 so I can't test this myself).


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
