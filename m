Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADDEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:04:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FCF2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="USzIYxAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FCF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cIChfXc4FA4qWJlThg13zUdSSqXcEHU+Yuy2WhqW0Xw=; b=USzIYxAs2i4h18wmcCxYceWtz5
	GnXi8stqpGQCGQoTPC3+dY+VZ05Epnf7nUnAn9HqRaZUISWmWMORqlKbvZ12CVfGO5g9geibvOZ6x
	MsvW93CORWJOSBB09+MVtKK7TnQBi4zSvkpcBLy/7aoY3TelGuxcB0Sps1j19FPWECRJwamunxJrb
	T1LcNNIiuE48QKfNuQTDxx4pvvf6nn3nQ3y0p922Ze1tWtn0UUAQy0Uxe3a15tBqboTkKWa8yVOu3
	vZXAgdRH+VIjuhPFVNRD+Ktf4a/kRdetr2DD9KFxDvVugu47l4fKi9qOnhNtoleLJDXri7CdYzXge
	B0PFT09g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCNQ-0005ag-1J; Fri, 22 Feb 2019 15:04:36 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCNF-0005PF-JY
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:04:27 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E4471A01FF;
 Fri, 22 Feb 2019 16:04:21 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 41BE11A01E1;
 Fri, 22 Feb 2019 16:04:21 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net
 (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DB0582062B;
 Fri, 22 Feb 2019 16:04:20 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next v3 1/4] arm64: dts: fsl: ls1028a: Add PCI IERC node
 and ENETC endpoints
Date: Fri, 22 Feb 2019 17:04:16 +0200
Message-Id: <1550847859-17346-2-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
References: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070426_035832_902B0D95 
X-CRM114-Status: UNSURE (   9.66  )
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
Cc: devicetree@vger.kernel.org, alexandru.marginean@nxp.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The LS1028A SoC features a PCI Integrated Endpoint Root Complex
(IERC) defining several integrated PCI devices, including the ENETC
ethernet controller integrated endpoints (IEPs). The IERC implements
ECAM (Enhanced Configuration Access Mechanism) to provide access
to the PCIe config space of the IEPs. This means the the IEPs
(including ENETC) do not support the standard PCIe BARs, instead
the Enhanced Allocation (EA) capability structures in the ECAM space
are used to fix the base addresses in the system, and the PCI
subsystem uses these structures for device enumeration and discovery.
The "ranges" entries contain basic information from these EA capabily
structures required by the kernel for device enumeration.

The current patch also enables the first 2 ENETC PFs (Physiscal
Functions) and the associated VFs (Virtual Functions), 2 VFs for
each PF.  Each of these ENETC PFs has an external ethernet port
on the LS1028A SoC.

Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2 - none
v3 - none

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index a8cf92a..7f5a8e6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -335,5 +335,38 @@
 				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		pcie@1f0000000 { /* Integrated Endpoint Root Complex */
+			compatible = "pci-host-ecam-generic";
+			reg = <0x01 0xf0000000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			msi-parent = <&its>;
+			device_type = "pci";
+			bus-range = <0x0 0x0>;
+			dma-coherent;
+			msi-map = <0 &its 0x17 0xe>;
+			iommu-map = <0 &smmu 0x17 0xe>;
+				  /* PF0-6 BAR0 - non-prefetchable memory */
+			ranges = <0x82000000 0x0 0x00000000  0x1 0xf8000000  0x0 0x160000
+				  /* PF0-6 BAR2 - prefetchable memory */
+				  0xc2000000 0x0 0x00000000  0x1 0xf8160000  0x0 0x070000
+				  /* PF0: VF0-1 BAR0 - non-prefetchable memory */
+				  0x82000000 0x0 0x00000000  0x1 0xf81d0000  0x0 0x020000
+				  /* PF0: VF0-1 BAR2 - prefetchable memory */
+				  0xc2000000 0x0 0x00000000  0x1 0xf81f0000  0x0 0x020000
+				  /* PF1: VF0-1 BAR0 - non-prefetchable memory */
+				  0x82000000 0x0 0x00000000  0x1 0xf8210000  0x0 0x020000
+				  /* PF1: VF0-1 BAR2 - prefetchable memory */
+				  0xc2000000 0x0 0x00000000  0x1 0xf8230000  0x0 0x020000>;
+
+			enetc_port0: pci@0,0 {
+				reg = <0x000000 0 0 0 0>;
+			};
+			enetc_port1: pci@0,1 {
+				reg = <0x000100 0 0 0 0>;
+			};
+		};
 	};
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
