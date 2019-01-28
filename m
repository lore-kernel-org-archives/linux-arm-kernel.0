Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B587AC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:03:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878BF2171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XRRx0caW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878BF2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D2C1t8rubQ8OF2QiHqFSP2ANxgaoYgjUE16lNEZXfD8=; b=XRRx0caW2QifziJyDEeppS5MJ
	KRJcew/cRcaxo3oL/BSHFawMh/AlLLtuLCgKIZp08Vr1BQ2gRSX5yTgt4spccFNvhd5TiVTpyMIJ8
	5tWVi8fDZ+HT8GRuEuTo2Me8eE1e4BWzprMB+BKuoV0mLDI9NhQJ6KbzbGOsD4kVPWWa5YOk5IPE9
	5fUMIZuEg9yLz+c4fxHRyDHbg41ghgvwz0pLcJVyPb3feQcF/AutL/3GwGl5XZmvi2Jjqf0dx+edt
	DdFNoPre+m7HXo/i1RRchKwv2nbvKWaJvMmxQh+Ga0pZcUooXSMnXL6S4ZSRPEoIlCScS5ZxXOW9K
	qe7J/aLcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4h4-0004L2-LT; Mon, 28 Jan 2019 11:03:10 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4gx-0004KI-PU
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:03:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5391A20746; Mon, 28 Jan 2019 12:03:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 16E8720654;
 Mon, 28 Jan 2019 12:02:52 +0100 (CET)
Date: Mon, 28 Jan 2019 12:02:52 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v8 3/5] arm64: dts: allwinner: a64: Add A64 CSI controller
Message-ID: <20190128110252.n3en2wu5izoyfy5b@flea>
References: <20190128085847.7217-1-jagan@amarulasolutions.com>
 <20190128085847.7217-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20190128085847.7217-4-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_030306_928528_573D9CD2 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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
 Michael Trimarchi <michael@amarulasolutions.com>, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============7330282414913455912=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7330282414913455912==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wqhrlsjxt33kaa7a"
Content-Disposition: inline


--wqhrlsjxt33kaa7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 02:28:45PM +0530, Jagan Teki wrote:
> Add dts node details for Allwinner A64 CSI controller.
>=20
> A64 CSI has similar features as like in H3, but the CSI_SCLK
> need to update it to 300MHz than default clock rate.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wqhrlsjxt33kaa7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7hXAAKCRDj7w1vZxhR
xfC+AQDSxMHZCT1ZjEIivFGN/2VyGG0ZpujqU7/G+QOB0x3JVQEAxvEvwWuocfHQ
Pt5jI1tfMJK4guFpYyLqqBA7r+SgpQE=
=B3Ir
-----END PGP SIGNATURE-----

--wqhrlsjxt33kaa7a--


--===============7330282414913455912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7330282414913455912==--

