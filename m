Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BC4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:27:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C464B20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kenV4aiZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2skOmWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C464B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=N0XFMomDPta1Rs+Dt2cAbXh2CCi+NY5s4wteCQqm3k8=; b=kenV4aiZrFmM1mkHY3udVIOEP4
	GhGlpF/87/W+BVl0n4PxoQIei81dPFuWBw/AxWs+osncdKYXHdOOYhjZp5/gt3XBGVGWKeWxX4bp5
	tfpn6meDWHszNfpyQWPf78/WpTrq95UPiL1rZpJ+BJ9KuTetB2u3jQv97vYIQIvJC+jq9FzGZwNmt
	r6dMsHDVYOFGifw2jj9ZByhOExAY/UIA/BDQ9hoheDYBPs+QyIWZbp9mFcIrvim5pehrNqPsvJXNO
	PoZJd9QN3p5xH7w0dhs8CVFQRGdnqiw2q361WilDPonfprP0a3O/bH+V7OMMumN8fQN07sbIQ+xTl
	L/YWQNFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYL7-0006X5-GM; Sun, 02 Dec 2018 20:27:41 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYID-0002Dw-Ti
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:51 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so10054864wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9WG2eU/ejG4wAWToKoueA27/6ygzN1rLZLWAo8LIhNE=;
 b=T2skOmWUlvAkqf6eBm9og5ZfS9jT1KI23fo/nbKhhS856UmFfaUb8HwHgXouxyXthM
 sqoQ7sQP2T4sVDfkt+m/FOjxKdEwXC4uMOTqofGMZYfg3pHItllfWhd26mB9eeFbg1FC
 nN8elPRFBkCLS6+x3mMhqyVYB4IsnEhDMk/0nXmBVrB1rp60vpT4pxOmsdScTjjoTt0g
 y78LIjXNmm/ATEgZSit7wigak9HNNVPqEVJRruahzGnjCn0FOLQ6vzdxjgLU1ywH5ecz
 BitLT4LVFASPkDx3Wt9iVEtDFmlGMWFDqasRXxj9y8vnUwe9x/Y/fMBNhUSVPS8aSJwF
 OL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9WG2eU/ejG4wAWToKoueA27/6ygzN1rLZLWAo8LIhNE=;
 b=G3hU8vOjJ8sw44mJYUAL4E4PtsELhP9Yk+jpEeNMwi9AnxxmhpzKJDcAWZW8zyjgS8
 x62MZRD6ZomQwFzzsmF8A50JoSEB7ZO4ndkY9Pl3qx6Jy6itXCKpRwHNvfCCcS/PNQhC
 L30TYJl7SoVE31JcIrp+WjemOwzabHepzg/MbEKqnr93KC5+5y72J8P9Ay2wxF3/XKvn
 dM9v9/41YrPUX8QYNek6MZRdQFZWuCEFzCek2xBFpbMAb73zBX60hAfu4l8Qd+FJvtJz
 NngftVq7W3PnOWiFuWtZYTuhi9OVUtzaRdgqz1V5D6IWymqsP9+Xxdp3EgB08jDOcRxV
 QkhA==
X-Gm-Message-State: AA+aEWZDv5LnxVWxMx/I8O5T5EsHjvnIpW0WLMLqTiECts0SaLevKa66
 q+M/efd+9TJzwgk1yOS1l5U=
X-Google-Smtp-Source: AFSGD/XRntLJPSM0w/Zsn7h1n0X9PgvCcz+6P5fwxaPwEuoO7d0rpyeQLePdNF9RAuMCz6TteCsl2Q==
X-Received: by 2002:adf:82e4:: with SMTP id 91mr12176031wrc.131.1543782278799; 
 Sun, 02 Dec 2018 12:24:38 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:38 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 16/17] ARM: dts: suniv: add initial DTSI file for F1C100s
Date: Sun,  2 Dec 2018 23:23:50 +0300
Message-Id: <dafe3e548064535cfc32934c079b53a5c45fcd48.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122442_901926_04BE2C2C 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

F1C100s is one product with the suniv die, which has a 32MiB co-packaged
DDR1 DRAM chip. As we have the support for suniv pin controller and CCU now, add a
initial DTSI for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
new file mode 100644
index 0000000..aff5f90
--- /dev/null
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
+ * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
+ */
+
+#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
+#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	clocks {
+		osc24M: clk-24M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			clock-output-names = "osc24M";
+		};
+
+		osc32k: clk-32k {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
+		};
+	};
+
+	cpus {
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		sram-controller@1c00000 {
+			compatible = "allwinner,suniv-f1c100s-system-control",
+				     "allwinner,sun4i-a10-system-control";
+			reg = <0x01c00000 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_d: sram@10000 {
+				compatible = "mmio-sram";
+				reg = <0x00010000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00010000 0x1000>;
+
+				otg_sram: sram-section@0 {
+					compatible = "allwinner,suniv-f1c100s-sram-d",
+						     "allwinner,sun4i-a10-sram-d";
+					reg = <0x0000 0x1000>;
+					status = "disabled";
+				};
+			};
+		};
+
+		ccu: clock@1c20000 {
+			compatible = "allwinner,suniv-f1c100s-ccu";
+			reg = <0x01c20000 0x400>;
+			clocks = <&osc24M>, <&osc32k>;
+			clock-names = "hosc", "losc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		intc: interrupt-controller@1c20400 {
+			compatible = "allwinner,suniv-f1c100s-ic";
+			reg = <0x01c20400 0x400>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		pio: pinctrl@1c20800 {
+			compatible = "allwinner,suniv-f1c100s-pinctrl";
+			reg = <0x01c20800 0x400>;
+			interrupts = <38>, <39>, <40>;
+			clocks = <&ccu 37>, <&osc24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#gpio-cells = <3>;
+
+			uart0_pe_pins: uart0-pe-pins {
+				pins = "PE0", "PE1";
+				function = "uart0";
+			};
+		};
+
+		timer@1c20c00 {
+			compatible = "allwinner,suniv-f1c100s-timer";
+			reg = <0x01c20c00 0x90>;
+			interrupts = <13>;
+			clocks = <&osc24M>;
+		};
+
+		wdt: watchdog@1c20ca0 {
+			compatible = "allwinner,suniv-f1c100s-wdt",
+				     "allwinner,sun4i-a10-wdt";
+			reg = <0x01c20ca0 0x20>;
+		};
+
+		uart0: serial@1c25000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25000 0x400>;
+			interrupts = <1>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu 38>;
+			resets = <&ccu 24>;
+			status = "disabled";
+		};
+
+		uart1: serial@1c25400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25400 0x400>;
+			interrupts = <2>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu 39>;
+			resets = <&ccu 25>;
+			status = "disabled";
+		};
+
+		uart2: serial@1c25800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25800 0x400>;
+			interrupts = <3>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu 40>;
+			resets = <&ccu 26>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
