Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D4C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:45:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5300F2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LWO4bjKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5300F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nw7K0yOlQR63nrd72owu8zYt9kznpZp+uSA6ZV8vG1U=; b=LWO4bjKDaTRlGM
	E+2DGcAFitJ+4heXcwKLrXTr9nO6jHheMM5ehoDb9lY7ObecGPAe1XA24Ji4k62NPGlfypEwYaYRt
	HUO3QP3nERZOFfQdkRUcISU9TY2HhSdYlXN3gf/400vaFm4Osp5hdxNKuPOTtbwpC69PoXu4N9MxG
	vfpTWsak/U3oUXYgtvyl0a6FHUSjvQE9B9LRGSUO+mIk6ATpYehTqN3pvPBtoYcVEWLGj73hXLXCI
	l5/6C+4FfIqVPhHFuoDQXv42XsOB/1LPgsYdmV/GNg0hxwwocprBb3dtYs+/MuRi03AT+ROwVMR8k
	q+DXsp74gmekatdswUaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gquTs-00061C-4G; Tue, 05 Feb 2019 06:45:16 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gquSn-0004Me-5z; Tue, 05 Feb 2019 06:44:16 +0000
X-UUID: 23b656b935944fde93bc79fb425192cd-20190204
X-UUID: 23b656b935944fde93bc79fb425192cd-20190204
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <frederic.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 773099852; Mon, 04 Feb 2019 22:43:37 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 4 Feb 2019 22:43:35 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Feb 2019 14:43:21 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 5 Feb 2019 14:43:21 +0800
From: Frederic Chen <frederic.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 4/7] [media] dt-bindings: mt8183: Added camera ISP Pass
 1 dt-bindings
Date: Tue, 5 Feb 2019 14:42:43 +0800
Message-ID: <1549348966-14451-5-git-send-email-frederic.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549348966-14451-1-git-send-email-frederic.chen@mediatek.com>
References: <1549348966-14451-1-git-send-email-frederic.chen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_224409_672224_13E5CD4C 
X-CRM114-Status: UNSURE (   9.55  )
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

From: Jungo Lin <jungo.lin@mediatek.com>

This patch adds DT binding document for the Pass 1 (P1) unit in
Mediatek's camera ISP system. The Pass 1 unit grabs the sensor data
out from the sensor interface, applies ISP effects and writes the
image data to DRAM.

Signed-off-by: Jungo Lin <jungo.lin@mediatek.com>
Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
---
 .../bindings/media/mediatek,mt8183-camisp.txt      | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8183-camisp.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8183-camisp.txt b/Documentation/devicetree/bindings/media/mediatek,mt8183-camisp.txt
new file mode 100644
index 0000000..ba16b4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8183-camisp.txt
@@ -0,0 +1,59 @@
+* Mediatek Image Signal Processor Pass 1 (ISP P1)
+
+The Pass 1 unit of Mediatek's camera ISP system grabs the sensor data out
+from the sensor interface, applies ISP effects and writes the image data
+to DRAM. Furthermore, Pass 1 unit has the ability to output two different
+resolutions frames at the same time to increase the performance of the
+camera application.
+
+Required properties:
+- compatible: "mediatek,mt8183-camisp" for MT8183
+- reg: Must contain an entry for each entry in reg-names.
+- interrupts: interrupt number to the cpu.
+- iommus: should point to the respective IOMMU block with master port
+  as argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+  for details.
+- power-domains : a phandle to the power domain of this local arbiter.
+- mediatek,smi : a phandle to the smi_common node.
+- clocks: device clocks, see
+  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
+- clock-names: must be "CAMSYS_CAM_CGPDN" and "CAMSYS_CAMTG_CGPDN".
+- mediatek,larb: must contain the local arbiters in the current SOCs, see
+  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+  for details.
+- mediatek,vpu : the node of video processor unit
+- smem_device : the shared memory device managing the shared memory between
+  Pass 1 unit and the video processor unit
+
+Example:
+	camisp: camisp@1a000000 {
+		compatible = "mediatek,mt8183-camisp", "syscon";
+		reg = <0 0x1a000000 0 0x1000>,
+		      <0 0x1a003000 0 0x1000>,
+		      <0 0x1a004000 0 0x2000>,
+		      <0 0x1a006000 0 0x2000>;
+		reg-names = "camisp",
+		            "cam1",
+		            "cam2",
+		            "cam3";
+		interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 254 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 255 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "cam1",
+		            "cam2",
+		            "cam3";
+		iommus = <&iommu M4U_PORT_CAM_LSCI0>,
+				<&iommu M4U_PORT_CAM_LSCI1>,
+				<&iommu M4U_PORT_CAM_BPCI>;
+		#clock-cells = <1>;
+		power-domains = <&scpsys MT8183_POWER_DOMAIN_CAM>;
+		/* Camera CCF */
+		clocks = <&camsys CLK_CAM_CAM>,
+				<&camsys CLK_CAM_CAMTG>;
+		clock-names = "CAMSYS_CAM_CGPDN",
+				"CAMSYS_CAMTG_CGPDN";
+		mediatek,larb = <&larb3>,
+				<&larb6>;
+		mediatek,vpu = <&vpu>;
+		smem_device = <&cam_smem>;
+	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
