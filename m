Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2EBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:31:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542202145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FxXDmWCJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2O59T0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542202145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=0wQ8CDntOmUWM9P+W9XEK36Aej1xbi2pqjAz0fu0xwY=; b=FxX
	DmWCJkGqxSncwOSIMWXohWtEkSaWGf3Jgp3B7nFkGlu8+tEKKHBsJ8T/QywrwqrssKCNrRY7D2Hja
	ZG9AEBAc7wgoHRhhUK+dV3L0w6QxSbdjDPVh5DoyMU0qpEBY/hC6phFy86bW0WuezGKF75p3AXIik
	nAd5EgXntglQI5Ao+sdMfqunr9oyu46VmaZO9vitoiD2us8xgzE4doXceQGTBwDmQlZRqnrqKePJE
	fdKK+oop2B9Jw0n2Agl4pfguobguUgFXLsm9JxqvZQ8OYVQ6aNcJeC5C0u2fSItokfBBmX6eH84QE
	vOt/B+s4WHrUYgwv87xzPYeMk75ymXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSg5T-0005bN-Cf; Fri, 30 Nov 2018 10:31:55 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSg5P-0005au-LL
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:31:53 +0000
Received: by mail-qk1-x742.google.com with SMTP id o125so2857041qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 02:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=mTdFp9QJqrp4Fefb/xtFK9WojMjRWUfnbHBujLH3TIE=;
 b=u2O59T0CXVB1jBKpDslOIj4mPrOTzHXej8IQDkRXxZPKZTtdyGHWKlm1ASbZCweTnk
 xN3gxmvJFJAnFE+JD13OzqtC0vO3pp3L5XqqIVf7XIQmy8bh3lXdBIafK93nrWsC5MLh
 9K1Tpi5XIYjQWhi2mmEMPxYdLJ0RrRTpwIwYj+LkPVieL832MVI2Z+ocPuln8Pz2rlRB
 6qRPQcRyqXZ+vKPiThffTj9wr9Fs8TI2WAliKVrT3QJDyfOf1EYVmaDiz3iW39VlvxNG
 nbdrH1vg4uQVz1JBiU8v/Cjbk8833r9YacdqFheJRrZutxDWUr6FdVi9gjqfsDqTOOrn
 ZQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=mTdFp9QJqrp4Fefb/xtFK9WojMjRWUfnbHBujLH3TIE=;
 b=jczwSe9BKQT1tDNlAMWPFHqHdZbA3I0M4DOL1M+SNkOGwmmo4U5MrMCcs0TGABDLMq
 ZuqJUIwX0FfrIMf/swH3fYXgQ/GfZy4NZe1LrB42E1m0ipUC7OaA/cbya2gzUQGf5coD
 TCXxJvagYNLYsz38W9D5vyT9K6sYeDwvImZqlSp2IVH5h7oNlybmhQNBCeYjzD5Q6tSM
 FjxR3VZmdSWNbiVDuneNh5vvkMYmnhAD/uwCaulsl0MrcrddzukYhTOoUqvGeOftn2hb
 GRx9wGjLwr6jTAUnCJmishOi6RhWZsRu/J0rnx+Chwks6DQqrPAwmQ2yKIrAJQScxBm0
 ZuRg==
X-Gm-Message-State: AA+aEWZYVYd9bs/TvtXiCVVtaHaFyQUYGsQDlSIIWjXxQXgdO7dDTTLQ
 AmgKHRb3QZuafatZOYNgLyc=
X-Google-Smtp-Source: AFSGD/Vst9CQijo8outo/T4cSIiMSfwGZ/nx8qOfp8EEWwj514pSNSuveAR6u6/Von+HjbwcROSnOQ==
X-Received: by 2002:a37:34f:: with SMTP id 76mr4666568qkd.347.1543573900064;
 Fri, 30 Nov 2018 02:31:40 -0800 (PST)
Received: from localhost.localdomain ([201.82.144.36])
 by smtp.gmail.com with ESMTPSA id c17sm3184217qtb.14.2018.11.30.02.31.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 02:31:39 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH v2] ARM: dts: imx7d-pico: Describe the Wifi clock
Date: Fri, 30 Nov 2018 08:31:29 -0200
Message-Id: <1543573889-8355-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_023151_722711_3BEA9215 
X-CRM114-Status: GOOD (  13.60  )
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
Cc: cameron@paloaltoinnovation.com, arend.vanspriel@broadcom.com,
 otavio@ossystems.com.br, vanessa.maegima@nxp.com,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org,
 john.weber@technexion.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Wifi chip should be clocked by a 32kHz clock coming from i.MX7D 
CLKO2 output pin, so describe the pinmux and clock hierarchy in the 
device tree to allow the Wifi chip to be properly clocked.

Managed to successfully test Wifi with such change. Used the standard
nvram.txt file provided by TechNexion, which selects an external 32kHz
clock for the Wifi chip by default.

Fixes: 99a52450c707 ("ARM: dts: imx7d-pico: Add Wifi support")
Suggested-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Tested-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Added a Fixes tag
- Added Otavio's Reviewed-by tag

 arch/arm/boot/dts/imx7d-pico.dtsi | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 4846df0..934a019 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -101,6 +101,19 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
+
+	usdhc2_pwrseq: usdhc2_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
+		clock-names = "ext_clock";
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
+			  <&clks IMX7D_CLKO2_ROOT_DIV>;
+	assigned-clock-parents = <&clks IMX7D_CKIL>;
+	assigned-clock-rates = <0>, <32768>;
 };
 
 &i2c4 {
@@ -200,12 +213,13 @@
 
 &usdhc2 { /* Wifi SDIO */
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_wifi_clk>;
 	no-1-8-v;
 	non-removable;
 	keep-power-in-suspend;
 	wakeup-source;
 	vmmc-supply = <&reg_ap6212>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
 	status = "okay";
 };
 
@@ -302,6 +316,12 @@
 };
 
 &iomuxc_lpsr {
+	pinctrl_wifi_clk: wificlkgrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO03__CCM_CLKO2	0x7d
+		>;
+	};
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x74
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
