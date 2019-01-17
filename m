Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C1EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:42:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163232054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rRgsGQyd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZDdWINFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163232054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ynsfU0KPHqRnt++vgmrsCNnqRRJa4vXIqBK9xAG7RGc=; b=rRgsGQydf5Wcrv
	DBYf92vBuXfopZpNL22FDrp8v7E0j4G6oZi2uYE2tEyNzLo5AKGJVJUATra94UqImqfVABbhTjTLZ
	7R3MPvoSrge4dg6eC5Kf9DUBVFMErbYsBcaS66DAEKj3DyXERpA7zJlPPaVbZdd3UjeUrp2DUf40j
	3Xx0c0x0KLcnlNoTjO4Zv4Bwcj3X8KjMZb2bhvv3aqTTGboOtZkQ5RG8oRgu3kRp7in5kdMyBJx3r
	AYPRUbaR5YdpnFLiEhVObpv9un7NHkYFXd1T+1XWG94rvI2D7aAgICKSvl88KaVZeeBfUxrMG45Bi
	fyeB5ibcBjhhDa3KU92g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4Bb-0005dv-I7; Thu, 17 Jan 2019 09:42:07 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4BM-0005Ms-Ub
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:41:58 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0H9fmkG060207;
 Thu, 17 Jan 2019 03:41:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547718108;
 bh=dsSzBvSvEio0e+YIzK/EXMt4VwY2qtnqkYN5joykVFk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZDdWINFh8kalJRO2kt7VpYIHMt/WMvmyYDb4L6HiqyzzL0R39/sPvNZTrEXf9gS8o
 g7igAQLd7Rm5iI/inQvZtPlYe9LCERAm4BjyYXO9K4+WD45cgtWVHbaziY+6o1jqha
 ESgWRph///EIs+JvZZh/VYvIsFsp0wvEOCTQ/fUs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0H9fmEp018217
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Jan 2019 03:41:48 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 17
 Jan 2019 03:41:47 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 17 Jan 2019 03:41:47 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0H9fdIl016863;
 Thu, 17 Jan 2019 03:41:45 -0600
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-am654-base-board: Add eMMC Support
Date: Thu, 17 Jan 2019 15:14:24 +0530
Message-ID: <20190117094424.7683-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190117094424.7683-1-faiz_abbas@ti.com>
References: <20190117094424.7683-1-faiz_abbas@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_014153_515566_A7342BC3 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: mark.rutland@arm.com, nm@ti.com, robh+dt@kernel.org, t-kristo@ti.com,
 faiz_abbas@ti.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On the am654x-evm, sdhci0 node is connected to an eMMC. Add node and
pinmux for the same.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index e41fc3a5987b..11e9a2a43dfc 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -69,6 +69,23 @@
 			AM65X_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (AG13) SPI0_CS0 */
 		>;
 	};
+
+	main_mmc0_pins_default: main-mmc0-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0) /* (B25) MMC0_CLK */
+			AM65X_IOPAD(0x01ac, PIN_INPUT_PULLUP, 0) /* (B27) MMC0_CMD */
+			AM65X_IOPAD(0x01a4, PIN_INPUT_PULLUP, 0) /* (A26) MMC0_DAT0 */
+			AM65X_IOPAD(0x01a0, PIN_INPUT_PULLUP, 0) /* (E25) MMC0_DAT1 */
+			AM65X_IOPAD(0x019c, PIN_INPUT_PULLUP, 0) /* (C26) MMC0_DAT2 */
+			AM65X_IOPAD(0x0198, PIN_INPUT_PULLUP, 0) /* (A25) MMC0_DAT3 */
+			AM65X_IOPAD(0x0194, PIN_INPUT_PULLUP, 0) /* (E24) MMC0_DAT4 */
+			AM65X_IOPAD(0x0190, PIN_INPUT_PULLUP, 0) /* (A24) MMC0_DAT5 */
+			AM65X_IOPAD(0x018c, PIN_INPUT_PULLUP, 0) /* (B26) MMC0_DAT6 */
+			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP, 0) /* (D25) MMC0_DAT7 */
+			AM65X_IOPAD(0x01b4, PIN_INPUT_PULLUP, 0) /* (A23) MMC0_SDCD */
+			AM65X_IOPAD(0x01b0, PIN_INPUT, 0) /* (C25) MMC0_DS */
+		>;
+	};
 };
 
 &main_pmx1 {
@@ -163,3 +180,11 @@
 		#size-cells= <1>;
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	bus-width = <8>;
+	non-removable;
+	ti,driver-strength-ohm = <50>;
+};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
