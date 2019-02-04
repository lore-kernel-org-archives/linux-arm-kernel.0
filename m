Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C70C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:30:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A942082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D9O3gjdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A942082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=09PW7gcWdAccPyxnQ3lBD8+GfCLBEVa9taRxRPm8R9Q=; b=D9O3gjdwySgTRY
	TEl8xpzrls6N/mYm0l0F4HD1rOutmZLFs7ESYcDH9+7+dIghOzqSfZOf3ozDg1V7/ADkSoei0NlwF
	I/uN5ZBTNpqm+3rcyT5kbqYZE68TRYooLEu7qKRdUwOrCo1P0BGCKXmCDARxNq1Uxw3+HOkgS1YdP
	6oaQsOscVLCbOPylGbY2Qd7zYWn0Disy7zH45RWhnh9YwrE0RvTrXikoc0p9icDLLuD0P7rciof5t
	TBWYYFWVsfqNMngtHyZgv9+fR5m4Z+JYxbeQcHgrv9Xs10Tg3X4RHqkY0BJpP2SN+wL07frIunc6c
	lyJRg0rlXuR20+4csasw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqgCa-0001PG-1i; Mon, 04 Feb 2019 15:30:28 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqgCM-0001GB-Nr
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 15:30:16 +0000
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28]
 helo=dude02.lab.pengutronix.de)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gqgCG-0005g3-Mg; Mon, 04 Feb 2019 16:30:08 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gqgCF-00089W-SM; Mon, 04 Feb 2019 16:30:07 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
 linux-imx@nxp.com, robh+dt@kernel.org, c.hemp@phytec.de
Subject: [PATCH 2/2] ARM: dts: pfla02: add ksz9031 clock skew values
Date: Mon,  4 Feb 2019 16:29:56 +0100
Message-Id: <20190204152956.13471-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204152956.13471-1-m.felsch@pengutronix.de>
References: <20190204152956.13471-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_073014_932500_E39319CB 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

The pfla02 SoM has a Micrel KSZ9031RNX ethernet phy connected to the FEC,
which needs RX and TX clock skew settings to compensate for differences
in line length. The skew values are taken from barebox commit
4c65c20f1071 ("ARM: pfla02: Set new ethernet phy tx timings"), which
is based on patches originally provided by Phytec:

    TX_CLK line is approx. 54mm longer than other TX lines which adds
    a delay of 0.36ns. RGMII need a delay of min. 1.0ns. This mean we
    have to add a delay of 0.64ns. We choose 0.78 to have a little gap.
    This can be done by setting GTX pad skew value to 11100
    Also add a delay for the RX delay lines, needed for the Duallite
    variant.  => Set register 2.8 (RGMII Clock Pad Skew) to 0x039F.

Cc: Christian Hemp <c.hemp@phytec.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 35d56e25c4a0..673711f445b6 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -89,10 +89,23 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
+	phy-handle = <&ethphy>;
 	phy-mode = "rgmii";
 	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 	phy-supply = <&vdd_eth_io_reg>;
 	status = "disabled";
+
+	fec_mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			txc-skew-ps = <1680>;
+			rxc-skew-ps = <1860>;
+		};
+	};
 };
 
 &gpmi {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
