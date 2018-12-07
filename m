Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9943C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA1820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JouHczXy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CPEXXHMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA1820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JvIn5fd/fXkIGDhbQVaLo7drGVHHrOD6oYlRKoAItAY=; b=JouHczXyD8QWor
	YjoqdXxTQ0TrdIrZJPokWrPCnr2kgDl/3MlNcaC9g+Ug8NLgXAiR81GjVs9TaUHu72zbTE+JK2DjW
	dIGSmM9GYeuKFZyithSZF0cW3HakAtjXhFzD3Zkj3FV0J72tY/XlZlsa40kozwFC375QMyQtP7u9I
	7pAWGJuZSCG2Dq+yBJxMXo1Syx3fAVbdFGg+y/liJPGbdR+sDi+jd2e/s4KB2t2PpIfUD0QCG8cTJ
	8+lR9X1QDRX3jgoDZoNwq/PrvjshMOR5LH0RCbEY80Dd0qBXjwg2oMFYFrqgFCJamQPQbfjxXxz1+
	Xa4Wq5sj6EohP54BywuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDl6-0007ch-7s; Fri, 07 Dec 2018 10:53:24 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDkX-0006xz-Q1
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:52:51 +0000
Received: by mail-wm1-x341.google.com with SMTP id r24so1053196wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 02:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8/vQo9Rx195PT21mlOBWdYcriHO5lvZbWlk7QCDAmXo=;
 b=CPEXXHMjRhhS39zsmYQRXgQ41ROFhA6OBSITXP3xZaSCAvZqjjRaXEUrF7KPSa2Cqj
 DBrWd1L/JBB/d/9XtURupDhApWy/f6SduIpc0Oo/KjExm6uGXbvSwz/ClJcm0Q3jSIDt
 GVVCiaKtVDaxEoqhxsqKhLRx4s53Yw6lp9tinN+GqJYV62HOcfxEPF+MRUO3MFckOyDp
 W4HoOgY0kGU5Kn+7xCfERETd2pix6ltluhU8ZB/VlhaoWajlAKPMAgfbaoGzDFNNBp4L
 0N7hf9CnYdrprgavVI2fCSWAS7kY4XCKQFhFeScFvHRY2y9kwYj6ewK9dCMlMBRN6fw9
 wqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8/vQo9Rx195PT21mlOBWdYcriHO5lvZbWlk7QCDAmXo=;
 b=YXM9JiKMkjFYwxwQyFZRuiA90ZrI0xO1ZFw+aUGiGZ1z7WkuMNUQZOVjWcYTunq2+h
 qUzY4dfWj6s5mJHUBG3GsCBuIq6/VOxSk4xJ/mqk/h5O0lKhN7YdtXM8ykXXAL/5M74Y
 OEXWgFQa6HV+/Vts5WJtqQLvemeOqaq+6AS04TTMH6Aa2i5HlnDwPMZqfczhgdfpZjoV
 yMHoltNqPI/rkioR5zhTXYSKMoIObI+CUnva+EqnmPkodVvcyjaIG+GJ4cOXQaj7aO0E
 a1VCcyc0cLbrPHAIvo7tUlYZ5R7zaG/SdqqQdyeIa2VzBlmr38D7N+eq9aJkzLOqAYpp
 q8GA==
X-Gm-Message-State: AA+aEWb78ucX6cL6tUOVwnMe9KciWle0fcfQUOd4r8VBvU6/O7Y/ijUf
 Nbce4OIRraepTCRIqz7RcvGuNQ==
X-Google-Smtp-Source: AFSGD/UGklAC1lTwzrN+f06JJI246eXUpGvGQHAgDX0oone1PcSvJx5IUVtIAAh9qnW3ork+ZM7cZQ==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr1891764wmg.53.1544179956883; 
 Fri, 07 Dec 2018 02:52:36 -0800 (PST)
Received: from xps.home ([2a00:23c4:f7a1:ce00:800d:14be:d1d:88c5])
 by smtp.gmail.com with ESMTPSA id v187sm1234684wme.0.2018.12.07.02.52.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 02:52:35 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com,
 ingrassia@epigenesys.com
Subject: [PATCH v2 1/2] arm64: dts: meson: Fix IRQ trigger type for macirq
Date: Fri,  7 Dec 2018 10:52:30 +0000
Message-Id: <20181207105231.25593-2-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207105231.25593-1-ccaione@baylibre.com>
References: <20181207105231.25593-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_025249_843169_28E04C39 
X-CRM114-Status: GOOD (  15.87  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A long running stress test on a custom board shipping an AXG SoCs and a
Realtek RTL8211F PHY revealed that after a few hours the connection
speed would drop drastically, from ~1000Mbps to ~3Mbps. At the same time
the 'macirq' (eth0) IRQ would stop being triggered at all and as
consequence the GMAC IRQs never ACKed.

After a painful investigation the problem seemed to be due to a wrong
defined IRQ type for the GMAC IRQ that should be LEVEL_HIGH instead of
EDGE_RISING.

The change in the macirq IRQ type also solved another long standing
issue affecting this SoC/PHY where EEE was causing the network
connection to die after stressing it with iperf3 (even though much
sooner). It's now possible to remove the 'eee-broken-1000t' quirk as
well.

Fixes: feb3cbea0946 ("ARM64: dts: meson-gxbb-odroidc2: fix GbE tx link breakage")
Fixes: 6d28d577510f ("ARM64: dts: meson-axg: fix ethernet stability issue")
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts      | 1 -
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi   | 1 -
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 18778ada7bd3..4d57363ac536 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -357,7 +357,6 @@
 		eth_phy0: ethernet-phy@0 {
 			/* Realtek RTL8211F (0x001cc916) */
 			reg = <0>;
-			eee-broken-1000t;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index df017dbd2e57..b1a42e99cb67 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -143,7 +143,7 @@
 			compatible = "amlogic,meson-axg-dwmac", "snps,dwmac";
 			reg = <0x0 0xff3f0000 0x0 0x10000
 			       0x0 0xff634540 0x0 0x8>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			clocks = <&clkc CLKID_ETH>,
 				 <&clkc CLKID_FCLK_DIV2>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index f1e5cdbade5e..58e6bcaac1d8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -462,7 +462,7 @@
 			compatible = "amlogic,meson-gx-dwmac", "amlogic,meson-gxbb-dwmac", "snps,dwmac";
 			reg = <0x0 0xc9410000 0x0 0x10000
 			       0x0 0xc8834540 0x0 0x4>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 54954b314a45..f8d1cedbe600 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -143,7 +143,6 @@
 			interrupt-parent = <&gpio_intc>;
 			/* MAC_INTR on GPIOZ_15 */
 			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
-			eee-broken-1000t;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 70325b273bd2..ec09bb5792b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -142,7 +142,6 @@
 		eth_phy0: ethernet-phy@0 {
 			/* Realtek RTL8211F (0x001cc916) */
 			reg = <0>;
-			eee-broken-1000t;
 		};
 	};
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
