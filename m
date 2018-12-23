Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA055C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:04:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F102176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bl7piFde";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="Vs6jtxNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F102176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8DL77sbSdUnnGbKYjaKK1GqsYy4N1xQrIjT7ux0U5oM=; b=Bl7piFdex3fNPHHraM+GHBPwty
	pMctRwhZbM0MFIhWuahssl7MDL/PIegUbrwnzLwgvLfzYIU4RCx0du95yfxn0nDRkn5WqTQKNChHd
	ITj3DHf341NaEVVLHksVSbcapZpkfVumBi69pwCJO2i3yPExvRX/i1Ri6JhRSd8Zs+mZDa5zVr6Es
	VXfbOlnBQB9tCZPSdIVVqoDv1Z5f+Ko7Hhvb0uKlYp+ZXr+ULJA5HyDXrjhEeXOIyfb0mF081zvw2
	vTlT7o5y4Q5NrhNukEtc6NnibocfnjRxBSwzGTjB85U1K8voJGXrxV+dVV+dYUekbEHWowkuKUlpR
	48BexHug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaws3-0007i2-4E; Sun, 23 Dec 2018 06:04:15 +0000
Received: from smtp3.mail.ru ([94.100.179.58])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gawrq-0007am-WF
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 06:04:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=NUYFzI/1RIutYwY/tt7hTPNzrzd16PMfRbCiN0rCVxk=; 
 b=Vs6jtxNI+uoscoCj6fFunhts1/aTcmQcyHAv2j8rhlgtdE35kf4cZGt86eE48+K9vVDPZknmdipcG6K6m75M56ba27Mh06kafmrBgxKUuIrp69z1DvPS9ylSSqmyXyemCvDjUVIajACeF63EXku414mcA7iSS9IyjwxJ8VODiZ0=;
Received: by smtp3.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gawrc-0002TA-8p; Sun, 23 Dec 2018 09:03:48 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] ARM: dts: i.MX51: imx51-digi-connectcore: Enable ESDHC1
Date: Sun, 23 Dec 2018 09:03:41 +0300
Message-Id: <20181223060342.32054-3-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181223060342.32054-1-shc_work@mail.ru>
References: <20181223060342.32054-1-shc_work@mail.ru>
Authentication-Results: smtp3.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 6115F4D8777AF1675A78504BD2AC29419868B496DAF47A9FFC309AB5BCA99F4BD50C6233F98AB931F0124468BC41536C
X-7FA49CB5: 0D63561A33F958A5448D373F30818138E0772031D2666BCE3D0C7675EF4652658941B15DA834481FA18204E546F3947CC2B5EEE3591E0D35F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BECADA55FE5B58BB7A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249DA33821E755670D83AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE72CE3825EE585899DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7B3CB1C817A35D2233A4272FF176CB30175ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445071D9EE4167233010AA51E55F5C8CD4F4B4156FAD878E1226B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_220403_428726_E9B4EE23 
X-CRM114-Status: GOOD (  10.63  )
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

This patch adds definitions for ESDHC1 for Digi Connectore SOM & JSK.
This interface can be used to boot a module.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts  |  4 ++++
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts b/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
index a5010e9..a2eea58 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
@@ -21,6 +21,10 @@
 	};
 };
 
+&esdhc1 {
+	status = "okay";
+};
+
 &owire {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_owire>;
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index e9421b8..a2a6408 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -145,6 +145,13 @@
 	};
 };
 
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	max-frequency = <50000000>;
+	bus-width = <1>;
+};
+
 &esdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc2>;
@@ -234,6 +241,14 @@
 			>;
 		};
 
+		pinctrl_esdhc1: esdhc1grp {
+			fsl,pins = <
+				MX51_PAD_SD1_CLK__SD1_CLK		0x400021d5
+				MX51_PAD_SD1_CMD__SD1_CMD		0x400020d5
+				MX51_PAD_SD1_DATA0__SD1_DATA0		0x400020d5
+			>;
+		};
+
 		pinctrl_esdhc2: esdhc2grp {
 			fsl,pins = <
 				MX51_PAD_SD2_CMD__SD2_CMD		0x400020d5
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
