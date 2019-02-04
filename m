Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E984C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:56:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E56120815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZP2Xjv1r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrkD3eEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E56120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=59r1Z5oIxjkJ8j439qxCqX1197XeFwUx0MggY8ooaGc=; b=ZP2Xjv1rF3y19YECKSQK+t0Dk
	lScz2FFMG1b2G1Ir+Sb24KiRgGlGaokRPzrR18Yyi10s4akwgQSVclGwkMJFptcYU40U6CgyL87Un
	GRpWsW843V9JHYRBCcKVcSlilq9NLzjHc3/YIchHD4nhAEjSjHuKtQ0q7w2/xDAfYmQAFhACbHgus
	9nm0/ps9GylMCNKA6EPE7y1+ZFkxwwTGF1+baGAInO296nIopNGmSIKZga1BQv8zh5XduAHimQyLZ
	O5TWSsApokPWc63H48r9yLY7fQEIiHLYjyjzAkcfiwhT7htYcLvqJoEDjJV0Mdzrr3qP+M3FO3AhP
	s1IyxRPYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhYF-00075V-1S; Mon, 04 Feb 2019 16:56:55 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhY1-0006ss-Li
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:56:43 +0000
Received: by mail-wr1-x444.google.com with SMTP id z5so558947wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kbKoOVDuK8DhkRmfyLVaiVFtUSegi/X8WGX0tp+jIaA=;
 b=MrkD3eEEpTPMFi3TDOKVKxkevbGgIohF0ebB0h409CPBCrh0mstsbVoV7HcE2IX5j9
 izej8yTyB20bb9uwlrvMZG8UnZmOv5rF2awmaxU+grFqVxHuC4x+BpjHFnTEmAOJBZbd
 XgurngksBLChqkp/Mu9WcbQ/48OCBkWrc1h66DEtfA6O5qTh0rXlWcaEff9HHBpZINcU
 Rs7iOWiRP3uD0Toe2XT/+uPL0h1lRbl9iUIzNg/h628l80TqJSYcSOsgEtJXyj9Nrzdx
 7IR8Sux3DF56pHPUhbNqQjdXALLilEvPRMiff0/mkNu+nai/hdRt1bxfOUfqMZ2+TF41
 yOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kbKoOVDuK8DhkRmfyLVaiVFtUSegi/X8WGX0tp+jIaA=;
 b=ks0p7wW8MEms4m6Bm0XfltpZpHEqvS3xtV32kcfoU5PC+cPvIYK30Mn/GjmsB937Bw
 LS+3t3sw78GX+wDRVyHQxhBE6l46+6nPkCULOJL86hybVgpBJR7Qr0rdaaIvnYGuY2PS
 v9YQvmOhGJYuUL3EaPWRckW+RTwtmpceMj9ZSbANmQ2VTKHCMbzNeE9o8vj+nE7z8+oU
 zoNKIzwxfC1x1D0oMkuU/F84KH4TKUOLaHA2Le5tbSxhw7C/rLz5lud1p0sr4L8TEfTP
 vtGEZseibQ3FlTeHlNRxu4pw+iTm5RhA+jhvvk7Zj5RcCVJ5im852KAn6tJPtOjurvht
 P4uQ==
X-Gm-Message-State: AHQUAuY4AKx9cLWHUzrjmI3Zrr2mK3HDz3yISJqlQmNFy0CqiYgh0aZ5
 faSW313ngBXNQ0XEiOxwS2k=
X-Google-Smtp-Source: AHgI3IZzcQvHbVVHrfaWpw1Qmj1NQKqfqrYKH7yYIXNuN6rB5PAx6TTNxoSBg6t+SUls3RLNB5mjSw==
X-Received: by 2002:adf:e98e:: with SMTP id h14mr248719wrm.115.1549299399619; 
 Mon, 04 Feb 2019 08:56:39 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id p10sm10543101wrt.25.2019.02.04.08.56.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Feb 2019 08:56:38 -0800 (PST)
Date: Mon, 4 Feb 2019 17:56:37 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
Message-ID: <20190204165637.GA30876@ulmo>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <CAL_JsqKt1kOXmRNvkYsQ6AL69+TPZURKpDbKkkEUb2+KZ5hKjQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKt1kOXmRNvkYsQ6AL69+TPZURKpDbKkkEUb2+KZ5hKjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_085641_733878_DF57963B 
X-CRM114-Status: GOOD (  33.56  )
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
Content-Type: multipart/mixed; boundary="===============2933498473242532027=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2933498473242532027==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 10:27:09AM -0600, Rob Herring wrote:
> On Mon, Feb 4, 2019 at 2:24 AM Thierry Reding <thierry.reding@gmail.com> =
wrote:
> >
> > On Mon, Feb 04, 2019 at 12:13:55AM -0800, Vasily Khoruzhick wrote:
> > > On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > > >
> > > > On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wrote:
> > > > > eDP panels usually have EDID EEPROM, so there's no need to define=
 panel
> > > > > width/height or any modes/timings in dts. But this panel still ma=
y have
> > > > > regulator and/or backlight.
> > > > >
> > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > ---
> > > > >  .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +=
++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/display/pan=
el/panel-edp.txt
> > > >
> > > > Please don't try to make panels look more generic than they really =
are.
> > > > You're going to have to provide a compatible string for your device=
 that
> > > > is more specific than "panel-edp". You claim that you don't need any
> > > > extra information that is panel specific, but you don't know that n=
ow.
> > > > We have in the past thought that we didn't need things like prepare
> > > > delay, but then we ran into situations where we did need them.
> > > >
> > > > Just do what everybody else does. Provide a specific compatible str=
ing
> > > > and match on that in the panel-simple driver. Even if you can read =
all
> > > > the video timings from an EDID EEPROM, you can still provide a mode=
 in
> > > > the panel descriptor to serve as a fallback if for example the EEPR=
OM
> > > > is faulty on some device.
> > >
> > > Pinebook used several 768p panels that have slightly different timings
> > > and recent batch uses 1080p panel.
> > >
> > > What panel descriptor should I use as fallback?
> >
> > You don't use panel descriptors as fallback. The simple-panel driver
> > will bind to a panel device and use the corresponding descriptor. If
> > your device tree contains the correct information, the descriptor is
> > correct for the panel you have.
> >
> > In other words you need to ensure that you have the correct panel in
> > device tree for the board that you're using. This is exactly the same
> > thing as for other devices.
> >
> > One way to to this is to have separate device trees for each variant
> > of the board that you want to support. Another variant may be to have
> > a common device tree and then have some early firmware update the DTB
> > with the correct panel information.
>=20
> That can be a pain to manage especially if panels are swapped run to
> run with 2nd sources.
>=20
> I think it is perfectly fine to have a generic-ish fallback as long as
> it is just that, a fallback. If the panel has quirks, then you'd
> better make sure the firmware is stuffing in the right compatibles or
> that you can update the firmware.

simple-panel would probably work if you stuck in some mostly compatible
string and provided a ddc-i2c-bus property in the device tree node. The
generic-ish fallback case could be implemented by providing a fallback
compatible string (we used to have "simple-panel", which I think would
still be adequate for this I suppose) and adding a dummy descriptor in
the driver, perhaps one with pre-defined delays that could be adjusted
to work for all cases, or they could just be 0. At least that way we'd
be explicitly documenting that we support this as a fallback.

I'm not sure how you'd want to enforce that people provide the right
compatible strings that way. Currently there's no way to make your panel
work without adding a panel driver, so people are forced to write the
DT bindings and a driver, or add support to an existing one. If we open
this backdoor, I suspect many people will just take the easy route and
rely on the fallback. And then what do we do when we get bug reports
about panels not working, or requiring some quirks. How do we go and
find out what the right compatible strings are for each board, or how to
fix things for something we don't have access to.

This all sounds like a Pandora's box to me.

Thierry

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxYbsIACgkQ3SOs138+
s6FfYQ//YjhRSI/DwPvLu34LouUyCxmfu7m6aIszNrWbobnc+o2QjK0Vy7bZolRV
4gUFXCFJpIzPrjPjtiJ1O1vpdPakNX3qzJMf186MCWcYSe+CY/Nnso7LgY7JXEwz
ufqNZnF5ngEQponLP4cLIh3UDhijDWKOKrn/V/p0CSuiVHUETCqREy8hwD3InyXB
iwlyjyTzGmHYCmdi9hCTU9K5nr8DUcvgutUuD6BPVdYtCWGMeGhBHV8R9BdynYwW
1Yzqmp2llZkwW1S0hyqc8GANeOWzfPdIWJI09+z1B3lZrqaf4oQEZQlW+OwVPrXG
m0f6kC63hP8yiQMGpTeTIHKplOGJhIBMHWtnbB3CNrom0lmREjYwuT1NxcHzMNwm
3EkvAYRcpvyKGarlzqCXsBSldfk0CE9T2t3nnWHaPD8gZ8AlLiM/ungoMOG7oTY/
/uEjXQRWJ/dz+/uBSUCqiUUAyYYdeAzEIpcsTCnaFeoWADdVDFhzDiTR5toqIcNR
S0fF3MLB/MvaNpB9dHZjzM0/xVZoV/+lnMDm7gqA4nbnHnXaXrg+7nWLxPvPnjs/
vEeo216FT8g7sWpC2+cWPv+rDoQ92dUa/IgDZSO5kQN8BHVDcF50rWr+YCoIqiha
l8tZfUXOy8DE1lb/GnWSSFMgAQ7jVT3yHA8rFI8jODGdkoMd/wY=
=1ItP
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--


--===============2933498473242532027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2933498473242532027==--

