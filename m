Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13737C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CFF2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gJ+EaB9P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0f2APmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CFF2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tbdc4r2JsqxfXHrtLlTEZlxVtqLd/DlKOur/vDveRiA=; b=gJ+EaB9PBH7Qw3dZ4/AEf8Yr8
	8FktgdZcsNdpS0z3LMWjShGBIY0uPNN345JCuB7QMZ+4mseHrEkNOoLaprUeey/1sNTwK4Y6JC12a
	XUPEPNmPwkHjEhMpqI8QhJSvSPA3Wl08N3vCyXcui5vI9oDK4qJyg6bs8/ScLNo02TQkLrDNxsBpH
	D8wYYtSnK/p3gWo2IiL0HEkKVVjIa38cPgo790TRt/lpcgqvwayTtDMyHhZoyv4zzZJrcoZtqOl2m
	061Oy5GnwYiof6Efs+IfjqKrtxF3Jy5kLf2vlxwTNQywmgXjdTQVSsy5urhnx8nbwLxbKoUlm/3XO
	17u8l3c8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9MQ-0002L5-GV; Mon, 28 Jan 2019 16:02:10 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9LT-0001zb-76
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:01:12 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so18611724wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IIAGtlBAYxChq9LE8Xgl+stdWp4U/DLgt3p9mfM8A4w=;
 b=J0f2APmLKasT0G5NAvM1SyYOaBOB4/DG8gZPHtmDlyriIOJjgbysxSSlkqcg2Lygls
 AZ+buUDStjIzFJMZhm6dRo4vutqq7ry/6GrVYzVyBxZT6LGJHUzTkzaeNC0DhDHvgTzR
 zx9s1txptMhs+sekTGy8suK0wekuh3VWfp5UTdrInMx6arCtJtu/gPgbiSTkRaoApIvc
 lJik1G6KB6ed+0o2qShbmCqGwX/Zh3SPVYcHkD1XrZGKWA07FUSzgAz0TOFPeT5Aav9y
 o/6EfC1+x47BQZOj1OBsfIfU2h6KC0pxGMidf2C2Nom2fvlafPAFiaodeJavNu3lW8j8
 /I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IIAGtlBAYxChq9LE8Xgl+stdWp4U/DLgt3p9mfM8A4w=;
 b=cZ9v3CjGCRMhS+ARwUeTcLvkGGzc9GMkRGfj6iKVJRgFB5aBHPUMpJKMcGsx1movAM
 CbgAswcJ5ch9bd8F2xxapT5oG5REEfHvrVtw2SQ16pgbzW69Erf+sRVNg68x9P7A9Y3n
 iG1qm7mCGVPDBY0BzRjFMQtmQADi0ZQYeCKT6CwQj1jPwQMEae2Sl/FoQNmdFu0gbq+5
 2TLdLhqCr0/c9MqwEin/AByti3B5uMOioFqFK9jmszZrGpjeVATZfI3P5OZID6l2xtb8
 rj4+7H/BfRtVpC2vbp3dXLnQFGDrFz/XhZ/fMTqXWyipetAvAy+wTGOraHu1SS3DtAyQ
 ISQw==
X-Gm-Message-State: AJcUukf3qwjowCpzdp8iwODcsgDS8U46YERog77UtGBUFVt9STSHuxWN
 YyyZsPZ1OEJqEIBPMkeBC9E=
X-Google-Smtp-Source: ALg8bN5DObWtwRbYQu1aRttWOkLwMW+gxLycNqWov7WPxgIHDrq6DevYTE8AKl8fC9tuC4rWKMjapQ==
X-Received: by 2002:adf:db51:: with SMTP id f17mr21126321wrj.90.1548691269782; 
 Mon, 28 Jan 2019 08:01:09 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id s1sm168731525wro.9.2019.01.28.08.01.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 08:01:09 -0800 (PST)
Date: Mon, 28 Jan 2019 17:01:08 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v3 6/8] drm/panel: simple: Add support for the LeMaker
 BL035-RGB-002 3.5" LCD
Message-ID: <20190128160108.GF26200@ulmo>
References: <20181107181843.27628-1-contact@paulk.fr>
 <20181107181843.27628-7-contact@paulk.fr>
MIME-Version: 1.0
In-Reply-To: <20181107181843.27628-7-contact@paulk.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_080111_318252_61C92D67 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Mark Van den Borre <mark@fosdem.org>, Gerry Demaret <gerry@fosdem.org>,
 David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Luc Verhaegen <libv@skynet.be>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3114287974576826476=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3114287974576826476==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 07:18:41PM +0100, Paul Kocialkowski wrote:
> This adds support for the 3.5" LCD panel from LeMaker, sold for use with
> BananaPi boards. It comes with a 24-bit RGB888 parallel interface and
> requires an active-low DE signal
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Applied to drm-misc-next, thanks.

Thierry

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPJ0QACgkQ3SOs138+
s6G5CQ//dIsEbrfTLsm7zGTb7L5zbM+zjfqGl43qCtTF8Y0EWBHIgW5fDctrzXlO
pddXxyZiQVGDu4dJv1UXJjLVfSOIVRQW0K1XjnR7d0Gq4o8juSkdO8czCphmZbUM
fDf3F37dIXE0w4ehW4OClzVnoC1EBGSHCLBiVg+gC/viu5mBpN+8WMLM0nq+mwA2
7Yl9yiD6CTa9E8EqM9NbmJN1QoXM8RFIESs9xgRI7Yj4Fu7lTltumYGbu6xNEO2M
qmSlUrJtMWNLHj+XSuxdo8bbZzZIL4Q9sj6oeEDwYUmPuVurzhfZuG3AhwM7t4XD
ropeE/C7ihGTmLIHfuDd8W6nC87kCkk32lGsIQGyQmWEoByDzNhcLccq3pk6hCxb
yIOjhnz/68LtIzxrGVNCbBWBkDXqrYdt74Qo9YJV9+3meKTZyNnggHHWwi5NL1p3
lZDWcqhvvGl27ZB++VvNNGrrxcqyNdWkdlaNV/xwMI0tSvpiq4u1spjf/xjMa+L2
9jdpCBo4LKhGA1IG/70dnH0PwKKEWJVWYFjLUiWODW07Kwelrc77FO8Pdmc9N/PZ
ow3moJNaWFqMDHdaorSWGOLF/Y4HWOK8+3ppxCYQARtn+hCVs9w4EzyrAhuW0Clz
dlUhtndKOchqsoMoosmGoWiPrfNIvA3hgQ5WWCFvfzu9AsAGA5E=
=Ujym
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--


--===============3114287974576826476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3114287974576826476==--

