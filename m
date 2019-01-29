Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46CAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:59:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B482D20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OZbzJO3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B482D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9J44WTo1t/H8M/JvD4NmvwamrhKr8kL1qcJZ/i7Orj0=; b=OZb
	zJO3pG60suUdPCiC+8zIwZBwh4AyIXundCaiTRL4fjgiYgpFfDPHKx8cbTH+WUV52lkSuyRwhVdI+
	h5J/qFtPvgBmuxC3PiJw2EigSXJjW0fXrhOy9ZOf4vfyLTtDOtJlIuJ9pRhA/qz22Ox/sK1TrFe/4
	pOa95jnLGzhxPcWlIVVkJoOXTJlVQYNm9vOmgrgRO01L0jj9tqcCZnKo/yrxWdapKUIdiYVev1IPC
	Kj6DrL2lPb1CnHsaLy0ZV18gd+uDAQWPilAL/iM5HIgGFgh85ZOMi3t1zx5wqeSy+Tck0+JIBb4Br
	lVZdHuJ2c7tYobt+fuSGd1hP20i/7cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYbx-0008Kl-Ro; Tue, 29 Jan 2019 18:59:53 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYbX-0007dD-8i; Tue, 29 Jan 2019 18:59:28 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mjjvp-1hZPsD0UDD-00lEHP; Tue, 29 Jan 2019 19:54:14 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: [GIT PULL 1/3] bcm2835-dt-next-2019-01-29
Date: Tue, 29 Jan 2019 19:53:26 +0100
Message-Id: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:rcOOSYolGStfJdNcq/KlyY6sP9DYafv5w8GyaG8lzQAEVBzTkZF
 lVerjWkAPb261nFtlnVEcBWy2ccodBkxXRncG38cC6ZTyMqNDDvGMJ94Y+fDIYewYWJ4Z86
 6qeCrjAvSL3mQpCUVImyU5kR5JbMQen5nx82/98469oDo9XTwFQwFcBaSkatwEOcU349s9j
 bodJZWMDCn9nXiCWiIQ2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G4BMmLK/yXk=:tilOvnhshspNLhtEThtgke
 Y0EhHQCtAEEp6RffXePaWBzqC7CDd+SC4zGEtZ8Hle1Tmg7ZpB57Ts5zqw7aHUrAFZu1J3eiJ
 nDBfym5L9eF5BHUO+wo8ubkREKdDttwtJGlF2z5xaFP8305zefyVG9+ARKFGAq3mgCwrEQqmM
 A8euvcMHX+J4rg2202xlsmdiZHGvKe+Qoz8Rbo3PNvP76AykVcwNlY9rpdxXinUfpWF9CU5Qn
 TI0vwJsMk01f9WwqoFA4nI6aXQpZYgGHoJCFxA9iTDu7ylCrxVosoVJyDF5ehv+waTMMwaByY
 iADjfs2S77HEZtFOsb7ryaGOtHm7ZyUsPqJU/i+XDsuCnFjrH8/O6j3AUm2XXvSUDCp40G8wn
 jxwUZW8sOBTPQ3DE9ZiFIYYm/WUp2b/v4QMweKtGHFEWIqDxIAxq31o6kcYmW0WE3WIrXgREe
 HNS/Asm4RJtbTecFaXDSN5xoRCPbXTPIhekQQhNlvRkLv8GA74vlC9oBhkYiK4pCAdCFlS4bp
 F9P1BXvhlyXhMh5jc10xwVBw7gDXG2Iq508F6R2bB8UTTU8ZGnYcNWmacEchTI3+QsEfRYUl+
 464VppEwYGpxGj6mhhG5J1YI/1Wr72Q+GPhUeGErK1RY9AXNOK2D1QKqGI7j0zrODWFmZuteF
 HI0OJeFG2dH+Giv6KgYxyhwpDbbKib13KoCpbPh2i+zK8MQYCNAhEpbgDB3tOJZjeOdJQ0I5S
 Q4msLQQl3pCNgBTAAROIfDnLcD3zv8WabAWGW/I3wnjy3geUSfvUPGPiFhA=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_105927_622577_102ADF4A 
X-CRM114-Status: GOOD (  15.54  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Florian,

sorry for being that late and hoping it's not too late.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2019-01-29

for you to fetch changes up to 14117e0af4a853b2b37925f526b2bfe1cfc7b285:

  ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl (2019-01-22 07:25:59 +0100)

----------------------------------------------------------------
This pull request adds the necessary changes for the new BCM2835 PM driver,
support for the new Raspberry Pi 3 A+ and the missing GPIO labels for RPi 2/3.
Additionally it contains some minor DT fixes.

----------------------------------------------------------------
Eric Anholt (2):
      ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block. (v4)
      ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware.

Stefan Wahren (9):
      dt-bindings: bcm: Add Raspberry Pi 3 A+
      ARM: dts: add Raspberry Pi 3 A+
      ARM: dts: bcm283x: Fix DTC warning for memory node
      ARM: dts: bcm2835-rpi: Drop unnecessary #address-cells/#size-cells
      ARM: dts: bcm2835: Fix labels for GPIO 0,1
      ARM: dts: bcm2837-rpi-3-b: Use consistent label for HDMI hotplug
      ARM: dts: bcm2837-rpi-3-b-plus: Clarify label for STATUS_LED
      ARM: dts: bcm283x: Add missing GPIO line names
      ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   4 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  11 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |   4 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   8 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  68 +++++++-
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         | 175 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  74 ++++++++-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  74 ++++++++-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             |   2 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |  17 +-
 13 files changed, 415 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
