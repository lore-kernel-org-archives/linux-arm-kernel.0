Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE500C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744EB20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="grJCXKu0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ztUWd2iI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7fxYO4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744EB20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JS2DGn3Xb0YZBErO/XQUz1NIwtYtsrGzsTJNZFSy3qg=; b=grJCXKu0dviPN0
	ihr5kUVRoGMCwD9ooq3TDmCqfOru5+Zut0XWM5FVzGxnr3VoV2BOaCvJKYO2TQ59vJNiESvD0sFCr
	4fVALIgWnNLDeSH0KgLkVoEMIc/CnVipgeTR0cMyjramDK05Lss68qBF+UroWa9h7kwNOT46jIG1R
	CDriSsVEUJB9oHzQ1q0qG1hkp1TWQxHWnLoSrtJpkPzg7PI2O+PrE4yFo5h8Yj+RPT2QwmxnCZ7UB
	73b4zEuZF2AKn+l67uCV0deqqJ834+uLC3kudIzw43TOUyRvFb56vdl8PhoOEwQR7udlp3gqzJvt2
	52Y5BAyRMp5B2yvpiV6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOU3-0004sA-24; Mon, 10 Dec 2018 16:32:39 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWORz-0002sP-NR
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 16:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X+JtbB5kahpWRryGJEfPt2WL8lWHxPrmd07Wiq4JNWY=; b=ztUWd2iIa0oqaOKlMtbg2j9ElA
 4svbylMENgzZUzMPn3Ej/Cqza2FnHN6JFfbQJokduDf3pEC6a9VZothF0dbVCyuc+ylVu1Dfj+iCb
 YaLKotiYo7Z8P1IUT+Ne+tJjwjTBWAOWK26Q96jgW3sRHTWm39sUG1F+cNf3nYyjC0n+Kuk2RcYEZ
 DWn8q9zn+vNAlx3/WKSZXPtlnrDAk6l/lxVHvSIz2V69kVuCJbS9tLsJcoXlKPgFD7ITjby1/SP13
 BY43rTvyMGwfa0rSFEi+liBOYX4GQyW1V+4KC3W2bSe9QIkirGSNgzhJYq9d7ggaYDfXBxAgvkRF0
 ibNG1UOg==;
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWORw-00051W-6A
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:30:29 +0000
Received: by mail-wm1-x342.google.com with SMTP id c126so11905668wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X+JtbB5kahpWRryGJEfPt2WL8lWHxPrmd07Wiq4JNWY=;
 b=S7fxYO4I95AqKMJRglYTKwog5gT5deCDNaP3im9wvXzVYzx+jtwBSZ0o6fRxB7Jmc+
 eB15AL+QD2DnvrJdsPhDUVsCsnLhI5DE4DzhTDAJYqJjL5gmbo36NvBBsDp2vt8MyP94
 9HCPomB4VXkwH2Mey1GG7N+MBms4p+uehZIWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X+JtbB5kahpWRryGJEfPt2WL8lWHxPrmd07Wiq4JNWY=;
 b=Z7GjxzRPXnX49AL8aLG/W3S65IsQD5Zoku1SUfnN0pFP1q1qqf91EGGDWxbok5P469
 NyemC9tVH5+uoHMC/K3dDSRiPFXaCWaV4MfOyvjW444Da8qYton6sTdIGoPn2jC1F3yz
 L46lkQi5gzEa0IRvRKoE6nJy+8AhfZJIn0tmVXENFyJ42achOnKpMb7HKFhtXplNjELI
 dlN/YWz1E7nyZiWzMT23zw/HClCHKwackfsUb1j5e+QAUaXBG+p1smG1yTbxyYMXajXi
 9L5LUnrMIaZgzZdjFSMV7pOGGyafYutCy9qzTS3Rjx5uqRNZRnuoiDVnGXbr+QBuajpP
 h9jw==
X-Gm-Message-State: AA+aEWaiabyz5v+CCGI8A2/aR4YBclfu+9R59as04oQ5cGDoYx9YO094
 4HCABLyPutGdWM0KixH1cy4mugvW721JxA==
X-Google-Smtp-Source: AFSGD/WdQIuPPfaJVnHmKm67tSzct0xhorn3RFQ9FLkFZWctQ0up7FDEPKIxIQpmXe9w6rLfNRtq7A==
X-Received: by 2002:a1c:90d5:: with SMTP id
 s204mr11215222wmd.148.1544459413490; 
 Mon, 10 Dec 2018 08:30:13 -0800 (PST)
Received: from localhost.localdomain
 (astlambert-681-1-52-199.w90-86.abo.wanadoo.fr. [90.86.17.199])
 by smtp.gmail.com with ESMTPSA id i186sm3480531wmd.19.2018.12.10.08.30.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:30:12 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: mm: permit early_memremap() to be used in
 paging_init()
Date: Mon, 10 Dec 2018 17:29:47 +0100
Message-Id: <20181210162949.8597-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210162949.8597-1-ard.biesheuvel@linaro.org>
References: <20181210162949.8597-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_113028_321150_E7368200 
X-CRM114-Status: GOOD (  15.65  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-efi@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

early_memremap() and early_ioremap() rely on early fixmap support,
which shares its virtual address space with kmap(), and so it is
taken down in paging_init().

In order to permit the EFI persistent memory reservation code to
use early_memremap() when called from paging_init(), move the call
to early_ioremap_reset() into paging_init(), right before the call
to early_fixmap_shutdown(), creating a window where we can add the
call to efi_apply_persistent_mem_reservations() in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/setup.c | 2 --
 arch/arm/mm/mmu.c       | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 375b13f7e780..7e2a936a5ed0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1124,8 +1124,6 @@ void __init setup_arch(char **cmdline_p)
 	/* Memory may have been removed so recalculate the bounds. */
 	adjust_lowmem_bounds();
 
-	early_ioremap_reset();
-
 	paging_init(mdesc);
 	request_standard_resources(mdesc);
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f6bf6686559d..078f82f89fe5 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -22,6 +22,7 @@
 #include <asm/cputype.h>
 #include <asm/sections.h>
 #include <asm/cachetype.h>
+#include <asm/early_ioremap.h>
 #include <asm/fixmap.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -1628,6 +1629,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 	memblock_set_current_limit(arm_lowmem_limit);
 	memblock_allow_resize();
 	dma_contiguous_remap();
+	early_ioremap_reset();
 	early_fixmap_shutdown();
 	devicemaps_init(mdesc);
 	kmap_init();
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
