Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057A9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:24:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78FC214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RBF6sron"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78FC214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JhR4214PW5NMMDxODSLbBSW7JfSkn5V39rRN6VPiT/k=; b=RBF6sronZUz3tl
	gZFsoMDWhTYOYy/5RZMZv3QOIAh8X3GonA11hWOCsfz39rlugWAt5/UakmTE6cye+7iulwtKZJn1O
	mFgP4OWhr6hoh0P2jJotVjyJE7A04ePAdEHA0fG8eect6z1SCbaR9tzSTLzMMbhVtuirlUGCYRW01
	v1CLlQyDvD0ibB6Ed/bSpaKY3s1MXqTEY7qH/8wBwJT33ohTRVKPnB6maXy5cRjPh8MDtkX65C4m3
	jsS5UmCpBlebOOGXExCIcEVGNIlt77hcjd+mgwtfWP9T6fB2LJ29mGVXMtDVHS7mCFyx6sY7FNHlt
	LjMAyiQgfS77r+g2/4Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwiiz-0000F1-0K; Thu, 21 Feb 2019 07:24:53 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwigZ-00060y-Ob; Thu, 21 Feb 2019 07:22:35 +0000
X-UUID: f1dc92c3cafa48559047b1f8d6d91655-20190220
X-UUID: f1dc92c3cafa48559047b1f8d6d91655-20190220
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <louis.kuo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 687499777; Wed, 20 Feb 2019 23:22:04 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 23:22:02 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Feb 2019 15:22:01 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 21 Feb 2019 15:22:01 +0800
From: Louis Kuo <louis.kuo@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 0/4] media: support Mediatek sensor interface driver 
Date: Thu, 21 Feb 2019 15:21:54 +0800
Message-ID: <1550733718-31702-1-git-send-email-louis.kuo@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_232224_411525_6188788A 
X-CRM114-Status: UNSURE (   7.62  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Sean.Cheng@mediatek.com, Rynn.Wu@mediatek.com,
 srv_heupstream@mediatek.com, holmes.chiou@mediatek.com,
 Jerry-ch.Chen@mediatek.com, jungo.lin@mediatek.com, sj.huang@mediatek.com,
 yuzhao@chromium.org, linux-mediatek@lists.infradead.org, zwisler@chromium.org,
 christie.yu@mediatek.com, frederic.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This is the first version of the RFC patch series adding Sensor Inferface(seninf) driver on
Mediatek mt8183 SoC, which will be used in camera features on CrOS application.
It belongs to the first Mediatek's camera driver series based on V4L2 and media controller framework.
I posted the main part of the seninf driver as RFC to discuss first and would like some review comments
on the overall structure of the driver.

The driver is implemented with V4L2 framework.
1. Register as a V4L2 sub-device.
2. Only one entity with sink pads linked to camera sensors for choosing desired camera sensor by setup link
   and with source pads linked to cam-io for routing different types of decoded packet datas to PASS1 driver
   to generate sensor image frame and meta-data.

The overall file structure of the seninf driver is as following:

* mtk_seninf.c: Implement software and HW control flow of seninf driver.
* seninf_drv_def.h: Define data structure and enumeration.
* seninf_reg.h: Define HW register R/W macros and HW register names.

Louis Kuo (4):
  media: platform: mtk-isp: Add Mediatek sensor interface driver
  media: platform: Add Mediatek sensor interface driver KConfig
  dt-bindings: mt8183: Added sensor interface dt-bindings
  dts: arm64: mt8183: Add sensor interface nodes

 .../devicetree/bindings/media/mediatek-seninf.txt  |   52 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   34 +
 drivers/media/platform/Makefile                    |    2 +
 drivers/media/platform/mtk-isp/Kconfig             |   16 +
 drivers/media/platform/mtk-isp/Makefile            |   14 +
 drivers/media/platform/mtk-isp/isp_50/Makefile     |   17 +
 .../media/platform/mtk-isp/isp_50/seninf/Makefile  |    4 +
 .../platform/mtk-isp/isp_50/seninf/mtk_seninf.c    | 1339 ++++++++++++++++++++
 .../mtk-isp/isp_50/seninf/seninf_drv_def.h         |  201 +++
 .../platform/mtk-isp/isp_50/seninf/seninf_reg.h    |  992 +++++++++++++++
 10 files changed, 2671 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-seninf.txt
 create mode 100644 drivers/media/platform/mtk-isp/Kconfig
 create mode 100644 drivers/media/platform/mtk-isp/Makefile
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/Makefile
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/seninf/Makefile
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/seninf/mtk_seninf.c
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/seninf/seninf_drv_def.h
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/seninf/seninf_reg.h

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
