Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E975C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:13:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AAF213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cwaazh3R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UaAynCT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AAF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H+he6ji7Hdg87ygF8TXf1ATojlt6Q5T8l7MUaPngxG8=; b=cwaazh3R4LeOR1
	nehJEV525mhNyaG68NWYLWCszQnPaPXM8V9C8I4E/EZITaMFhveX5QCoQd0+IdhSNu31lNFj7X8qM
	NDrbx1CK/UjqIUx9Y8Z+FnOiECe+e3K/J6MypyfOLUib5fc6abXOEXJqtLuVPLHqWEQHevCBkrt6O
	bSx4y9jjeW2SoYwm7lHWKzO6wiEla1dWEd1aa95t1abxHJkcM0QoBcfQ8+K4F72Njmpu54oKyTPqc
	umRnK6jNlgC0GQbt1mn7uTWeFqsQdeEOIg+WPo9mgZj0R91BeTR7qKSbomlM9Vq4lPc/SdI+QMedd
	i3nWCpPZoJMaZyKEG97Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOw1-0005zR-7e; Thu, 29 Nov 2018 16:13:01 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOvp-0005oq-Ce
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:12:50 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wATGCX6f037953;
 Thu, 29 Nov 2018 10:12:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1543507954;
 bh=5Itq+h4eyJP0hNnlk49FSrkv/SSC/HBF3GniGrEguSI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UaAynCT6N4Rhni3fjpJQLMivh/ujfdhJXdRVbSqIJ4Bzlb376B5ck9AWZZQowFfys
 2BSnSI053tUpa2fpiE2hEzcw9YnBHti+oq0y2aCge3rL2YRDGRBQhMm1WP2w3OnOr0
 AuO4D0dnOyEm73SL5WzCvGJC+MjCt9p7T0i7cac0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wATGCXD6126075
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 29 Nov 2018 10:12:33 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 29
 Nov 2018 10:12:33 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 29 Nov 2018 10:12:33 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wATGCQL4019470;
 Thu, 29 Nov 2018 10:12:30 -0600
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: mmc: sdhci-am654: Document bindings for the
 host controllers on TI's AM654 SOCs
Date: Thu, 29 Nov 2018 21:45:11 +0530
Message-ID: <20181129161513.31734-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129161513.31734-1-faiz_abbas@ti.com>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_081249_509021_5E0DEFF9 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, adrian.hunter@intel.com,
 kishon@ti.com, robh+dt@kernel.org, faiz_abbas@ti.com, michal.simek@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add binding documentation for mmc host controllers present on TI's AM654
SOCs

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/mmc/sdhci-am654.txt   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
new file mode 100644
index 000000000000..862b93051bfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
@@ -0,0 +1,37 @@
+Device Tree Bindings for the SDHCI Controllers present on TI's AM654 SOCs
+
+The bindings follow the mmc[1], clock[2] and interrupt[3] bindings.
+Only deviations are documented here.
+
+  [1] Documentation/devicetree/bindings/mmc/mmc.txt
+  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
+  [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Required Properties:
+	- compatible: should be "ti,am654-sdhci-5.1"
+	- reg: Must be two entries.
+		- The first should be the sdhci register space
+		- The second should the subsystem/phy register space
+	- clocks: Handles to the clock inputs.
+	- clock-names: Tuple including "clk_xin" and "clk_ahb"
+	- interrupts: Interrupt specifiers
+	- ti,otap-del-sel: Output Tap Delay select
+	- ti,trm-icp: DLL trim select
+	- ti,driver-strength-ohm: driver strength in ohms.
+				  Valid values are 33, 40, 50, 66 and 100 ohms.
+
+Example:
+
+	sdhci0: sdhci@4f80000 {
+		compatible = "ti,am654-sdhci-5.1";
+		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
+		power-domains = <&k3_pds 47>;
+		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
+		clock-names = "clk_ahb", "clk_xin";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+		sdhci-caps-mask = <0x80000007 0x0>;
+		mmc-ddr-1_8v;
+		ti,otap-del-sel = <0x2>;
+		ti,trm-icp = <0x8>;
+		status = "disabled";
+	};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
