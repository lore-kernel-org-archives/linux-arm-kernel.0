Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2535C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F06220660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k9eijNLa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1p3/EeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F06220660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UqA48kYm1v1jVe6fOdWA6CD0nSvBnabuMKr++IRL10s=; b=k9eijNLaATZLtq
	ZK64g/umZyi97Z2ohQrRfJBiH5mA+QDpLGNwmc7XG40Yy963vgjq5YVAa63ubTa7nCjxTxFp0aL/Y
	cUry7EgD96mRrdYP1zSiX6X8Ih8NQ661juRktbjw2hFht3fYHfGrj5pfUQjMWh43Y/IyKaPFa1WqW
	Utz5Td+jxa0wbJKxOjUl2WAsGZxHy5ziXb8VM9ujhx6cbWPHDXXJGAmcJqBn83hn8sFHzT8POBYE2
	AXvOysIeJfV5SzAHitwTk0rC1jUtbBb/tLYCRy0TthRo9DeT6kn89pEAgvRVbyCwpiq3eOTz6pjVp
	0gKssZWcK/ETGXwYuBaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbfr-0000Wl-HQ; Thu, 10 Jan 2019 14:51:11 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbfg-0000IM-85
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:51:05 +0000
Received: by mail-lj1-x242.google.com with SMTP id n18-v6so9959678lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CcNwEXfi6ZlUWBcW2Bye6DgIumypfVjE/iqyPungPEM=;
 b=e1p3/EeOMacVEz/eSnrPj5h5JE79nhsL407Ef84/I6mEd+wTf1mkTcMBa3yTouepSx
 RaEugdd9HkihedamHuEYSU8z/D8TV1CSNMAsPFmT5+uIES7uInOZ0nwxzU0W50sf0EX1
 VdiNbSMeH3ENC3jCJD1Ym5mybuIi+qizwMyAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CcNwEXfi6ZlUWBcW2Bye6DgIumypfVjE/iqyPungPEM=;
 b=aONYc6KyRbjJNIaAgmx/ur2iZx3VEvfM4MqqdJEDhDSn63LQiFKcY7ozGc0TluHHsq
 +AIYMAC2kIecjldPibH57EukMv4Cay5WhPR7y7W4apt7BFH/2EfWTPf+K5r6HQNC0zrs
 Ap/4QH1AyUjDRFNQzBs676N7wqKW+doMeichUqykrSZ7Q/VKD6Akf0bUFxZnIYnlIi9V
 HzZCHKONbCzJhvZKzuV/AQf7GhgP4eleNdIvFmES2RPLDEDqmGppIVm9NaunSyw95deu
 jsrmSvLRl0lazhz6toD97FCrF/7C60LBNzxU/Kr9BE7pceVmCdTwumUGbycCbTNWrQqU
 Fe7A==
X-Gm-Message-State: AJcUukdqHGXvl5CD5UI03M+PrShxQRYB601hnG4Xt5jXAIw6wkmh9aur
 es7rEZ8YAr8/t4nmP73waZXSsA==
X-Google-Smtp-Source: ALg8bN7crAFz1W1gq/oTIJOBLS5Rudt857YLHTdESshHo5upLiakIPuRjKCedUWBA5TlOUkjvwe+6g==
X-Received: by 2002:a2e:9556:: with SMTP id
 t22-v6mr6727732ljh.36.1547131858075; 
 Thu, 10 Jan 2019 06:50:58 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id 12-v6sm15226157ljf.96.2019.01.10.06.50.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 06:50:56 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>
Subject: [PATCH 2/2 RESEND] ARM: dts: msm8660: Fix up GIC IRQ flags
Date: Thu, 10 Jan 2019 15:50:54 +0100
Message-Id: <20190110145054.11952-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_065101_325695_306A0BB2 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

All the GSBI blocks are marking their GIC IRQ lines as
"IRQ_TYPE_NONE" but there is no such thing: all GIC IRQ
lines have a trigger type.

That yields the following warning from the GIC driver:

WARNING: CPU: 0 PID: 1 at ../drivers/irqchip/irq-gic.c:1016
	 gic_irq_domain_translate+0xdc/0xe4
(...)

Mark all of these IRQ_TYPE_LEVEL_HIGH as is common so this
warning goes away.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 9b1cf00d8ca3..e5da87036dbb 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -141,7 +141,7 @@
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16540000 0x1000>,
 				      <0x16500000 0x1000>;
-				interrupts = <GIC_SPI 156 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI6_UART_CLK>, <&gcc GSBI6_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -150,7 +150,7 @@
 			gsbi6_i2c: i2c@16580000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x16580000 0x1000>;
-				interrupts = <GIC_SPI 157 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -176,7 +176,7 @@
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16640000 0x1000>,
 				      <0x16600000 0x1000>;
-				interrupts = <GIC_SPI 158 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI7_UART_CLK>, <&gcc GSBI7_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -185,7 +185,7 @@
 			gsbi7_i2c: i2c@16680000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x16680000 0x1000>;
-				interrupts = <GIC_SPI 159 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI7_QUP_CLK>, <&gcc GSBI7_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -209,7 +209,7 @@
 			gsbi8_i2c: i2c@19880000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x19880000 0x1000>;
-				interrupts = <GIC_SPI 161 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI8_QUP_CLK>, <&gcc GSBI8_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -234,7 +234,7 @@
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x19c40000 0x1000>,
 				      <0x19c00000 0x1000>;
-				interrupts = <0 195 IRQ_TYPE_NONE>;
+				interrupts = <0 195 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI12_UART_CLK>, <&gcc GSBI12_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -243,7 +243,7 @@
 			gsbi12_i2c: i2c@19c80000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x19c80000 0x1000>;
-				interrupts = <0 196 IRQ_TYPE_NONE>;
+				interrupts = <0 196 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI12_QUP_CLK>, <&gcc GSBI12_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
