Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308A4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:10:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E442D205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iYPQ2plB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="mVW0BZyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E442D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=q9mFolTZ3NOsB4oAOO3gepDHpnIbh1lsxgWRNPhUXE8=; b=iYP
	Q2plBa5PYLCMWX3OHmMpyt8EclACxkmo3o3kHdrLBJfs3NijLcxNtfGu/6+6lFxrqrPb1WPqOAOoK
	wRBlKKBXbeuzAXLWTASgysRCHD3mJdgQa8yQeQUcDAEPppUNHhoAErQpHdB6VKeBNrW97pQomU/Ez
	bHIBIiy4MudJzpRJuitbanMlTsWH+OF4nTEqJoLIJjtiYyNv1EbJNO2E/SNRY8zAGop3v+gCCnZ8y
	1Z1Ozae2X55L+Kd0U4/NW8/UhVVwy1588avQZtT5B9Eg+e+JTJ/cZpxIJKB5v+mx6kQjXZgPvNjqi
	OQKZ/lt5Xv7VtFAx3ID8jmQ3YBquuWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1qt-0005t6-KT; Thu, 06 Dec 2018 22:10:35 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1qX-00021y-K5
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:10:32 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 01F4F25BF28;
 Fri,  7 Dec 2018 08:58:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133538; bh=dAlc/zv6PCqPi0m+Whg40PGf8etN97tJ89VqYlwtDU8=;
 h=From:To:Cc:Subject:Date:From;
 b=mVW0BZyDGD/m1u7BXXbuo207wukanFrOMVjgi1XGvHHH3oZGL5GqQaIDnLbp9sWTo
 uI0cZmhIv1Dfg7hL5DK9bwwfkwvGI7UOIKn6BFazngYpYo1eb39lfRJN/gLErUmmdb
 z2zSj07/zVibpAERWMbJe5SJfwr7dSEgL1rV0iMQ=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id C4A96E21700; Thu,  6 Dec 2018 13:58:56 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.21
Date: Thu,  6 Dec 2018 13:58:53 -0800
Message-Id: <cover.1544131943.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141014_005189_C901866A 
X-CRM114-Status: GOOD (  10.97  )
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

Please consider these Renesas ARM based SoC drivers updates for v4.21.


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.21

for you to fetch changes up to 7fc4650cc2417d7a2907a000f6f88240baa42018:

  soc: renesas: rcar-sysc: Fix power domain control after system resume (2018-12-06 12:10:10 -0800)

----------------------------------------------------------------
Renesas ARM Based SoC Drivers Updates for v4.21

SYSC Driver:
* Common
  - Fix power domain control after system resume
  - Merge PM Domain registration and linking
  - Remove rcar_sysc_power_{down,up}() helpers
* R-Car E3 (r8a77990) SoC
  - Fix initialization order of 3DG-{A,B}
* R-Car V3H (r8a77980) SoC
  - Correct A3VIP[012] power domain hierarchy
  - Correct names of A2DP[01] power domains
* R-Car V3M (r8a77970) SoC
  - Correct names of A2DP/A2CN power domains
  - emove non-existent CR7 power domain
* R-Car M3-N (r8a77965) SoC
  - Remove non-existent A3IR power domain

----------------------------------------------------------------
Geert Uytterhoeven (9):
      soc: renesas: r8a77965-sysc: Remove non-existent A3IR power domain
      soc: renesas: r8a77970-sysc: Remove non-existent CR7 power domain
      soc: renesas: r8a77970-sysc: Correct names of A2DP/A2CN power domains
      soc: renesas: r8a77980-sysc: Correct names of A2DP[01] power domains
      soc: renesas: r8a77980-sysc: Correct A3VIP[012] power domain hierarchy
      soc: renesas: r8a77990-sysc: Fix initialization order of 3DG-{A,B}
      soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down,up}() helpers
      soc: renesas: rcar-sysc: Merge PM Domain registration and linking
      soc: renesas: rcar-sysc: Fix power domain control after system resume

 drivers/soc/renesas/r8a77965-sysc.c       |  1 -
 drivers/soc/renesas/r8a77970-sysc.c       |  5 +--
 drivers/soc/renesas/r8a77980-sysc.c       | 10 ++---
 drivers/soc/renesas/r8a77990-sysc.c       | 23 ++---------
 drivers/soc/renesas/rcar-sysc.c           | 65 +++++++++----------------------
 include/dt-bindings/power/r8a77970-sysc.h |  7 ++--
 include/dt-bindings/power/r8a77980-sysc.h |  6 +--
 7 files changed, 35 insertions(+), 82 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
