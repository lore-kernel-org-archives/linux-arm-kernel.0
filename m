Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F354C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:03:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091C820878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W0pf9KEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091C820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8iLJkEx/dT3ARwbREK6vryRkgEkOkKeZk9W84q18d0Y=; b=W0pf9KEdbe6DJm
	3jKyC0/2/55vWOytPEN6j8Rc7b/q9pOAitUIRHTcuzguumcIuH3EF4lprEvprDCSISWMc3x358Bsp
	5Ua6Be0j0KyJfCbXdw8CSxqEf7bdxCD4uAJcCj4hHKrsAGRogWfNisbZCCnTmjE9skB7chZPBIR7C
	yXVippbQjcDdhfpmDo25jbCr4diNQWOL7tVv2sWQzOTHKkCoVFxsTep5hL1aEc7IWCnfeLMQIV06H
	rEVbmXM2YyQwvNLTwsuE9Fun2xAjcja+GMwDkMOZxOu0dE6d0it5hFD3hSzfO0PDZl14kAjyDmhDf
	62R9ONRdrVhg2tvIogUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsNi-00037T-5H; Thu, 06 Dec 2018 12:03:50 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsNY-0002qm-WC; Thu, 06 Dec 2018 12:03:46 +0000
Received: from droid10.amlogic.com (10.18.11.213) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 6 Dec 2018
 20:03:07 +0800
From: Hanjie Lin <hanjie.lin@amlogic.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: [PATCH v7 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic
 Meson PCIe controller
Date: Thu, 6 Dec 2018 20:02:37 +0800
Message-ID: <1544097760-85834-2-git-send-email-hanjie.lin@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544097760-85834-1-git-send-email-hanjie.lin@amlogic.com>
References: <1544097760-85834-1-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
X-Originating-IP: [10.18.11.213]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_040341_145097_4F0B3081 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
 Hanjie Lin <hanjie.lin@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yue Wang <yue.wang@amlogic.com>,
 Qiufang Dai <qiufang.dai@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Liang Yang <liang.yang@amlogic.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yue Wang <yue.wang@amlogic.com>

The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
PCI core. This patch adds documentation for the DT bindings in Meson PCIe
controller.

Signed-off-by: Yue Wang <yue.wang@amlogic.com>
Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
new file mode 100644
index 0000000..12b18f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
@@ -0,0 +1,70 @@
+Amlogic Meson AXG DWC PCIE SoC controller
+
+Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
+It shares common functions with the PCIe DesignWare core driver and
+inherits common properties defined in
+Documentation/devicetree/bindings/pci/designware-pci.txt.
+
+Additional properties are described here:
+
+Required properties:
+- compatible:
+	should contain "amlogic,axg-pcie" to identify the core.
+- reg:
+	should contain the configuration address space.
+- reg-names: Must be
+	- "elbi"	External local bus interface registers
+	- "cfg"		Meson specific registers
+	- "phy"		Meson PCIE PHY registers
+	- "config"	PCIe configuration space
+- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Must include the following entries:
+	- "pclk"       PCIe GEN 100M PLL clock
+	- "port"       PCIe_x(A or B) RC clock gate
+	- "general"    PCIe Phy clock
+	- "mipi"       PCIe_x(A or B) 100M ref clock gate
+- resets: phandle to the reset lines.
+- reset-names: must contain "phy" "port" and "apb"
+       - "phy"         Share PHY reset
+       - "port"        Port A or B reset
+       - "apb"         Share APB reset
+- device_type:
+	should be "pci". As specified in designware-pcie.txt
+
+
+Example configuration:
+
+	pcie: pcie@f9800000 {
+			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
+			reg = <0x0 0xf9800000 0x0 0x400000
+					0x0 0xff646000 0x0 0x2000
+					0x0 0xff644000 0x0 0x2000
+					0x0 0xf9f00000 0x0 0x100000>;
+			reg-names = "elbi", "cfg", "phy", "config";
+			reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
+			bus-range = <0x0 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
+
+			clocks = <&clkc CLKID_USB
+					&clkc CLKID_MIPI_ENABLE
+					&clkc CLKID_PCIE_A
+					&clkc CLKID_PCIE_CML_EN0>;
+			clock-names = "general",
+					"mipi",
+					"pclk",
+					"port";
+			resets = <&reset RESET_PCIE_PHY>,
+				<&reset RESET_PCIE_A>,
+				<&reset RESET_PCIE_APB>;
+			reset-names = "phy",
+					"port",
+					"apb";
+	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
