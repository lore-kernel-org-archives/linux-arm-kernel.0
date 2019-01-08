Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F89C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:03:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155D8214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HmmCf8D1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BM87YX8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155D8214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k6Aa61r/cV4jJQZKC6U9ydUBlHXRBKlCikoZ8HJO5Mc=; b=HmmCf8D1BE98rD
	LanS1EPjnZqVS2Z110ySAc36FNQ6l7l+td0SB1g+oO/9UAsPcaitgRb8ypgKAZsxqMSbpce3Qzwc6
	Z1CF+x2GXNBnKgPHybk9Y5DiNQ3DRALlPiXsPQhm+BGsXYJ8AnYggJZKDiZSZ0amvgQjMSHAHoQfK
	o4Coc5dYN1QDDHcU1nSkoFrDZJ0D0YGqKEWKFyJEl9/XFC3eWlMo4y9RFHj5rUDjdqXxhkKz3Diem
	UYzZd9+rEIpEPIVY1GxtqOknDCTj6QIfzZCz2QSugVMfCCWl0F8A29z+NZg9Kk9bfrAFR+pFxgj+S
	yejFtF0I9Ob/NlFESU8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzSa-00085i-4A; Tue, 08 Jan 2019 22:02:56 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzSU-000843-2y; Tue, 08 Jan 2019 22:02:52 +0000
Received: by mail-oi1-x242.google.com with SMTP id i6so4664201oia.6;
 Tue, 08 Jan 2019 14:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yeRzpbcbgjbI0lLhadxvwvgMS0KwUgW5YCjFRCqRO5o=;
 b=BM87YX8L351IUkFQyLgOZz4LHFdXPPzu6qHalOc+0nMB6swynxEjEULDFbJIJBdkKi
 XUY+jjYY1ivdoA9eiZnsslUSL+KCDpa7fjtF2NAdbLe+HLbp+psvHi5si5HAvnfsDrEk
 lEfg0gtcQi54DsNO5eLiVyFBNCtICM8e2usv+ofS0ldRhazJIOTmLw7Ra2EEePpzm/p7
 7Q7vY2vo1ynNbTjytq1qScDrnnETs0rWXdePvvtS/dfOtfyAQ1wcvpXoKwQfr6vB2aRi
 tWs3Ejdpk1hIVHcUj9brBuJo/uGiVb7S9bNGttWAjadEI+IUxSh1ZczrOH/W/XkOuNSR
 WcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yeRzpbcbgjbI0lLhadxvwvgMS0KwUgW5YCjFRCqRO5o=;
 b=tyEmjkOUVv8QEt7jlwCEwfk3OSAXuHxGBJEuHWBk+igYha/BBK65CtrQ42jOYOk8xG
 HzVdW2zLy67/qO/dzN88YGPYVV63VzkBeAvBsrr8+HGMVCPKrwgJB7jYCPM7R8heE6w0
 NP/yadrpRg8ek4SQhBwJphvwqt+gwYrTKaz5XmtIIpsOwld7uWjq3MBMVPFpFp8Pn7yf
 6tAGpunKWSp4ow8czpsLCIEKE+LlF8Pe2ThaZiqBj8xXY8TDktV8EQMLL6Aa21/hga+9
 S10dwDmYnXtSbmxHuatbEvLgMR9wR5TI9CFkHD4mvK2XvQZrrUEvAerJLojR/BJhpnba
 JnSw==
X-Gm-Message-State: AJcUukeVtsHN/2uNr57oOLXQnpLV3pbOHJew1ZxUqBqFzBQdXBO7xCyZ
 VEMjIYwq/wr8HeDfl+b95Wz1M3fGMAjW2FcaYhs=
X-Google-Smtp-Source: ALg8bN7P51/jqB+bkFgTZpb06PMT3+o9vsQB+Pam0L0oni5TcWVpMqzKi0oPZOK55cKh9170xpCkLlyvOpyuez3/n5c=
X-Received: by 2002:aca:34c2:: with SMTP id b185mr2297343oia.321.1546984968358; 
 Tue, 08 Jan 2019 14:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <20181229125711.5205-2-martin.blumenstingl@googlemail.com>
 <CANAwSgQjoXqbV2hDs4W3kR=7ULK0gkR24V6SiEJw2+mYsaNcVQ@mail.gmail.com>
In-Reply-To: <CANAwSgQjoXqbV2hDs4W3kR=7ULK0gkR24V6SiEJw2+mYsaNcVQ@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 8 Jan 2019 23:02:37 +0100
Message-ID: <CAFBinCCRTCV2TUhaDGtjQbXp2bSh4cnP6pW25B0JVpCK64qYVg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: meson8b: odroidc1: mark the SD card
 detection GPIO active-low
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_140250_274872_830B52E3 
X-CRM114-Status: GOOD (  24.32  )
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
Cc: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-gpio@vger.kernel.org, balbes-150@yandex.ru,
 Kevin Hilman <khilman@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-mmc@vger.kernel.org, bgolaszewski@baylibre.com,
 Guenter Roeck <linux@roeck-us.net>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Mon, Jan 7, 2019 at 9:51 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Sat, 29 Dec 2018 at 18:28, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> > tree") SD cards are not detected anymore.
> >
> > The CD GPIO is "active low" on Odroid-C1. The MMC dt-bindings specify:
> > "[...] using the "cd-inverted" property means, that the CD line is active
> > high, i.e. it is high, when a card is inserted".
> >
> > Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
> > drop the "cd-inverted" property. This makes the definition consistent
> > with the existing dt-bindings and fixes the check whether an SD card is
> > inserted.
> >
> > Fixes: e03efbce6bebf5 ("ARM: dts: meson8b-odroidc1: add microSD support")
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  arch/arm/boot/dts/meson8b-odroidc1.dts | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > index 58669abda259..070d69889f3e 100644
> > --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > @@ -273,8 +273,7 @@
> >                 cap-sd-highspeed;
> >                 disable-wp;
> >
> > -               cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> > -               cd-inverted;
> > +               cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
> >
> >                 vmmc-supply = <&tflash_vdd>;
> >                 vqmmc-supply = <&tf_io>;
> > --
> > 2.20.1
> >
>
> Please add my on my Odroid c1+
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
thank you for testing this!

> My Odroid C2 is also fails to bootup with out these changes.
> Can you send patch to fix them as well.
I sent a more generic patch (after a discussion with Linus) which will
fix all boards with the "cd-inverted" property even if we don't fix
the .dts files: [0]
(that doesn't mean that this patch is obsolete, but it means that we
restore compatibility with .dts which use the "cd-inverted" property)

it would be great if you could test that on your Odroid-C2 and give
your Tested-by on that as well!


Regards
Martin


[0] https://patchwork.kernel.org/patch/10745961/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
