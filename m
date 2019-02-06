Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E649C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:06:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB77020821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HVs+Ub+i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DStq1T+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB77020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bpYbEk4o4ol76Sx89xH4g3E/K8XqF3lWKqjaqkDtmFU=; b=HVs
	+Ub+i5ewMAhC80w1oxF0EzmcTDjRXVMpMW2Izxfa0ap9IPJxUq/XB0aL0/EPP4lzr2QdGop4bZCwW
	UA1d1kC/5Q5eZLG54QwX+furtvWN1T/WFBG9BAWmCoYvLCmVuAUnitCVm9LA+MfV6GoZVcBoxs3Fr
	nbFGCtEZsTktMMZh2Huf+KgufG2aX8A0+Kq3voPxuXvwhmBG3c01Ph6EBmWxzGiE0J1nIJ1OXJxsh
	q5YMisgBIxFLGPC3LS1uS0hg3MgvAg8BzArdoVbuyMCGbtGm29w1O/1FXcidV+h8h3VLUXAMQ1b5V
	lv/Yw+19sk1ezbhLgObhH/6WrMrIUkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grRaM-0001sN-DP; Wed, 06 Feb 2019 18:06:10 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grRaI-0001ep-Ux
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
 :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hp6/EOSUYQyEh9rOBukoDQ0DPILF0FRlekRRDA+lrgc=; b=DStq1T+r466kLUD0E6pXRgof06
 Y/uC2pb/FvF+ryCOaQI6Fe+LFn33BHO6sdsn63pzRrJ1etyqP6G8Y6ZkC+xgGItM7cLexgrSOHD26
 wXzXQDtY/pHShbOFX5NycFSX/jCm6dpSh0ez1sj+abMgAWtE9g0jEgYElAqVscrECxuU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1grRZq-0008Rm-Ht; Wed, 06 Feb 2019 19:05:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gregory Clement <gregory.clement@bootlin.com>
Subject: [PATCH] arch: arm: dts: Remove disabled marvell,dsa properties
Date: Wed,  6 Feb 2019 19:05:26 +0100
Message-Id: <20190206180526.32423-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_100607_149763_072519CF 
X-CRM114-Status: UNSURE (   8.24  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 linux ARM <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These have been disable since the change to probe Marvell Ethernet
switches as MDIO devices. Remove the properties now that the code to
suppport them will also be removed soon.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-370-rd.dts           | 42 --------------
 arch/arm/boot/dts/armada-388-clearfog.dts     | 58 -------------------
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 47 ---------------
 arch/arm/boot/dts/kirkwood-dir665.dts         | 47 ---------------
 arch/arm/boot/dts/kirkwood-linksys-viper.dts  | 47 ---------------
 .../arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 47 ---------------
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi     | 41 -------------
 7 files changed, 329 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 2bfb3108b5b2..c910d157a686 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -114,48 +114,6 @@
 			};
 		};
 	};
-
-	dsa {
-		status = "disabled";
-
-		compatible = "marvell,dsa";
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		dsa,ethernet = <&eth1>;
-		dsa,mii-bus = <&mdio>;
-
-		switch@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x10 0>;	/* MDIO address 16, switch 0 in tree */
-
-			port@0 {
-				reg = <0>;
-				label = "lan0";
-			};
-
-			port@1 {
-			       reg = <1>;
-			       label = "lan1";
-			};
-
-			port@2 {
-			       reg = <2>;
-			       label = "lan2";
-			};
-
-			port@3 {
-			       reg = <3>;
-			       label = "lan3";
-			};
-
-			port@5 {
-			      reg = <5>;
-			      label = "cpu";
-			};
-		};
-	 };
 };
 
 &pciec {
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 89a354b43978..20f8d4667753 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -30,64 +30,6 @@
 		};
 	};
 
-	dsa@0 {
-		status = "disabled";
-
-		compatible = "marvell,dsa";
-		dsa,ethernet = <&eth1>;
-		dsa,mii-bus = <&mdio>;
-		pinctrl-0 = <&clearfog_dsa0_clk_pins &clearfog_dsa0_pins>;
-		pinctrl-names = "default";
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		switch@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4 0>;
-
-			port@0 {
-				reg = <0>;
-				label = "lan5";
-			};
-
-			port@1 {
-				reg = <1>;
-				label = "lan4";
-			};
-
-			port@2 {
-				reg = <2>;
-				label = "lan3";
-			};
-
-			port@3 {
-				reg = <3>;
-				label = "lan2";
-			};
-
-			port@4 {
-				reg = <4>;
-				label = "lan1";
-			};
-
-			port@5 {
-				reg = <5>;
-				label = "cpu";
-			};
-
-			port@6 {
-				/* 88E1512 external phy */
-				reg = <6>;
-				label = "lan6";
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-0 = <&rear_button_pins>;
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 7a2606c3b62e..8480a16919a0 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -210,53 +210,6 @@
 		compatible = "pwm-fan";
 		pwms = <&gpio0 24 4000>;
 	};
-
-	dsa {
-		status = "disabled";
-
-		compatible = "marvell,dsa";
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		dsa,ethernet = <&eth0>;
-		dsa,mii-bus = <&mdio>;
-
-		switch@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x0 0>;	/* MDIO address 0, switch 0 in tree */
-
-			port@0 {
-				reg = <0>;
-				label = "lan4";
-			};
-
-			port@1 {
-				reg = <1>;
-				label = "lan3";
-			};
-
-			port@2 {
-				reg = <2>;
-				label = "lan2";
-			};
-
-			port@3 {
-				reg = <3>;
-				label = "lan1";
-			};
-
-			port@4 {
-				reg = <4>;
-				label = "internet";
-			};
-
-			port@5 {
-				reg = <5>;
-				label = "cpu";
-			};
-		};
-	};
 };
 
 &pciec {
diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/kirkwood-dir665.dts
index 31ceacd841de..b3ad3f607d31 100644
--- a/arch/arm/boot/dts/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/kirkwood-dir665.dts
@@ -190,53 +190,6 @@
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
 	};
-
-	dsa {
-		status = "disabled";
-
-		compatible = "marvell,dsa";
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		dsa,ethernet = <&eth0port>;
-		dsa,mii-bus = <&mdio>;
-
-		switch@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0 0>;	/* MDIO address 0, switch 0 in tree */
-
-			port@0 {
-				reg = <0>;
-				label = "lan4";
-			};
-
-			port@1 {
-			       reg = <1>;
-			       label = "lan3";
-			};
-
-			port@2 {
-			       reg = <2>;
-			       label = "lan2";
-			};
-
-			port@3 {
-			       reg = <3>;
-			       label = "lan1";
-			};
-
-			port@4 {
-				reg = <4>;
-				label = "wan";
-			};
-
-			port@6 {
-			       reg = <6>;
-			       label = "cpu";
-			};
-		};
-	};
 };
 
 &mdio {
diff --git a/arch/arm/boot/dts/kirkwood-linksys-viper.dts b/arch/arm/boot/dts/kirkwood-linksys-viper.dts
index a7d659b7145a..2f9660f3b457 100644
--- a/arch/arm/boot/dts/kirkwood-linksys-viper.dts
+++ b/arch/arm/boot/dts/kirkwood-linksys-viper.dts
@@ -66,53 +66,6 @@
 			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
 		};
 	};
-
-	dsa {
-		status = "disabled";
-
-		compatible = "marvell,dsa";
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		dsa,ethernet = <&eth0port>;
-		dsa,mii-bus = <&mdio>;
-
-		switch@16,0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <16 0>;	/* MDIO address 16, switch 0 in tree */
-
-			port@0 {
-				reg = <0>;
-				label = "ethernet1";
-			};
-
-			port@1 {
-				reg = <1>;
-				label = "ethernet2";
-			};
-
-			port@2 {
-				reg = <2>;
-				label = "ethernet3";
-			};
-
-			port@3 {
-				reg = <3>;
-				label = "ethernet4";
-			};
-
-			port@4 {
-				reg = <4>;
-				label = "internet";
-			};
-
-			port@5 {
-				reg = <5>;
-				label = "cpu";
-			};
-		};
-	};
 };
 
 &pinctrl {
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index 86d532916d56..2e1a75348908 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -107,53 +107,6 @@
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
 	};
-
-	dsa {
-		status = "disabled";
-
-		compatible = "marvell,dsa";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		dsa,ethernet = <&eth0port>;
-		dsa,mii-bus = <&mdio>;
-
-		switch@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0 0>;	/* MDIO address 0, switch 0 in tree */
-
-			port@0 {
-				reg = <0>;
-				label = "lan1";
-			};
-
-			port@1 {
-				reg = <1>;
-				label = "lan2";
-			};
-
-			port@2 {
-				reg = <2>;
-				label = "lan3";
-			};
-
-			port@3 {
-				reg = <3>;
-				label = "lan4";
-			};
-
-			port@4 {
-				reg = <4>;
-				label = "wan";
-			};
-
-			port@5 {
-				reg = <5>;
-				label = "cpu";
-			};
-		};
-	};
 };
 
 &mdio {
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
index 0f22f0e6f56b..f1f8eee132e8 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
@@ -48,47 +48,6 @@
 			cd-gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
 			/* No WP GPIO */
 		};
-	};
-
-	dsa {
-		status = "disabled";
-
-		compatible = "marvell,dsa";
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		dsa,ethernet = <&eth0port>;
-		dsa,mii-bus = <&mdio>;
-
-		switch@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				label = "lan1";
-			};
-
-			port@1 {
-				reg = <1>;
-				label = "lan2";
-			};
-
-			port@2 {
-				reg = <2>;
-				label = "lan3";
-			};
-
-			port@3 {
-				reg = <3>;
-				label = "lan4";
-			};
-
-			port@5 {
-				reg = <5>;
-				label = "cpu";
-			};
-		};
        };
 };
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
