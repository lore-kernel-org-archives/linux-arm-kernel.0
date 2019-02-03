Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8C7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:42:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C195F2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hLkTIfOm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aq5pOEwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C195F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UTEQXa+N4oHIYBAslXfGhJobsA6oXuwylSTERgPiYQY=; b=hLkTIfOmxUssWh
	jvir2piuJTlXJGGOJVQEy+tNL+NAq3AVWFIdv746cZnmeeymsm0qUBBg+l/UtYeLYiRaMNEq7agKC
	R3uI+tdrfpner7zXl9JxW6WALgRKUkAWCvUztykwWgmq1tqmePQOZGj+AZg35hYgo0FJ9h0lLUGf0
	snBEF6i6U9q7ix+KUctf3soTemsWHGkgdGAlqwMmV9T9SHdiqxAEM1mnyPALW3EmLUlSA6rjeysXz
	ea3RXA/sq37g7cbz+kMvnjlVVr66tzHgM/sonfLwEge6bgNRJ8hwaVTT/a9RrLcOwTFzfkyrO3qWZ
	tm/TxBTgGScTqk5ys1XQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPWz-0008Au-9L; Sun, 03 Feb 2019 21:42:25 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPWv-0008AD-K5
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:42:23 +0000
Received: by mail-lf1-x142.google.com with SMTP id l142so934852lfe.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fpz2W/TjPcxFBHzYFFU5GOPTpjW/wLTawgRXQIP8reY=;
 b=aq5pOEwBf1JZhQfg37LP4aGoqMgPTJdaBLhQZM6ptHxswnfoEQiED0VumGGvDSZgTS
 JDUSX7+hSOQXWnzeEzCkKvlqFtPVEFBd2wQ+lFQTKG9+7OUc2iGniVuouXJ00TiOIpnR
 Riu8i/J2D9OIPbJalb98VW7BZMDxTuvwUI5N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fpz2W/TjPcxFBHzYFFU5GOPTpjW/wLTawgRXQIP8reY=;
 b=phlF1uB4T57SRkjIKh9+bcyJ5zqa5ggPeji3aAyCR0tmLEVvc91PXxzKOQwgJF/1ob
 MTfxA39QQE7WV9EyCeixfpjMMZpEdhHhfSBzyFmpRJjgrotjvs/1XMVr1GuJjhhHpBhg
 7r763fVGjW4Ctcn3HJz5W49v4C4moApYVA/ZKyqUwQnHFhWDpcu2AImsXg6p4wIedh1e
 ppsDzNgDPwwK2Z5bbCk17d5vR0DD0mhFypWJJYpoQ5CfTrdP4TxuNOnf36iMU1GCHmMm
 YB8U1UT9swvSHU1N8LGOyb8uE7VGnEWsfXB0XRRP+bjAwVhBEXjkcN/ud0yXE4iHfmsD
 QUWg==
X-Gm-Message-State: AJcUukdRMIS7tO+TDd+PA6lby33LdD5OJrwNbS/YQOGqSbagvdbrYuvp
 FnX9JtqmqrcIi/SV+CfhnvYpLGDuc/8=
X-Google-Smtp-Source: ALg8bN6LypUe4GA5l/pLfrZpCI47dwotB9bQvE8auYG1rbSe7oS26am6TsLeSOJuUS8NJ6a9G9lJmQ==
X-Received: by 2002:a19:59c2:: with SMTP id
 n185mr36422766lfb.118.1549230137229; 
 Sun, 03 Feb 2019 13:42:17 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 00/17 v1] ARM: ixp4xx: Modernize and DT support
Date: Sun,  3 Feb 2019 22:41:48 +0100
Message-Id: <20190203214205.13594-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134221_669397_DF923003 
X-CRM114-Status: GOOD (  20.20  )
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
Cc: Olof Johansson <olof@lixom.net>, Tim Harvey <tharvey@gateworks.com>,
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This modernizes the IXP4xx platform and adds initial Device Tree
Support. We migrate to MULTI_IRQ_HANDLER, bumps the IRQs to
offset 16, converts to SPARSE_IRQ, then we add proper subsystem
drivers in each subsystem for irqchip, GPIO and clocksource and
switch over to using these new drivers.

Then we add DT bindings to all of these aforementioned drivers,
add add support for probing each from device tree (keeping the
boardfile path).

Then we add Device Tree boot support.

The last patch shows how some basic (working) device trees will
look.

We will not delete any boardfiles until we support the
corresponding board fully with a device tree, which requires
things like PCI support which we can work on using this as
a base.

A working set of base patches that boots to prompto from
initramfs on NSLU2 and GW2358-4 is provided on this branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/log/?h=ixp4

I am now collecting feedback and ACKs for the patches. I aim
to create a branch in the GPIO tree and ask the ARM SoC tree
to pull it in. It will be best to keep all patches in one
branch since I mess with MAINTAINERS after each commit (as
requested by checkpatch!).

Obviously I am looking for the IXP4xx maintainers to review
and consent to this change or I cannot move ahead. I think
it is best that I queue up a branch and send to ARM SoC
but if you IXP4xx folks want to do it in some other way
I am happy to hear.

Linus Walleij (17):
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
  RFC: ARM: dts: Add some initial IXP4xx device trees

 .../devicetree/bindings/arm/intel-ixp4xx.yaml |  22 +
 .../bindings/gpio/intel,ixp4xx-gpio.txt       |  38 ++
 .../intel,ixp4xx-interrupt.txt                |  33 ++
 .../bindings/timer/intel,ixp4xx-timer.txt     |  18 +
 MAINTAINERS                                   |   9 +
 arch/arm/Kconfig                              |   5 +-
 arch/arm/boot/dts/Makefile                    |   3 +
 .../boot/dts/intel-ixp42x-linksys-nslu2.dts   | 111 ++++
 arch/arm/boot/dts/intel-ixp42x.dtsi           |  25 +
 .../dts/intel-ixp43x-gateworks-gw2358-4.dts   |  96 ++++
 arch/arm/boot/dts/intel-ixp43x.dtsi           |  15 +
 arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi    |  34 ++
 arch/arm/boot/dts/intel-ixp4xx.dtsi           |  58 +++
 arch/arm/mach-ixp4xx/Kconfig                  |  14 +
 arch/arm/mach-ixp4xx/Makefile                 |   3 +
 arch/arm/mach-ixp4xx/avila-pci.c              |   2 +
 arch/arm/mach-ixp4xx/avila-setup.c            |   2 +
 arch/arm/mach-ixp4xx/common.c                 | 426 ++--------------
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
 .../mach-ixp4xx/include/mach/ixp4xx-regs.h    |  89 ----
 arch/arm/mach-ixp4xx/irqs.h                   |  68 +++
 arch/arm/mach-ixp4xx/ixdp425-pci.c            |   2 +
 arch/arm/mach-ixp4xx/ixdp425-setup.c          |   2 +
 arch/arm/mach-ixp4xx/ixdpg425-pci.c           |   2 +
 arch/arm/mach-ixp4xx/ixp4xx-of.c              |  49 ++
 arch/arm/mach-ixp4xx/ixp4xx_npe.c             |   5 +
 arch/arm/mach-ixp4xx/ixp4xx_qmgr.c            |   7 +
 arch/arm/mach-ixp4xx/nas100d-pci.c            |   2 +
 arch/arm/mach-ixp4xx/nas100d-setup.c          |   5 +-
 arch/arm/mach-ixp4xx/nslu2-pci.c              |   2 +
 arch/arm/mach-ixp4xx/nslu2-setup.c            |  12 +-
 arch/arm/mach-ixp4xx/wg302v2-pci.c            |   2 +
 arch/arm/mach-ixp4xx/wg302v2-setup.c          |   2 +
 drivers/clocksource/Kconfig                   |   7 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-ixp4xx.c            | 284 +++++++++++
 drivers/gpio/Kconfig                          |  12 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-ixp4xx.c                    | 473 ++++++++++++++++++
 drivers/input/misc/ixp4xx-beeper.c            |  20 +-
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-ixp4xx.c                  | 405 +++++++++++++++
 drivers/net/ethernet/xscale/ixp4xx_eth.c      |  10 +
 drivers/watchdog/ixp4xx_wdt.c                 |   9 +
 include/linux/irqchip/irq-ixp4xx.h            |  12 +
 include/linux/platform_data/timer-ixp4xx.h    |  11 +
 58 files changed, 1940 insertions(+), 614 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
 create mode 100644 Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.txt
 create mode 100644 arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
 create mode 100644 arch/arm/boot/dts/intel-ixp42x.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358-4.dts
 create mode 100644 arch/arm/boot/dts/intel-ixp43x.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp4xx.dtsi
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-ixp4xx/irqs.h
 create mode 100644 arch/arm/mach-ixp4xx/ixp4xx-of.c
 create mode 100644 drivers/clocksource/timer-ixp4xx.c
 create mode 100644 drivers/gpio/gpio-ixp4xx.c
 create mode 100644 drivers/irqchip/irq-ixp4xx.c
 create mode 100644 include/linux/irqchip/irq-ixp4xx.h
 create mode 100644 include/linux/platform_data/timer-ixp4xx.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
