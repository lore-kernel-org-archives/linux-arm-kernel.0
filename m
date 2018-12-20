Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87278C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:23:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAE321720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PVUc1/wX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAE321720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RzBK0EAUzFelB8C3B+BWYjGHoG8J+C/6IHfGaA7UO8U=; b=PVU
	c1/wXruiN8bhi3H/n4pu5b9ooAwt64qHLSWaqUdX3rZtbEd8jh/kLaAGroXZI9MFmb8FpgVR4mD+h
	9tt6ROEyJbNjhy1dnt2KZ79AGxyXs9N7ATjq0q9o8gwLrdTvTWB9+FDixpLaezQgWzI2K37D08Jhe
	OPweFP0X9nDAHBAH1SMez46RMpa09q9Y/XCsMkIWid1WpmAMDZbOFYAX2gpQaB0GDLG7cewlGGoXu
	zwSyiRNaIBgzkiJDu5gW8JgLeIE+k2MmmwQ/XHuJ/FjJiDHEXl9lQG+Fa2faUVlgtN1RZhz34+eQw
	UU4aY1Kfk0S29QWxShj3AVge1x+ZzyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZqoG-00023l-7e; Thu, 20 Dec 2018 05:23:48 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZqoC-00022x-LG
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 05:23:46 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 20 Dec 2018 14:23:30 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 02CAB180D80;
 Thu, 20 Dec 2018 14:23:31 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Thu, 20 Dec 2018 14:23:30 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 9E6F31A1235;
 Thu, 20 Dec 2018 14:23:30 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] arm64: dts: uniphier: Add PCIe host controller and PHY nodes
Date: Thu, 20 Dec 2018 14:23:13 +0900
Message-Id: <1545283393-2078-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_212345_018765_CEAFD95E 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add PCIe host controller and PHY nodes. This supports for LD20, PXs3 and
their boards.

This node defines PCIe memory, I/O, and config spaces as follows.

  MEM: 20000000-2ffdffff (255MB)
  I/O: 2ffe0000-2ffeffff ( 64KB)
  CFG: 2fff0000-2fffffff ( 64KB)

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 47 ++++++++++++++++++++++
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |  4 ++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 47 ++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index d7e2d89..63d3d17 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -872,6 +872,53 @@
 			};
 		};
 
+		pcie: pcie@66000000 {
+			compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
+			status = "disabled";
+			reg-names = "dbi", "link", "config";
+			reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
+			      <0x2fff0000 0x10000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			clocks = <&sys_clk 24>;
+			resets = <&sys_rst 24>;
+			num-lanes = <1>;
+			num-viewport = <1>;
+			bus-range = <0x0 0xff>;
+			device_type = "pci";
+			ranges =
+			/* downstream I/O */
+				<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
+			/* non-prefetchable memory */
+				 0x82000000 0 0x20000000  0x20000000  0 0x0ffe0000>;
+			#interrupt-cells = <1>;
+			interrupt-names = "dma", "msi";
+			interrupts = <0 224 4>, <0 225 4>;
+			interrupt-map-mask = <0 0 0  7>;
+			interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
+					<0 0 0  2  &pcie_intc 1>,	/* INTB */
+					<0 0 0  3  &pcie_intc 2>,	/* INTC */
+					<0 0 0  4  &pcie_intc 3>;	/* INTD */
+			phy-names = "pcie-phy";
+			phys = <&pcie_phy>;
+
+			pcie_intc: legacy-interrupt-controller {
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <0 226 4>;
+			};
+		};
+
+		pcie_phy: phy@66038000 {
+			compatible = "socionext,uniphier-ld20-pcie-phy";
+			reg = <0x66038000 0x4000>;
+			#phy-cells = <0>;
+			clocks = <&sys_clk 24>;
+			resets = <&sys_rst 24>;
+			socionext,syscon = <&soc_glue>;
+		};
+
 		nand: nand@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index a41f7ca..f91d77f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -112,3 +112,7 @@
 &usb1 {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 4f57c9e..fe56a32 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -727,6 +727,53 @@
 			};
 		};
 
+		pcie: pcie@66000000 {
+			compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
+			status = "disabled";
+			reg-names = "dbi", "link", "config";
+			reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
+			      <0x2fff0000 0x10000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			clocks = <&sys_clk 24>;
+			resets = <&sys_rst 24>;
+			num-lanes = <1>;
+			num-viewport = <1>;
+			bus-range = <0x0 0xff>;
+			device_type = "pci";
+			ranges =
+			/* downstream I/O */
+				<0x81000000 0 0x00000000  0x2ffe0000  0 0x00010000
+			/* non-prefetchable memory */
+				 0x82000000 0 0x20000000  0x20000000  0 0x0ffe0000>;
+			#interrupt-cells = <1>;
+			interrupt-names = "dma", "msi";
+			interrupts = <0 224 4>, <0 225 4>;
+			interrupt-map-mask = <0 0 0  7>;
+			interrupt-map = <0 0 0  1  &pcie_intc 0>,	/* INTA */
+					<0 0 0  2  &pcie_intc 1>,	/* INTB */
+					<0 0 0  3  &pcie_intc 2>,	/* INTC */
+					<0 0 0  4  &pcie_intc 3>;	/* INTD */
+			phy-names = "pcie-phy";
+			phys = <&pcie_phy>;
+
+			pcie_intc: legacy-interrupt-controller {
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <0 226 4>;
+			};
+		};
+
+		pcie_phy: phy@66038000 {
+			compatible = "socionext,uniphier-pxs3-pcie-phy";
+			reg = <0x66038000 0x4000>;
+			#phy-cells = <0>;
+			clocks = <&sys_clk 24>;
+			resets = <&sys_rst 24>;
+			socionext,syscon = <&soc_glue>;
+		};
+
 		nand: nand@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
