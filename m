Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2750C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:35:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E49120857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMK+AGFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E49120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YTmcTp8R0qW+1sT9Z6FKmm480YXm21GoEsNMbsnEfew=; b=BMK
	+AGFRNtds6f8voSx9QRNe0cbreZazOcBR6OSccQFjpngzHaFG1OdYPRb7wcf4zopqj3o5X8ciE4NI
	Sa6YB1zbWxpGZ/lfFn5LXSCMHgQ0KSuSRlH54uakLf6hkBOxOgw9JvrAISzhrwZcLocLjkUWX8u5o
	ugw/+YEoFyY/2BDRi6dLkVUY5eDEzEu8ITWUoMLR4T6A9B4UT/VqkaPWjSVscYS6NZzrLvKtxHKdy
	LfEm1b6lchIqv1+VXpGh54cQlMPMEXiPIciKTU2XmgbsDYt8vctqVbciB9adSj9THk+RyP10sR6xK
	QSCviEZhEcyOVBOpH9Dze58h4vnsC8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3VF-0000cs-2g; Fri, 08 Feb 2019 10:35:25 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3VA-0000cP-Ky
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:35:22 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C385F1BF212;
 Fri,  8 Feb 2019 10:35:07 +0000 (UTC)
Date: Fri, 8 Feb 2019 11:35:07 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner arm64 defconfig changes for 5.1
Message-ID: <20190208103507.mok75mo2gef3bjas@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_023520_890678_5BA22674 
X-CRM114-Status: GOOD (  10.25  )
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
Content-Type: multipart/mixed; boundary="===============7242624610727869614=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7242624610727869614==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yxa3quqbl5zd5m2g"
Content-Disposition: inline


--yxa3quqbl5zd5m2g
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
i-config64-for-5.1

for you to fetch changes up to 2345ec2061ee1f0e67b437a3ba54367e7a2ab6cc:

  arm64: defconfig: Enable SUN6I Camera sensor interface (2019-02-01 13:50:=
09 +0100)

----------------------------------------------------------------
Allwinner arm64 defconfig changes for 5.1

Two new additions to arm64's defconfig to support A64 boards.

----------------------------------------------------------------
Jagan Teki (2):
      arm64: defconfig: Enable I2C_GPIO
      arm64: defconfig: Enable SUN6I Camera sensor interface

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yxa3quqbl5zd5m2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF1bWwAKCRDj7w1vZxhR
xcMeAQDy1v7yHF5hehjHZQBtWMUSB90E6loxhhjZgdW+MzfFagD/fe8snHJDUMsn
690Zv7sg91P8xxriNr89kZarcnOYZAE=
=QRhH
-----END PGP SIGNATURE-----

--yxa3quqbl5zd5m2g--


--===============7242624610727869614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7242624610727869614==--

