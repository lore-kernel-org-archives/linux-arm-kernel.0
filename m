Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE95C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:53:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B69221904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VM1/Byem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B69221904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t5UdbRQcxBnigeAX6+WiES0DIF4ErToy21xdwbE1IFQ=; b=VM1/ByemtIYjHh
	QAngglwUTfeTQilhhfMzdK/yeYIzHckMUUDVxJk2o4w4v00lgayX8prlmrZwwpBnqivMPPXJ6v81g
	Cnh874lpA0Yif46KobfBeTvGd7mXA14lwETL00pDQSgISPe9c0xmdo9TmLn/u/eCME2UwumwYllS0
	N9d/ofAtOarsw65z80va3/lPNjydl04UZj61lgnWEZJ49vd2fneI6yrwYCGTUB9cg5draFfQJyLWd
	Ix91mi+tz5rPS51ydtjULCajeDeFVFP8QeWVqAdIwbOD5ARTaqXt9nBjtLUEE6+arPLuzSpvmDefJ
	0OVRlrwFfiGBsZwiqRog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwMgr-0007Cf-Ao; Wed, 20 Feb 2019 07:53:13 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMgn-0007Ay-4C; Wed, 20 Feb 2019 07:53:10 +0000
X-UUID: c8d8fa2edbcc4f84aa18fb3c74b10184-20190219
X-UUID: c8d8fa2edbcc4f84aa18fb3c74b10184-20190219
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <jerry-ch.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1856778887; Tue, 19 Feb 2019 23:53:04 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 23:53:03 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 15:52:55 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 20 Feb 2019 15:52:55 +0800
From: Jerry-ch Chen <Jerry-Ch.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 1/7] dt-bindings: mt8183: Add binding for FD shared
 memory
Date: Wed, 20 Feb 2019 15:48:07 +0800
Message-ID: <1550648893-42050-2-git-send-email-Jerry-Ch.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550648893-42050-1-git-send-email-Jerry-Ch.chen@mediatek.com>
References: <1550648893-42050-1-git-send-email-Jerry-Ch.chen@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: B24336EFC8304D9506677991F1EEC8AAE9653F2A267B11C35774AFD84F2FDB182000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_235309_166954_3F800EF2 
X-CRM114-Status: GOOD (  12.34  )
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

This patch adds the binding for describing the shared memory
used to exchange meta data between the co-processor and Face
Detection (FD) unit of the camera system on Mediatek SoCs.

Signed-off-by: Jerry-ch Chen <jerry-ch.chen@mediatek.com>
---
 .../mediatek,reserve-memory-fd_smem.txt            | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt

diff --git a/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt
new file mode 100644
index 0000000..52ae507
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt
@@ -0,0 +1,44 @@
+Mediatek FD Shared Memory binding
+
+This binding describes the shared memory, which serves the purpose of
+describing the shared memory region used to exchange data between Face
+Detection hardware (FD) and co-processor in Mediatek SoCs.
+
+The co-processor doesn't have the iommu so we need to use the physical
+address to access the shared buffer in the firmware.
+
+The Face Detection hardware (FD) can access memory through mt8183 IOMMU so
+it can use dma address to access the memory region.
+(See iommu/mediatek,iommu.txt for the detailed description of Mediatek IOMMU)
+
+
+Required properties:
+
+- compatible: must be "mediatek,reserve-memory-fd_smem"
+
+- reg: required for static allocation (see reserved-memory.txt for
+  the detailed usage)
+
+- alloc-range: required for dynamic allocation. The range must
+  between 0x00000400 and 0x100000000 due to the co-processer's
+  addressing limitation
+
+- size: required for dynamic allocation. The unit is bytes.
+  for Face Detection Unit, you need 1 MB at least.
+
+
+Example:
+
+The following example shows the FD shared memory setup for MT8183.
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		reserve-memory-fd_smem {
+			compatible = "mediatek,reserve-memory-fd_smem";
+			size = <0 0x00100000>;
+			alignment = <0 0x1000>;
+			alloc-ranges = <0 0x40000000 0 0x100000000>;
+		};
+	};
\ No newline at end of file
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
