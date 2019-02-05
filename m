Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C5C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:44:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEBB2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VtZqHPKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEBB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ACCp9FIbLAYNHFVRh1ICjZWW1HuHhpIDSLTQwDFXWhE=; b=VtZqHPKQQZIRUo
	NpMZSH6QV5LzNmKmSOmEX3wHXCS7BZFoY+Ucu3NlMW8t9Brzzq7r7v6VA5tpniXxZVNx0sCQLW3EB
	Mz5B06S6mROH2Gu1xFj/wzZba3ruY7blK7gkflI2bfubFJE7/zWCZBfKnrPmsnIvPOHU/14UQJfGm
	mS14ggeGTCee8PrhHrokNNIWLab+DClaB1MeYCRwScew2H8wGFWxcnn08o2t112F6OrHhPgGMzmWu
	ziFmLkCgfE1gEDeg5aeF41PNNsGy/2Ni2j+eX+RootRym7TAD6u9U3jg1j0ceQ8j1UehUx3obk2Hp
	2Fq93dvaWHLeZrIQ0ivQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gquTF-0004y9-FM; Tue, 05 Feb 2019 06:44:37 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gquSa-0004NW-UU; Tue, 05 Feb 2019 06:44:10 +0000
X-UUID: 848c944b6839477db6f2c805c38602e9-20190204
X-UUID: 848c944b6839477db6f2c805c38602e9-20190204
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <frederic.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1627860560; Mon, 04 Feb 2019 22:43:37 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 4 Feb 2019 22:43:36 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Feb 2019 14:43:23 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 5 Feb 2019 14:43:23 +0800
From: Frederic Chen <frederic.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 6/7] media: platform: Add Mediatek ISP Pass 1 driver
 KConfig
Date: Tue, 5 Feb 2019 14:42:45 +0800
Message-ID: <1549348966-14451-7-git-send-email-frederic.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549348966-14451-1-git-send-email-frederic.chen@mediatek.com>
References: <1549348966-14451-1-git-send-email-frederic.chen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_224357_186012_46D9D0EB 
X-CRM114-Status: UNSURE (   9.27  )
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

This patch adds KConfig for Pass 1 (P1) unit driver of Mediatek's
camera ISP system. ISP P1 unit is embedded in Mediatek SOCs. It
provides RAW processing which includes optical black correction,
defect pixel correction, W/IR imbalance correction and lens
shading correction.

Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
---
 drivers/media/platform/Kconfig         |  2 ++
 drivers/media/platform/mtk-isp/Kconfig | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 drivers/media/platform/mtk-isp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index a505e9f..ef08d48 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -32,6 +32,8 @@ source "drivers/media/platform/davinci/Kconfig"
 
 source "drivers/media/platform/omap/Kconfig"
 
+source "drivers/media/platform/mtk-isp/Kconfig"
+
 config VIDEO_ASPEED
 	tristate "Aspeed AST2400 and AST2500 Video Engine driver"
 	depends on VIDEO_V4L2
diff --git a/drivers/media/platform/mtk-isp/Kconfig b/drivers/media/platform/mtk-isp/Kconfig
new file mode 100644
index 0000000..999eb24
--- /dev/null
+++ b/drivers/media/platform/mtk-isp/Kconfig
@@ -0,0 +1,21 @@
+config VIDEO_MEDIATEK_ISP_PASS1_SUPPORT
+	bool "Mediatek pass 1 image processing function"
+
+	select DMA_SHARED_BUFFER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_CORE
+	select VIDEOBUF2_V4L2
+	select VIDEOBUF2_MEMOPS
+	select VIDEOBUF2_VMALLOC
+	select MEDIA_CONTROLLER
+
+	default n
+	help
+		Pass 1 driver controls 3A (autofocus, exposure,
+		and white balance) with tuning feature and output
+		the first capture image buffer in Mediatek's camera system.
+
+		Choose y if you want to use Mediatek SoCs to create image
+		vcapture application such as video recording and still image
+		capture.
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
