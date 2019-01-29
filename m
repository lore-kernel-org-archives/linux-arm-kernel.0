Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A76C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:59:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87A020844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HPYg20Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87A020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bnO1gsRPrDz6TCtHExc6kFMj+3oBr4+JFXaOo7l72DA=; b=HPYg20MxkN/IP9Gae6dVS95O7b
	vN/q+f84vjB18mWxA1I+Qq5GjG4g1T6YMIqmBQ/gHn//K8IKuXWUgcYFNL7+CWsnpDntAIMgrB+Km
	hmXrNqNJ86y9T0bYD25By82ZzWPqPjpwVgKlzJqH98MIP9W8o4aBBMcIDra55Yfc1e8nyuh5VD9QS
	iCxuMuKjIA8CL0VcatN5RWiFX9Xjdc0Hrt++8WV04y4zKIMCHB8WKoxD/k+CSD1JW0kRxc4tYVvJ/
	fO08+Rpl+X06F/BBOrC9LqeluJx8ik1VWK/yKggcKLm/BeA6wGdQ9lx4DDd5ZuBj2Tobkxx7Ncfre
	eFX+2OoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYbb-0007pI-4v; Tue, 29 Jan 2019 18:59:31 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYbV-0007XW-UI; Tue, 29 Jan 2019 18:59:27 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mqrjz-1hSGzn3awj-00muIn; Tue, 29 Jan 2019 19:54:14 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: [GIT PULL 3/3] bcm2835-drivers-next-2019-01-29
Date: Tue, 29 Jan 2019 19:53:28 +0100
Message-Id: <1548788008-4733-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:tG5e4rB/ae/4LOicQ33k71HkMKgOGJQ8XE4ILJWiF9IZNMue2KO
 O95qpDJ8C1zmcXxBpZZmm4tkTDBPZlzZVSpfudiii8LYQB/IuV3k1hhT+fIUIJk+QyyPDjt
 jRqKNy9iuYrfR6AnjrbH6f/RvbsrwtL75LmIKsAwU7ahxQeVQawi5mLM18KcgudolbNcTnx
 dvfiCgYlVJoOoc04duR5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PqXSdVNfAao=:wyMUG498xc4BCmI6N684zL
 TFUqu04UZYqRQYMoXVYpMcG1xjPnaipXtLrzDCHygM1qLSxPxsf0k7yxnzzoumS1QG2CV7/O0
 LtQSlA49+JscffuHjjcvMe0qi5yFaRdxWJxPzgoOziVThNtHNd875XXsdWVnnGEMmO4nIN9SW
 WhQYqIa+JFGrw4VF/01/v+cBjVPWKcKW5Y8K2O436L4E+UcrqJPIPsKx/06JS3TWRpusXBH0z
 fIE8SwU1Bb0Ya8ajdL1m3zyAHZL7WJL3To1/ukUgQp/GmgRT2zDWpHgimtG1IGuCrJrPWh70p
 RRaosEEh47kF7cUVSi6G3v05KEa7YTO4Zw04/W/VcX21VQLqZ+sB7AYwhI94aCWvzMjV8g42G
 6MV3YgG7476gfPoIFgdwwgXdYSfalS02t/nQsvtmieKfek2rLvXIekSOfd74Qlt0lW9vWYcVc
 y7cHqGhf2KysVQzoDiRlWUyNn+63992GkWSOTLNY3iAEfCU+EUp2Ua4alBk0M2arss8aDmy4L
 o4av+vH0cCwDAJadztYvimyniHHo7gBpdCRaLuJP+coW5l33HwIjTYjPO91ai9+zOXlBzhE8C
 3wqupLY+aqEu0XvX0oEKfy6TSmkjlaZPmNa0EquyuCVhxzfOsv2xqDMSw87CXkz5oS4JKgMCI
 fnoLjx/mQNH4VVmlMfQUobhAK8CGvdCh0yxadufGyDyzFFaSprnP/rzpM3Ov/pwU7n/eAeBbl
 PUlUpWfQcGKn7Yps7hn8MZDH40x2yvp3p5kPAodSx+pWqMsvF2yA680YcEL9dcDP+JXvvsbb0
 h3UhYhMiFCrs87ym4tGpKv677IcCU0OKyih9PMScNStnRNtPZ/cFcOlYsSaqOUVFJOgYxreDb
 MC1vc6NeKCmmQwGKMtfxbt7wkXNKhccA0uNbFOlwtQ6oZbItD86dud10XpqrS4QCzwzTngrXa
 gm3wSh9EddA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_105926_285502_7798A457 
X-CRM114-Status: GOOD (  15.66  )
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

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-drivers-next-2019-01-29

for you to fetch changes up to f494caa480f7089ff9bba16dd865e190cee7e545:

  soc: bcm: Make PM driver default for BCM2835 (2019-01-24 19:19:22 +0100)

----------------------------------------------------------------
This pull request brings the new BCM2835 PM driver and a workaround to
avoid network boot failures of the Raspberry Pi 3 B+ BOOTROM.

----------------------------------------------------------------
Eric Anholt (3):
      dt-bindings: soc: Add a new binding for the BCM2835 PM node. (v4)
      bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
      soc: bcm: bcm2835-pm: Add support for power domains under a new binding.

Stefan Wahren (3):
      soc: bcm2835: sync firmware properties with downstream
      firmware: raspberrypi: notify VC4 firmware of a reboot
      soc: bcm: Make PM driver default for BCM2835

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt           |  46 ++
 arch/arm/mach-bcm/Kconfig                          |   1 +
 drivers/firmware/raspberrypi.c                     |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bcm2835-pm.c                           |  92 +++
 drivers/soc/bcm/Kconfig                            |  12 +
 drivers/soc/bcm/Makefile                           |   1 +
 drivers/soc/bcm/bcm2835-power.c                    | 661 +++++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c                     |  26 +-
 include/dt-bindings/soc/bcm2835-pm.h               |  28 +
 include/linux/mfd/bcm2835-pm.h                     |  14 +
 include/soc/bcm2835/raspberrypi-firmware.h         |   4 +
 12 files changed, 880 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/mfd/bcm2835-pm.c
 create mode 100644 drivers/soc/bcm/bcm2835-power.c
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h
 create mode 100644 include/linux/mfd/bcm2835-pm.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
