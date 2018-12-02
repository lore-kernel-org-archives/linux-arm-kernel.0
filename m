Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F566C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5865620892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZUjUWriu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3SuOme7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5865620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=7NqHDUeZ/Yg8M8lrKi8zY7yY00fUySjZQITw8Qq4oa4=; b=ZUj
	UWriukxR3d1edPDAcNqS6990UWpVk+E09qFxplc25tIC8rCV1Q6UWn2PSwSeufVzz+yTLDC7fM/+I
	NRaXgyj4pXKYpJFun3Cc4M240eHBhofINNTt7Kwg4MDba231wvL71XfBAmI7FOksoy7cN8HSUJCCu
	9YoEzMhsdTo7hA4wPLZ/JSLt12FGcAJMlXsnkC09JpFowN3VO//sQeiP9rDzkbGvvIxY5IEmYnUYp
	sPFiGZVcpYpz2x4yFPN4FKWgSnjYdiLb2gJZ0rOTaZTk3JYaHn4lbR/LiPd0DJGMHPA0wvSrLV5HD
	CpnliAAotGDLU9i2dY6ilMwkwOAZIRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYI0-00020X-5x; Sun, 02 Dec 2018 20:24:28 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYHw-0001wA-NG
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:26 +0000
Received: by mail-wm1-x344.google.com with SMTP id n190so1243699wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=HkUpJ5u4r54RHIDg1gzTLsj/w77aL+J50O3FnhmlJOw=;
 b=E3SuOme7u/a1WA6+Zoz7I5g2kxrWwXZSSOMcXtfXJwbW7e5Ek9lPzdS8BHfNJpV19u
 yzlf9XIPqq4WMCO4/k+J/E2Ut7Z27DT83QRjt8NRUfIWiDrwKNTWgXAn6wluT/nlMOYP
 Ut71ei8dYTXYYKJCuCI6++r6/nEms0UvUr7797l7cW8rgB973CDUV3zjwAl0Ffgy3zga
 qYKxs/QQ2329sjaQp9AK0SYK42w1zSWYFod2EriG82xvi7RyTgfTgKJU/GejQ2+qq4dV
 tmrAH9ZjWEs2z8CX9v5lkSqRAR6DBnTh3QhHI9yvQ7IywptDS2LOIF/daqK5gQ6+beP7
 SpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HkUpJ5u4r54RHIDg1gzTLsj/w77aL+J50O3FnhmlJOw=;
 b=UBNr95of/5McegiscGC3AJWxF/9KpKJx5u9qbWUvoeAk/eNaHIcYeckOtmRSgxdMwM
 PRNYHlzSqceZcErTS4lBRtAAYKQqUL/26+39/g6iOb2hg9UcQ0LkTWdszPptMfb7ywm5
 UWgutMTlc/3PAPm/yNN2wA7o2uMkuxffSjj3SwRa7ayNg85ctxOLpcZLAD6rT6iV3tgL
 TqbwoPQelfDTBhWk5YUJ9XXSZSNjAm8Vt+MdBvQCXQjfrtRIH87NPeVQQQL9nY3IbHUf
 KuYeVdLdKOU+QNPEqijIcfA7FPgf+i+fuHlaPuV9J1IhdB3oUCk3v7cx8Rvuq2KmsDg8
 lw8A==
X-Gm-Message-State: AA+aEWZP5WLx3fOc+PjCKn4FhCYXYtNhWm/m/NC8T7U838vrIugH1z4Y
 cnrgV8tPsgOeqY4qvw9lbuM=
X-Google-Smtp-Source: AFSGD/Vc+qGw9tdEbw5X7WMtvAB6XnjcHlyyYSAwEiJgrtbhmzhnL5/P5omnh1nE5cNflXNMosAAWg==
X-Received: by 2002:a1c:c148:: with SMTP id r69mr5870115wmf.147.1543782250442; 
 Sun, 02 Dec 2018 12:24:10 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:09 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 00/17] initial support for "suniv" Allwinner new ARM9 SoC
Date: Sun,  2 Dec 2018 23:23:34 +0300
Message-Id: <cover.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122424_766940_B77EC5F3 
X-CRM114-Status: GOOD (  16.19  )
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

This is the sixth version of patchset for Allwinner ARMv5 F1C100s
SoC. Addressed comments from Stephen Boyd, added signatures.

Changes since v5:
- Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
  - Fixed license identifier position

Changes since v4:
- Patch "dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl"
  - This patch applied for 4.21.
- Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
  - This patch applied for 4.21.
- Patch "dt-bindings: clock: Add Allwinner suniv F1C100s CCU"
  - Fixed license identifier position
  - Added DMA fields.
- Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
  - Added DMA reset and clock support.
- Patch "ARM: dts: suniv: add initial DTSI file for F1C100s"
  - Remove dt-binding headers. 
  - Fix uart0 pin label.
- Patch "ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
  - Fix uart0 pin label.

Changes since v3:
- Patch "ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs"
  - Remove CONFIG_ARCH_SUNXI_Vx. Use ARCH_MULTI_Vx to differentiate SoC's
  - Change KConfig ARCH_SUNXI selection: 'select' to 'default'. 
- Patch "irqchip/sun4i: Add a struct to hold global variables"
  - Split irq_sun4i.c changes to 3 patch.
- Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
  - pinctrl-suniv-f1c100s: remove: disable_strict_mode = true
- Patch "ARM: dts: suniv: add initial DTSI file for F1C100s"
  - suniv-f1c100s.dtsi: remove unnecessary componenets.
  - Instead of patching drivers, add original compatible string with 
f1c100s compatibles.
  - Add Acked-by signatures.

Changes since v2:
- Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
  - Move SUN4I_TIMER option to ARCH_SUNXI
  - Added help text for MACH_SUNIV
- Patch "irqchip/sun4i: add support for suniv interrupt controller"
  - Defined sunxi_irq_chip_data struct and used it to differentiate
    registers between different chips.
- Patch " ARM: dts: suniv: add initial DTSI file for F1C100s"
  - Removed unnecessary fake clock.
  - Fixed compatible strings.

Changes since v1:
- Patch "ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7
  Allwinner SoCs"
  - Instead of using a common bool config use a common menuconfig. 
  - Use ARCH_MULTI_V7 to differentiate V7 SoCs.
  - Addressed comment from Julian Calaby
- Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
  - Use ARCH_MULTI_V5 to differentiate V5 SoCs.
  - removed "allwinner,suniv" board compatible string
  - Added dt-bindings
- Patch "irqchip/sun4i: add support for suniv interrupt controller"
  - Added dt-bindings
  - Changed "allwinner,suniv-ic" to "allwinner,suniv-f1c100s-ic"
- Patch "clocksource: sun4i: add a compatible for suniv"
  - Added dt-bindings
  - Changed "allwinner,suniv-timer" to "allwinner,suniv-f1c100s-timer"
- Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
  - Added dt-bindings
  - Renamed suniv-pinctrl to suniv-f1c100s-pinctrl
- Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
  - Added dt-bindings
  - Renamed suniv-ccu to suniv-f1c100s-ccu
- Patch "ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
  - Addressed comment from Rask Ingemann Lambertsen

Thanks!

Mesih Kilinc (17):
  ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
  dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
  ARM: sunxi: add Allwinner ARMv5 SoCs
  dt-bindings: interrupt-controller: Add suniv interrupt-controller
  irqchip/sun4i: Add a struct to hold global variables
  irqchip/sun4i: Move IC specific register offsets to struct
  irqchip/sun4i: Add support for Allwinner ARMv5 F1C100s
  dt-bindings: timer: Add Allwinner suniv timer
  clocksource: sun4i: add a compatible for suniv
  dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
  pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
  dt-bindings: clock: Add Allwinner suniv F1C100s CCU
  clk: sunxi-ng: add support for suniv F1C100s SoC
  dt-bindings: sram: Add Allwinner suniv F1C100s
  dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
  ARM: dts: suniv: add initial DTSI file for F1C100s
  ARM: suniv: f1c100s: add device tree for Lichee Pi Nano

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 .../interrupt-controller/allwinner,sun4i-ic.txt    |   4 +-
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 .../devicetree/bindings/sram/sunxi-sram.txt        |   4 +
 .../bindings/timer/allwinner,sun4i-timer.txt       |   4 +-
 .../devicetree/bindings/watchdog/sunxi-wdt.txt     |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |  26 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi               | 147 ++++++
 arch/arm/mach-sunxi/Kconfig                        |  19 +-
 arch/arm/mach-sunxi/sunxi.c                        |  10 +
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           | 541 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |  34 ++
 drivers/clocksource/sun4i_timer.c                  |   5 +-
 drivers/irqchip/irq-sun4i.c                        | 106 ++--
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      | 416 ++++++++++++++++
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      |  70 +++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      |  38 ++
 23 files changed, 1408 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
