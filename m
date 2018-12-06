Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB90C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:18:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68BC20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z0Z0OpJj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Q/TGb/Rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68BC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HxoznRMkjugmZCiRR49mckT2ttzyZs0qd7tBJCn8Fm4=; b=Z0Z0OpJjt9Nd5InxIDjNQIuAkT
	hLH/K0UT0WSUT5cli9/P7HeILFkouaP2T0HiNYiKcL07RMRMZJw5sp+BkZPszaTSDHM6j0/0n1DyD
	JD9y0hr4vk7zg4mPnigENPU4zRNtpTCMnDXMbNlfcyHcjRTYl6qfJ0KG/AaOl4dcdwOEwocuy29Ba
	WGlilWCXOgcPBxZlRjTztSDuvovtBFnj2Hv4qQvX3uZiz4EzWBgZeJyZqlu/vx3JFxF5Ba6UY8NEi
	Wor4f9Mimc9T4FQZpQ854bYmWf6yGjmm9jxgSxDogjb2JAICpsec/8gO2IV21FB9lqb3yT6jKw7Qx
	n3wRucMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1yK-0005x3-Ix; Thu, 06 Dec 2018 22:18:16 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1x4-00085t-Tj
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:17:05 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id DA49F25BF82;
 Fri,  7 Dec 2018 08:59:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133578; bh=PxUKsCOcuM6BFWAWvCpuDBvoxEWwgaPbuXH7YvN0X4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q/TGb/Rr+74OFG1kn2C2WdWeYK9bsYYKzOR/bUeVFsqoaSpOiIAS+pnjovPy2O3by
 oqpvtOXvqauRGUQRWxG9VfYR4fOFamGNzTSlKk28TIC6Alc4MX/IX05/u1uR4qPACq
 mQiiqNpQFyZGIv5n9Qbi6TS4M609FpK/Fc1jh1kw=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 23378E23295; Thu,  6 Dec 2018 13:59:35 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 9/9] ARM: shmobile: R-Mobile: Move pm-rmobile to
 drivers/soc/renesas/
Date: Thu,  6 Dec 2018 13:59:34 -0800
Message-Id: <2ed29e15e4b2500ae78de658a18f4482e7ac288b.1544132474.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544132474.git.horms+renesas@verge.net.au>
References: <cover.1544132474.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141659_568510_54BDE354 
X-CRM114-Status: GOOD (  10.64  )
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

The pm-rmobile driver is really a driver for the System Controller
(SYSC) found in R-Mobile SoCs.  An equivalent driver for R-Car SoCs is
already located under drivers/soc/renesas/.

Hence move the pm-rmobile driver from arch/arm/mach-shmobile/ to
drivers/soc/renesas/, and rename it to rmobile-sysc.

Enable compile-testing on non-ARM and non-R-Mobile SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                                     | 5 -----
 arch/arm/mach-shmobile/Makefile                                    | 1 -
 drivers/soc/renesas/Kconfig                                        | 7 ++++++-
 drivers/soc/renesas/Makefile                                       | 1 +
 .../pm-rmobile.c => drivers/soc/renesas/rmobile-sysc.c             | 0
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/mach-shmobile/pm-rmobile.c => drivers/soc/renesas/rmobile-sysc.c (100%)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 9b798c9dffe4..3683d6f10973 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,9 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-config PM_RMOBILE
-	bool
-	select PM
-	select PM_GENERIC_DOMAINS
-
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 5591646cb9bb..f7bf17b7abae 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -35,7 +35,6 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
-obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
 
 # Framework support
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index fe7f58616cdd..4d8012e1205c 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -34,9 +34,11 @@ config ARCH_RCAR_GEN3
 
 config ARCH_RMOBILE
 	bool
-	select PM_RMOBILE
+	select PM
+	select PM_GENERIC_DOMAINS
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
+	select SYSC_RMOBILE
 
 config ARCH_RZN1
 	bool
@@ -297,4 +299,7 @@ config RST_RCAR
 config SYSC_RCAR
 	bool "R-Car System Controller support" if COMPILE_TEST
 
+config SYSC_RMOBILE
+	bool "R-Mobile System Controller support" if COMPILE_TEST
+
 endif # SOC_RENESAS
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 3bdd7dbc38a9..00764d5a60b3 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -27,3 +27,4 @@ endif
 # Family
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
 obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
+obj-$(CONFIG_SYSC_RMOBILE)	+= rmobile-sysc.o
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/drivers/soc/renesas/rmobile-sysc.c
similarity index 100%
rename from arch/arm/mach-shmobile/pm-rmobile.c
rename to drivers/soc/renesas/rmobile-sysc.c
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
