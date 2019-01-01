Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B663C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:55:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4749C2075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KZoq7H+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4749C2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o88+E7Got6X75IgksWqgFSlVxUeyoNHYQFKjDjz5j80=; b=KZoq7H+EuJjSp6
	y07dF5kmr7csNNiStZ4omf+wyYJG+VoLUkfP17fF9aZ+mh/tc5hOWn8GlQ8FKgDs/fbo4vYAd3VLg
	cx0pHSkl1fZ3y2wuJPjMxotsnFZEQaieq6VeudEqUavb3fP7rKc5TbpVxYaM3dYc4CWMofyYj2qS0
	NpoWS+QwSG/pz0fGx9VNI8U8OIAYhPicZMLGGn7L2zB7pGJVCJfinLbRDhGcI1VEiAQaHAIsXgph1
	l1Q9+79vi86rPydK8aR7Zb1M5+4psh8c3KrXvzx4PqoF8+4ecp9knWzz2trdlHrM1Ek7Ag+aooDIC
	zGj3N0sm2Wptw80zlrhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geC57-0004oD-Rz; Tue, 01 Jan 2019 04:55:09 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geC3Q-0003L1-30; Tue, 01 Jan 2019 04:53:34 +0000
X-UUID: 4f1f14697dcf4b0097fb12d719e229ab-20190101
X-UUID: 4f1f14697dcf4b0097fb12d719e229ab-20190101
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1195394036; Tue, 01 Jan 2019 12:53:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 12:53:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 12:53:17 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob
 Herring <robh+dt@kernel.org>
Subject: [PATCH 13/13] arm64: dts: mediatek: Get rid of mediatek,
 larb for MM nodes
Date: Tue, 1 Jan 2019 12:51:16 +0800
Message-ID: <1546318276-18993-14-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_205324_477295_4C9FBE9A 
X-CRM114-Status: UNSURE (   9.91  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

After adding device_link between the IOMMU consumer and smi,
the mediatek,larb is unnecessary now.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index abd2f15..8babd71 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -895,7 +895,6 @@
 				 <&mmsys CLK_MM_MUTEX_32K>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
-			mediatek,larb = <&larb0>;
 			mediatek,vpu = <&vpu>;
 		};
 
@@ -906,7 +905,6 @@
 				 <&mmsys CLK_MM_MUTEX_32K>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		mdp_rsz0: rsz@14003000 {
@@ -936,7 +934,6 @@
 			clocks = <&mmsys CLK_MM_MDP_WDMA>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WDMA>;
-			mediatek,larb = <&larb0>;
 		};
 
 		mdp_wrot0: wrot@14007000 {
@@ -945,7 +942,6 @@
 			clocks = <&mmsys CLK_MM_MDP_WROT0>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WROT0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		mdp_wrot1: wrot@14008000 {
@@ -954,7 +950,6 @@
 			clocks = <&mmsys CLK_MM_MDP_WROT1>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WROT1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		ovl0: ovl@1400c000 {
@@ -964,7 +959,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_OVL0>;
 			iommus = <&iommu M4U_PORT_DISP_OVL0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		ovl1: ovl@1400d000 {
@@ -974,7 +968,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_OVL1>;
 			iommus = <&iommu M4U_PORT_DISP_OVL1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		rdma0: rdma@1400e000 {
@@ -984,7 +977,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		rdma1: rdma@1400f000 {
@@ -994,7 +986,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		rdma2: rdma@14010000 {
@@ -1004,7 +995,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA2>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA2>;
-			mediatek,larb = <&larb4>;
 		};
 
 		wdma0: wdma@14011000 {
@@ -1014,7 +1004,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_WDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		wdma1: wdma@14012000 {
@@ -1024,7 +1013,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_WDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		color0: color@14013000 {
@@ -1268,7 +1256,6 @@
 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
 			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
-			mediatek,larb = <&larb1>;
 			iommus = <&iommu M4U_PORT_HW_VDEC_MC_EXT>,
 				 <&iommu M4U_PORT_HW_VDEC_PP_EXT>,
 				 <&iommu M4U_PORT_HW_VDEC_AVC_MV_EXT>,
@@ -1329,8 +1316,6 @@
 			      <0 0x19002000 0 0x1000>;	/* VENC_LT_SYS */
 			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>,
 				     <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
-			mediatek,larb = <&larb3>,
-					<&larb5>;
 			iommus = <&iommu M4U_PORT_VENC_RCPU>,
 				 <&iommu M4U_PORT_VENC_REC>,
 				 <&iommu M4U_PORT_VENC_BSDMA>,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
