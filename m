Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7369C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:18:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B418420663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O3ZRzFPb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="p9T7qKSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B418420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Jx3IB6YKvjQ9FLTmTBBmRNh6tH/2wIdArz5FsXBjdvo=; b=O3Z
	RzFPbfbItORtDJ1BUuzusqkIhLhmOC3TfLIkpn13gdAzrUb9wYFRdvQvZ6SwKddcweKiG5UcGb8yX
	HM6WURlh4bgdlk6a9+nFUdRn7/UX+X0OHeYc0T6VDLodygBGMfn7sKfLfb7H4MQKNL1o4ZtDUW+K6
	XNOO7Gw7H8TtceePNXtF7qXrtIKphlO9A7Wn3ySC9r4GyqX+X6j3HblZCirsYtij68EGVZUf8jlIS
	YhAhvv4IPJ9UhScb6feYFAhBa/YRheNKRWX+siVh1iGnFFS7XKVJOUrXVk0LIS+y6inx/jfEPuJMY
	ZqCx42bLSvLOSJ2a2uLSTYUD9mwOf0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomxF-0001c9-EE; Wed, 30 Jan 2019 10:18:49 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomxB-0001bL-QL
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:18:47 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 6BE7225B813;
 Wed, 30 Jan 2019 21:18:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548843522; bh=TJn1ve2SUMfaw4zfPFjSaFoAzuQ/yMXdY0pUJSNP65s=;
 h=From:To:Cc:Subject:Date:From;
 b=p9T7qKSKUP60l9Rt5v2WhX8Dq8tnd0NJN96vgSGIXPYlRoAnu2/tCvMI/nRMtYlmJ
 AichbP6iTajqtztyVn0lBATIgno8iilwGk56YjRQAP5NtThtm8sa1VaxSYuG79I+P+
 BjiPQMNb1I2hBUB1c3bN89xFzQ0+x/Yk1DlIpy4A=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id A7E2294043D; Wed, 30 Jan 2019 11:18:40 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Fixes for v5.0
Date: Wed, 30 Jan 2019 11:18:37 +0100
Message-Id: <cover.1548843393.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_021846_000067_0E3D52C1 
X-CRM114-Status: UNSURE (   9.53  )
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

Please consider these third round of Renesas ARM based SoC fixes for v5.0.

This pull request is based on the previous round of
such requests, tagged as renesas-fixes2-for-v5.0,
which I have already sent a pull-request for.


The following changes since commit 05c8478abd485507c25aa565afab604af8d8fe46:

  arm64: dts: renesas: r8a77965: Enable DMA for SCIF2 (2019-01-17 14:22:23 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes3-for-v5.0

for you to fetch changes up to 6a6a797625b5fe855bf60c798561896e311d58ce:

  ARM: dts: r8a7743: Convert to new LVDS DT bindings (2019-01-23 10:00:15 +0100)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Fixes for v5.0

* Convert to new LVDS DT bindings fixing a regression introduced in v4.17

----------------------------------------------------------------
Biju Das (1):
      ARM: dts: r8a7743: Convert to new LVDS DT bindings

 arch/arm/boot/dts/r8a7743.dtsi | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
