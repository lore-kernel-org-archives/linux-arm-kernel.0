Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F01DC2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:46:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D524320879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zqnss4Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D524320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SOrdKx47wx2rgWK1nGG6jhWKm8Kby9LUyMEt4fYyhaU=; b=Zqnss4WbReNbjS
	agqa4jxil9uEVVhuV0Anldo1JFZVW2yPlbNuAPzosx5S59rDDHv7PldWiL0s0v+aclYH7IrFbzOkw
	38BayDgleS4IwqRihd0uihi2Sj50IUeaXRqCVVwWAYs9wRRatGh/nhUH+m3a3VTLAn+lm7uYRVYQs
	Ol+Q16ykHu6ovjYd775wO3e1/p2RZ/uKXT7gcv6AB8HVxq3mOqEF9o9QqQSXNVkgMIpS9+xDaNK38
	QgynnINHA3p7dmKnYLIWXHMshd1kIeOBERiCJtReu9T4jVJYwyiBrSCVf28gL7Sw3xlBnHiL6jmCH
	z0a3af9YK//1+OYSzDsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbmW-00025s-M2; Mon, 21 Jan 2019 15:46:36 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbm3-0001gO-ER
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:46:24 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E33AC2078C; Mon, 21 Jan 2019 16:46:05 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id A228220BCD;
 Mon, 21 Jan 2019 16:45:55 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 0/9] phy: Add configuration interface for MIPI D-PHY devices
Date: Mon, 21 Jan 2019 16:45:45 +0100
Message-Id: <cover.fbf0776c70c0cfb7b7fd88ce6a96b4597d620cac.1548085432.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074607_833991_E0815E24 
X-CRM114-Status: GOOD (  18.43  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
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

Changes from v4:
  - Removed regression on the variable calculation
  - Fixed the wakeup unit
  - Collected Sean Acked-by on the last patch
  - Collected Sakari Reviewed-by on the first patch

Changes from v3
  - Rebased on 5.0-rc1
  - Added the fixes suggested by Sakari

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

Maxime Ripard (9):
  phy: dphy: Remove unused header
  phy: dphy: Change units of wakeup and init parameters
  phy: dphy: Clarify lanes parameter documentation
  sun6i: dsi: Convert to generic phy handling
  phy: Move Allwinner A31 D-PHY driver to drivers/phy/
  drm/bridge: cdns: Separate DSI and D-PHY configuration
  dt-bindings: phy: Move the Cadence D-PHY bindings
  phy: Add Cadence D-PHY support
  drm/bridge: cdns: Convert to phy framework

 Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt |  21 +-
 Documentation/devicetree/bindings/phy/cdns,dphy.txt           |  20 +-
 drivers/gpu/drm/bridge/Kconfig                                |   1 +-
 drivers/gpu/drm/bridge/cdns-dsi.c                             | 538 +------
 drivers/gpu/drm/sun4i/Kconfig                                 |   3 +-
 drivers/gpu/drm/sun4i/Makefile                                |   5 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c                       | 292 +----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c                        |  31 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                        |  17 +-
 drivers/phy/allwinner/Kconfig                                 |  12 +-
 drivers/phy/allwinner/Makefile                                |   1 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c                   | 318 ++++-
 drivers/phy/cadence/Kconfig                                   |  13 +-
 drivers/phy/cadence/Makefile                                  |   1 +-
 drivers/phy/cadence/cdns-dphy.c                               | 389 +++++-
 drivers/phy/phy-core-mipi-dphy.c                              |   8 +-
 include/linux/phy/phy-mipi-dphy.h                             |  13 +-
 17 files changed, 894 insertions(+), 789 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 delete mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
 create mode 100644 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
 create mode 100644 drivers/phy/cadence/cdns-dphy.c

base-commit: bfeffd155283772bbe78c6a05dec7c0128ee500c
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
