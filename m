Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3725C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DB72184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TGx3kEpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DB72184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s8YLLadBn1q91yNMweQgiPB7WXXjsx7/F2WIoSMwIjU=; b=TGx3kEpqk3m/f1yWrIgZVIFUH
	zxQhEHPWNFtGLGoXsvOR/lMYXQqLDk57ue5PrbbNuf0AARvn/0W45y90PUwUtk1HXEjsXQoXlVbEa
	7cH+jT2KOIPx04p7pnnWLsTHz6YQlEQ//kq6i3RdiECmGFdnJR83ld15Aa4Zt3vvt30o495Tdn2Xh
	SKGbS0Ekpr0hxkA/8Js0gHEy5/MmZuB1MWJj1dzUiRp+KiDQQjCQoKXfXFuect17z7H8ZqR8cs2FY
	P1dJyToEnnQNEyHmVZkSVchGkYVDXxJcnoo+E+eaDe0N0yBn5c9tUfrpOjXvj1cPMEEIAKM0MA48q
	3mQsO6J+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomei-0008Vm-Cu; Wed, 30 Jan 2019 09:59:40 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomeT-0008PW-TS
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:59:29 +0000
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B8E951BF20A;
 Wed, 30 Jan 2019 09:59:12 +0000 (UTC)
Date: Wed, 30 Jan 2019 10:59:12 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 10/10] arm64: dts: allwinner: h5: Add CPU Operating
 Performance Points table
Message-ID: <20190130095912.yq6anxqnczi6btpv@flea>
References: <20190130084203.25053-1-wens@csie.org>
 <20190130084203.25053-11-wens@csie.org>
 <20190130092927.x65ihy3je5n6324w@flea>
 <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_015926_321372_E715FA12 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Sergey Matyukevich <geomatsi@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Emmanuel Vadot <manu@freebsd.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============9171081320780209239=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============9171081320780209239==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wfmp6bpod2cyevow"
Content-Disposition: inline


--wfmp6bpod2cyevow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 05:41:16PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jan 30, 2019 at 5:29 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Wed, Jan 30, 2019 at 04:42:03PM +0800, Chen-Yu Tsai wrote:
> > >                       enable-method =3D "psci";
> > >                       clocks =3D <&ccu CLK_CPUX>;
> > >                       clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +                     operating-points-v2 =3D <&cpu_opp_table>;
> > > +                     #cooling-cells =3D <2>;
> > > +             };
> > > +     };
> > > +
> > > +     cpu_opp_table: opp_table {
> > > +             compatible =3D "operating-points-v2";
> > > +             opp-shared;
> > > +
> > > +             opp@408000000 {
> > > +                     opp-hz =3D /bits/ 64 <408000000>;
> > > +                     opp-microvolt =3D <1000000 1000000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@648000000 {
> > > +                     opp-hz =3D /bits/ 64 <648000000>;
> > > +                     opp-microvolt =3D <1040000 1040000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@816000000 {
> > > +                     opp-hz =3D /bits/ 64 <816000000>;
> > > +                     opp-microvolt =3D <1080000 1080000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@912000000 {
> > > +                     opp-hz =3D /bits/ 64 <912000000>;
> > > +                     opp-microvolt =3D <1120000 1120000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@960000000 {
> > > +                     opp-hz =3D /bits/ 64 <960000000>;
> > > +                     opp-microvolt =3D <1160000 1160000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@1008000000 {
> > > +                     opp-hz =3D /bits/ 64 <1008000000>;
> > > +                     opp-microvolt =3D <1200000 1200000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@1056000000 {
> > > +                     opp-hz =3D /bits/ 64 <1056000000>;
> > > +                     opp-microvolt =3D <1240000 1240000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@1104000000 {
> > > +                     opp-hz =3D /bits/ 64 <1104000000>;
> > > +                     opp-microvolt =3D <1260000 1260000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@1152000000 {
> > > +                     opp-hz =3D /bits/ 64 <1152000000>;
> > > +                     opp-microvolt =3D <1300000 1300000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> >
> > What is the frequency and voltage that U-Boot sets up?
>=20
> 1008 MHz, and whatever voltage the board design defaults to (typically
> the higher setting).
>=20
> > We've had the issue with the A33 that it's started at 1008MHz, with
> > the matching voltage, and ramping up the frequency to 1.2GHz on boards
> > without PMIC support would increase the frequency but not the voltage,
> > resulting in a brownout.
>=20
> Which is why I added the regulator to all boards before this patch. At
> least for Linux, once the regulator supply is described in the device
> tree, if the driver is missing, regulator_get_* and thus cpufreq should
> fail with -EPROBE_DEFER.
>=20
> Or we could drop the extra OPPs.

Ok, if you covered all of them then fine by me. For the whole series,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wfmp6bpod2cyevow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFF1bwAKCRDj7w1vZxhR
xbZhAP46JffbKB3rQtH3OZZp/Q8KDlrR+H9ZICzLbzMMU9z0rwEA15eZqCKQVZgW
jF6e24cIZ8zqdNsUMVB8SlklJRRa7wo=
=/pAR
-----END PGP SIGNATURE-----

--wfmp6bpod2cyevow--


--===============9171081320780209239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9171081320780209239==--

