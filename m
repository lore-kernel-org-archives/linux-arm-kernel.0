Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816C3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:51:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F84E218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f45wKS/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F84E218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=QfRYpYc2MlGhXITP/MyZkqpNGfIT8Wzp2qdwln1udTQ=; b=f45
	wKS/1uzoKc5Mj+Auu3cnMUJqrMvVycecX+gfob34NsKh66w7s56i/wnn7+9Pdcuj+tg2wRqQfFawY
	hKgXVCoRAkh/VPftkdcKSm0AJ0ThxTtyR0yfOidAd6Uul68blH6c0iGL9q1WHpZoyBGbh2IFVxGDI
	oqU/BKGZ8x2Qp7shNuUMx4nxSHObNxJavt/TsCzjnJf2S7xeEqt9X/qO0v9CfH4QMtVq3rVxNizEX
	bClYoV1YhbDGgV+m3X2e6oOi/exEzzn6Uo6k1gAzCsPjz1YMXQ1sQU5nLfTiOow0bhYlXPSAKiVEy
	6Z+gFhqws7wtYfbVGcrdSVdeDePoGUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyrBV-000264-IL; Wed, 27 Feb 2019 04:51:09 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyrBR-00025d-1H
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 04:51:07 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 27 Feb 2019 13:51:00 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 522DD6117D;
 Wed, 27 Feb 2019 13:51:00 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 27 Feb 2019 13:51:00 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 7203840392;
 Wed, 27 Feb 2019 13:50:59 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 41C1A121B6C;
 Wed, 27 Feb 2019 13:50:59 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org
Subject: [PATCH v4 00/10] Add basic support for Socionext Milbeaut M10V SoC
Date: Wed, 27 Feb 2019 13:50:56 +0900
Message-Id: <1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_205105_411162_1B65324F 
X-CRM114-Status: GOOD (  19.93  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Rob Herring <robh+dt@kernel.org>, Takao Orito <orito.takao@socionext.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Here is the series of patches the initial support for SC2000(M10V) of
Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
source code.

SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
computer vision. It also features advanced functionalities such as 360-degree,
real-time spherical stitching with multi cameras, image stabilization for
without mechanical gimbals, and rolling shutter correction. More detail is
below:
https://www.socionext.com/en/products/assp/milbeaut/SC2000.html

Specifications for developers are below:
 - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
 - NEON support
 - DSP
 - GPU
 - MAX 3GB DDR3
 - Cortex-M0 for power control
 - NAND Flash Interface
 - SD UHS-I
 - SD UHS-II
 - SDIO
 - USB2.0 HOST / Device
 - USB3.0 HOST / Device
 - PCI express Gen2
 - Ethernet Engine
 - I2C
 - UART
 - SPI
 - PWM

Support is quite minimal for now, since it only includes timer, clock,
pictrl and serial controller drivers, so we can only boot to userspace
through initramfs. Support for the other peripherals  will come eventually.

Changes since v3:
* Add "Reviewed" tag to the dt-binding of the serial driver.
* Fix schema string in milbeaut soc binding.
* Refine defconfig for milbeaut M10V.
* Add milbeaut architecture config to multi_v7_defconfig.

Changes since v2:
* Drop clk, pinctrl, and serial driver.
* Drop unneeded options from defconfig.
* Convert milbeaut soc binding to yaml.
* Fix serial driver binding.
* Change serial id of aliases in DT.
* Add platform checking when entering suspend/resume.
* Drop pr_err()s.

Changes since v1:
* Change file names.
* Change #define names.
* Refine cpu-enable-method and bindigs.
* Add documentation for Milbeaut SoCs.
* Add more infomation for timer driver.
* Add sched_clock to timer driver.
* Refine whole of clk driver.
* Add earlycon instead of earlyprintk.
* Refine Device Tree.


Sugaya Taichi (10):
  dt-bindings: sram: milbeaut: Add binding for Milbeaut smp-sram
  dt-bindings: arm: Add SMP enable-method for Milbeaut
  dt-bindings: Add documentation for Milbeaut SoCs
  ARM: milbeaut: Add basic support for Milbeaut m10v SoC
  dt-bindings: timer: Add Milbeaut M10V timer description
  clocksource/drivers/timer-milbeaut: Introduce timer for Milbeaut SoCs
  dt-bindings: serial: Add Milbeaut serial driver description
  ARM: dts: milbeaut: Add device tree set for the Milbeaut M10V board
  ARM: configs: Add Milbeaut M10V defconfig
  ARM: multi_v7_defconfig: add ARCH_MILBEAUT and ARCH_MILBEAUT_M10V

 Documentation/devicetree/bindings/arm/cpus.yaml    |   1 +
 .../bindings/arm/socionext/milbeaut.yaml           |  22 +++
 .../devicetree/bindings/serial/milbeaut-uart.txt   |  21 +++
 .../devicetree/bindings/sram/milbeaut-smp-sram.txt |  24 +++
 .../bindings/timer/socionext,milbeaut-timer.txt    |  17 +++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dts            |  32 ++++
 arch/arm/boot/dts/milbeaut-m10v.dtsi               |  95 ++++++++++++
 arch/arm/configs/milbeaut_m10v_defconfig           | 119 +++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/mach-milbeaut/Kconfig                     |  20 +++
 arch/arm/mach-milbeaut/Makefile                    |   1 +
 arch/arm/mach-milbeaut/platsmp.c                   | 143 ++++++++++++++++++
 drivers/clocksource/Kconfig                        |   9 ++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-milbeaut.c               | 161 +++++++++++++++++++++
 18 files changed, 672 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
 create mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dts
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v.dtsi
 create mode 100644 arch/arm/configs/milbeaut_m10v_defconfig
 create mode 100644 arch/arm/mach-milbeaut/Kconfig
 create mode 100644 arch/arm/mach-milbeaut/Makefile
 create mode 100644 arch/arm/mach-milbeaut/platsmp.c
 create mode 100644 drivers/clocksource/timer-milbeaut.c

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
