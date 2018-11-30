Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261DAC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:17:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6EC20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tLvx475P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6EC20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vtl/6m0GtmbC0dvtHhms7/qOKvLyOarNHJk+WnqfHoQ=; b=tLvx475PDzefMe986cmu/51Fg
	RkNlUHnLcTRlVGLq6W6NSqRAGgxDK6XSIKaWafs5MEAzPIyVd/4s94v/EKL80vU5trfXlsGLvdzpt
	uRuc+vkfN42k9Gk/ooCVLP7PHixF+tAp2KogmhOBABah+g1rioYr5UchVXHS875VPangkFfueExRB
	9WWELY70xv3gOjHz+XX2pFYpmhlOxXxPIQnlRTGaC9ZYJCrF3FGmtvdMR/3aURU/seS+1SiW1cnb7
	Bx/RM1okgiwxqw6sNIdtnbF7FORAgeIHyU7pVuNKmuN87XyVYL3UR5H/jVZZVfYT1WsoblnuF+Bfr
	qr8kLkonQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSifL-0000Wn-W6; Fri, 30 Nov 2018 13:17:07 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSifF-0000WH-PQ
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:17:06 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B27A6207B0; Fri, 30 Nov 2018 14:16:50 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6324B2037D;
 Fri, 30 Nov 2018 14:16:50 +0100 (CET)
Message-ID: <2a52719446c1050990494e44a991acb932da8273.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH 14/15] arm64: dts: allwinner: h5: Add
 Video Engine and reserved memory node
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Nov 2018 14:16:50 +0100
In-Reply-To: <CAGb2v64pVKG4mSAF48xR54yj00rQ6iTvgYQB9Bf-XWmH2FhVqQ@mail.gmail.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-15-paul.kocialkowski@bootlin.com>
 <CAGb2v64pVKG4mSAF48xR54yj00rQ6iTvgYQB9Bf-XWmH2FhVqQ@mail.gmail.com>
Organization: Bootlin
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_051701_968932_5B1701F3 
X-CRM114-Status: GOOD (  19.50  )
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
Cc: devel@driverdev.osuosl.org, devicetree <devicetree@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============7706279690352006185=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7706279690352006185==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-453EcI7CdM8GuIru8Jyr"


--=-453EcI7CdM8GuIru8Jyr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2018-11-15 at 23:35 +0800, Chen-Yu Tsai wrote:
> On Thu, Nov 15, 2018 at 10:51 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > This adds nodes for the Video Engine and the associated reserved memory
> > for the H5. Up to 96 MiB of memory are dedicated to the CMA pool.
> >=20
> > The pool is located at the end of the first 256 MiB of RAM so that the
> > VPU can access it. It is unclear whether this is still a hard
> > requirement for this platform, but it seems safer that way.
>=20
> I think we can actually test this. You could move the reserved memory
> pool beyond 256 MiB, and have cedrus decode stuff, and try to display
> the results. If it's gibberish, or the system crashes, it's likely the
> memory access wrapped around at 256 MiB.
>=20
> What do you think?

I did the test on various platforms and found that starting with the
A33, the VPU can map any address in RAM! SO we shouldn't need reserved
memory nodes for these devices after all.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-453EcI7CdM8GuIru8Jyr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlwBOEIACgkQ3cLmz3+f
v9FV/Af+JpWv2W/HOaxK1G4Ane+uWUNIMUUgOaXhtOWvSfOu9arSCtcVqerpnZHu
TegKhEKLo5GMEcEBOFbnqiFEno9JkrY+fN7ukdUp0QGqX8uSry5ehpm/yznNDTnZ
IvzNrsRO1CrcC0/YKn3+6hxbcD81wf86ALVtQwpUvVv3FNGsvEaKyi7YKKDNOyQs
Yevz1VInlDEXFJ5SXmR99LMbAyjNBt7UtHVM5jKODv3lkdXyAta5MGCaRlv8oqxk
hZnEe5M4mPns7vmNTa/wM0+zHkAORNs9IoOTepMep2f9pmMNq9qw03PT6hV0bxcU
2ZgSh2jiSJBB8jJk+VhAAUmB+iS8qg==
=wjcm
-----END PGP SIGNATURE-----

--=-453EcI7CdM8GuIru8Jyr--



--===============7706279690352006185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7706279690352006185==--


