Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21E5C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:23:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F25521904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hqrJnCbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F25521904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+KQ0HOaZEjLdwOMfsM45t4fcqKB4IEBLf0PfyVroQDc=; b=hqrJnCbMqmryLl
	7TyU9i+gGO048c/X+Qrw9RNa4BGKxSTMhbakeykxsFbaEVf3JOXh+xSaZTJYYKMqPtcL6D8sNyH6e
	VwWbnSfk4AIusI/pNOEYyjHwyWy3XO/6/5tRLLnnnVMuTNssvX5VrU6hYzyJptXNgG3E4hu0zctvd
	i+5mrf8mkdVkGVmfDb+eANnU0FHYFDNDL82LDXIYFKbI+Pk23JhbWsJlyLnmWF3IwYCAeQRedS5GY
	eLlzBgdzpmGoOGPnVSLnQ68ZfUaXQAFw+Uljur6t0Wo1U0GaBvMnNTm1yMFoFKNuVlcdwOiLBnlEB
	5hdtCQta6PYv4BQQEfVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpWv2-00064o-Ju; Fri, 01 Feb 2019 11:23:36 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpWuR-0004wI-6E; Fri, 01 Feb 2019 11:23:04 +0000
X-UUID: ec6ffa7e524e4daba6cdde1be0945388-20190201
X-UUID: ec6ffa7e524e4daba6cdde1be0945388-20190201
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <frederic.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 714081186; Fri, 01 Feb 2019 03:22:03 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 03:22:02 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 19:21:59 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 1 Feb 2019 19:22:00 +0800
From: Frederic Chen <frederic.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 3/7] [media] dt-bindings: mt8183: Added DIP-SMEM
 dt-bindings
Date: Fri, 1 Feb 2019 19:21:27 +0800
Message-ID: <1549020091-42064-4-git-send-email-frederic.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
References: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_032259_349070_4D50FDE7 
X-CRM114-Status: GOOD (  10.56  )
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
 sj.huang@mediatek.com, christie.yu@mediatek.com,
 linux-mediatek@lists.infradead.org, frederic.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the DT binding documentation for the shared memory
between DIP (Digital Image Processing) unit of the camera ISP system
and the co-processor in Mediatek SoCs.

Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
---
 .../bindings/media/mediatek,dip_smem.txt           | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,dip_smem.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek,dip_smem.txt b/Documentation/devicetree/bindings/media/mediatek,dip_smem.txt
new file mode 100644
index 0000000..5533721
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,dip_smem.txt
@@ -0,0 +1,29 @@
+Mediatek ISP Shared Memory Device
+
+Mediatek ISP Shared Memory Device is used to manage shared memory
+among CPU, ISP IPs and coprocessor. It is associated with a reserved
+memory region (Please see Documentation\devicetree\bindings\
+reserved-memory\mediatek,reserve-memory-isp_smem.txt) and
+and provide the context to allocate memory with dma addresses.
+
+Required properties:
+- compatible: Should be "mediatek,isp_smem"
+
+- iommus: should point to the respective IOMMU block with master port
+  as argument. Please set the ports which may be accessed
+  through the common path. You can see
+  Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+  for the detail.
+
+- mediatek,larb: must contain the local arbiters in the current Socs.
+  Please set the larb of camsys for Pass 1 and imgsys for DIP, or both
+  if you are using all the camera function. You can see
+  Documentation/devicetree/bindings/memory-controllers/
+  mediatek,smi-larb.txt for the detail.
+
+Example:
+	isp_smem: isp_smem {
+		compatible = "mediatek,isp_smem";
+		mediatek,larb = <&larb5>;
+		iommus = <&iommu M4U_PORT_CAM_IMGI>;
+	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
