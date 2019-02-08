Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268DCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:29:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CDF20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rgl9YAB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CDF20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=VRfOUhhXYAhIeHtqWe02/CTdnRvJGsV+MU8kd6wbtyg=; b=rgl
	9YAB0EJkueEsaTt0SIGR5v9ipf26GPDKgs2Retpoyw3e+GarW4H0CpXkUwUhbUf6WcSIhcFJq6MeI
	cy/k4z8xZwoMnc2fMjKvDt2PwZ1I+P8R4QBZbghK+3VZNkWVacmJ533sd6ARrNmV7GCEEz2x4M3Gw
	MNBVTVWVxQ1QwbjaeDJ2Yo1OgW8jK5ieKg+YkjvMRldI+HWlLPtKKahn1O0k1MZM82QDhQ7Huu9p1
	wLfPCAYDi4YAHRDcjk2PZPAkucVCQsjmzkjGLIXDCRlcT7t0bz0E9k7aYp7zqpDndh1mcF3L8h6Fi
	bMflQ7QHgOAGgk/GdfI1RD0lALM/rjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3Pf-0005L8-Kz; Fri, 08 Feb 2019 10:29:39 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3Pc-0005KO-GE
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:29:38 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E14D0C0017;
 Fri,  8 Feb 2019 10:29:33 +0000 (UTC)
Date: Fri, 8 Feb 2019 11:29:33 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner arm64 DT changes for 5.1, take 2
Message-ID: <20190208102933.3op53lsvppizl6b4@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_022937_326411_0504DDEE 
X-CRM114-Status: GOOD (  12.40  )
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
Content-Type: multipart/mixed; boundary="===============6086648831668071169=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6086648831668071169==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uwto22imimxlwsmz"
Content-Disposition: inline


--uwto22imimxlwsmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd, Kevin, Olof,

Please pull the following PR for the next merge window.

Thanks!
Maxime

The following changes since commit 55ec26d6a4241363fa94f15377ebd8f1116fbfd7:

  arm64: dts: allwinner: a64: Enable A64 timer workaround (2019-01-24 18:23=
:26 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunx=
i-dt64-for-5.1-2

for you to fetch changes up to a24270afa7f7ba800567a03ea9d34f500738e4c8:

  arm64: dts: allwinner: a64: Enable PMIC power supplies on various boards =
(2019-02-06 13:19:13 +0100)

----------------------------------------------------------------
Allwinner arm64 DT changes for 5.1, take 2

Our usual round of DT changes for the arm64 Allwinner SoCs:
  - Enabling of the various power supplies on most a64 boards
  - H6 SRAM controller support
  - A64 CSI support

----------------------------------------------------------------
Chen-Yu Tsai (2):
      arm64: dts: allwinner: h6: Move GIC device node fix base address orde=
ring
      arm64: dts: allwinner: a64: Enable PMIC power supplies on various boa=
rds

Harald Geyer (1):
      arm64: dts: allwinner: a64: teres-i: enable power supplies

Jagan Teki (1):
      arm64: dts: allwinner: a64: Add A64 CSI controller

Jernej Skrabec (2):
      dt-bindings: sram: sunxi: Add compatible for the H6 SRAM C1
      arm64: dts: allwinner: h6: Add support for the SRAM C1 section

 .../devicetree/bindings/sram/sunxi-sram.txt        |  1 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  8 +++++
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |  4 +++
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |  8 +++++
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  8 +++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  8 +++++
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      |  8 +++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 20 ++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       | 36 +++++++++++++++---=
----
 9 files changed, 90 insertions(+), 11 deletions(-)

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--uwto22imimxlwsmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF1aDQAKCRDj7w1vZxhR
xZQWAQCLJPquXsEZJ7FCHah6CxFnMNyxSg2SrM2plVD0QGflmgD/TUD06koAfakJ
GU426bEmB7Jws/g8mPy0a26sPoqJNQk=
=IqfC
-----END PGP SIGNATURE-----

--uwto22imimxlwsmz--


--===============6086648831668071169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6086648831668071169==--

