Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD377C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:25:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F06C20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NLT1Tv98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F06C20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mby4AcMoiyktmmKCmTLYZQIB1H6tyBJqv6wJXZ7y4ak=; b=NLT1Tv989TdFZz
	ty7MLF3QXbb95rSrk+93Yi41+fYnk+G9y7frGsZERfVlHxnJ4/dj997kbOhKseFSO5rN2aF2h+0TX
	8P8Z9BQcHTXBA1h9n+xQMIMvHiZUmm9Vh9aO4yFtvisiRF8o2QQd2/CpH5m2TZYoR/ThBnI1zOimy
	bK8OZy7r3M49Z1oz6Xh3hBlePkVewcUHutut8i4f4vefOp//AdMd/5vvJlj6r+haA0hpq9wXJB/iO
	qfEizAuEQqFUl8/ADOsUZsG6iaVQhVCdGZVhjfoX6TN32dkuHTtfRPIxOFlBN6SQ/2ngSZlvvXBGH
	HlfVbAwedSfYNzDnJ7AQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF9P-00042L-4S; Thu, 31 Jan 2019 16:25:15 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF8R-00033b-CH
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:24:16 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id BF122809F;
 Thu, 31 Jan 2019 16:24:23 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL 3/3] dts changes for omaps for v5.1
Date: Thu, 31 Jan 2019 08:23:56 -0800
Message-Id: <pull-1548951676-587288@atomide.com-3>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <pull-1548951676-587288@atomide.com>
References: <pull-1548951676-587288@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_082415_455901_917789B9 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-signed

for you to fetch changes up to b4c30df0eb354d8e081132b7b7449f6d17619614:

  ARM: dts: omap4-sdp: Make ethernet working even if booted with latest u-boot (2019-01-24 08:23:43 -0800)

----------------------------------------------------------------
dts updates for omap variants for v5.1 merge window

This series contains board specific dts updates and few minor
clean-up changes:

- add stdout-path for am335x-chiliboard

- add wlcore wakeirq for omap3-evm, pandaboard and omap4-droid4

- remove unnecessary address-cells and io-cells for am33xx

- replace deprecated linux,wakeup with wakeup-source property

- use spdx license for am335x-shc

- configure ethernet pins for omap4-sdp

----------------------------------------------------------------
Felix Brack (1):
      ARM: dts: am33xx: Remove unnecessary properties

Heiko Schocher (1):
      ARM: dts: am335x-shc.dts: Switch to SPDX identifier

Marcin Niestroj (1):
      ARM: dts: am335x-chiliboard: Add stdout-path property

Peter Ujfalusi (1):
      ARM: dts: omap4-sdp: Make ethernet working even if booted with latest u-boot

Sudeep Holla (1):
      ARM: dts: am437x: replace linux,wakeup with wakeup-source property

Tony Lindgren (4):
      ARM: dts: Add wlcore wakeirq for omap3-evm
      ARM: dts: Configure wlcore wakeirq for pandaboard
      ARM: dts: omap4-droid4: Configure wlcore wakeirq
      Merge branch 'omap-for-v4.21/dt' into omap-for-v5.1/dt

 arch/arm/boot/dts/am335x-chiliboard.dts           |  4 +++
 arch/arm/boot/dts/am335x-shc.dts                  |  4 +--
 arch/arm/boot/dts/am33xx-l4.dtsi                  |  2 --
 arch/arm/boot/dts/am437x-gp-evm.dts               |  2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi           |  7 ++++--
 arch/arm/boot/dts/omap3-evm-processor-common.dtsi | 10 +++++++-
 arch/arm/boot/dts/omap4-droid4-xt894.dts          | 10 +++++---
 arch/arm/boot/dts/omap4-panda-common.dtsi         |  6 +++--
 arch/arm/boot/dts/omap4-sdp.dts                   | 30 +++++++++++++++++++++++
 9 files changed, 61 insertions(+), 14 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
