Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E9DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:07:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5593217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WtnYiTy+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUBgLplG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5593217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yIhfKDIEPNk76WUBA3a88KQ5fpVaaPa5CJilfVvZ60g=; b=WtnYiTy+3f1oTe
	rIo3iagCPAe1YOzFvbvbUA+5qZ63rxH+tjyMaYYlXLy2ogbdg9e+LDQHVdGBRvBUMk6khRfZDvA9r
	myQtMNeAKCjAkEUeVkGryhlKSTQmTVGDaZ6N6f6yaxO5E+PJVX0RI01dcZKRy3CsTJ7E0TRzCe+iB
	pmAvU45KhMG9hnOwbd5ZtkERKgVxAz13W5R1wUbX+1YRYFxvzEC1gBkIpP4NUn4ATojxYCnIUgdL4
	HyvQt+3rShqV7YGoA7W8maanJ28lBQYlZxqyUY8YWZLx028/02qrVRHMxQLhfnjmIyqf6MShX/+vY
	DA83rBnLzUmhpykR0dFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvoFz-0003iZ-H9; Mon, 18 Feb 2019 19:07:11 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvoFv-0003hx-SF
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:07:09 +0000
Received: by mail-ot1-x343.google.com with SMTP id c18so8483858otl.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fp218e3wXZ+KvdGmTSBOCNvmt5bYBspsbTNjBFlw2tc=;
 b=JUBgLplGuripn3zeBw6JaVxpz/eiZiVP4zJjAxCMdCAvqOCEL7cztNvpZuO7ex46fR
 5H6Q2i94cKUMn5d9n59t576qqL5vqX7J6mMmrHzVR10sDZV2fJC+5QeXnFrC9cUjSB1g
 TOA6LXIK4tndiQxj+93qcroiIcvM6qMR878bsN9HzHVJxtpo+hB+L2ttI/4KyzoCT8pY
 T1viGiLOTNMAyAAOpdthU1T7TFdeTYsthHEdZ/vl2QCtUWW+JAtb64bPn7IE0HGSvb6k
 InvvPbV8QCYH+BbFCGrk0ocxJZijxCabRSxjQRAd070SmwfsCObp/mopRc2buWMi4OWb
 6dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fp218e3wXZ+KvdGmTSBOCNvmt5bYBspsbTNjBFlw2tc=;
 b=Hec1FzE3SSLwPMGf6XbFk+OwscFqGbrbbAPIQ3fZkJyp3rS3/eLhx4x9JEDwha9tRC
 VP1BRPTnaCjwTGOFAGKFg0vsVIPRmMSDGSWWcYmzFsz/Nz8SUeO7XH1ig0gs8c5ZIfkV
 Rka+oTHQtiYxnwU995Ic8WXwgTMAQ126fOnax/g4XCI2HkEVrCDPKt9pBpo+NIoKkXB/
 kg88Q28ARbOsOnBy4O9Uj9Th3jPNAUaFMIdrmmaKfP05+T6eNh7iHZR6LBfInS8G97eD
 /2HU4f/qmvAh+0EYHfBCR05yzA/TT3SqGLf9rZ5CtNBDSlnc1VWKS5Ad03l+AeNC+rBQ
 YYfg==
X-Gm-Message-State: AHQUAuZL3a2q73phzfmEPzFBLdOMz6Zy5bp95EqRv6j8tZLN0Rb6Ylyt
 fkQY3L9e4/2JURloecoUpEnvvlRdvzBfF9h71sw=
X-Google-Smtp-Source: AHgI3Ia/iuQlohNOkL7Q/VeUiTAn0BvuAdCFr3pvPI0Mq4Smb9hw2T/lLJfcRTuXNczGd24XYeXJs+ma+1Gdmqrd8wA=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr15446730otk.203.1550516826562; 
 Mon, 18 Feb 2019 11:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-11-anarsoul@gmail.com>
 <20190218183301.GA5480@bogus>
In-Reply-To: <20190218183301.GA5480@bogus>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 18 Feb 2019 11:06:40 -0800
Message-ID: <CA+E=qVcdDQJvssZgu23gM_gKvz2G5GAWcmjFBokE_V=WGJ4h6A@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] drm/panel: simple: Add NewEast Optoelectronics
 CO., LTD WJFH116008A panel support
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_110707_908724_7BE0CF5C 
X-CRM114-Status: GOOD (  18.50  )
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

On Mon, Feb 18, 2019 at 10:33 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 14, 2019 at 09:09:56PM -0800, Vasily Khoruzhick wrote:
> > This commit adds support for the NewEast Optoelectronics CO., LTD
> > WJFH116008A 11.6" 1920x1080 TFT LCD panel.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../display/panel/neweast,wjfh116008a.txt     |  7 ++++
> >  drivers/gpu/drm/panel/panel-simple.c          | 39 +++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt b/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
> > new file mode 100644
> > index 000000000000..d76579f9f55e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
> > @@ -0,0 +1,7 @@
> > +NewEast Optoelectronics CO., LTD WJFH116008A 11.6" 1920x1080 TFT LCD panel
> > +
> > +Required properties:
> > +- compatible: should be "neweast,wjfh116008a"
> > +
> > +This binding is compatible with the simple-panel binding, which is specified
> > +in simple-panel.txt in this directory.
>
> We already established that this goes thru a standard eDP connector. We
> should describe that and everything associated with it.

I believe using eDP connector binding wouldn't help much in my case
and it won't improve accuracy of hardware description while adding
unnecessary code duplication (edp-connector will be pretty much
simple-panel).

Since currently there're no standalone connector drivers, implementing
one requires significant refactoring of the code that I'm not
familiar.

> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
