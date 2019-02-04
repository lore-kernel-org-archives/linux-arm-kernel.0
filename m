Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:34:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9670B2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SxWgfurG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNm4TFZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9670B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zTM8+VmTJ67QIRlzYkWwQLC6ekXxvCuUTMFZES34JVY=; b=SxWgfurGyxxRkE
	IVWQ8oJxoVkuird9jRavJip2ugM+uwS/fL1NFaEh77l7UETcDFHfRwkhl3owGQGoWrlc+jUT6xeXD
	jWNgJHVgmfkmvpw3CjlDGlxpYlgY0ZPYy2nAcdfvgXi3rdaKrQkGA0RCAv0jczqufKFX/a6c08c1F
	1qwUcQyvKBBDfT+hJzgNz3buEaXEnEfBgzaPuxVw4v6T1G7YPtpIcukx91Aygk+RamiITcZRPHRi5
	rKF6bZS9SZIDWlpu+fEMKzckRe3lrJEYrPNZoCKHuvytZ+qjUfXWX/ASXpLcovo7YDaQQyD8soiWG
	gLBS3Xphi51/C7Jp2ImQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkwt-0007pz-RF; Mon, 04 Feb 2019 20:34:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkwp-0007pY-DA
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 20:34:34 +0000
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CA6002184E
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  4 Feb 2019 20:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549312471;
 bh=Re1UZvsmjw0wV833kDxmsJEoQe/2TMaTNpRq24hdsqc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=PNm4TFZuPq4zUJ79MGsBGz88OTpGgU5SzG81qy1TOQfEZEYxAhZo8x3O5GAc3jkKo
 ipOEbXnkBy5XSQeY9GWTWANgGeHB5urWl21Uvpi0Oy2EtCSygcAwDam7xYELZt6BeE
 jUBxUlEmjmD2T58UrRUE4RiXQOrxBp6gpLGsrTt8=
Received: by mail-qk1-f174.google.com with SMTP id w204so816080qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 12:34:30 -0800 (PST)
X-Gm-Message-State: AHQUAub8fDrqSNT0RDUniM/Xxl+cHK15AIad056UlkkVM2E0ILKRLaTw
 SUeKAof/hqbdGFmfMPJqnYssldm69EYBTByGeQ==
X-Google-Smtp-Source: AHgI3IZKaVBoQKo8RY+yZFmkCKbNle93IKhu8hpqJsU8HF6yis51t4ULVD1AqPZKbGohwYL87T7c/UhhUdRdWrj3PnM=
X-Received: by 2002:a37:5686:: with SMTP id k128mr872682qkb.29.1549312469945; 
 Mon, 04 Feb 2019 12:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <CAL_JsqKt1kOXmRNvkYsQ6AL69+TPZURKpDbKkkEUb2+KZ5hKjQ@mail.gmail.com>
 <20190204165637.GA30876@ulmo>
 <CAL_JsqJx98DfHZSafiXA8QiO=bn1zy8g6keQ15L=cUmbVkTTOA@mail.gmail.com>
 <CA+E=qVdoOTj522hftrYp3fbH3zH4jD7GxtvOOH6RwCHx+nNwNQ@mail.gmail.com>
In-Reply-To: <CA+E=qVdoOTj522hftrYp3fbH3zH4jD7GxtvOOH6RwCHx+nNwNQ@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 4 Feb 2019 14:34:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXi0iZG1sJ7zGR978X7WT9JJ6omrvCAL9P2sLuFXmFJg@mail.gmail.com>
Message-ID: <CAL_JsqKXi0iZG1sJ7zGR978X7WT9JJ6omrvCAL9P2sLuFXmFJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
To: Vasily Khoruzhick <anarsoul@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_123431_566166_20298E74 
X-CRM114-Status: GOOD (  17.94  )
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

On Mon, Feb 4, 2019 at 2:26 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Mon, Feb 4, 2019 at 12:23 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> > > simple-panel would probably work if you stuck in some mostly compatible
> > > string and provided a ddc-i2c-bus property in the device tree node. The
> > > generic-ish fallback case could be implemented by providing a fallback
> > > compatible string (we used to have "simple-panel", which I think would
> > > still be adequate for this I suppose) and adding a dummy descriptor in
> > > the driver, perhaps one with pre-defined delays that could be adjusted
> > > to work for all cases, or they could just be 0. At least that way we'd
> > > be explicitly documenting that we support this as a fallback.
> >
> > I'd like something more specific than 'simple-panel' that at least
> > implies it has EDID and whatever else we think it should imply.
> >
> > Looking into this a bit more, why don't we just do a connector here?
> > eDP has a standard connector (with power). It's just like other
> > connectors, but with power and no hotplug. If someone does their own
> > interface, then they should do their own connector or panel binding.
>
> Where do we put backlight in this case?

In the connector node. You'd need a backlight supply,
'backlight-enable-gpios' and backlight phandle to pwm-backlight node.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
