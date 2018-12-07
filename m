Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F61C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:40:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750D620837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CCOdj1FU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EgDeU9vZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750D620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/oxcEFV7zTBLqGDmIzfYCmEnrpnGTgnt00P1C3jlMg=; b=CCOdj1FUcdd9t/
	IPMfiVXFpbynQ6bp6lU2r4CuU8H/uHR0CCqQ2zFZWQDA7CJ+ft04nGHP3cZHpILTdYiA4/Iy1L5n8
	JYS/3D6xiWH87aqfDY43F3JJ1Z58CJtZtmHTKTFP6aB7lFJ8+tZC5PxGw7UMHOxF4lq3HSBW4pqfc
	laeSIcFDSmhZEttQ+Rd4q6XnhcObarHyL5qlMdimz69fiSd3CwLiSznVvNq3CyCLX+DYZnS5E45/I
	s5LDT06gBXg2bzo8C8RUqAxH7B1dIEzEJfi566cDKtglDWZaRZoffa7vBExsdFFzavntJQBlpiQnM
	6yN1rnJ4lt5jLGWqr35g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVBgi-00059K-P5; Fri, 07 Dec 2018 08:40:44 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVBg9-00039X-4d
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 08:40:12 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB78drsS078967;
 Fri, 7 Dec 2018 02:39:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544171993;
 bh=QZAdAI5rRRXeFLYxO45mCN74SAomheYIagGwI/4AuOM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EgDeU9vZhUOFuNMG1y4MspbM91Q908jXtCQs/au2CzrtiqgcXS9VFTgKRCtzbF/Vg
 gHoONwxFTbobxLdeS4TOsloi12Ctwu5Wi7kkh6miWL8T+1/dtM7jS8E+6CuWK6COKB
 UI5sZwb1Jpfz/qDCHQbG2rLXcsVAn/zhTS1M96qM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB78dr1H045276
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 02:39:53 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 02:39:52 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 02:39:52 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB78djGv012224;
 Fri, 7 Dec 2018 02:39:49 -0600
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am654: Add Support for MMC/SD
Date: Fri, 7 Dec 2018 14:12:32 +0530
Message-ID: <20181207084233.13700-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207084233.13700-1-faiz_abbas@ti.com>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_004009_514494_1859448B 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: mark.rutland@arm.com, nm@ti.com, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, kishon@ti.com, t-kristo@ti.com, robh+dt@kernel.org,
 faiz_abbas@ti.com, michal.simek@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are two MMC host controller instances present on the TI's
Am654 SOCs. Add device tree nodes for the same.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 916434839603..d07212f16a81 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -129,4 +129,32 @@
 		clocks = <&k3_clks 113 1>;
 		power-domains = <&k3_pds 113>;
 	};
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
+
+	sdhci1: sdhci@4fa0000 {
+		compatible = "ti,am654-sdhci-5.1";
+		reg = <0x0 0x4fa0000 0x0 0x260>, <0x0 0x4fb0000 0x0 0x134>;
+		power-domains = <&k3_pds 48>;
+		clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
+		clock-names = "clk_ahb", "clk_xin";
+		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		sdhci-caps-mask = <0x80000007 0x0>;
+		mmc-ddr-1_8v;
+		ti,otap-del-sel = <0x2>;
+		ti,trm-icp = <0x8>;
+		status = "disabled";
+	};
 };
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
