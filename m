Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10249C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:25:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF29720661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M0QzadpC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKDvG3Fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF29720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YB4YQrds7d6hKhniTMW1Z3QNNjktyr+pRi/3GnvTX7Q=; b=M0QzadpCa7SYnP
	Vs9IsV/gIm/eK31mO9LhUNvjZcw6+qQjxZT4dUvMKXm1zRSxW/6hEPveGQvIB0neAGDNF4JF97GDu
	2LGoWG9VQ/eXg9usvKczUi6GRTPl0D/0f3jjWr/1NeIwEgR5IsasgR9ciRzb0TdU1m/ZO1F2vJkTV
	SsoeGIMj3WPrXsaqm8DzviJeLTsHB5pHQH1xy9SH0xM16JCR/G+9ETHpOZ4zs3rNOHEM++bSGYfx3
	L6F7aIwBn+yGPN3FfeXVvyE45yQUrg8T/N4TB4yJ6e3hBOwSuXtX/WSgLgKkvYPpUGj1Zce76Ot+O
	yEvxjeN6C+eW9iysGjmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVl2H-0006Fc-0P; Sat, 08 Dec 2018 22:25:21 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVl0O-0003Ln-0I
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 22:23:34 +0000
Received: by mail-lf1-x142.google.com with SMTP id p86so5461475lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rBIWybge8yyBkLL0f+YVGaXW8/WUUWbmc+5k7MS2t0U=;
 b=JKDvG3FiDMcwN3bu1VOcAh/vAv5RQ0+jbS4pAORRb9KHCpO0ZL4ZDBrOEbNrKy6asU
 FsHdd4qIQv5fCL7lRsy6zAeWUxlVwzubujf0f5KXziRFdOiQVqHgQHR+bMR45sDm85Hi
 JcPPKQn5Kv/4KKLPg4izNyKcP9Nk9McvH7XUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rBIWybge8yyBkLL0f+YVGaXW8/WUUWbmc+5k7MS2t0U=;
 b=NFoI7wjMA9qpjsD/z6CE9F7nfYJc7rHVIo/F68xvu94kAD0YWloqiMc+aFCUGbqNV0
 /K6gXrhsL2Zph4a4+nNK+27h05zBmurP+QV3sSFuFVr+Sl0Lco9sKf64rQfjuRqCSYAx
 WsA3bZjkz9K/a++Sqs6dp+HSmEz3wZyEspveyj52ytWK36C5siPjuJit4IuIJhBnos+6
 iR8HWgltP/TtHvCHjUlTO5fkSSkDqxkm3r6eCN4lFEHt3Gei6UTPiOjwArPoNfK67/rT
 o86dRisODKS1bgFwjIQZpvH0N9gtlIMbolk7Ek6i6GkQjWG6yzxkNFhmkU2147kwjt7J
 +iGw==
X-Gm-Message-State: AA+aEWY0RcCPtouXP8AlKgoVkBTw0OaQVaZQnwFZnfvHpYoKzPjB7ffI
 RSgoTwZA242bFMHX34km43EnYmOSYjePpA==
X-Google-Smtp-Source: AFSGD/XXkXhmgLvMU474CF4EfyQvcmT/MmX/HE5ANIbS3DQa2A9JgSEV3qyQNfuTBadO35UcXFELLQ==
X-Received: by 2002:a19:641d:: with SMTP id y29mr3887412lfb.14.1544307795557; 
 Sat, 08 Dec 2018 14:23:15 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id b69sm1310884lfl.28.2018.12.08.14.23.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 08 Dec 2018 14:23:14 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4/5] ARM: dts: Add the FOTG210 USB host to Gemini boards
Date: Sat,  8 Dec 2018 23:23:00 +0100
Message-Id: <20181208222301.5303-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208222301.5303-1-linus.walleij@linaro.org>
References: <20181208222301.5303-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_142324_166425_3FB0E3C7 
X-CRM114-Status: GOOD (  17.18  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
 LEDE Development List <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the FOTG210 USB host controller to the Gemini
device trees. In the main SoC DTSI it is flagged as disabled
and then it is selectively enabled on the devices that utilize
it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts |  8 ++++++
 arch/arm/boot/dts/gemini-nas4220b.dts      |  8 ++++++
 arch/arm/boot/dts/gemini-rut1xx.dts        | 20 ++++++++++++++
 arch/arm/boot/dts/gemini-sl93512r.dts      |  8 ++++++
 arch/arm/boot/dts/gemini-sq201.dts         |  8 ++++++
 arch/arm/boot/dts/gemini-wbd111.dts        |  8 ++++++
 arch/arm/boot/dts/gemini-wbd222.dts        |  8 ++++++
 arch/arm/boot/dts/gemini.dtsi              | 32 ++++++++++++++++++++++
 8 files changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 318e9b2ba7dc..5e8e96458903 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -452,5 +452,13 @@
 				};
 			};
 		};
+
+		usb@68000000 {
+			status = "okay";
+		};
+
+		usb@69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 963ea890c87f..53b65ebe8454 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -204,5 +204,13 @@
 		ata@63400000 {
 			status = "okay";
 		};
+
+		usb@68000000 {
+			status = "okay";
+		};
+
+		usb@69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
index eb4f0bf074da..b2354c215a84 100644
--- a/arch/arm/boot/dts/gemini-rut1xx.dts
+++ b/arch/arm/boot/dts/gemini-rut1xx.dts
@@ -124,5 +124,25 @@
 				/* Not used in this platform */
 			};
 		};
+
+		ethernet@60000000 {
+			status = "okay";
+
+			ethernet-port@0 {
+				phy-mode = "rgmii";
+				phy-handle = <&phy0>;
+			};
+			ethernet-port@1 {
+				/* Not used in this platform */
+			};
+		};
+
+		usb@68000000 {
+			status = "okay";
+		};
+
+		usb@69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-sl93512r.dts b/arch/arm/boot/dts/gemini-sl93512r.dts
index ebefb7297379..2bb953440793 100644
--- a/arch/arm/boot/dts/gemini-sl93512r.dts
+++ b/arch/arm/boot/dts/gemini-sl93512r.dts
@@ -324,5 +324,13 @@
 		ata@63400000 {
 			status = "okay";
 		};
+
+		usb@68000000 {
+			status = "okay";
+		};
+
+		usb@69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index c5bb24102b75..ecbc27d93b2d 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -292,5 +292,13 @@
 		ata@63000000 {
 			status = "okay";
 		};
+
+		usb@68000000 {
+			status = "okay";
+		};
+
+		usb@69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-wbd111.dts b/arch/arm/boot/dts/gemini-wbd111.dts
index 29af86cd10f7..6831d2aed17a 100644
--- a/arch/arm/boot/dts/gemini-wbd111.dts
+++ b/arch/arm/boot/dts/gemini-wbd111.dts
@@ -171,5 +171,13 @@
 				/* Not used in this platform */
 			};
 		};
+
+		usb@68000000 {
+			status = "okay";
+		};
+
+		usb@69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
index 24e6ae3616f7..ed38d48ef5f6 100644
--- a/arch/arm/boot/dts/gemini-wbd222.dts
+++ b/arch/arm/boot/dts/gemini-wbd222.dts
@@ -183,5 +183,13 @@
 				phy-handle = <&phy1>;
 			};
 		};
+
+		usb@68000000 {
+			status = "okay";
+		};
+
+		usb@69000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index eb752e9495de..8cf67b11751f 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -409,5 +409,37 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		usb@68000000 {
+			compatible = "cortina,gemini-usb", "faraday,fotg210";
+			reg = <0x68000000 0x1000>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon GEMINI_RESET_USB0>;
+			clocks = <&syscon GEMINI_CLK_GATE_USB0>;
+			clock-names = "PCLK";
+			/*
+			 * This will claim pins for USB0 and USB1 at the same
+			 * time as they are using some common pins. If you for
+			 * some reason have a system using USB1 at 96000000 but
+			 * NOT using USB0 at 68000000 you wll have to add the
+			 * usb_default_pins to the USB controller at 96000000
+			 * in your .dts for the board.
+			 */
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb_default_pins>;
+			syscon = <&syscon>;
+			status = "disabled";
+		};
+
+		usb@69000000 {
+			compatible = "cortina,gemini-usb", "faraday,fotg210";
+			reg = <0x69000000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon GEMINI_RESET_USB1>;
+			clocks = <&syscon GEMINI_CLK_GATE_USB1>;
+			clock-names = "PCLK";
+			syscon = <&syscon>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
