Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20292C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:22:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F62208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U9QXl+qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F62208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bWslp7GTByxImItNr9edsx2TqG/I8OZ74GJgf/YcrxM=; b=U9QXl+qF7yQmIA
	C9m5gxNSDWJ4UCRIbDfOTe5OVD/f1OJydUYpcq/HAUOJjjkPSN/AiUOhINZhfXm7LNPjzGVdF1wNZ
	qO1d2QIbvs6TFZesZtLfilZKL6rEfi0jjpaReu06bAJOvaPC1d5HR8WJ6Ll1Zr02eGnIZZxr7pSaI
	xZ1hCfuCU1Eq4XAp5BHOf24fDj8o9GYe7v5tEOeiPGMb1Bfbl2Q3pMtJ5BK3DmvVMiaGr3QXO1cFY
	KlPX5Q8RAi4Qh/v3YQcrFhXrngvKDJDWP7Elzg5NUkUp9c6S8sB1DL7f3jpGzLwfLn6yjSaWZS+st
	dLkWJsvV/E3JjsBq8IQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwN8s-0003bT-TJ; Wed, 20 Feb 2019 08:22:10 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwN8o-0003aH-S4
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 08:22:08 +0000
Received: from localhost (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id C5B59240012;
 Wed, 20 Feb 2019 08:21:57 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v4 0/3] drm/panel: Add Ronbo RB070D30
Date: Wed, 20 Feb 2019 09:21:53 +0100
Message-Id: <cover.5ac8e6ed5381ceb14a2e5d64671228f665a08d43.1550650810.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_002207_053666_3415F336 
X-CRM114-Status: GOOD (  12.44  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Here is a series adding a driver for the Ronbo RB070D30 panel. This was
previously integrated in the DSI burst series, but those parts have been
merged since.

It's been tested on an Allwinner A33 board.

Let me know what you think,
Maxime

Changes from v3:
  - Added patches for the DT binding and vendor documentation
  - Addressed the comments from Sam and Paul
  - Dropped the merged patches
  - Fixed error in Ronbo panel error path

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
  dt-bindings: Add vendor prefix for Ronbo Electronics
  drm/panel: Add Ronbo RB070D30 panel

Maxime Ripard (1):
  dt-bindings: panel: Add YAML schemas for the Ronbo RB070D30 panel

 Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml |  52 +++++++++++++++-
 Documentation/devicetree/bindings/vendor-prefixes.txt               |   1 +-
 drivers/gpu/drm/panel/Kconfig                                       |   9 +++-
 drivers/gpu/drm/panel/Makefile                                      |   1 +-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c                        | 258 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c

base-commit: b68999315c0cea0f71efae4adbc3508abc9f0f9c
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
