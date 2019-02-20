Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568B5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:55:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB102083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EGKvwb2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB102083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1iRMsfZ1W5ZIeH6WDlgn3AXjBS+Fh7gFqySIHgoMXWQ=; b=EGKvwb2hquetJI
	Gm9c9UWfBbd1Gzb41mj8tPbMZnZU7uTVvLvHiGL+OjNzTh2tRf19hTsjX6uJZpN3g6XS6YvNjzt4g
	vMz/7/eNSVq1lf31lG3gBRU0ojrdlDrdaQQofTG0IHmX/wh2Z4PlH5ahjC4cciiV9GWxXtg55rd8v
	ouBfFTrZXsmW0jfiGlLUCywf5MUhpycsNUM/PfBiuKUaZa2FcVE1VXmdfbgEaFzcnu1dqziS+unXd
	se4RSss7DEHzl6c8Yi2eKBjnxd2ICd/SxSUheeXVnHA1rOSeUGhO7V0Ysvv8Y559M3QDw8d4okIpM
	39fKDKm/3x3k/xPrjMFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwMig-0000rp-Qf; Wed, 20 Feb 2019 07:55:06 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMi0-0008Ul-W8; Wed, 20 Feb 2019 07:54:26 +0000
X-UUID: 5680262d2d054d1b8a620681aba505cf-20190219
X-UUID: 5680262d2d054d1b8a620681aba505cf-20190219
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <jerry-ch.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1917060234; Tue, 19 Feb 2019 23:53:10 -0800
Received: from MTKMBS06N2.mediatek.inc (172.21.101.130) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 23:53:09 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 15:53:07 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 20 Feb 2019 15:53:07 +0800
From: Jerry-ch Chen <Jerry-Ch.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 4/7] [media] dt-bindings: mt8183: Added FD dt-bindings
Date: Wed, 20 Feb 2019 15:48:10 +0800
Message-ID: <1550648893-42050-5-git-send-email-Jerry-Ch.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550648893-42050-1-git-send-email-Jerry-Ch.chen@mediatek.com>
References: <1550648893-42050-1-git-send-email-Jerry-Ch.chen@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: D00B037DE5B09A9535FA6E07DB648BC8A9B799E9CB79082D304071DCDCD14E0D2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_235425_188674_52AA6CB3 
X-CRM114-Status: GOOD (  10.02  )
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
 Jerry-ch Chen <jerry-ch.chen@mediatek.com>, jungo.lin@mediatek.com,
 sj.huang@mediatek.com, yuzhao@chromium.org, linux-mediatek@lists.infradead.org,
 zwisler@chromium.org, christie.yu@mediatek.com, frederic.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds DT binding documentation for the Face Detection (FD)
unit of the camera system on Mediatek's SoCs.

Signed-off-by: Jerry-ch Chen <jerry-ch.chen@mediatek.com>
---
 .../bindings/media/mediatek,mt8183-fd.txt          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8183-fd.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8183-fd.txt b/Documentation/devicetree/bindings/media/mediatek,mt8183-fd.txt
new file mode 100644
index 0000000..d8dbb89
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8183-fd.txt
@@ -0,0 +1,30 @@
+* Mediatek Face Detection Unit (FD)
+
+Face Detection (FD) unit is a typical memory-to-memory HW device.
+It provides hardware accelerated face detection function, and it
+is able to detect different poses of faces. FD will writre result
+of detected face into memory as output.
+
+Required properties:
+- compatible: "mediatek,fd"
+- reg: Must contain an entry for each entry in reg-names.
+- reg-names: Must include the following entries:
+- interrupts: interrupt number to the cpu.
+- clocks : clock name from clock manager
+- clock-names: must be main. It is the main clock of FD
+
+Example:
+	fd:fd@1502b000 {
+		compatible = "mediatek,fd";
+		mediatek,larb = <&larb5>;
+		mediatek,vpu = <&vpu>;
+		iommus = <&iommu M4U_PORT_CAM_FDVT_RP>,
+			 <&iommu M4U_PORT_CAM_FDVT_WR>,
+			 <&iommu M4U_PORT_CAM_FDVT_RB>;
+		reg = <0 0x1502b000 0 0x1000>;
+		interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&imgsys CLK_IMG_FDVT>;
+		clock-names = "FD_CLK_IMG_FDVT";
+		smem_device = <&fd_smem>;
+	};
+
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
