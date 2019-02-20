Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0CBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:52:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB04F2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a3fGaayc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB04F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5mU2wyJbll74qni1lEniRzYYJu9psiiPvOAM+sSw4lM=; b=a3fGaaycMzuYzq
	fv4xkMkhtlFZO7Mw8jABQ8jrAds89NsqBhSYMpd4wmtmkct7+PfwgIptCQq+IeM3TNjpEOb2fZkFH
	kKlGFhOeX1YM7MNSJV8c/ODyvWUkKuHD2pA62L5xEVMwcHarBY681SX+IoJYDffm3agRHXRzqyUdk
	DJUVnYhQYvzAKON9NHBtyV6PmAwxxXe2vmdODlxxriQlPqgopQ10p1bTzxJsSxHyfujiga+QBrTNr
	w2hrcD9myB2eDlJFCFbf+c/RwCrbwslNY7E4//V9LWbZ6DiRBdYJeWzyXiVc6vMlkFIsiWdGSzdrJ
	poOHcdxzaBKXtkxRa99w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwMgW-0006u8-Jf; Wed, 20 Feb 2019 07:52:52 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMgS-0006sF-4b; Wed, 20 Feb 2019 07:52:49 +0000
X-UUID: c718cc9e1bfc4cf392ba2cd7b611d0aa-20190219
X-UUID: c718cc9e1bfc4cf392ba2cd7b611d0aa-20190219
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <jerry-ch.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1903481067; Tue, 19 Feb 2019 23:52:43 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 23:52:41 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 15:52:33 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 20 Feb 2019 15:52:33 +0800
From: Jerry-ch Chen <Jerry-Ch.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 0/7] media: platform: Add support for Face Detection
 (FD) on mt8183 SoC
Date: Wed, 20 Feb 2019 15:48:06 +0800
Message-ID: <1550648893-42050-1-git-send-email-Jerry-Ch.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 430434F4B5B73D6AB60BAACB55FFBAD7B0A93BCBD88D341970DFC58BA2B1D5012000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_235248_215117_D618DE76 
X-CRM114-Status: GOOD (  10.48  )
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

This is the first version of the RFC patch series adding Face Detection
(FD) driver on Mediatek mt8183 SoC, which will be used in camera features
on CrOS application. It belongs to the first Mediatek's camera driver
series based on V4L2 and media controller framework. I posted the main part
of the FD driver as RFC to discuss first and would like some review
comments on the overall structure of the driver.

Face Detection (FD) unit provide hardware accelerated face detection
feature. It can detect different sizes of faces in a given image.
Furthermore, it has the capability to detect the faces of Rotation-in-Plane
from -180 to +180 degrees and Rotation-off-Plane from -90 to +90 degrees.

The driver is implemented with V4L2 and media controller framework. We have
the following entities describing the FD path.

1. Meta input (output video device): connects to FD sub device. It accepts
   the input parameter buffer from userspace. The metadata interface used
   currently is only a temporary solution to kick off driver development
   and is not ready for reviewed yet.

2. RAW (output video device): connects to FD sub device. It accepts input
   image buffer from userspace.

3. FD (sub device): connects to Meta output. When processing an image,
   FD hardware only returns the statistics of detected faces so it needs
   only one capture video devices to return the streaming data to the user.

4. Meta output (capture video device): Return the result of detected faces
   as metadata output.

   The overall file structure of the FD driver is as following:

* mtk_fd-dev-ctx-core.c: Implements common software flow of FD driver.
* mtk_fd-v4l2.c: Static FD contexts configuration.
* mtk_fd.c: Controls the hardware flow.
* mtk_fd-dev.c: Implements context-independent flow.
* mtk_fd-ctrl.c: Handles the HW ctrl request from userspace.
* mtk_fd-smem-drv.c: Provides the shared memory management required
operation. We reserved a memory region for the co-processor and FD to
exchange the hardware configuration data.
* mtk_fd-v4l2-util.c: Implements V4L2 and vb2 ops.

Jerry-ch Chen (7):
  dt-bindings: mt8183: Add binding for FD shared memory
  dts: arm64: mt8183: Add FD shared memory node
  dt-bindings: mt8183: Added FD-SMEM dt-bindings
  dt-bindings: mt8183: Added FD dt-bindings
  dts: arm64: mt8183: Add FD nodes
  media: platform: Add Mediatek FD driver KConfig
  platform: mtk-isp: Add Mediatek FD driver

 .../devicetree/bindings/media/mediatek,fd_smem.txt |   28 +
 .../bindings/media/mediatek,mt8183-fd.txt          |   30 +
 .../mediatek,reserve-memory-fd_smem.txt            |   44 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   28 +
 drivers/media/platform/Kconfig                     |    2 +
 drivers/media/platform/mtk-isp/Kconfig             |   10 +
 drivers/media/platform/mtk-isp/Makefile            |   16 +
 drivers/media/platform/mtk-isp/fd/Makefile         |   38 +
 drivers/media/platform/mtk-isp/fd/mtk_fd-core.h    |  157 +++
 drivers/media/platform/mtk-isp/fd/mtk_fd-ctx.h     |  299 ++++++
 .../platform/mtk-isp/fd/mtk_fd-dev-ctx-core.c      |  917 +++++++++++++++++
 drivers/media/platform/mtk-isp/fd/mtk_fd-dev.c     |  355 +++++++
 drivers/media/platform/mtk-isp/fd/mtk_fd-dev.h     |  198 ++++
 .../media/platform/mtk-isp/fd/mtk_fd-smem-drv.c    |  452 +++++++++
 drivers/media/platform/mtk-isp/fd/mtk_fd-smem.h    |   25 +
 .../media/platform/mtk-isp/fd/mtk_fd-v4l2-util.c   | 1046 ++++++++++++++++++++
 drivers/media/platform/mtk-isp/fd/mtk_fd-v4l2.c    |  115 +++
 drivers/media/platform/mtk-isp/fd/mtk_fd-v4l2.h    |   36 +
 drivers/media/platform/mtk-isp/fd/mtk_fd.c         |  730 ++++++++++++++
 drivers/media/platform/mtk-isp/fd/mtk_fd.h         |  127 +++
 20 files changed, 4653 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,fd_smem.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8183-fd.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt
 create mode 100644 drivers/media/platform/mtk-isp/Kconfig
 create mode 100644 drivers/media/platform/mtk-isp/Makefile
 create mode 100644 drivers/media/platform/mtk-isp/fd/Makefile
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-core.h
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-ctx.h
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-dev-ctx-core.c
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-dev.c
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-dev.h
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-smem-drv.c
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-smem.h
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-v4l2-util.c
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-v4l2.c
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd-v4l2.h
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd.c
 create mode 100644 drivers/media/platform/mtk-isp/fd/mtk_fd.h

-- 
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
