Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B139DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2ED2192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E+hdImnO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or0Bgq02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2ED2192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FEt5ZYVo/DOy51dAjthh/whW23J0gcj0jEka+3Ur+BU=; b=E+hdImnOcs9Ng+
	TlFXOexQCtk0VbnKADW0WpYMm/LJ7M0VGKLE2ACiFGME6ZueOrMC5ZKZSRd+W7KOZXZN5RWZ7v7bu
	XMnQeshFQwVXCHkZJFC1eQg7pbY2xkPYywJ9V0qCGnaxDelVkv95T0XbiEanJ9ETvMGjjyDQ/BwE1
	2cGrKsYfIpYWxrxFBGVVmU3s1dNDOwlUEebCbo/u9CKkDYg7yNTrQ0HII1HIxlVDCoLqKIvxphqIw
	QHkyi8drcdWs95g+W17Zr/9iA+ieHfuj/IYnG5OPpKBdQpfbIpRyUMcKqFGswM0Zf16rBxnyt67hu
	Q0sDlWNjpabFOIxPtQWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guciC-0007lo-2A; Fri, 15 Feb 2019 12:35:24 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guci1-0007bz-GO
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:35:15 +0000
Received: by mail-wr1-x441.google.com with SMTP id v16so10141414wrn.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 04:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E9XvbP3q/Notg42vlwN25xZrwhT5Enb4lH/EsK0IncY=;
 b=Or0Bgq02ZY0qWqKiUkzPKNov6a/Q4YjPvl3EGGQc5U3Kb08erVsAndV9zUC1DM2985
 YRD5HtKTFwHzSw5q3yHyGONIFaq6Dvgp8tF4JVybWWSWxYDPXP3krYM62JroTbagB47j
 f6X8KxSUCvVJgoWHNa6+u2FdHEI1A+TezX3Tz1CTpQ2iFNKJMnJcK8lbVCz10jEexjEc
 I6+OJnQ69wwk8bzqdDW8WAIVldCPyCj/NgDSHIcQah4hagCExU7djTMgKFEDEl9Q/7rW
 eIBuIjBfkroSw0TNJTc/G+vKNoDyzYhIE+ORcH5wOp4k3BB5BuuBiQ+l1Yr3LDEjgN3c
 sAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E9XvbP3q/Notg42vlwN25xZrwhT5Enb4lH/EsK0IncY=;
 b=JTz+79XH2NTvx7/TxQj+I0aIF5kO/BmjKSCYuqQR2pMVCLILoBgKLBWyYAPduUfCxC
 RzrdgAzOqy/lPQm+zxa1TN0k6z9TUODrkJVyQinWn9EXhyB+r5qbkUSMx6UQPxL1+GQv
 1kRzMCRVYjSXSZR0xuxlBEtDwctEmC2AjiU8mtFZ0Ilq/U0wkVMwyk621Mu4IWko11lo
 MDXfO0GVkZ6XHagiG2XVh/g94XtPtWJTZVlswaDUg1HdD5BeXEdpwmvvosaf9w7zEq8d
 4XKCTWBNDCugOV/UJIGpjJUPQDk2xH2cdi5IOZYZd4ai9oGBHzvf2zR7znASBog4CtQT
 aoug==
X-Gm-Message-State: AHQUAuY1RtFNtK4Oq4iWvhDwM6Ts4yA3wknwnSTONKhrFur7+fJ81ETI
 oZbSgvKUOJdnYOr0e4vNINsFA6NoqwU=
X-Google-Smtp-Source: AHgI3Ia0V0oIs9whIxqvFzynyPSYDBBbEeYAogPOVKTT+A0weNNJxri66roozxRtk3RqOD44fgI1Ug==
X-Received: by 2002:a5d:6810:: with SMTP id w16mr6703382wru.62.1550234110537; 
 Fri, 15 Feb 2019 04:35:10 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id y13sm636673wrw.31.2019.02.15.04.35.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 04:35:09 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/2] arm64: account for GICv3 LPI tables in static memblock
 reserve table
Date: Fri, 15 Feb 2019 13:33:32 +0100
Message-Id: <20190215123333.21209-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
References: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_043513_542585_20941545 
X-CRM114-Status: GOOD (  17.09  )
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
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In the irqchip and EFI code, we have what basically amounts to a quirk
to work around a peculiarity in the GICv3 architecture, which permits
the system memory address of LPI tables to be programmable only once
after a CPU reset. This means kexec kernels must use the same memory
as the first kernel, and thus ensure that this memory has not been
given out for other purposes by the time the ITS init code runs, which
is not very early for secondary CPUs.

On systems with many CPUs, these reservations could overflow the
memblock reservation table, and this was addressed in commit
eff896288872 ("efi/arm: Defer persistent reservations until after
paging_init()"). However, this turns out to have made things worse,
since the allocation of page tables and heap space for the resized
memblock reservation table itself may overwrite the regions we are
attempting to reserve, which may cause all kinds of corruption,
also considering that the ITS will still be poking bits into that
memory in response to incoming MSIs.

So instead, let's grow the static memblock reservation table on such
systems so it can accommodate these reservations at an earlier time.
This will permit us to revert the above commit in a subsequent patch.

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 11 +++++++++++
 include/linux/memblock.h        |  3 ---
 mm/memblock.c                   | 10 ++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e1ec947e7c0c..ada877f56551 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -332,6 +332,17 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_addr_valid(kaddr)		\
 	(_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
 
+/*
+ * Given that the GIC architecture permits ITS implementations that can only be
+ * configured with a LPI table address once, GICv3 systems with many CPUs may
+ * end up reserving a lot of different regions after a kexec for their LPI
+ * tables (one per CPU), as we are forced to reuse the same memory after kexec
+ * (and thus reserve it persistently with EFI beforehand)
+ */
+#if defined(CONFIG_EFI) && defined(CONFIG_ARM_GIC_V3_ITS)
+#define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
+#endif
+
 #include <asm-generic/memory_model.h>
 
 #endif
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 64c41cf45590..859b55b66db2 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -29,9 +29,6 @@ extern unsigned long max_pfn;
  */
 extern unsigned long long max_possible_pfn;
 
-#define INIT_MEMBLOCK_REGIONS	128
-#define INIT_PHYSMEM_REGIONS	4
-
 /**
  * enum memblock_flags - definition of memory region attributes
  * @MEMBLOCK_NONE: no special request
diff --git a/mm/memblock.c b/mm/memblock.c
index 022d4cbb3618..a526c3ab8390 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -26,6 +26,12 @@
 
 #include "internal.h"
 
+#define INIT_MEMBLOCK_REGIONS		128
+#define INIT_PHYSMEM_REGIONS		4
+#ifndef INIT_MEMBLOCK_RESERVED_REGIONS
+#define INIT_MEMBLOCK_RESERVED_REGIONS	INIT_MEMBLOCK_REGIONS
+#endif
+
 /**
  * DOC: memblock overview
  *
@@ -92,7 +98,7 @@ unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
-static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
+static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS] __initdata_memblock;
 #endif
@@ -105,7 +111,7 @@ struct memblock memblock __initdata_memblock = {
 
 	.reserved.regions	= memblock_reserved_init_regions,
 	.reserved.cnt		= 1,	/* empty dummy entry */
-	.reserved.max		= INIT_MEMBLOCK_REGIONS,
+	.reserved.max		= INIT_MEMBLOCK_RESERVED_REGIONS,
 	.reserved.name		= "reserved",
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
