Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EFEC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:08:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78B22087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eODkOE7E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otYvbE23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78B22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0CnNrE4TshEOpbqCJYtLqLmKQTAu2ZbA3MWW0Fp1NKA=; b=eODkOE7Ek0gbyo
	6DwySt65cTQGQTbt41ffPZ+/3vOkxVthkgDCWTz4EeS3Dvmxuj8q42G5hwtPMAS4/zHflSLwlDWBb
	d3/o2SjaRL0y0KRmgitgtDz8uFnMZBcnMv4MiFnH1HSnZbionbWRx8RVEl7g6m9TKS4b0phbAUHWd
	tAw1QlBYBeo7lp5mZFLs4wNGs3w39r+hJLCv64Kzb1jMmy4QxS0u3ugp0giEZjBvs5l92Qe7kQmUk
	rVHZhA1NbEiC4DZZkS37JWalkPM3H4RK3BMtHb69P2ppUS/AuGslBfT8g4SGIMiqGzlk8+Qwl55C4
	IE4pBhX1qX9wLsvvSXcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhjI-0002ze-7O; Mon, 04 Feb 2019 17:08:20 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhjF-0002zK-VR
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:08:19 +0000
Received: by mail-ot1-x343.google.com with SMTP id s13so1016315otq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nBUljq0NN0GSjY6fHkehNH9BR5Buu4ANotBVP2vhoIo=;
 b=otYvbE23c/iWX+hgo3xYhzYfwlfro16/QfoemYLn21aD5uokuJpiJA/eRkXTxd0E4V
 mVhfVxER+5ZOjSiTS05q7m5Pf0VGD+LbOsjG+VuuBZcQxj3RFf8VlZa95U5Z6+2p+1VY
 Q4GwYUPGqz4nvNJb4a4VhnpJsPkukpWlxq3Y45HIyEW/LpAseS0duaWKtbc7R8JiiaFW
 0BokNTJo7agvf4OPDV/gmhyvT+C8ZKGaQSz4vEjoTDeawWFLa0VHVRK7Qmk/eeltyl3L
 fqwmoQ4b5drxkHsU8RykF9QT/T7dQR+3kknEp+s9p2pnHw6IrWKURq0JtBeZA2l5NbYy
 sQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nBUljq0NN0GSjY6fHkehNH9BR5Buu4ANotBVP2vhoIo=;
 b=LXM1i9sCmoQ7ajbzIQ9bBDAeOtXVeIiO6HV4ixxrwfT3ev+9Jqf8pDmQGdk2cPGlbT
 NKe8s7sWHjf5lSOKItl/S0zNno20RYZcnWB0rdpzv0V4LtswVRYwW2WgNQAx5qWA4sFf
 pBhQiS4sJ0VafN2qWd7zVgxWPF/RyXx5luGcw9z8mrA3zMhnDyV9gfyDmS01Mb3JdSCs
 z6lwGVS70g9zRXJjiy6F7IXOWdm1cH2OPrRjvP263o05g5HPwUL2rkCVezW5TmySyaRm
 dLL8idZweVYBdTZfGXHH1127w1r5Oy51tlsEMLnbbtrVda9ZKYjOLrh1HVUI3L0QzZZd
 fmCA==
X-Gm-Message-State: AHQUAuaU2YnD+27i8tMcJnm43KKLtCf4mgBREwJTv5yE1DsRNc1L7xdI
 GTceJgf34ESu70/yO2bKnm45rv/cUSlOz01GN/o=
X-Google-Smtp-Source: AHgI3IYVuC0PBVVduJr6LxiLQxEkUr1YyzbSbHLE9NBeyASV5jKza0okC+RzJaf9V1RHFqujrYdATglJhDeHqzhe+rQ=
X-Received: by 2002:aca:f044:: with SMTP id o65mr172390oih.145.1549300096718; 
 Mon, 04 Feb 2019 09:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <CAL_JsqKt1kOXmRNvkYsQ6AL69+TPZURKpDbKkkEUb2+KZ5hKjQ@mail.gmail.com>
 <20190204165637.GA30876@ulmo>
In-Reply-To: <20190204165637.GA30876@ulmo>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 4 Feb 2019 09:07:50 -0800
Message-ID: <CA+E=qVca2g1tkpvYZo-+nJ+v8d7UXFtoxV6t8mAkQkftYDFkZw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_090818_032424_AA745E3F 
X-CRM114-Status: GOOD (  20.38  )
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
 Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 8:56 AM Thierry Reding <thierry.reding@gmail.com> wrote:

> > I think it is perfectly fine to have a generic-ish fallback as long as
> > it is just that, a fallback. If the panel has quirks, then you'd
> > better make sure the firmware is stuffing in the right compatibles or
> > that you can update the firmware.
>
> simple-panel would probably work if you stuck in some mostly compatible
> string and provided a ddc-i2c-bus property in the device tree node. The
> generic-ish fallback case could be implemented by providing a fallback
> compatible string (we used to have "simple-panel", which I think would
> still be adequate for this I suppose) and adding a dummy descriptor in
> the driver, perhaps one with pre-defined delays that could be adjusted
> to work for all cases, or they could just be 0. At least that way we'd
> be explicitly documenting that we support this as a fallback.
>
> I'm not sure how you'd want to enforce that people provide the right
> compatible strings that way. Currently there's no way to make your panel
> work without adding a panel driver, so people are forced to write the
> DT bindings and a driver, or add support to an existing one. If we open
> this backdoor, I suspect many people will just take the easy route and
> rely on the fallback. And then what do we do when we get bug reports
> about panels not working, or requiring some quirks. How do we go and
> find out what the right compatible strings are for each board, or how to
> fix things for something we don't have access to.
>
> This all sounds like a Pandora's box to me.

OK, just give me an option that will work on this platform with a
single software image (keep in mind that u-boot aka "firmware" is part
of this image) and that is acceptable for upstream and I'll try to
implement it.

> Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
