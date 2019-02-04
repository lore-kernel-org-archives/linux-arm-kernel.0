Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47631C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:27:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F482083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OG71cBJI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI6LlaLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F482083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eLgHWOk6J2im/SiOMMuyyXKYtmqooTbIdE1DcxJ4Ijw=; b=OG71cBJI0LD5yl
	WlqV3RgRHvG16qCxXo0uPkHttCbuI/tzTXhOxuqUn+cAbhFfnXWWgfDVkYmEy+worNqS6HG77VVPj
	GSrjHzrrEhRBGYOPfjaK816g9k0+Ta8HpXHjJ834a4jQ46Qf1w0c31GNa3Tszst2neYWJ4qvBEJ2H
	Z/hPyi7J7fwQ6uvOYiiV6Gjw68aNdKOKiOfOJCYxX12a33RUUdG2aKaiPxptiEC2qegQA4zt9AOPF
	TMoMX30lEq5n9l6pcPT7v0IeB7xVkrnzZG5DaxaKIw3D2+cFimpzSW+r8JlaxdK5ITQXkPhyXhnAs
	OMQFNjLDmAcE4+5XhrCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqh5W-0001Hd-8q; Mon, 04 Feb 2019 16:27:14 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqh5S-0001H9-Fn
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:27:12 +0000
Received: by mail-ot1-x342.google.com with SMTP id 32so671736ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z33S2/tBASL7ZYU7PMw+LhaeD0w+rofBnoyglbKaVZE=;
 b=mI6LlaLuvt0WpBSvnW2+qWKjvkIN1gm3MU7oog3EHZTyrdkwxujwjY60CHCcqWdws1
 O5emGNNcG8ym/3beXvwBCossM7IpOks37K9+blFOotl2m4HzJLQvIYGxTcSON6zRBkNa
 GBIPwF0w2Wo53kSZGNhesPqDOWAF6p+seIEVhUlbA2/oRsPl/rLqKM0eR+vF9p8C0Y6d
 5hCmjjqVebeYlsUWpRVyZdRO0ilM7rBJf/kcsWjyN5jYtxG7ghCBqqIiW4lW+PrNslIv
 jMBFcDm3l+sySiY2R+DI7cBjdzPz55NF+/1HCQmxAtpwo1rpDugtRyXPXI/rFwaf1Yrb
 xNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z33S2/tBASL7ZYU7PMw+LhaeD0w+rofBnoyglbKaVZE=;
 b=AIeOBPONvf4gZ/q+ERKjLvPrWBB6/9Ybt+00SgegR9LFxlL4td6PY68I18iIlGgfDD
 5A2O1tZfQVTn9ASHkr2bNwGDCBkX1EsrbLvb023zi00PX1x82yPOWPv14iLtiWp47msA
 +p+8fgbOKh+P8DGb2Zapt3rQC52LKsITCudJhDjSxafBSvCy4/qPJKWr3aNCIiNmTuQj
 b4/iloWwHY5uR87ioC/FyC+ti6K1K2/0s029ZsVpGsN7IZVS1wjYac2B6Sg60/XRU/g7
 Fh6sKIpoZMfkvJm+VsYWAd6yuT1v6pGNAcGJUCNmRuqs8ojv+H0ut08eRJMPucJOPsj7
 oeuw==
X-Gm-Message-State: AHQUAuZvyrMv2DkqjQt8YfDRhE1l3zuzvpCjlUzJ7w97ipi+SZninnW4
 hmRvrh1OszxXqby6JWO6xWBfHydDWSgHwr577rE=
X-Google-Smtp-Source: AHgI3IYVA4Alm+TtRbL8Io50aFGjQNRP6R1wUWcD1/lW403mq6kcD2XsDLN8diQ7mCnY3D17ABLrCyAOclAkPqy3vbk=
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr81717otk.221.1549297629419;
 Mon, 04 Feb 2019 08:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-7-anarsoul@gmail.com>
 <20190204142036.vd42nvyjnjr5yeoi@flea>
In-Reply-To: <20190204142036.vd42nvyjnjr5yeoi@flea>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 4 Feb 2019 08:26:43 -0800
Message-ID: <CA+E=qVfTfJ9E29gz83tdVGx5_KGWSQVJOAxKTzC+-n7=gdj0cA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 06/12] drm/sun4i: rgb: Add 1% tolerance to dclk
 frequency check when bridge is connected
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_082710_523337_BDFBA6B4 
X-CRM114-Status: GOOD (  18.29  )
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
 Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 6:20 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Sun, Feb 03, 2019 at 10:54:55AM -0800, Vasily Khoruzhick wrote:
> > Clock rate check that was added in commit bb43d40d7c83 ("drm/sun4i: rgb:
> > Validate the clock rate") prevents some panel and bridges from working with
> > sun4i driver.
> >
> > Unfortunately, dotclock frequency for some modes are not achievable on
> > sunxi hardware, and there's a slight deviation in rate returned by
> > clk_round_rate(), so they fail this check.
> >
> > Experiments show that panels and bridges work fine with this slight
> > deviation, e.g. Pinebook that uses ANX6345 bridge with 768p eDP panel
> > requests 73 MHz, gets 72.296MHz instead (0.96% difference) and works just
> > fine.
> >
> > This patch adds a 1% tolerence to the dot clock check when bridge is
> > connected.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> I'm not sure we want to make exceptions for all the hardware
> combination we face, but we should go for something more generic (and
> easier to maintain instead).
>
> IIRC, from the previous discussion, HDMI had a tolerancy requirement
> in the standard. Do you know if there's such a thing for eDP? That
> would solve the issue for all the eDP displays at once.

I don't have access to eDP standard - vesa.org says it's available to
members only.

> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
