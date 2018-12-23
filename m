Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A916C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:05:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473EA2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DJeIc6cn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="pjZa7Tbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473EA2176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=q09p8Totv4sh0ZSRd6NDPhXyziDadOUf591JN92v0dU=; b=DJeIc6cngT48frwf5Ug8QwqGbN
	8OZlZsptLRM6rWFaxIkS3hVDW+B7poU5PLy02ivSt7jPOZ7CXM2qAcw5UuC2JBhDra8BMphGlXyr5
	gF0WszJ1MrNmfaMNUUEhJS9cSMx+BhLlB4iG1mZQf4aLRgLYIxvEgSKaCBtRA7Z4RWEwgcH+Bmc1n
	zUF4/yf0uh5iEdYrZfeXoc7plPpb9mPvXNnlO9hH7rS2rVqwDZkzF/v2WDF7RSoBM42QUL2N76VdY
	CTdehJt8tTHsz1SBpfUq/2+eax5wG1c7BReDm8wJiPHbxOWpzeDFDt/lHVuIoY4VAOt0Z9gWGEAEJ
	Co1mnFXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gawsy-0000SC-74; Sun, 23 Dec 2018 06:05:12 +0000
Received: from smtp3.mail.ru ([94.100.179.58])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gawrq-0007al-WE
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 06:04:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=0vgHvu71CwKv0MVQwNu6DHWjepqjFqRBqtBpqL7+D1U=; 
 b=pjZa7TbcYV8CBcmNVShPRvsAnWy1rZDoLIQFfrqy5wg6KoOcn9ghMiP/wNeqllyezDbQBQVYrf40V2M78FYGN03wHkJRCQlj+rTMo9aayFB5+Txbg/8DszVhENw7oIGlN2NkXtX6Fldo3owf6BTvnjuLSuj1+V/J3arUtR9afU8=;
Received: by smtp3.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gawrb-0002TA-Pk; Sun, 23 Dec 2018 09:03:48 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: dts: i.MX51: digi-connectcore: Move RTC from SOM to
 JSK
Date: Sun, 23 Dec 2018 09:03:40 +0300
Message-Id: <20181223060342.32054-2-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181223060342.32054-1-shc_work@mail.ru>
References: <20181223060342.32054-1-shc_work@mail.ru>
Authentication-Results: smtp3.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 0014004E1F3277295A78504BD2AC29419868B496DAF47A9FD1F5664BC9DA345E0920DE0E63D11C63F0124468BC41536C
X-7FA49CB5: 0D63561A33F958A598527AAD12272E33E0772031D2666BCE061A56362A5F17648941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B974A882099E279BDA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249DA33821E755670D83AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE72CE3825EE585899DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7F595157BB51E07CBEA393B93815D931D75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445071D9EE416723301A78EAADB28B7DA57CBCCD57F2E67AF486B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_220403_434024_5985B2F2 
X-CRM114-Status: GOOD (  11.11  )
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In fact, the RTC battery can only be connected outside the module,
so this patch moves the PMIC RTC property and its power from SOM dts
to JSK.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts  | 12 ++++++++++++
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi |  7 -------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts b/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
index 2967a74..a5010e9 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
@@ -27,6 +27,18 @@
 	status = "okay";
 };
 
+&pmic {
+	fsl,mc13xxx-uses-rtc;
+
+	regulators {
+		vcoincell_reg: vcoincell {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-always-on;
+		};
+	};
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index 82d8df0..e9421b8 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -37,7 +37,6 @@
 		reg = <0>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
-		fsl,mc13xxx-uses-rtc;
 
 		regulators {
 			sw1_reg: sw1 {
@@ -142,12 +141,6 @@
 			pwgt2spi_reg: pwgt2spi {
 				regulator-always-on;
 			};
-
-			vcoincell_reg: vcoincell {
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-			};
 		};
 	};
 };
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
