Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CBFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:53:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3599218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f5rq9a8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3599218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Nyy3uTsyTL7hPT+iPTlcp7gRRLVQlgIKUSbCTntHRnc=; b=f5r
	q9a8Qc0QNvPa8FvY+kJWXjAct2ZtL3NsXtecHpapPbTdS2pwffgeqja/Mf3+Z/35mHOBXYFClaphm
	NErUxYAf0qhdhTeWyC1yLWuk4LHkkFpuKA4c/PNCN9p40EIgUItOPOclSdYfCLTExuStI/bnJNumd
	UNiuX4eDgF0xvNJmVwI2vEdlGHzu1Yeu86pNHr689GD1NEb84bLcYbB7hBWgrc/mAJscZR8pzSWJN
	t39fS3k3DdrDHq95vcPr7NjyHsPkR+bX9m2V0kU6C9lPcQDquJtOw5NCQexiUElh7LRA42G/eMMqx
	WLmOen1EkClw7ucPdp5rKijShVUiL/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyrDf-0003oP-Gq; Wed, 27 Feb 2019 04:53:23 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyrDO-0003XW-Bk
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 04:53:10 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 27 Feb 2019 13:53:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 65972180D46;
 Wed, 27 Feb 2019 13:53:05 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 27 Feb 2019 13:53:05 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id D364A40392;
 Wed, 27 Feb 2019 13:53:04 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id B1B47121B6C;
 Wed, 27 Feb 2019 13:53:04 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@kernel.org
Subject: [PATCH v4 08/10] ARM: dts: milbeaut: Add device tree set for the
 Milbeaut M10V board
Date: Wed, 27 Feb 2019 13:53:40 +0900
Message-Id: <1551243220-10864-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_205306_930366_C4ACD455 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add devicetree for Milbeaut M10V SoC and M10V Evaluation board.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dts | 32 +++++++++++
 arch/arm/boot/dts/milbeaut-m10v.dtsi    | 95 +++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dts
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148..f697d87 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1233,6 +1233,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7623n-bananapi-bpi-r2.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
+dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
diff --git a/arch/arm/boot/dts/milbeaut-m10v-evb.dts b/arch/arm/boot/dts/milbeaut-m10v-evb.dts
new file mode 100644
index 0000000..614f60c
--- /dev/null
+++ b/arch/arm/boot/dts/milbeaut-m10v-evb.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Socionext Milbeaut M10V Evaluation Board */
+/dts-v1/;
+#include "milbeaut-m10v.dtsi"
+
+/ {
+	model = "Socionext M10V EVB";
+	compatible = "socionext,milbeaut-m10v-evb", "socionext,sc2000a";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		bootargs = "rootwait earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		uclk40xi: uclk40xi {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <40000000>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000  0x80000000>;
+	};
+
+};
diff --git a/arch/arm/boot/dts/milbeaut-m10v.dtsi b/arch/arm/boot/dts/milbeaut-m10v.dtsi
new file mode 100644
index 0000000..aa7c6ca
--- /dev/null
+++ b/arch/arm/boot/dts/milbeaut-m10v.dtsi
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "socionext,sc2000a";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "socionext,milbeaut-m10v-smp";
+		cpu@f00 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0xf00>;
+		};
+		cpu@f01 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0xf01>;
+		};
+		cpu@f02 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0xf02>;
+		};
+		cpu@f03 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0xf03>;
+		};
+	};
+
+	timer { /* The Generic Timer */
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			<GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			<GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			<GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		clock-frequency = <40000000>;
+		always-on;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&gic>;
+
+		gic: interrupt-controller@1d000000 {
+			compatible = "arm,cortex-a7-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x1d001000 0x1000>,
+			      <0x1d002000 0x1000>; /* CPU I/f base and size */
+		};
+
+		timer@1e000050 { /* 32-bit Reload Timers */
+			compatible = "socionext,milbeaut-timer";
+			reg = <0x1e000050 0x20>;
+			interrupts = <0 91 4>;
+		};
+
+		uart1: serial@1e700010 { /* PE4, PE5 */
+			/* Enable this as ttyUSI0 */
+			compatible = "socionext,milbeaut-usio-uart";
+			reg = <0x1e700010 0x10>;
+			interrupts = <0 141 0x4>, <0 149 0x4>;
+			interrupt-names = "rx", "tx";
+		};
+
+	};
+
+	sram@0 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0x10000>;
+		smp-sram@f100 {
+			compatible = "socionext,milbeaut-smp-sram";
+			reg = <0xf100 0x20>;
+		};
+	};
+};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
