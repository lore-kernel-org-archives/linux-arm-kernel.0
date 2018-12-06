Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3310AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:12:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23ED2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X1+Nsd08";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kCQiv87c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23ED2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SdI/gd3wTXJpZVl3jtxclWCyCF3HOhzLpX8k1ejJXGU=; b=X1+Nsd08INwHjMaLzGFXzSA8N2
	ShYi4ZdSH/+D82wZuYEA2hw3+DTRT4NJGCFSbKOR1+n4euPzIiGDeJB5HpnHHp0xZJIij4uaheTLT
	s0rCjKg+3xeHm5hZLWMv5ZQ7Rt3BdWhOe9y7UZrIMRbk4Ge8wKlpmX8rkgaY7jmrFqx3KrOCXTYcp
	CHYVO8Ew6JfuEnHMWT1jSGRq0IKwAJZTk2E+pF+k/SzcDnI0irmVmeGiixaUeRuUQY8uO1O3sfoqL
	SQuL3HLqDqrcjEdAlvbvm6vCF9647sn/zEzUo5mTv/je2pUhrEI016uvIUVcmC9lKFsQOXNGVnLRY
	cQAC5LUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1sk-0007ar-3W; Thu, 06 Dec 2018 22:12:30 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1rD-00021y-MW
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:10:59 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 600E625BF3A;
 Fri,  7 Dec 2018 08:58:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133539; bh=TUkUruoxqk/Ng84pVTsqir2Gg8QE1NAx9DstPcaBTfg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kCQiv87cFSHcH1LFBk1F4p+/JfnGsWbDNRBUQRU27iZPFEtU8rNEUMOvYgIh2qJh9
 vQBB0RIW7OV+b/Mu5BOzsJ6lCx0GOWLZ6m6X0saj7xX89NwDon6DVjoIi7votSHi2u
 BJmXsPoMBYqV7eRhQ0l0wxyS5M/H3DrYzZBaDW8A=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 29723E21D8B; Thu,  6 Dec 2018 13:58:58 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/9] soc: renesas: r8a77980-sysc: Correct names of A2DP[01]
 power domains
Date: Thu,  6 Dec 2018 13:58:52 -0800
Message-Id: <97473bc85b22ac610b1810b6a9a4669a6cb0b7b0.1544131943.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544131943.git.horms+renesas@verge.net.au>
References: <cover.1544131943.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141056_571204_27A26CEE 
X-CRM114-Status: UNSURE (   9.76  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The R-Car Gen3 HardWare Manual Errata for Rev. 0.80 (Feb 28, 2018)
renamed the A2PD0 and A2DP0 power domains on R-Car V3H to A2DP0 resp.
A2DP1.

As these definitions are not yet used from DT, they can just be renamed.

Fixes: 7755b40d07a8dba7 ("dt-bindings: power: add R8A77980 SYSC power domain definitions")
Fixes: 41d6d8bd8ae94ca9 ("soc: renesas: rcar-sysc: add R8A77980 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a77980-sysc.c       | 4 ++--
 include/dt-bindings/power/r8a77980-sysc.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/renesas/r8a77980-sysc.c b/drivers/soc/renesas/r8a77980-sysc.c
index 9265fb525ef3..dbb2621ce4e3 100644
--- a/drivers/soc/renesas/r8a77980-sysc.c
+++ b/drivers/soc/renesas/r8a77980-sysc.c
@@ -38,8 +38,8 @@ static const struct rcar_sysc_area r8a77980_areas[] __initconst = {
 	{ "a2sc2",	0x400, 8, R8A77980_PD_A2SC2,	R8A77980_PD_A3IR },
 	{ "a2sc3",	0x400, 9, R8A77980_PD_A2SC3,	R8A77980_PD_A3IR },
 	{ "a2sc4",	0x400, 10, R8A77980_PD_A2SC4,	R8A77980_PD_A3IR },
-	{ "a2pd0",	0x400, 11, R8A77980_PD_A2PD0,	R8A77980_PD_A3IR },
-	{ "a2pd1",	0x400, 12, R8A77980_PD_A2PD1,	R8A77980_PD_A3IR },
+	{ "a2dp0",	0x400, 11, R8A77980_PD_A2DP0,	R8A77980_PD_A3IR },
+	{ "a2dp1",	0x400, 12, R8A77980_PD_A2DP1,	R8A77980_PD_A3IR },
 	{ "a2cn",	0x400, 13, R8A77980_PD_A2CN,	R8A77980_PD_A3IR },
 	{ "a3vip",	0x2c0, 0, R8A77980_PD_A3VIP,	R8A77980_PD_ALWAYS_ON },
 	{ "a3vip1",	0x300, 0, R8A77980_PD_A3VIP1,	R8A77980_PD_A3VIP },
diff --git a/include/dt-bindings/power/r8a77980-sysc.h b/include/dt-bindings/power/r8a77980-sysc.h
index 2c90c1237725..7bebe7e8dbdb 100644
--- a/include/dt-bindings/power/r8a77980-sysc.h
+++ b/include/dt-bindings/power/r8a77980-sysc.h
@@ -15,8 +15,8 @@
 #define R8A77980_PD_A2SC2		0
 #define R8A77980_PD_A2SC3		1
 #define R8A77980_PD_A2SC4		2
-#define R8A77980_PD_A2PD0		3
-#define R8A77980_PD_A2PD1		4
+#define R8A77980_PD_A2DP0		3
+#define R8A77980_PD_A2DP1		4
 #define R8A77980_PD_CA53_CPU0		5
 #define R8A77980_PD_CA53_CPU1		6
 #define R8A77980_PD_CA53_CPU2		7
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
