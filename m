Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93815C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:18:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F34620851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DdUGPOsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F34620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IysRLj8vj8RK6o7MsKiz1fV3yYFb5MfHfoL6bXCqydQ=; b=DdUGPOsjD+DnPp
	9+rFwU6YeCzjQaZnF5eVqkP0aA3nwJOqajOjix3zy/QtZut2A32/Or/QsQVK0is9qiv8dQETODrFA
	PRuMaZeDVEDbibP8EL1Xj5UEXaerIOw4N0vnwjEYW3Gky0ynrkfJgKwwGpfGFxln36TBL4xz1Th9f
	c+gvD1RLD4N+8LP5a0awe7h9wOb1Wdrv78jpOXoUySBNyL343HErozL9cx7QbcbjzidnzSZ1HfnkW
	wkYKJRDDr9MgBlaExYEyNvmVSA1ClJjAVgKojrjHMPPBK3k980M5hNNO6cCj6F5Rf1shYeL5xxtG2
	6xpx0Wa3CvoWuJSTUuKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXGZw-0006ce-38; Thu, 13 Dec 2018 02:18:20 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXGZs-0006bj-Pm
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 02:18:18 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 0774880EE;
 Thu, 13 Dec 2018 02:18:09 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: Fix wrong address for omap5 sata phy
Date: Wed, 12 Dec 2018 18:18:00 -0800
Message-Id: <20181213021801.49938-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_181816_893241_D618A272 
X-CRM114-Status: UNSURE (   8.44  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Looks like I missed converting the omap5 sata phy addresses to use offset
from the module base instead of full physical address.

While at it, we can also more it to be a direct parent of the interconnect
target module, it is not really a child of the ocp2scp control device.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-l4.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/omap5-l4.dtsi
--- a/arch/arm/boot/dts/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/omap5-l4.dtsi
@@ -515,19 +515,19 @@
 					#address-cells = <1>;
 					#size-cells = <1>;
 					reg = <0x0 0x20>;
-					ranges = <0 0 0x4000>;
-					sata_phy: phy@4a096000 {
-						compatible = "ti,phy-pipe3-sata";
-						reg = <0x6000 0x80>, /* phy_rx */
-						      <0x4A096400 0x64>, /* phy_tx */
-						      <0x4A096800 0x40>; /* pll_ctrl */
-						reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-						syscon-phy-power = <&scm_conf 0x374>;
-						clocks = <&sys_clkin>,
-							 <&l3init_clkctrl OMAP5_SATA_CLKCTRL 8>;
-						clock-names = "sysclk", "refclk";
-						#phy-cells = <0>;
-					};
+				};
+
+				sata_phy: phy@6000 {
+					compatible = "ti,phy-pipe3-sata";
+					reg = <0x6000 0x80>, /* phy_rx */
+					      <0x6400 0x64>, /* phy_tx */
+					      <0x6800 0x40>; /* pll_ctrl */
+					reg-names = "phy_rx", "phy_tx", "pll_ctrl";
+					syscon-phy-power = <&scm_conf 0x374>;
+					clocks = <&sys_clkin>,
+						 <&l3init_clkctrl OMAP5_SATA_CLKCTRL 8>;
+					clock-names = "sysclk", "refclk";
+					#phy-cells = <0>;
 				};
 		};
 
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
