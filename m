Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E8EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:45:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FC420842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CRcH0nlv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSTi+Jbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FC420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=x1vgLVd5pc81hZb/ayQD+JJGn4j1rSJzet2ZXoq62hE=; b=CRcH0nlviG7Zzx
	PDrUyMFmpoYlMfrLhDhNX2ZEOPyBeIv++/LbVh5/mwbz3qdBp1Uz7TvCkwkXNgsQyJxdPeShQ91W0
	6CUgJqzYOGMcZf/WZA8Dn1xOmsXeB7cRwSeZ5844AnIyejg5dlvAl6mLpEkDgax5HDmqtSHYDvbvi
	pmFn8nE+eJMFPunJcfgQEnf0OLU1M9pUU0+bK3PJj0CgiH9F3zLVkwkkMmvKJCT4v+e7D2c/hEWqS
	vMkvAfLtcVVMWLREvm9KLQ2qkJp450TarzcW+scBzzoLS2zAnApP2fesOnB2j2oe4kgqYh1O5W0Yr
	fhMgrygNRkmpqeLnMOtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqXC-0004j4-06; Thu, 21 Feb 2019 15:45:14 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqX7-0004Qw-0F
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:10 +0000
Received: by mail-lf1-x141.google.com with SMTP id e27so20704415lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t9YNo6p2Z6AC44TcRkCUdNNkg8W2+n28FRwCvJZ3DqM=;
 b=uSTi+JbiKggs72DjWeLDi36MSH5opOCCBuOvygJvQnwBf3PnK3g0ciAdxygswBiLRR
 jSxQRw2NKnAkzq0YXO77QFy6VPh5x5aAIetszF0fI21mFGh6AJG5bhHEFAFE1oZd4WXo
 DGaxjgHkqC9n71Q+xgggRWoocKL1De1f/B3DL+VYlcqn4wjdsIMZPEkp4nQ6rxNvxXD4
 +tIV9MBAQByK6JxHWmzgg6eNM+i5RgZYE5gohvPiplRkTh6mB/Bdp1aTcl3YuHRt016q
 XquLhn9PjEjmavpCR/eujwdLZXWf+iL/d+7ucqRjE9lBH0LRW/AseQPK7JWC5TWjihJF
 HWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t9YNo6p2Z6AC44TcRkCUdNNkg8W2+n28FRwCvJZ3DqM=;
 b=R5U7jS3B5Uu5DYimfuvb9f2suhZNODfloltY6z2+Y4wXrdrk6Tw2KXKkC9GyGUxXxa
 t1NfU6sKXOKn5IMoUZNmzGOwRhPKtw8LEHJicuSceF+eKv2y4CRH2FjoWI8vKfhn2NSv
 MG9HNP5RWBp8ydiJb+dHt73/3bexDvpUQVel0hltOY24w/IVQ34irOfkTLfG8eLd/6XS
 4nFafnuMHawDmagrwzz8glwXxIhAR4ZrL4fvoVE7kT5fhKwMJvsu4qx9wFv3yTE79hwW
 8OXNx2ZHfdXiK8I+dVpDXCM1k/rfP9FzJd0wGtWj3//0Y3Nlke1ep26eTrYZ4ywZCZ66
 uGBw==
X-Gm-Message-State: AHQUAua++MaxlooL3HtD1jkA+Cg0G6NSKeQN4ZtZawxMhQyw/IUquOif
 BT/IazajLZ+wPI1EY1tqACidlWX/VPQ=
X-Google-Smtp-Source: AHgI3IZeeqAyac1ZDInW6guM683CniKzbSUPYNslqrl1dqvu3lZmxRKywcAN0WniHuwvPQFf5ogL0Q==
X-Received: by 2002:a19:4f57:: with SMTP id a23mr25329574lfk.46.1550763906412; 
 Thu, 21 Feb 2019 07:45:06 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:04 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 00/30 v2] ARM: ixp4xx: Modernize and DT support
Date: Thu, 21 Feb 2019 16:44:28 +0100
Message-Id: <20190221154458.23763-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074509_054817_1B0B4822 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This modernizes the IXP4xx platform and adds initial Device Tree
Support. We migrate to MULTI_IRQ_HANDLER, bumps the IRQs to
offset 16, converts to SPARSE_IRQ, then we add proper subsystem
drivers in each subsystem for irqchip, GPIO and clocksource and
switch over to using these new drivers.

This patch set represents what I want to merge for v5.2 early
after the next merge window. I already have working ethernet
but that will be a bonus feature if we can get it in or will
be deferred to v5.3 so that it can be applied in isolation.

Major changes from v1:
- Added patches for moving NPE and queue manager down to
  drivers/soc/ixp4xx
- Added device tree bindings and code to probe NPE and queue
  manager from device tree

A working set of base patches that boots to prompt from
initramfs on NSLU2 and GW2358-4 and also includes the
series for ethernet support is provided on this branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/log/?h=ixp4

Obviously I am looking for the IXP4xx maintainers to ACK
the patch set.


Linus Walleij (30):
  ARM: ixp4xx: Convert to MULTI_IRQ_HANDLER
  ARM: ixp4xx: Pass IRQ resource to beeper
  ARM: ixp4xx: Convert to SPARSE_IRQ
  irqchip: Add driver for IXP4xx
  gpio: ixp4xx: Add driver for the IXP4xx GPIO
  ARM: ixp4xx: Switch to use new IRQ+GPIO drivers
  clocksource/drivers/ixp4xx: Add driver
  ARM: ixp4xx: Switch to use new timer driver
  irqchip: ixp4xx: Add DT bindings
  irqchip: ixp4xx: Add OF initialization support
  clocksource/drivers/ixp4xx: Add DT bindings
  clocksource/drivers/ixp4xx: Add OF initialization support
  gpio: ixp4xx: Add DT bindings
  gpio: ixp4xx: Add OF probing support
  ARM: ixp4xx: Add DT bindings
  ARM: ixp4xx: Add device tree boot support
  ARM: dts: Add some initial IXP4xx device trees
  ARM: ixp4xx: Move NPE and QMGR to drivers/soc
  ARM: ixp4xx: Move IXP4xx QMGR and NPE headers
  ARM: ixp4xx: Turn the NPE into a platform device
  ARM: ixp4xx: Turn the QMGR into a platform device
  soc: ixp4xx: npe: Pass addresses as resources
  soc: ixp4xx: Uninline several functions
  soc: ixp4xx: Remove unused functions
  soc: ixp4xx: qmgr: Pass resources
  soc: ixp4xx: Add DT bindings for IXP4xx NPE
  soc: ixp4xx: npe: Add DT probe code
  soc: ixp4xx: qmgr: Add DT bindings for IXP4xx qmgr
  soc: ixp4xx: qmgr: Add DT probe code
  ARM: dts: Add queue manager and NPE to the IXP4xx DTSI

 .../devicetree/bindings/arm/intel-ixp4xx.yaml |  22 +
 ...ntel,ixp4xx-network-processing-engine.yaml |  44 ++
 .../bindings/gpio/intel,ixp4xx-gpio.txt       |  38 ++
 .../intel,ixp4xx-interrupt.yaml               |  57 +++
 .../misc/intel,ixp4xx-queue-manager.yaml      |  57 +++
 .../bindings/timer/intel,ixp4xx-timer.yaml    |  42 ++
 MAINTAINERS                                   |  17 +-
 arch/arm/Kconfig                              |   5 +-
 arch/arm/boot/dts/Makefile                    |   3 +
 .../boot/dts/intel-ixp42x-linksys-nslu2.dts   | 109 ++++
 arch/arm/boot/dts/intel-ixp42x.dtsi           |  25 +
 .../dts/intel-ixp43x-gateworks-gw2358.dts     |  94 ++++
 arch/arm/boot/dts/intel-ixp43x.dtsi           |  15 +
 arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi    |  34 ++
 arch/arm/boot/dts/intel-ixp4xx.dtsi           |  70 +++
 arch/arm/mach-ixp4xx/Kconfig                  |  27 +-
 arch/arm/mach-ixp4xx/Makefile                 |   5 +-
 arch/arm/mach-ixp4xx/avila-pci.c              |   2 +
 arch/arm/mach-ixp4xx/avila-setup.c            |   2 +
 arch/arm/mach-ixp4xx/common.c                 | 484 +++---------------
 arch/arm/mach-ixp4xx/coyote-pci.c             |   2 +
 arch/arm/mach-ixp4xx/coyote-setup.c           |   2 +
 arch/arm/mach-ixp4xx/dsmg600-pci.c            |   2 +
 arch/arm/mach-ixp4xx/dsmg600-setup.c          |   5 +-
 arch/arm/mach-ixp4xx/fsg-pci.c                |   2 +
 arch/arm/mach-ixp4xx/fsg-setup.c              |   2 +
 arch/arm/mach-ixp4xx/gateway7001-pci.c        |   2 +
 arch/arm/mach-ixp4xx/gateway7001-setup.c      |   2 +
 arch/arm/mach-ixp4xx/gtwx5715-pci.c           |   2 +
 arch/arm/mach-ixp4xx/gtwx5715-setup.c         |   2 +
 .../mach-ixp4xx/include/mach/entry-macro.S    |  41 --
 arch/arm/mach-ixp4xx/include/mach/irqs.h      |  75 ---
 .../mach-ixp4xx/include/mach/ixp4xx-regs.h    |  94 ----
 arch/arm/mach-ixp4xx/include/mach/qmgr.h      | 204 --------
 arch/arm/mach-ixp4xx/irqs.h                   |  68 +++
 arch/arm/mach-ixp4xx/ixdp425-pci.c            |   2 +
 arch/arm/mach-ixp4xx/ixdp425-setup.c          |   2 +
 arch/arm/mach-ixp4xx/ixdpg425-pci.c           |   2 +
 arch/arm/mach-ixp4xx/ixp4xx-of.c              |  60 +++
 arch/arm/mach-ixp4xx/nas100d-pci.c            |   2 +
 arch/arm/mach-ixp4xx/nas100d-setup.c          |   5 +-
 arch/arm/mach-ixp4xx/nslu2-pci.c              |   2 +
 arch/arm/mach-ixp4xx/nslu2-setup.c            |  12 +-
 arch/arm/mach-ixp4xx/wg302v2-pci.c            |   2 +
 arch/arm/mach-ixp4xx/wg302v2-setup.c          |   2 +
 drivers/clocksource/Kconfig                   |   7 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-ixp4xx.c            | 284 ++++++++++
 drivers/crypto/ixp4xx_crypto.c                |   4 +-
 drivers/gpio/Kconfig                          |  12 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-ixp4xx.c                    | 474 +++++++++++++++++
 drivers/input/misc/ixp4xx-beeper.c            |  20 +-
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-ixp4xx.c                  | 407 +++++++++++++++
 drivers/net/ethernet/xscale/ixp4xx_eth.c      |  14 +-
 drivers/net/wan/ixp4xx_hss.c                  |   4 +-
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/ixp4xx/Kconfig                    |  16 +
 drivers/soc/ixp4xx/Makefile                   |   2 +
 .../soc/ixp4xx/ixp4xx-npe.c                   |  66 ++-
 .../soc/ixp4xx/ixp4xx-qmgr.c                  | 186 +++++--
 drivers/watchdog/ixp4xx_wdt.c                 |   9 +
 include/linux/irqchip/irq-ixp4xx.h            |  12 +
 include/linux/platform_data/timer-ixp4xx.h    |  11 +
 .../mach => include/linux/soc/ixp4xx}/npe.h   |   2 -
 include/linux/soc/ixp4xx/qmgr.h               |  91 ++++
 69 files changed, 2467 insertions(+), 913 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
 create mode 100644 arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
 create mode 100644 arch/arm/boot/dts/intel-ixp42x.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
 create mode 100644 arch/arm/boot/dts/intel-ixp43x.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp4xx.dtsi
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/qmgr.h
 create mode 100644 arch/arm/mach-ixp4xx/irqs.h
 create mode 100644 arch/arm/mach-ixp4xx/ixp4xx-of.c
 create mode 100644 drivers/clocksource/timer-ixp4xx.c
 create mode 100644 drivers/gpio/gpio-ixp4xx.c
 create mode 100644 drivers/irqchip/irq-ixp4xx.c
 create mode 100644 drivers/soc/ixp4xx/Kconfig
 create mode 100644 drivers/soc/ixp4xx/Makefile
 rename arch/arm/mach-ixp4xx/ixp4xx_npe.c => drivers/soc/ixp4xx/ixp4xx-npe.c (94%)
 rename arch/arm/mach-ixp4xx/ixp4xx_qmgr.c => drivers/soc/ixp4xx/ixp4xx-qmgr.c (66%)
 create mode 100644 include/linux/irqchip/irq-ixp4xx.h
 create mode 100644 include/linux/platform_data/timer-ixp4xx.h
 rename {arch/arm/mach-ixp4xx/include/mach => include/linux/soc/ixp4xx}/npe.h (95%)
 create mode 100644 include/linux/soc/ixp4xx/qmgr.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
