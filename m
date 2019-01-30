Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C21C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:18:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26FC2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DiUYXbfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26FC2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h7FSf6l6PjuYJYU2ueTGt3rxiEfeY72Oxb2neEKP9mY=; b=DiUYXbfLToIwSd
	gEDO7y/yXfX7EKMPK6srGKYk9/V/izaRS0UAinen2jmMvxeU7bVeK+csCSKQY8C+N07+HbZNClxX2
	ghP9VIpdH7ruCWrhcH05yrNYGrWlyghX7Y3aPE2sgo6JmfImu3ZXZk5sjZKWnbgun9pDgyDCEjvDy
	KH9da/s6V007asegbF9JV6tSsP15BYrmEWAOXtAN7KbTmsGHt4BM9yWROCMuY4CroxZINDulrB36i
	UdpdlqIVit3gRMUTAfnyeWj15O8FIeO1Aed2OYANhi1D5tlLlKfSQoJC8eU9CxOQ0Zlbeltw2ZoE2
	S4vY9PY/VFE8INxUBR6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosZh-0001Ja-W8; Wed, 30 Jan 2019 16:18:54 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosZe-0001IF-Dk
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:18:52 +0000
Received: from sapphire.lan (unknown [10.0.4.3])
 by mx.tkos.co.il (Postfix) with ESMTP id 58277440AB7;
 Wed, 30 Jan 2019 18:18:44 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 3/4] ARM: dts: hummingboard2: describe optional rs485
Date: Wed, 30 Jan 2019 18:18:40 +0200
Message-Id: <926d03329f04ff0c7c8d58e29c6d673a3d95fae9.1548861664.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1548861664.git.baruch@tkos.co.il>
References: <cover.1548861664.git.baruch@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_081850_689770_AF65F721 
X-CRM114-Status: UNSURE (   9.94  )
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
Cc: Baruch Siach <baruch@tkos.co.il>, Jon Nettleton <jon@solid-run.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A Hummingboard assembly option provides RS-485 transceiver on UART2
(/dev/ttymxc1). Add DT node for that. Keep it disabled, since RS-485 is
not assembled by default.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index fe95fe27e6ef..c5b5c6d3306f 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -501,6 +501,14 @@
 			>;
 		};
 
+		pinctrl_hummingboard2_uart2: hummingboard2-uart2 {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+				MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
+				MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b1
+			>;
+		};
+
 		pinctrl_hummingboard2_uart3: hummingboard2-uart3 {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D25__UART3_TX_DATA	0x1b0b1
@@ -573,6 +581,14 @@
 	status = "okay";
 };
 
+/* Optional RS-485 transceiver */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_uart2>;
+	uart-has-rtscts;
+	status = "disabled";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	/* Use &pinctrl_hummingboard2_rev14_uart3 for HB2 rev 1.4 */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
