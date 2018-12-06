Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B391C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:17:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6792E2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OiRLj15t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="NG6N5qW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6792E2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vDzPyiB7hb04jv+MVOBb6qI6fAU6Q0ViBIcFowqER3I=; b=OiRLj15tPD/Fjo+2KYnQD3zNTm
	GzWcRjYA1mhI6JvPzWnbTqecpVOjOsU5CzhLYgLVlfQKHPKbkTZt+LUG5B/2hQNDEq5uHjIC7P2r3
	eIDr/57m9QadP0iTb+s3UJGLo7sOCxWpyTTaHOLmz1zs/PSgrrJbYGRtJ6BoSymgiknlMle3TKwEV
	wKpSrtey/FY4XjPJsPB+QcnfDvUMNBojI5qMQC6LkPTgnzU8ct+MsAtV1sTnQPvLITa8I2NxPW9Pl
	yISf1ZwEYQlwQplX4uV/yyRA2Fk/BH65WyDi0NVnU8yt/uj464xnScWET11NZqv5DHn9+5BySe6+z
	2nJCNXuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1xe-0005O4-Sp; Thu, 06 Dec 2018 22:17:34 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1wf-00085t-Jx
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:16:50 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id A50B525BF7F;
 Fri,  7 Dec 2018 08:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133576; bh=n3Fiw5cd85YFcBv6HGobPVPyS/s2Wgm5U0Xpb7tQNck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NG6N5qW7PsgocG90/Phx37Tkgw7Nr7rWbn+00pszSPFC9N2tCBfgsfKwBiT57QL3n
 k07Q9Td13QDpo5zZSEmSZm9fR9+kL0FcJy/hGONZl27KhhAzayyx8kGhazblP2qXwx
 ekGvciUODG4Ws7Gq8IiGKLQ/ng/OPsl1F2sQv76A=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 16DB6E22BAF; Thu,  6 Dec 2018 13:59:35 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 6/9] arm64: renesas: Move SoC Kconfig symbols to
 drivers/soc/renesas/
Date: Thu,  6 Dec 2018 13:59:31 -0800
Message-Id: <fa43948f6736b74c5840ec0b028d3662caf0f558.1544132474.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544132474.git.horms+renesas@verge.net.au>
References: <cover.1544132474.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141634_597158_CCF4D41B 
X-CRM114-Status: GOOD (  11.26  )
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

arch/arm64/Kconfig.platforms has SoC-specific Kconfig symbols for
Renesas SoCs, while other vendors have only a single Kconfig symbol.

Increase consistency with other vendors by moving the SoC-specific
Kconfig symbols to drivers/soc/renesas/Kconfig.

Increase consistency with R-Car Gen1 and Gen2 SoCs on arm32 by
introducing a family-specific Kconfig symbol for R-Car Gen3
(ARCH_RCAR_GEN3), which enables family-specific hardware features.
While so far only a single family (R-Car Gen3 and derivatives) of
Renesas arm64 SoCs is supported by Linux, this will make it easier
to add support for other SoC families later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/Kconfig.platforms | 59 -----------------------------
 drivers/soc/renesas/Kconfig  | 90 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 77 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2eb02734ae45..28f052185eb6 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -159,69 +159,10 @@ config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
 	select GPIOLIB
 	select PINCTRL
-	select PM
-	select PM_GENERIC_DOMAINS
-	select RENESAS_IRQC
 	select SOC_BUS
-	select SYS_SUPPORTS_SH_CMT
-	select SYS_SUPPORTS_SH_TMU
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
-config ARCH_R8A774A1
-	bool "Renesas RZ/G2M SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas RZ/G2M SoC.
-
-config ARCH_R8A774C0
-	bool "Renesas RZ/G2E SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas RZ/G2E SoC.
-
-config ARCH_R8A7795
-	bool "Renesas R-Car H3 SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car H3 SoC.
-
-config ARCH_R8A7796
-	bool "Renesas R-Car M3-W SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car M3-W SoC.
-
-config ARCH_R8A77965
-	bool "Renesas R-Car M3-N SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car M3-N SoC.
-
-config ARCH_R8A77970
-	bool "Renesas R-Car V3M SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car V3M SoC.
-
-config ARCH_R8A77980
-	bool "Renesas R-Car V3H SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car V3H SoC.
-
-config ARCH_R8A77990
-	bool "Renesas R-Car E3 SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car E3 SoC.
-
-config ARCH_R8A77995
-	bool "Renesas R-Car D3 SoC Platform"
-	depends on ARCH_RENESAS
-	help
-	  This enables support for the Renesas R-Car D3 SoC.
-
 config ARCH_ROCKCHIP
 	bool "Rockchip Platforms"
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 407f02c80e8b..2f5bc5a6ae2b 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -3,30 +3,94 @@ config SOC_RENESAS
 	bool "Renesas SoC driver support" if COMPILE_TEST && !ARCH_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
-	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
-			   ARCH_R8A774A1 || ARCH_R8A774C0 || ARCH_R8A7795 || \
-			   ARCH_R8A7796 || ARCH_R8A77965 || ARCH_R8A77970 || \
-			   ARCH_R8A77980 || ARCH_R8A77990 || ARCH_R8A77995
+	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2
 	select SYSC_R8A7743 if ARCH_R8A7743 || ARCH_R8A7744
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A77470 if ARCH_R8A77470
-	select SYSC_R8A774A1 if ARCH_R8A774A1
-	select SYSC_R8A774C0 if ARCH_R8A774C0
 	select SYSC_R8A7779 if ARCH_R8A7779
 	select SYSC_R8A7790 if ARCH_R8A7790
 	select SYSC_R8A7791 if ARCH_R8A7791 || ARCH_R8A7793
 	select SYSC_R8A7792 if ARCH_R8A7792
 	select SYSC_R8A7794 if ARCH_R8A7794
-	select SYSC_R8A7795 if ARCH_R8A7795
-	select SYSC_R8A7796 if ARCH_R8A7796
-	select SYSC_R8A77965 if ARCH_R8A77965
-	select SYSC_R8A77970 if ARCH_R8A77970
-	select SYSC_R8A77980 if ARCH_R8A77980
-	select SYSC_R8A77990 if ARCH_R8A77990
-	select SYSC_R8A77995 if ARCH_R8A77995
 
 if SOC_RENESAS
 
+config ARCH_RCAR_GEN3
+	bool
+	select PM
+	select PM_GENERIC_DOMAINS
+	select RENESAS_IRQC
+	select RST_RCAR
+	select SYS_SUPPORTS_SH_CMT
+	select SYS_SUPPORTS_SH_TMU
+
+if ARM64
+
+config ARCH_R8A774A1
+	bool "Renesas RZ/G2M SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A774A1
+	help
+	  This enables support for the Renesas RZ/G2M SoC.
+
+config ARCH_R8A774C0
+	bool "Renesas RZ/G2E SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A774C0
+	help
+	  This enables support for the Renesas RZ/G2E SoC.
+
+config ARCH_R8A7795
+	bool "Renesas R-Car H3 SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A7795
+	help
+	  This enables support for the Renesas R-Car H3 SoC.
+
+config ARCH_R8A7796
+	bool "Renesas R-Car M3-W SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A7796
+	help
+	  This enables support for the Renesas R-Car M3-W SoC.
+
+config ARCH_R8A77965
+	bool "Renesas R-Car M3-N SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A77965
+	help
+	  This enables support for the Renesas R-Car M3-N SoC.
+
+config ARCH_R8A77970
+	bool "Renesas R-Car V3M SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A77970
+	help
+	  This enables support for the Renesas R-Car V3M SoC.
+
+config ARCH_R8A77980
+	bool "Renesas R-Car V3H SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A77980
+	help
+	  This enables support for the Renesas R-Car V3H SoC.
+
+config ARCH_R8A77990
+	bool "Renesas R-Car E3 SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A77990
+	help
+	  This enables support for the Renesas R-Car E3 SoC.
+
+config ARCH_R8A77995
+	bool "Renesas R-Car D3 SoC Platform"
+	select ARCH_RCAR_GEN3
+	select SYSC_R8A77995
+	help
+	  This enables support for the Renesas R-Car D3 SoC.
+
+endif # ARM64
+
 # SoC
 config SYSC_R8A7743
 	bool "RZ/G1M System Controller support" if COMPILE_TEST
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
