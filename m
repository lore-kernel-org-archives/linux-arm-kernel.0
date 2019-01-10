Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B94C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:31:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430EE214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AYAVlrNk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YWPV24//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430EE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wkizuy8HgB1tCEVvoaFdeZkI69gEH307N/HJknF5yRI=; b=AYAVlrNk2WckHm
	HUy4v5eIU8TrFzTnUpO1Nt1/109LJqGa8sSjHQanJs/DR5stPsi3+tmrLBHXUpdI6LtTjWlp7ioZ4
	IVbOAsg2ys37XuZTZO+nr3kVZx45gisu0BXwiDhA/q6II9h35sMgvNm3+8tZbhrJoxG5/NJ63WYmf
	4p0et70D4RyLzeQ+iBAQ0fBtXm8PQgdyJ3/CEvst108zC0tQBPMtGlLHrGIz+lpZJEKFnOMhfGVwL
	Wm99uhXH/Wut21uFOsQr14lfN4LUXdtgrwJmvqAHDGXXhODGJ91W1S7HD2tTzE8PPocF+cVZtDnAY
	tMkGx2mmgpqi9XzsUdhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghUoY-0004Bu-7E; Thu, 10 Jan 2019 07:31:42 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghUoA-0003lO-9x
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:31:24 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0A7VC0V055751;
 Thu, 10 Jan 2019 01:31:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547105472;
 bh=5++OiNtMlT2WVwSZ8rQJshX+c8F6SPQdlgQ6dUfIuPQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=YWPV24//Is/Sa+JKgD8/l10v8LnqE1KFVJz1i4uhJOyLse+lJNPOR3y802FWoZ8cQ
 wBC+poQK2XfwU8lyoflXGTIDfsGJraDtEzcdVfhrDBN21ixXzeJLcVx9uW+f9VOjXR
 nRNzBYQeu25k02DB/0DpyPrsFMegs+z7U5++b9Ew=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0A7VCg7106552
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Jan 2019 01:31:12 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 01:31:11 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 01:31:11 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0A7V38j020221;
 Thu, 10 Jan 2019 01:31:09 -0600
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC support
Date: Thu, 10 Jan 2019 13:03:55 +0530
Message-ID: <20190110073355.3382-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190110073355.3382-1-faiz_abbas@ti.com>
References: <20190110073355.3382-1-faiz_abbas@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_233119_001172_2FAA5785 
X-CRM114-Status: GOOD (  12.67  )
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

On the am654x-evm, the sdhci0 node is connected to an eMMC. Add node and
pinmux for the same.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
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
