Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F769C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:54:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7A220823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TteDR6gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7A220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+bfdCnWNbIDHIhSgwSUy1CWsNZpqmMXmHH8RlqpdSvk=; b=TteDR6gcQ0eVtz
	mqoSD7TmOeLhC7DIkdCmQ6hhgvX+LLi5FWwj2lOmZHULxxQrrMn5VuJWulOuSUVH84AODJwJwD2GD
	UOSKqLpdMJkGXJ1yF/jbY+Ql8f5V0vFkQNPwlPv2m8xt49+bjeztQ22mP3khZy2GAdSE1UMIPciJ8
	dfsUz1iweD9SbSh33CmcimIu4VnB6YKnFSNv6r6UcjjwM/bp0RlCF0gXCDie54tYMQwZtkHdLbJ4Z
	/3iFG6iFSzjHgadc4exHQ5iburWh8sllK/YIRjsNwF+CNKW6cToQqX7VFY3e5MwpkU99o8nng5AQi
	W095W0JcYguQTSLv4YIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2r7-0003gP-S2; Fri, 08 Feb 2019 09:53:57 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2qn-0003LC-Ip
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:53:39 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B810124001A;
 Fri,  8 Feb 2019 09:53:24 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 0/9] drm/sun4i: dsi: Add burst mode support
Date: Fri,  8 Feb 2019 10:53:13 +0100
Message-Id: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_015337_766821_F8A57CFF 
X-CRM114-Status: GOOD (  13.06  )
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

It's been tested on an A33 board with the panel supported on the last
patch, which should remove all quirks due to a different SoC from the
equation.

Let me know what you think,
Maxime

Changes from v2:
  - Change the start delay calculation according to the legacy driver in
    Allwinner's BSP
  - Fixed the edge calculation to add the same parentheses around the
    factors
  - Added a bunch of fixes to timings
  - Added a patch to make hblk computation more accurate, and added a
    comment
  - Renamed the panel to Ronbo and fixed a bunch of things
  - Added the Reviewed-By

Konstantin Sudakov (2):
  drm/sun4i: dsi: Add burst support
  drm/panel: Add Ronbo RB070D30 panel

Maxime Ripard (7):
  fixup! ARM: dts: sun8i-a33: bridgemate: Enable display support
  drm/sun4i: dsi: Restrict DSI tcon clock divider
  drm/sun4i: dsi: Change the start delay calculation
  drm/sun4i: dsi: Enforce boundaries on the start delay
  drm/sun4i: dsi: Fix front vs back porch calculation
  drm/sun4i: dsi: Fix DRQ calculation
  drm/sun4i: dsi: Rework a bit the hblk calculation

 arch/arm/boot/dts/sun8i-a33-bridgemate-bm3.dts |   2 +-
 drivers/gpu/drm/panel/Kconfig                  |   9 +-
 drivers/gpu/drm/panel/Makefile                 |   1 +-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c   | 262 ++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c             |   4 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c         | 183 ++++++++++---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h         |   2 +-
 7 files changed, 420 insertions(+), 43 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c

base-commit: f6028e7e48b0f3865b0837d400ca783d3d200b62
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
