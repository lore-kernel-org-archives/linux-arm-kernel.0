Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA61C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:20:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93D12133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FW6s7rVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93D12133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6ywgYXbe8TUGUY9XqIIT6S1zFZ0eD7SFCwbalmVlw9A=; b=FW6s7rVDjCn0WE
	JlLTFosYQp7wB8cd/pD31sFeoZyl7MJIDxGZYOSFA5DiAejAaWFtIFWtYHvEc+14PscBQ6RNkPaRi
	Yk8iVShqp3XBCzAUzYytJ/TBDY5sUPGCzR31Iz/rTSU73AKj8++ERhvFAGvgIxEI1JQOTpStZyWGW
	Oc3DgW0NgCzVmpoQe7FWE3qQVIZekggvbq3ngQrQlKuvkJdBrS7BknZ9YH9tpaYFdJ9uwtinQXvOC
	8/ry+GInEEr9xhOL4gZuL0Vac3iwYf/01g0GoZ0tlt25KwUgMeyngZmMRVNbjgFBT6s5/bBE3IXuM
	bAClULfuXo/ozcIht+lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4Dx-0000qI-1n; Fri, 25 Jan 2019 16:20:57 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4Df-0000co-SF
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:20:41 +0000
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28]
 helo=dude02.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gn4Db-0004TU-Co; Fri, 25 Jan 2019 17:20:35 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
Date: Fri, 25 Jan 2019 17:20:33 +0100
Message-Id: <20190125162034.12984-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_082040_063267_24A0F0DC 
X-CRM114-Status: GOOD (  10.52  )
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
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GPCv2 sits between most of the peripherals and the GIC and
functions as a wakeup controller for the CPU cores.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 5bd1f106ed84..af2584d51fa2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -11,8 +11,7 @@
 #include "imx8mq-pinfunc.h"
 
 / {
-	/* This should really be the GPC, but we need a driver for this first */
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&gpc>;
 
 	#address-cells = <2>;
 	#size-cells = <2>;
@@ -257,6 +256,9 @@
 			gpc: gpc@303a0000 {
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
 
 				pgc {
 					#address-cells = <1>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
