Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51494C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:36:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1851F2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XkBPQ6LQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1851F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iJ0NQB6hYIV969+oPGbRALmseu43EvU5hVz3U/kFhdM=; b=XkBPQ6LQcMTY6UlZY/dLtJZCG
	itU98XuEDPqsvJB8cJnKPmfN3G/AIGSVLdD2N2+GNdKCmUREGs7RBBWh/jXwcCEE+zh/PeeQkOqbx
	BSU5EhFT0dx/+ac6EexoRzkZnxriTmyU9LoEKmpB86seCVdhBRqU3OZ50I1V0hiV6KcvdyMX56F+j
	PaVa+Rlysi2og8FdLzBUFzkT1L4oG34DV1xa+lAqN7ZJ8fwhWInZ5U7f2OOUw/M2+vvYCtSMqZx3s
	I6AxYvRXsxb46qMfPzktMq7eW+WDil4BQG8yUTCIgVTbwF/QvHK4/jdCuKpbuLNsXF8SmEilNf4s1
	XOaZ4w3DA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCk8-0006Yv-Em; Tue, 04 Dec 2018 15:36:12 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCk4-0006Uc-Ua
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:36:10 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9190D2071D; Tue,  4 Dec 2018 16:35:54 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3790320D17;
 Tue,  4 Dec 2018 16:35:20 +0100 (CET)
Date: Tue, 4 Dec 2018 16:35:20 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 21/21] drm/sun4i: frontend: Add A20-specific
 device-tree compatible and quirks
Message-ID: <20181204153520.7rpy4awl46zteozl@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-22-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181204142218.16284-22-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_073609_118118_8CC28A5A 
X-CRM114-Status: GOOD (  11.92  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 linux-sunxi@googlegroups.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4947300570086746024=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4947300570086746024==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="22apitpo3rwet6up"
Content-Disposition: inline


--22apitpo3rwet6up
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:18PM +0100, Paul Kocialkowski wrote:
> This adds the appropriate device-tree compatible and quirk data for
> hooking frontend support for the A20. It supports the FIR coefficients
> ready bit but not the access control bit. It also takes different phase
> values than the A33 for these coefficients.
>=20
> The compatible is already used in the A20 device-tree and already
> documented in the device-tree bindings.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--22apitpo3rwet6up
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAaeuAAKCRDj7w1vZxhR
xQ2SAPsFkMAlYBgCPdigdMAaUHoHT9cCqpfOfNEdPV7S2n1drQEAtzunSvcSs5vM
wSwImEUFEouy7IkUP+NdoTCaHEQiAwg=
=3HVg
-----END PGP SIGNATURE-----

--22apitpo3rwet6up--


--===============4947300570086746024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4947300570086746024==--

