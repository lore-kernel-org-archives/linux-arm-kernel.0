Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFFC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B172082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XgHx78Vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B172082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JsdbwYg/2OzlDayIK8t7DuZ//8tFZWaNVZxQSnds9OE=; b=XgHx78VdA3RESZ
	xa3zXldZGrg5lrGKnyQaTtj9bJSFlCsoRRIoiA/fKTIhFA56cbQzBXCcqkvuCoLc0Kx6Ag+3rXwcX
	YqoV1g9EpkrorNKOX5Jd050ZQYpCmit9HaWGM2Rlvl3fIWRP/eqkWJ1v92VUanG/1CCeJl1131FOx
	mytGRrju1ii0+JmYViXPFXmZEZ1lkvSfwb7FpJ1ztGkT4wthHyPUejbZdEASrosaZmtWYyOOc1MQ4
	5ppA3p68sJnOfaFyDcaurVzuYxeKSwCT+y8joDhK4lxH53DhNu9GttS+Ez/f46MZFDDFw2z36aCQq
	x61uO7dBWqN0v7asYsKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSRb1-0008M6-Q4; Thu, 29 Nov 2018 19:03:31 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSRax-0008Kb-Vf
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 19:03:29 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 312AF80EA;
 Thu, 29 Nov 2018 19:03:18 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] few minor fixes for omaps for v4.20-rc cycle
Date: Thu, 29 Nov 2018 11:03:07 -0800
Message-Id: <pull-1543518110-786840@atomide.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_110328_059282_E9A6B1A2 
X-CRM114-Status: UNSURE (   9.39  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/fixes-rc4

for you to fetch changes up to 91e43395820baad80248987608216c35da9df65b:

  Merge branch 'fixes-dts' into omap-for-v4.20/fixes (2018-11-08 09:32:24 -0800)

----------------------------------------------------------------
Few minor fixes for omaps for v4.20-rc cycle

This set of fixes contains minor regression fixes for LogicPD dts files
for MMC pinctrl and interrupts. There is also one section annotation fix
that shows up with Clang, and a fix for an unitialized field for omap1.

----------------------------------------------------------------
Adam Ford (4):
      ARM: dts: am3517: Fix pinmuxing for CD on MMC1
      ARM: dts: LogicPD Torpedo: Fix mmc3_dat1 interrupt
      ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1
      ARM: dts: am3517-som: Fix WL127x Wifi interrupt

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Nathan Chancellor (1):
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Tony Lindgren (1):
      Merge branch 'fixes-dts' into omap-for-v4.20/fixes

 arch/arm/boot/dts/am3517-evm.dts                  | 2 +-
 arch/arm/boot/dts/am3517-som.dtsi                 | 2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi             | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 2 +-
 arch/arm/mach-omap1/board-ams-delta.c             | 3 +++
 arch/arm/mach-omap2/prm44xx.c                     | 2 +-
 6 files changed, 8 insertions(+), 5 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
