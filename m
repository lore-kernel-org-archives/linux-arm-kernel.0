Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DF4C31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:18:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC352089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hl4Eg6bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC352089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=//A64VtM56l2dLDS/voIVW8/PKn4KROOmgAQvb10uo0=; b=hl4Eg6bz1gWVdnOLiTFqgDOimD
	uVE+1vswD5b6jq7DHcv3jZQgCBhT9fnlUPzz/15QRFGVcmr7Ml+hk0V5fx7g7eDBpCNoD4DQ1zNhH
	RR1kgFzOdf/kdRinOL58bZLQwIEkbMTzbInNl/pCZ0uLdcMQDqtzrd/nBy0A8L8Y1JmGalXpA+GE+
	LMVCQJvAFg0bIXRcW6ZuuuIurp14h0LXl3jKY7DuE1DKNWFzQPag86Gwb+RMXNdepKrtOp/BGBfkp
	XZ2mG6pcMCWI0SlHX5kBYIlJgXo6uL7qRojkyxgRitkpWcvLZXveHdpii/3zbK/Ekz/Twgkv9lgLe
	7xmsfRZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glf5N-0004Sn-Qp; Mon, 21 Jan 2019 19:18:17 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glf5G-0004S4-2b
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 19:18:15 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 lsun@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 21 Jan 2019 21:18:02 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
 by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x0LJHxvI027731;
 Mon, 21 Jan 2019 14:17:59 -0500
Received: (from lsun@localhost)
 by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x0LJHvK8001039;
 Mon, 21 Jan 2019 14:17:57 -0500
From: Liming Sun <lsun@mellanox.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 David Woods <dwoods@mellanox.com>, Robin Murphy <robin.murphy@arm.com>,
 arm-soc <arm@kernel.org>
Subject: [PATCH v7 0/9] Mellanox BlueField ARM SoC Rshim driver
Date: Mon, 21 Jan 2019 14:17:48 -0500
Message-Id: <1548098268-982-1-git-send-email-lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_111810_543283_F84B7220 
X-CRM114-Status: GOOD (  16.11  )
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
Cc: devicetree@vger.kernel.org, Liming Sun <lsun@mellanox.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series implements Linux driver support for the Rshim
component on Mellanox BlueField ARM SoC.

1. Overview of the Rshim component

The Rshim component provides a connection among different other
components of the SoC and can be accessed externally via USB or
PCIe. USB access is available on standard appliance and SmartNIC.
PCIe access is for SmartNIC only.

From user perspective, Rshim provides the following
functionalities.

1.1 Boot FIFO

  The Boot FIFO is polled by the boot ROM. At a later booting
  phase it's read by UEFI as well to load the Linux kernel.

  The Boot FIFO is a one-way direction FIFO. The data could
  come from different sources.

    a) On-chip eMMC, which is the default configuration.

      After chip reset, HW will generate eMMC commands, which
      triggers the boot stream on the eMMC boot partition to show
      up in Boot FIFO.

      This one doesn't need any Linux driver.

    b) Injected externally from USB or PCIe.

      External host could overwrite the boot mode and inject
      boot stream into the Boot FIFO over USB or PCIe. It's
      used in board bring-up, fault recovering or debugging.

      This one usually needs driver support in the external host.

1.2 TmFifo

  TmFifo are FIFOs which can be used for communication between
  the SoC ARM core and the external side. Each direction has its
  own FIFO.

  TmFifo needs driver support on both the SoC side and the
  external host side.

1.3 Rshim register space access

  Rshim register space could be accessed externally via
  USB or PCIe. It's used for configuration, debugging, etc.
  More specifically, it could be used to access the ARM
  CoreSight component which could do on-chip debugging,
  such as for boot loader, drivers, or crash information
  collection.

  This one needs driver support from external host.

2. Driver Introduction

  This patch series provides several drivers.

  *) Patch 1/9 ~ 4/9 (tmfifo.c, tmfifo_regs.h, Kconfig, Makefile)

    They provide Linux driver support for the TmFifo on the
    SoC side (see above 1.2).

  *) Patch 5/9 ~ 9/9

    They provide Linux driver support for the external host.

    - Patch 5/9 (rshim.c, rshim.h, rshim_regs.h, Makefile)

      It provides common functionalities and register access
      to the RShim component. Several character devices are
      created like below for easy user-access.

      /dev/rshim<N>/boot 

        This device file is used to inject boot stream into
        the Boot FIFO, such as
              'cat boot-image > /dev/rshim<N>/boot'
        This one is to implement the above function 1.1.b

      /dev/rshim<N>/rshim

        This device file is used to access Rshim register
        space like a plat file.

      /dev/rshim<N>/console

        This device file is used to access the virtual
        console to the SoC via the TmFifo (see above
        functionality 1.2). It can be used by any standard tools
        like minicom, screen, etc.

    - Patch 6/9 (rshim_net.c)

      This patch provides virtual networking support over
      the Rshim TmFifo (see above functionality 1.2).

    - Patch 7/9 (rshim_usb.c)

      This is the USB backend driver, which implements the
      details to access the RShim component via USB. It supports
      endpoints, USB bulk-transfer and interrupts. After loaded
      by ACPI, it triggers the loading of the common driver
      and network driver, and provides low-level APIs to the
      common driver.

      Below is an example of the networking calling stack.

      Linux Network Stack --> virtio_net --> rshim_net -->
      rshim common driver --> rshim USB backend driver

    - Patch 8/9 (rshim_pcie.c)

      This is the PCIe backend driver, which implements the
      details to access the RShim component via PCIe when
      the HCA firmware is ready. In such case, the Rshim component
      is exposed as a standard PCIe PF and it's register space
      can be mapped in BAR0.

      Linux Network Stack --> virtio_net --> rshim_net -->
      rshim common driver --> rshim PCIe backend driver

   - Patch 9/9 (rshim_pcie_lf.c)

     Similarly, this is another PCIe backend driver, but provides
     slow access when the HCA firmware is not ready. In such as,
     the BAR0 mapping is not available. The Rshim register access
     is done via a slow access gateway. The below calling stack
     is also similar.

      Linux Network Stack --> virtio_net --> rshim_net -->
      rshim common driver --> rshim PCIe livefish backend driver

Liming Sun (9):
  soc: Add TmFifo driver for Mellanox BlueField Soc
  arm64: Add Mellanox BlueField SoC config option
  dt-bindings: soc: Add TmFifo binding for Mellanox BlueField SoC
  MAINTAINERS: Add entry for Mellanox Bluefield Soc
  soc: mellanox: host: Add the common host side Rshim driver
  soc: mellanox: host: Add networking support over Rshim
  soc: mellanox: host: Add the Rshim USB backend driver
  soc: mellanox: host: Add the Rshim PCIe backend driver
  soc: mellanox: host: Add the Rshim PCIe live-fish backend driver

 .../devicetree/bindings/soc/mellanox/tmfifo.txt    |   23 +
 MAINTAINERS                                        |    8 +
 arch/arm64/Kconfig.platforms                       |    6 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/mellanox/Kconfig                       |   26 +
 drivers/soc/mellanox/Makefile                      |    6 +
 drivers/soc/mellanox/host/Makefile                 |    2 +
 drivers/soc/mellanox/host/rshim.c                  | 2673 ++++++++++++++++++++
 drivers/soc/mellanox/host/rshim.h                  |  361 +++
 drivers/soc/mellanox/host/rshim_net.c              |  834 ++++++
 drivers/soc/mellanox/host/rshim_pcie.c             |  478 ++++
 drivers/soc/mellanox/host/rshim_pcie_lf.c          |  695 +++++
 drivers/soc/mellanox/host/rshim_regs.h             |  152 ++
 drivers/soc/mellanox/host/rshim_usb.c              | 1035 ++++++++
 drivers/soc/mellanox/tmfifo.c                      | 1244 +++++++++
 drivers/soc/mellanox/tmfifo_regs.h                 |   76 +
 18 files changed, 7622 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
 create mode 100644 drivers/soc/mellanox/Kconfig
 create mode 100644 drivers/soc/mellanox/Makefile
 create mode 100644 drivers/soc/mellanox/host/Makefile
 create mode 100644 drivers/soc/mellanox/host/rshim.c
 create mode 100644 drivers/soc/mellanox/host/rshim.h
 create mode 100644 drivers/soc/mellanox/host/rshim_net.c
 create mode 100644 drivers/soc/mellanox/host/rshim_pcie.c
 create mode 100644 drivers/soc/mellanox/host/rshim_pcie_lf.c
 create mode 100644 drivers/soc/mellanox/host/rshim_regs.h
 create mode 100644 drivers/soc/mellanox/host/rshim_usb.c
 create mode 100644 drivers/soc/mellanox/tmfifo.c
 create mode 100644 drivers/soc/mellanox/tmfifo_regs.h

-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
