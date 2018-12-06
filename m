Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:58:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF1720838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j7JOhrvb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="j+8eVMpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF1720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qGjpFmIQDgtwj6GBuBTxSytNoOzXrFBTzRhBnHzo/q0=; b=j7J
	Ohrvbnlo0I8ubdH7qyTqDzzwKq43XyWJyOTtBi9FIQf3hqMxhnACtqGKSxeJWHCNyJuL+gnGDN1zc
	gORi/rscm7ioWkEZrylvVoqZki6F1Eq2UnqGy3pqwRS607pgh6iFyXtVoNzCU/T0s5tzzOAaZLwz3
	DLVOgVrX57ooxf+ux8YmpBP7UrxQnoaz2whx4Gx875Hq4LysoK4woDnkZV74C4mcGPql/o1P/X1Js
	HO70GkRvkicWo4BMlZ8eE4YPV7sIGOXNpxuYdgbrXa6kJmSdFN/dxARSEF9mr/KBlhtNMPo/htf/+
	8chfNvqHssltq26ar/lS54bY04TCI4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1fN-0008IB-NA; Thu, 06 Dec 2018 21:58:41 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1ea-00077Q-HB
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:58:02 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id D33F425BECF;
 Fri,  7 Dec 2018 08:57:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133456; bh=8Yh73XKA8sbEAETANGj/dwJOQUxNsQYpMPv9H94dLG8=;
 h=From:To:Cc:Subject:Date:From;
 b=j+8eVMpcSUBxmGpoFALPCduzLgYEeECk5UcFpATPIUSJcZ1ZnQg/GBme+UI5YRYcj
 D6h705qRnKo3yZYwY2b8LkIV+n6v+nzz6B2La21KzBF23iCgIyW4gw4Q4K/1qBoRce
 9rYy5Fga2lIfgS+HWBOD+oJSXnhaeaDqxXFr1Ak0=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 41AFFE21700; Thu,  6 Dec 2018 13:57:32 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.21
Date: Thu,  6 Dec 2018 13:57:30 -0800
Message-Id: <cover.1544126426.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_135752_962531_5A325E27 
X-CRM114-Status: GOOD (  10.84  )
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

Please consider these second round of Renesas ARM64 based SoC DT updates
for v4.21.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.21,
which you have already pulled.


The following changes since commit 275e4eb3f21a09b6b8bd4a353b9a01e500240385:

  arm64: dts: renesas: Add all CPUs in cooling maps (2018-11-26 09:11:44 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.21

for you to fetch changes up to 4fbd4158fe8967e9296516ebae2cfaf7a1c7a214:

  arm64: dts: renesas: r8a77995: draak: Add backlight (2018-12-05 11:45:44 -0800)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.21

* R-Car D3 (r8a77995) SoC based Draak board
  - Add the backlight device for the LVDS1 output

* R-Car H3 (r8a7795) ES1.0 SoC
  - Add missing power domains to IPMMU nodes

* R-Car M3-N (r8a77965) SoC
  - Remove non-existent IPMMU-IR

----------------------------------------------------------------
Geert Uytterhoeven (2):
      arm64: dts: renesas: r8a77965: Remove non-existent IPMMU-IR
      arm64: dts: renesas: r8a7795-es1: Add missing power domains to IPMMU nodes

Laurent Pinchart (1):
      arm64: dts: renesas: r8a77995: draak: Add backlight

 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi   |  2 ++
 arch/arm64/boot/dts/renesas/r8a77965.dtsi      |  8 --------
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+), 8 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
