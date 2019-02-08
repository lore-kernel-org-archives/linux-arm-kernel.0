Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B70C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:31:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9556820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DHVNhUU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9556820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9VKR27rYlowLORwuD4HTTK0f4U8A5qE5DYE+BIXqGnA=; b=DHV
	NhUU49OtFxEj/xsJvOxOGgr/JLP4y7nh1lSrwdUjlpAyfKi4n0zut/wTjYuS9P6q/P4iQRIVPIb2v
	NlkfvwmbffZ1bJiLdbRm8ISqkEP0fBgCi7VRExooqtkrk1EJXJg7//jWzX/gCtsF3y2A9/Tgihc/B
	dAyjrrE1fPzTVPSWShsxQd+d7XvWMRaS3l4kAymYI8KK8DXiohYChjXilPePS8RgSNlsUbqIrr3eg
	S5ajMo8oj1N/4LwTH+I0xuXqNGJSg5lySU3+/xcG9GQDyndtcF8VBDuPuOZxsUsVaNNVfeupP56cI
	3hDSx1HZcCeE+hhqJUqPyIG+ZLqKQ2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3Rg-0006tS-HP; Fri, 08 Feb 2019 10:31:44 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3Rc-0006sk-Qp
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:31:42 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B2EE1E0007;
 Fri,  8 Feb 2019 10:31:33 +0000 (UTC)
Date: Fri, 8 Feb 2019 11:31:33 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner DT changes for 5.1, take 2
Message-ID: <20190208103133.4jomhfzbqphbxkm6@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_023141_022931_B46077FC 
X-CRM114-Status: GOOD (  11.85  )
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
Content-Type: multipart/mixed; boundary="===============5268626355282843891=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5268626355282843891==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="22gzyjavm6xbhley"
Content-Disposition: inline


--22gzyjavm6xbhley
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd, Kevin, Olof,

Please pull the following PR for the next merge window.

Thanks!
Maxime

The following changes since commit 55533921301e83162584f87fe571545056d03e09:

  ARM: dts: sun8i-a23-q8: Set compatible string for LCD panel (2019-01-25 1=
0:43:20 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunx=
i-dt-for-5.1-2

for you to fetch changes up to 185401e1dd1656f8a1dff42bb2e4863493fd51f0:

  ARM: dts: sun8i: a83t: Enable PMIC power supplies on various boards (2019=
-02-07 16:51:13 +0100)

----------------------------------------------------------------
Allwinner DT changes for 5.1, take 2

Our usual bunch of DT changes for the Allwinner arm SoCs:
  - LCD support for the Q8 A13 tablets
  - GMAC support for the A80
  - PMIC power supplies for the A83t

----------------------------------------------------------------
Chen-Yu Tsai (14):
      ARM: dts: sun5i: Add backlight GPIO for reference design tablet
      ARM: dts: sun5i: q8-tablet: Move panel properties to correct node lev=
el
      ARM: dts: sun5i: q8-tablet: Add LCD Panel enable GPIO
      ARM: dts: sun5i: q8-tablet: Add LCD Panel power supply
      ARM: dts: sun5i: q8-tablet: Use bananapi,s070wv20-ct16 panel compatib=
le
      ARM: dts: sun9i: a80-optimus: Add node for AXP809's unused dc1sw regu=
lator
      ARM: dts: sun9i: a80-optimus: Add GPIO pin-bank regulator supplies
      ARM: dts: sun9i: cubieboard4: Add GPIO pin-bank regulator supplies
      ARM: dts: sun9i: Add GMAC clock node
      ARM: dts: sun9i: Add A80 GMAC gigabit ethernet controller node
      ARM: dts: sun9i: Add A80 GMAC RGMII pinmux setting
      ARM: dts: sun9i: a80-optimus: Enable GMAC
      ARM: dts: sun9i: cubieboard4: Enable GMAC
      ARM: dts: sun8i: a83t: Enable PMIC power supplies on various boards

 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts          |  7 ++-
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |  2 +-
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |  4 ++
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |  8 +++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |  8 +++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        | 44 ++++++++++++++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            | 44 ++++++++++++++-
 arch/arm/boot/dts/sun9i-a80.dtsi                   | 65 ++++++++++++++++++=
++++
 8 files changed, 172 insertions(+), 10 deletions(-)

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--22gzyjavm6xbhley
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF1ahQAKCRDj7w1vZxhR
xTdbAQCkias2BQKHlc1M16iqNYztcIU33wYG28KzNEuElKSCEAEA/mQKvViMdUm+
eNM50+i04A1qaVmM8/R4C3jTfUKKfAo=
=L0Uv
-----END PGP SIGNATURE-----

--22gzyjavm6xbhley--


--===============5268626355282843891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5268626355282843891==--

