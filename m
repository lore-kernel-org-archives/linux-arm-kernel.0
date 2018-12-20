Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B456C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:50:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28096218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j7XG0fmy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0lnMcgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28096218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rw+K3KQXswLmjyoStX7eOAabc+g6Fcfa/qPe5MD0lZ4=; b=j7XG0fmyKQsodpqwjrc8zl1xq0
	oChFrMgIeNBP13gMNPmFxq81OxYhLTpW6xnOSitZFV34y42CZCsqGyPrXHKUCOwuHQBXo1xnAf6S1
	zXFFU/kIDFWJo0jQgB57GvN6ZdStYvtzjs6TN9fcJ1BZdjUSYXT/I6TF+r/vROblkJ3f4WOPZmGCh
	jDBFfEoYogg6ubF3CN+Ttute2YJTE9jCen5sCdLNo5Q9PoaG2cH5tT/y2qyz6zYKu/QN3B6JN7ql6
	v38rNS8PkZ/iMIFYSsyRdlzJ3Dgcp5apLKzHfhF9GSkExt3wSePcZ/iGf4fgguyQNIhB7Ka9BH45m
	NZJiUTxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5H3-0007nk-4U; Thu, 20 Dec 2018 20:50:29 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5Gq-0006vf-LR
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 20:50:22 +0000
Received: by mail-pf1-x443.google.com with SMTP id c123so1485545pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 12:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4odp2+RFytClLaKntEe3wnMAIEZDbKE1PHbW/8Vr5cg=;
 b=n0lnMcghI6qbafubapj+m+abg+X9ws1w1P4Yh7KlAVzmzVCKXWRj4xL+0sA2lkVZly
 FnJyFvBvT8CumgTRbEmvAxmfxsL7ApQl9pVOvbixbYloXuzR5hi2hQLaey6uV1s35Dzd
 pYJG+HYgDSfnTcEsXiZdrfrZBusyN1NOBUEcs3eJegW78xzKmn5S8CxegzvleJ8jP3Qq
 BQk1wydXHzasx9dfkX48+Gse/xV1UDbYvFpEhj7T79p4JCflEtq6u5WnZ5Jlh0pD6KUX
 LpdMUCC2B6O0yHLsLxzxxGWxpho9ABMVI0uBj/OzQHIkkPXgBTFH/SujIxX8CkwMLeUw
 XObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4odp2+RFytClLaKntEe3wnMAIEZDbKE1PHbW/8Vr5cg=;
 b=FLXjDM+ZUDhVlSEPxUXEn9QB8hZCInkYd74fwjMcA8o/0AMmOtSzhuGmsRbYhqpJt6
 bfMp2yG1JvyXtxW0DsZA0/SoxXC0dU8Uz4/UWociroyiDWsjBiiGUeIH41cG0gCEfSX5
 XneGVjCVahcwsf3HHfksSyIj/2PpbEZ1gUxLZVx1R3bmhCCJ2Wwq4q1MlEi2p00yjIKH
 mrdglsjpZJlcXaqByb1s6krILdNuRHMHPi1+XcvfZuKe8tSZ5RQzFHHDKuZ5s/V/BGiM
 QSIOOCXPjhXD1jrd7m2xQegTHQQHQktwcuyk5YSjdnNOPxqLL544iVwwJjnrUM4BQx13
 G4uA==
X-Gm-Message-State: AA+aEWbCwhP4jmlUTyLw8uJDYQjb6SulAkRoa4QNp3LAzO43zhpoW2Vq
 aKF1mIPI2kEm8BRrrH0lGyk=
X-Google-Smtp-Source: AFSGD/WUar6aIx6zEei3CcmQdIynypDXz/KJ0qF87ro5ekNh+q2Ak6+J8/kc9SR2R6a3jtUX4jLeuQ==
X-Received: by 2002:a63:6f0d:: with SMTP id k13mr24032634pgc.42.1545339005755; 
 Thu, 20 Dec 2018 12:50:05 -0800 (PST)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp.
 [118.155.13.174])
 by smtp.gmail.com with ESMTPSA id r4sm50924003pgn.54.2018.12.20.12.50.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 20 Dec 2018 12:50:05 -0800 (PST)
From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT] arm64: dts: renesas: r8a7796: Create thermal zone to
 support IPA
Date: Fri, 21 Dec 2018 05:49:40 +0900
Message-Id: <1545338982-19466-2-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545338982-19466-1-git-send-email-ykaneko0929@gmail.com>
References: <1545338982-19466-1-git-send-email-ykaneko0929@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_125017_465036_2F16389C 
X-CRM114-Status: GOOD (  16.11  )
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

[dien.pham.ry: arm64: dts: r8a7796: Add support IPA for CA53 core]

Setup a thermal zone driven by SoC temperature sensor.
Create passive trip points and bind them to CPUFreq cooling
device that supports power extension.

In R-Car Gen3, IPA is supportted for only one channel
 (on H3/M3/M3N board, it is channel THS3). Reason:
  Currently, IPA controls base on only CPU temperature.
  And only one thermal channel is assembled closest
  CPU cores is selected as target of IPA.
  If other channels are used, IPA controlling is not properly.

Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
Signed-off-by: An Huynh <an.huynh.uj@rvc.renesas.com>
[takeshi.kihara.df: fix W=1 dtc unit_address_vs_reg warnings]
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 56 +++++++++++++++-----------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index afedbf5..98f621c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -160,6 +160,9 @@
 			power-domains = <&sysc R8A7796_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <854>;
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
 			clocks = <&cpg CPG_CORE R8A7796_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
 			capacity-dmips-mhz = <1024>;
@@ -186,6 +189,10 @@
 			power-domains = <&sysc R8A7796_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <277>;
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
 			clocks = <&cpg CPG_CORE R8A7796_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 			capacity-dmips-mhz = <535>;
@@ -2822,76 +2829,67 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 0>;
+			sustainable-power = <3874>;
 
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
-					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
-				};
-			};
 		};
 
 		sensor_thermal2: sensor-thermal2 {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 1>;
+			sustainable-power = <3874>;
 
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
-					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
-				};
-			};
 		};
 
 		sensor_thermal3: sensor-thermal3 {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 2>;
+			sustainable-power = <3874>;
 
 			trips {
-				sensor3_passive: sensor3-passive {
-					temperature = <95000>;
+				threshold: trip-point0 {
+					temperature = <90000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
+
+				target: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
 				sensor3_crit: sensor3-crit {
 					temperature = <120000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
-
 			cooling-maps {
 				map0 {
-					trip = <&sensor3_passive>;
-					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
+					trip = <&target>;
+					cooling-device = <&a57_0 0 2>;
+					contribution = <1024>;
+				};
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
