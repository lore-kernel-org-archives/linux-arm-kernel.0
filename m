Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53756C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:30:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219DD2075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RCnxZRwM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XaRXIc7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219DD2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YaJlNOcfmdOP6FMZi6bKaBuJVMzu2y0UY8ncf7Saiq0=; b=RCnxZRwMtDPyzq
	Mza2UmVQSO3EUMpKXICVq/O4Cqs0iFLhNDmj/YuueJUAET3CEHm04lXInWcQOy6QQBf9uu97RWGnK
	+es4dx4hfo5yBoV8b31q8+eWFx968x5mGN2ZGnzHhqLkHEVMkTlHQ+VY9tfOtoe0VxlgMIsaqHDle
	/hbsUlTR6SS1Fjag99GRxOFKWgmYsxZ69b+Gxu/gwZ1LjUgDMdekOqlOK2DKvMa5wJY6wbcjN6wHR
	AHcw73+Z3h0LGgEwCOEYhfadFdnUpWRH0vit12ZLuUR0OKTXikRhBpHFeEu8ZvTZ3Lqo+qDH7cz+Q
	QBQmu3mOkZmiRCvcTYaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtubr-0006yO-7D; Wed, 13 Feb 2019 13:29:55 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuac-0005Pk-7q
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:29:09 +0000
Received: by mail-wm1-x344.google.com with SMTP id d15so2450039wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 05:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pcq+KlYpunIsRMvl5N8urLfnQtGhYRhha0Fk42l8s1s=;
 b=XaRXIc7epzKjHIVTj6gNKn5+cxg7Ghkp8lZNxiYHbAyxUEaVN56j4iYJwSBGp4aE5+
 3QtsoOGwtDEjEIWOIxO1KELBeSJsoPvpZMWwAUZuWkbyE4hL/iaEYYytZI7LdiWJNp4F
 zBvvY+Cg6ZwoATNYw5MH5Bol6+5YIWz5bpQgSbmH95qUuNmW47KjjSJBZ0yhPWl3/7yh
 JPpMXlDJW78MtIMTb8ofOkCuN+g+myvHgWJD1FWwJfHAHrXvU72K/0lO18i4HwWZEBWN
 qH2ecbpVXEo0QXCAaOEjBKcKuOPjgBjuJN9UtejMwy8ysfzsSZ0ljex08BxoljXBg7NW
 WNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pcq+KlYpunIsRMvl5N8urLfnQtGhYRhha0Fk42l8s1s=;
 b=Iy87esLJV4ZHoAuzU4xGNBRdvw12SHxp3tCX1O8xaws1UP+FAMBeSA1pk5XhS1MU+p
 +s4w9A4lBbFr5cI74RLozaR95jVvYLhg5MTuEVjHGpn6RdJi0uAWd18YEQxi4AToDzPV
 hl1UJwckTDbCnGripOAyuwlN2jm5qe918GLGVn7GF02G34NkNb0xU99O6gyh1mvzhVEQ
 dw/MKmjq9hbLRrnxu2tKurxlIYQUSrlc9qxNF6EBHKhAsrCeWxWowHqUBSqh9oRErXFC
 wMH+/rBCPhnNJDdPuZQjPeQTa6BvnBZ0cnmD8IljYJsMeZmMJ+mp1aTJyBQZXJZ9v+pG
 HBrA==
X-Gm-Message-State: AHQUAubvgRbwTSyxL+mPtYYxpSu/fnf18sCFu4XxJYrB/Uig3AlE+iFG
 29Ud/FNLHnF62f7LuI5coKn/Cw==
X-Google-Smtp-Source: AHgI3IY0TrtAJNeV0o2sh6HPQrmepOLdzsvm4n2ugw3Q2kVjsFtdv4NzUra2Yf3t/+68plO2RUDw5A==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr339024wmj.1.1550064516723;
 Wed, 13 Feb 2019 05:28:36 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-27-200.w90-86.abo.wanadoo.fr. [90.86.252.200])
 by smtp.gmail.com with ESMTPSA id x3sm22841195wrd.19.2019.02.13.05.28.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 05:28:35 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH 1/2] arm64: account for GICv3 LPI tables in static memblock
 reserve table
Date: Wed, 13 Feb 2019 14:27:37 +0100
Message-Id: <20190213132738.10294-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213132738.10294-1-ard.biesheuvel@linaro.org>
References: <20190213132738.10294-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_052838_856792_BE1C9603 
X-CRM114-Status: GOOD (  17.88  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
 James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
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

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 11 +++++++++++
 include/linux/memblock.h        |  3 ---
 mm/memblock.c                   | 10 ++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e1ec947e7c0c..7e2b13cdd970 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -332,6 +332,17 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_addr_valid(kaddr)		\
 	(_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
 
+/*
+ * Given that the GIC architecture permits ITS implementations that can only be
+ * configured with a LPI table address once, GICv3 systems with many CPUs may
+ * end up reserving a lot of different regions after a kexec for their LPI
+ * tables, as we are forced to reuse the same memory after kexec (and thus
+ * reserve it persistently with EFI beforehand)
+ */
+#if defined(CONFIG_EFI) && defined(CONFIG_ARM_GIC_V3_ITS)
+#define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + 2 * NR_CPUS)
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
