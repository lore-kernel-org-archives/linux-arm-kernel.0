Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D9C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6A021726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lsPYSgUx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="K75Pm7fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6A021726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8473TcNGmOXRXRxRDPodCkFVVGD65wInSvKzeUo8Ya8=; b=lsPYSgUxvWftL4
	EAF+onW2YksCXy/cfwJFLJbOm3VvjKBYwFvUW65TrPBar2kDTz2cyz23hE9FxBPCl3bMPU+jL1UtD
	/EN3k9IR/5+hqqTaO9K3g8HUMQhWiB9qNwgH7OSRvWPem7bL6VLMQgXAQqSkvc7vR/yyw0jlzJ//R
	ROuRClHRNLQHTFcd2fV3qTa0cyPekNZzGKmsYWtXmY9LAQlOBHGE6jk2Wq39FKvL5X5kRCZo1MPk1
	b3A1v3GVVps1PA/Sos6tif1dWmAlOGbDVEhNGun8rIrzZoguBBpLNvHmailO1Yj44OvrY3rp26DBm
	IEKOAVKjqvew/50IBIKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gml9m-000712-WC; Thu, 24 Jan 2019 19:59:23 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gml9h-00070J-UE
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:59:20 +0000
Received: by mail-pl1-x641.google.com with SMTP id b5so3376530plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gu9TACan5B/DOcFtXC5jyd98RZPdMTDUQnY8jPCFqPQ=;
 b=K75Pm7fc1DU+mfT9d4Io0qXsbW/bnuhvf1mUe8L1I7PT882iEZf4T/DHGWXa14ojDn
 vmZejAqy/j877ueH7XznRHw5FvsmtO0wYwrr8bzlh3KY3A9LOw8k+fVVzPdL+MuVgBR0
 EWa6Jm/r1MV/s6SG+5tKxvNyWEhBvexUuxZcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gu9TACan5B/DOcFtXC5jyd98RZPdMTDUQnY8jPCFqPQ=;
 b=IHZ5MPzKbdm0kLRwZosNUGeu3945T6I4Qh0QkqppM314+ViLKIw1WRG3s6I3KpmXJ5
 Ofk7YgFh7SyYNGwm/J+9wzidVHLBBZUrkYYG4hhG2t30K/CJ5S09eGGcZqyOf2VFmV5r
 PwLbouLJI+g+3Vf1iNAVANrtafTN78kxZWxSaMXABdJzVSZVH4k4v97BcdsnKvhlMNqn
 kubWJQPqnbFA6CHtmS7hsJjOhrjNbytey07E3DK5EQNASWSRDxRYy61cN16C4t4VUVsg
 P55CmDh3wLE4gKsvMM4fULjW1T0DgpnYDDrXGrJc0k690odSnyW7xlS4ESptxqRUK3b9
 aF6A==
X-Gm-Message-State: AJcUukcioNynisnvrzRTiLT0A//A/iaUYWi7fba+JvkWQfwLsp8oTxVn
 fb0iCe4SVfSYBYKcLsCbJ8ePaw==
X-Google-Smtp-Source: ALg8bN4AIIreI3usHTCXC4Y+jWxwZbpBisd2jm45fBSoZpaIjRI/Zz60hUXWrRxkojSHxgfzXxmH4A==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr7937832plr.15.1548359956988; 
 Thu, 24 Jan 2019 11:59:16 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 11:59:16 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 00/22] drm/sun4i: Allwinner A64 MIPI-DSI support
Date: Fri, 25 Jan 2019 01:28:38 +0530
Message-Id: <20190124195900.22620-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_115918_444669_DE9E12A3 
X-CRM114-Status: GOOD (  14.51  )
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
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Here is next version changes for Allwinner A64 MIPI-DSI support

This series grouped the changes from previous version A64 MIPI-DSI[1]
along with burst mode[2].

Though the series seems to have more patches, but all patches are ordered 
in a way that the review process is as smooth as possible.

Overall the series is grouped into four different sets to support three 
different panels types that can fit into the DSI controller.

set:1 for 4-lane, burst mode:
- patch 0001: 0009, DSI controller changes that support burst mode.
  all the patches fixed the previous comments along with proper commit message.

set:2 for A64 DSI changes:
- patch 0010: 0011, PLL-MIPI changes related to A64
- patch 0012: 0013, VCC-DSI supply change on DSI controller
- patch 0014: 0015: dt-bindings patches for A64 DSI and DPHY documentation
- patch 0016: A64 DSI pipeline patch
- patch 0017: Overlay patch that enable Feiyang FY07024DI26A30-D burst mode
  panel on Pine64-LTS to validate set:1 changes

set:3 for 4-lane, non-burst mode:
- patch 0018: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
- patch 0019: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211 
  panel on Bananapi M64 to validate set:3 changes

set:4 for 2-lane, non-burst mode:
- patch 0020: 0021, DSI hfp and hbp timings fixes
- patch 0022: patch to enable Techstar TS8550B panel on Amarula A64-Relic
  to validate set:4 changes.

Changes for v6:
- dropped unneeded changes, patches
- fixed all burst mode patches as per previous version comments
- rebase on master
- update proper commit message
- dropped unneeded comments
- order the patches that make review easy
Changes for v5:
- collect Rob, Acked-by
- droped "Fix VBP size calculation" patch
- updated vblk timing calculation.
- droped techstar, bananapi dsi panel drivers which may require
  bridge or other setup. it's under discussion.
Changes for v4:
- droppoed untested CCU_FEATURE_FIXED_POSTDIV check code in
  nkm min, max rate patches
- create two patches for "Add Allwinner A64 MIPI DSI support"
  one for has_mod_clk quirk and other one for A64 support
- use existing driver code construct for hblk computation
- dropped "Increase hfp packet overhead" patch [2], though BSP added
  this but we have no issues as of now.
  (no issues on panel side w/o this change)
- create separate function for vblk computation 
- enable vcc-dsi regulator in dsi_runtime_resume
- collect Rob, Acked-by
- update MAINTAINERS file for panel drivers
- cleanup commit messages
- fixed checkpatch warnings/errors

[1] https://patchwork.kernel.org/cover/10721509/
[2] https://patchwork.kernel.org/cover/10686655/

Any inputs?
Jagan.

Jagan Teki (22):
  drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
    delay
  drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
  drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
  drm/sun4i: tcon: Export get tcon0 routine
  drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for 4-lane burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP, HSA_HSE
  clk: sunxi-ng: Add check for minimal rate to NKM PLLs
  clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
  dt-bindings: sun6i-dsi: Add VCC-DSI supply property
  drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI voltage regulator
  dt-bindings: sun6i-dsi: Add A64 DSI compatible (w/ A31 fallback)
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  arm64: dts: allwinner: a64: Add DSI pipeline
  [DO NOT MERGE] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI
    panel
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
  arm64: dts: allwinner: a64-amarula-relic: Add Techstar TS8550B
    MIPI-DSI panel

 .../bindings/display/sunxi/sun6i-dsi.txt      |   5 +
 .../allwinner/sun50i-a64-amarula-relic.dts    |  39 +++++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  43 +++++
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  39 +++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  47 +++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   1 +
 drivers/clk/sunxi-ng/ccu_nkm.c                |   5 +
 drivers/clk/sunxi-ng/ccu_nkm.h                |   1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 165 ++++++++++++++++--
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   4 +
 12 files changed, 337 insertions(+), 16 deletions(-)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
