Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A16C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:29:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E664420672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AR6H/lwm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jqo7eYwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E664420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e2KlUqZ8HRfJh87lVYXJzkrf6s/rJd/l8kkCJ2esFwY=; b=AR6H/lwml+/tTW
	AJDUg32FaB9GUqazuGKtU5/sSJZv91TIlyo/s0HLd+jEw7f46ry0838MBW7JyqpRG4vwyRgTQMlJE
	tTmWcmKNrOUP4udxdc8n4ykyG/XEjqDmM3YnIxDzgyurK0pYjL1kkxBUFjscHyLGLmEUIwU6+5B9l
	vIP7VY1zeGhQw1+IQSv5ZMM8Bc3x34MTZG2iRZJBRTfc0b1Yz5fg7JH14T+ECcm4Jlu9bgRQCtMoQ
	PFxXhBBzcAf6sEaLVPc2Y00DgyQxyQX6P8uXZBXdZW3nuf7f4EtNGBfRDy+sY1DpLmb2qiKsqzZPQ
	RrD9NsWnHrbklStI80HA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWNUh-0001Jm-7f; Mon, 10 Dec 2018 15:29:15 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWNUe-0001Iq-3N
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 15:29:13 +0000
Received: by mail-wm1-x343.google.com with SMTP id a18so11749469wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 07:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qn9uGLpJqqC9/C3gn/dk4Uvnqi3QjOyzeRwtqZlEuT8=;
 b=Jqo7eYwaVPv5J1etNPRDTZJU7W0VnpeVAKcG8qgpkvPqmXuqULbWKnIB6GOtljpmHo
 zaFNy7P6KY2V1S5bBnY8y1FK8jVtqTIRK5G+e17/T99jTU5S3LNCN5Zl+MIi4Ru4Y2Gb
 aJ37rY7jgW73rxxFT9Z2cpToJOpjz1WyZEZc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qn9uGLpJqqC9/C3gn/dk4Uvnqi3QjOyzeRwtqZlEuT8=;
 b=o+aBLMUypWTrK/1c5asAfk22/TDmqCLuiiG6ubNiOOqq9ylDM9VRoakmm5deknESlV
 q69TchI55hSVbBZuiPIPSAIcqyXu1Hcc+k5yXCmpH7VHcIN3oVKEcPt5WiiIUYwVOihM
 1us/wO+dEjrh/cb3MsgwIYTMe86wp3aAIi5/waZdI9BmCT52nJ35jWr3Bkm9M7/G65uZ
 vHWuU7U6pi5G/1lffsZ8684MeQnXF+TtziTNR6fPxnFK6qfLoKxG97iKDEp/bGWzzJEb
 M6uHlcC9YctvLih/wkYPmrP8cg4H0426OIF4tOshGSH/miOnnKlOPGfesf1W24XDj/cJ
 eklQ==
X-Gm-Message-State: AA+aEWYzI6i5Iq5oi732yFE82pJBkFYrU0dZ48fwrqk1DyIEiturZFkW
 QwJlEuCbGubeOdakOOnCPtX7rxhhgN21Dg==
X-Google-Smtp-Source: AFSGD/XHsyBE+uDlaT76Q5VyNmokQV/7zzIAc0o1ebCeBOkuNXRl+/ahTDKWQGlHW8hGuI5ySAVkpQ==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr11123784wma.68.1544455739331; 
 Mon, 10 Dec 2018 07:28:59 -0800 (PST)
Received: from localhost.localdomain
 (astlambert-681-1-52-199.w90-86.abo.wanadoo.fr. [90.86.17.199])
 by smtp.gmail.com with ESMTPSA id o64sm21336637wmo.47.2018.12.10.07.28.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 07:28:58 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: mm: skip cleaning of idmap page tables on LPAE capable
 cores
Date: Mon, 10 Dec 2018 16:28:55 +0100
Message-Id: <20181210152855.3634-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_072912_149933_A4F9C391 
X-CRM114-Status: GOOD (  15.01  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, init_static_idmap() installs some page table entries to
cover the identity mapped part of the kernel image (which is only
about 160 bytes in size in a multi_v7_defconfig Thumb2 build), and
calls flush_cache_louis() to ensure that the updates are visible
to the page table walker on the same core.

When running under virtualization, flush_cache_louis() may take more
than 10 seconds to complete:

[    0.108192] Setting up static identity map for 0x40300000 - 0x403000a0
[   13.078127] rcu: Hierarchical SRCU implementation.

This is due to the fact that set/way ops are not virtualizable, and so
KVM may trap each one, resulting in a substantial delay.

Since only LPAE capable CPUs may execute under virtualization, and
considering that LPAE capable CPUs are guaranteed to have cache
coherent page table walkers (per the architecture), let's only
perform this cache maintenance on non-LPAE cores.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mm/idmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 1d1edd064199..a033f6134a64 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -6,6 +6,7 @@
 
 #include <asm/cputype.h>
 #include <asm/idmap.h>
+#include <asm/hwcap.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
@@ -110,7 +111,8 @@ static int __init init_static_idmap(void)
 			     __idmap_text_end, 0);
 
 	/* Flush L1 for the hardware to see this page table content */
-	flush_cache_louis();
+	if (!(elf_hwcap & HWCAP_LPAE))
+		flush_cache_louis();
 
 	return 0;
 }
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
