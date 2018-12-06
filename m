Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BEEC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:18:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1EE2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rgEn8+PB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="GA/xBWo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1EE2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=k3b1IPYT/WvELSx7fUXDfXpTwDNxR90RDCTRBV3Moxo=; b=rgEn8+PBxxs4jL29i2VEhtKP1Z
	DhTBGbVSLlBZSzQk1qpgPG4fDYbD7424U8NtQeKKgpFdHXf0fazRZO/8uG7QvQOWxkEV2IUTmsocZ
	uPiQJ6AuISDlRPsI4A+G5j3IkFQYD/S8wQQaWP6cIWvJeL5BUGQex3yzJ8Rq5Fcn/PmgUOi2erCp5
	019xibWBzWnCVfR7YF/gGcxqHBzAvONtqhK+jr0OR5I4MwqyBXOyGNJ4XOvG+CVBzz4+uYu+zOudm
	kPyuQULC2BxmmH+49eXFd2+4p4/B+z/8ZCFvsoGRgMJIDlzGLU7j7HqE21/MRolGYQOWocgIXspMM
	ARFloN2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1yc-0006C4-7j; Thu, 06 Dec 2018 22:18:34 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1xB-00085t-MO
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:17:20 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E3E3825BF85;
 Fri,  7 Dec 2018 08:59:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133578; bh=zIeaxycc000hX3jMg3CRNrnweBSTrG2djUmOo3803VI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GA/xBWo9K50SlTvkrKrOGwNwC7F9c2EpYuH338EuR5uQpQyy+yqnQB2mR5uj3fdvy
 eijvcQ8nHbZfqJp6fHZeJwW8TSa5y8J1Gy92BGjWhbAb5v+N+rWxifKr1Npyfcpc3x
 f+5TMHVQ78AGdzlIeFV3u2JUnS2KAAN6UNIy3d4s=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 1A527E23291; Thu,  6 Dec 2018 13:59:35 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 7/9] ARM: shmobile: Move SoC Kconfig symbols to
 drivers/soc/renesas/
Date: Thu,  6 Dec 2018 13:59:32 -0800
Message-Id: <062887bf5ef733133e51c77900ad5a570a974817.1544132474.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544132474.git.horms+renesas@verge.net.au>
References: <cover.1544132474.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141706_194001_0BCFFB52 
X-CRM114-Status: UNSURE (   9.41  )
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

For consistency with arm64, where vendors have a single Kconfig symbol
in arch/arm64/Kconfig.platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 126 -----------------------------------
 drivers/soc/renesas/Kconfig    | 148 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 139 insertions(+), 135 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 70c6f557f8cd..9b798c9dffe4 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -4,31 +4,6 @@ config PM_RMOBILE
 	select PM
 	select PM_GENERIC_DOMAINS
 
-config ARCH_RCAR_GEN1
-	bool
-	select PM
-	select PM_GENERIC_DOMAINS
-	select RENESAS_INTC_IRQPIN
-	select SYS_SUPPORTS_SH_TMU
-
-config ARCH_RCAR_GEN2
-	bool
-	select HAVE_ARM_ARCH_TIMER
-	select PM
-	select PM_GENERIC_DOMAINS
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
-
-config ARCH_RMOBILE
-	bool
-	select PM_RMOBILE
-	select SYS_SUPPORTS_SH_CMT
-	select SYS_SUPPORTS_SH_TMU
-
-config ARCH_RZN1
-	bool
-	select ARM_AMBA
-
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
@@ -38,104 +13,3 @@ menuconfig ARCH_RENESAS
 	select PINCTRL
 	select SOC_BUS
 	select ZONE_DMA if ARM_LPAE
-
-if ARCH_RENESAS
-
-#comment "Renesas ARM SoCs System Type"
-
-config ARCH_EMEV2
-	bool "Emma Mobile EV2"
-	select HAVE_ARM_SCU if SMP
-	select SYS_SUPPORTS_EM_STI
-
-config ARCH_R7S72100
-	bool "RZ/A1H (R7S72100)"
-	select PM
-	select PM_GENERIC_DOMAINS
-	select SYS_SUPPORTS_SH_MTU2
-	select RENESAS_OSTM
-
-config ARCH_R7S9210
-	bool "RZ/A2 (R7S9210)"
-	select PM
-	select PM_GENERIC_DOMAINS
-	select RENESAS_OSTM
-
-config ARCH_R8A73A4
-	bool "R-Mobile APE6 (R8A73A40)"
-	select ARCH_RMOBILE
-	select ARM_ERRATA_798181 if SMP
-	select HAVE_ARM_ARCH_TIMER
-	select RENESAS_IRQC
-
-config ARCH_R8A7740
-	bool "R-Mobile A1 (R8A77400)"
-	select ARCH_RMOBILE
-	select RENESAS_INTC_IRQPIN
-
-config ARCH_R8A7743
-	bool "RZ/G1M (R8A77430)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-
-config ARCH_R8A7744
-	bool "RZ/G1N (R8A77440)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-
-config ARCH_R8A7745
-	bool "RZ/G1E (R8A77450)"
-	select ARCH_RCAR_GEN2
-
-config ARCH_R8A77470
-	bool "RZ/G1C (R8A77470)"
-	select ARCH_RCAR_GEN2
-
-config ARCH_R8A7778
-	bool "R-Car M1A (R8A77781)"
-	select ARCH_RCAR_GEN1
-
-config ARCH_R8A7779
-	bool "R-Car H1 (R8A77790)"
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select ARCH_RCAR_GEN1
-
-config ARCH_R8A7790
-	bool "R-Car H2 (R8A77900)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-	select I2C
-
-config ARCH_R8A7791
-	bool "R-Car M2-W (R8A77910)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-	select I2C
-
-config ARCH_R8A7792
-	bool "R-Car V2H (R8A77920)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-
-config ARCH_R8A7793
-	bool "R-Car M2-N (R8A7793)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-	select I2C
-
-config ARCH_R8A7794
-	bool "R-Car E2 (R8A77940)"
-	select ARCH_RCAR_GEN2
-
-config ARCH_R9A06G032
-	bool "RZ/N1D (R9A06G032)"
-	select ARCH_RZN1
-
-config ARCH_SH73A0
-	bool "SH-Mobile AG5 (R8A73A00)"
-	select ARCH_RMOBILE
-	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select RENESAS_INTC_IRQPIN
-endif
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 2f5bc5a6ae2b..fe7f58616cdd 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -3,18 +3,26 @@ config SOC_RENESAS
 	bool "Renesas SoC driver support" if COMPILE_TEST && !ARCH_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
-	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2
-	select SYSC_R8A7743 if ARCH_R8A7743 || ARCH_R8A7744
-	select SYSC_R8A7745 if ARCH_R8A7745
-	select SYSC_R8A77470 if ARCH_R8A77470
-	select SYSC_R8A7779 if ARCH_R8A7779
-	select SYSC_R8A7790 if ARCH_R8A7790
-	select SYSC_R8A7791 if ARCH_R8A7791 || ARCH_R8A7793
-	select SYSC_R8A7792 if ARCH_R8A7792
-	select SYSC_R8A7794 if ARCH_R8A7794
 
 if SOC_RENESAS
 
+config ARCH_RCAR_GEN1
+	bool
+	select PM
+	select PM_GENERIC_DOMAINS
+	select RENESAS_INTC_IRQPIN
+	select RST_RCAR
+	select SYS_SUPPORTS_SH_TMU
+
+config ARCH_RCAR_GEN2
+	bool
+	select HAVE_ARM_ARCH_TIMER
+	select PM
+	select PM_GENERIC_DOMAINS
+	select RENESAS_IRQC
+	select RST_RCAR
+	select SYS_SUPPORTS_SH_CMT
+
 config ARCH_RCAR_GEN3
 	bool
 	select PM
@@ -24,6 +32,128 @@ config ARCH_RCAR_GEN3
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
+config ARCH_RMOBILE
+	bool
+	select PM_RMOBILE
+	select SYS_SUPPORTS_SH_CMT
+	select SYS_SUPPORTS_SH_TMU
+
+config ARCH_RZN1
+	bool
+	select ARM_AMBA
+
+if ARM
+
+#comment "Renesas ARM SoCs System Type"
+
+config ARCH_EMEV2
+	bool "Emma Mobile EV2"
+	select HAVE_ARM_SCU if SMP
+	select SYS_SUPPORTS_EM_STI
+
+config ARCH_R7S72100
+	bool "RZ/A1H (R7S72100)"
+	select PM
+	select PM_GENERIC_DOMAINS
+	select SYS_SUPPORTS_SH_MTU2
+	select RENESAS_OSTM
+
+config ARCH_R7S9210
+	bool "RZ/A2 (R7S9210)"
+	select PM
+	select PM_GENERIC_DOMAINS
+	select RENESAS_OSTM
+
+config ARCH_R8A73A4
+	bool "R-Mobile APE6 (R8A73A40)"
+	select ARCH_RMOBILE
+	select ARM_ERRATA_798181 if SMP
+	select HAVE_ARM_ARCH_TIMER
+	select RENESAS_IRQC
+
+config ARCH_R8A7740
+	bool "R-Mobile A1 (R8A77400)"
+	select ARCH_RMOBILE
+	select RENESAS_INTC_IRQPIN
+
+config ARCH_R8A7743
+	bool "RZ/G1M (R8A77430)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select SYSC_R8A7743
+
+config ARCH_R8A7744
+	bool "RZ/G1N (R8A77440)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select SYSC_R8A7743
+
+config ARCH_R8A7745
+	bool "RZ/G1E (R8A77450)"
+	select ARCH_RCAR_GEN2
+	select SYSC_R8A7745
+
+config ARCH_R8A77470
+	bool "RZ/G1C (R8A77470)"
+	select ARCH_RCAR_GEN2
+	select SYSC_R8A77470
+
+config ARCH_R8A7778
+	bool "R-Car M1A (R8A77781)"
+	select ARCH_RCAR_GEN1
+
+config ARCH_R8A7779
+	bool "R-Car H1 (R8A77790)"
+	select ARCH_RCAR_GEN1
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select SYSC_R8A7779
+
+config ARCH_R8A7790
+	bool "R-Car H2 (R8A77900)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select I2C
+	select SYSC_R8A7790
+
+config ARCH_R8A7791
+	bool "R-Car M2-W (R8A77910)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select I2C
+	select SYSC_R8A7791
+
+config ARCH_R8A7792
+	bool "R-Car V2H (R8A77920)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select SYSC_R8A7792
+
+config ARCH_R8A7793
+	bool "R-Car M2-N (R8A7793)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select I2C
+	select SYSC_R8A7791
+
+config ARCH_R8A7794
+	bool "R-Car E2 (R8A77940)"
+	select ARCH_RCAR_GEN2
+	select SYSC_R8A7794
+
+config ARCH_R9A06G032
+	bool "RZ/N1D (R9A06G032)"
+	select ARCH_RZN1
+
+config ARCH_SH73A0
+	bool "SH-Mobile AG5 (R8A73A00)"
+	select ARCH_RMOBILE
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select RENESAS_INTC_IRQPIN
+
+endif # ARM
+
 if ARM64
 
 config ARCH_R8A774A1
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
