Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B84C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:24:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34004206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PmcAuakj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34004206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=/L9q1pxjdMrb3cXECbVdyvCWZM3DGvfRVy4dAPVX3iA=; b=Pmc
	AuakjdmovlGkpZDLiTU3m7QTKUdrJCwQceyCTBfa6UxKRBkYoEgGPzb8RUl9EqmCtADIANNToc3yo
	ZXNYRpFuYb6celDSTvZlVq/rIbCqwilpcTwik/W8Hx+wYYWxEO37Ksks/9aYhIJ2j3XSlAs7/hpYX
	tifxacNGF+W3tiYbKpB3r289oYw2Q/pyNPpPNeKdD8TUStd0EHG73+ayovbTBT88t8vJ2sTasJGyh
	+vzvMally2M8K9icSeS5g4P9psvh/h5/gZ9QxKoszaJ45mnd2qDiPI9e08ohQ6s2fdsOOVEat4ks6
	WenEXWf1fSUFwWUfkwbkeBBcurx3UGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3KH-0002dL-0d; Fri, 08 Feb 2019 10:24:05 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3KC-0002be-7D
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:24:02 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AE72F20008;
 Fri,  8 Feb 2019 10:23:54 +0000 (UTC)
Date: Fri, 8 Feb 2019 11:23:54 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner H3/H5 changes for 5.1
Message-ID: <20190208102354.vwygnt2wevbjntwy@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_022400_411961_D4ABBBFB 
X-CRM114-Status: GOOD (  11.10  )
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
Content-Type: multipart/mixed; boundary="===============2588018355004860788=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2588018355004860788==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bvvv56qasxebodmq"
Content-Disposition: inline


--bvvv56qasxebodmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd, Kevin, Olof,

Please pull the following PR for the next merge window.

Thanks!
Maxime

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunx=
i-h3-h5-for-5.1

for you to fetch changes up to 0d15a7397ae7e6b03c7024e393051b79b215fed0:

  arm64: dts: allwinner: h5: libretech-all-h3-cc: Mark eMMC HS-DDR 3.3V cap=
able (2019-02-06 13:20:36 +0100)

----------------------------------------------------------------
Allwinner H3 and H5 changes for 5.1

Our usual round of DT changes shared between arm and arm64.

We have a bunch of changes for board, improving the eMMC support on the H5
variant of the All-H3-CC, enabling HDMI and reworking the CSI driver.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: dts: sunxi: h3/h5: Drop A31 fallback compatible for CSI controll=
er
      arm64: dts: allwinner: h5: libretech-all-h3-cc: Mark eMMC HS-DDR 3.3V=
 capable

Corentin Labbe (1):
      ARM: dts: sun8i-h3: nanopi-m1-plus: enable HDMI

 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      | 25 ++++++++++++++++++=
++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  3 +--
 .../allwinner/sun50i-h5-libretech-all-h3-cc.dts    |  4 ++++
 3 files changed, 30 insertions(+), 2 deletions(-)

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--bvvv56qasxebodmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF1YugAKCRDj7w1vZxhR
xX46AP9VeTA4BX+ixhqtPQpOl5KZsn+mAXqjtsZT/XeW4QGiBwD/euiKr5DKDP5K
CGLhiAgM6D7xlSp24G97HYAMmanT2gM=
=3kWd
-----END PGP SIGNATURE-----

--bvvv56qasxebodmq--


--===============2588018355004860788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2588018355004860788==--

