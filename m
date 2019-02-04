Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463A4C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:27:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E435D2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0aMetu1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrnR3U1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E435D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yOE5U3VQx/4+mLwyu2K9Lk+2mqfYTf0BeYUVNrErUR0=; b=i0aMetu1NxqbxN
	Wloe0XSUpqbySUdEiHnrXnVNvL8Dy+IYXlbxsmdQ/jkaW5cbDiiqoBDjJdl59MlMQI518WRtQIX0+
	KuPK6pS+vxlznDapCsKi8P1qzgX9wct3VwyypR5p2emUgfmgB6roTBn+bUotQQGpinozgxpKu/Pa1
	NREK+pdcBzsRWRcwqYm/QTdSBNhTdJfhcZTvQwC2v7iXihDjpQ3g0zR/rcSdzuqkFpG/UVKV/trY8
	LcuUHe46aMFD35JYZCX/AF+w8g6+QC/CJ54BpcrSvyIwZ1gyg9WQQXskDjbP8OSC9/snjaKeoZgtQ
	RmekpW7hFt5H93dTAO6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkpV-000541-Jw; Mon, 04 Feb 2019 20:26:57 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkpR-00053R-H3
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 20:26:55 +0000
Received: by mail-ot1-x343.google.com with SMTP id a11so2016838otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 12:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pQ2yD1zmBoyF9CrxS0d9WP6bJa6rc7DySp9SskQCzts=;
 b=hrnR3U1cJ95Cx19E4mWhTRXSUyLPczQJdSC5ADxCyHHJUHGjKwxq3gLybIHHkDWcuW
 DQOdNrB1gHWiZdQfNzXxEl9OIEhiHWP76xRWVR0+PykHpKi9UvsJAOFBBCROyT8A6DlT
 BhmmYS1SgGKSPPthya+ipQrm2KFHUNbCkcanK70Jwp7kwpschyYPtt3J7+MRzcUbJqNT
 9Zf9dT2mZeov7A56K/5sbZTz0AbhqP9CI87pV81JukfdBA+Mg89FwUdQ6iDPIcA2m/vx
 A5ZH4XPCQ0opB5JFtRiRTRRIFM8LS9kBREvT0IJSzTASpKN0oeCNjluyLHv1dyZW1Vr3
 +hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pQ2yD1zmBoyF9CrxS0d9WP6bJa6rc7DySp9SskQCzts=;
 b=W48MjZ0+3ckExGo493DP4Ig8IvSe9SFJ1pceL1pq6bCjSX2rmTjIT90H35i81Y2GQw
 1jLTDqb2h6KBp6BMfkC8kxSvcWvbmKsDWpw0AA6u7m7UmHU0qUxWTsPHdJXcsoX5JKHk
 kBEQ03zhgQNsUDHA3H1xpM4lyUvJ+ACovx8ec9f5wolkiSy4pjILCVZiMo9qvBoAJ9kI
 6dpr/TpWu3k7r4C6ltljkag5qSKEDWgC472ZClMfWJf9KtxJ7+zboNLfDv0OJybqks+c
 W8/s181CXPXOq6gFBdZggn8Gf0rCTXsfg5Kl+vi25Q9c/PMiLu61zicRJTJv4BqHDxLo
 QMUg==
X-Gm-Message-State: AHQUAuY4cM5QYnPFXxHJRFcmE/HF74sEUF/m5Vqt+au6ZnIk6+iWajJv
 nzcote6No3XHblrK/D5/Fff8x3n12628W3qhD8Q=
X-Google-Smtp-Source: AHgI3IbJwhKaTIo5OcVapSkB4MdINzsbO9oIGlcqnDFIuVPSDGm0ZpbaSpn+OeYcw40pm3vlxdwPVJyqXCKnTZU4wKo=
X-Received: by 2002:a9d:966:: with SMTP id 93mr652532otp.25.1549312012708;
 Mon, 04 Feb 2019 12:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <CAL_JsqKt1kOXmRNvkYsQ6AL69+TPZURKpDbKkkEUb2+KZ5hKjQ@mail.gmail.com>
 <20190204165637.GA30876@ulmo>
 <CAL_JsqJx98DfHZSafiXA8QiO=bn1zy8g6keQ15L=cUmbVkTTOA@mail.gmail.com>
In-Reply-To: <CAL_JsqJx98DfHZSafiXA8QiO=bn1zy8g6keQ15L=cUmbVkTTOA@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 4 Feb 2019 12:26:57 -0800
Message-ID: <CA+E=qVdoOTj522hftrYp3fbH3zH4jD7GxtvOOH6RwCHx+nNwNQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
To: Rob Herring <robh+dt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_122653_685443_6074335A 
X-CRM114-Status: GOOD (  21.01  )
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

On Mon, Feb 4, 2019 at 12:23 PM Rob Herring <robh+dt@kernel.org> wrote:

> > simple-panel would probably work if you stuck in some mostly compatible
> > string and provided a ddc-i2c-bus property in the device tree node. The
> > generic-ish fallback case could be implemented by providing a fallback
> > compatible string (we used to have "simple-panel", which I think would
> > still be adequate for this I suppose) and adding a dummy descriptor in
> > the driver, perhaps one with pre-defined delays that could be adjusted
> > to work for all cases, or they could just be 0. At least that way we'd
> > be explicitly documenting that we support this as a fallback.
>
> I'd like something more specific than 'simple-panel' that at least
> implies it has EDID and whatever else we think it should imply.
>
> Looking into this a bit more, why don't we just do a connector here?
> eDP has a standard connector (with power). It's just like other
> connectors, but with power and no hotplug. If someone does their own
> interface, then they should do their own connector or panel binding.

Where do we put backlight in this case?

> > I'm not sure how you'd want to enforce that people provide the right
> > compatible strings that way. Currently there's no way to make your panel
> > work without adding a panel driver, so people are forced to write the
> > DT bindings and a driver, or add support to an existing one. If we open
> > this backdoor, I suspect many people will just take the easy route and
> > rely on the fallback. And then what do we do when we get bug reports
> > about panels not working, or requiring some quirks. How do we go and
> > find out what the right compatible strings are for each board, or how to
> > fix things for something we don't have access to.
>
> We'll simply reject anything that should be implied by compatible. And
> now we can enforce with schema that DTs aren't populated with
> fallbacks alone. Of course, we can't make anyone pass all schema
> checks before shipping a dtb.
>
> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
