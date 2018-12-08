Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A725C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:05:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8B42082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rmFbJHvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8B42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UK+kOSXCXdHN/iihqOYYf2cvhPENtnFMXTy+qfgDE30=; b=rmFbJHvCE0o9TeAcer9Hkuf8U
	UNea5vTDM99lzcMqlucDzxwkM8WmOEbX6s6zTFxqEuQy0jcIK9YDj4ZyJ5KfG3vTnvzhTNRr4ilSz
	AthAW5I1+hxKh03+0NAMPacPvS+BzDO3pKaon1H3Qnalq8e+s0HbDsG1fcht5v9XLAQBiP3kC+gZP
	w9T5CRmTvC/3yTVUg98GcIt3br/mbKHZX4R0ujSk/0xer/g+mode/rjeOpB8u+YCNU//v3WBMerxD
	ExaQp491MVUdILs1oYvPUsDdAew1KYd7L38jfAjm2TqtCqgez2ZnFoKpRaOnm83XrM1izBZ5Bszd1
	k1ZDseQfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVeB2-0008NM-E3; Sat, 08 Dec 2018 15:05:56 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVeAz-0008MW-01
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 15:05:55 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5BC20207F0; Sat,  8 Dec 2018 16:05:37 +0100 (CET)
Received: from qschulz (lfbn-1-2071-46.w90-76.abo.wanadoo.fr [90.76.137.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id F006E20510;
 Sat,  8 Dec 2018 16:05:26 +0100 (CET)
Date: Sat, 8 Dec 2018 16:05:26 +0100
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181208150526.uceviwfwqskfwovm@qschulz>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
 <20181207192237.GK26661@dell>
MIME-Version: 1.0
In-Reply-To: <20181207192237.GK26661@dell>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_070553_399971_CBF1A556 
X-CRM114-Status: GOOD (  17.47  )
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
 devicetree <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============3388716925718720724=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3388716925718720724==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="umq566xyw5pxyboh"
Content-Disposition: inline


--umq566xyw5pxyboh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Fri, Dec 07, 2018 at 07:22:37PM +0000, Lee Jones wrote:
> On Fri, 07 Dec 2018, Vasily Khoruzhick wrote:
>=20
> > On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wrote:
> >=20
> > > My OCD-dar is going crazy.
> > >
> > > Why haven't you used the same alignment as is already there?
> > >
> > > If it starts to run over 80-chars then bring the others back.
> > >
> > > Also why is there a single liner shoved in the middle of the
> > > multi-line entries?  Please move the singles to the top or the
> > > bottom.
> >=20
> > Hi Lee,
> >=20
> > Could you please reformat it in the way that makes your OCD-dar happy?
> > It would be really nice to get
>=20
> I'm afraid not, for a multitude of reasons.
>=20
> The most important of which surround testing.
>=20
> > AC and battery support for APX8x3 merged -- it'll make Pinebook and
> > Teres-I pretty well supported by mainline kernel.
>=20
> That's great.  A worthy cause indeed.  So I'm sure you guys will want
> to turn the patch around in short order so that it's applied in time
> for the next merge window.
>=20

Aren't the MFD cells probed in order?

In that case, it makes little sense to short order them for this
particular device (X-Powers PMICs in general). It will just make the
system boot slower because of probe deferring.

Why? As explained by Chen-Yu in v3[1], axp-gpios can be muxed as
regulators, thus should be probed before axp-regulators. axp-adc is
often used by axp-battery, axp-usb-power, axp-ac-power, thus should be
probed beforehand as well.

For the alignment that also triggered your OCD, I can send you a patch
the day you merge this one if it can help. I sent a few patches for this
driver that didn't respect the alignment so I'm fine fixing the mfd
cells (and eventually re-order them as I saw a few axp-gpio cells being
declared after axp-regulators).

Does that make this patch OK for you, Lee?

Thanks,
Quentin

[1] https://lkml.org/lkml/2018/10/11/338

--umq566xyw5pxyboh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlwL3bYACgkQhLiadT7g
8aMzDQ//SP/WNuKOA5RABdv9owyD0gfaSWiEML1W6ovmeEBPfxP6euZcHgnRsgEw
errjVUNOrlUy1Dn7cDLMhhCYlZuXBjfqlakVRAZpzhI1n0C4jHcERSB5e7Qck9uf
UwUSmi5rRZF0s2Tk034O/ycv/BkbRbXwPKN9K5j9zsyGYXBjWlw7Vr695E4O9pSc
69dTwRq1eYUFXlOk6Z8jBwAbMfPq38MgT7TbOq6OhxfW7efsPF4GinGyFfmhYmd/
C8uJtc+NxXn3XOySpObEAIbl5XL+ugpwT/zVhGz+IdNBX+aJNLWrzpyfK/9U9DEd
TQye0ezWR8n4navDsuYfYMaPXToXRZRWc/m1yvM+mSkDOAiXBhNZ1+oUPRTiKtnS
fxx+THTvpUwmNACctbUNRoU5u4QHfyL5A4I3uuiPyU9x3c9WYnB/ycHBxgMVx/0A
QrH7czW0VeqI598UV7hfNmDwV74ZxcJvCdROQLr5i9KWqknjTYAizvJdK/76MxSh
fAkA+SHO55y22ivHeJsCha6cIOtbbOVzVjFLeDRm+1MiHNFkacNHglNtC030hE1Z
LYjKE2hdG8zlL1Ak78Fpam9mZrOtHpwbS+AJpNsdZFA455iqZQfsLI6CY7o/N6E5
t739gtE19+hwYyaK2cNG9F4eZkVrtnOyNkOMxX1yIUkeMoRHUAE=
=BKmW
-----END PGP SIGNATURE-----

--umq566xyw5pxyboh--


--===============3388716925718720724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3388716925718720724==--

