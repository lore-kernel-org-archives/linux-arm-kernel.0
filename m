Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68094C37120
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:31:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B6E20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sjkZq4+S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uk3EeoBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B6E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=P/Mn38bwQNiCl6g4PRWKAX2gQYROigBWT889jhkCbDQ=; b=sjk
	Zq4+S3iHPEGO+E/Ho+mix2eY2b2aZHzpzesOb3ouDOGWnQLHugNtser1YhHnvU8BwU5XgOflNeTvR
	qC+A33Ya9eMyKaQpQY1g1gYoDVyYITFDRs6VPd038Hnc9nclrOF55wmExJuEV36N52Dd2GslI+F+T
	tRXjgAAOmds2ts9ExyBbXINYmNUKKOwNeau4l7UHUBODohRjYP8xpnE5kLn7qxuU/A1UtVAEueMrp
	2L1/ksKRoTF72wPSkYuFDFCH344xosvBc+JBQWQAiQfzQuQ95PD+O+WQWrCaSk60HpGIMWwPnHQei
	LI112Lzc23wP9sMcafec5fdqNexUqQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glgEU-0001Uw-Pf; Mon, 21 Jan 2019 20:31:46 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glgCP-0007ue-8M
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 20:31:03 +0000
Received: by mail-qk1-x742.google.com with SMTP id g125so12999891qke.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=loF/G7cnOd71BdYLeM9+dTxdQBr5qwG654S3oCJWQvA=;
 b=uk3EeoBWGsymwzj8xL6lVx5wSP9SBX74JD5j31pwr7XYhajhfGzyFJ02jI7wKutMVj
 sQIefKZN5rsurXRbAubul/d9zvsKc0jV+KQvRBjMCacugAhH+IKnmKm3xWn5EjPNd8Pz
 WzvHN6aOip/w5Wvl8GD/086fmVDolapxaOMQSifOq/9ZAa9UZ71/mj4U+Pr2PhsrlEEC
 Z8nXEYAYsq8/kVJNuaU01YtWo5pVcW0vpdjh3Luopxx8g6sGRch8kw44K0QTtWtf976G
 tJ7HizzusM2Z4BV01qcONKn17mwVxjvNfvbxvRUU5+g/e+Nkq5HeTF8JZ6IebImm2hpI
 klcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=loF/G7cnOd71BdYLeM9+dTxdQBr5qwG654S3oCJWQvA=;
 b=nQlZQa+N1aDOkpFgDG2EQs504tFYBfVni/ECjHhaHVQdz8aHHpHvd3HozKlDmtmDc9
 x5UDqLXNTdOOZxtdE6vfgKPFdYukAoXZ68IsXkk/TcvtN2DkyoOEXj0sZR0mH2laR8wk
 wpFu0N0dCNYJl90FC+5xJ+W9Jcx0ggmTLlyJHjS/V/CCdP+jo7YRyki3JQ9773IeMsKW
 SHBS97LCClXYMcXpDoUxUVAm2SwwyHFsT2fXkHeHjXfx6pKL03qTWEOcovIkpnHciWRk
 yjvGRxX/uxVQBTEhuec+8Wzqz12KvCUtBjzn10Whtaxt/jDXvlCpYNDNqO2Tp1M6FNz8
 KKaw==
X-Gm-Message-State: AJcUukcs4z1vf0CnSdjv76MwojWA7tbqHhlCZwM2Vz9rJRLx+rbbrUco
 NQmcEeq3zvVfuEdgA5gw2YY=
X-Google-Smtp-Source: ALg8bN7oycPSVKUPsBI2z1LO1K8nvGOTAYt81dxQIm/kQfQj7tWTHn0Ym4dSiJt4swdIkkmhaiO4bQ==
X-Received: by 2002:a37:70c3:: with SMTP id
 l186mr25165960qkc.218.1548102576034; 
 Mon, 21 Jan 2019 12:29:36 -0800 (PST)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:a73::2])
 by smtp.gmail.com with ESMTPSA id q5sm103107927qtq.20.2019.01.21.12.29.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 12:29:35 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] ARM: dts: imx: Remove 'simple-bus' from anatop compatible
Date: Mon, 21 Jan 2019 18:29:05 -0200
Message-Id: <20190121202905.31224-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_123057_708373_3385B923 
X-CRM114-Status: GOOD (  10.78  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

dtc gives the following warnings when building with W=1:

arch/arm/boot/dts/imx6qdl.dtsi:702.19-715.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-1p1: missing or empty reg/ranges property
arch/arm/boot/dts/imx6qdl.dtsi:717.19-730.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-3p0: missing or empty reg/ranges property
arch/arm/boot/dts/imx6qdl.dtsi:732.19-745.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-2p5: missing or empty reg/ranges property
arch/arm/boot/dts/imx6qdl.dtsi:747.32-762.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-vddcore: missing or empty reg/ranges property
arch/arm/boot/dts/imx6qdl.dtsi:764.29-779.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-vddpu: missing or empty reg/ranges property
arch/arm/boot/dts/imx6qdl.dtsi:781.31-796.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-vddsoc: missing or empty reg/ranges property

Remove 'simple-bus' from the compatible list of anatop, since it is a
regulator and thus should not be described as 'simple-bus'.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sll.dtsi | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fe17a3405edc..5b54f1bfa03d 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -693,7 +693,7 @@
 			};
 
 			anatop: anatop@20c8000 {
-				compatible = "fsl,imx6q-anatop", "syscon", "simple-bus";
+				compatible = "fsl,imx6q-anatop", "syscon";
 				reg = <0x020c8000 0x1000>;
 				interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 4b4813f176cd..1bbcfcf6b2fc 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -518,7 +518,7 @@
 			anatop: anatop@20c8000 {
 				compatible = "fsl,imx6sl-anatop",
 					     "fsl,imx6q-anatop",
-					     "syscon", "simple-bus";
+					     "syscon";
 				reg = <0x020c8000 0x1000>;
 				interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 62847c68330b..b2caf86dd9a9 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -506,7 +506,7 @@
 			anatop: anatop@20c8000 {
 				compatible = "fsl,imx6sll-anatop",
 					     "fsl,imx6q-anatop",
-					     "syscon", "simple-bus";
+					     "syscon";
 				reg = <0x020c8000 0x4000>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 5b16e65f7696..44b2824a0a3f 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -594,7 +594,7 @@
 
 			anatop: anatop@20c8000 {
 				compatible = "fsl,imx6sx-anatop", "fsl,imx6q-anatop",
-					     "syscon", "simple-bus";
+					     "syscon";
 				reg = <0x020c8000 0x1000>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 3282eed497ea..6916d8ea1abc 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -557,7 +557,7 @@
 
 			anatop: anatop@20c8000 {
 				compatible = "fsl,imx6ul-anatop", "fsl,imx6q-anatop",
-					     "syscon", "simple-bus";
+					     "syscon";
 				reg = <0x020c8000 0x1000>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 81fe18c0b7da..73fea5b16b6c 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -519,7 +519,7 @@
 
 			anatop: anatop@30360000 {
 				compatible = "fsl,imx7d-anatop", "fsl,imx6q-anatop",
-					"syscon", "simple-bus";
+					"syscon";
 				reg = <0x30360000 0x10000>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
