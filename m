Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A1C282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:50:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBD0214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YWUDnW0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBD0214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vpe6uwwDMFFxJ81Gy2EGXicG++WznyVHnJoifYkjX/8=; b=YWUDnW0Y1yWWEFqGVW+6xs3HP
	/RmIKv18fPmTueLIO2Mfbo7gDfGTQKes/uN2uSWr/LuOqsmjcrPln2L9W7oLSxa9I80PpCKorCGpJ
	I8NOvd9bjcV7fU0dvXWu4QSuQp83eMtu7ge9P2Jzg8f3m6+eaSxHig2za3dNEsf/XfZMnwafRcEet
	B+MRbwMLzxa4dWlK7W+fMjyRbo1oXnJ0eQyU7fvFT/zTCJFgv9SIWjf8/exInV4BlqGsUe7Q5VnCJ
	55/xGh1pSFRqsWKEZ5TdhnFOMcxgkFN546Mg0wZ9e7VZH2xOS6rDRfIu5gRmCXHRRje/2apvaE//3
	hI09zY9cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWDv-0005oh-KL; Mon, 21 Jan 2019 09:50:31 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWDs-0005oL-Ck
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:50:30 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DF83F207B2; Mon, 21 Jan 2019 10:50:24 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9925B206A7;
 Mon, 21 Jan 2019 10:50:14 +0100 (CET)
Date: Mon, 21 Jan 2019 10:50:14 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
Message-ID: <20190121095014.b6iq5dubfi7x2pi4@flea>
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190111173015.12119-2-jernej.skrabec@siol.net>
 <CAGb2v66DiqK9sL-hQev4Wy08d9T7f1Yc2DFWJ0gYOnqChJyBRw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v66DiqK9sL-hQev4Wy08d9T7f1Yc2DFWJ0gYOnqChJyBRw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_015028_568782_13086A32 
X-CRM114-Status: GOOD (  18.07  )
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
 Jernej Skrabec <jernej.skrabec@siol.net>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============4011902082139902830=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4011902082139902830==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pod3s2auuikkj2ou"
Content-Disposition: inline


--pod3s2auuikkj2ou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm a bit late to the party, sorry for that.

On Sat, Jan 12, 2019 at 09:56:11AM +0800, Chen-Yu Tsai wrote:
> On Sat, Jan 12, 2019 at 1:30 AM Jernej Skrabec <jernej.skrabec@siol.net> =
wrote:
> >
> > A64 IR is compatible with A13, so add A64 compatible with A13 as a
> > fallback.
>=20
> We ask people to add the SoC-specific compatible as a contigency,
> in case things turn out to be not so "compatible".
>=20
> To be consistent with all the other SoCs and other peripherals,
> unless you already spotted a "compatible" difference in the
> hardware, i.e. the hardware isn't completely the same, this
> patch isn't needed. On the other hand, if you did, please mention
> the differences in the commit log.

Even if we don't spot things, since we have the stable DT now, if we
ever had that compatible in the DT from day 1, it's much easier to
deal with.

I'd really like to have that pattern for all the IPs even if we didn't
spot any issue, since we can't really say that the datasheet are
complete, and one can always make a mistake and overlook something.

I'm fine with this version, and can apply it as is if we all agree.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pod3s2auuikkj2ou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEWV1gAKCRDj7w1vZxhR
xdUhAPsFhFx24R8BcF1PZBKzZxawseM8u6EkLqiywLaJEW9KsgEA7IaQ769P9J/O
y0f1jGjSPd1ns0KF+bP144/jbr84RwA=
=oQXi
-----END PGP SIGNATURE-----

--pod3s2auuikkj2ou--


--===============4011902082139902830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4011902082139902830==--

