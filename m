Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE63C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:00:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF33E214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J3ermO93";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="VM39sy+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF33E214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6AGg8NMRewaDUzih7mOc/q2H8VesBGxkBwjMrLoeuok=; b=J3e
	rmO93xJIonGQ9myREB5LeaNmVNJhRIaOeCAkYnOIBXfmoY+nGlZ7Z/rjBNdAhlsUWzEXHMZ4qRbUj
	MRM0t6OOs74aAb1h0ZsVi9TdsZWuCmIvqn4OyPh4faHhYyY2GN3v/9bpPgSTnPlC/mpMwR/a8x2Hh
	3Sn2ZTJmwTK9Jk026UjiO85lr+wA6x9oocu+jTGPRiEccO4nDv3J4RjBAqNcO50d8m7znfICa96ht
	fBOGszS8vznd3TnR4zRo5R8CfYWcfIO6UdbEoHMpOQeYrN6dFy0tfXJYwsO97AnrkrmW/208zTh23
	1Eu0PuhpF/unHFfF1MRWLdDu7wHR/qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1gb-0001BN-KR; Thu, 06 Dec 2018 21:59:57 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1gE-00077Q-QO
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:59:53 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 5B24425B74E;
 Fri,  7 Dec 2018 08:58:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133510; bh=D3XumfhYNHI7AzaZkqqczDx92qjs6DZfcCQPjL3TGhk=;
 h=From:To:Cc:Subject:Date:From;
 b=VM39sy+Kg1z0YMzyy8Z4zPometXVJ1xS2XQiYn5Lbw04FJlNhEvmIwCp24uP1OZby
 GRS/O4dFo05nRxpU/GJI/N/QjiIVO9fVos3CK4v8IvaU21wH4yf8hevOLydqieTTuz
 8SD4u/inFFMoePw24UiZTZmRdPNEfNM0ZD3urx2M=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 222D2E21700; Thu,  6 Dec 2018 13:58:29 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.21
Date: Thu,  6 Dec 2018 13:58:23 -0800
Message-Id: <cover.1544125558.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_135935_633569_C2543DAC 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.21.

This pull request is based on the previous round of
such requests, tagged as renesas-arm-dt-for-v4.21,
which you have already pulled.


The following changes since commit 673df60a880f060e3e94920c7b5f7a9ed8aa65f2:

  ARM: dts: r9a06g032: Correct the GIC DT node name (2018-11-28 13:55:30 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt2-for-v4.21

for you to fetch changes up to e259e04748e2798a747d9c363ded50514b15a7b9:

  ARM: dts: r8a7744-iwg20m: Add SPI NOR support (2018-12-05 11:52:46 -0800)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.21

* RZ/G1N (r8a7744) SoC
  - Describe in DT: SYS-DMAC, GPIO, Ethernet AVB, SMP, [H]SCIF{A|B},
    I2C, USB 2.0 and 3.0 hosts, USB-DMAC, HSUSB, RWDT, Audio, CAN, IRQC,
    thermal, CMT, VIN, VSP, IPMMU, PMU, TPU, QSPI MSIOF, and PCIE
  - iWave G20D-Q7 board
    - Initial support
    - Enable eMMC, SDHI and SPIO NOR support
  - Add camera daughterboard

* RZ/G1M (r8a7743) SoC
  - Remove legacy "renesas,rcar-thermal" compatibility

----------------------------------------------------------------
Biju Das (33):
      ARM: dts: r8a7744-iwg20m: Add iWave RZ/G1N Qseven SOM
      ARM: dts: r8a7744: Initial SoC device tree
      ARM: dts: r8a7744-iwg20d-q7: Add support for iWave G20D-Q7 board based on RZ/G1N
      ARM: dts: r8a7744: Add SYS-DMAC support
      ARM: dts: r8a7744: Add GPIO support
      ARM: dts: r8a7744: Add Ethernet AVB support
      ARM: dts: r8a7744: Add SMP support
      ARM: dts: r8a7744: Add [H]SCIF{A|B} support
      ARM: dts: r8a7744: Add I2C and IIC support
      ARM: dts: r8a7744: Add SDHI nodes
      ARM: dts: r8a7744: Add MMC node
      ARM: dts: r8a7744-iwg20m: Add eMMC support
      ARM: dts: r8a7744-iwg20m: Enable SDHI0 controller
      ARM: dts: r8a7744: USB 2.0 host support
      ARM: dts: r8a7744: Add USB-DMAC and HSUSB device nodes
      ARM: dts: r8a7744: Add RWDT node
      ARM: dts: r8a7744: Add audio support
      ARM: dts: r8a7744: Add CAN support
      ARM: dts: r8a7744: Add IRQC support
      ARM: dts: r8a7744: Add thermal device to DT
      ARM: dts: r8a7744: Add CMT SoC specific support
      ARM: dts: r8a7744: add VIN dt support
      ARM: dts: r8a7744: Add VSP support
      ARM: dts: r8a7744: Add IPMMU DT nodes
      ARM: dts: r8a7744: Add PWM SoC support
      ARM: dts: r8a7744: Add TPU support
      ARM: dts: r8a7744-iwg20d-q7-dbcm-ca: Add device tree for camera DB
      ARM: dts: r8a7744: Add QSPI support
      ARM: dts: r8a7744: Add MSIOF[012] support
      ARM: dts: r8a7744: Add xhci support
      ARM: dts: r8a7744: Add PCIe Controller device node
      ARM: dts: iwg20d-q7-common: Move cmt/rwdt node out of RZ/G1M SOM
      ARM: dts: r8a7744-iwg20m: Add SPI NOR support

Geert Uytterhoeven (1):
      ARM: dts: r8a7743: Remove legacy "renesas,rcar-thermal" compatibility

 arch/arm/boot/dts/Makefile                      |    2 +
 arch/arm/boot/dts/iwg20d-q7-common.dtsi         |    9 +
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi           |    9 -
 arch/arm/boot/dts/r8a7743.dtsi                  |    3 +-
 arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts |   17 +
 arch/arm/boot/dts/r8a7744-iwg20d-q7.dts         |   15 +
 arch/arm/boot/dts/r8a7744-iwg20m.dtsi           |   90 ++
 arch/arm/boot/dts/r8a7744.dtsi                  | 1741 +++++++++++++++++++++++
 8 files changed, 1875 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20d-q7.dts
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20m.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7744.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
