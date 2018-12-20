Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9583DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:50:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A2021904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QO9r5E41";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p577dpeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A2021904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Qs4+i3s3SCKjDE49ZaJOCQ1NryNTow/lQyJ8P/Sq+mo=; b=QO9
	r5E417AW17RQC+pU0lH3a+ugIW/bPVGcTPqqGc1QSH8TD0zr+B3Ro7fDS+YPd6hQNvRS1o35pzGsw
	ghSmPofWVmQRdWJzf4jWX36tUeIi+WgngIp1i9oXJbmyDK6m4ufT2Q1bxAMhqrlyBwN4H8khrUMDm
	Z2DZRTX8kYgIq+pyXt6ghv2zXnEQh6j1mEgnZOGjmQp6VuDNCi46VwnfJH9AMy4K3t5/MDQ5Y+pjv
	3Za5iBE1CJcj2bwXc6ywKbUjWuM6kJF1lyMUY3/5MtXTXwFOMc72GS2AZZ1dO53uIEeFf1ptlBWBD
	O6vtbp69xGEjsK/iQJ1RtG54K5+jVdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5Gm-0007Yo-KO; Thu, 20 Dec 2018 20:50:12 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5Gj-0006Fj-20
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 20:50:10 +0000
Received: by mail-pf1-x441.google.com with SMTP id c73so1458965pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 12:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=0flPfBxzfyZe3dhoZo6Ms+aMB+NadIGKBxGum72SgVk=;
 b=p577dpeVOwFZPNfz/oEfrJFTVwIHBEIn/XbkpbNoGx99hGag274+rZF3Z98CtNzf66
 xdSCQfhdjkU5EVtOhvNqyBtfP4JvEK9nq+PFF6rsGooRxp/9Idm/IW/mls5Dxb6UFhYL
 qU1F1nw75Y8xGk4jilAF+jNBRt6xmMTJqzoVsksBcMTCxV8KjsNiwHkh3imGO/fdzYEW
 DiDzQa1iTgLpzNlABeAaQ5UsTOWQB3cOPx7sBkKM2aBNNu2wpxFBQdYT/SwVX3v4+ijx
 GHKFlR8kDfPKUhexMKgotOxbyYbLG5EwDpiKSpHHfwKOTPWkGpYN+dhWHumkp3ETTefp
 XEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0flPfBxzfyZe3dhoZo6Ms+aMB+NadIGKBxGum72SgVk=;
 b=aOxJnvR9GyuWzpwEFZolfpnpJD50YlVO4XCoDTgBB3PiAYhEQyDmnohT4U1GLh8lXr
 i/Yek8UiH3bMLj2q1RWzKilM9MRl0GrIZZJyLZPQyDgmC/GsNzKs5riQfNAl1/K96So1
 lLAkPaOpXK0W4uuggyQkzJo4coEcdZ04xDDlVuJE2dm4GWZMcVOHj7Us1oygaSpvnMx0
 HAvAbqIuLDF0xmYFmJkv3vPIoHh+MY/ZP+k/RnF1/CLa0k5YWUBUCTd15fuJF7+aiZ6x
 0wcSSo8A998nFq3ncCPPfx36Z4SDyZgw/3jGObUEcIrCrNXh7SE9deciAQ5nVEmLTOX5
 IimQ==
X-Gm-Message-State: AA+aEWZPhjpiCQjZpN/DyKN+vrqXsNzR6wECjWSLmJvAEwx0McBInARc
 q6dx2q/W4FENoxO75ALhSwH72N+c
X-Google-Smtp-Source: AFSGD/WXCkyhIucrpxkfaW4GrqdRVkZtZK5Hb6uiWM/3S21XsUD9HQ4y5h78EUFjntSCC0KjLq2V2A==
X-Received: by 2002:a62:9683:: with SMTP id s3mr25574029pfk.60.1545338997658; 
 Thu, 20 Dec 2018 12:49:57 -0800 (PST)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp.
 [118.155.13.174])
 by smtp.gmail.com with ESMTPSA id r4sm50924003pgn.54.2018.12.20.12.49.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 20 Dec 2018 12:49:56 -0800 (PST)
From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT] arm64: dts: renesas: r8a7795: Create thermal zone to
 support IPA
Date: Fri, 21 Dec 2018 05:49:39 +0900
Message-Id: <1545338982-19466-1-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_125009_111798_D81F22E2 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Dien Pham <dien.pham.ry@renesas.com>

[dien.pham.ry: arm64: dts: r8a7795: Add support IPA for CA53 core]

Setup a thermal zone driven by SoC temperature sensor.
Create passive trip points and bind them to CPUFreq cooling
device that supports power extension.

In R-Car Gen3, IPA is supportted for only one channel
 (on H3/M3/M3N board, it is channel THS3). Reason:
  Currently, IPA controls base on only CPU temperature.
  And only one thermal channel is assembled closest
  CPU cores is selected as target of IPA.
  If other channels are used, IPA controlling is not properly.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
[gaku.inami.xw: fix the trip temperature for cooling-device]
[gaku.inami.xw: fix the power coefficient]
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
Signed-off-by: An Huynh <an.huynh.uj@rvc.renesas.com>
[takeshi.kihara.df: fix W=1 dtc unit_address_vs_reg warnings]
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 64 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index af9605d..dd52b50 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -155,6 +155,9 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <854>;
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
 			capacity-dmips-mhz = <1024>;
@@ -207,6 +210,10 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <277>;
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 			capacity-dmips-mhz = <535>;
@@ -3098,58 +3105,30 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 0>;
+			sustainable-power = <6313>;
 
 			trips {
-				sensor1_passive: sensor1-passive {
-					temperature = <95000>;
-					hysteresis = <1000>;
-					type = "passive";
-				};
 				sensor1_crit: sensor1-crit {
 					temperature = <120000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&sensor1_passive>;
-					cooling-device = <&a57_0 4 4>,
-							 <&a57_1 4 4>,
-							 <&a57_2 4 4>,
-							 <&a57_3 4 4>;
-				};
-			};
 		};
 
 		sensor_thermal2: sensor-thermal2 {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 1>;
+			sustainable-power = <6313>;
 
 			trips {
-				sensor2_passive: sensor2-passive {
-					temperature = <95000>;
-					hysteresis = <1000>;
-					type = "passive";
-				};
 				sensor2_crit: sensor2-crit {
 					temperature = <120000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&sensor2_passive>;
-					cooling-device = <&a57_0 4 4>,
-							 <&a57_1 4 4>,
-							 <&a57_2 4 4>,
-							 <&a57_3 4 4>;
-				};
-			};
 		};
 
 		sensor_thermal3: sensor-thermal3 {
@@ -3158,11 +3137,18 @@
 			thermal-sensors = <&tsc 2>;
 
 			trips {
-				sensor3_passive: sensor3-passive {
-					temperature = <95000>;
+				threshold: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				target: trip-point1 {
+					temperature = <100000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
+
 				sensor3_crit: sensor3-crit {
 					temperature = <120000>;
 					hysteresis = <1000>;
@@ -3172,11 +3158,15 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&sensor3_passive>;
-					cooling-device = <&a57_0 4 4>,
-							 <&a57_1 4 4>,
-							 <&a57_2 4 4>,
-							 <&a57_3 4 4>;
+					trip = <&target>;
+					cooling-device = <&a57_0 0 2>;
+					contribution = <1024>;
+				};
+
+				map1 {
+					trip = <&target>;
+					cooling-device = <&a53_0 0 2>;
+					contribution = <1024>;
 				};
 			};
 		};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
