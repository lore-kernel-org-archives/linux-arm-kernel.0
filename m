Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E291C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:20:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D6221473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o233dgCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D6221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fjX2FvUcK7rfVsrM+o+EbhGP9Il7YCsvhYKhKw6jWTc=; b=o233dgCJdo8DWN
	Z3WRwxUJwEPVPTwjtfrgMhSmiCPhIFPB5uHO4AhUhAwwK9NbhtLSn+h8UKyW5C2kjylfXy2enyOGu
	dm8j0+KzXkM9W7GVL688e2sE2N4Iu75wfhq29sE4q5TJINwrGieAR+PN1Wv9xrrJqDIoVL4c/ByL9
	jMrCFCzaH22TG75zeyxrj81BMZNRjFpHaTtJTdJLk3RRj/c7KRECBYtddFjlwdE5f8SqyE59HHZgJ
	6T1QwnKPyQdHmSYjOiiB6JeyQ6phJL541N9R2H8EDP9C7fPu4JOdwiaz4Z95BI7mMORIQOstcs8lX
	B7vpXHzmpDeSf+mBzl+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosb8-0003V3-OY; Wed, 30 Jan 2019 16:20:22 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosZe-0001IC-EJ
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:18:54 +0000
Received: from sapphire.lan (unknown [10.0.4.3])
 by mx.tkos.co.il (Postfix) with ESMTP id 98D8B440AC2;
 Wed, 30 Jan 2019 18:18:44 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 4/4] ARM: dts: hummingboard2: describe optional can bus
Date: Wed, 30 Jan 2019 18:18:41 +0200
Message-Id: <ac31ad5da849e76db78eb7dd38bf3ad9890b7ad1.1548861664.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1548861664.git.baruch@tkos.co.il>
References: <cover.1548861664.git.baruch@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_081850_713399_EFC108A3 
X-CRM114-Status: UNSURE (   9.13  )
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

A Hummingboard assembly option provides CAN bus connector for the i.MX6
provided FlexCAN peripheral. Keep disabled by default.

Note the conflict with HDMI pin mux.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index c5b5c6d3306f..2008be6fbee4 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -206,6 +206,7 @@
 	status = "okay";
 };
 
+/* Conflicts with the CAN bus option */
 &hdmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hummingboard2_hdmi>;
@@ -523,6 +524,13 @@
 				MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
 			>;
 		};
+
+		pinctrl_hummingboard2_flexcan1: hummingboard2-flexcan1 {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
+			>;
+		};
 	};
 };
 
@@ -596,6 +604,13 @@
 	status = "okay";
 };
 
+/* Optional CAN bus. Conflicts with HDMI CEC. */
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_flexcan1>;
+	status = "disabled";
+};
+
 &vcc_3v3 {
 	vin-supply = <&v_3v2>;
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
