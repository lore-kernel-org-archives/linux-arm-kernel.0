Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17688C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:54:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8E82083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X7sCiqMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8E82083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DeU/QaxImFp43kg8sfsMreqoVdWUc0cF7zsJ1kXYgI8=; b=X7sCiqMbAlAwQ7
	0qDltRCAFe/GXuoGOmtG2Hk8+qCQG3pUFeJDegvvnKaHrHUvdtc/jWegbQSEViS7bs6aG2aQKiSsl
	7zEiypoHB7phVqS3/BrVOHl6zGYh4BRp5np+zUaRT7iPpF5oTcQXoca6EukgQv0M9Fz/vWS4EYJ/f
	va0r3LJiUWWWDiZ+xOJooD2dtUzMwslz+RcvXz5O4fB3TPbgudy5gtFr+wjAKZttXIZRV8OwbToie
	oQN37hc3P171JXIbrMonPfqp+LcmtBhsbhY9oUgJ7vYu9E7dZMB3yCLLNwExXYVj7IVUGzdez3vbs
	9dYRvpAMGJkrMYlFMSkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwMiJ-0000LR-7N; Wed, 20 Feb 2019 07:54:43 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMhz-0008Uf-G6; Wed, 20 Feb 2019 07:54:24 +0000
X-UUID: 6f0d2cf2bf78466696e89aefc8ce59bb-20190219
X-UUID: 6f0d2cf2bf78466696e89aefc8ce59bb-20190219
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <jerry-ch.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1668174344; Tue, 19 Feb 2019 23:53:10 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 23:53:08 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 15:53:07 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 20 Feb 2019 15:53:07 +0800
From: Jerry-ch Chen <Jerry-Ch.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 3/7] [media] dt-bindings: mt8183: Added FD-SMEM
 dt-bindings
Date: Wed, 20 Feb 2019 15:48:09 +0800
Message-ID: <1550648893-42050-4-git-send-email-Jerry-Ch.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550648893-42050-1-git-send-email-Jerry-Ch.chen@mediatek.com>
References: <1550648893-42050-1-git-send-email-Jerry-Ch.chen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_235423_569076_2B3880E7 
X-CRM114-Status: GOOD (  10.77  )
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

This patch adds the DT binding documentation for the shared memory
between Face Detection unit of the camera system and the co-processor
in Mediatek SoCs.

Signed-off-by: Jerry-ch Chen <jerry-ch.chen@mediatek.com>
---
 .../devicetree/bindings/media/mediatek,fd_smem.txt | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,fd_smem.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek,fd_smem.txt b/Documentation/devicetree/bindings/media/mediatek,fd_smem.txt
new file mode 100644
index 0000000..6f7c836
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,fd_smem.txt
@@ -0,0 +1,28 @@
+Mediatek FD Shared Memory Device
+
+Mediatek FD Shared Memory Device is used to manage shared memory
+among CPU, FD and coprocessor. It is associated with a reserved
+memory region (Please see Documentation/devicetree/bindings/
+reserved-memory/mediatek,reserve-memory-fd_smem.txt) and
+provide the context to allocate memory with dma addresses.
+
+Required properties:
+- compatible: Shall be "mediatek,fd_smem"
+
+- iommus: Shall point to the respective IOMMU block with master port
+  as argument. Please set the ports which may be accessed
+  through the common path. You can see
+  Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+  for the detail.
+
+- mediatek,larb: must contain the local arbiters in the current SoCs.
+  Please set the larb of imgsys for FD if you are using FD function.
+  You can see Documentation/devicetree/bindings/memory-controllers/
+  mediatek,smi-larb.txt for the detail.
+
+Example:
+	fd_smem: fd_smem {
+		compatible = "mediatek,fd_smem";
+		mediatek,larb = <&larb5>;
+		iommus = <&iommu M4U_PORT_CAM_IMGI>;
+	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
