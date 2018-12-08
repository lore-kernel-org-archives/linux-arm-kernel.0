Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40093C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:51:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B9320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZcVxhfEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B9320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free-electrons.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=58NcuvMWSMAQvjGUz9H7kr+8x3dszt3P5xyjbOiO4TM=; b=ZcVxhfEsAW2KqX
	RjxLGUyh6TKlR7y3DlFujrvOKhB4l2yMlLj4cLGTeELECdcikhXot1d9aKKptNzOdubKSC1O7A394
	eSHVnwPtMX2rHpj8OEGIgvAL+Z4IflecGQtSVPcTEO2SsrbrRpz8uSU4jestfsbjWzil7NsStMUzY
	lbAdWj/+qcaSLRqziLAvjlV7qa491W+VpUKNYL2quZmRPRufZsj/FCmIvJ6pKhXp9MCHmrdpzMqdZ
	tDlGvhuxCf20KWI0NoTxMgVJYSePxbZrOCyyZ/L7u/tf0fqCnfAYSRW4+2gwe/7nXpQyat/JStGVu
	6hPAibHZyQbv5iTiDTMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVYKe-0001M7-Jb; Sat, 08 Dec 2018 08:51:28 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVYKb-0001Lh-R2
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 08:51:27 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A807620741; Sat,  8 Dec 2018 09:51:13 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 by mail.bootlin.com (Postfix) with ESMTPSA id 76F5C20510;
 Sat,  8 Dec 2018 09:51:13 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 <arm@kernel.org>
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.21 (#1)
Date: Sat, 08 Dec 2018 09:51:14 +0100
Message-ID: <87d0qcv1tp.fsf@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_005126_008161_74BD1EB3 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.21.

I'd like to do a second pull request early next week because I saw
some other patches wich were part of driver series that could go in
4.21.

Gregory

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.21-1

for you to fetch changes up to dfc1259a3f7a116b96e23e3467607c713c38a383:

  arm64: dts: clearfog-gt-8k: describe mini-PCIe CON2 USB (2018-12-08 09:26:51 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.21 (part 1)

 - complete the description of the clearfog-gt-8k board (Armada 8040
   based board)
 - declare eMMC on espressobin (Armada 3720 based board) which still
   need to be enable by the bootloader as it is not present on all the
   board.
 - add a new version of the Macchiatobin (Armada 8040 based board): the
   Single Shot (without the 10G 3310 PHYs).

----------------------------------------------------------------
Baruch Siach (4):
      arm64: dts: clearfog-gt-8k: fix USB regulator gpio polarity
      arm64: dts: clearfog-gt-8k: 1G eth PHY reset signal
      arm64: dts: clearfog-gt-8k: enable mini-PCIe CON2 USB
      arm64: dts: clearfog-gt-8k: describe mini-PCIe CON2 USB

Ding Tao (2):
      arm64: dts: marvell: armada37xx: Add emmc/sdio pinctrl definition
      arm64: dts: marvell: armada-37xx: Enable emmc on espressobin

Russell King (1):
      arm64: dts: add support for Macchiatobin Single Shot board

 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 .../boot/dts/marvell/armada-3720-espressobin.dts   |  22 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  10 +
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |  22 +-
 .../dts/marvell/armada-8040-mcbin-singleshot.dts   |  29 ++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 333 +-------------------
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 346 +++++++++++++++++++++
 7 files changed, 433 insertions(+), 330 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
