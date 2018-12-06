Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A353BC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:17:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588C92082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jyp1tolE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="YumJwp2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588C92082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AR+jY2nv7MmKlCwMMaADKmezBcl7MFxrSIcXVupNchg=; b=Jyp1tolEn7O7IQdvAnni8I9ws6
	gIevKV3R8EGQgEqHeHWJiFFFXNbKhox8ssgzPeXdtg8A9upamS5oVJEIGRsgDKgnIfS5hJC16mUQD
	blZogriV3hxlKMOQmqJs1km/SvfM5y4PAhNYrI03u3yUbgiWIYJmOc5qAB59kaoqMhGVFjfU8/xuu
	7HtXvghA0X4bRrpJb0nWH2I1z2Ne6MGQBbn0bg2a/Btyu9TOhR07gnlfBDFMXZGNRe29rA/hTCrdC
	lBN13DyPg2aq0DqfKL102OKzn/6qSKCEZsTP2Z+ATd+vy54PeWeh6sblNdg43KRBKHhHvXT0aE8SO
	7YPJL0uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1xR-00059S-1C; Thu, 06 Dec 2018 22:17:21 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1w7-00085t-2J
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:16:33 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 8E83B25BF7E;
 Fri,  7 Dec 2018 08:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133576; bh=vBsuhl/8mlY93Q27msg4cf9gNq3N9y9d0ljpeFu+DYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YumJwp2FVI59q4d62vV0ZpFwiQmHROweOgWucitBIlX/RZ1ialyyanekxyMbyy89Z
 ZlRmulFzpTR0QKc625J5kOD+rPg8TXAP8AevA20cMX9/zA+GUb8RNM3e3PSEGVAnkT
 vIQvabGGCFfSxm+ux/C0XfFh+zv4SoaT0sClAjeI=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 10791E22094; Thu,  6 Dec 2018 13:59:35 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 5/9] ARM: shmobile: Hide ARCH_RZN1 to improve consistency
Date: Thu,  6 Dec 2018 13:59:30 -0800
Message-Id: <79aac4b9b2081235ecf9fb1683aa765e539dc0e2.1544132474.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544132474.git.horms+renesas@verge.net.au>
References: <cover.1544132474.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141600_059471_8DD35098 
X-CRM114-Status: UNSURE (   9.47  )
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

Unlike all other family-specific Kconfig symbols for Renesas ARM SoCs,
ARCH_RZN1 is user-visible.  As this symbol is already selected by the
SoC-specific ARCH_R9A06G032 symbol, there is no need for that.

Hide ARCH_RZN1 from the user, and move it up, where all other
family-specific Kconfig symbols live.  Drop the select of CPU_V7, as
this is already implied by the dependency of ARCH_RENESAS on
ARCH_MULTI_V7.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a35eb5913dfd..70c6f557f8cd 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -25,6 +25,10 @@ config ARCH_RMOBILE
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
+config ARCH_RZN1
+	bool
+	select ARM_AMBA
+
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
@@ -128,11 +132,6 @@ config ARCH_R9A06G032
 	bool "RZ/N1D (R9A06G032)"
 	select ARCH_RZN1
 
-config ARCH_RZN1
-	bool "RZ/N1 (R9A06G0xx) Family"
-	select ARM_AMBA
-	select CPU_V7
-
 config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
 	select ARCH_RMOBILE
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
