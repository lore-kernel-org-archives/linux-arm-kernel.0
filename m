Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA353C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718E12075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tl7H0WCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718E12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ojZ34GRKr6fZ74g8GLsG/757DDV2TskNDgBira1SbA=; b=tl7H0WCHROn8sk
	QBkjoimiKw27AhiKMNsGakie6k8j97eFdK+FuaxX6H2G7G7TG1luyp4Tq1LUFYp1qB6E53/1hjgIf
	gaUwnXqWGTeJnod158JIgrd5Ey2wS2mOHBChF5SLVLvZWNg5akBu1Zs0c0cSe0UemrYiTbSLkJmMN
	ESHhxF6bBsP1kH+9MywDXUxp3fVzDQV29e0pUtDLEfDJ1gtnS6XAnCN78tZE6okEatT6Z3e0ghH4T
	YJoD3MB9TzAHMTnda89KZ6Shz7TM+EskkU1tCX4Rj2XFFlG6CfYA8dj+GkuRXjoafGwfnCZKvAi/9
	8amSRf8Z6+RXu8aklgJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcFg-0004lS-QI; Fri, 14 Dec 2018 01:26:52 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcEu-00042K-FA; Fri, 14 Dec 2018 01:26:07 +0000
X-UUID: 05ce704fa55e47f891ad6b3062800876-20181214
X-UUID: 05ce704fa55e47f891ad6b3062800876-20181214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <honghui.zhang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2041086221; Fri, 14 Dec 2018 09:25:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 09:25:46 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:25:45 +0800
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>, 
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ryder.lee@mediatek.com>, <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
 <robh@kernel.org>
Subject: [PATCH 2/4] dt-bindings: PCI: MediaTek: Remove un-used property
Date: Fri, 14 Dec 2018 09:25:40 +0800
Message-ID: <1544750742-31419-3-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
References: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 476BBAF8048127866DD3CAE02BA0EED37B745FED16F4473F0C8DCC23C07537D52000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_172604_739175_E3BD43EB 
X-CRM114-Status: UNSURE (   6.45  )
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
 jianjun.wang@mediatek.com, Honghui Zhang <honghui.zhang@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The "num-lanes" property is not used, remove it.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 20227a8..92437a3 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -65,7 +65,6 @@ Required properties:
   explanation.
 - ranges: Sub-ranges distributed from the PCIe controller node. An empty
   property is sufficient.
-- num-lanes: Number of lanes to use for this port.
 
 Examples for MT7623:
 
@@ -118,7 +117,6 @@ Examples for MT7623:
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
 			ranges;
-			num-lanes = <1>;
 		};
 
 		pcie@1,0 {
@@ -129,7 +127,6 @@ Examples for MT7623:
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
 			ranges;
-			num-lanes = <1>;
 		};
 
 		pcie@2,0 {
@@ -140,7 +137,6 @@ Examples for MT7623:
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
 			ranges;
-			num-lanes = <1>;
 		};
 	};
 
@@ -172,7 +168,6 @@ Examples for MT2712:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
 					<0 0 0 2 &pcie_intc0 1>,
@@ -191,7 +186,6 @@ Examples for MT2712:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
 					<0 0 0 2 &pcie_intc1 1>,
@@ -245,7 +239,6 @@ Examples for MT7622:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
 					<0 0 0 2 &pcie_intc0 1>,
@@ -264,7 +257,6 @@ Examples for MT7622:
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges;
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
 					<0 0 0 2 &pcie_intc1 1>,
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
