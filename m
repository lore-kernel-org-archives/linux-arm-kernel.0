Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B10C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:54:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72712177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d3TaS3Xr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zQu3YlL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72712177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nsxUsY0yyNWt28dQMAXfyLWiyHvKKYAe+s/MyDXMFis=; b=d3TaS3XrLCogJP
	OxkAD7TOzTQpg8uZn30bAHNrUPqIN2t2kEwUEiJmiSPcb/PM2Ff2R69PiwC1jY9c+b6TGCUcoMAPT
	8Pp99f4wGM2Ai9pb6eHskMhgpYGf5rUHey+Wumg1lK10LHKbanjnPvyO16a8LwbX1BTEIfQ+mIACZ
	dfgbq7vXr+lVq9XeclfpAzanL+1nFqseof8RSqpRe1BMwKT4hBO9TE7dyrgfHgGSlZVKjk/c9BtwW
	rH9ystEMgXGGssYOZEQ+bfVygJe9HvXG3P4h3Xyqg5/Mes3ihNpg0QLvudpTKAYC3cDmUWn5vHIvf
	Gw7BaIWe1/iB9oof/qow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw6nQ-0001Tr-L9; Tue, 19 Feb 2019 14:54:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw6nM-0001TT-BZ
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 14:54:54 +0000
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9E09921908
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550588090;
 bh=sMKevPs9QRwjYJalNCDpDqxOd816wl1rVZc+onpeTbw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=zQu3YlL1Gmyl28RjDHk7sbW4WAAGqHQa0ZjrDc+xj4tHe7zW2ZUWQ8d99tH4vG38y
 Rp0P3Gv/OfsFTGUK7aOfEAy4xRR/8+kBqM/0mRWhP51gsjcccKsFXucbIBRos9iE2Q
 Va8eLYI0DFZBLhdb06bu9FRAh9kWURwMwsQxDR5g=
Received: by mail-qt1-f169.google.com with SMTP id b8so23350218qtr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 06:54:50 -0800 (PST)
X-Gm-Message-State: AHQUAuZenXvmtZsf7MNqD+aR056T3inHgmuM5vv7lYUMbsHXkfnmaAdW
 7SGWd4MMO4uhUCowK+Xtw3hy1dUYszxQJGaWPA==
X-Google-Smtp-Source: AHgI3IYC1Mn4upLNA2uND8FWdVvO/S/bdQL1woBdATwigCyJ10TmlDSfFEJP6xt5X1XP6BG5Bj5G9yMj4zIrvXq9dvc=
X-Received: by 2002:ac8:25d1:: with SMTP id f17mr21982144qtf.38.1550588089725; 
 Tue, 19 Feb 2019 06:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-11-anarsoul@gmail.com>
 <20190218183301.GA5480@bogus>
 <CA+E=qVcdDQJvssZgu23gM_gKvz2G5GAWcmjFBokE_V=WGJ4h6A@mail.gmail.com>
In-Reply-To: <CA+E=qVcdDQJvssZgu23gM_gKvz2G5GAWcmjFBokE_V=WGJ4h6A@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Feb 2019 08:54:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+pyAd_kMMz+yKjqY=asAi1X1XguM58VjfVhPwD-xi-2w@mail.gmail.com>
Message-ID: <CAL_Jsq+pyAd_kMMz+yKjqY=asAi1X1XguM58VjfVhPwD-xi-2w@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] drm/panel: simple: Add NewEast Optoelectronics
 CO., LTD WJFH116008A panel support
To: Vasily Khoruzhick <anarsoul@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_065452_435291_80AC49F8 
X-CRM114-Status: GOOD (  24.03  )
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
 Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 1:07 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Mon, Feb 18, 2019 at 10:33 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Feb 14, 2019 at 09:09:56PM -0800, Vasily Khoruzhick wrote:
> > > This commit adds support for the NewEast Optoelectronics CO., LTD
> > > WJFH116008A 11.6" 1920x1080 TFT LCD panel.
> > >
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > >  .../display/panel/neweast,wjfh116008a.txt     |  7 ++++
> > >  drivers/gpu/drm/panel/panel-simple.c          | 39 +++++++++++++++++++
> > >  2 files changed, 46 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt b/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
> > > new file mode 100644
> > > index 000000000000..d76579f9f55e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
> > > @@ -0,0 +1,7 @@
> > > +NewEast Optoelectronics CO., LTD WJFH116008A 11.6" 1920x1080 TFT LCD panel
> > > +
> > > +Required properties:
> > > +- compatible: should be "neweast,wjfh116008a"
> > > +
> > > +This binding is compatible with the simple-panel binding, which is specified
> > > +in simple-panel.txt in this directory.
> >
> > We already established that this goes thru a standard eDP connector. We
> > should describe that and everything associated with it.
>
> I believe using eDP connector binding wouldn't help much in my case
> and it won't improve accuracy of hardware description while adding
> unnecessary code duplication (edp-connector will be pretty much
> simple-panel).
>
> Since currently there're no standalone connector drivers, implementing
> one requires significant refactoring of the code that I'm not
> familiar.

I'm not talking about drivers. I'm talking about bindings. Those are
not necessarily 1-1. There's no reason the simple panel driver can't
have an 'edp-connector' entry.

Also, since you have EDID, you should be using that for timing data
IMO, and the binding needs to have enough information to support that.
It may if DP-aux comes from the bridge chip or it may not if you need
to describe that connection. Again, this is independent from what
Linux chooses to do. If Linux chooses to have its own timing
information that's its choice. Another OS may choose to use EDID.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
