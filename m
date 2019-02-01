Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E39EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:23:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A0520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVOBnNep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A0520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=goVX+sK3bAfyLgqOCrXOxIG6gCxCeDb2rUMRruMfLmE=; b=kVOBnNepaHY396
	opDCJPOZm+QqDEWeN8Ft9dX7Ku33Grd/pdcAFDN8OBCaqKDHR52fW0CC5HKOyLGvDS7Ef/ao5Gu+n
	h5lQk/1A4T5n38wIWHJaxyE1k+McDpL0bH4aUtMOREJxxSeWsunkXwXqAzWRQ4jb1lfiD7lSUUrrS
	hJ7GITVJWfipfPE/uSRY2LSpReN2YMMpButxA8mPcTEcXsZcSmK+Ulzz+Q1ozUr7oB/dqxzdKRXCc
	RTrwShDJJRcsrLNhd9YW1qn6T78+7Og5GXq+oWhVGYYZAQkXSoTmTuLbVjM1Uf+IlzCR0PBjPGi5F
	vH4xy3+lc8WUogdKRr2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpWvJ-0006PX-FQ; Fri, 01 Feb 2019 11:23:53 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpWuW-0004wI-4m; Fri, 01 Feb 2019 11:23:09 +0000
X-UUID: c91200be631142ad905903c636ad5b42-20190201
X-UUID: c91200be631142ad905903c636ad5b42-20190201
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <frederic.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1141625528; Fri, 01 Feb 2019 03:22:12 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 03:22:12 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 19:22:02 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 1 Feb 2019 19:22:01 +0800
From: Frederic Chen <frederic.chen@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 5/7] dts: arm64: mt8183: Add DIP nodes
Date: Fri, 1 Feb 2019 19:21:29 +0800
Message-ID: <1549020091-42064-6-git-send-email-frederic.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
References: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8F38E79912C2991C0398BEA6FBFA149941A0DA60F1D9670034E37428633EC11C2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_032304_358061_B97D4396 
X-CRM114-Status: UNSURE (   7.80  )
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
 sj.huang@mediatek.com, christie.yu@mediatek.com,
 linux-mediatek@lists.infradead.org, frederic.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds nodes for Digital Image Processing (DIP). DIP is
embedded in Mediatek SoCs and works with the co-processor to
adjust image content according to tuning input data. It also provides
image format conversion, resizing, and rotation features.

Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index fff67c4..19b2c13 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -377,6 +377,29 @@
 		#clock-cells = <1>;
 	};
 
+	dip_smem: dip_smem {
+		compatible = "mediatek,dip_smem";
+		mediatek,larb = <&larb5>;
+		iommus = <&iommu M4U_PORT_CAM_IMGI>;
+	};
+
+	dip: dip@15022000 {
+		compatible = "mediatek,mt8183-dip";
+		mediatek,larb = <&larb5>;
+		mediatek,mdp3 = <&mdp_rdma0>;
+		mediatek,vpu = <&vpu>;
+		iommus = <&iommu M4U_PORT_CAM_IMGI>;
+		reg = <0 0x15022000 0 0x6000>;
+		interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_LOW>;
+		clocks =
+				<&imgsys CLK_IMG_LARB5>,
+				<&imgsys CLK_IMG_DIP>;
+		clock-names =
+				"DIP_CG_IMG_LARB5",
+				"DIP_CG_IMG_DIP";
+		smem_device = <&dip_smem>;
+	};
+
 	vdecsys: syscon@16000000 {
 		compatible = "mediatek,mt8183-vdecsys", "syscon";
 		reg = <0 0x16000000 0 0x1000>;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
