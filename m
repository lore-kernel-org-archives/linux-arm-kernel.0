Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815ACC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:33:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0CC20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eojr2Fkf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xDh0xKNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0CC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E8cbhqL/e+ueES7c6SiS6lOZ1qsjA9BRJ4Qz+YDp8r0=; b=Eojr2FkfShcRHu
	6OeCEIC3Iza+kSh4HY0NO3jeWDjzMBFjlhvw2c2pEAHxV+wztIzMtAUDoREi082MWpgdVLrGWO0XG
	P2YeXXYI5rrSNjixlwLMKu0B9M9WwIbRTE5hMz8rt4zl9yxRxjINdzAAQWMz2RVqegMDJIvFynUwn
	009NfLeymX6Ij1ieODI1tfBpHGqRjlzaIH6NnCnqMZLZO43oiWA3MahessF8L6LhMUEvkPkM1ncTe
	FrCgr9HqsWQsHiwmWA4drgeQjgnH/u/nmDVrJJB1UQgKLDaRNqepXkG9gvt89A7GkOmA60KEUytaO
	aB96x9csWAgBehEYQgsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQMT-00070C-GQ; Mon, 10 Dec 2018 18:32:57 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQMD-0006n2-Qy
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:32:43 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBAIWRdL095338;
 Mon, 10 Dec 2018 12:32:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544466747;
 bh=ebG37l2ja88J6B5a9TPkxcZTBxSHaZhHM2UimTz/6Hs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xDh0xKNzFXsP1dOUlNTwL9ra0PbuuPwO+WS6FTXlOm92vggyRJOc8tnpePwxwDvcI
 R+oLXVKiATxA2tCX/7Ry3BAxDjWGzF86D922+aJ4S/41iVh94b/i++i4Zcb+lYgPFf
 Nsn4RjRz22EguEuvvHfr3cKhIqp2QyFDWNGvg6s8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBAIWQwf101825
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 12:32:26 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 12:32:26 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 12:32:26 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBAIWJdN020318;
 Mon, 10 Dec 2018 12:32:23 -0600
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: mmc: sdhci-am654: Document bindings for
 the host controllers on TI's AM654 SOCs
Date: Tue, 11 Dec 2018 00:05:05 +0530
Message-ID: <20181210183507.9617-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210183507.9617-1-faiz_abbas@ti.com>
References: <20181210183507.9617-1-faiz_abbas@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_103242_002545_E3CFE8C6 
X-CRM114-Status: GOOD (  17.22  )
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
SOCs.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/mmc/sdhci-am654.txt   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
new file mode 100644
index 000000000000..15dbbbace27e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
@@ -0,0 +1,36 @@
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
+	};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
