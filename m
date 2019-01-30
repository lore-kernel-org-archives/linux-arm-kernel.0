Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA4FC282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:44:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8AF21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HhtpSBNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8AF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fptor2SeeBAn4mS+tjH/btLVEHiD/vMB0JUsQLDT5ro=; b=HhtpSBNkE06xYU
	fE2RM68TLvLA0bx8HatKyu5BJSwO9PU9l8yAgw74h2mIOhrrXTMKtDYk21chmqz49GQVyEe05ripG
	l5igTQwMbybU0HQw61jHuTTHeD+v4did5KsiQM5VUxW4+cKjWCuI8vJwFoUPCxbZvzd/9mW4BBNOG
	PoEuBjtxgxndwAXoG1oJrFwpmzW/AwNPSFqs8dAaYO1bXU20LKqjBIMMMk3tswzp9DbICD/ndmR/1
	gIhpuJegXmX41N0Wp4GKhh/x0zXx0GctcNAMY9cgm0LumoKKUhwC0MAoTErUS6iotlkKz1ybLapSn
	RFNhe8mXn8H+VGwb1mkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golTz-0003y5-Eg; Wed, 30 Jan 2019 08:44:31 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golS0-0002EB-MG
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:42:31 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id DBF0D5FD57; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 06/10] arm64: dts: allwinner: h5: orange-pi-zero-plus2: Add
 CPU regulator supply
Date: Wed, 30 Jan 2019 16:41:59 +0800
Message-Id: <20190130084203.25053-7-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130084203.25053-1-wens@csie.org>
References: <20190130084203.25053-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_004229_753668_54816BAE 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: devicetree@vger.kernel.org, Sergey Matyukevich <geomatsi@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>,
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The OrangePi Zero Plus 2 uses a fixed regulator to supply the CPU cores.
The feedback resistor network can be changed by toggling a GPIO line.
This is effectively a GPIO controlled regulator that can change between
roughly 1.1V and 1.3V. The actual voltage is slightly higher. The values
used in the device tree description are based on calculations using the
resistor values from the schematics.

Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Sergey Matyukevich <geomatsi@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---

This patch is based on the schematics and has not been tested on an
actual board.
---
 .../sun50i-h5-orangepi-zero-plus2.dts         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index 53c8c11620e0..801c681307ef 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -76,6 +76,22 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	reg_vdd_cpux: vdd-cpux {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-cpux";
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1108475>;
+		regulator-max-microvolt = <1307810>;
+		regulator-ramp-delay = <50>; /* 4ms */
+		enable-gpios =  <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL6 */
+		gpios-states = <0x1>;
+		states = <1108475 0x0
+			  1307810 0x1>;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -84,6 +100,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
 &de {
 	status = "okay";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
