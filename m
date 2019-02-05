Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F186C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32B52080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mf1L07bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32B52080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZxaevwHdNurSThTmzyw5KzIkPgzGMU649sAXepqMqzA=; b=Mf1L07bJ4zb1lm
	SElIB3czP0ZU03Aba6KvXWBkukmp+/xITHN/Idaz5hsfNFUsQeg38DP61rZkQ6CrT/DoIFC67RyZT
	DyhmOQCEXKSQK6k34XVR5teRxWk6uUudkUout6VgJNdGMkMxNKdYbGFzxpwNPTwLpaD2g4YbPsvtF
	0xeJbSIiqe0IllKOJNQJtmZMYjhYdzWk7bsBid0pBxKALKCLKeTWqSy44wAdIuSv4jJNz1VDxl4EX
	gh4QWR6ywkEFy20X8qwvfLR7qij3NxrF8t3oJVy29QmTryHgONNHyzZnn/gh7L1pDe+NIvvhYmCfu
	BJNvdLYnft9YsfEXvc6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gquRv-0003xr-8s; Tue, 05 Feb 2019 06:43:15 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gquRr-0003wf-P5; Tue, 05 Feb 2019 06:43:13 +0000
X-UUID: 88ad86ddde254a34a6af378c52a5deac-20190204
X-UUID: 88ad86ddde254a34a6af378c52a5deac-20190204
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <frederic.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2072108690; Mon, 04 Feb 2019 22:43:07 -0800
Received: from MTKMBS06N1.mediatek.inc (172.21.101.129) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 4 Feb 2019 22:43:05 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Feb 2019 14:43:03 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 5 Feb 2019 14:43:03 +0800
From: Frederic Chen <frederic.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 0/7] media: platform: Add support for ISP Pass 1 on
 mt8183 SoC 
Date: Tue, 5 Feb 2019 14:42:39 +0800
Message-ID: <1549348966-14451-1-git-send-email-frederic.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_224311_824310_BF12B852 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: Sean.Cheng@mediatek.com, Rynn.Wu@mediatek.com, srv_heupstream@mediatek.com,
 holmes.chiou@mediatek.com, Jerry-ch.Chen@mediatek.com, jungo.lin@mediatek.com,
 sj.huang@mediatek.com, yuzhao@chromium.org, christie.yu@mediatek.com,
 zwisler@chromium.org, linux-mediatek@lists.infradead.org,
 frederic.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This is a first version of the RFC patch series adding the driver for
Pass 1 (P1) unit in Mediatek's camera ISP system on mt8183 SoC, which
will be used in camera features of CrOS. It's the first time Mediatek
develops ISP kernel drivers based on V4L2 and media controller
framework. I posted the main part of the ISP Pass 1 driver as RFC to
discuss first and would like some review comments on the overall
architecture of the driver.

Pass 1 unit processes image signal from sensor devices and accepts the
tuning parameters to adjust the image quality. It performs optical
black correction, defect pixel correction, W/IR imbalance correction
and lens shading correction for RAW processing.

The driver is implemented with V4L2 and media controller framework so
we have the following entities to describe the ISP pass 1 path. (The
current metadata interface used in meta input and partial meta nodes
is only a temporary solution to kick off the driver development and is
not ready to be reviewed yet):

1. meta input (output video device): connects to ISP P1 sub device. It
accepts the tuning buffer from user.

2. ISP P1 (sub device): connects to partial meta 0, partial meta 1,
main stream and packed out video devices. When processing an image,
Pass 1 hardware supports multiple output images with different sizes
and formats so it needs two capture video devices ("main stream" and
"packed out") to return the image data to the user.

3. partial meta 0 (capture video device): return the statistics
metadata.

4. partial meta 1 (capture video device): return the statistics
metadata.

5. main stream (capture video device): return the processed image data
which is used in capture scenario.

6. packed out (capture video device): return the processed image data
which is used in preview scenario.

The overall file structure of the ISP Pass 1 driver is as following:

* mtk_cam.c: Controls the hardware dependent flow and configuration.
* mtk_cam-v4l2.c: High-level software context configuration.
* mtk_cam-v4l2-util.c: Implements V4L2 and vb2 ops.
* mtk_cam-dev-ctx-core.c: Common software flow of the driver.
* mtk_cam-dev.c: Implements context independent flow.
* mtk_cam-vpu.c: Communicates with the co-processor on the SoC through
  the VPU driver.
* mtk_cam-smem-drv.c: Provides the shared memory management required
  operations. We reserved a memory region for the co-processor and
  Pass 1 unit to exchange the tuning and configuration data.


Frederic Chen (2):
  [media] dt-bindings: mt8183: Add binding for ISP Pass 1 shared memory
  media: platform: Add Mediatek ISP Pass 1 driver KConfig

Jungo Lin (5):
  dts: arm64: mt8183: Add ISP Pass 1 shared memory node
  [media] dt-bindings: mt8183: Added CAM-SMEM dt-bindings
  [media] dt-bindings: mt8183: Added camera ISP Pass 1 dt-bindings
  dts: arm64: mt8183: Add ISP Pass 1 nodes
  [media] platform: mtk-isp: Add Mediatek ISP Pass 1 driver

 .../bindings/media/mediatek,cam_smem.txt           |   32 +
 .../bindings/media/mediatek,mt8183-camisp.txt      |   59 +
 .../mediatek,reserve-memory-cam_smem.txt           |   44 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   54 +
 drivers/media/platform/Kconfig                     |    2 +
 drivers/media/platform/Makefile                    |    2 +
 drivers/media/platform/mtk-isp/Kconfig             |   21 +
 drivers/media/platform/mtk-isp/Makefile            |   14 +
 drivers/media/platform/mtk-isp/isp_50/Makefile     |   17 +
 drivers/media/platform/mtk-isp/isp_50/cam/Makefile |   35 +
 .../platform/mtk-isp/isp_50/cam/mtk_cam-ctx.h      |  327 ++++
 .../mtk-isp/isp_50/cam/mtk_cam-dev-ctx-core.c      |  986 +++++++++++++
 .../platform/mtk-isp/isp_50/cam/mtk_cam-dev.c      |  381 +++++
 .../platform/mtk-isp/isp_50/cam/mtk_cam-dev.h      |  204 +++
 .../platform/mtk-isp/isp_50/cam/mtk_cam-regs.h     |  146 ++
 .../platform/mtk-isp/isp_50/cam/mtk_cam-smem-drv.c |  452 ++++++
 .../platform/mtk-isp/isp_50/cam/mtk_cam-smem.h     |   27 +
 .../mtk-isp/isp_50/cam/mtk_cam-v4l2-util.c         | 1555 ++++++++++++++++++++
 .../mtk-isp/isp_50/cam/mtk_cam-v4l2-util.h         |   49 +
 .../platform/mtk-isp/isp_50/cam/mtk_cam-v4l2.c     |  288 ++++
 .../platform/mtk-isp/isp_50/cam/mtk_cam-v4l2.h     |   40 +
 .../platform/mtk-isp/isp_50/cam/mtk_cam-vpu.c      |  466 ++++++
 .../platform/mtk-isp/isp_50/cam/mtk_cam-vpu.h      |  158 ++
 .../media/platform/mtk-isp/isp_50/cam/mtk_cam.c    | 1235 ++++++++++++++++
 .../media/platform/mtk-isp/isp_50/cam/mtk_cam.h    |  347 +++++
 25 files changed, 6941 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,cam_smem.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8183-camisp.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-cam_smem.txt
 create mode 100644 drivers/media/platform/mtk-isp/Kconfig
 create mode 100644 drivers/media/platform/mtk-isp/Makefile
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/Makefile
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/Makefile
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-ctx.h
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-dev-ctx-core.c
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-dev.c
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-dev.h
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-regs.h
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem-drv.c
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem.h
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-v4l2-util.c
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-v4l2-util.h
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-v4l2.c
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-v4l2.h
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-vpu.c
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-vpu.h
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam.c
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam.h

-- 
1.9.1




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
