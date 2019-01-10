Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951DFC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6136B2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UE/LoN4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6136B2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=w7xTYP+J1kJU+uceOCiZBU3rWIL/dS00NjH+7+wu9gw=; b=UE/LoN4ur0mlx3wFSszBgAUBNI
	7Dx0jdt3/Sw98SVnQpLFDesqlzTaTRUtIYmHm0QWJabiVScMCNwhgD6ZSjE+6i8AhM4mnWzxnF6Vq
	YzJrC+X85hx5wrlmYz29+7Loo075sEXwg81F5oOgCHp08YW1LPQtrF70mKaObbAg8yiOtm41YGOVm
	82lbDpCeoW8BCFH2KJ0R8UhwsRoEw2zdOtAztJmH9tVKCI73fvsvOwmu5Q61oivY2PSFYDIimbNYT
	Rmrk/OTrgdPohp/eC41VPz3/Fa/tBY3ZMk1bzeV/3bt98qfklsboJpcjKAiZ24kS+QEaKKnnfuP88
	wAwXThzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXIk-0005x0-HI; Thu, 10 Jan 2019 10:11:02 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXIh-0005vx-5n
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:11:00 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E96502000B9;
 Thu, 10 Jan 2019 11:10:55 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C4DB200059;
 Thu, 10 Jan 2019 11:10:51 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2569D402C8;
 Thu, 10 Jan 2019 18:10:45 +0800 (SGT)
From: Peng Ma <peng.ma@nxp.com>
To: shawnguo@kernel.org,
	axboe@kernel.dk
Subject: [PATCH 2/2] arm64: dts: lx2160a: add sata node support
Date: Thu, 10 Jan 2019 18:05:33 +0800
Message-Id: <20190110100533.33333-2-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190110100533.33333-1-peng.ma@nxp.com>
References: <20190110100533.33333-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_021059_349793_34CA3E64 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, linux-ide@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add sata node support and Enable sata support

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44 +++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 6481e5f..aacca27 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -117,3 +117,19 @@
 &usb1 {
 	status = "okay";
 };
+
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sata3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1..e857a14 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,49 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+
+		sata0: sata@3200000 {
+			status = "disabled";
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3200000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+		};
+
+		sata1: sata@3210000 {
+			status = "disabled";
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3210000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+		};
+
+		sata2: sata@3220000 {
+			status = "disabled";
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3220000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+		};
+
+		sata3: sata@3230000 {
+			status = "disabled";
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3230000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+		};
 	};
 };
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
