Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050C5C282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C491A21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZbvvVEgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C491A21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=juB2xe5XXWKngHPWtZ54vlohRfDAibkIOl679Grje4I=; b=ZbvvVEgoa8kSGG
	FcNd41eFQjKnbBGNak9SKIF54a+6HuOB1MzYcnNspA5N5Hp9TCahwmYKQyo2Im4FNkg7uSA4bA0Yl
	VanIaDZL/Wywlp5YqmvC7husJ/hMltrx6NxCgch8Wkr7IDJ4nsHAacTU7Q+8m4h+TXT9mFaCoIkql
	fap0FicUXt+9auYcI3GEjIW74WnfaHABw+MNRK2Zs1/JnQz8Tt+wbsXgIh0+CwXOYmhdBntOrNHbB
	OQWdlehB3w0pgH45pERqpqzE1FvN00qGwRUJ4t4a5pSquapUBj289MGA0mWqcI/qLxJk3IOelDxWE
	6Ie1fLlkvcTzerWelzjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golTL-0003Jv-Uk; Wed, 30 Jan 2019 08:43:51 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golS0-0002EA-0z
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:42:29 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id E39E45FD5D; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 07/10] arm64: dts: allwinner: h5: orange-pi-pc2: Add CPU
 regulator supply
Date: Wed, 30 Jan 2019 16:42:00 +0800
Message-Id: <20190130084203.25053-8-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130084203.25053-1-wens@csie.org>
References: <20190130084203.25053-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_004228_274383_D36DA5EA 
X-CRM114-Status: GOOD (  13.39  )
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

The OrangePi PC 2 uses a Silergy SY8106A regulator to supply the CPU
cores. The fixed voltage when I2C programmed regulation is not in action
is slightly higher than 1.1V. The value in the device tree description
is based on calculations of the resistor values from the schematics.

Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Emmanuel Vadot <manu@freebsd.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

---

This patch is based on the schematics and has not been tested on an
actual board.
---
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 3e0d5a9c096d..23cfad7c78f4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -132,6 +132,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
 &de {
 	status = "okay";
 };
@@ -207,6 +211,30 @@
 	status = "okay";
 };
 
+&r_i2c {
+	status = "okay";
+
+	reg_vdd_cpux: regulator@65 {
+		compatible = "silergy,sy8106a";
+		reg = <0x65>;
+		regulator-name = "vdd-cpux";
+		silergy,fixed-microvolt = <1108474>;
+		/*
+		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
+		 * however both the Armbian DVFS table and the official one
+		 * have operating points with voltage under 1.1V, and both
+		 * DVFS table are known to work properly at the lowest
+		 * operating point.
+		 *
+		 * Use 1.0V as the minimum voltage instead.
+		 */
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
 &spi0  {
 	status = "okay";
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
