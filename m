Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A75C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C32E2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oh8u9eGS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="VORiz1kI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C32E2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3B4eoMfSUNVvzukznXdnpOq1HlUHfg+dKSQz224tTDY=; b=Oh8u9eGSphJB/aSlLkIEKJCVZm
	4Ya0jtiyC3h3ukjP0Vse2ceBmnCPi2tTCmZkeTbJW2PLPSHZfqSkOf5eEGoumYbr48JlsRWB16cpl
	YuYuIOMsfN3M6TE7giCzbj6FyL2JZlYqy4weHHhuCojIJUTFYQ8JrEyKTLn7AlHKZLZxX3dLKFOvY
	WmWu3qXwKWNde1cXzr4d1t5g/vsMABGDRmnj3AVcS00iBr73fYq39IJt6bfrMFiuYKJUjh9YopXGS
	iQDTP9TIay3AXJGRHny/oninSw8FS4fq2ICsL1PPuGg+hU96y6oBWKw1B4sn3ndTqEMp61Zg10UqN
	FVSyYWag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1rS-0006Lg-UK; Thu, 06 Dec 2018 22:11:10 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1r3-00021y-Cq
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:10:52 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 4822425BF36;
 Fri,  7 Dec 2018 08:58:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133539; bh=UFikAiueX12gEoRQmRwihrLHeOjr4JmC8FwQQIGdxK0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VORiz1kIqS+18+RArY/Jfo221barnjugV19G66hdc/VcCo992yQbN4O94UhAUAD1F
 rsdtADamhN41X5PTDusf+qHXjLhZYFemVKgSuSKuhDZWdgDiwelqA/LPczlrtPcLwT
 vUEIxMr7+ReJTfPzuxfYmBjYVrCUqPgojqhjxLy8=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 2447DE21D86; Thu,  6 Dec 2018 13:58:58 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/9] soc: renesas: r8a77970-sysc: Correct names of A2DP/A2CN
 power domains
Date: Thu,  6 Dec 2018 13:58:51 -0800
Message-Id: <b5eb730e031acaba2d25e8f522ac5966a70885ae.1544131943.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544131943.git.horms+renesas@verge.net.au>
References: <cover.1544131943.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141045_907306_24CAAD5A 
X-CRM114-Status: GOOD (  10.59  )
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
renamed the A2IR2 and A2IR3 power domains on R-Car V3M to A2DP resp.
A2CN.

As these definitions are not yet used from DT, they can just be renamed.

While at it, fix the indentation of the A3IR definition.

Fixes: 833bdb47c826a1a6 ("dt-bindings: power: add R8A77970 SYSC power domain definitions")
Fixes: bab9b2a74fe9da96 ("soc: renesas: rcar-sysc: add R8A77970 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a77970-sysc.c       | 4 ++--
 include/dt-bindings/power/r8a77970-sysc.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/renesas/r8a77970-sysc.c b/drivers/soc/renesas/r8a77970-sysc.c
index 2c6d76490ca0..280c48b80f24 100644
--- a/drivers/soc/renesas/r8a77970-sysc.c
+++ b/drivers/soc/renesas/r8a77970-sysc.c
@@ -23,8 +23,8 @@ static const struct rcar_sysc_area r8a77970_areas[] __initconst = {
 	{ "a3ir",	0x180, 0, R8A77970_PD_A3IR,	R8A77970_PD_ALWAYS_ON },
 	{ "a2ir0",	0x400, 0, R8A77970_PD_A2IR0,	R8A77970_PD_A3IR },
 	{ "a2ir1",	0x400, 1, R8A77970_PD_A2IR1,	R8A77970_PD_A3IR },
-	{ "a2ir2",	0x400, 2, R8A77970_PD_A2IR2,	R8A77970_PD_A3IR },
-	{ "a2ir3",	0x400, 3, R8A77970_PD_A2IR3,	R8A77970_PD_A3IR },
+	{ "a2dp",	0x400, 2, R8A77970_PD_A2DP,	R8A77970_PD_A3IR },
+	{ "a2cn",	0x400, 3, R8A77970_PD_A2CN,	R8A77970_PD_A3IR },
 	{ "a2sc0",	0x400, 4, R8A77970_PD_A2SC0,	R8A77970_PD_A3IR },
 	{ "a2sc1",	0x400, 5, R8A77970_PD_A2SC1,	R8A77970_PD_A3IR },
 };
diff --git a/include/dt-bindings/power/r8a77970-sysc.h b/include/dt-bindings/power/r8a77970-sysc.h
index 5c1ef1398b70..85cc5f23cf9f 100644
--- a/include/dt-bindings/power/r8a77970-sysc.h
+++ b/include/dt-bindings/power/r8a77970-sysc.h
@@ -18,10 +18,10 @@
 #define R8A77970_PD_CA53_CPU1		 6
 #define R8A77970_PD_CA53_SCU		21
 #define R8A77970_PD_A2IR0		23
-#define R8A77970_PD_A3IR			24
+#define R8A77970_PD_A3IR		24
 #define R8A77970_PD_A2IR1		27
-#define R8A77970_PD_A2IR2		28
-#define R8A77970_PD_A2IR3		29
+#define R8A77970_PD_A2DP		28
+#define R8A77970_PD_A2CN		29
 #define R8A77970_PD_A2SC0		30
 #define R8A77970_PD_A2SC1		31
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
