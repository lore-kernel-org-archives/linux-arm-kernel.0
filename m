Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065E5208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t9es0hhn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="onY3EccK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065E5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RExD9wtIsTjiGSqTGMGpWwZmH/93IQEbeVUROPoCcHM=; b=t9e
	s0hhn6Y1z3teXO6CG0JxQ61YMkQ49EW1neH8LXlw2jpF4iiExhCK2NfOQ/MaTZTlRvyqURBw5ipEl
	sJUEoPqgC7WX/TcEvIMvOaNn2X1WB99qvrdi7xWdQpyGwjvwaBpTAEFOJZ8ZoS1l3RC9J3EAbrNTI
	+t+URf1+0sK6ennb/hLMxJQZ8sEh2I1VWmo/klKILwr/REYpSNddu+fY7sSr9rrlGRlW/jPOstAn6
	/Y0RAxJDDHVbyyWaBsHDGUiNS14dEusX5qtix+eOMZ3DjyUL2mu0OUsOiFjJuZGd2oEXec+ZEptaA
	pV94AlGKjfhpVqmoah5NlaF9+guBpAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvouQ-0001TY-Up; Mon, 18 Feb 2019 19:48:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvouK-0001R7-Q7
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:48:56 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C4091217D9;
 Mon, 18 Feb 2019 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550519332;
 bh=+OmSMSGwo3GxzHENcDMY1mw3dpV1vusvdXOAz2UjDMg=;
 h=From:To:Cc:Subject:Date:From;
 b=onY3EccKQ3K+JONHcVvPzMMCldpxR6jrFgabQluLx2Vl+p6AfP6N47okbHi83e/AA
 GFuXK1Qj0FwASH/+KE9NrgBXiM5bWZDg8FHunqIyknE5OQtkU1Os1cDocXh+RvbrKE
 QO8J6ajm5pn0f4NjwnmGx/dvfYrpx76ZGWlJUnUg=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: exynos: Add CPU cooling on Arndale Octa
Date: Mon, 18 Feb 2019 20:48:40 +0100
Message-Id: <20190218194841.21374-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_114853_016134_D5C503FC 
X-CRM114-Status: GOOD (  13.30  )
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
Cc: Markus Reichl <reichl@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arndale Octa board comes without fan so proper CPU cooling is necessary
to avoid critical shutdowns when CPUs are busy.  Although thermal zones
were present but CPU cooling was missing in DTS.

Adjust the trip points and add respective cooling nodes for each CPU
thermal zone.  The CPU throttling will start at 60 degrees of C,
intensify at 80 degrees of C and slow down CPUs as much as possible at
110 degrees of C.

With this configuration, when running four CPU intensive tasks, the
temperatures did not exceed 90 degrees of Celsius mostly oscillating
around 88 degrees in hottest thermal zone.  Test was however done with
only four CPUs online (big cluster, Cortex A15) because of errors when
booting secondary CPUs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 264 ++++++++++++++++++
 1 file changed, 264 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index c7d9604a119e..2b227246c685 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -59,6 +59,270 @@
 	cpu-supply = <&buck6_reg>;
 };
 
+&cpu0_thermal {
+	trips {
+		cpu0_alert0: cpu-alert-0 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu0_alert1: cpu-alert-1 {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu0_alert2: cpu-alert-2 {
+			temperature = <110000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu0_crit0: cpu-crit-0 {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <0>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		/*
+		 * Reduce the CPU speed by 2 steps, down to: 1600 MHz
+		 * and 1100 MHz.
+		 */
+		map0 {
+			trip = <&cpu0_alert0>;
+			cooling-device = <&cpu0 0 2>,
+					 <&cpu1 0 2>,
+					 <&cpu2 0 2>,
+					 <&cpu3 0 2>,
+					 <&cpu4 0 2>,
+					 <&cpu5 0 2>,
+					 <&cpu6 0 2>,
+					 <&cpu7 0 2>;
+		};
+
+		/*
+		 * Reduce the CPU speed down to 1200 MHz big (6 steps)
+		 * and 800 MHz LITTLE (5 steps).
+		 */
+		map1 {
+			trip = <&cpu0_alert1>;
+			cooling-device = <&cpu0 3 6>,
+					 <&cpu1 3 6>,
+					 <&cpu2 3 6>,
+					 <&cpu3 3 6>,
+					 <&cpu4 3 5>,
+					 <&cpu5 3 5>,
+					 <&cpu6 3 5>,
+					 <&cpu7 3 5>;
+		};
+
+		/*
+		 * Reduce the CPU speed as much as possible, down to 700 MHz
+		 * big (11 steps) and 600 MHz LITTLE (7 steps).
+		 */
+		map2 {
+			trip = <&cpu0_alert2>;
+			cooling-device = <&cpu0 6 11>,
+					 <&cpu1 6 11>,
+					 <&cpu2 6 11>,
+					 <&cpu3 6 11>,
+					 <&cpu4 5 7>,
+					 <&cpu5 5 7>,
+					 <&cpu6 5 7>,
+					 <&cpu7 5 7>;
+		};
+	};
+};
+
+&cpu1_thermal {
+	trips {
+		cpu1_alert0: cpu-alert-0 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu1_alert1: cpu-alert-1 {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu1_alert2: cpu-alert-2 {
+			temperature = <110000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu1_crit0: cpu-crit-0 {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <0>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu1_alert0>;
+			cooling-device = <&cpu0 0 2>,
+					 <&cpu1 0 2>,
+					 <&cpu2 0 2>,
+					 <&cpu3 0 2>,
+					 <&cpu4 0 2>,
+					 <&cpu5 0 2>,
+					 <&cpu6 0 2>,
+					 <&cpu7 0 2>;
+		};
+
+		map1 {
+			trip = <&cpu1_alert1>;
+			cooling-device = <&cpu0 3 6>,
+					 <&cpu1 3 6>,
+					 <&cpu2 3 6>,
+					 <&cpu3 3 6>,
+					 <&cpu4 3 5>,
+					 <&cpu5 3 5>,
+					 <&cpu6 3 5>,
+					 <&cpu7 3 5>;
+		};
+
+		map2 {
+			trip = <&cpu1_alert2>;
+			cooling-device = <&cpu0 6 11>,
+					 <&cpu1 6 11>,
+					 <&cpu2 6 11>,
+					 <&cpu3 6 11>,
+					 <&cpu4 5 7>,
+					 <&cpu5 5 7>,
+					 <&cpu6 5 7>,
+					 <&cpu7 5 7>;
+		};
+	};
+};
+
+&cpu2_thermal {
+	trips {
+		cpu2_alert0: cpu-alert-0 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu2_alert1: cpu-alert-1 {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu2_alert2: cpu-alert-2 {
+			temperature = <110000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu2_crit0: cpu-crit-0 {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <0>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu2_alert0>;
+			cooling-device = <&cpu0 0 2>,
+					 <&cpu1 0 2>,
+					 <&cpu2 0 2>,
+					 <&cpu3 0 2>,
+					 <&cpu4 0 2>,
+					 <&cpu5 0 2>,
+					 <&cpu6 0 2>,
+					 <&cpu7 0 2>;
+		};
+
+		map1 {
+			trip = <&cpu2_alert1>;
+			cooling-device = <&cpu0 3 6>,
+					 <&cpu1 3 6>,
+					 <&cpu2 3 6>,
+					 <&cpu3 3 6>,
+					 <&cpu4 3 5>,
+					 <&cpu5 3 5>,
+					 <&cpu6 3 5>,
+					 <&cpu7 3 5>;
+		};
+
+		map2 {
+			trip = <&cpu2_alert2>;
+			cooling-device = <&cpu0 6 11>,
+					 <&cpu1 6 11>,
+					 <&cpu2 6 11>,
+					 <&cpu3 6 11>,
+					 <&cpu4 6 7>,
+					 <&cpu5 6 7>,
+					 <&cpu6 6 7>,
+					 <&cpu7 6 7>;
+		};
+	};
+};
+
+&cpu3_thermal {
+	trips {
+		cpu3_alert0: cpu-alert-0 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu3_alert1: cpu-alert-1 {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu3_alert2: cpu-alert-2 {
+			temperature = <110000>; /* millicelsius */
+			hysteresis = <10000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu3_crit0: cpu-crit-0 {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <0>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu3_alert0>;
+			cooling-device = <&cpu0 0 2>,
+					 <&cpu1 0 2>,
+					 <&cpu2 0 2>,
+					 <&cpu3 0 2>,
+					 <&cpu4 0 2>,
+					 <&cpu5 0 2>,
+					 <&cpu6 0 2>,
+					 <&cpu7 0 2>;
+		};
+
+		map1 {
+			trip = <&cpu3_alert1>;
+			cooling-device = <&cpu0 3 6>,
+					 <&cpu1 3 6>,
+					 <&cpu2 3 6>,
+					 <&cpu3 3 6>,
+					 <&cpu4 3 5>,
+					 <&cpu5 3 5>,
+					 <&cpu6 3 5>,
+					 <&cpu7 3 5>;
+		};
+
+		map2 {
+			trip = <&cpu3_alert2>;
+			cooling-device = <&cpu0 6 11>,
+					 <&cpu1 6 11>,
+					 <&cpu2 6 11>,
+					 <&cpu3 6 11>,
+					 <&cpu4 5 7>,
+					 <&cpu5 5 7>,
+					 <&cpu6 5 7>,
+					 <&cpu7 5 7>;
+		};
+	};
+};
+
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
