Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E8EC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:56:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868BE20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qHXDBzRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868BE20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hKAAuTuhRljhZ9NAOMaiM3lRodl2FZ8z3mJU0qhWTQc=; b=qHXDBzRFLWs2y0
	GmuWLLaEcvm6Lo9CxmG8vzR7hQiI62QHY/tVXnoG7DK7CiaMsR9vnE0cvU7XkEdMksKAmjdJDHwVZ
	Cc1pEBRks8vH7TEiLocwd+Iw3GQEwpE/Ag3PfGX3ZXDasLLN7IwoOo8oT2QIlVxyzuPQcr2T/ljoE
	tCaTrQdRnCx7rywLP0YhGuxmLVesXafjfbDZ0Ea22yO2ynmLckZIVgewSdlBFMPTjIcStHKLbO2qG
	TTej+YFbhEOMAPu5kgWhsW8iV0e+232QWqTBdbleDVYsxWApd9Y9nTrLJJtWKN9JCdNdJ6trQ8l3Z
	/T57hBCPncI7glfWXD+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGcU-0007NZ-M3; Fri, 07 Dec 2018 13:56:42 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGbr-0006e6-R4
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:56:07 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9B1EB20D23; Fri,  7 Dec 2018 14:55:51 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6AB1820726;
 Fri,  7 Dec 2018 14:55:41 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v3 00/10] phy: Add configuration interface for MIPI D-PHY
 devices
Date: Fri,  7 Dec 2018 14:55:27 +0100
Message-Id: <cover.ad7c4feb3905658f10b022df4756a5ade280011f.1544190837.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_055604_218022_0443FCAB 
X-CRM114-Status: GOOD (  17.55  )
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
Cc: Archit Taneja <architt@codeaurora.org>, Rafal Ciepiela <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Here is a set of patches to allow the phy framework consumers to test and
apply runtime configurations.

This is needed to support more phy classes that require tuning based on
parameters depending on the current use case of the device, in addition to
the power state management already provided by the current functions.

A first test bed for that API are the MIPI D-PHY devices. There's a number
of solutions that have been used so far to support these phy, most of the
time being an ad-hoc driver in the consumer.

That approach has a big shortcoming though, which is that this is quite
difficult to deal with consumers integrated with multiple variants of phy,
of multiple consumers integrated with the same phy.

The latter case can be found in the Cadence DSI bridge, and the CSI
transceiver and receivers. All of them are integrated with the same phy, or
can be integrated with different phy, depending on the implementation.

I've looked at all the MIPI DSI drivers I could find, and gathered all the
parameters I could find. The interface should be complete, and most of the
drivers can be converted in the future. The current set converts two of
them: the above mentionned Cadence DSI driver so that the v4l2 drivers can
use them, and the Allwinner MIPI-DSI driver.

Let me know what you think,
Maxime

Changes from v2:
  - Rebased on next
  - Changed the interface to accomodate for the new submodes
  - Changed the timings units from nanoseconds to picoseconds
  - Added minimum and maximum boundaries to the documentation
  - Moved the clock enabling to phy_power_on in the Cadence DPHY driver
  - Exported the phy_configure and phy_validate symbols
  - Rework the phy pll divider computation in the cadence dphy driver

Changes from v1:
  - Rebased on top of 4.20-rc1
  - Removed the bus mode and timings parameters from the MIPI D-PHY
    parameters, since that shouldn't have any impact on the PHY itself.
  - Reworked the Cadence DSI and D-PHY drivers to take this into account.
  - Remove the mode parameter from phy_configure
  - Added phy_configure and phy_validate stubs
  - Return -EOPNOTSUPP in phy_configure and phy_validate when the operation
    is not implemented

Maxime Ripard (10):
  phy: Add MIPI D-PHY mode
  phy: Add configuration interface
  phy: Add MIPI D-PHY configuration options
  phy: dphy: Add configuration helpers
  sun6i: dsi: Convert to generic phy handling
  phy: Move Allwinner A31 D-PHY driver to drivers/phy/
  drm/bridge: cdns: Separate DSI and D-PHY configuration
  dt-bindings: phy: Move the Cadence D-PHY bindings
  phy: Add Cadence D-PHY support
  drm/bridge: cdns: Convert to phy framework

 Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt |  21 +-
 Documentation/devicetree/bindings/phy/cdns,dphy.txt           |  20 +-
 drivers/gpu/drm/bridge/cdns-dsi.c                             | 535 +------
 drivers/gpu/drm/sun4i/Kconfig                                 |   3 +-
 drivers/gpu/drm/sun4i/Makefile                                |   5 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c                       | 292 +----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c                        |  31 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                        |  17 +-
 drivers/phy/Kconfig                                           |   8 +-
 drivers/phy/Makefile                                          |   1 +-
 drivers/phy/allwinner/Kconfig                                 |  12 +-
 drivers/phy/allwinner/Makefile                                |   1 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c                   | 318 ++++-
 drivers/phy/cadence/Kconfig                                   |  13 +-
 drivers/phy/cadence/Makefile                                  |   1 +-
 drivers/phy/cadence/cdns-dphy.c                               | 389 +++++-
 drivers/phy/phy-core-mipi-dphy.c                              | 166 ++-
 drivers/phy/phy-core.c                                        |  64 +-
 include/linux/phy/phy-mipi-dphy.h                             | 285 ++++-
 include/linux/phy/phy.h                                       |  65 +-
 20 files changed, 1468 insertions(+), 779 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 delete mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
 create mode 100644 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
 create mode 100644 drivers/phy/cadence/cdns-dphy.c
 create mode 100644 drivers/phy/phy-core-mipi-dphy.c
 create mode 100644 include/linux/phy/phy-mipi-dphy.h

base-commit: 74c4a24df7cac1f9213a811d79558ecde23be9a2
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
