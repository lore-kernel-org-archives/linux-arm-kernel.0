Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9BC4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C302A20449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DPMSDm+6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Zhrmsu6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C302A20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=khCPu68teNlA62sarLOrLcvgkOr/v/d6YZqH/V5O8Xw=; b=DPMSDm+6jnXQB/
	tjp+NVKpQO6bVs1GvkhnOfKBC2CqeZcySnXaPji+6t8odLdH9rOmonwNS0cmZYFR/W3Jychx9/qAT
	5N7WskMRk3akwvWMLzBUvLF9V7OXlzqHTQ79VyvZSi4N82ypt0RUOex8uil+3/br5lL2xipIv9lC+
	C12Pudv691fXhKiKgTncJDKLXxsSb39gXqvVb+l/F6xS9B+fKEv4zpt5MuUn8klruUreLgiKOxAol
	1/mayEiDXPykJq9SyxZD42MemNJqcdvlx0MsKT1AlhAE3Y0HwlhiwMlQh6xHr9Hqx8DIpOgyLe4QA
	0jN5jEFxfuq5xgFw3T/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVT9-00065w-RS; Tue, 12 Feb 2019 10:39:15 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVSu-0005ri-4t
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:01 +0000
Received: by mail-wr1-x443.google.com with SMTP id w17so2048720wrn.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PDjNBvyvVoHvvc5JUb/baeUz66OyAJ8u1fDtgbl0Wsk=;
 b=Zhrmsu6wBiqmoiFJ8pKfCnPEDPg/EwiEBiANshFQqYUSXwGctIS69qTbBK484nL5Xf
 292ougMtQOdrsRe+J5MGGiWBglBXAuW0RA+VamCzUIRaL3HorLxXCiliU/SCrbDo+yaO
 FS74wB5O1DMjmgWk1mwa29AlmCCeoYyFXnPaEQWxkAuk0YVdm+HSYqucZ71kuZrb17D4
 m2i6DLQs5qL6NTwCQmxjqhbLncNmMKC/rPIq9HjHX/2eGlxFHIFR/fr1QkotlYiLq9Wb
 VRbkK2mVMpIE6n3BtIOonf5TK/MrSwAkjU5ZaT3JRIi3uPbl8RelUIRRGGLzp7Ep3zTp
 0YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PDjNBvyvVoHvvc5JUb/baeUz66OyAJ8u1fDtgbl0Wsk=;
 b=R80lKKeMDa+eG6d3bINlhmkjbVdlcKc0rfzHpNlN55vR881MCnVy7H/0GvrW112dS0
 tj/H+h6dYpdjE2TZBcUZiL2zoKDvpqtBltPuuCbrTZdmsPi4gZOJgEU9ekCKeoYtPfps
 j/arQxETTtcpdPOVF/Hk08e251swX5mvmoPgQ1RfYS3PgEnRtk13fRTRsZEHK51J5cp1
 GwjTJNQawhFRTXoaHtoXVWb2+8ENok9Z+PX2na1PlGEhYNiUg2zXn9XyC0zaVZgn6+I1
 mC5ooGVgMEZNQ+9VGro6ZVNCYwdrItJtPEGwFVGeKKPYoB/3xnyl7KIa4i++LzEKxhwi
 Bepg==
X-Gm-Message-State: AHQUAuaEszFxoETSblthI8NAN4yps5prVlvosU9oiW3M7B6wvBIRO83w
 /NY/nJq9IG8VnqR5rCUvSdNBfQ==
X-Google-Smtp-Source: AHgI3IYELN4e3xXG0/g/+NOPYoGj2FA+Vt4HUCEqeGuTT6AV3mX26/X1rCq7ciuOZCufXORVNExvKA==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr2228262wrs.94.1549967935722; 
 Tue, 12 Feb 2019 02:38:55 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.38.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:38:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 00/37] ARM: davinci: modernize the irq support
Date: Tue, 12 Feb 2019 11:37:58 +0100
Message-Id: <20190212103835.7768-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023900_187984_CEC47C9F 
X-CRM114-Status: GOOD (  22.02  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series ports the davinci platform to using SPARSE_IRQ, cleans up
the irqchip drivers and moves them over to drivers/irqchip.

The series can be logically split into five parts. The first patch
preemptively fixes a problem in an input driver that would have caused
problems later. Patches (2-9) aim at introducing support for SPARSE_IRQ.
They contain a couple changes required for that functionality and do some
cleanup at the end.

Third part (10-22) makes the aintc driver suitable for drivers/irqchip
and eventually moves it over there.

Part 4 (23-36) does the same for the cp-intc driver.

Last patch removes unnecessary code.

The series has been tested on da850-lcdk (for cp-intc) and
dm365-evm (for aintc).

v1 -> v2:
- made commit messages readable without reading the subject line first
- collected David's Reviewed-by tags for patches that haven been
  significantly modified since v1
- added handling of spurious interrupts in cp-intc
- added comments explaining the irq handlers (C versions translated from
  assembly)
- dropped the patches removing the hardware interrupt numbers from
  the priority tables
- don't remove irqs.h, make it a local header instead
- rearranged the patches in order not to remove the code added
  by earlier ones
- renamed d*_init_irqs to d*_init_irq to fit the name of the relevant
  callback in machine info struct
- fixed license identifiers where needed
- added comments to config structures for irqchip drivers
- fixed all off-by-one errors in resource sizes
- clarified the comments on the weird handling of IRQ_TINT1_TINT34 as level
  irq and added missing calls to irq_set_handler() to dm3* SoCs
- fixed one function that was missing a correct prefix in cp_intc
- return value variables should be called ret not rv
- added a patch converting calls to _raw_readl/writel() to their _relaxed
  counterparts
- fixed the commit message prefix in patches that belong to the irqchip
  subsystem

v2 -> v3:
- added a patch preventing a build problem in davinci_keyscan driver
- converted another usage of 'int rv' to 'int ret'
- don't use __raw_readl/writel() in new patches, but leave patches converting
  previous uses
- drop a stray newline in usb.c when removing irqs.h
- when unifying the error handling: use specific messages instead of WARN_ON()
- do the above for aintc as well
- add patches adding calls to request_mem_region() to both drivers

Bartosz Golaszewski (37):
  input: davinci_keyscan: remove unnecessary includes
  ARM: davinci: remove intc_host_map from davinci_soc_info struct
  ARM: davinci: aintc: use irq domain
  ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
  ARM: davinci: remove davinci_intc_type
  ARM: davinci: pull davinci_intc_base into the respective intc drivers
  ARM: davinci: wrap HW interrupt numbers with a macro
  ARM: davinci: select SPARSE_IRQ
  ARM: davinci: make irqs.h a local header
  ARM: davinci: aintc: drop GPL license boilerplate
  ARM: davinci: aintc: wrap davinci_irq_init() with a helper
  ARM: davinci: aintc: use a common prefix for symbols in the driver
  ARM: davinci: aintc: drop the 00 prefix from register offsets
  ARM: davinci: aintc: use readl/writel_relaxed()
  irqchip: davinci-aintc: add a new config structure
  ARM: davinci: aintc: use the new irqchip config structure in dm* SoCs
  ARM: davinci: aintc: use the new config structure
  ARM: davinci: aintc: unify error handling
  ARM: davinci: aintc: request memory region before remapping it
  ARM: davinci: aintc: move timer-specific irq_set_handler() out of
    irq.c
  ARM: davinci: aintc: remove unnecessary includes
  irqchip: davinci-aintc: move the driver to drivers/irqchip
  ARM: davinci: cp-intc: remove cp_intc.h
  ARM: davinci: cp-intc: add a wrapper around cp_intc_init()
  irqchip: davinci-cp-intc: add a new config structure
  ARM: davinci: cp-intc: add the new config structures for da8xx SoCs
  ARM: davinci: cp-intc: use a common prefix for all symbols
  ARM: davinci: cp-intc: convert all hex numbers to lowercase
  ARM: davinci: cp-intc: use the new-style config structure
  ARM: davinci: cp-intc: request the memory region before remapping it
  ARM: davinci: cp-intc: improve coding style
  ARM: davinci: cp-intc: unify error handling
  ARM: davinci: cp-intc: use readl/writel_relaxed()
  ARM: davinci: cp-intc: drop GPL license boilerplate
  ARM: davinci: cp-intc: remove redundant comments
  irqchip: davinci-cp-intc: move the driver to drivers/irqchip
  ARM: davinci: remove intc related fields from davinci_soc_info

 arch/arm/Kconfig                              |   2 +
 arch/arm/mach-davinci/Kconfig                 |  19 +-
 arch/arm/mach-davinci/Makefile                |   3 -
 arch/arm/mach-davinci/asp.h                   |   8 +-
 arch/arm/mach-davinci/board-da830-evm.c       |   5 +-
 arch/arm/mach-davinci/board-da850-evm.c       |   5 +-
 arch/arm/mach-davinci/board-dm355-evm.c       |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c   |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c      |   8 +-
 arch/arm/mach-davinci/board-dm646x-evm.c      |   7 +-
 arch/arm/mach-davinci/board-mityomapl138.c    |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c     |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c   |   3 +-
 arch/arm/mach-davinci/board-sffsdr.c          |   2 +-
 arch/arm/mach-davinci/common.c                |   3 -
 arch/arm/mach-davinci/cp_intc.c               | 215 ---------------
 arch/arm/mach-davinci/cp_intc.h               |  57 ----
 arch/arm/mach-davinci/da830.c                 | 128 ++-------
 arch/arm/mach-davinci/da850.c                 | 154 ++---------
 arch/arm/mach-davinci/davinci.h               |   4 +
 arch/arm/mach-davinci/devices-da8xx.c         | 147 +++++-----
 arch/arm/mach-davinci/devices.c               |  40 +--
 arch/arm/mach-davinci/dm355.c                 |  86 +++---
 arch/arm/mach-davinci/dm365.c                 | 110 +++++---
 arch/arm/mach-davinci/dm644x.c                |  76 +++--
 arch/arm/mach-davinci/dm646x.c                |  90 +++---
 arch/arm/mach-davinci/include/mach/common.h   |  14 +-
 arch/arm/mach-davinci/include/mach/da8xx.h    |   2 +
 .../mach-davinci/include/mach/entry-macro.S   |  39 ---
 arch/arm/mach-davinci/irq.c                   | 117 --------
 .../mach-davinci/{include/mach => }/irqs.h    |   4 -
 arch/arm/mach-davinci/usb-da8xx.c             |   9 +-
 arch/arm/mach-davinci/usb.c                   |  13 +-
 drivers/input/keyboard/davinci_keyscan.c      |   4 -
 drivers/irqchip/Kconfig                       |  10 +
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-davinci-aintc.c           | 163 +++++++++++
 drivers/irqchip/irq-davinci-cp-intc.c         | 260 ++++++++++++++++++
 include/linux/irqchip/irq-davinci-aintc.h     |  27 ++
 include/linux/irqchip/irq-davinci-cp-intc.h   |  25 ++
 41 files changed, 912 insertions(+), 960 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/cp_intc.c
 delete mode 100644 arch/arm/mach-davinci/cp_intc.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-davinci/irq.c
 rename arch/arm/mach-davinci/{include/mach => }/irqs.h (98%)
 create mode 100644 drivers/irqchip/irq-davinci-aintc.c
 create mode 100644 drivers/irqchip/irq-davinci-cp-intc.c
 create mode 100644 include/linux/irqchip/irq-davinci-aintc.h
 create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
