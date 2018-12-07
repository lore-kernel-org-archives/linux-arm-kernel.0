Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD34BC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:26:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7302420837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ea9m1Dpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7302420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Dd+GckK4Isfo0O4vGGpW89fsUT/yeXQcoi9N+v4OIpo=; b=ea9
	m1Dpw4M/guiGm/5kOYEDfnsdHQ4t+QJ1puP2p/hNjjk77/dQYDYWybG3XWbNxFjKGVfK0Tf9CaT8e
	SUZxG61VPSwHwxG6K8BepDoUFbJ/ZDv9d9QSbHHh1r4hTEgM6oD9DzuZO+pIFzoom9VYOhiz6IsuC
	KRCvf1k8cxEese7VWQwrn5oDN+KF4MBPIlasqKM7matMuyNdNPq2iAXVbJPFfpgR5JDwEix+cRw7k
	pUrYDnQ6OrSscoqVBxK8Ol4Pc8ypY1j6FDZQ/hoMe2PwjQuWFr35nuaC4CTFiAVuSvyoN0mht2axz
	bYJ66bZaPyBVTQCNo5kJIvtxuaSWJFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVH55-0006lV-Tt; Fri, 07 Dec 2018 14:26:15 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVH4u-0006X2-JL
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:26:10 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4CC2320745; Fri,  7 Dec 2018 15:25:53 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1E1BA20711;
 Fri,  7 Dec 2018 15:25:53 +0100 (CET)
Date: Fri, 7 Dec 2018 15:25:53 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner core changes for 4.21
Message-ID: <20181207142553.rr6yzhddwz5epdud@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_062605_302916_52BD30EC 
X-CRM114-Status: GOOD (  11.05  )
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
Content-Type: multipart/mixed; boundary="===============2940733625632473835=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2940733625632473835==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rpnotehwkhuud7tm"
Content-Disposition: inline


--rpnotehwkhuud7tm
Content-Type: text/plain; charset=us-ascii
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
i-core-for-4.21

for you to fetch changes up to dabfc8364ca76c8f8a24e8b5efc348869ac35d79:

  dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt (2018-12-05 11:58:=
41 +0100)

----------------------------------------------------------------
Allwinner core changes for 4.21

A few patches to enable a new Allwinner SoC based on an armv5 CPU.

----------------------------------------------------------------
Mesih Kilinc (4):
      ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
      dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
      ARM: sunxi: add Allwinner ARMv5 SoCs
      dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt

 Documentation/devicetree/bindings/arm/sunxi.txt       |  1 +
 .../devicetree/bindings/watchdog/sunxi-wdt.txt        |  1 +
 arch/arm/mach-sunxi/Kconfig                           | 19 +++++++++++++++=
+++-
 arch/arm/mach-sunxi/sunxi.c                           |  9 +++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rpnotehwkhuud7tm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAqC8QAKCRDj7w1vZxhR
xUeZAQDr3o4yAPr7eKG8nQhuVN3LfO4U79/MIRAiS9jrz5H0cwD/RIyp/Hwl6ImE
85NXsN/1pA038GRgdFcVzoEIts7ljQ8=
=8oWi
-----END PGP SIGNATURE-----

--rpnotehwkhuud7tm--


--===============2940733625632473835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2940733625632473835==--

