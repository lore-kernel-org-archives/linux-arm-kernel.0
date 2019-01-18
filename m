Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CD4C07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:43:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13152086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PxnQ63k0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAMqzaKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13152086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IIbvzrLueN9dkDtFeLY9uXFH78zEoyhcy6GxlZRKVk0=; b=PxnQ63k02O+LZD
	z1+6A8mqVjgpEw+dhsvSBHeZ8NsiRPJcxt5NUUNuTQaSqtceq/0fVyUYsPEx216F4uBQ0nYjgNh5f
	tStalGVQsLXsbib3gqC+A8KHl/G5XZ9PgIeoDpsMiWdAq5fPeV43r/GszYWrVfseSHi75I43ko5hQ
	mCLlemADk0VNBV4fV9beuneuVvWb6jH7nocgaBbNVu28cCSjDv/WP4DWq5IattGM989IM8uf8zTWY
	JyyJosB7fPjV9qDoB9GWEIQgmgQ6gJJtixJ3wKgQkeL4Rn0z5dCDnBgy+NWDB7Zve8xJK4vEcWxvi
	k8Da5RPeJve0KxMRLiUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkYB6-0005Gx-MJ; Fri, 18 Jan 2019 17:43:36 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkYB2-0005GR-LN
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:43:34 +0000
Received: by mail-wm1-x343.google.com with SMTP id p6so5275675wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a6+Clyh2qycxFQiZuNwnPZ0jw6xK3RnFgEnN9Oqcwgw=;
 b=SAMqzaKs27Fzh2OuJSq/2LVYsCubePLLbhCpbL2XxCbQiDq2S4HCWjMCP1LnbVJZys
 kS7uMIyxHLQVkKXy2+BJ+Hmo6lPp4ZleNlsJaSD0gUtiHxpY/mr+boUnS9sW2v5pNPOp
 o8EQDedv08r2MTnMvnbgvyAF3lmSv/gIyM8Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a6+Clyh2qycxFQiZuNwnPZ0jw6xK3RnFgEnN9Oqcwgw=;
 b=k+t4hL5bYXvt7Exb4c/sBcww2i9H7jnJe7BgNbJoXlcOa+ix0Hy6JTkxXJKWc6U+/R
 lKBrqrUfqf9CE1ewgxIve+wZtQhl7u7j4h815pERDWNSiQ4fwMWZI/CRWCkNWz1Zp8Rt
 TFU9C39XQx6d+7ZFC/YMu+53K0TX6TGs+Am9Vrxkcf/GqdSQD+/qAUQsgbKxeVNe3ED1
 XkwqZU58n55qy+QBtSzHcKmuhGArX2TI7dIfGqJzweLI5OyWjma7Gt24Ws6crvjQ2o2Q
 H0mFxS322zimud/12BjKwby8mUbwueo7fXtzTSKEPeeoe5dwvk7w4BG5ueCUupOe4iD3
 iUVQ==
X-Gm-Message-State: AJcUukdUDPh+fnHs5Qx5B2fhZvlhLoiegGDnadBVBCNetDXd7QRIoi5Q
 TOXyJCebDw1ajDe9LHuGbQz0aA==
X-Google-Smtp-Source: ALg8bN7G5Gua92xpYoaubBs7rbuXhv59/3qh0r8b1FhUs2GMnOZQSKWzQ1YXKp528zkPTecBYL5gaQ==
X-Received: by 2002:a1c:81ca:: with SMTP id c193mr17412341wmd.66.1547833409755; 
 Fri, 18 Jan 2019 09:43:29 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id v6sm68735424wro.57.2019.01.18.09.43.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:43:28 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [RFC PATCH] arm64: efi: fix chicken-and-egg problem in memreserve code
Date: Fri, 18 Jan 2019 18:43:24 +0100
Message-Id: <20190118174324.24715-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_094332_696838_F120D8AD 
X-CRM114-Status: GOOD (  21.85  )
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
Cc: mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Unfortunately, it appears that the recently introduced and repaired
EFI memreserve code is still broken.

Originally, we applied all memory reservation passed via the EFI table
before doing any memblock allocations. However, this turned out to be
problematic, given that the number of reservations is unbounded, and
a GICv3 system will reserve a block of memory for each CPU, resulting
in hundreds of reservations.

We 'fixed' this by deferring the reservations in the memblock table
until after we enabled memblock resizing. However, to reach this
point, we must have mapped DRAM and the kernel, which itself relies
on some memblock allocations for page tables. Also, memblock resizing
itself relies on the ability to invoke memblock_alloc() to reallocate
those tables themselves.

So this is a nice chicken-and-egg problem which is rather difficult
to fix cleanly. So instead of a clean solution, I came up with the
patch below.

The idea is to set a memblock allocation limit below the lowest
reservation entry that occurs in the memreserve table. This way,
we can map DRAM and the kernel and enable memblock resizing without
running the risk of clobbering those reserved regions. After applying
all the reservations, the memblock limit restriction is lifted again,
allowing the boot to proceed normally.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

The problem with this approach is that it is not guaranteed that the
temporary limit will leave enough memory to allocate the page tables
and resize the memblock reserved array. Since this is only 10s of KBs,
it is unlikely to break in practice, but some pathological behavior
may still occur, which is rather nasty :-(

 arch/arm64/include/asm/memblock.h |  1 +
 arch/arm64/kernel/setup.c         |  2 +-
 arch/arm64/mm/init.c              | 19 ++++++++++
 drivers/firmware/efi/efi.c        | 39 +++++++++++++++++++-
 include/linux/efi.h               |  7 ++++
 5 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memblock.h b/arch/arm64/include/asm/memblock.h
index 6afeed2467f1..461d093e67cf 100644
--- a/arch/arm64/include/asm/memblock.h
+++ b/arch/arm64/include/asm/memblock.h
@@ -17,5 +17,6 @@
 #define __ASM_MEMBLOCK_H
 
 extern void arm64_memblock_init(void);
+extern void arm64_memblock_post_paging_init(void);
 
 #endif
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4b0e1231625c..a76b165e3f16 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -313,7 +313,7 @@ void __init setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
-	efi_apply_persistent_mem_reservations();
+	arm64_memblock_post_paging_init();
 
 	acpi_table_upgrade();
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..6e95b52b5d07 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -355,6 +355,7 @@ static void __init fdt_enforce_memory_region(void)
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+	u64 memblock_limit;
 
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
@@ -399,6 +400,18 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
+	/*
+	 * Set a temporary memblock allocation limit so that we don't clobber
+	 * regions that we will want to reserve later. However, since the
+	 * number of reserved regions that can be described this way is
+	 * basically unbounded, we have to defer applying the actual
+	 * reservations until after we have mapped enough memory to allow
+	 * the memblock resize routines to run.
+	 */
+	efi_prepare_persistent_mem_reservations(&memblock_limit);
+	if (memblock_limit < memory_limit)
+		memblock_set_current_limit(memblock_limit);
+
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/*
 		 * Add back the memory we just removed if it results in the
@@ -666,3 +679,9 @@ static int __init register_mem_limit_dumper(void)
 	return 0;
 }
 __initcall(register_mem_limit_dumper);
+
+void __init arm64_memblock_post_paging_init(void)
+{
+	memblock_set_current_limit(memory_limit);
+	efi_apply_persistent_mem_reservations();
+}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4c46ff6f2242..643e38f5e200 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -595,11 +595,13 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 	return 0;
 }
 
-int __init efi_apply_persistent_mem_reservations(void)
+int __init efi_prepare_persistent_mem_reservations(u64 *lowest)
 {
 	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = efi.mem_reserve;
 
+		*lowest = U64_MAX;
+
 		while (prsv) {
 			struct linux_efi_memreserve *rsv;
 			u8 *p;
@@ -622,6 +624,41 @@ int __init efi_apply_persistent_mem_reservations(void)
 			/* reserve the entry itself */
 			memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
 
+			for (i = 0; i < atomic_read(&rsv->count); i++)
+				*lowest = min(*lowest, rsv->entry[i].base);
+
+			prsv = rsv->next;
+			early_memunmap(p, PAGE_SIZE);
+		}
+	}
+
+	return 0;
+}
+
+int __init efi_apply_persistent_mem_reservations(void)
+{
+	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
+		unsigned long prsv = efi.mem_reserve;
+
+		while (prsv) {
+			struct linux_efi_memreserve *rsv;
+			u8 *p;
+			int i;
+
+			/*
+			 * Just map a full page: that is what we will get
+			 * anyway, and it permits us to map the entire entry
+			 * before knowing its size.
+			 */
+			p = early_memremap(ALIGN_DOWN(prsv, PAGE_SIZE),
+					   PAGE_SIZE);
+			if (p == NULL) {
+				pr_err("Could not map UEFI memreserve entry!\n");
+				return -ENOMEM;
+			}
+
+			rsv = (void *)(p + prsv % PAGE_SIZE);
+
 			for (i = 0; i < atomic_read(&rsv->count); i++) {
 				memblock_reserve(rsv->entry[i].base,
 						 rsv->entry[i].size);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index be08518c2553..2ec2153fc12e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1212,6 +1212,7 @@ extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
 
 extern bool efi_is_table_address(unsigned long phys_addr);
 
+extern int efi_prepare_persistent_mem_reservations(u64 *lowest);
 extern int efi_apply_persistent_mem_reservations(void);
 #else
 static inline bool efi_enabled(int feature)
@@ -1232,6 +1233,12 @@ static inline bool efi_is_table_address(unsigned long phys_addr)
 	return false;
 }
 
+static inline int efi_prepare_persistent_mem_reservations(u64 *lowest)
+{
+	*lowest = U64_MAX;
+	return 0;
+}
+
 static inline int efi_apply_persistent_mem_reservations(void)
 {
 	return 0;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
