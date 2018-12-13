Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B301C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:40:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0527020645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r5vXmRJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0527020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8VPBUz8L6OKjbXFKbHoA1BG4pblSFI/wgTZhfOoctrM=; b=r5vXmRJu8AtCEO
	MvXanfK5ET1CqI1neTWXUTMcKN0hsnNKPZiKggKtOymF1nKP69j3CWODR/yfXjXArbnoT2orle9/D
	+ibYylwNm5t0G00Ku4DWGjvvk+r+dihAA1GN0bc+adsZ+uWS1d+g1LfdAZ7/8Lu5R1n0Z5JBfSXGj
	k3tFh7jNXdzfMnW4gPCQd1DOuCV5NZNUbUktFPPw39Y6zkXjyykeM3jpYUMCOk0EW4R7+RI82oybh
	7Yci28wpEbpRSqd3L6IgAENDx5LHzNPz+hvkkdGSejjn15u92L9gGqH29UALyKHHgQp6bshEv5KXr
	Gvy2czOMhVmEV27nqeIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXMY4-00057t-8c; Thu, 13 Dec 2018 08:40:48 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXMWu-0002Zk-Sa
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 08:39:39 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 961FD20C94; Thu, 13 Dec 2018 09:39:17 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id ACFF3206FF;
 Thu, 13 Dec 2018 09:39:16 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 7/7] ARM64: dts: marvell: armada-37xx: declare the COMPHY
 node
Date: Thu, 13 Dec 2018 09:39:08 +0100
Message-Id: <20181213083908.14180-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213083908.14180-1-miquel.raynal@bootlin.com>
References: <20181213083908.14180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_003937_405541_D64E2613 
X-CRM114-Status: GOOD (  11.65  )
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
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Describe the A3700 COMPHY node. It has three PHYs that can be
configured as follow:
* PCIe or GbE
* USB3 or GbE
* SATA or USB3
Each of them has its own memory area.

Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index e7405931f381..036d6fd6c9ef 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -242,6 +242,35 @@
 				reg = <0x14000 0x60>;
 			};
 
+			comphy: phy@18300 {
+				compatible = "marvell,comphy-a3700";
+				reg = <0x18300 0x300>,
+				      <0x1F000 0x400>,
+				      <0x5C000 0x400>,
+				      <0xe0178 0x8>;
+				reg-names = "comphy",
+					    "lane1_pcie_gbe",
+					    "lane0_usb3_gbe",
+					    "lane2_sata_usb3";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				comphy0: phy@0 {
+					reg = <0>;
+					#phy-cells = <1>;
+				};
+
+				comphy1: phy@1 {
+					reg = <1>;
+					#phy-cells = <1>;
+				};
+
+				comphy2: phy@2 {
+					reg = <2>;
+					#phy-cells = <1>;
+				};
+			};
+
 			pinctrl_sb: pinctrl@18800 {
 				compatible = "marvell,armada3710-sb-pinctrl",
 					     "syscon", "simple-mfd";
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
