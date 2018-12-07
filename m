Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A5C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:54:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C5F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u6rpwKiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C5F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RBLqsexVHaR2iT1lJGGK8ihRFQpBv+keDx2Y5yVYbp8=; b=u6r
	pwKiT0HvOZOezhRjF/uyt09147Ht/XB3r9eXMtDGSGJy6fqqPF+rciphvJUpfci0je/qdAmL4moEh
	3Z7QSMSzh0zsb/VvR5OxYYWS0ttbaC1goAT7hKINNDE3eyKdzw4HlQeGlfTOC7n70SR4k2RaWOeXZ
	+s4v9OIu36ERMjdvvJHfMQnDt2vbkoSEqqbPIG4w5v9UDnTHKFGBrgFqk00c650qnJJR2bJ4rhh4Z
	YMnVXVRH1kK8QmeoWIgDhlda5pBwB0E4oHUKgJP8C5KYra/O9w1aSqCI5V2JCxgUlGihCG2WAYhGH
	c95cHOBl7vUtLC534zCmwXWu8LtFm6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHWM-0002qM-2G; Fri, 07 Dec 2018 14:54:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHWI-0002pp-28
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:54:23 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B19DB20726; Fri,  7 Dec 2018 15:54:10 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6D56020701;
 Fri,  7 Dec 2018 15:54:00 +0100 (CET)
Date: Fri, 7 Dec 2018 15:54:00 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner H3/H5 changes for 4.21
Message-ID: <20181207145400.7wazz6nyppbzgprk@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_065422_374768_2F79B443 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1662671027641314027=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1662671027641314027==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fpe5jeag2rbtfgfp"
Content-Disposition: inline


--fpe5jeag2rbtfgfp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd, Kevin, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunx=
i-h3-h5-for-4.21

for you to fetch changes up to 8be5b161bb3d07bc5a119dfe0285ec05d28202c9:

  arm64: dts: allwinner: h5: Add Video Engine node (2018-12-05 12:03:06 +01=
00)

----------------------------------------------------------------
Allwinner H3/H5 changes for 4.21

Our usual pull request with the changes shared between the H3 and H5 SoCs.

The major changes for this release are:
  - Addition of the video engine for the H5
  - H3 Camera support
  - New board: Emlid Neutis N5, Mapleboard MP130

----------------------------------------------------------------
Aleksandr Aleksandrov (2):
      dt-bindings: vendor-prefix: new vendor - Emlid
      arm64: dts: allwinner: new board - Emlid Neutis N5

Jonathan McDowell (1):
      ARM: dts: sun8i-h3: Add dts for the Mapleboard MP130

Jorik Jonker (1):
      ARM: dts: sun8i-h3: add sy8106a to orange pi plus

Myl=E8ne Josserand (1):
      ARM: dts: sun8i: Add the H3/H5 CSI controller

Paul Kocialkowski (4):
      ARM: dts: sun8i: h3: Fix the system-control register range
      arm64: dts: allwinner: h5: Add system-control node with SRAM C1
      ARM/arm64: dts: allwinner: Move H3/H5 syscon label over to soc-specif=
ic nodes
      arm64: dts: allwinner: h5: Add Video Engine node

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts    | 153 +++++++++++++++++=
++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  20 +++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   4 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  28 +++-
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../sun50i-h5-emlid-neutis-n5-devboard.dts         | 149 +++++++++++++++++=
+++
 .../dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi   |  61 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |  33 +++++
 10 files changed, 443 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5=
-devboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5=
=2Edtsi

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fpe5jeag2rbtfgfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAqJiAAKCRDj7w1vZxhR
xWTYAP0REMUfgiMb0e0MM2mFlsxcffyhFY3f5Bq8iLNYGwCbagEAgwQlIyWwzo7F
kt7PxetyCq59EU2yCKGPIZ5Ijt5Gpwc=
=Yp1K
-----END PGP SIGNATURE-----

--fpe5jeag2rbtfgfp--


--===============1662671027641314027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1662671027641314027==--

