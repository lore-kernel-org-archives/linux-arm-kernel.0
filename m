Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2E7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:40:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E525120685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DK7B3wIS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sC/UuYdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E525120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zWgvwQIlpsq5P78XWok4SXhHKEj0/ZGj5Al2P1vEOnU=; b=DK7
	B3wISxu4icaIU0Yoc/mQOK6gfKSk6qaZEc4tOzApxFkX70f9KGDpg/M1UmuHqWfHw0VyuYxGEV0dX
	NF2NQa0xVnle21xEebCoXluZwJDdy+VDvraeB0dJibbmYvOH1ev3hdr7RyDXxNG4KJ38Y/np8kQyE
	P4WazFBzQ3Coyh94ZVGICPYs8dOzXQoO4poIAT/I5fa+J+wxNsKgCiEi6R7WVu6w5ziDT81Le1VnC
	GE4fZ378cs35R+VsFnPC31tfqtrP9WSbUPefQzAW9i344JYYJTct9ykL/3wGoS8pm8ejAzk+Y9S72
	UYuytdzUHWNZQSUKmVc8J8wk9dKhSzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghcRg-0004DJ-BT; Thu, 10 Jan 2019 15:40:36 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghcRa-0004Bn-Ez
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 15:40:33 +0000
Received: by mail-wr1-x442.google.com with SMTP id r10so11879262wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 07:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=V9rCXdwFQ912EEViaZFliq7MrgmbybjfHv7F+8qyBT8=;
 b=sC/UuYdZFJJDxNYpYHZqKnaJ1OhTmrlu5RUodLU9wXttl96CuBI3zHhPqPs+81sTn+
 5TxD139hdOGc/ZTmvTweF6yUhBHX2rsWDGRmPVsehxkt5O9IqWfB5HKSmmv0ppKb+/1R
 qW/yU/dEuxEKspPf4PXd/3x99ZFp4c9y/SNvffTKmBfPZGFvMW4Xqwqu/FOrDrUSVpTy
 4698sP8nU5iaZ27OkO216ltszQqVA19NlexLLAnoWbv29krZv3nCwGgxhsnD42mnnIzX
 Flq+aPtI1k9ai81QqhRlensAaNM62kbEVyxzaf9CuCX+Lf1ImBeoT+S0QlDvC0l1T0mj
 9gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=V9rCXdwFQ912EEViaZFliq7MrgmbybjfHv7F+8qyBT8=;
 b=N1BvuSryRZN27zlp1JqH0KLUFSfyq2RjPEImyz10zP5VAhK7us0zOWeEDS4XFzo2+w
 F76TJifmcnTkeaLEeSD0HwADoUe2wqcMTIklSqLBbGRkT2LqEmbY/lwCLxNhj8dednqK
 nl1fxpIiLyUwXA2s193npx/IA+ADnHVV6h2w8EAscV/hI/NBUIft2nCp4BJBx4g500tk
 0BmHcW+2OIMCmIWwuGYGD1n2FBUCMiF2M+MultxQoQydgD26xAWxFkc2SRCqgsvfZ3Nx
 Iq8OOBc2Alu/AJoi9tzV1Ca6OuBySwtaEvkaKtAGtjzOqxAALdPuLlojeFb2PCte+ATX
 x+bQ==
X-Gm-Message-State: AJcUukciWNFnX6IicVlu2Gp3bcBA+3z54wGUhVPw6Yi9HVmXZrj1j6l8
 OOJMgrIYEm1rymo7yu/GqgQr4GZnQTp8s0QlWCk=
X-Google-Smtp-Source: ALg8bN5gwy6guv6OLbftNleV1OlHsgTK9ZVUvYMAIsf6u3WqifYpeSYuir6Ufn0+IbXX5ctDS4UJxQ==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr10183906wrw.304.1547134828319; 
 Thu, 10 Jan 2019 07:40:28 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 ([2620:10d:c092:180::1:f5ef]) by smtp.googlemail.com with ESMTPSA id
 h131sm22694198wmd.17.2019.01.10.07.40.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 07:40:27 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 linux-amlogic@lists.infradead.org
Subject: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
Date: Thu, 10 Jan 2019 16:40:22 +0100
Message-Id: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_074030_526209_5F2E1977 
X-CRM114-Status: GOOD (  11.67  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Loys Ollivier <lollivier@baylibre.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
changed the behavior of "cd-inverted" to follow the device tree bindings
specification.
Lines specifying "cd-inverted" are now "active high".

Fix the SD card for meson by setting the cd-gpios as "active low" according
to the boards specifications.

Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v3: fix typos in the commit message

v2: fix more occurences, also in other meson boards.

 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi              | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts          | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             | 3 +--
 14 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index e14e0ce7e89f..016641a41694 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -187,8 +187,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 8cd50b75171d..ade2ee09ae96 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -305,8 +305,7 @@
 	max-frequency = <200000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddio_ao3v3>;
 	vqmmc-supply = <&vddio_tf>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 4cf7f6e80c6a..25105ac96d55 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -238,8 +238,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 2e1cd5e3a246..1cc9dc68ef00 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -258,8 +258,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&tflash_vdd>;
 	vqmmc-supply = <&tf_io>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index ce862266b9aa..0be0f2a5d2fe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -196,8 +196,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 93a4acf2c46c..ad4d50bd9d77 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -154,8 +154,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vcc_3v3>;
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index ec09bb5792b7..2d2db783c44c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -211,8 +211,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vcc_3v3>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
index f1c410e2da2b..796baea7a0bf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
@@ -131,8 +131,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index db293440e4ca..255cede7b447 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -238,8 +238,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&vcc_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 6739697be1de..9cbdb85fb591 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -183,8 +183,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index a1b31013ab6e..bc811a2faf42 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -137,8 +137,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 3c3a667a8df8..3f086ed7de05 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -356,8 +356,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index f7a1cffab4a8..8acfd40090d2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -147,8 +147,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 7212dc4531e4..7fa20a8ede17 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -170,8 +170,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
