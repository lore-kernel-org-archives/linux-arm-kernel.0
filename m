Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC98C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:55:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281AB20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="obNQU82/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281AB20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qb8hyDY084/bNU31jcT6eJlOgsbzsEdhlbpQ0XGHPzE=; b=obNQU82/waMmgp
	LXGnSusD1pYpESGNx26R2HLcBwtZ2Jn6z+CuZlCr8DwpAvQU1p7XrlDgx4RRj9Z20ho8NLcsafo46
	DvuInQ+XwavpYUvmdY3w2MUxHCE51RL9wHvCCo5rSuByWfzu9KguwN6j2Kbsd+XpD5iwmKVTAvxOX
	t7zAx7JPlNNYNAFRs4uVQ5kbTUaFJ68MxVx3kthz45bhMqNp3D1LSoXiutU7rA8qMxZrBxG4liePU
	XlSTOYVrGKOwTcpWNfbGV8Slt5hioTIEFKaGNF9hc7J5qej7y72l3TuxannQw61kwv/EqajOUsHt2
	EQCOiupoHJdmJNHPnrLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXl7x-0001Ls-5Y; Fri, 14 Dec 2018 10:55:29 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXl7t-0001Ki-94
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 10:55:26 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7]
 helo=dude.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gXl7f-0003gg-Fu; Fri, 14 Dec 2018 11:55:11 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 2/2] arm64: dts: imx8mq: add GPC power domains
Date: Fri, 14 Dec 2018 11:55:10 +0100
Message-Id: <20181214105510.1174-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181214105510.1174-1-l.stach@pengutronix.de>
References: <20181214105510.1174-1-l.stach@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_025525_481242_2D4C8905 
X-CRM114-Status: UNSURE (   9.73  )
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
Cc: devicetree@vger.kernel.org, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds support for the power domain controller found on the
i.MX8MQ SoC.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 66 +++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a55b9329376b..c521cd1b6820 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/clock/imx8mq-clock.h>
+#include <dt-bindings/power/imx8mq-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx8mq-pinfunc.h"
@@ -252,6 +253,71 @@
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
+					pgc_mipi: pgc-power-domain@0 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_MIPI>;
+					};
+
+					pgc_pcie1: pgc-power-domain@1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_PCIE1>;
+					};
+
+					pgc_otg1: pgc-power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_USB_OTG1>;
+					};
+
+					pgc_otg2: pgc-power-domain@3 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_USB_OTG2>;
+					};
+
+					pgc_ddr1: pgc-power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_DDR1>;
+					};
+
+					pgc_gpu: pgc-power-domain@5 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_GPU>;
+					};
+
+					pgc_vpu: pgc-power-domain@6 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_VPU>;
+					};
+
+					pgc_disp: pgc-power-domain@7 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_DISP>;
+					};
+
+					pgc_mipi_csi1: pgc-power-domain@8 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_MIPI_CSI1>;
+					};
+
+					pgc_mipi_csi2: pgc-power-domain@9 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_MIPI_CSI2>;
+					};
+
+					pgc_pcie2: pgc-power-domain@10 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_PCIE2>;
+					};
+				};
+			};
 		};
 
 		bus@30400000 { /* AIPS2 */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
