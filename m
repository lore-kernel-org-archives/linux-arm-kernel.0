Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F890C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:24:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DF72085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oe/jgLq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DF72085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ra3VR85Mcing+U3ny4HeKw3a8PwGszutX+XawjoNGIg=; b=oe/jgLq09c/pah
	L3fT5rJRxT5oz+ygm0+H577QcFt0m95JWJIkhKRw/c3sYl5YiXdiGj1w57WK0L1Y7kNB/q03k/9zC
	QUfqce9EEKkoDRKNmDgAPPqv+piXZe2q5ab4wJu9XMdUdcoi+ri31iBkl5lM41VXoE4Q7bDOpkxhF
	61OQyD18aSB3ZJvhqwby2nIgLQp9VkmeaSt1GMkxOXHiyZdy7a28dTUzfuvuN4LT0NNJj+eNLRAR9
	RmUV68x4yAcTccKoxtIYwNq+w73Dz1n8HwbvPJKRX53Hz/gEThZbXDpG8cepiI+WkJaGQmAdlRGEM
	3mlFfkaeFPoL+crvWzWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gms60-0006yw-OE; Fri, 25 Jan 2019 03:23:56 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gms5Q-0006dU-D4
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 03:23:23 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 149355FCC3; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 00/11] ARM: sun8i: a23: Enable display pipeline
Date: Fri, 25 Jan 2019 11:23:03 +0800
Message-Id: <20190125032314.20915-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_192320_728280_513E6F90 
X-CRM114-Status: GOOD (  17.73  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This series enables the display pipeline on the Allwinner A23 SoC.
A few fixes are included for corner cases when the frontend isn't
enabled.

The A23 display pipeline is very much the same as the A33, except
that the A23 does not have the SAT IP block embedded within the
display backend.

MIPI DSI is not covered as I do not have a device that uses it.

Patch 1 fixes the pll-mipi clock on the A23.

Patch 2 adds compatible strings for the various hardware blocks
of the A23 display pipeline.

Patch 3 through 5 fix some issues in our DRM plane support, namely
declaring support for formats when we shouldn't.

Patch 6 adds support for the A23 display pipeline to the driver.

Patch 7 is a small cleanup before moving the display pipeline device
nodes.

Patch 8 moves the display nodes from the A33-specific dtsi file to
the A23-A33 shared dtsi file. Note that the MIPI DSI device nodes are
not moved.

Patch 9 adds compatible strings to the display nodes in the A23-specific
dtsi file.

Patch 10 enables the display pipeline for the shared A23/A33 Q8 tablet
dtsi file. The compatible string should be filled in by the tablet dts
files.

Patch 11 fills in the compatible string for the standard A23 Q8 tablet.
Note the compatible string is not for the specific model used in the
tablet, as it varies between production runs. Rather it is just one that
works.

Please have a look. Patch 3 might be worth applying as a fix, but might
not be worth the trouble. It could just as easily be applied for -next
and then backported.

Also, the fixes tags are no longer line wrapped, unlike patches I've
sent in the past.


Regards
ChenYu

Chen-Yu Tsai (11):
  clk: sunxi-ng: sun8i-a23: Enable PLL-MIPI LDOs when ungating it
  dt-bindings: display: sun4i-drm: Add compatible strings for A23
    display
  drm/sun4i: backend: Remove BGRX8888 from list of supported formats
  drm/sun4i: layer: Assign backend pointer before calling DRM helpers
  drm/sun4i: layer: support just backend formats when frontend is
    unavailable
  drm/sun4i: Add support for A23 display pipeline
  ARM: dts: sun8i-a23-a33: Move NAND controller device node to sort by
    address
  ARM: dts: sun8i-a33: Move display pipeline nodes to a23/a33 common
    dtsi
  ARM: dts: sun8i-a23: Add compatible strings to display pipeline device
    nodes
  ARM: dts: sun8i-q8-common: Enable display pipeline with RGB LCD panel
  ARM: dts: sun8i-a23-q8: Set compatible string for LCD panel

 .../bindings/display/sunxi/sun4i-drm.txt      |   5 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          | 175 ++++++++++++++--
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts     |   4 +
 arch/arm/boot/dts/sun8i-a23.dtsi              |  20 ++
 arch/arm/boot/dts/sun8i-a33.dtsi              | 194 ++++--------------
 arch/arm/boot/dts/sun8i-q8-common.dtsi        |  37 ++++
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c          |   2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c         |   5 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   2 +
 drivers/gpu/drm/sun4i/sun4i_frontend.c        |   4 +
 drivers/gpu/drm/sun4i/sun4i_layer.c           |  37 +++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   1 +
 drivers/gpu/drm/sun4i/sun6i_drc.c             |   1 +
 13 files changed, 310 insertions(+), 177 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
