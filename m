Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:02:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBF020656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e2ee01yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBF020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PWSWo0r3FD98T4vsCrOKxsZdHFvy7Nn5fqLNmcxdlxg=; b=e2ee01yg2MHSvn
	rVpxGmPbmQBkHbAPobW6z6Q0A/Bp9Ls0+boBNcvbxJ+WdH1TbDM+DloIF3260LbrHwz51HWRST2r5
	aP/LV+a8CyTq/ko11Td9yd2dUKhR+Ecr/faNxOXeppnc7/BtnKU7NzWcgz+L627MvrjGpbXevEuia
	9pCceG7+9Nfu6j7ELoPIDb+Q2FNPLt6B6B1UqoH0ibZ8rf7dXuAEMYH+Xl7KT8AoDeQNs1ooYHy7B
	KWhKEruytTIvoTHE+IdBRZxGup5/qBcFtQO5UJfB3XzEh2/zmKRsbWOsDRkD7ZeYZ0jYs/ZFhhD4H
	t4H5+4RcEnBc60bVf5Dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjMTs-0003hy-O2; Tue, 15 Jan 2019 11:02:04 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjMTe-0003Xo-79
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 11:01:52 +0000
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28]
 helo=dude02.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gjMTa-0005As-B8; Tue, 15 Jan 2019 12:01:46 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: imx8mq: add GPC power domains
Date: Tue, 15 Jan 2019 12:01:44 +0100
Message-Id: <20190115110145.11017-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_030150_422613_BE585050 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds support for the power domain controller found on the
i.MX8MQ SoC.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2:
- fix node numbering to be in hex
- make node names more generic by dropping pgc- prefix
- add required reset clocks for the GPU domain
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a55b9329376b..5bd1f106ed84 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/clock/imx8mq-clock.h>
+#include <dt-bindings/power/imx8mq-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx8mq-pinfunc.h"
@@ -252,6 +253,75 @@
 				              "clk_ext1", "clk_ext2",
 				              "clk_ext3", "clk_ext4";
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mq-gpc";
+				reg = <0x303a0000 0x10000>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_mipi: power-domain@0 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_MIPI>;
+					};
+
+					pgc_pcie1: power-domain@1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_PCIE1>;
+					};
+
+					pgc_otg1: power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_USB_OTG1>;
+					};
+
+					pgc_otg2: power-domain@3 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_USB_OTG2>;
+					};
+
+					pgc_ddr1: power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_DDR1>;
+					};
+
+					pgc_gpu: power-domain@5 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_GPU>;
+						clocks = <&clk IMX8MQ_CLK_GPU_ROOT>,
+						         <&clk IMX8MQ_CLK_GPU_SHADER_DIV>,
+							 <&clk IMX8MQ_CLK_GPU_AXI>,
+						         <&clk IMX8MQ_CLK_GPU_AHB>;
+					};
+
+					pgc_vpu: power-domain@6 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_VPU>;
+					};
+
+					pgc_disp: power-domain@7 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_DISP>;
+					};
+
+					pgc_mipi_csi1: power-domain@8 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_MIPI_CSI1>;
+					};
+
+					pgc_mipi_csi2: power-domain@9 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_MIPI_CSI2>;
+					};
+
+					pgc_pcie2: power-domain@a {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_PCIE2>;
+					};
+				};
+			};
 		};
 
 		bus@30400000 { /* AIPS2 */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
