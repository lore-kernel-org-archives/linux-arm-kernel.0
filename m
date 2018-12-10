Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF65C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:34:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B932082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VY6qg8hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B932082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wHBxR8ktLwGV5E5Y9j7zDVBSyZLk1+eFqhjs8+lvWiE=; b=VY6qg8hpUlV1gO
	+koAFMwRD8+etfMsbmhb7RKXBP3isxAS4d0XBHGnpls9zpw9ilrzlGpV3PcsXQ8FhA9xmLmFcHCXT
	mcnGSMYZCTqQkuqmuPijTsx2o/MMyVAFGwgRoSsJ2W1aL62rkP/6mBqxGNvdNgyPymtfBp0W3JBk8
	96wluZ4fdXau1LQIE55LzlCwT/f4JlxIZNlQkKAUTawrs5Y/jIjCMTSPTKHcHV6qLatl6Zhikc7D6
	rACsVnxSJIkqqPv4Zwin0O+R7SNmIQ08e4aZT2BIun79fk7AvHfPy6juIRsTNQzAUvZYlQyFswIeL
	hrsHFywQR43MhCAbre0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWG53-0004ji-24; Mon, 10 Dec 2018 07:34:17 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWG3y-0003d9-8i; Mon, 10 Dec 2018 07:33:13 +0000
X-UUID: 41d9240c0b11403589a816e48324adee-20181210
X-UUID: 41d9240c0b11403589a816e48324adee-20181210
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <weiyi.lu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1441233250; Mon, 10 Dec 2018 15:32:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 15:32:51 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 15:32:51 +0800
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring
 <robh@kernel.org>
Subject: [PATCH v3 00/12] Mediatek MT8183 clock and scpsys support
Date: Mon, 10 Dec 2018 15:32:28 +0800
Message-ID: <20181210073240.32278-2-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210073240.32278-1-weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_233310_562404_1FB79026 
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series is based on v4.20-rc1 and most of changes are extracted from series below
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
  clk: mediatek: fixup: Disable tuner_en before change PLL rate
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
 drivers/clk/mediatek/clk-mt8183-audio.c       |  102 ++
 drivers/clk/mediatek/clk-mt8183-cam.c         |   70 +
 drivers/clk/mediatek/clk-mt8183-img.c         |   70 +
 drivers/clk/mediatek/clk-mt8183-ipu0.c        |   63 +
 drivers/clk/mediatek/clk-mt8183-ipu1.c        |   63 +
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c     |   61 +
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c    |  130 ++
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c      |   61 +
 drivers/clk/mediatek/clk-mt8183-mm.c          |  118 ++
 drivers/clk/mediatek/clk-mt8183-vdec.c        |   74 +
 drivers/clk/mediatek/clk-mt8183-venc.c        |   66 +
 drivers/clk/mediatek/clk-mt8183.c             | 1304 +++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |    3 +-
 drivers/clk/mediatek/clk-mtk.h                |    3 +
 drivers/clk/mediatek/clk-mux.c                |  229 +++
 drivers/clk/mediatek/clk-mux.h                |  101 ++
 drivers/clk/mediatek/clk-pll.c                |   50 +-
 drivers/soc/mediatek/Makefile                 |    2 +-
 drivers/soc/mediatek/mtk-scpsys-ext.c         |   99 ++
 drivers/soc/mediatek/mtk-scpsys.c             |  616 ++++++--
 include/dt-bindings/clock/mt8183-clk.h        |  422 ++++++
 include/dt-bindings/power/mt8173-power.h      |    6 +-
 include/dt-bindings/power/mt8183-power.h      |   26 +
 include/linux/soc/mediatek/scpsys-ext.h       |   39 +
 41 files changed, 3874 insertions(+), 105 deletions(-)
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
