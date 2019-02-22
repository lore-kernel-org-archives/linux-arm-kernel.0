Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:15:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6903F207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FNHGzjyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6903F207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BQA5xgLyYwc3nWJrzB8ABIp6BChbMrkGKjJ27A1psQ8=; b=FNHGzjycLNFfDF
	z3A1i4xPuHxU0/neW1d2m3vIzkZ60ssyFSRcrAVo5Q1Nwu+C+Hu0utrQEMR+PIfu+ifGN/RYjQSw+
	LhF18EQSqa2cavZh97kTGKIr+VXwjpjcRJ626SoOg6Y5GelxHoii95r5tTjlI6Bj5yKNbHvByLr3r
	w8BmNd4rw4TP4KTmIZ7kYeOnw27mUyCkErQvV/jtIMYLTGN+u0LHeTcS9zpZwgedlhxM+DJHT6/48
	0Bk98b0pgyjc7Lm4JDMFUKR9uGGUcSXpT+4+4as5DOXWx0PARY3WU0EX+j5QGHmDM+/imzs+WJ77K
	PAH0wn1MOOULnVXH6tWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCXo-0005f6-LQ; Fri, 22 Feb 2019 15:15:20 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCXl-0005eO-91
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:15:18 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id C2C2D80AA;
 Fri, 22 Feb 2019 15:15:25 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] deprecate old cpsw driver phy mode for v5.1
Date: Fri, 22 Feb 2019 07:15:12 -0800
Message-Id: <pull-1550848332-146231@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_071517_392628_29C244D7 
X-CRM114-Status: UNSURE (   7.73  )
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
Cc: Tony Lindgren <tony@atomide.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit bae2bf97939aebd74dfd8f0b76b4902a19e63eef:

  dt-bindings: net: ti: deprecate cpsw-phy-sel bindings (2019-02-20 08:14:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/cpsw-signed

for you to fetch changes up to dba235fa70cbedf7dd64d5763299451be4b9de16:

  net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver (2019-02-21 07:33:51 -0800)

----------------------------------------------------------------
One change to deprecate old CPSW Ethernet PHY mode selection driver

With the device tree changes configuring CPSW with a proper PHY driver,
we want to deprecate the old driver to avoid new users for it.

Note that this driver is based on the related dts changes.

----------------------------------------------------------------
Grygorii Strashko (1):
      net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver

 drivers/net/ethernet/ti/Kconfig | 6 +++---
 drivers/net/ethernet/ti/cpsw.h  | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
