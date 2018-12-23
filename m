Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B927CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:04:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862D72176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pFPM0TID";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="kmsyzr1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862D72176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=d4gmHjIMTvtlxDGo7gtBkdlkqdTJ43owbSimLrYNp/8=; b=pFPM0TIDF1v3M/AtsWtsUanSgj
	epXbDtQjidNBfYrlO8nrwtO4RfVYNTxa6UCI0JfNEgkI4zlwr2fhqF52kj8DjfJy7IYtnV4aU+yfn
	hI+km3ZCS1acWrQh3cR8Jz2mUVdBJ4c+rVUQ1UeShC8j4jVjkt1NLR9G4/2qEpF/7cc/0RVGN/ioD
	qF3lmvYwjXRln3dPziCGL8HHaC7GGIE8E5TA3wkCZcLP2wCaO7anOD02o12zKRGxfO1m/YsaN6b0M
	VJluxR6xfLm5IhuwaJYs84D1XUrC4Tna54qqNUUBA2FublOlWp9ptFpZzWYCxIuaqcz/De+oZz9lw
	KL8jZv3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gawsg-0008FI-8l; Sun, 23 Dec 2018 06:04:54 +0000
Received: from smtp3.mail.ru ([94.100.179.58])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gawrq-0007an-WD
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 06:04:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=d6hgJXD72qrys43amOiySQhV05lieoXx4XACgEv42sg=; 
 b=kmsyzr1RgcNXj0brtUvGDu70aKyojPoKLD4qd7zPN9sc1ujeoxs041ScXSCb+eLf2Q5qzYKxduOPNSbsmQlDFSQ7ENXCNgDL5GIAwv0o6pJcAsmXaA4ljK+ip0vcFT14zbfEasN9VIYrRnBLiSYm2p9PHGsB+hjlnU1sgbOBMoU=;
Received: by smtp3.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gawrc-0002TA-Nx; Sun, 23 Dec 2018 09:03:49 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] ARM: dts: i.MX51: digi-connectcore-som: Add support for
 I2C bus recovery
Date: Sun, 23 Dec 2018 09:03:42 +0300
Message-Id: <20181223060342.32054-4-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181223060342.32054-1-shc_work@mail.ru>
References: <20181223060342.32054-1-shc_work@mail.ru>
Authentication-Results: smtp3.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: E14BCC6235C710295A78504BD2AC29419868B496DAF47A9FFC309AB5BCA99F4B0CDB658EA8F83BE73A499A265D1D56E6
X-7FA49CB5: 0D63561A33F958A5448D373F30818138E0772031D2666BCE5E74126B30ADA5F78941B15DA834481FA18204E546F3947C0839144E5BB460BAF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B55B19328CBC4F849A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249DA33821E755670D83AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE72CE3825EE585899DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7430ED7F324E0B2BE79A30FF140FDA44B75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445071D9EE4167233010AA51E55F5C8CD4F58BF46E4B01B60EA6B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_220403_430967_FF4B17FE 
X-CRM114-Status: GOOD (  10.09  )
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

Define the required properties to enable I2C bus recovery supported by
the I2C subsystem.
This patch adds GPIO based I2C fault injector for Digi Connectcore SOM.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index a2a6408..d90ba5f 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -174,9 +174,12 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
 	clock-frequency = <400000>;
+	scl-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
 	mma7455l@1d {
@@ -290,6 +293,13 @@
 			>;
 		};
 
+		pinctrl_i2c2_gpio: i2c2gpiogrp {
+			fsl,pins = <
+				MX51_PAD_GPIO1_2__GPIO1_2		0x400001ed
+				MX51_PAD_GPIO1_3__GPIO1_3		0x400001ed
+			>;
+		};
+
 		pinctrl_nfc: nfcgrp {
 			fsl,pins = <
 				MX51_PAD_NANDF_D0__NANDF_D0		0x80000000
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
