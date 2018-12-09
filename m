Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51798C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:22:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF1520831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="II3JYcV2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FzxVOKBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF1520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cJMQzX1zytgWL2Ow6POGdHJNYbw0y1V7pIKN08XptbY=; b=II3JYcV2eLaLm3
	FV97jk7eS7j9rRPT3QYf4uPx8Q7EWQ486w9vVEVWCtTXHIRFFGeUJECvsUKWy29Al4vaUBlfvA4Lg
	Ysttg4dqCrIHqB9ltDiCPrCFbM55/KqEmlu76s3ZEr2oZo5M+QvQ8r4D3TxhzKRucy8+VPYp8AKRR
	+S0JrXc9MufcQMLG3POOw/O/aotQZziFyUYqoW1GIRNEiXvXUGQ6HuWR7U2ojRCfORA3EUzBkvtct
	rZ5VWqumoNkhCxBrTtK0W1f8I387PVZXoaQ4LGLfmgw9W+WQ90qx7r5UegOeLE/oO1BRcVJyCjKtd
	LpHqyZrFSL7ffLOm27Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVwDu-00019v-2S; Sun, 09 Dec 2018 10:22:06 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVwDW-00011N-AF
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 10:21:43 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB9ALY9q072732;
 Sun, 9 Dec 2018 04:21:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544350894;
 bh=U5x789AI3gPB1tD5QQJXPkPEU7/J4WYh30fY52yr3kI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FzxVOKBGqXjQrevA61qqrVqearFVu8qsZGZQA0OYINtzLmp/VJByhWWkj6WLOHUMK
 SYlB+6Uo3iX7CGFLngGkvlmJ+XTeyrx5RQJ+slaOvU7sswudL2xYntRmeUVRMz7bBK
 mDQCpTwb2z6tMJMCv4cghFJTfmAsrgjeTZa0eBDM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB9ALYvt043697
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 9 Dec 2018 04:21:34 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 9
 Dec 2018 04:21:34 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 9 Dec 2018 04:21:34 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB9ALQ8M007865;
 Sun, 9 Dec 2018 04:21:32 -0600
From: Vignesh R <vigneshr@ti.com>
To: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am654: Enable main domain McSPI0
Date: Sun, 9 Dec 2018 15:52:22 +0530
Message-ID: <20181209102222.7624-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209102222.7624-1-vigneshr@ti.com>
References: <20181209102222.7624-1-vigneshr@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_022142_452001_204DF810 
X-CRM114-Status: GOOD (  13.80  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable McSPI0 of main domain and add DT node for the SPI NOR flash
connected to CS0.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 49ec2c3f5ef1..e41fc3a5987b 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -60,6 +60,15 @@
 			AM65X_IOPAD(0x0070, PIN_INPUT, 5) /* (R25) GPMC0_CSn2.I2C2_SDA */
 		>;
 	};
+
+	main_spi0_pins_default: main-spi0-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x01c4, PIN_INPUT, 0) /* (AH13) SPI0_CLK */
+			AM65X_IOPAD(0x01c8, PIN_INPUT, 0) /* (AE13) SPI0_D0 */
+			AM65X_IOPAD(0x01cc, PIN_INPUT, 0) /* (AD13) SPI0_D1 */
+			AM65X_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (AG13) SPI0_CS0 */
+		>;
+	};
 };
 
 &main_pmx1 {
@@ -136,3 +145,21 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ecap0_pins_default>;
 };
+
+&main_spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi0_pins_default>;
+	#address-cells = <1>;
+	#size-cells= <0>;
+	ti,pindir-d0-out-d1-in = <1>;
+
+	flash@0{
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+		spi-max-frequency = <48000000>;
+		#address-cells = <1>;
+		#size-cells= <1>;
+	};
+};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
