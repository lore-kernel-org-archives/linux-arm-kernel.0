Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8414DC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:12:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514DE20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o4jq55Fh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kUPuCmFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514DE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0tZ3spNw+t+MOLyEgUWMryT7CcwwTzIszsE93Ahdf1M=; b=o4jq55FhgvFGLrzXDjCdYJIxKh
	Q6yq6s75JQ+fKOIUdSwMv94hncOcp0Oh9FHcxf6O8o+WWxCXxSvDJbszUQqboexM3GPF+GvbYYRWp
	uh7UYNRSEqiYcgV3hq38UDjt8tkAoMms4nwOsjSFTG8lq4cNaxSMDpJiDt/5/0vRnfDLlAJICPRWW
	RbdYDd/UounRtyMgmoEFqbS6A6u5pwPD0GmpvVaXlbMTsTTmJLcNZgcamN2X6qGhsj0sIzS+o6hEq
	69iv+S85w2ztD7FhiaMX8fleuDxdt5IQe2OdXBJopPdDDYUtelAZomgvu5oSaYiGhkGslALnbuDYg
	bXm1SLZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1sU-0007N6-Cm; Thu, 06 Dec 2018 22:12:14 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1rB-00021y-AA
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:10:55 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 4ECD625BF37;
 Fri,  7 Dec 2018 08:58:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133539; bh=MQ0/ZqPHciaw1YMwBMh3shQekS4AjSTuF2DrYQdibM4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kUPuCmFGyYGbCFFNJ4BPwGalr8zYqD+tBKlBtUSmoUJ0xqadDJwKH67un6+Hk5xsQ
 l15d8dIhq0KM1jUujZFMsxsSX/+Q9jiKAAcwUcHgsgBf/b4Zf2gtZweh1wdjufErls
 iIw3OiOiiFZBSrhv3kvSfC/x9jsz2yMYuwOMUuxE=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 1F60BE217D1; Thu,  6 Dec 2018 13:58:58 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/9] soc: renesas: r8a77970-sysc: Remove non-existent CR7
 power domain
Date: Thu,  6 Dec 2018 13:58:50 -0800
Message-Id: <da3e1c57caf93ed379f14686e877f806111abe7c.1544131943.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544131943.git.horms+renesas@verge.net.au>
References: <cover.1544131943.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141053_701837_BAC5180A 
X-CRM114-Status: UNSURE (   9.42  )
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
removed the CR7 power domain on R-Car V3M, as this SoC does not have an
ARM Cortex-R7 Realtime Core.

As this definition was never used from DT, it can just be removed.

Fixes: 833bdb47c826a1a6 ("dt-bindings: power: add R8A77970 SYSC power domain definitions")
Fixes: bab9b2a74fe9da96 ("soc: renesas: rcar-sysc: add R8A77970 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a77970-sysc.c       | 1 -
 include/dt-bindings/power/r8a77970-sysc.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/soc/renesas/r8a77970-sysc.c b/drivers/soc/renesas/r8a77970-sysc.c
index 35b30d6a8958..2c6d76490ca0 100644
--- a/drivers/soc/renesas/r8a77970-sysc.c
+++ b/drivers/soc/renesas/r8a77970-sysc.c
@@ -20,7 +20,6 @@ static const struct rcar_sysc_area r8a77970_areas[] __initconst = {
 	  PD_CPU_NOCR },
 	{ "ca53-cpu1",	0x200, 1, R8A77970_PD_CA53_CPU1, R8A77970_PD_CA53_SCU,
 	  PD_CPU_NOCR },
-	{ "cr7",	0x240, 0, R8A77970_PD_CR7,	R8A77970_PD_ALWAYS_ON },
 	{ "a3ir",	0x180, 0, R8A77970_PD_A3IR,	R8A77970_PD_ALWAYS_ON },
 	{ "a2ir0",	0x400, 0, R8A77970_PD_A2IR0,	R8A77970_PD_A3IR },
 	{ "a2ir1",	0x400, 1, R8A77970_PD_A2IR1,	R8A77970_PD_A3IR },
diff --git a/include/dt-bindings/power/r8a77970-sysc.h b/include/dt-bindings/power/r8a77970-sysc.h
index bf54779d1625..5c1ef1398b70 100644
--- a/include/dt-bindings/power/r8a77970-sysc.h
+++ b/include/dt-bindings/power/r8a77970-sysc.h
@@ -16,7 +16,6 @@
 
 #define R8A77970_PD_CA53_CPU0		 5
 #define R8A77970_PD_CA53_CPU1		 6
-#define R8A77970_PD_CR7			13
 #define R8A77970_PD_CA53_SCU		21
 #define R8A77970_PD_A2IR0		23
 #define R8A77970_PD_A3IR			24
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
