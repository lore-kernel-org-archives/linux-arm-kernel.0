Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ED6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:05:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60D22081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rrjo5yL1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgzrVt+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60D22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eUbYWhip0IzOU4duxUbSkS8upY7v48XMZ3OxkQrFXPo=; b=Rrjo5yL11mQlSz
	xLPf/plGTAw69L9Hu9w6pTCUiy5+Z1NJ9O7bxe9HAemQQKDP6pBg0E397TN1Xqjv8ZwxuQyF1PO3D
	f+XfuVZg/jFZ+3QGXMVQaDTalAQsP4s/ANMcKygz8y0xtgQaoYMN8oNYPqaS2UR8t0FOtd+L2R2cz
	q/Pmu5wRQiTy4O8bxaeLMIGW/LwjichUFrUhRZTTIkVz2R/R2XDxJWKxWxR6vHjKAh2AgTYUnmptm
	xfmSOmQY0KJj1+zlR0faRC5ArYq9+XGAZBMMsyZ5Ok1Yf2mQObfWmhk5V7xyqWV+yvtFdZ6vIixgc
	VL/6YQSdbgU/0fjGZumg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkUG-0002Vj-9G; Mon, 04 Feb 2019 20:05:00 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkUC-0002Uw-LY; Mon, 04 Feb 2019 20:04:58 +0000
Received: by mail-ot1-x341.google.com with SMTP id k98so1986123otk.3;
 Mon, 04 Feb 2019 12:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OdNKk9nvat9w/9d/QSXjnvAWHsniXIPePf5/7xOPDAQ=;
 b=RgzrVt+Ciu+oAPB0kbcPF38EMaJMR8p7PU3D8ldh+wR8G7MSXdFCtrQSWzIQNI7A1h
 ChcZz0TZUKJX2wlQeSb7LEjGoXk2Q2vnv51Vlncr7hSaUU8qYgel3CXaWySO6k93VAbL
 a+14udI0zDz31HB3yM+IfZBuju8CAbx1f+UsTyW8j8IT/VXc6lEL1lv9rFBBW94mwk/i
 JTdaVh15hiMHgx/T35lgbHuiIuIp7xVYKz/qtfYBhEEbBjg+OFj8jV8XSbAOxY7qqaxU
 SCWHqIU23obclGrRcBaHEdtYn1QvBqXaZ8DLSjO4GQxYwesNzrlXU1A8W8IFuJG0CmQA
 yKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OdNKk9nvat9w/9d/QSXjnvAWHsniXIPePf5/7xOPDAQ=;
 b=TZfXN8NeJayU6lJiDS6WTDIws2QkV3jeP8aiM1quGBxdQqwjvBExArwnE9FwkUzNkr
 vENKK6Zc4yfL0cBDamX+Z+AEOVZNR6Ul52a47KTOWYw1B1/7mPp8UiQfiYWqA4NYZqrW
 484qFDqqYMwpN07UnpfY0um3cLpiYSl9LRwlGY8zSpsIyNlFztqOhmc3yk6QituudFtF
 TMBM0d25G+crcpZ77cDXLX8UHCWa0L7oK4u74z/7eZvxelBv9KEd/N2Q1KbS8Hs2kBMF
 38RMtMUvQxdvkHMSiDlmqyL9rK51WrfOaah/9eqAuJJVseikIl2VrPwtSGunWqNYoffm
 oT9Q==
X-Gm-Message-State: AHQUAubL6yDYG1oFpbTQYlWvFpMLQQ4OlKw+UJriamuzjjPwYcCP7wbm
 kWh8KDOPaYAtSpLJsznjtB46VBXUlQ8EYWncIRY=
X-Google-Smtp-Source: AHgI3IZMvbXODUZBbxu1Pth4DtEM4TyJk5Z7WPQKgsybgsckgchpBvI/XwLh4pbBKJY04tqF8HrGjzV/AHRArxLBZ0M=
X-Received: by 2002:aca:39c6:: with SMTP id g189mr591597oia.201.1549310695898; 
 Mon, 04 Feb 2019 12:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com>
 <20190129102521.4141-2-linux.amoon@gmail.com>
 <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com>
In-Reply-To: <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 5 Feb 2019 01:34:42 +0530
Message-ID: <CANAwSgSnR-DWffg3vKStuXQXahLf8ONssxr4+byL=PSr5JR=xA@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset
 warning
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_120456_701316_C2C4D65F 
X-CRM114-Status: GOOD (  20.76  )
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
 Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

Thanks for your review comments.

On Mon, 4 Feb 2019 at 19:29, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Tue, Jan 29, 2019 at 11:25 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add missing vin-supply node 5.0V regulator setting to power
> > to usb ports, changes help fix the usb reset warning.
> >
> > [  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> >
> > Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
> > Tested-by: Kevin Hilman <khilman@baylibre.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > changes from prevoius
> >
> >  regulator                      use open bypass  opmode voltage current     min     max
> > ---------------------------------------------------------------------------------------
> >  regulator-dummy                  5    4      0 unknown     0mV     0mA     0mV     0mV
> >     c9100000.usb                  1                                 0mA     0mV     0mV
> >     c9100000.usb                  1                                 0mA     0mV     0mV
> >     c9000000.usb                  1                                 0mA     0mV     0mV
> >     c9000000.usb                  1                                 0mA     0mV     0mV
> >  P5V0                             1    1      0 unknown  5000mV     0mA  5000mV  5000mV
> >     USB_OTG_PWR                   4    2      0 unknown  5000mV     0mA  5000mV  5000mV
> >        phy-c0000020.phy.1         2                                 0mA     0mV     0mV
> >        phy-c0000000.phy.0         2                                 0mA     0mV     0mV
> > --
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > index 2e1cd5e3a246..da729ed00408 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > @@ -28,6 +28,13 @@
> >                 reg = <0x0 0x0 0x0 0x80000000>;
> >         };
> >
> > +       p5v0: regulator-p5v0 {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "P5V0";
> > +               regulator-min-microvolt = <5000000>;
> > +               regulator-max-microvolt = <5000000>;
> > +       };
> > +
> >         usb_otg_pwr: regulator-usb-pwrs {
> >                 compatible = "regulator-fixed";
> >
> > @@ -36,6 +43,8 @@
> >                 regulator-min-microvolt = <5000000>;
> >                 regulator-max-microvolt = <5000000>;
> >
> > +               vin-supply = <&p5v0>;
> did you find out why this patch fixes the USB_OTG_PWR regulator?
> based on just reading the patch I can't find an explanation myself
>

As per the device tree binding we need this setting to enable power input source
[0] Documentation/devicetree/bindings/regulator/fixed-regulator.txt

*I have observed few more place where this setting is missing*

> have you tested without this patch to rule out that you hit some bug
> in the regulator framework back when you wrote the patch?
> (I don't have an Odroid-C2 so I can't test this myself).
>

Yes I have tested this patch.Some device like usb camera and usb hard drive
when connected to usb port will generate warning message.
which shows us that not enough power is being set to the port.

>
> Regards
> Martin

Best Regards



-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
