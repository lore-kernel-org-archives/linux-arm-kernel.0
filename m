Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307F8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:15:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24742082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uuqaQ0gt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LQ1LYu+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24742082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JCjSbHdeCRB/wiiOvJDQKAf8L/P0sSd86tZiZIgLzjs=; b=uuqaQ0gtOlaaDvRKEu0J7PZqsF
	7iued2GxaWbWbY5WVe9MYCaWz18o8u1XBhtFUO3bsfJXwchSMmDrWjrUH583GLYv+UyDAvmJYbZ5R
	oVNDNgOWAetd33ZRopjhYYhzrZqCwNHqfa99p104rkAdFeCzfhuNVy8Ov2v3QhITt8FZ4dU2D9zgy
	iG27+/I+zxYIMpH9cA+GqbxyHIDZuMXH4DUBQzpMtXRhG7Fdg80BvKCgG98+yWJdhJuwiuPJxBX+I
	1pGnPf681MpAPTDjki+E3sWLLRTpV38hkbKK2t9eVW2xZnnOmsY5Zhl4NJzyXw5RRpxmDptxPHYig
	tdNucszg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1vz-0003nr-II; Thu, 06 Dec 2018 22:15:51 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1uz-00085t-9e
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:14:58 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 21A7825BF7A;
 Fri,  7 Dec 2018 08:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133576; bh=XPoK3MOJnVYTMadCSH/2x8yYnu03OO3wVnsUtkjjPN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LQ1LYu+pijlnRTc/XZZYHtjzBdWWkOlPrgVYfr3lEvre53elU5R1Inc7tX0KhtV08
 lWdfaUG9UTG7kKlmIB2mVqvQLUKdszWOrpTJ4h1uRwaOhocVfSlZw5wHqQaSXUdGkZ
 z55jAFrRdPEpTR89vrd+bggIb0Nz7YBdNrk7caCE=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 0C8FDE21D8B; Thu,  6 Dec 2018 13:59:35 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/9] ARM: shmobile: sh73a0: Remove obsolete inclusion of
 <asm/smp_twd.h>
Date: Thu,  6 Dec 2018 13:59:29 -0800
Message-Id: <e743454a0f42b5acf17b5fddce9811d53e4bf24b.1544132474.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544132474.git.horms+renesas@verge.net.au>
References: <cover.1544132474.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141450_774204_1ADD23F3 
X-CRM114-Status: UNSURE (   9.12  )
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

As of commit 9a9863987bf7307f ("ARM: shmobile: Remove legacy SoC code
for SH-Mobile AG5"), this header file is no longer used.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-sh73a0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 9bc543faba96..0403aa8629dd 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -12,7 +12,6 @@
 #include <linux/delay.h>
 
 #include <asm/smp_plat.h>
-#include <asm/smp_twd.h>
 
 #include "common.h"
 #include "sh73a0.h"
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
