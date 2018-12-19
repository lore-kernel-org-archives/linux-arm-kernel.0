Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21436C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FD221873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WlDy5kJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FD221873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EpDNdQKHF3Tv3ODmAsV/JcCZK0HUvv/1CVoQlVX381U=; b=WlDy5kJc5/tYdo
	28rGYOGNwRbYXStf2FBXwMEzqQHQfZHXxLIf1Ya4kaxkaQOgGWBLFNr1Hk+s9Yx01LRgiYumoeLPc
	7N0Jt3lFeZWFx4svt1vNSkt+DVTUBCQ/lE9MpGfCOWklDJA5ZlwUfbyrI0VeYuWa5pDMfcIo2mZ3T
	kH9qsJte/wTuDcP+HTnQmPbsSffLxcPmM6e6P3OPnHrFxQlNnT9I+klOit6F7YHG6DhFy5PUF6aWU
	wYpBvdqRpmPHwdXzTb06vqx/3ZMgL+y7VER2RbhJtgPzwY4NqvpdfkshyYix5sTcFyPmSDnHipvun
	bIssS0qF6KMg2rrOFnbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZWCz-0006w1-7n; Wed, 19 Dec 2018 07:23:57 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZWCE-0006Hv-DM; Wed, 19 Dec 2018 07:23:13 +0000
X-UUID: bf6c4e4ba6864ea8a8ca383a0a518466-20181219
X-UUID: bf6c4e4ba6864ea8a8ca383a0a518466-20181219
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <biao.huang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1693101038; Wed, 19 Dec 2018 15:22:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Dec 2018 15:22:52 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 15:22:52 +0800
From: Biao Huang <biao.huang@mediatek.com>
To: <davem@davemloft.net>, <robh+dt@kernel.org>
Subject: [v3, PATCH 1/2] net-next: dt-binding: dwmac-mediatek: remove fine-tune
 property
Date: Wed, 19 Dec 2018 15:22:40 +0800
Message-ID: <1545204161-15742-2-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545204161-15742-1-git-send-email-biao.huang@mediatek.com>
References: <1545204161-15742-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_232310_608763_6B3D9054 
X-CRM114-Status: GOOD (  10.39  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 andrew@lunn.ch, biao.huang@mediatek.com, netdev@vger.kernel.org,
 liguo.zhang@mediatek.com, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 joabreu@synopsys.com, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

remove fine-tune property in device tree, modify
the corresponding description in dt-binding.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 .../devicetree/bindings/net/mediatek-dwmac.txt     |   31 +++++++-------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
index 4de479b..8a08621 100644
--- a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
@@ -22,33 +22,25 @@ Required properties:
 
 Optional properties:
 - mediatek,tx-delay-ps: TX clock delay macro value. Default is 0.
-	It should be defined for rgmii/rgmii-rxid/mii interface.
+	It should be defined for RGMII/MII interface.
 - mediatek,rx-delay-ps: RX clock delay macro value. Default is 0.
-	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
-Both delay properties need to be a multiple of 170 for fine-tune rgmii,
-range 0~31*170.
-Both delay properties need to be a multiple of 550 for coarse-tune rgmii,
-range 0~31*550.
-Both delay properties need to be a multiple of 550 for mii/rmii,
-range 0~31*550.
+	It should be defined for RGMII/MII/RMII interface.
+Both delay properties need to be a multiple of 170 for RGMII interface,
+or will round down. Range 0~31*170.
+Both delay properties need to be a multiple of 550 for MII/RMII interface,
+or will round down. Range 0~31*550.
 
-- mediatek,fine-tune: boolean property, if present indicates that fine delay
-	is selected for rgmii interface.
-	If present, tx-delay-ps/rx-delay-ps is 170+/-50ps per stage.
-	Else tx-delay-ps/rx-delay-ps of coarse delay macro is 0.55+/-0.2ns per stage.
-	This property do not apply to non-rgmii PHYs.
-	Only coarse-tune delay is supported for mii/rmii PHYs.
-- mediatek,rmii-rxc: boolean property, if present indicates that the rmii
+- mediatek,rmii-rxc: boolean property, if present indicates that the RMII
 	reference clock, which is from external PHYs, is connected to RXC pin
 	on MT2712 SoC.
 	Otherwise, is connected to TXC pin.
 - mediatek,txc-inverse: boolean property, if present indicates that
-	1. tx clock will be inversed in mii/rgmii case,
+	1. tx clock will be inversed in MII/RGMII case,
 	2. tx clock inside MAC will be inversed relative to reference clock
-	   which is from external PHYs in rmii case, and it rarely happen.
+	   which is from external PHYs in RMII case, and it rarely happen.
 - mediatek,rxc-inverse: boolean property, if present indicates that
-	1. rx clock will be inversed in mii/rgmii case.
-	2. reference clock will be inversed when arrived at MAC in rmii case.
+	1. rx clock will be inversed in MII/RGMII case.
+	2. reference clock will be inversed when arrived at MAC in RMII case.
 - assigned-clocks: mac_main and ptp_ref clocks
 - assigned-clock-parents: parent clocks of the assigned clocks
 
@@ -76,7 +68,6 @@ Example:
 		mediatek,pericfg = <&pericfg>;
 		mediatek,tx-delay-ps = <1530>;
 		mediatek,rx-delay-ps = <1530>;
-		mediatek,fine-tune;
 		mediatek,rmii-rxc;
 		mediatek,txc-inverse;
 		mediatek,rxc-inverse;
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
