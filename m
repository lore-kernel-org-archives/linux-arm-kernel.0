Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC3DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:39:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD7320837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qX0WES8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD7320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=8+onTOEYHLC4kR9Hv3pua3gYT7MDnbiOZK1PT5O3kUs=; b=qX0
	WES8m/Y2+T+FXQpqJ60G+FTEPjojkaLg521HpQjbikoQ+lXsoYbBSmCh1vmb70md9DukrrvYTIIp3
	tpSzkAh3G5HOodXgqDVM7Ej8n5bv6wtCrpXls2VfNFo1QeQXan+gNtaPm4IDhTAL70Cf8ZGzi2g+f
	Tr4BOJxPNzVLt2koe7XEqilKEnTC3RZe0JUCoHnxMF6P6oyC9Q8jIHxBjQ2EATl3CDQP1MpUfj81N
	O9jMQ8SfedqRFlihfUEPREttjeOSHENKvP1S51iM2wQ9/eR1ENXSRScSwJhf69ghVytEJ5bjq9fPl
	C5oGhdi1BEMqDa7BcdYlrv82eGsNEEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHHd-0003hk-AD; Fri, 07 Dec 2018 14:39:13 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHHZ-0003hB-Hg
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:39:12 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 38E1D20894; Fri,  7 Dec 2018 15:38:58 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id EAF0420711;
 Fri,  7 Dec 2018 15:38:47 +0100 (CET)
Date: Fri, 7 Dec 2018 15:38:48 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner DT changes for 4.21
Message-ID: <20181207143848.m4ti5c3ulxpjz5pf@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_063909_856378_6F6C8B68 
X-CRM114-Status: GOOD (  19.11  )
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
Content-Type: multipart/mixed; boundary="===============4594725745865456008=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4594725745865456008==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qbntqnyf26py6ltl"
Content-Disposition: inline


--qbntqnyf26py6ltl
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
i-dt-for-4.21

for you to fetch changes up to 5719ac19fc32d892434939c1756c2f9a8322e6ef:

  ARM: dts: sunxi: Fix PMU compatible strings (2018-12-07 15:34:24 +0100)

----------------------------------------------------------------
Allwinner DT changes for 4.21

This is a quite big pull request this time, with a huge number of changes
(and patches) due to us fixing the vast majority of the DTC warnings our DT
had.

We also have a bunch of other good, more meaningful, changes:
  - Support for the new Allwinner T3 (rebranded R40) and f1c100s (armv5)
    SoCs
  - AXP803 PMIC AC Power supply support
  - Rework of the oscillators tree
  - Two new boards: the t3-cqa3t-bv3 and Lichee Pi Nano

Plus a few enhancements here and there.

----------------------------------------------------------------
Chen-Yu Tsai (6):
      ARM: dts: sun8i: a33: Drop audio codec oversampling rate to 128 fs
      ARM: dts: sunxi: h3/h5: Add clock accuracy for external oscillators
      ARM: dts: sun8i: r40: Add clock accuracy for external oscillators
      ARM: dts: sun8i: a23/a33: Fix up RTC device node
      ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references
      ARM: dts: sun8i: r40: Add RTC device node

Hao Zhang (2):
      Documentation: ARM: sunxi: Add Allwinner SoC T3.
      ARM: dts: sun8i: Add board dts file for t3-cqa3t-bv3.

Maxime Ripard (67):
      ARM: dts: sun4i: Fix gpio-keys warning
      ARM: dts: sun4i: Fix HDMI output DTC warning
      ARM: dts: sun5i: Change framebuffer node names to avoid warnings
      ARM: dts: sun5i: Change clock node names to avoid warnings
      ARM: dts: sun5i: Remove skeleton to avoid warnings
      ARM: dts: sun5i: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun5i: Remove redundant interrupt-controller
      ARM: dts: sun5i: Change LRADC node names to avoid warnings
      ARM: dts: sun5i: Remove all useless pinctrl nodes
      ARM: dts: sun5i: Remove card detect pull-up
      ARM: dts: sun5i: Change pinctrl nodes to avoid warning
      ARM: dts: sun5i: a10s: Fix HDMI output DTC warning
      ARM: dts: sunxi: Change default CMA pool node name
      ARM: dts: sunxi: Remove the CMA node label
      ARM: dts: sun5i: Remove underscores from nodes names
      ARM: dts: sunxi: Change LRADC node names to avoid warnings
      ARM: dts: sun5i: A10s: Remove empty SRAM node
      ARM: dts: sun5i: Provide default muxing for relevant controllers
      ARM: dts: sun6i: Remove skeleton and memory to avoid warnings
      ARM: dts: sun6i: Change framebuffer node names to avoid warnings
      ARM: dts: sun6i: Change clock node names to avoid warnings
      ARM: dts: sun6i: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun6i: Change LRADC node names to avoid warnings
      ARM: dts: sun6i: Remove all useless pinctrl nodes
      ARM: dts: sun6i: Remove card detect pull-up
      ARM: dts: sun6i: Remove redundant MMC pinmux tuning
      ARM: dts: sun6i: Change pinctrl nodes to avoid warning
      ARM: dts: sun6i: Remove underscores from nodes names
      ARM: dts: sun6i: colombus: Change i2c node name to avoid warnings
      ARM: dts: sun6i: Provide default muxing for relevant controllers
      ARM: dts: sun7i: Remove skeleton and memory to avoid warnings
      ARM: dts: sun7i: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun7i: Change clock node names to avoid warnings
      ARM: dts: sun7i: Change framebuffer node names to avoid warnings
      ARM: dts: sun7i: Remove all useless pinctrl nodes
      ARM: dts: sun7i: Remove card detect pull-up
      ARM: dts: sun7i: Change LRADC node names to avoid warnings
      ARM: dts: sun7i: Remove gpio-keys warnings
      ARM: dts: sun7i: Change pinctrl nodes to avoid warning
      ARM: dts: sun7i: Split the RTS and CTS pins out of the UART nodes
      ARM: dts: sun7i: som204: Use the UART3 TX and RX pin group
      ARM: dts: sun7i: Remove underscores from nodes names
      ARM: dts: sun7i: Fix HDMI output DTC warning
      ARM: dts: sun7i: Provide default muxing for relevant controllers
      ARM: dts: sun7i: Remove redundant MMC pinmux tuning
      ARM: dts: sun7i: lamobo-r1: Remove unused address-cells/size-cells
      ARM: dts: sun8i: a23/a33: Remove skeleton and memory to avoid warnings
      ARM: dts: sun8i: a23/a33: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun8i: a23/a33: Fix OPP DTC warnings
      ARM: dts: sun8i: a23/a33: Remove unused address-cells/size-cells
      ARM: dts: sun8i: a23/a33: Remove leading zeros from unit-addresses
      ARM: dts: sun8i: a23/a33: Change framebuffer node names to avoid warn=
ings
      ARM: dts: sun8i: a23/a33: Remove redundant MMC pinmux tuning
      ARM: dts: sun8i: a23/a33: Remove all useless pinctrl nodes
      ARM: dts: sun8i: a23/a33: Change LRADC node names to avoid warnings
      ARM: dts: sun8i: a23/a33: Reorder the pin groups
      ARM: dts: sun8i: a23/a33: Remove card detect pull-up
      ARM: dts: sun8i: a23/a33: Change pinctrl nodes to avoid warning
      ARM: dts: sun8i: a23/a33: Remove underscores from nodes names
      ARM: dts: sunxi: reference: Move the muxing back to the common DTSI
      ARM: dts: sun8i: a23/a33: Provide default muxing for relevant control=
lers
      ARM: dts: sun8i: BPI-M2M: Remove i2c nodes
      ARM: dts: sun8i: h3: Remove leading zeros from unit-addresses
      ARM: dts: sun8i: v3s: Change LRADC node names to avoid warnings
      ARM: dts: sun8i: v3s: Change pinctrl nodes to avoid warning
      ARM: dts: sun8i: v3s: Provide default muxing for relevant controllers
      ARM: dts: sun8i: v3s: Remove skeleton and memory to avoid warnings

Mesih Kilinc (2):
      ARM: dts: suniv: add initial DTSI file for F1C100s
      ARM: dts: suniv: Add device tree for Lichee Pi Nano

Olliver Schinagl (1):
      ARM: dts: sun7i: set proper lradc vref on OLinuXino Lime2

Ondrej Jirman (1):
      ARM: dts: sun8i-a83t-tbs-a711: Change MMC0 bus-width to 4

Oskari Lemmela (1):
      ARM: dts: axp81x: add AC power supply subnode

Paul Kocialkowski (2):
      ARM: dts: sun8i: a33: Remove unnecessary reserved memory node
      ARM: dts: sun8i: h3: Remove unnecessary reserved memory node

Rob Herring (1):
      ARM: dts: sunxi: Fix PMU compatible strings

Viresh Kumar (1):
      ARM: dts: sunxi: Add all CPUs in cooling maps

 Documentation/devicetree/bindings/arm/sunxi.txt    |   3 +-
 Documentation/devicetree/bindings/media/cedrus.txt |   2 +-
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/axp81x.dtsi                      |   5 +
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |   2 -
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |   2 -
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   2 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |  14 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |  25 +--
 arch/arm/boot/dts/sun5i-a10s-mk802.dts             |  29 +--
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |  54 ++---
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts      |  20 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |  30 +--
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  30 ++-
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |  24 +--
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |  29 +--
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts       |  14 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |  34 +---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  38 +---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  14 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   6 +-
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts           |  34 +---
 arch/arm/boot/dts/sun5i-gr8-evb.dts                |  59 ++----
 arch/arm/boot/dts/sun5i-gr8.dtsi                   |  12 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  40 +---
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |  35 +---
 arch/arm/boot/dts/sun5i.dtsi                       |  68 ++++---
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts          |  10 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts           |  33 +--
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  39 +---
 arch/arm/boot/dts/sun6i-a31-i7.dts                 |  32 +--
 arch/arm/boot/dts/sun6i-a31-m9.dts                 |  30 +--
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts   |  30 +--
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  79 +++----
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts  |   2 +-
 arch/arm/boot/dts/sun6i-a31s-cs908.dts             |   6 +-
 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts         |   8 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |  27 +--
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi     |   2 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |  27 +--
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |  47 +----
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     |  20 +-
 .../boot/dts/sun6i-reference-design-tablet.dtsi    |  10 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |  46 +----
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |  44 +---
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |  65 +-----
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  21 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  64 +-----
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |  60 +-----
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |  47 +----
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts        |  10 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |  10 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |  48 +----
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |  21 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |  26 +--
 .../arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts |   2 -
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |  68 ++-----
 .../boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts  |   2 -
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts  |  36 ++--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |  22 +-
 .../boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts    |  11 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |  32 +--
 .../boot/dts/sun7i-a20-olinuxino-micro-emmc.dts    |   2 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  54 ++---
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      |  52 +----
 arch/arm/boot/dts/sun7i-a20-orangepi.dts           |  44 +---
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |  31 +--
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |  39 +---
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |  39 +---
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   |  23 +--
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 159 ++++++++-------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  88 ++++----
 arch/arm/boot/dts/sun8i-a23-evb.dts                |  20 +-
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts           |   2 +-
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |  15 +-
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   |  15 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                   |   6 +-
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts         |   4 +-
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts     |  12 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          |   4 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  20 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  43 ++--
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |   1 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   5 -
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  26 +--
 arch/arm/boot/dts/sun8i-q8-common.dtsi             |   8 +-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts       |  33 +--
 .../boot/dts/sun8i-r16-nintendo-nes-classic.dts    |   2 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts             |  42 +---
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  18 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |  17 +-
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts           | 226 +++++++++++++++++=
++++
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts |   8 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts      |   4 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                   |  12 +-
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |  26 +++
 arch/arm/boot/dts/suniv-f1c100s.dtsi               | 147 ++++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  28 ++-
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi     |   2 +-
 .../boot/dts/sunxi-reference-design-tablet.dtsi    |  10 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |   4 +
 101 files changed, 1033 insertions(+), 1923 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qbntqnyf26py6ltl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAqF+AAKCRDj7w1vZxhR
xWkPAQCbcAJljabGwQNid4wVlfH2A0Dl77jGkciXZhZCwxo15AD+OuAOK1MKyO7q
3AueU6NCvEMt09FKrqrMy1qaH7SM+Qo=
=KS+g
-----END PGP SIGNATURE-----

--qbntqnyf26py6ltl--


--===============4594725745865456008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4594725745865456008==--

