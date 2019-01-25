Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58ABC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:52:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2A121904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E2kHvfyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2A121904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4JESN3AJMXWPhmbn0bBqnEgQVxDVoY1dZU9C68H7tkc=; b=E2kHvfypS3j6YY
	BCJkR3IcfK5Q/DNUmvSNWwzA7V7fwOtDrjSRARtLSOFpl1K4XBstMn0QtDkTGb+IMXy5o1CCF6o7e
	E6l74aChVRG15b67OrxSGh1Ml+2HG1rzvgi/BmtS1zakE5Q8lUBBqoTIx2ZzgBysS1zyqlXrbUnxE
	ggumJEjrp8Gx2E4oJGWgqBs9FocUIC5+L4aLymNNKnG3h1gztm7FsXJFBA0dUrqxajxDz4kaVuLA9
	n9qQveVwvQKpgc0lz62+AaGd/jrDMYke4XOjvUPaioFS5U/0wRV411IIx+MfFuIqGstuI6QsrVgNU
	3eyGIzU42CZGBe7WmppA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4i2-00040k-Bu; Fri, 25 Jan 2019 16:52:02 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4hz-000403-Ay
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:52:00 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id AD990806C;
 Fri, 25 Jan 2019 16:52:04 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] dts fixes for omaps for v5.0-rc cycle
Date: Fri, 25 Jan 2019 08:51:49 -0800
Message-Id: <pull-1548435073-725543@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_085159_417937_0C950E52 
X-CRM114-Status: GOOD (  10.68  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc3

for you to fetch changes up to 063c20e12f8bbbc10cabc2413606b140085beb62:

  ARM: dts: am335x-shc.dts: fix wrong cd pin level (2019-01-23 16:14:33 -0800)

----------------------------------------------------------------
Device tree fixes for omaps for v5.0-rc cycle

This series of dts fixes for omap devices fixes several device specific
regressions:

- The onenand timings for n950/n9 have been wrong for a while since
  we moved to dts based timings

- A typo for the cpcap pmic is now producing erors during boot as the
  level should be 0 for unconfigurable triggering instead of 1

- Changes for ti-sysc for omap5 left uart3 with debug flags that should
  not be set

- Fix a new dtc warning started showing up for omap3-gta04 grap_port

- With the generic MMC card detection code we need to fix the gpio
  in dts for n900 and am335x-shc

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: dts: N950/N9: fix onenand timings

Arthur Demchenkov (1):
      ARM: dts: n900: fix mmc1 card detect gpio polarity

Heiko Schocher (1):
      ARM: dts: am335x-shc.dts: fix wrong cd pin level

Tony Lindgren (3):
      ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
      ARM: dts: Remove unnecessary idle flags for omap5 uart3
      ARM: dts: omap3-gta04: Fix graph_port warning

 arch/arm/boot/dts/am335x-shc.dts               |  2 +-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi             |  4 ---
 arch/arm/boot/dts/omap3-n900.dts               |  2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi           | 42 +++++++++++++++++---------
 arch/arm/boot/dts/omap5-l4.dtsi                |  2 --
 6 files changed, 31 insertions(+), 23 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
