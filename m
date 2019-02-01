Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B68C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:32:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB6F2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SY+QTVbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB6F2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9mwgyfEYJ1Cx2Sc+MoJRq721T5isELzNnWYhkCJxMOE=; b=SY+QTVbzF43nJu
	MuycSQFGmdmSKpytw3d+Xr2+0Nncxmi+KYDbA6wA9pS3G2Lj2RE3PUDe5Yt6hXEIL5VTGn/r8w235
	KCP+pkzINRPk+isDHopA0u++vfAdzLnX0tAfe0rwpNnQViBR+KxQzA6Tq3rudMz7e9Q2AJnFsy5aA
	M5qFzJM0tZGPxCzlO8v0OrltbchqPjc3Yy/hdwZzz0QD5i5Ja7nRV5Wel4alN/iP1MuF8aC+RSn0G
	FAJlH4unc0GU69sD2ZBa1sfVW2xFL4cYUZiiKzqu5dVt1SmJuKlVVviP4gBbDkwnML4n7t7UAk4Ag
	i7W/xV9IlJdNqu5fz14A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUF2-0000TL-Q2; Fri, 01 Feb 2019 08:32:04 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUDb-0007GC-IX; Fri, 01 Feb 2019 08:30:40 +0000
X-UUID: a4699f0b6f4940078bbb9a48460157d1-20190201
X-UUID: a4699f0b6f4940078bbb9a48460157d1-20190201
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <weiyi.lu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 760952909; Fri, 01 Feb 2019 00:30:28 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 00:30:27 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:30:24 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:30:24 +0800
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring
 <robh@kernel.org>
Subject: [PATCH v4 00/12] Mediatek MT8183 clock and scpsys support
Date: Fri, 1 Feb 2019 16:30:04 +0800
Message-ID: <20190201083016.25856-2-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190201083016.25856-1-weiyi.lu@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 581B28452E237DACE233EE183FEC79EF4AC44A0EC67C20D4425C1D1D9338C9642000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_003036_062591_C2170804 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series is based on v5.0-rc1 and most of changes are extracted from series below
(clock/scpsys common changes for both MT8183 & MT6765)
https://patchwork.kernel.org/patch/10528495/
(clock support of MT8183)
https://patchwork.kernel.org/patch/10549891/

The whole series is composed of
clock common changes for both MT8183 & MT6765 (PATCH 1-3),
scpsys common changes for both MT8183 & MT6765 (PATCH 4),
clock support of MT8183 (PATCH 5-8),
scpsys support of MT8183 (PATCH 9-11) and
resend a clock patch long time ago(PTACH 12).

change sinve v3:
- add fix tag.
- small change of mtk_clk_mux data structure.
- use of_property_for_each_string to iterate dependent subsys clock of power domain.
- document critical clocks.
- reduce some clock register error log.
- few coding style fix.

change sinve v2:
- refine for implementation consistency of mtk clk mux.
- separate the onoff API into enable/disable API for mtk scpsys.
- resend a patch about PLL rate changing.

changes since v1:
- refine for better code quality.
- some minor bug fix of clock part, like incorrect control address
  and missing clocks.

James Liao (1):
  clk: mediatek: Allow changing PLL rate when it is off

Owen Chen (4):
  clk: mediatek: Disable tuner_en before change PLL rate
  clk: mediatek: add new clkmux register API
  clk: mediatek: add configurable pcwibits and fmin to mtk_pll_data
  soc: mediatek: add new flow for mtcmos power.

Weiyi Lu (7):
  dt-bindings: ARM: Mediatek: Document bindings for MT8183
  clk: mediatek: Add dt-bindings for MT8183 clocks
  clk: mediatek: Add flags support for mtk_gate data
  clk: mediatek: Add MT8183 clock support
  dt-bindings: soc: fix typo of MT8173 power dt-bindings
  dt-bindings: soc: Add MT8183 power dt-bindings
  soc: mediatek: Add MT8183 scpsys support

 .../arm/mediatek/mediatek,apmixedsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt |    1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt |   22 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt |    1 +
 .../arm/mediatek/mediatek,infracfg.txt        |    1 +
 .../bindings/arm/mediatek/mediatek,ipu.txt    |   43 +
 .../bindings/arm/mediatek/mediatek,mcucfg.txt |    1 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt  |    1 +
 .../arm/mediatek/mediatek,topckgen.txt        |    1 +
 .../arm/mediatek/mediatek,vdecsys.txt         |    1 +
 .../arm/mediatek/mediatek,vencsys.txt         |    1 +
 .../bindings/soc/mediatek/scpsys.txt          |   14 +
 drivers/clk/mediatek/Kconfig                  |   75 +
 drivers/clk/mediatek/Makefile                 |   15 +-
 drivers/clk/mediatek/clk-gate.c               |    5 +-
 drivers/clk/mediatek/clk-gate.h               |   17 +-
 drivers/clk/mediatek/clk-mt8183-audio.c       |  105 ++
 drivers/clk/mediatek/clk-mt8183-cam.c         |   63 +
 drivers/clk/mediatek/clk-mt8183-img.c         |   63 +
 drivers/clk/mediatek/clk-mt8183-ipu0.c        |   56 +
 drivers/clk/mediatek/clk-mt8183-ipu1.c        |   56 +
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c     |   54 +
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c    |  123 ++
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c      |   54 +
 drivers/clk/mediatek/clk-mt8183-mm.c          |  111 ++
 drivers/clk/mediatek/clk-mt8183-vdec.c        |   67 +
 drivers/clk/mediatek/clk-mt8183-venc.c        |   59 +
 drivers/clk/mediatek/clk-mt8183.c             | 1285 +++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |    3 +-
 drivers/clk/mediatek/clk-mtk.h                |    3 +
 drivers/clk/mediatek/clk-mux.c                |  223 +++
 drivers/clk/mediatek/clk-mux.h                |   89 ++
 drivers/clk/mediatek/clk-pll.c                |   53 +-
 drivers/soc/mediatek/Makefile                 |    2 +-
 drivers/soc/mediatek/mtk-scpsys-ext.c         |   99 ++
 drivers/soc/mediatek/mtk-scpsys.c             |  602 ++++++--
 include/dt-bindings/clock/mt8183-clk.h        |  422 ++++++
 include/dt-bindings/power/mt8173-power.h      |    6 +-
 include/dt-bindings/power/mt8183-power.h      |   26 +
 include/linux/soc/mediatek/scpsys-ext.h       |   39 +
 41 files changed, 3757 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
 create mode 100644 drivers/clk/mediatek/clk-mt8183-audio.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu_adl.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu_conn.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-mfgcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183.c
 create mode 100644 drivers/clk/mediatek/clk-mux.c
 create mode 100644 drivers/clk/mediatek/clk-mux.h
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
 create mode 100644 include/dt-bindings/clock/mt8183-clk.h
 create mode 100644 include/dt-bindings/power/mt8183-power.h
 create mode 100644 include/linux/soc/mediatek/scpsys-ext.h

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
