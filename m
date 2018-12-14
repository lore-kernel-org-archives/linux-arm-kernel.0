Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D6C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623872075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EloZ1wvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623872075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VvtunYyGEOERmrelc2I4zezAYOypummFinM//LfxqXI=; b=EloZ1wvYMZqvq1
	SIZZIGaB4nK71Sr6REATn6EP64WTzMyEuz43CTezMhw7nm9PzNym4tGUcDRklAGjKE08nOka2fjYT
	1pawL9NRC/G7TyfXSPfnXhJ6iwUyXYuzx69goxcqadgQ+SVOe/RdDAlabcponeNdI6r8BN7iNtdPi
	hceG4brP/LmT7pqAq8dYL7EOT8Z8Stj7lYD8sLbx8XUFiD3y2ZN3xBnPvOhfYrA+ruHogUUS73uzn
	Oa60ddZdO+19qHpOQvaHQrulgQkdyz6DjL7gnUTHqMhjXlbAX1OtqUR+RGmDR7y9cDrc92bPyMb8P
	yJAQ8hCifmvoen7Ckvow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcFs-0004wJ-44; Fri, 14 Dec 2018 01:27:04 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcEx-00042I-0H; Fri, 14 Dec 2018 01:26:08 +0000
X-UUID: 42e937a1b6194ef0802b405786a2c17d-20181214
X-UUID: 42e937a1b6194ef0802b405786a2c17d-20181214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <honghui.zhang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 956507524; Fri, 14 Dec 2018 09:25:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 09:25:48 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:25:47 +0800
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>, 
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ryder.lee@mediatek.com>, <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
 <robh@kernel.org>
Subject: [PATCH 4/4] arm64: dts: mt7622: Remove un-used property for PCIe
Date: Fri, 14 Dec 2018 09:25:42 +0800
Message-ID: <1544750742-31419-5-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
References: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 879A224954563394A6F87C97A25AF00FB82AA502720284E2262449B230922BF52000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_172607_170593_3F3919F8 
X-CRM114-Status: UNSURE (   7.06  )
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

The "num-lanes" property for PCIe is not used, remove it.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index de2c47bd..f619eb5 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -750,7 +750,6 @@
 			ranges;
 			status = "disabled";
 
-			num-lanes = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
 					<0 0 0 2 &pcie_intc0 1>,
@@ -771,7 +770,6 @@
 			ranges;
 			status = "disabled";
 
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
