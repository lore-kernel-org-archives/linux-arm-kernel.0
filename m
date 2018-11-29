Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E675C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:58:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E3921104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFyELzGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E3921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a5eTdDi8QpFUhHU1s2yUGeTDYdw3VugQQzwrU/cWXbk=; b=rFyELzGbr8/BXW
	2FYIw50ym2CIy/SLyo4N+r6H+YRKoQYEn0NqRWz3NZG21TVBlVaruIEKdJHbi13g82VPiDiAVLKlk
	R+/2A/EpCU+dIwfYAQRhIdbbOCtlAXich0LtLQBNML3UX53wZgi0jkzdcY5LxDCakL1znzRaaBiHC
	hszzwqMlcvkF5D4XylihcYpNNailOYi2UYOv9l+fjaJ8mcJh6tnntXD9GhNtGZ8CQQgywr5lOPoOF
	2Gj+pcDX+cT1RVOkx3dQvODnyzG0BE5pxsl4lIASuUvxGHSgYcEyAC4j7xBMl+HSlAJUCtLBnZQD2
	kgSru6g0IFFVn11SJlhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSRz-00044v-0G; Thu, 29 Nov 2018 19:58:15 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSRm-0003wD-Io
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 19:58:04 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 36F6F8171;
 Thu, 29 Nov 2018 19:57:59 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL 2/4] driver changes for omaps for v4.21
Date: Thu, 29 Nov 2018 11:57:41 -0800
Message-Id: <pull-1543521343-338334@atomide.com-2>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <pull-1543521343-338334@atomide.com>
References: <pull-1543521343-338334@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_115802_654010_617A982A 
X-CRM114-Status: GOOD (  10.61  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/driver-signed

for you to fetch changes up to 3be5e10daf1fc063ec5cff3cd785c4a59814af0b:

  Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver (2018-11-29 11:39:23 -0800)

----------------------------------------------------------------
Driver changes for omaps for v4.21 merge window

Few SoC related driver changes to add PRCM as the wake-up source
for wkup_m3_ipc driver, and to improve ti-sysc driver for dra7
mcasp and device detection when debug is enabled.

There is also a non-critical fix for ti-sysc to fix handling of
the optional clocks but this can wait for the merge window no problem.

----------------------------------------------------------------
Keerthy (1):
      soc: ti: wkup_m3: Add PRCM int16 as the wake up source

Tony Lindgren (4):
      bus: ti-sysc: Fix getting optional clocks in clock_roles
      bus: ti-sysc: Add mcasp optional clocks flag
      bus: ti-sysc: Detect devices for debug on omap5
      Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver

 Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
 drivers/bus/ti-sysc.c                             | 23 +++++++++++++++++++++--
 drivers/soc/ti/wkup_m3_ipc.c                      |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
