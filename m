Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5D9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:46:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01A8206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B4oHWPX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01A8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NZGIgnTDfGReoiKhiJmsR1rAydtrU7CPAUPG/dq/RD4=; b=B4oHWPX+1I9qpR
	tF+hdgKaNscPN6amBgfihDunuiOKpdfVccXQfp5XqQQb3r+AOPMYCe1GmwZFTUhyRitoVVMnGFBYU
	37hLyrn2S3BeRv+EhKgpHYnu1nyyfAmCIDpIzSYI8s9khTkz9pm5hbw3j2DGy84kCbGXmeaA572Qw
	Ci5/vPbZs+HPWQmr0kvmKJXfKHz8nu0Lz4tUUIQK+JfpOurFnl841awX6HkmpmzhB90MvBWNOHtHe
	Qyit7DloHFwKRRrGKQO1iYD8FVp3QLyBV7OcuOiqcR+SbnsTCuTk8DxODTig5+gklm9vogzgllH6R
	5wZynBXO5350Q3jiJ9wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCu5-00045a-V4; Tue, 04 Dec 2018 15:46:29 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCu1-000445-K2
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:46:27 +0000
Received: from sapphire.lan (unknown [10.0.4.3])
 by mx.tkos.co.il (Postfix) with ESMTP id E8116440862;
 Tue,  4 Dec 2018 17:46:08 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 orenbh <orenbh@marvell.com>
Subject: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state support
 on Armada 7K/8K"
Date: Tue,  4 Dec 2018 17:46:02 +0200
Message-Id: <3ece60154be74bd6534387db8da578194f823b43.1543938362.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_074625_893408_564BF81E 
X-CRM114-Status: UNSURE (   6.79  )
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
Cc: Baruch Siach <baruch@tkos.co.il>, Sergey Matyukevich <geomatsi@gmail.com>,
 linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This reverts commit 8ed46368776b3bc93d74c1f8f2bfb9fd8a9ad805.

This commit breaks boot on Armada 8K based systems. Reverting it makes
affected systems boot again.

Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |  4 ---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 27 -------------------
 2 files changed, 31 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
index 64632c873888..01ea662afba8 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
@@ -20,28 +20,24 @@
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 		cpu2: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x100>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 		cpu3: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x101>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 073610ac0a53..7d94c1fa592a 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -28,33 +28,6 @@
 		method = "smc";
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		idle_states {
-			entry_method = "arm,pcsi";
-
-			CPU_SLEEP_0: cpu-sleep-0 {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x0010000>;
-				entry-latency-us = <80>;
-				exit-latency-us  = <160>;
-				min-residency-us = <320>;
-			};
-
-			CLUSTER_SLEEP_0: cluster-sleep-0 {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x1010000>;
-				entry-latency-us = <500>;
-				exit-latency-us = <1000>;
-				min-residency-us = <2500>;
-			};
-		};
-	};
-
 	ap806 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
