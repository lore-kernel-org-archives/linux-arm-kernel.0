Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E23AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:18:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EE121773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hG3R1+Bh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="PYgpncFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EE121773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=h9x74d7V1QcCmFF/tpYLz0AURk44eZzy3kfW35ZpPUw=; b=hG3
	R1+Bh3+7dR0EDPZvqPD8la37asP5iRowB9Fy7ItwD3HLNpRnIc02ozSfEv8HKlTh8uNhzo8eb6uSJ
	MpJEFSptG6+er3CHuF+y4Awv8ue+0av4YyQssNWqS0o9AKARDl/R4hIhJEPLSsusiUXd0sWjmocvR
	MdgHSnOLrma8X6nYQufEDm9O9pg+LH3gKEH/YfRVUBsjRPkviGwEPA413PmGY2EuWuiIgYewtOS3G
	AWIsyPfKNLcCrvtEE/OvHS34RfiLHkX3/jEYVQBGXrFRZqQjF8WsuqBCHmhQHPsEKEChTPVy1D43I
	QMXKHfby2OhTXn4lB/5p6A6UrIzQp1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXQF-0000Ey-45; Thu, 10 Jan 2019 10:18:47 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXQB-0000E8-IU
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:18:45 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 040D925B78D;
 Thu, 10 Jan 2019 21:18:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547115520; bh=Y23i0v7gKUPP3fAPAdy4Tng7j4v3/+uaD6kGZuLZxDQ=;
 h=From:To:Cc:Subject:Date:From;
 b=PYgpncFWpxQjTLw7sbBV/eNGAAtZJvpXa56ZiGZ0zIYgnV4irQNNeHa/2A5GF8VgK
 xaHglwCz7ZNuVYf7lZooMbmwA2cyf1P1kIueKnTvUDHZ49e8fLD/z54MDywkWOA9ht
 xZk4dnK5gY3FW3RXO30i2aN7i9H8+3Fdj2H0AzcI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 36B93940462; Thu, 10 Jan 2019 11:18:38 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v5.0
Date: Thu, 10 Jan 2019 11:18:15 +0100
Message-Id: <cover.1547115367.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_021843_759552_CDB29059 
X-CRM114-Status: GOOD (  10.49  )
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

Please consider these Renesas ARM based SoC fixes for v5.0.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v5.0

for you to fetch changes up to a64597227d0de5610407fcc95dc835745a53f5d0:

  soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B} (2019-01-07 14:51:51 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v5.0

Renesas SoCs:
* Fix build regressions caused by move of Kconfig symbols

RZ/G2E (r8a774c0) SoC:
* Correct initialization order of 3DG-{A,B} in SYSC driver

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: shmobile: fix build regressions

Biju Das (1):
      soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B}

 drivers/soc/renesas/Kconfig         |  2 +-
 drivers/soc/renesas/r8a774c0-sysc.c | 23 ++++-------------------
 2 files changed, 5 insertions(+), 20 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
