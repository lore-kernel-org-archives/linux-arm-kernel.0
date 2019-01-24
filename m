Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E9AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:16:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28B621855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZBQjCdEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28B621855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KhKVdxM/QHMXuXGyUcQaQnOlV7f6gCd6EWcqYHFBRN8=; b=ZBQjCdEjKSWMYh
	4O3KIbU/SMh4gjlZUzL1JkgcwZwSfQCetZb4Sf0mVtMF6pwxwBGRFcS/1n+StIe8DeUJ6rrYApmg/
	u1Q9D2X2G9lgqB9xijqkw1aSSTYiJIZZ4EQQcbmi3bMiINMWeOoB5Vv4nr0Uo7ag/HUmkyOv2WIIk
	/7nV5E9eJWD0dfSZoTSI5fV8Chg65/94tne/j53L0VsZoeXxHTXpXKhX3q3kYS/u+1qZ0lXetFvqL
	K3G/1N6dRibUum7RYFeJCsMz+SbyPCJ/gayOOydIVh6mZ7x1UD3fEkBDRNcHv7SEMxRuxzieRp8t8
	X9xn1WACfEXepgXIghtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmaBf-0002i3-HO; Thu, 24 Jan 2019 08:16:35 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmaAn-0001uq-6A; Thu, 24 Jan 2019 08:15:54 +0000
X-UUID: 6530851bfe1d4bb8b6930fe6478318f4-20190124
X-UUID: 6530851bfe1d4bb8b6930fe6478318f4-20190124
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <erin.lo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1687068115; Thu, 24 Jan 2019 00:15:18 -0800
Received: from MTKMBS02N1.mediatek.inc (172.21.101.77) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 00:15:16 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 16:15:08 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 24 Jan 2019 16:15:08 +0800
From: Erin Lo <erin.lo@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier
 <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v6 2/6] dt-bindings: arm: Add bindings for Mediatek MT8183 SoC
 Platform
Date: Thu, 24 Jan 2019 16:07:16 +0800
Message-ID: <1548317240-44682-3-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_001541_562712_1E0BE9A2 
X-CRM114-Status: UNSURE (   7.61  )
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
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>,
 erin.lo@mediatek.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 mars.cheng@mediatek.com, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds dt-binding documentation of cpu for Mediatek MT8183.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 8f260e5..f6d6ed3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -20,6 +20,7 @@ compatible: Must contain one of
    "mediatek,mt8127"
    "mediatek,mt8135"
    "mediatek,mt8173"
+   "mediatek,mt8183"
 
 
 Supported boards:
@@ -77,3 +78,6 @@ Supported boards:
 - MTK mt8173 tablet EVB:
     Required root node properties:
       - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
+- Evaluation board for MT8183:
+    Required root node properties:
+      - compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
