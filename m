Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F597C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:56:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3562084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lil3apb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3562084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mni.thm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sPt0115KxuLI5t9p155j5FNtlRyGSPed1MjmsT4JkjQ=; b=Lil3apb5usKovp
	DOcRtnG+flHxhlYuU8bXRoIp3onHKgLfV2ioI6wG2Iozy8EHs2fFCyjUZ8Kodye1jX3ENoO08wAdA
	xFanOjwaqsgNQM1Yo9PetMpyCwz81SuCnJgbBP3vOjF8v0+XRAD+rEqruXDL+tfcW43J5uqt4zgBk
	LAu7rKhgUMzukdjDtSL+XubiIF7UujHnL653aXpjvyEXf/Io1Axtxfj7DwOg+g6gaxNU0vf5ZqQW9
	TDokyMOW5hDZoyRHur/BW3m2m1jEuH0Unyfqx2d4/5LsLj9BeQuwTgcZa21DC5JPEh+Ugk1QMCSSa
	TT6tbdpZknPDdR1bdO7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkvn1-0000jQ-97; Sat, 19 Jan 2019 18:56:19 +0000
Received: from mout1.fh-giessen.de ([212.201.18.42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkvmx-0000iv-FI
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 18:56:17 +0000
Received: from mx3.fh-giessen.de ([212.201.18.28])
 by mout1.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.91) (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
 id 1gkvmn-000K3I-89; Sat, 19 Jan 2019 19:56:05 +0100
Received: from mailgate-1.its.fh-giessen.de ([212.201.18.15])
 by mx3.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.91) (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
 id 1gkvmn-001ino-4k; Sat, 19 Jan 2019 19:56:05 +0100
Received: from p549d3f2a.dip0.t-ipconnect.de ([84.157.63.42]
 helo=zwei.fritz.box) by mailgate-1.its.fh-giessen.de with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.91)
 (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
 id 1gkvmm-000CJY-QQ; Sat, 19 Jan 2019 19:56:04 +0100
From: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will.deacon@arm.com
Subject: [PATCH] arch/arm64: Add the various compression methods to the
 default config
Date: Sat, 19 Jan 2019 19:55:40 +0100
Message-Id: <20190119185540.20526-1-tobias.johannes.klausmann@mni.thm.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_105615_510226_EB35AC04 
X-CRM114-Status: UNSURE (   7.73  )
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
Cc: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There is no reason having arm64 not select these configurations by
default!

Signed-off-by: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
---
 arch/arm64/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..91a5e1cd7279 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -140,6 +140,11 @@ config ARM64
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_LZ4
+	select HAVE_KERNEL_LZMA
+	select HAVE_KERNEL_LZO
+	select HAVE_KERNEL_XZ
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
 	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
