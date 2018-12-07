Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72E9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:44:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B759820882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VDmOz/OT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B759820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=jXNWfphG1V/P0IOUiHKn0oV/qqC6PBYLlye4qv3Uf44=; b=VDm
	Oz/OT5kM8y2+WXKGHFsLclgHr5EjLxDgp0KKyrptUy1eJTjAYJpYndK+wVdgiOse1lR43Zz86zHRz
	RH6KX1ClxVsYnNKV14Kpjmz21h4fdUGgt9kXf1fDGNlHsV4YFVwdB3dEHc0Mk8SLX/VwXqVtct0K+
	80k8GRDZ7FGym9f7Ylv6ZnSUUttIT77O+9V9lWTvGDjfN8rOmrxtv3eiTeTUl/kWSvMBkx4d3bDRV
	zOMauJEPEtjPMW6mUJCUNYhIe+by49KDvHBCT2P5cl/SYvCFG/oZjRLxe8YpLkHggelMi+/3Ut32o
	Gj2OR/aPU3hpHIabltrO/FXKOnbw4LQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHMg-0006QZ-47; Fri, 07 Dec 2018 14:44:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHMc-0006Py-Ez
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:44:24 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 38CEA20726; Fri,  7 Dec 2018 15:44:11 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 078422037D;
 Fri,  7 Dec 2018 15:44:01 +0100 (CET)
Date: Fri, 7 Dec 2018 15:44:01 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.21
Message-ID: <20181207144401.mfrfb2qj2sdno2at@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_064422_773373_F5DDD215 
X-CRM114-Status: GOOD (  16.13  )
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
Content-Type: multipart/mixed; boundary="===============1925333426617798095=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1925333426617798095==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sxgi2pv5iyz7jjgb"
Content-Disposition: inline


--sxgi2pv5iyz7jjgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd, Kevin, Olof,

Please pull the following changes for the next merge window.

ThankS!
Maxime

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunx=
i-dt64-for-4.21

for you to fetch changes up to 44ff3cafcd7f413e7710a58ac40cfdc3a9380097:

  arm64: dts: allwinner: a64: Fix up RTC device node and clock references (=
2018-12-07 10:23:39 +0800)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.21

Our usual set of arm64 DT changes, with the biggest additions being:
  - Support for the video decoding engine in the A64
  - Support for the audio codec in the A64
  - USB Support in the H6
  - HDMI Support in the H6
  - EMAC Support in the H6
  - New board: Orange Pi Lite2

----------------------------------------------------------------
Chen-Yu Tsai (5):
      arm64: dts: allwinner: h6: orangepi: Add board-wide 5V regulator
      arm64: dts: allwinner: h6: orangepi: Enable USB 2.0 host and OTG ports
      arm64: dts: allwinner: h6: orangepi: Add device nodes for LEDs
      arm64: dts: allwinner: a64: bananapi-m64: Enable audio codec
      arm64: dts: allwinner: a64: Fix up RTC device node and clock referenc=
es

Icenowy Zheng (7):
      dt-binding: dwmac-sun8i: add H6 compatible string (w/ A64 fallback)
      arm64: allwinner: h6: add EMAC device nodes
      arm64: allwinner: h6: add support for the Ethernet on Pine H64
      arm64: dts: allwinner: h6: add USB2-related device nodes
      arm64: dts: allwinner: h6: add USB Vbus regulator for Pine H64
      arm64: dts: allwinner: h6: enable USB2 on Pine H64
      arm64: dts: allwinner: h6: fix EMAC compatible string sequence

Jagan Teki (4):
      arm64: allwinner: h6: Add common orangepi nodes into dtsi
      arm64: allwinner: h6: Add OrangePi Lite2 initial support
      dt-bindings: gpu: mali-utgard: Add compatible for A64 Mali
      arm64: dts: allwinner: a64: Add device node for Mali-400 GPU

Jernej Skrabec (2):
      arm64: dts: allwinner: h6: Add HDMI pipeline
      arm64: dts: allwinner: h6: Enable HDMI output on Pine H64 board

Oskari Lemmela (2):
      arm64: dts: allwinner: axp803: add AC and battery power supplies
      arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies

Paul Kocialkowski (2):
      arm64: dts: allwinner: a64: Add support for the SRAM C1 section
      arm64: dts: allwinner: a64: Add Video Engine node

Vasily Khoruzhick (5):
      arm64: dts: allwinner: add backlight regulator for Pinebook
      arm64: dts: allwinner: a64: add nodes necessary for analog sound supp=
ort
      arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
      arm64: dts: allwinner: a64: enable sound on Pinebook
      arm64: dts: allwinner: a64: pinebook: enable power supplies

 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |   5 +
 .../devicetree/bindings/net/dwmac-sun8i.txt        |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi          |  33 +++
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  29 ++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  27 ++
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     |  67 +++++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  34 +++
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      |   4 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 123 +++++++-
 .../dts/allwinner/sun50i-h6-orangepi-lite2.dts     |  11 +
 .../dts/allwinner/sun50i-h6-orangepi-one-plus.dts  | 140 +---------
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi     | 210 ++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      |  82 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       | 311 +++++++++++++++++=
++++
 15 files changed, 924 insertions(+), 154 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.=
dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sxgi2pv5iyz7jjgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAqHMQAKCRDj7w1vZxhR
xTHjAP9tb8AAGNOpxaKm6g0TVw1jWbxtbkmYDgC6nmZuYKY1qAEA2YHRS1fhdRR3
0q3w+DeoIOtCqi6jhnttt8wU0W4kHgs=
=JPoZ
-----END PGP SIGNATURE-----

--sxgi2pv5iyz7jjgb--


--===============1925333426617798095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1925333426617798095==--

