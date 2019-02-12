Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9809AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:19:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311C32081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U9lBzGur";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdssbfCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311C32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SnTYGT6ZiAUV9GYHLBe0fLjEb0+CQr1N2M6Lfi6FiWs=; b=U9lBzGurI/cwP2
	ETMXuHOxeeO9eD3Y90KqGVweujtBX5Kj0I7K0NJq/e7E3KdCh5WJr927ysqDbSWLa/UGrQD+dC9eQ
	IRbzVqOP3IBHVd+NUzpAiZ+8YChzYK55V73qSx86ECwmNW4up103J9y7nZH4S1VGv72gaX9IVLGVe
	Ksmv6OFbAV1LnQC2vbXysYlOQqWE8oyiAf4uovyPt//OK7tZRtnJ7gRMzeVR/D/t+8AX2MDgjpywz
	0FD2cXmQqTILbPjf9BzazEx8o7pg21ooUIQmm6zgkF+9aDhckHdEskObn6nF5ky4VBHpXapzrVGLy
	RuvGi61aRW1WX9YLnJXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtfSN-0007Qi-Hv; Tue, 12 Feb 2019 21:19:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtfSG-0007LO-U2; Tue, 12 Feb 2019 21:19:03 +0000
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 245582075C;
 Tue, 12 Feb 2019 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550006340;
 bh=b8USUSrg3lJKX89ykkFcbjrdlAPDyKVL3G6hd2eIKTM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=QdssbfCLQx+1NjM8RrOrm7erZtinwVjJSa4a+r6GZrAp0tadbkmNAFQKP8lDSnx2t
 /fk514a292jF6WGM0psVno9umMFG/65mLK8EARg2npiOQmvQdMy1Q8UhhgODYecGFV
 vxO9Ieagwq/6/nV2T08oKRAQ1CVyeaZ5HjX38sIw=
Received: by mail-qk1-f177.google.com with SMTP id w204so110405qka.2;
 Tue, 12 Feb 2019 13:19:00 -0800 (PST)
X-Gm-Message-State: AHQUAuapfLCbCr7tOV8lV8bhS7tXmb0z1/Zp6TA8XWB46f4YuxDOPFo4
 C3IwYvG+pKW8uAVSAw9mKc2R3kZx4nk3hkJSTw==
X-Google-Smtp-Source: AHgI3IbGBC5HehArOZY6ed9XOuq2/9Lb4TpJX6nU6mD811cwtyzYbz48P+dF9MwrYsEa7CmR2h8pY4pkQsvgQAsxg2c=
X-Received: by 2002:a37:5686:: with SMTP id k128mr3941140qkb.29.1550006339312; 
 Tue, 12 Feb 2019 13:18:59 -0800 (PST)
MIME-Version: 1.0
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
 <20190130155016.GA26536@bogus> <20190211092251.GV4686@localhost>
In-Reply-To: <20190211092251.GV4686@localhost>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Feb 2019 15:18:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPhuDDsEMvpVizewTuehOZTc84d+8Hq7o8C+O4UrBjYw@mail.gmail.com>
Message-ID: <CAL_JsqJPhuDDsEMvpVizewTuehOZTc84d+8Hq7o8C+O4UrBjYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
To: Johan Hovold <johan@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_131901_276152_6A068F02 
X-CRM114-Status: GOOD (  23.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 linux-amlogic@lists.infradead.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 3:23 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Jan 30, 2019 at 09:50:16AM -0600, Rob Herring wrote:
> > On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> > > Add binding for Mediatek-based GNSS receivers.
> > >
> > > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> > > ---
> > >
> > > v3:
> > > Removed the I2C and SPI interfaces references.
> > > Removed the "mediatek,mt3339" compatible line.
> > > Added the optional propertied (reset, fix)
> > > Added the pin names for the optional properties.
> > >
> > > v2:
> > > Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> > > Moved current-speed as an optional propertie.
> > > Removed the status line in the example.
> > > Added "mediatek,mt3339" compatible.
> > >
> > >  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> > > new file mode 100644
> > > index 000000000000..00650d81c5c8
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> > > @@ -0,0 +1,37 @@
> > > +Mediatek-based GNSS Receiver DT binding
> > > +
> > > +Mediatek chipsets are used in GNSS-receiver modules produced by several
> > > +vendors and can use an UART interface.
>
> s/an/a/
>
> > > +
> > > +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> > > +properties.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible       : Must be
> > > +
> > > +                   "globaltop,pa6h"
> > > +
> > > +- vcc-supply       : Main voltage regulator (pin name: VCC)
> > > +
> > > +Optional properties:
> > > +
> > > +- gtop,reset-gpios : GPIO used to reset the device
> > > +                     (pin name: RESET, NRESET)
> >
> > reset-gpios is the standard name.
> >
> > > +- gtop,fix-gpios   : GPIO used to determine device position fix state
> > > +                     (pin name: FIX, 3D_FIX)
>
> I'm thinking we might need a standard name for fix-gpios as well. This
> isn't a feature that is globaltop (or mediatek) specific, and other
> manufacturers provide similar functionality through pins named UI_FIX,
> or even LCKIND (lock indicator).
>
> The pin is typically used to drive an indicator LED AFAIU, but the
> characteristics of the signal varies from device to device (fw to fw),
> for example, pulse when no lock and low otherwise, or pulse when a 2d or
> 3d-fix is acquired, etc.
>
> I'm not sure how useful the pulsing would be for software, but someone
> might find a use for it in some form.
>
> Rob, is this something we want to keep in the binding, and if so, how
> about using a generic name such as "gnss-fix-gpios"?

Sure. As long as details like being a pulse and when the pulse occurs
are implied by compatible string. So we don't get an endless addition
of properties to describe those.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
