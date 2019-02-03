Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DB3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:30:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79582177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="srLGwnGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79582177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hi+pkumlDJQsKz4oH/QbpmyaIV/cPTx1VzKTuxYqvcc=; b=srLGwnGUi+2tFR
	FKOzyl4JuxQbZgNBDcI2j0VfaYrKxz4jKh2p3UhEacE/JJ5zeeOJd/xZDoiqoLX6/ZhZ2L4ybrx7x
	/UFGsDKYfbpkNLHxABDjWGlRfsMhlEhB4ouh9F6tMtMt19j9epx5r/BbSc1phoUsrRrffB2PMAFEE
	3ajrIzKlCc6jxGPUVHdj8O38fi/4tn6IyraG1+AQWUnePmkB55zd5aDVXMrVeolQh1YIf3bpx8ySy
	Ytd8NO2+hcuQR3mKSyWk/0gEYapthqyV8myNIq9xoZdmZlbhhBiYBCWKgA6eHrecZTALUaYxm584j
	of1FJTG3Ly2U6HFiYZIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPLF-0004KM-NP; Sun, 03 Feb 2019 21:30:17 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPKi-0003Ip-JN
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:29:48 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 2A44643EF9C;
 Sun,  3 Feb 2019 21:29:40 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Kevin Hilman <khilman@baylibre.com>, arm@kernel.org
Subject: [GIT PULL 2/3] ARM: dts: NXP LPC32xx and LPC18xx/LPC43xx changes for
 5.1
Date: Sun,  3 Feb 2019 23:29:35 +0200
Message-Id: <20190203212936.17053-2-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203212936.17053-1-vz@mleia.com>
References: <20190203212936.17053-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190203_212940_195044_17E18460 
X-CRM114-Status: GOOD (  14.99  )
/bin/ln: failed to access
 'reaver_cache/texts/20190203_212940_195044_17E18460': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_212940_195044_17E18460 
X-CRM114-Status: GOOD (  13.15  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof and Kevin,

please consider to pull the updates to NXP LPC32xx and NXP LPC18xx/LPC32xx
board devicetree files, added support of one LPC4357 devkit board and
now proper description and usage of PL111 controller can be found on both
LPC32xx and LPC18xx/LPC43xx platforms.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/vzapolskiy/linux-lpc32xx tags/lpc32xx-dt-for-5.1

for you to fetch changes up to 0293adf76ae96cea6e1690e79d9912c690bccde3:

  ARM: dts: lpc32xx: ea3250: beautify gpio keys children nodes (2019-02-03 21:37:43 +0200)

----------------------------------------------------------------
ARM: lpc32xx: devicetree updates for v5.1

Here are the changes for ARM NXP LPC32xx and ARM NXP LPC18xx/LPC43xx
devicetree files:

* added dts file for MYIR Tech MYD-LPC4357 development board,
* two missing properties are added to LPC32xx keypad controller device
  tree node, this fixes a long-standing problem with its initialization,
* LPC32xx PL11x LCD controller device node got corrected properties,
  which allows to use it with a new PL11x DRM driver,
* output voltage level on one of Phytec phyCORE-LPC3250 fixed regulators
  is corrected, the fix is needed to remove duplicating platform data,
* Phytec phyCORE-LPC3250 board gets a description of a kit LCD panel,
  this completes setup of CLCD device tree node for the board,
* added unit addresses to memory device nodes on EA and Phytec boards,
* fixes of ordinary warnings in dts formatting like leading zeroes,
  unused address and size cell properties and so on.

----------------------------------------------------------------
Mathieu Malaterre (1):
      ARM: dts: lpc32xx: Remove leading 0x and 0s from bindings notation

Vladimir Zapolskiy (12):
      ARM: dts: lpc435x: remove address and size cells from gpio-keys-polled nodes
      ARM: dts: Add DT for MYIR Tech MYD-LPC4357 Development Board
      ARM: dts: lpc32xx: add required clocks property to keypad device node
      ARM: dts: lpc32xx: reparent keypad controller to SIC1
      ARM: dts: lpc32xx: fix ARM PrimeCell LCD controller variant
      ARM: dts: lpc32xx: fix ARM PrimeCell LCD controller clocks property
      ARM: dts: lpc32xx: phy3250: fix SD card regulator voltage
      ARM: dts: lpc32xx: phy3250: remove regulators umbrella device node
      ARM: dts: lpc32xx: phy3250: setup LCD controller to panel interface
      ARM: dts: lpc32xx: phy3250: add unit address to memory device node
      ARM: dts: lpc32xx: ea3250: add unit address to memory device node
      ARM: dts: lpc32xx: ea3250: beautify gpio keys children nodes

 arch/arm/boot/dts/Makefile                  |   3 +-
 arch/arm/boot/dts/lpc3250-ea3250.dts        |  20 +-
 arch/arm/boot/dts/lpc3250-phy3250.dts       |  87 +++--
 arch/arm/boot/dts/lpc32xx.dtsi              |  28 +-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    |   2 -
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts |   2 -
 arch/arm/boot/dts/lpc4357-myd-lpc4357.dts   | 619 ++++++++++++++++++++++++++++++++++++
 7 files changed, 701 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm/boot/dts/lpc4357-myd-lpc4357.dts

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
