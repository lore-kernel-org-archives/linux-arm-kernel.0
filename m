Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D87BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7102083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dn0zYeSy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2qNrI2h/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7102083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SA0EvpSK9DCilRhCXJlImcwwiXPa7rHZOqQMV6PDTQg=; b=Dn0zYeSyX9B8kL
	djGoYdruoelacS9urURavgZPHbk2U5ziPXyoihs1H7QLq12Qu4fLnno2BzZFVWQ+CM70KqrWSR9Ds
	B3zTPIu/xi6vGlGDVzYPizgnPGe6rPn0MIwPXI+C0SmrtDSloM43ofHNyDucCvx52g7mQdo6KUGdE
	xpxFTAPeMbKhfX0hlH4DALnAYdiJJrUBKLmF3dLoAXIXzhNHUysROtznc2brXPg9X1foBXS5scbPc
	zyLgX2AH0WxgVHJ2YP5WSWXQQK4h4BeugEYFjDh3IScTsMqoov8ZRuGep7voBc5rM500r8icRGKwd
	YsARfzCTN3dpNnPk60uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqh5m-0001Ym-Bk; Mon, 04 Feb 2019 16:27:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqh5e-0001RT-Nr
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:27:27 +0000
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3DCD218B0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  4 Feb 2019 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549297641;
 bh=7nzZc/yD4khUaljlNkylKpCEst+tqzkOtBkucskv23A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2qNrI2h/2SyaajCFNWyVIU+rzJ+BRhSIIH12cPDJBLQcIylUQDYh+JsGT5omDp0nB
 8zs9GlugqXNDEmsASYxpZA2o2Dju2CvDJoJzu/iw/rt/ZaT3woxx5FWZ6Urvpozw7n
 kMJtEGu47WmWMHxR1D0LQHhpDHZZLCYuISqSz2tE=
Received: by mail-qt1-f170.google.com with SMTP id y20so461480qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:27:21 -0800 (PST)
X-Gm-Message-State: AHQUAuY7G5Lrag8h3/uKzBaAt1uTZmMvrsFfejnDpRF39bIzL4MTMSdS
 k6sb3UL9Z1x53uKQCv3y9PvzXvAvOgwEYTNN3A==
X-Google-Smtp-Source: AHgI3IYtkw6mhtKs/McwJGg3ygf31wr7UsHyWhT/pzLjBzgtl7Yee6yhO4RlLZPY/emx2zyK0xfa53bcomat+NXSVng=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr157588qve.246.1549297640760;
 Mon, 04 Feb 2019 08:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
In-Reply-To: <20190204082353.GE19087@ulmo>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 4 Feb 2019 10:27:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKt1kOXmRNvkYsQ6AL69+TPZURKpDbKkkEUb2+KZ5hKjQ@mail.gmail.com>
Message-ID: <CAL_JsqKt1kOXmRNvkYsQ6AL69+TPZURKpDbKkkEUb2+KZ5hKjQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_082723_540253_F1CEAC2B 
X-CRM114-Status: GOOD (  25.85  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 2:24 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Feb 04, 2019 at 12:13:55AM -0800, Vasily Khoruzhick wrote:
> > On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wrote:
> > > > eDP panels usually have EDID EEPROM, so there's no need to define panel
> > > > width/height or any modes/timings in dts. But this panel still may have
> > > > regulator and/or backlight.
> > > >
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.txt
> > >
> > > Please don't try to make panels look more generic than they really are.
> > > You're going to have to provide a compatible string for your device that
> > > is more specific than "panel-edp". You claim that you don't need any
> > > extra information that is panel specific, but you don't know that now.
> > > We have in the past thought that we didn't need things like prepare
> > > delay, but then we ran into situations where we did need them.
> > >
> > > Just do what everybody else does. Provide a specific compatible string
> > > and match on that in the panel-simple driver. Even if you can read all
> > > the video timings from an EDID EEPROM, you can still provide a mode in
> > > the panel descriptor to serve as a fallback if for example the EEPROM
> > > is faulty on some device.
> >
> > Pinebook used several 768p panels that have slightly different timings
> > and recent batch uses 1080p panel.
> >
> > What panel descriptor should I use as fallback?
>
> You don't use panel descriptors as fallback. The simple-panel driver
> will bind to a panel device and use the corresponding descriptor. If
> your device tree contains the correct information, the descriptor is
> correct for the panel you have.
>
> In other words you need to ensure that you have the correct panel in
> device tree for the board that you're using. This is exactly the same
> thing as for other devices.
>
> One way to to this is to have separate device trees for each variant
> of the board that you want to support. Another variant may be to have
> a common device tree and then have some early firmware update the DTB
> with the correct panel information.

That can be a pain to manage especially if panels are swapped run to
run with 2nd sources.

I think it is perfectly fine to have a generic-ish fallback as long as
it is just that, a fallback. If the panel has quirks, then you'd
better make sure the firmware is stuffing in the right compatibles or
that you can update the firmware.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
