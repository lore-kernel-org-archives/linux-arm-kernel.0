Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABEDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:42:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C108A20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tUIN/rXE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ5Fle2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C108A20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9Ifv2KvQZe3xbIOR6GdF+cwdF9ycAtqnOr5UAJHydIQ=; b=tUIN/rXENIAdssDOI1E1FSW2J
	tbTssOnk45LTxKt2piEwdXDbC82zk7TYc9i7dvoaQlT5Z2+8dWxtmu5V0GcnPO9RShnUJaqqIdVD3
	6xJV3fwzR6k3Dm9gdMcurGpYmMafcpXxij8snvZ8l3UcsGZEl/2d7ViPRARV5u/8QEfIHHSzFZDKG
	7aswgc8YZkNN/x2l+LtmRbN2BsVhIpSrBRL/D4lOD8EgW3p6no9D18YZDibufz8XOxsvMWiwuTbvL
	5gsytrpI9ebLe0BTbUsl7ypvKYHvyelqFq32Mb77zJZKHK9Jb1N4XXQBMZ4qVhrlgOPKPXJOKYLgR
	9JLj4lyCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grLbE-0003Ms-Vc; Wed, 06 Feb 2019 11:42:40 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grLbB-0003MG-Hg
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 11:42:39 +0000
Received: by mail-wr1-x442.google.com with SMTP id a16so7222877wrv.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 03:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xKTnjADLiGU2NapTeQ8jqEgMZ+eQgEusUsG4lwf/5rY=;
 b=MJ5Fle2OTXbMVLEkf/GcpXoKlQKVFqP4RGBAKb8a760iueBu5nu3ENW0PPYSKfHV0X
 yYPhoj6YscQ45hmwndqVGhXuZLJWXIlGwiGzdeZyLI/NJoE+8RenHjpiJz2fHByDY8wW
 e0wrgKOtDKn02QS6tTOV6PiqGXGrlA6pGcfVgiacjJG/eTFkpARbMs+JE0+9gTeThUvB
 x4iGHo+ZbWi5Da14FMaQ9FoYwfGv8jmQDUPNLoBN52ihKXnVi3Ng2bS4kHRoJboNc/8G
 Uy70i7tM+Jcd9//s6V+Gxt0uOqSf/2z52aoF8MZ4pVfRkDgcMvuOeNPOHsbzyVDCrnnc
 3t6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xKTnjADLiGU2NapTeQ8jqEgMZ+eQgEusUsG4lwf/5rY=;
 b=llxN2mVqmlehzVw2Y2sckH0qBTIH1E27OsMagRHHCGDbkvwDldQnQUgev+LApNN/K/
 hQ1ZjLtpZkK7YXfDIHgj448vU1zZrebpwMG2ckDenTzpE9o8OgVvPATNL60j5iAPDclW
 3a4cEdc+ganjBrkTHyWyc5jvTXSIGQFGZcB00++gvDwlNeJFHASklIlvUAVXga7UJhGx
 nlCVWjjYGf2eji69SBjFuq9Y4Sy76jjRqTlIL39XST8GPwsmTWmoMOkPsdJUwFlC8oWV
 ysTaxjee7LyyDuMZBZbWHNzBJqWvzqaNY8zw5UMtK4j/1fvyte5q36xzggeP5qnYVVTx
 zhqA==
X-Gm-Message-State: AHQUAuZiTIQEtgsfMI88sQN/+q0WT4T3qaDUjIEkzmI+AJ6wYEHE67o1
 qeiz0L8BMSHvPnSh/JzFfagDq67cIGw=
X-Google-Smtp-Source: AHgI3IZdt/xSP7qYINRaV9MOFNi4VsnrV2lEAom93cN4KpwaRSdgwjv61Vumz1eCojeuWALm6ZsCtg==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr7304788wrt.193.1549453355212; 
 Wed, 06 Feb 2019 03:42:35 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id o3sm15376696wrs.30.2019.02.06.03.42.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 03:42:34 -0800 (PST)
Date: Wed, 6 Feb 2019 12:42:33 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [linux-sunxi] Re: [PATCH RESEND v2 06/12] drm/sun4i: rgb: Add 1%
 tolerance to dclk frequency check when bridge is connected
Message-ID: <20190206114233.GB21676@ulmo>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-7-anarsoul@gmail.com>
 <20190204142036.vd42nvyjnjr5yeoi@flea>
 <CA+E=qVfTfJ9E29gz83tdVGx5_KGWSQVJOAxKTzC+-n7=gdj0cA@mail.gmail.com>
 <0F6CBEA4-6DB6-40F1-A2FD-65101AF64F1F@aosc.io>
 <CA+E=qVd7yh=JNZSvrfY4Diu+VJWFK6yLUJ5MavBcZ8Cftn6f-Q@mail.gmail.com>
 <20190205154156.o3aa4cy6uxenkwol@flea>
 <CA+E=qVePKnQLwObfu=ya7-GcUiUkjyFg2p-rmg=FiJJUhQBvxw@mail.gmail.com>
 <20190206091608.yvws7iyjuhw3xsdk@flea>
MIME-Version: 1.0
In-Reply-To: <20190206091608.yvws7iyjuhw3xsdk@flea>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_034237_581921_4A94FBDC 
X-CRM114-Status: GOOD (  23.97  )
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
 Chen-Yu Tsai <wens@csie.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============7549287377083304001=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7549287377083304001==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 10:16:08AM +0100, Maxime Ripard wrote:
> On Tue, Feb 05, 2019 at 09:49:17AM -0800, Vasily Khoruzhick wrote:
> > On Tue, Feb 5, 2019 at 7:42 AM Maxime Ripard <maxime.ripard@bootlin.com=
> wrote:
> > >
> > > On Mon, Feb 04, 2019 at 10:50:17AM -0800, Vasily Khoruzhick wrote:
> > > > On Mon, Feb 4, 2019 at 8:29 AM Icenowy Zheng <icenowy@aosc.io> wrot=
e:
> > > > > >> IIRC, from the previous discussion, HDMI had a tolerancy requi=
rement
> > > > > >> in the standard. Do you know if there's such a thing for eDP? =
That
> > > > > >> would solve the issue for all the eDP displays at once.
> > > > > >
> > > > > >I don't have access to eDP standard - vesa.org says it's availab=
le to
> > > > > >members only.
> > > > >
> > > > > Try out to grab an old version?
> > > > >
> > > > > I remember 1.0 is open.
> > > >
> > > > I can't find anything regarding dot clock tolerance in DisplayPort
> > > > specification.
> > >
> > > I guess since the DP is a VESA spec, it's probably .5%, just like on
> > > the EDID (well, CVT).
> >=20
> > Unfortunately that's not enough for Pinebook. It needs 1% for 768p
> > panel.
>=20
> And that mode is stored in the EDID as a standard (or established)
> timing, or a detailed timing?
>=20
> If the latter, then it should also provide the tolerancies as part of
> the panel timing description.

The simple-panel driver can, in addition to a struct drm_display_mode
take a struct display_timings to specify the modes. These allow to
define <minimum, typical, maximum> triplets for each parameter, which
are usually found in panel datasheets.

Of course that's not going to help you much if all you have is EDID and
if that doesn't provide tolerances.

Thierry

> If the former, then what would be the advertised pixel clock and the
> one we can compute? Maybe we have a bug somewhere.
>=20
> Maxime
>=20
> --=20
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxayCkACgkQ3SOs138+
s6HaLw//cfnUhXCcsJJCytAwQVS04XgtDkElB83/mJ1JxxfMFsF/xXptZzWomwXC
BKiEFLRkGbqb2HUYHSfGsUk+rns+gB7T7sSO4QU+wCfyDamtVxdXQRLqHpE9kVN+
GGtj+ou15wVzi9whZ3v8HyKJA2lRw4A1ye/sHQvuUH/0JVoDv+31IQfrwcYad8AS
ShaIMqYEp78hQVZSB4mvbHZIZFSbk88nmzJ0wXcV+fOE67K2tz0ORqCJ8zeLJYsf
bufoG2Ooyamv0+9o3cOg+VNVZMKAiJGeT9qFlHvAxd1K7HzeAJ8jlFoy/hjSHRcC
bD38epk5CiDN+IvMTwPG0t3WgI0u7KMmSRkVbiIJ5jN2PqeBJ+sAOyqaa7WsmAWl
KT+49pjJi4cjBlkjswquf7J4OXJGhh8p96/jLxJyIqXk+93wamz7jyyYUzQx4FkK
QYgf5CNBk9Idg43ITX59trEj7VECbP3/U7EVi/UWNuFBov+CCkTwN1wDIIJl2Fjn
qbn6OP76njMZTzO4YYkEo/fgXoRBU4xNgK167wNDP1MTvrDbYYmYyae5NuKwu7zi
KAkN1ImZBq/IgA4xkR0dTSQZvWXRO8mf0XNPWrADcmg6FRWeBGuSwvlkRjgQqWI8
FOfDzT5y36v7pa9AAFC18VFUPUCHjK1L5loWyt9KzzuavD5j7+4=
=sYYT
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--


--===============7549287377083304001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7549287377083304001==--

