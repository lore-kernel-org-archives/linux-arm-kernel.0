Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8165EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:31:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B792081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RJG1gQEa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EZb44Ks4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B792081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uDMQiLDFeMNKCqthdpKP/jlo00L8aolnA2evdboB6sw=; b=RJG1gQEa+3RMNA
	SgUd6ODpB9BMgLMsH/JiFLNSvAkjjUesXLDmYYOj/gGdE4TL1a3WGw5TCkzacyLbB24rWLVhUoBzA
	X4ElEY0IzikL/2c3m809w4ATU0NB+RWpHQz131IOk6PrQ3hI+FHFE9ddTuBgbG5QDGU3EE77eNLuQ
	youoZk40efhnRiYQBOPT9NPryp+5KtnD0DG8XF4Ic4Qy890zXg4dSOe276X3cl+K0Y8U0rxLHghU5
	PTU+y3KEyF0L47R2MG4UteSlkGRy9mne8myFWKgHupk09HFBSX/GIQIT4+MPx9616Q6Nb05Dz8Jh7
	NMp+gJm7RpCVfMvfN0Yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkwW-0006ph-Fa; Tue, 11 Dec 2018 16:31:32 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkwR-0006iW-Kk
 for linux-arm-kernel@bombadil.infradead.org; Tue, 11 Dec 2018 16:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y30KnNhYAX3iURuawkFJEt+NiFuN65O0FF5G5ETYhNQ=; b=EZb44Ks4LHFrs0EN4wyDvzngV7
 6A/2AyaXui9wj31AIIZc+Z277ZlwgQ7BV3Tu19Dx4UdHWE63gQCfbbBmDtMB5daVd3F9jQi+GdWI6
 IQkGGjj3oapwtNb6N0ZeTD4oXMMRAa5GB9oim1n0rRqzO/4xGxqsZmXDQ7kZeZfSALGqU1wwrD8Il
 4LjdI1nIpGNaRIelQBXSCE5Sis7TX0jgoFHBaZEuYLc7d9KOX0nGjQvxoSFtFqlKV3rBi6UuB/++Z
 uUfUpelXkXvI4wrbRNhyqPr3rdmKZNykZE/UjZF3CEhaJVcxCmvSnZw8hWmhPDLfvN8fY83A0ZajD
 xczJdwnA==;
Received: from muru.com ([72.249.23.125])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkR8-0008AK-Nm
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:59:07 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 9CDF78027;
 Tue, 11 Dec 2018 15:58:54 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] few device fixes for omaps for v4.20-rc cycle
Date: Tue, 11 Dec 2018 07:58:47 -0800
Message-Id: <pull-1544543892-150996@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_105906_825573_06B03FD9 
X-CRM114-Status: GOOD (  10.33  )
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

The following changes since commit 91e43395820baad80248987608216c35da9df65b:

  Merge branch 'fixes-dts' into omap-for-v4.20/fixes (2018-11-08 09:32:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/fixes-rc6

for you to fetch changes up to 84fb6c7feb1494ebb7d1ec8b95cfb7ada0264465:

  ARM: dts: Fix OMAP4430 SDP Ethernet startup (2018-12-07 09:10:49 -0800)

----------------------------------------------------------------
Few device fixes for omaps

Here's a collection of minor fixes for annoying usability issues
people have noticed using various devices.

There are two regression fixes:

- A regression fix for omap5 usb3 dual role mode

- A regression fix to ams-delta audio being muted permanently

And two one-liners:

- Fix polarity for am335x-pdu001 SD card detection

- Fix non-working omap4-sdp Ethernet startup for rebind

It would be nice to get these merged during the -rc cycle if
possible. Naturally these can all wait for the merge window too
if we start running out of time.

----------------------------------------------------------------
Felix Brack (1):
      ARM: dts: am335x-pdu001: Fix polarity of card detection input

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix audio permanently muted

Roger Quadros (1):
      ARM: dts: omap5: Fix dual-role mode on Super-Speed port

Russell King - ARM Linux (1):
      ARM: dts: Fix OMAP4430 SDP Ethernet startup

Tony Lindgren (1):
      Merge branch 'audio-fix' into omap-for-v4.20/fixes

 arch/arm/boot/dts/am335x-pdu001.dts       | 2 +-
 arch/arm/boot/dts/omap4-sdp.dts           | 1 +
 arch/arm/boot/dts/omap5-board-common.dtsi | 1 +
 arch/arm/mach-omap1/board-ams-delta.c     | 6 ++++--
 4 files changed, 7 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
