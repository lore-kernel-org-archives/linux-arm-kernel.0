Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8163CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE0720834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RlRkVrk8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JnVpBPS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE0720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=paxAmtiN9UUHmu6emhjRGGrNys2scto2ierwO/tYI8E=; b=RlRkVrk8uqDVTGNNobHdvl6q/
	cUQ4ChfferAM70WLVTOsdHIiYKBbS8pjwv497u0ia5GKZT3rvLguUuv6jomLhv5PnNUCClwZOdwjz
	LFTzMXexcz0StgfdRvgIGdl692i6Eq+sor3SL9F1awzSv3QpAgj3dmJB2V16MAaEA7Hpj+U7mGK4N
	tnGsFXgkmH2c3XBoTX+tJWqT5qAGjK2XvltMOnFj/Ux1b8/xcXO2FYIYYYd5AHLdVjKa68bXacL+g
	/hvzDpNZaa44VGcnMtXF31eGUNhs0i40V2QuBVqK4yc73YlES8J9wqkXem2CORAQDDqiITTdhdLNs
	cYZaCuW6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSiuI-0005w0-Kz; Fri, 30 Nov 2018 13:32:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSirH-0002OB-8e
 for linux-arm-kernel@bombadil.infradead.org; Fri, 30 Nov 2018 13:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Mime-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xZ+sxC06QVelaIOFkYDL271mRJ8t3HUMaZgksjLXvXg=; b=JnVpBPS3BcCUlv18n4O6I8EDV
 szfOAwEUtt0a6ZD3OfAHxIOWcpuiGtBODkKRWuqYgmLkSRXfDCWKzaK8XL4QGChYjnc6yaiJVBnwz
 XyQpgh+U9F1J3oFDntI5AlF4xBVP855aQpvQSCHm8wCCw3Ti5c/W2ro7NZuZcGB1aYEOt/Ya7Qs0r
 qSxcnmsXwk86selZqCoOMviwxBS1XdmPHTb4X27VGJS12nuTtyWlTf0OKrzRyop9EqvAHx4shZiDJ
 TiWE0vkX3D9i6AtZhLRP0K2sZfLzU0Wm2fQgkrXbT2H0MVqzhbLeYxbhWYfkDPVdNqeFl7GfHwzNO
 H8qXzyuYQ==;
Received: from mail.bootlin.com ([62.4.15.54])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSiog-0000ul-RS
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:26:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 59BC1207B0; Fri, 30 Nov 2018 14:26:35 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 00B1320711;
 Fri, 30 Nov 2018 14:26:34 +0100 (CET)
Message-ID: <82a1ef7ea170ba50f58f74e26dac6170ac87783f.camel@bootlin.com>
Subject: Re: [PATCH 07/15] arm64: dts: allwinner: h5: Add system-control
 node with SRAM C1
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Nov 2018 14:26:34 +0100
In-Reply-To: <CAGb2v65yNKnqbeQmUYjMzDtydYL=7kxmtPrAEEU9U=a5XbMiFg@mail.gmail.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-8-paul.kocialkowski@bootlin.com>
 <CAGb2v64t6t3Bwf4nc8gQWRDkdv4zGRF1-+Q7snqX6bkEVqirvA@mail.gmail.com>
 <CAGb2v65yNKnqbeQmUYjMzDtydYL=7kxmtPrAEEU9U=a5XbMiFg@mail.gmail.com>
Organization: Bootlin
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_132646_990911_CB466260 
X-CRM114-Status: GOOD (  36.71  )
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
Content-Type: multipart/mixed; boundary="===============5517250972604654814=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5517250972604654814==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-GiwLARmS2nmhlZHes8Vi"


--=-GiwLARmS2nmhlZHes8Vi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-11-30 at 11:38 +0800, Chen-Yu Tsai wrote:
> On Fri, Nov 16, 2018 at 12:52 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > > Add the H5-specific system control node description to its device-tre=
e
> > > with support for the SRAM C1 section, that will be used by the video
> > > codec node later on.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 22 ++++++++++++++++++=
++
> > >  1 file changed, 22 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-h5.dtsi
> > > index b41dc1aab67d..c2d14b22b8c1 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > @@ -94,6 +94,28 @@
> > >         };
> > >=20
> > >         soc {
> > > +               system-control@1c00000 {
> > > +                       compatible =3D "allwinner,sun50i-h5-system-co=
ntrol";
> > > +                       reg =3D <0x01c00000 0x1000>;
> > > +                       #address-cells =3D <1>;
> > > +                       #size-cells =3D <1>;
> > > +                       ranges;
> > > +
> > > +                       sram_c1: sram@1d00000 {
> > > +                               compatible =3D "mmio-sram";
> > > +                               reg =3D <0x01d00000 0x80000>;
> >=20
> > I'll try to check this one tomorrow.
> >=20
> > I did find something interesting on the H3: there also seems to be SRAM=
 at
> > 0x01dc0000 to 0x01dcfeff , again mapped by the same bits as SRAM C1.
> >=20
> > And on the A33, the SRAM C1 range is 0x01d00000 to 0x01d478ff.
> >=20
> > This was found by mapping the SRAM to the CPU, then using devmem to pok=
e
> > around the register range. If there's SRAM, the first read would typica=
lly
> > return random data, and a subsequent write to it would set some value t=
hat
> > would be read back correctly. If there's no SRAM, a read either returns=
 0x0
> > or some random data that can't be overwritten.
> >=20
> > You might want to check the other SoCs.
>=20
> This range seems to contain stuff other than SRAM, possibly fixed lookup
> tables. Since this is entirely unknown, lets just stick to the known full
> range instead.

Thanks for investigating all this!

I also conducted some tests and found that the H5 has its SRAM C1
(marked as SRAM C in the manual) at 0x18000. However for the A64, SRAM
C1 gets mapped to 0x1D00000. There is also SRAM C at 0x18000 but this
one seems unrelated to the VPU and only used by DE2 (as already
described in the A64 dt).

I share your conclusion that there seems to be more than SRAM in there.
Testing with devmem write/read on the start address was reliable as a
test, but some chunks in the range did not behave like SRAM (not the
same value read).

I agree that we should keep the known full range as there are lots of
unknowns here.

Cheers,

Paul

> ChenYu
>=20
> > > +                               #address-cells =3D <1>;
> > > +                               #size-cells =3D <1>;
> > > +                               ranges =3D <0 0x01d00000 0x80000>;
> > > +
> > > +                               ve_sram: sram-section@0 {
> > > +                                       compatible =3D "allwinner,sun=
50i-h5-sram-c1",
> > > +                                                    "allwinner,sun4i=
-a10-sram-c1";
> > > +                                       reg =3D <0x000000 0x80000>;
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > >                 mali: gpu@1e80000 {
> > >                         compatible =3D "allwinner,sun50i-h5-mali", "a=
rm,mali-450";
> > >                         reg =3D <0x01e80000 0x30000>;
> > > --
> > > 2.19.1
> > >=20
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-GiwLARmS2nmhlZHes8Vi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlwBOooACgkQ3cLmz3+f
v9H5cAf/Y4PYNTtU8z80K7NkG2UKbqz1WClI50UXcS49VGXlbAN+Q4scGjd2bzML
JMgd3lpH5sCqmMR0B3sZBe1H7qPuTQQwZ6h94h8aULW7BppqjT3X2FGuaOr5TT5l
0OL4Rlsj1RzKB8vFn3prDtwOlDanSjq1Akrf8F1pNs6CH4wmtVhEOtQq6Pzgb6RY
KQZrD9Ahyh01YQd2eWvmCEEwQKMbS61uFRWSKbi6PPqCn9NjkyzYYB5MhDOQ2Rl5
OtLiDpcTMR3GwpbfNczbUsy3C/Ad8Yo0iZvVMoqKgZpLbqyXkT4r5qIcNc80uY8u
LEep4QqRU2g3pCM3AY0wvpAfzidZgg==
=LKPm
-----END PGP SIGNATURE-----

--=-GiwLARmS2nmhlZHes8Vi--



--===============5517250972604654814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5517250972604654814==--


