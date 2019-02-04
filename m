Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18210C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:27:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB2D2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AUg5gMbD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjeerCXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB2D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A+Z6ARtJ/QEnTbvxgVH5Sr28amGKFoyAuxVDdN6duLI=; b=AUg5gMbDDZP3i793sJB9OCuPx
	Q4XtH/FlsHpXYrfyqz1nSmSLFmdCkhNkJZiyer2r4Om3MR2roP/zOYZKCLB3aG6oSISkElha1zkqD
	AEFLAIzzYQ85aDE+A9Ga1U2Gec3ZuNu+z02aYi5O1zfnWf8p3rYrbnQ9guPDzJGniZ8dhcXFDhHxa
	NHI0rXfoYwQoRpkAno1LYy4QsZxNxxGyLiTUV+mqNx+qqPeAOoZMYyQU0UbjteRP61jY/B0r/PJ9t
	RlH62WSrj0QIOwanTcUs7lpsIX9tOZN6Kn9pMmRNPZHQah7u1zk6Rdp21l88t4ZipvQNygjE1zfGJ
	qYbTooQiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqh5y-0001kh-EO; Mon, 04 Feb 2019 16:27:42 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqh5f-0001R1-FJ
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:27:27 +0000
Received: by mail-wm1-x342.google.com with SMTP id y185so10476059wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ei/F7ERTHjxrPH6rDXq+aZc48wQjGCH/Jl9BdlcMZiU=;
 b=IjeerCXS2yFzhk37uxdVa5MQMJNUE0lZsoKFN6Zp8ysVrcvX8aoceOtvMQMdrGkGvN
 6ipTT3mgkz6Gt9j2cK1HA2KDVhqRDqakCWfslKZnyQXuuncHRNBMe/R97fe4/1O7ZEn8
 y6o9kl6da7Ehm9Icg7Je3DQbqayd3vrQkF/SmKHmWERIiMppYxYhjVl60oS/b6oDzi0b
 8BhDEbSzHtD071ZqwJvQaKqZmmUjcj2FopybSmhyhbx4nXcupu/LBbHKu7GtWihjLmCG
 Yj8zHntj911tnLEVGeIeT/+WLEAVYuPkBZcru59ozh7slrTRlp8U4JPMrCpZv2h10yHV
 TQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ei/F7ERTHjxrPH6rDXq+aZc48wQjGCH/Jl9BdlcMZiU=;
 b=pE345dgW/6pywc+VH9cu2XRlISOSUhnm3GkREjjHLEZvOnIBh24W5VYhd4DJK1QjbB
 brOdrOrxeod7KeMG5lOZ+UGk/sR++m2GJC4zvmmC3xQ5t/pYqmfiCCXXJERj5aw03U9u
 P3DJq3kpCVtZvsZzW59RkOmscnO6MnA+AMhlodl/urP2hc1mVVfj18ZXMhxKPF/CS1+X
 f/dc45+Qq9VJEjLGOjoPIfYIPTtmahwXRaeru0xoD9NwJMJ4N4kz4IfCub2Rk2cWi2dr
 xoeBVBauCzZh2LbLYZU0xrVkLkmpGrncGMF7rcLEV3n5R4eY8aZo/foYBtl+oACWNqJ5
 AtFg==
X-Gm-Message-State: AHQUAuZhWG+yx8zu63NW/QtpvQ9ZCV47EH6/LW5UIGbSzIyaT81VbJJt
 4YMhW83Ls7ibXkUBRNEy8xg=
X-Google-Smtp-Source: AHgI3IYYk7NT8LDTkTrgjqEtDsrmNIjpoWqbv/5utRiENO5w/NV0N23JthYI1PHup5QxHjAed3vNNA==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr144988wme.11.1549297641280;
 Mon, 04 Feb 2019 08:27:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id l21sm7334837wmh.29.2019.02.04.08.27.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Feb 2019 08:27:20 -0800 (PST)
Date: Mon, 4 Feb 2019 17:27:19 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
Message-ID: <20190204162719.GC25476@ulmo>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <CA+E=qVew+8__yrAud1gFnLQ8HCwDdGhVjV=c173HGvZxH=7zZQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+E=qVew+8__yrAud1gFnLQ8HCwDdGhVjV=c173HGvZxH=7zZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_082723_842368_9E89752B 
X-CRM114-Status: GOOD (  20.86  )
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
Content-Type: multipart/mixed; boundary="===============4290618962981893961=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4290618962981893961==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 08:11:05AM -0800, Vasily Khoruzhick wrote:
> On Mon, Feb 4, 2019 at 12:24 AM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
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
> That defeats the purpose of using eDP panels. Panel can identify
> itself and report what timings it supports.
>=20
> If we use separate DTBs then users will have to figure out what panel
> is installed in their hardware and use appropriate software image -
> that's something I'd like to avoid.
>=20
> I can add a descriptor for something like "pinebook eDP panel" if it
> works for you, but it won't have any display timings in it.

I'd like to point you to this:

	http://sietch-tagr.blogspot.com/2016/04/display-panels-are-not-special.html

it addresses some of your questions. Hopefully that will also help you
understand that this isn't only about display timings.

Thierry

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxYZ+cACgkQ3SOs138+
s6HKnw//SPcp61RCvf+9XPzSxlnYUALPXt+A0njrwrJ/dUYVkEOp6LFWRX6DJQTC
Ix5QhTCgfOvcz/rvd4yN8p1qp+/VBpUob2/4dMkB4He43CXqlOzRhZ9pYsRZ4dcK
Ei8SjSzoBMy74hMspeZ4Hd12/6JkOEgBRH3tyxCbfGg98F8x4gk07nVb1pKQuQlb
7zdEBH+DaAiSphKOn8DZgAPaxLIRm9ELod1zppWmfDq0CvyxEZDV3R4z23O/m6yH
sMfDf/kjfDxx2X8RJ85SPzSJh4yTFUNo0zyNDFQ3xxWbt7c167f5C5+4zW0cSIZO
MTRH12C6bSKz7cbI7aGu7pXAsFw1gMgc/WikjQuRV1xJkqChxO2UNnlL90hMdXXQ
qSATNkfo3HUkIrOS1AiDzqwG5Sr/tvb+H0ETZxQZ9YwI2ckMwYVWIkMbm6ogjMwx
UIbUyFPBIJsNX6u6b+3AYJVQqAFPCdU5U8+YxFxssKVzsT0ILG0WMPa9f9miHcx9
jTZnWwcJOVxFCvL1x/GcjMJ/DW5boNR8K3zGLN2bxTWJwpOC+yt0CzsKSqPJxJYl
xuY25Zpy/IXi7vRpJUKhrYv3Iz+hnYzFJE3UseCdiW7ZAfOmiUuRLVAlp1AZForx
xi4Y82H8FCh15dpO0iiWlumEqMmMK0e/9Fdl6TThKMMjsZLJ6MM=
=aXpn
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--


--===============4290618962981893961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4290618962981893961==--

