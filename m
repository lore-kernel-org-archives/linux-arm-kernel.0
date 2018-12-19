Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68314C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:08:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A1A2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OOkqT38d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="X+sgDiP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A1A2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=2/fGWTnWP7rzKw8JrkbLFKx95hX6vpxmGO1ralgKjoE=; b=OOk
	qT38daD46kAKAexHpcu46q+mvPFG009TTm952g9ETA5EIlz6oyeSY30pS+vWe/KN03QMB81HUsvfS
	8M8P93JVlGlrrmTwZaPgvF82tVx1bgh6lTx9toPX9ayO3VeX9LYU0OsWQ2/vJ/rBMiWt8rb0PcXEO
	XDIwBztDmvc44NgG4p6IILSv6eD1W5LhDVd0QwPntRZWIldRKj30gIv2OJdjLLVLm7ZvSvzqp9JLB
	DAokwx0MHTM1jWAMUwZ+BxRcPOSGVt+ekZ1u5j6vZFPQRdWvWDhQr2szGl7mDfT4YPBv+QzBoLqrn
	aevmn7Ml4Hk5Kx8WdIWQ4csS93OPqZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZhCH-0003zs-IC; Wed, 19 Dec 2018 19:07:57 +0000
Received: from smtp62.i.mail.ru ([217.69.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZhCD-0003zT-LD
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 19:07:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; h=Message-Id:Date:Subject:Cc:To:From;
 bh=ISdM1HPJP9vUMZD+pcNKl9XxZWf7FRH+pqB7lTuffZw=; 
 b=X+sgDiP2kV/z9Nie39k+XSqi/fjpeGG9MH1W8pufASRzDuL2JBuOoPfgC9Uh7LJcPzYujB5Kr1EhHNmoxJIU6QSuGY7apqvzGds5j4dOT5M3PFYns2bpKBqYLcB/TtxoDe6bxOCa5YipmCq2hQFuHAIAZOhOqAYalGUGaHCyfcQ=;
Received: by smtp62.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gZhBy-0003Ii-FS; Wed, 19 Dec 2018 22:07:38 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx51: Add default bus-width property for esdhc1
Date: Wed, 19 Dec 2018 22:07:34 +0300
Message-Id: <20181219190734.23331-1-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
Authentication-Results: smtp62.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: BBE463BEF7A60BD05A78504BD2AC2941AC9F5C0DA9FA9AD2CA1AFAF90CF64ECD5E2877AFFD012BC1FCE52281FDD2ED3E
X-7FA49CB5: 0D63561A33F958A52B1B1878898F5B1701FF91AAFED694226F7EF5F8CC530E2F8941B15DA834481FA18204E546F3947C51C368AE3DEE0FB9F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BDD7F4BCB486E2545A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224999B836357A5F2ED63AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE769E77FCA7B33833FCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE71DCCDD4014BAD17D02552C6A286A30D575ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445FD9E314665D9B43E46E33EE1769C0EE03120E6DF4C9996C96B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_110754_073021_A38113E1 
X-CRM114-Status: GOOD (  13.59  )
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
Cc: Shawn Guo <shawnguo@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
 kernel@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds bus-width property for esdhc1 to avoid mmc
core warning: "bus-width" property is missing, assuming 1 bit.
Additionally, the patch removes this property for boards where
4-bit width is already specified, and adds 1-bit width for
boards where this property is omitted.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-apf51dev.dts                   | 1 -
 arch/arm/boot/dts/imx51-babbage.dts                    | 1 +
 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts | 1 +
 arch/arm/boot/dts/imx51-ts4800.dts                     | 1 +
 arch/arm/boot/dts/imx51-zii-rdu1.dts                   | 1 -
 arch/arm/boot/dts/imx51.dtsi                           | 1 +
 6 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index 3e1846a..b26d92f 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -97,7 +97,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	cd-gpios = <&gpio2 29 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 35ee1b4..8e86116 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -322,6 +322,7 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
+	bus-width = <1>;
 	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index e9e819f..f2c3c87 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -101,6 +101,7 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1 &pinctrl_esdhc1_cd>;
+	bus-width = <1>;
 	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 39eb067..e6d25a5 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -82,6 +82,7 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
+	bus-width = <1>;
 	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 69d753c..1287b57 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -459,7 +459,6 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	bus-width = <4>;
 	no-1-8-v;
 	non-removable;
 	no-sdio;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 67d4627..eac432a 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -172,6 +172,7 @@
 						 <&clks IMX5_CLK_DUMMY>,
 						 <&clks IMX5_CLK_ESDHC1_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
+					bus-width = <4>;
 					status = "disabled";
 				};
 
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
