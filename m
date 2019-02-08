Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ACBC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:23:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69234218DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DgHk9ngq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69234218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Al8UTzrwssrVIqXdHUDrPTObTSHs8Y1L5GdCNwFFC20=; b=DgHk9ngqalWr2r
	1hHseA9tMZTqRM+gsnqA1kCun9XcdRMrOhAwEy2ie79MfOsoWt4dBe3buxOJMk8BvHVpmIkSIbIaH
	X7iMcyHU+/y1dt0huFFQ9dV4nKf13M80mk/+AsaxBdHi8mH6q9HY+WI62z95TzJwK22rbF+klRgHu
	eiJS8XLN+si96eQGuCpKfbRCoLJGF4VmNcGXLAHDk+idT/859geD2oFr47OT8IsBoXye7bTe27Ijt
	YFoJ316u3TvoAV8yUqpLPsMyTShcUuPdCs7AGxsJgpvnqBGNVxoE7pl3+9whFkdwMeyVMWXEpKj6v
	4uWjiEnLu5gAuzFWnQOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsDbs-0006ZD-Q2; Fri, 08 Feb 2019 21:22:56 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsDbo-0006Yr-T9
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 21:22:54 +0000
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 (Authenticated sender: gregory.clement@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6E894C0005;
 Fri,  8 Feb 2019 21:22:50 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 <arm@kernel.org>
Subject: [GIT PULL] ARM: mvebu: dt for v5.1 (#1)
Date: Fri, 08 Feb 2019 22:22:50 +0100
Message-ID: <87k1ia561h.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_132253_092163_5946702A 
X-CRM114-Status: UNSURE (   7.24  )
X-CRM114-Notice: Please train this message.
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

Here is the first pull request for dt for mvebu for v5.1.

Gregory

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-5.1-1

for you to fetch changes up to cb92e40411ef8a773675b522d29b6ea82e5fb8e0:

  arch: arm: dts: Remove disabled marvell,dsa properties (2019-02-08 18:22:55 +0100)

----------------------------------------------------------------
mvebu dt for 5.1 (part 1)

 - Cleanup marvell,dsa properties

----------------------------------------------------------------
Andrew Lunn (1):
      arch: arm: dts: Remove disabled marvell,dsa properties

 arch/arm/boot/dts/armada-370-rd.dts            | 42 -------------------
 arch/arm/boot/dts/armada-388-clearfog.dts      | 58 --------------------------
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts  | 47 ---------------------
 arch/arm/boot/dts/kirkwood-dir665.dts          | 47 ---------------------
 arch/arm/boot/dts/kirkwood-linksys-viper.dts   | 47 ---------------------
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 47 ---------------------
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi      | 41 ------------------
 7 files changed, 329 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
