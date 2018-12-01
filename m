Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E39C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:31:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53F32146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EKVA0pk2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ITw8dhDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53F32146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PD3FUF14v8/+TZ8DSU4CMcHQXalIT8fatwLcF63rQLE=; b=EKVA0pk2I51veI
	QN1LiWVby/zn/BQBmgpZjh/7UB+Rf/MeX6sVUeEwzDCdjIq1reiLtxmAXHxf0hK+bs+oou01AO5sr
	w1FmqLIXuv9w+QIK4/uM9eEhnM3ZJQcA4ftT0CLfkMiPnKpAUDVsC+3BfhniM4pthjnFrKmaohQDe
	hNIKIF6c+WVwWJ1rE2Ii2ziNcszNwbFMjYDCTkOOjQRQPj6w41sqI6quAjMZjrSOkhQf075DroPb4
	DO9zZHEdOM8oxQweLSYR06GKjWJJVeIHEWWuX2zSgNJtpVIMm1v9ZuLyly0jFK1PDN1qKU7oHjMCT
	i3n6UzYUA7j1+CzCgHcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT7Ep-0007Zs-DF; Sat, 01 Dec 2018 15:31:23 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT7El-0007Yd-FJ
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 15:31:20 +0000
Received: by mail-wm1-x341.google.com with SMTP id c126so1706875wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 07:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=dOfptwxehh2BOlowhmD9nkQSUoiLytGVrcCDN0HYOOM=;
 b=ITw8dhDMrfouRs6GR+si7FyYtqrVucZJ89XmfH4dTNTDZ6dRflCBnopc1Sm3Fl5hIx
 zp3BVYzeQ/6/sXpJJKPSzDACeOdTQu4EPqJOXUpNEXASySCqYwckJTLRXm6BAJquoB0M
 kljkMkC2UBch4GnRCDLFhcrY3UTbqOD2LhtsSF0MtzYJ+zXUUXCWVLk7BNtTzYBDtSjH
 ja99lAwEda2/5VBwKHWZI/8BZeLJkHHeKAOZUSu4jeCyWUZrHGaEkSi6boakMUcIZsGo
 K0P7ikAfVxcoQe//0wlmV6g+VMN2ojFLLMI4pp7cs0CI9cZmPXZ0ik2b61KkWqbi2MxW
 ngNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=dOfptwxehh2BOlowhmD9nkQSUoiLytGVrcCDN0HYOOM=;
 b=Cbs75k7kH0v6RgU7LRbjR/ABUTiV6wjHqntOJKundIX+XPTk9aGNAQoC0zHAW0q3GZ
 QBI53K0fTF50Pt51OzfXvLu9HXS/3qB54rcPf+Lz0ghKNyHWMAAgf5qH1lj9yR7rOPK4
 q8B8Da4eJ7AVgH3+VLXJwR3P+vNQohC2761QRgsYDQSHyyN0WFltZ+9sZaBE24Jyvqqf
 3zJh1eyHx0EyrXF3RciEzo9dJpmQtIpX/nAa4hbfbF/DN8QcRIayWykC742Ow0iyIUz8
 0WFuROc8lN4bDVkhTSS6wDVaSKkO0VLAbGNbO1FzgldLHT7dezBnUQOcuQxZgeyJyfBS
 oiVg==
X-Gm-Message-State: AA+aEWbRUpsTznz4s3Dezc0Ihdn3cScJzYXGXgLcmCWUQqnhIqqrdp8w
 6tDcQBfT59SFdHK4gBEcJBWhvw==
X-Google-Smtp-Source: AFSGD/WQu4mPt9uK0fYXAEi4QB2eSLELDMgvXraGgspOKe1yANjqG/0u69cF47+MmfDAyd+9hsC7wg==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr2433058wme.20.1543678266540; 
 Sat, 01 Dec 2018 07:31:06 -0800 (PST)
Received: from xps ([104.207.76.73])
 by smtp.gmail.com with ESMTPSA id x14sm5918692wrm.65.2018.12.01.07.31.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 01 Dec 2018 07:31:05 -0800 (PST)
Message-ID: <b0f979de8ab9bf347b3a13048d9aa6237109b511.camel@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-axg: Fix and enable GPIO interrupt
 controller
From: Carlo Caione <ccaione@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 01 Dec 2018 15:31:04 +0000
In-Reply-To: <CAFBinCDEJK-tJJJCd7wPLJHRCV0DegnSGO21XH3EXU7s7Om=Bw@mail.gmail.com>
References: <20181201145614.5381-1-ccaione@baylibre.com>
 <CAFBinCDEJK-tJJJCd7wPLJHRCV0DegnSGO21XH3EXU7s7Om=Bw@mail.gmail.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_073119_509840_AF134316 
X-CRM114-Status: GOOD (  21.27  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 2018-12-01 at 16:20 +0100, Martin Blumenstingl wrote:
> Hi Carlo,

Hi Martin,

> On Sat, Dec 1, 2018 at 3:56 PM Carlo Caione <ccaione@baylibre.com>
> wrote:
> > The GPIO interrupt controller registers are mapped to the wrong
> > offset in the DTSI. Fix the offset in the DTSI and enable the
> > interrupt
> > controller in the DTS of the only AXG board enabled.
> > 
> > Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 6 ++++++
> >  arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > index 18778ada7bd3..c3e4aac75782 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> > @@ -374,6 +374,12 @@
> >         status = "okay";
> >  };
> > 
> > +&gpio_intc {
> > +       compatible = "amlogic,meson-gpio-intc",
> > +                    "amlogic,meson-axg-gpio-intc";
> multiple compatible strings should be ordered:
> - use the most specific compatible (the AXG one) first
> - the the less specific ones

mindlessly copied and pasted from the GXL.

> also why did you add the AXG compatible string in the s400 board .dts
> instead of meson-axg.dtsi (which makes it available for all AXG
> boards)?

good point.

> > +       status = "okay";
> > +};
> > +
> >  &ir {
> >         status = "okay";
> >         pinctrl-0 = <&remote_input_ao_pins>;
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > index df017dbd2e57..f1affc12e3e6 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > @@ -1415,7 +1415,7 @@
> > 
> >                         gpio_intc: interrupt-controller@f080 {
> unit-address should match the reg property: ...@9880
> 
> >                                 compatible = "amlogic,meson-gpio-
> > intc";
> > -                               reg = <0x0 0xf080 0x0 0x10>;
> > +                               reg = <0x0 0x9880 0x0 0x10>;
> Amlogic's patched 4.9 buildroot kernel uses 0xf080 - can you add a
> short sentence to the description on which board you have tested this
> (I assume you used the s400)

The datasheet reports a different offset. But I tested again on 0xf080
and it looks like 0xf080 is actually the correct one? Need to test this
better.

I'll follow this up with v2.

Cheers,

--
Carlo Caione



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
