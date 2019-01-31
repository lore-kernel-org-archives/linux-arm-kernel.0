Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43601C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:45:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B788218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pHnUDM1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B788218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=D1+r0M50LSI3P4j8et7mjQI77CybkotIRFGeFbdVSpg=; b=pHnUDM1HCbdBb9
	hBEdbJRLzH+NVajaDl2bPzKaD8b+O+Iz+Ey1pJP09DmBiXACUyki1TnmnnGoNSiwSL6/7Wf+cgRyH
	lUWjwPvJOpQXeAc0EkiZ6xCG1H9/Zdr/XCUKh1NkzfuKmjcOxmdeLQK9qSnfcOyS9CaikfXFEQiG6
	msNkyXhE+jlyBTr7rmMsTc9GH096NCkw/j/pSQvY49MgkoDc6ASp6cSyyTlKXNnPll0MFcWoEVDoG
	LPUP0f6h80za3R/xuCelKTrPTYa7YRQ63/FQcRek2qBAxqAhF1xaHQW0HdgyITK2bQmFpPfmE4Kof
	mWfxCqVBONYwoyeSl38A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpEWX-00057r-6i; Thu, 31 Jan 2019 15:45:05 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpEWI-00057V-Lw
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:44:52 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 6EF97809F;
 Thu, 31 Jan 2019 15:44:55 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] omap soc regression fixes for v5.0-rc cycle
Date: Thu, 31 Jan 2019 07:44:37 -0800
Message-Id: <pull-1548949376-511005@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_074450_759814_B03AC88B 
X-CRM114-Status: GOOD (  10.74  )
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
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 063c20e12f8bbbc10cabc2413606b140085beb62:

  ARM: dts: am335x-shc.dts: fix wrong cd pin level (2019-01-23 16:14:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc4

for you to fetch changes up to dc30e70391376ba3987aeb856ae6d9c0706534f1:

  ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized (2019-01-29 08:54:22 -0800)

----------------------------------------------------------------
SoC fixes for omaps for v5.0-rc cycle

This series contains two SoC regression fixes and one uninitialized
variable fix:

- Fix inverted nirq pin handling for omap5 that started producing
  warnings with earlier GIC direction checks and took a while to
  understand and confirm. Basically there are two sys_nirq pins
  that are bypassing peripheral modules and inverted automatically
  by the SoC and need to be handled with a custom irq_set_type()

- Recent ti-sysc changes caused a regression to the pwm-omap-dmtimer
  code where the device tree handling code for timer source clock
  gets confused. It looks like we can remove that code eventually,
  but for now we just drop a bogus pm_runtime_irq_safe() for the
  timers with the related quirks caused by pm_runtime_irq_safe(),
  and have the standard assigned-clocks and assigned-clock-parents
  deal with setting the source clock

- Fix potentially uninitialized value for display init code if
  regmap_read() fails

----------------------------------------------------------------
Tony Lindgren (5):
      clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
      ARM: OMAP5+: Fix inverted nirq pin interrupts with irq_set_type
      bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
      ARM: dts: Configure clock parent for pwm vibra
      Merge branch 'pwm-dmtimer-fixes' into omap-for-v5.0/fixes-v2

Yizhuo (1):
      ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized

 arch/arm/boot/dts/omap4-droid4-xt894.dts  | 11 ++++++++++
 arch/arm/boot/dts/omap5-board-common.dtsi |  9 +++++---
 arch/arm/boot/dts/omap5-cm-t54.dts        | 12 ++++++++++-
 arch/arm/mach-omap2/display.c             |  7 +++++-
 arch/arm/mach-omap2/omap-wakeupgen.c      | 36 ++++++++++++++++++++++++++++++-
 drivers/bus/ti-sysc.c                     |  6 +++---
 drivers/clocksource/timer-ti-dm.c         |  5 ++++-
 7 files changed, 76 insertions(+), 10 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
