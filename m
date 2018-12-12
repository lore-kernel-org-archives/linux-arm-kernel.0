Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26997C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:29:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5302084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WdF2LT5S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QCwX+367"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5302084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uE+7FZjjttF8RNn8huAkIfn+cbMEEDYsvkvPNNT2BCs=; b=WdF2LT5SMY5O7y
	Z75uYSTOx4WoX3q071am1tfvH/f8ZWEgmgFpU/1N7pvdu0iDhbDCsjEYX+3Z9i/WTeEKdWfn1H0n5
	buGFHqfm0rch6hhI1ri2oktw+NKajHLzbXB3ofNs0+o0i8m/CPLVSP0A1c5uhFBGLJV2V/W7OOjed
	e3934FHqE256GXquVQbzkaI/9rO5naPt8JPB3II560KdUoa6t8AXNQjP6iVntD1oiApDHkShCdiPs
	qvQ7UkSmpnlBpIezt5cQFAxYAv7Hi/Y36ZGvdlz4UvNzb7C7QKmXZWLHrMg0rVcn/3azqwU+LLavz
	kTAG8BosQe9LuGU9cIPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX4Zb-0001Me-MD; Wed, 12 Dec 2018 13:29:11 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX4ZY-0001Ki-FF
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 13:29:10 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so17672918wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 05:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nHAv5R5QwRmJoCLzBKLZOXFUpzVxkJ8Y6vSdR8cBZGY=;
 b=QCwX+367wHog/EzWzZZz8NdRumFZVFfyfCBTkcBOHX0VCOIscisr10gLRbkkjExHwz
 gJNSn6mMGcwR0p9W57KOyOE7FlQ9bY8YBRWiYOY+twMmuQbAwnALnqx86m8pxqUzsBci
 GVyjbDtwHn6hAsAYMR7DKXx0EpNwmfIFTE3E0upXH7Oo3hOCYMRTuIVVaEOkGJwn2uxz
 IazBB1yLCLOvRfL0uZVkVsd8369dGPsnKAG9O6Jl/e2RDXi6Y2k6kc5UKL0tTlWlcqCm
 LsxgFQG1CnAXI+hZBtYZ3HKjLaxdxht603AMQgemdtF1rB/phow/GKH+rzuMpjlLa6/g
 aKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nHAv5R5QwRmJoCLzBKLZOXFUpzVxkJ8Y6vSdR8cBZGY=;
 b=C9IYEISMIGsBM2QvwHPsz0i+465WKuAx5bwaUR/d3unimW8fe6vp0mv8GWbrjah9QM
 Kp0jw6F1DCzSE9E0YWepsdzLzdz6NXBstkdan7gQyLOOo5DBfWtCgNBWHqDQ0akl4Vd7
 +lB9hwqGpk4qhlC563v8OWpTf7yfaOiQcjhEl7n07XzvO8ghz1gltPVRO8NEVDAco1fl
 kjdSYL8FUuNq7fCPdK8T/t7hu+bBEiQxVjO0Ya6BUsCvZuiFCLj0s706HKMzKvfDp5Ge
 Pay1uupyQP85w19coYGPLT/EgNSaVU41EcwYdt1DUcrzcGonUMeCPqN0GwzxtrAkhjfY
 3ZAA==
X-Gm-Message-State: AA+aEWaX3IM4RYSEfI/zitCYpjWuUvqKJmdksAP3XpCROViIcLiIPB1R
 laSUfYhsbGrNu4WLpw9ygrg1FvKl+Rv+LLX94hQ1CQ==
X-Google-Smtp-Source: AFSGD/VEVNo4hXgKkuJs4Sxb988az8kXAqw60vyKgmO3r+7u+/iD41jor3t1AmM5VxFCcDXJmKjw+arEkt3im1mDibo=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr17261677wro.29.1544621336425; 
 Wed, 12 Dec 2018 05:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20181210090640.4495-1-mjourdan@baylibre.com>
 <434d1dc0-3c5e-5cb3-cc88-b565bfb74217@baylibre.com>
In-Reply-To: <434d1dc0-3c5e-5cb3-cc88-b565bfb74217@baylibre.com>
From: Maxime Jourdan <mjourdan@baylibre.com>
Date: Wed, 12 Dec 2018 14:28:45 +0100
Message-ID: <CAMO6nawq6XsmsucVHPDDc3nuYLEDa4U1QC_5v26jofNv+BKH1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: meson: add specific simplefb bindings
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_052908_504185_8E56195F 
X-CRM114-Status: GOOD (  19.36  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Neil,
On Wed, Dec 12, 2018 at 10:54 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Maxime,
>
> On 10/12/2018 10:06, Maxime Jourdan wrote:
> > Similar to simple-framebuffer-sunxi, we support different display pipelines
> > that the firmware is free to choose from.
> >
> > This documents the "amlogic,simple-framebuffer" compatible and the
> > "amlogic,pipeline" extension.
> >
> > Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> > ---
> >  .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> > new file mode 100644
> > index 000000000000..122a5c005cd9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> > @@ -0,0 +1,33 @@
> > +Meson specific Simple Framebuffer bindings
> > +
> > +This binding documents meson specific extensions to the simple-framebuffer
> > +bindings. The meson simplefb u-boot code relies on the devicetree containing
> > +pre-populated simplefb nodes.
> > +
> > +These extensions are intended so that u-boot can select the right node based
> > +on which pipeline is being used. As such they are solely intended for
> > +firmware / bootloader use, and the OS should ignore them.
> > +
> > +Required properties:
> > +- compatible: "amlogic,simple-framebuffer"
> > +- amlogic,pipeline, one of:
> > +  "vpu-cvbs"
> > +  "vpu-hdmi"
> > +
> > +Example:
> > +
> > +chosen {
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +     ranges;
> > +
> > +     framebuffer@0 {
> > +             compatible = "amlogic,simple-framebuffer",
> > +                          "simple-framebuffer";
> > +             amlogic,pipeline = "vpu-hdmi";
> > +             clocks = <&clkc CLKID_HDMI_PCLK>,
> > +                      <&clkc CLKID_CLK81>,
> > +                      <&clkc CLKID_GCLK_VENCI_INT0>;
> > +             power-domains = <&pwrc_vpu>;
> > +     };
> > +};
> >
>
> You should add a cover-letter for this patchset !
>
> Neil

Sorry about that, I completely forgot. Thanks for the reminder, will repost.

Maxime

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
