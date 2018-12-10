Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8811C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6A620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lX+lsDvE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PGWyH6gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6A620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e+OI6GbHti1I1E0Z7vMu4c/Bfzf4FxwFa5RlmKL9OkI=; b=lX+lsDvEu++FdM
	wxorZBukNCyzV/uLpPcPtMhJSqt7Ll83Trw5c3rJlduBbywGOMADJbjxxd4Cgt33dkRPrUydVUzmV
	4z9F0fyTiMxaQwqFgmQEF/hjSy9g1sOSX+jLFXx3SRV/N84hw2ORCZkG90qFXxaQQ1A5l7eLChFb4
	Ho3RS8bvkKIkkouWFY8cbNGE4PY50Xsdiwj/6nwkY4qmb5LYiNqxjve3eD2fyJQAX9GI611zuMneg
	dUVYWlVJHc9O88h5FOnOJX6MOKASnK4Fgh+jPFA7OSFP+sa04AB5D4IkAEv0pexgj3ZKPH0D2SeUL
	vEefD5jmhXkgBepVBUpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOFr-0007eJ-TI; Mon, 10 Dec 2018 16:17:59 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOFo-0007ap-7D
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:17:58 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so4139619wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4e160jMcepVwiZJsNnnNpZImXigG1UFlKIJPHI/u0ZU=;
 b=PGWyH6gvEgGECqR9NF5BNxl0Py6/byXoGInOFkKVE+0+88Y6FLxsgIjb3fU8ieU/hH
 Rv0xxhJBemSjkPY8qFJr8c2kWelzVfj7BtoPAlZdBWoHM0nxyNAj4bWx58RFyUlZgemy
 4vm3NxVQbl8K/WBJvIyxDtABM3SpgGeLKSnvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4e160jMcepVwiZJsNnnNpZImXigG1UFlKIJPHI/u0ZU=;
 b=DfFsbzlg3DJGy0fshHnSJ8C33wv3PBHTiAcuJYTl3gGM3iTS2NMy2SUaipShAqdiZR
 EPSu6cKn7knkrOcCcKX9rsYIvXp3mUzXV3fExNvc74FTCL4VlG0Z0tFEeu48tXtb0mU1
 ZvJjD2HGOpdZBDsO2fMRu9MuFamtVKcaWqiPU4LgKrdcg/3a7hIX6uWFRbmwcu+nb6wX
 ztUqLaTJNA7IR+3sGALA7IVgfOB0GzZOpyGJvun7QPBApYNXvH+WTX1E9CQ6yL8AMAg7
 MKsGQkifnRBmwK/sHzHokxpE9AJXYtPmwXq2CY1+3RKeQyytekp0EvBqX/286b+VTOs2
 fM5A==
X-Gm-Message-State: AA+aEWbyhVvlXiJnJswthbZxaGvXSQnxA0y+Ypxhzsue2XiEBXqZEtvW
 +bG2GQSYjNNMgplQF7PZxLzwmQ==
X-Google-Smtp-Source: AFSGD/VQBz0t2kPLdQnvQlYVMUvZlYL6BnJVEo5bd5LCWWxO1MKzpIa0c7RdrVi/0rm4J+4hN9teWg==
X-Received: by 2002:a1c:8b09:: with SMTP id n9mr11192943wmd.38.1544458663940; 
 Mon, 10 Dec 2018 08:17:43 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:17:43 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 00/17] drm/sun4i: Allwinner A64 MIPI-DSI support 
Date: Mon, 10 Dec 2018 21:47:12 +0530
Message-Id: <20181210161729.29720-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081756_260626_0D213D03 
X-CRM114-Status: GOOD (  12.39  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series fixed the issues related to work DSI on 2-lane panel
which is reported on previous version[1][2][3]

This supposed to be a clean series, where it support Allwinner A64 MIPI-DSI
support for 4-lane, 2-lane DSI panels.

This series fixed all previous series comments along with checkpatch
warnings/error.

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

[3] https://patchwork.kernel.org/cover/10680247/
[2] https://patchwork.kernel.org/patch/10657541/
[1] https://patchwork.kernel.org/patch/10657619/

Note: the respetive dts consumer for dsi will send once the panel
driver finalized or in burst mode patch series.

Any inputs,
Jagan.

Jagan Teki (17):
  clk: sunxi-ng: Add check for minimal rate to NKM PLLs
  drm/sun4i: sun6i_mipi_dsi: Add has_mod_clk quirk
  drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
  dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer
  drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
  drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
  drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI voltage regulator
  dt-bindings: sun6i-dsi: Add VCC-DSI supply property
  clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  arm64: dts: allwinner: a64: Add DSI pipeline

 .../bindings/display/sunxi/sun6i-dsi.txt      |   5 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  45 +++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   1 +
 drivers/clk/sunxi-ng/ccu_nkm.c                |   5 +
 drivers/clk/sunxi-ng/ccu_nkm.h                |   1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 118 ++++++++++++++----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   8 ++
 7 files changed, 159 insertions(+), 24 deletions(-)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
