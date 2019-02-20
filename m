Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613D1C10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2682E2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ePYjkoUO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P+eBkAGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2682E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0XneERwGA9dSB191nfIDeB5i9gJveFCobuT3nDs1T9A=; b=ePYjkoUOQbV4Jt
	sflvCOPv6EGNOwTyouwGTjoxWqR+8dUI0geClZbkLJ3N+eLFu7tSLRfTE7Hq/koRcKEVE3w6OLssG
	ELcZSRtTCyKVQx7Sjhz1bN2768DN/1KfSw5VBBK0++V6u6wkbbx4yjJVOGTtDvucfyTSmve1cLDsf
	pBJkukQtGsncGThJc9Olk9B+qQteLXoyrr6N4atG6FeKIObr6ZClqCQKUABIeDyQvZhDRp+y7G7Qr
	W6gLjbhAjaRndwa3irkyFJzOYxS7Yxkqif8aZKv9pnISxXhJENjcJimh/Cxj5QHiNTozrdQM8eCQG
	ZE6O4/MrCNTP1oskK/zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTle-0000LD-0O; Wed, 20 Feb 2019 15:26:38 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTl8-00087u-Uc
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:26:11 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KFQ0i3055557;
 Wed, 20 Feb 2019 09:26:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550676360;
 bh=QKzjUjKCPfDXcTiEnGu7cK4JzcDDNuwmd+3LS5W6iS4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=P+eBkAGl9xnpNTJs4kDMxkMVb2gwAY1oLoOGLFNGJlA4MRVv80cI5eTWbDTUTmTnS
 izT7jeoHwOVSqcsce3ueFVy9/ea+JIsDVcqN7oP4cx9R8apBzBr111XGmbmpx/9jZu
 jbz3OYSTa6ui+1S5qcPxW5D7nI9eMQiMfVm+GZd0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KFQ0fP070042
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 09:26:00 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 09:25:59 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 09:25:59 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KFPwmi009382;
 Wed, 20 Feb 2019 09:25:59 -0600
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I
 <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren
 <tony@atomide.com>
Subject: [PATCH 1/6] ARM: dts: dra7: switch to use phy-gmii-sel
Date: Wed, 20 Feb 2019 17:25:14 +0200
Message-ID: <1550676319-6440-2-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_072607_684365_2F75EE15 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>,
 netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index bb45cb7fc3b6..414f1cd68733 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -77,18 +77,18 @@
 						};
 					};
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,dra7xx-phy-gmii-sel";
+						reg = <0x554 0x4>;
+						#phy-cells = <1>;
+					};
+
 					scm_conf_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
 					};
 				};
 
-				phy_sel: cpsw-phy-sel@554 {
-					compatible = "ti,dra7xx-cpsw-phy-sel";
-					reg= <0x554 0x4>;
-					reg-names = "gmii-sel";
-				};
-
 				dra7_pmx_core: pinmux@1400 {
 					compatible = "ti,dra7-padconf",
 						     "pinctrl-single";
@@ -3099,7 +3099,6 @@
 					     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
 				ranges = <0 0 0x4000>;
 				syscon = <&scm_conf>;
-				cpsw-phy-sel = <&phy_sel>;
 				status = "disabled";
 
 				davinci_mdio: mdio@1000 {
@@ -3114,11 +3113,13 @@
 				cpsw_emac0: slave@200 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 1>;
 				};
 
 				cpsw_emac1: slave@300 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 2>;
 				};
 			};
 		};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
