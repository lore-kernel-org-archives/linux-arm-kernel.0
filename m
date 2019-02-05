Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D082AC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:45:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7C32080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oMTZlJmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7C32080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9gX5Jb4/9riPhRUqvSc/tSYBrnRDlbRDaikXyFnFTUE=; b=oMTZlJmfe2LE2/
	stBPJpUQVPYYjE37aEFGlxFGcf3R195LzHx/iVAmACOYV9ABs2LnPkD1F3JurmYc5rGa1C4RhB2EJ
	WHaL5b1Q9us58TQb5we1YiuApTk9JIrsiMQkzuExoweDBKoQ9ydtYmBWgoz9UK9YTeddCqRtAi5cg
	KpjDOmDjO7wRQWPFZBJibhVJmAocPd+jxeExayN9o8UvSXo32H7jFAP+UAT2PyTlZy7fVxD5MZNbE
	3S4TaFwn4b06ThyOlM92BhDKPN+P30s6RR84ywv3FW0xSDvtz7O1YERIiw7/YkoxGU1uXSfXSWEgp
	mG6joSUeq12PTHUYRyLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gquTa-0005H0-BV; Tue, 05 Feb 2019 06:44:58 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gquSo-0004NW-2e; Tue, 05 Feb 2019 06:44:17 +0000
X-UUID: fb7f7977d87545d89713f59791ce3263-20190204
X-UUID: fb7f7977d87545d89713f59791ce3263-20190204
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <frederic.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 374182805; Mon, 04 Feb 2019 22:43:35 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 4 Feb 2019 22:43:34 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Feb 2019 14:43:22 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 5 Feb 2019 14:43:22 +0800
From: Frederic Chen <frederic.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 5/7] dts: arm64: mt8183: Add ISP Pass 1 nodes
Date: Tue, 5 Feb 2019 14:42:44 +0800
Message-ID: <1549348966-14451-6-git-send-email-frederic.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549348966-14451-1-git-send-email-frederic.chen@mediatek.com>
References: <1549348966-14451-1-git-send-email-frederic.chen@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 48D05ECA1E0ABAA1E13C76477FB115FB55BF55EE5553BBE37F37429512DC82C62000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_224410_529295_BE3CAE3C 
X-CRM114-Status: UNSURE (   7.39  )
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

Add nodes for Pass 1 unit of Mediatek's camera ISP system.
Pass 1 unit embedded in Mediatek SOCs, works with the
co-processor to process image signal from the image sensor
and output RAW data.

Signed-off-by: Jungo Lin <jungo.lin@mediatek.com>
Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 3b85a6c..780d2c5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -419,4 +419,44 @@
 		#clock-cells = <1>;
 	};
 
+	cam_smem: cam_smem {
+		compatible = "mediatek,cam_smem";
+		mediatek,larb = <&larb3>,
+				<&larb6>;
+		iommus = <&iommu M4U_PORT_CAM_LSCI0>,
+				<&iommu M4U_PORT_CAM_LSCI1>,
+				<&iommu M4U_PORT_CAM_BPCI>;
+	};
+
+	camisp: camisp@1a000000 {
+		compatible = "mediatek,mt8183-camisp", "syscon";
+		reg = <0 0x1a000000 0 0x1000>,
+			<0 0x1a003000 0 0x1000>,
+			<0 0x1a004000 0 0x2000>,
+			<0 0x1a006000 0 0x2000>;
+		reg-names = "camisp",
+					"cam1",
+					"cam2",
+					"cam3";
+		interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 254 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 255 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "cam1",
+					"cam2",
+					"cam3";
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
 };
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
