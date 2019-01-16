Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC36C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:28:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3029120578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LIS6/huC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FQaEcRba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3029120578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HsPyO3lKxx6PzLtdj6zz7eNJ1rXPlIBEeD/NbEmhoyU=; b=LIS6/huCToU4Gr
	bVzxwKlLdE2DIZVLWz8R9Z9PdxZN6+i7VuDqkyBsUPV4rGwsFC4ueFDR8db5fklU2Kdu2M/J4t1Cj
	PuI0n+E1umqpN2wVqyn4Kz/aMnCKkEGQov8+Pkai8AhCCf95FPJy+mvoP3DAK55cpNwO6TUdYVgw1
	rMIbfu34p6FcHzZ19tgi9+PhTR6SspsSEOHnA7Pno4yYwNLWES0Ua474ZuVZI0H4jtlKiWiXuZrlL
	dsds4K8hTDW+KpL9nzfPdve3lkzfafgozsLF9c6UkzSYP63/TJ+/EG1P5JNcCCzadNMqKNahblfGZ
	vw7SyjoE5RU0YgiebVxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkIe-00025t-Mg; Wed, 16 Jan 2019 12:28:04 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkIb-000257-1G
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:28:03 +0000
Received: by mail-wr1-x443.google.com with SMTP id z5so6659792wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 04:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r4NfPscd33YfCts+OAvk6v5W92clce1d3rs145yFmNw=;
 b=FQaEcRbahfG+TnXDcCkYUtCScD9QwtNF9xwSw1P8coMNwd6FH+PuCXhCcIc0aXJx24
 uTjtFuv9FqG4HgeoFuz2xOvcuJTxQL3UdHM2iMQIXLk9wbV9EY6TBwSqhUvlbkjXFFrv
 D3UsdVP3AnAsYgggt9xVS9k5ZJgqayR9gFsuewkg3DTfsdmzhzdi9GYrxjZeb5+SiN6B
 khC2FHjYiqpwJJWf7BYXtBLF/gYYFnHpXKK69hfqBXPusU6+4NWeyH59PT2hdfpActnA
 iMb0caql2wyoCb+MwNLAV9JJ0nOuj+U/RLxCVwppeMDKT4XvHUwk6A48gQT0hyjARZug
 wNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r4NfPscd33YfCts+OAvk6v5W92clce1d3rs145yFmNw=;
 b=ghMgsgY+BivOC8SwHsvBUP2eIibzIXtTbh+XYQS2l9mwsOH3beeMxq+4T0u/5etlwr
 8oJwmDfKUYlf+24fEJExQJMQ41WbQMlOgOWmbCDSCEgksgcIufnf2ncjRaXOVfXn/qr5
 Cm9pDj3TcALFFckM7lrI/RoaybzwCMGbVZqMYUSFiN6lMs/w5nZvAeYVmC+r/m01IJi7
 ODeIdiZGldCeC9zD3zGdHmPkHidm/kU22mxxewrIC7iTGpjI5mHyIiV4F01fRyCnjlSe
 27a83q8S58hCehmu5yNomX9IBOqScOciaWUHFHirYezPAiji1romaqHfnflGXRT7m/bR
 sdtA==
X-Gm-Message-State: AJcUukc54z6M4NTUl8UQUpnJCKFlN3PhZyRIMHl6Hw1b9TAwNl23KaX8
 p/nSRsYmLx5jFLRKwv7MCyVsshPo0VbTjh7kHwvoMQ==
X-Google-Smtp-Source: ALg8bN55aGnn/rCggprsVOZmW4BpW+w4PPoodQ3bjNNI9imPwrCf+gPaTwU3JYDgBw7x0VRpLcXriGgPneKFN65/qwE=
X-Received: by 2002:adf:a58a:: with SMTP id g10mr7297402wrc.3.1547641678842;
 Wed, 16 Jan 2019 04:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20190107095307.15233-1-mjourdan@baylibre.com>
 <20190107095307.15233-2-mjourdan@baylibre.com>
 <20190111222509.GA14462@bogus>
In-Reply-To: <20190111222509.GA14462@bogus>
From: Maxime Jourdan <mjourdan@baylibre.com>
Date: Wed, 16 Jan 2019 13:27:48 +0100
Message-ID: <CAMO6nazpZmr7sNNc4HL_f7Sovv3xAfDmOAc=_NTyFFH7F2y__Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: meson: add specific simplefb bindings
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_042801_139977_1D127098 
X-CRM114-Status: GOOD (  10.64  )
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
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 11:25 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 07, 2019 at 10:53:06AM +0100, Maxime Jourdan wrote:
> > Similar to simple-framebuffer-sunxi, we support different display pipelines
> > that the firmware is free to choose from.
> >
> > This documents the "amlogic,simple-framebuffer" compatible and the
> > "amlogic,pipeline" extension.
> >
> > Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> > ---
> >  .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
>
> Use the compatible string for the file name:
> amlogic,simple-framebuffer.txt
>
> With that,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the review, will send a v3.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
