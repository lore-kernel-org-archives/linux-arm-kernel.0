Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41BAC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:55:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDD921019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Trixt+Qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDD921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uD1s4AFGBI0eaaQi3ZKock3uQeblhdiEAGIpW0Eg9q0=; b=Trixt+Qb0VMAmh
	0Y+1vvXijxLxqOgxZxqwlw2YBW5ghmF50WZ3hYR1nE+g0f154RXY1Zzr5zZv6KYSbRkYz5d4PFD72
	O3U+cSCJemHVPaBrZLwvkm9oCEivHACtH4Cu3Fxss2PSLZGXmF7JVawSzWl3s4oJGAVI3F+2dUoSg
	VAks8EpPXed4l94XaNmzW+rGfBM9jyNAT5fOPBvbE4kqxsd4h4NF8uGlHM7kFATxEaHwGgaBRiYbz
	5+3Sx+Dl6uPcu3HVUN7tKEeCDDFkJ4FpJgim4be/W+m3JEVWfCVKgXXj887wBYTixqIMVXewM7jxc
	lltFwU77Z6XICq3iz24w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKrt-0005h3-U2; Wed, 23 Jan 2019 15:55:09 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKrQ-0004yw-Dq
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:54:41 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 603E3209BF; Wed, 23 Jan 2019 16:54:36 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 22DAE207AC;
 Wed, 23 Jan 2019 16:54:26 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 0/4] drm/sun4i: dsi: Add burst mode support
Date: Wed, 23 Jan 2019 16:54:20 +0100
Message-Id: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_075440_598208_EC1E494F 
X-CRM114-Status: GOOD (  10.79  )
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
Cc: bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Here is a series implementing the burst mode support for DSI.

It's been tested on an A33 board with the panel supported on the 4th patch,
which should remove all quirks due to a different SoC from the equation.

Let me know what you think,
Maxime

Konstantin Sudakov (2):
  drm/sun4i: dsi: Add burst support
  drm/panel: Add Rondo RB070D30 panel

Maxime Ripard (2):
  drm/sun4i: dsi: Restrict DSI tcon clock divider
  drm/sun4i: dsi: Change the start delay calculation

 drivers/gpu/drm/panel/Kconfig                |   9 +-
 drivers/gpu/drm/panel/Makefile               |   1 +-
 drivers/gpu/drm/panel/panel-rondo-rb070d30.c | 258 ++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c           |   4 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c       | 185 ++++++++++----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h       |   2 +-
 6 files changed, 414 insertions(+), 45 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-rondo-rb070d30.c

base-commit: f6028e7e48b0f3865b0837d400ca783d3d200b62
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
