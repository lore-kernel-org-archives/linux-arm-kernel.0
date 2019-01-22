Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C10AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:06:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97F420879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fJ5kM092";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2Li2h6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97F420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bcJy9Cd+oVljPa1qIV30XfhS9TLhfK2GvbLWRni9paA=; b=fJ5kM092EN7G78
	QkKs8I9Mld9677bhjl9NQN3WKMY+A9nySlpOd6fzTvygO2bL6UAjCUWWOfpXqhLVBqQ4mMa7H8xTG
	RKzbN54imo4OtPTpnDEX1dHr1nQkWPsLoGyJR5FtOI/xaAdpy7WWGtT2xsX6vehMgf1Pi7m6ryNew
	VmAC4FE3/z7B2KLDyBjBPhEwWlOFpCyHnNDRUzZxLAodPyOw5qwWhj7nE1eghPlVZ4VcwWz17h//H
	0tATyncJQKaVPxmXx98tLmYJNDqukJWlRUgPaCDPI3KDP9IafAkuskCZ/+fBGXnGChdnO2or2ANRA
	TSqcTzQT0mWmgxaEq9ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxdM-0004p6-IS; Tue, 22 Jan 2019 15:06:36 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxdJ-0004ok-4h
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:06:34 +0000
Received: by mail-wm1-x341.google.com with SMTP id b11so14493584wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UOYKuSL5Mc3+i6V5yuN8VGLaRYUHqSjx2EoNQxQQYCw=;
 b=b2Li2h6bMiShx34TjIsFU/nm1RM4QxumLNL/RbWat606XkA11x17nbXRzYoh5KGPPA
 ORLFLzGm7kBro+GJ40vArFXa2F1z3/NQ8shK0F17NzNtrWfZSKsETzMF7acQGhDcU+pI
 Oxzfu3Znc93LtjyebaEon3IrQkpIQurTiFjlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UOYKuSL5Mc3+i6V5yuN8VGLaRYUHqSjx2EoNQxQQYCw=;
 b=bv894KLnwBy+asWxdzt/tfDoTOgqZn50w6dDPubTwFZBkA7cONAG15ZWqPU3itMkD6
 hhd329I6kviEw9mEiP2tdaYgJl3EqddorPmlr+3CNOop/t1GSXzKV8TLCbsewv1+MI0U
 xTM1LD+JGNJO0vTtyhflNmxmGj/k8CqSvQKWktkwbUl571TyFf4eEnxK90JSIgw78rFB
 N6lCqro1tUUYKJWWpFBF9qzm9UkvSGHdr8Za4NooxJe5ZYmhxuaBQs41Hc5LqKvA0xIo
 b/8gOZFeebhjSKQwK8/9xR3BF+EzAtCYPslKc4zFhRVEV/SpH4zF8aU7W6g8yQZqbkLr
 3Vew==
X-Gm-Message-State: AJcUukf+2rIA3nEgzAmjEISQQ6E57lbmYGhpuxBmp1CDyWVDcIT4DQa+
 NWBrV6S/X0e6UPp/AsfIL+Bgtw==
X-Google-Smtp-Source: ALg8bN778/QAvszzjrPefLp7Sg27rTv6cYDlCMvQUL7TtD/bAxqlieXj/VXRity2byy0v3PrEgcF+Q==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr4264519wmj.90.1548169590997; 
 Tue, 22 Jan 2019 07:06:30 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id b7sm88575484wrs.47.2019.01.22.07.06.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 07:06:30 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: bgrt: parse BGRT to obtain BMP address before it gets
 clobbered
Date: Tue, 22 Jan 2019 16:06:16 +0100
Message-Id: <20190122150616.850-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_070633_190013_BE0DEC34 
X-CRM114-Status: GOOD (  21.11  )
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
Cc: lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Jones <pjones@redhat.com>,
 rjw@rjwysocki.net, leif.lindholm@linaro.org, astone@redhat.com,
 linux-efi@vger.kernel.org, harry.l.hsiung@intel.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The bitmap left in the framebuffer by the firmware is described by an
ACPI table called "BGRT", which describes the size, pixel format and
the address of a BMP image in memory. While the BGRT ACPI table is
guaranteed to reside in a "ACPI reclaim" memory region, which is
never touched by Linux. The BMP image, however, typically resides
in EFI Boot Services Memory, which may have been overwritten by the
time the BGRT discovery routine runs.

So instead, drop the handling from the ACPI init code, and call the
BGRT parsing code immediately after going over the EFI configuration
table array, at which time no memory has been touched yet except for
the .data/.bss regions covered by the static kernel image.

Unfortunately, this involves a non-trivial amount of ACPI entry
point and root table parsing, but we cannot rely on the normal
ACPI infrastructure yet this early in the boot.

Also note that we cannot take the 'acpi_disabled' global variable
into account, since it may not have assumed the correct value yet
(on arm64, the default value is '1' which is overridden to '0' if
no DT description has been made available by the firmware)

Cc: Peter Jones <pjones@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/acpi.c        |  2 -
 arch/x86/kernel/acpi/boot.c     |  2 -
 drivers/acpi/bgrt.c             |  6 --
 drivers/firmware/efi/efi-bgrt.c | 80 ++++++++++++++++++--
 drivers/firmware/efi/efi.c      | 13 ++++
 include/linux/efi-bgrt.h        |  4 +-
 6 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 44e3c351e1ea..7429a811f76d 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -230,8 +230,6 @@ void __init acpi_boot_table_init(void)
 			early_init_dt_scan_chosen_stdout();
 	} else {
 		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
-		if (IS_ENABLED(CONFIG_ACPI_BGRT))
-			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 	}
 }
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2624de16cd7a..2d3535b62752 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1633,8 +1633,6 @@ int __init acpi_boot_init(void)
 	acpi_process_madt();
 
 	acpi_table_parse(ACPI_SIG_HPET, acpi_parse_hpet);
-	if (IS_ENABLED(CONFIG_ACPI_BGRT))
-		acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 
 	if (!acpi_noirq)
 		x86_init.pci.init = pci_acpi_init;
diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index 75af78361ce5..048413e06898 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -81,12 +81,6 @@ static const struct attribute_group bgrt_attribute_group = {
 	.bin_attrs = bgrt_bin_attributes,
 };
 
-int __init acpi_parse_bgrt(struct acpi_table_header *table)
-{
-	efi_bgrt_init(table);
-	return 0;
-}
-
 static int __init bgrt_init(void)
 {
 	int ret;
diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index b22ccfb0c991..8bd9b96942d2 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -27,24 +27,92 @@ struct bmp_header {
 	u32 size;
 } __packed;
 
-void __init efi_bgrt_init(struct acpi_table_header *table)
+void __init efi_bgrt_init(unsigned long rsdp_phys)
 {
 	void *image;
 	struct bmp_header bmp_header;
 	struct acpi_table_bgrt *bgrt = &bgrt_tab;
+	struct acpi_table_bgrt *table = NULL;
+	struct acpi_table_rsdp *rsdp;
+	struct acpi_table_header *hdr;
+	u64 xsdt_phys;
+	u32 rsdt_phys;
+	unsigned int len;
 
-	if (acpi_disabled)
+	if (!efi_enabled(EFI_MEMMAP))
 		return;
 
-	if (!efi_enabled(EFI_MEMMAP))
+	/* map the root pointer table to find the xsdt/rsdt values */
+	rsdp = early_memremap(rsdp_phys, sizeof(*rsdp));
+	if (rsdp && ACPI_VALIDATE_RSDP_SIG(rsdp->signature)) {
+		xsdt_phys = rsdp->xsdt_physical_address;
+		rsdt_phys = rsdp->rsdt_physical_address;
+	} else {
+		WARN_ON(1);
+		return;
+	}
+	early_memunmap(rsdp, sizeof(*rsdp));
+
+	/* obtain the length of whichever table we will be using */
+	hdr = early_memremap(xsdt_phys ?: rsdt_phys, sizeof(*hdr));
+	if (WARN_ON(!hdr))
+		return;
+	len = hdr->length;
+	early_memunmap(hdr, sizeof(*hdr));
+
+	if (xsdt_phys) {
+		struct acpi_table_xsdt *xsdt = early_memremap(xsdt_phys, len);
+		int i;
+
+		if (WARN_ON(!xsdt))
+			return;
+
+		for (i = 0; i < (len - sizeof(*hdr)) / sizeof(u64); i++) {
+			table = early_memremap(xsdt->table_offset_entry[i],
+					       sizeof(*table));
+			if (WARN_ON(!table))
+				break;
+
+			if (ACPI_COMPARE_NAME(table->header.signature,
+					      ACPI_SIG_BGRT))
+				break;
+			early_memunmap(table, sizeof(*table));
+			table = NULL;
+		}
+		early_memunmap(xsdt, len);
+	} else if (rsdt_phys) {
+		struct acpi_table_rsdt *rsdt = early_memremap(rsdt_phys, len);
+		int i;
+
+		if (WARN_ON(!rsdt))
+			return;
+
+		for (i = 0; i < (len - sizeof(*hdr)) / sizeof(u32); i++) {
+			table = early_memremap(rsdt->table_offset_entry[i],
+					       sizeof(*table));
+			if (WARN_ON(!table))
+				break;
+
+			if (ACPI_COMPARE_NAME(table->header.signature,
+					      ACPI_SIG_BGRT))
+				break;
+			early_memunmap(table, sizeof(*table));
+			table = NULL;
+		}
+		early_memunmap(rsdt, len);
+	}
+
+	if (!table)
 		return;
 
-	if (table->length < sizeof(bgrt_tab)) {
+	if (table->header.length < sizeof(bgrt_tab)) {
 		pr_notice("Ignoring BGRT: invalid length %u (expected %zu)\n",
-		       table->length, sizeof(bgrt_tab));
+		       table->header.length, sizeof(bgrt_tab));
 		return;
 	}
-	*bgrt = *(struct acpi_table_bgrt *)table;
+	*bgrt = *table;
+	early_memunmap(table, sizeof(*table));
+
 	if (bgrt->version != 1) {
 		pr_notice("Ignoring BGRT: invalid version %u (expected 1)\n",
 		       bgrt->version);
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4c46ff6f2242..e5ef5c0eacc1 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/efi.h>
+#include <linux/efi-bgrt.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/io.h>
@@ -592,6 +593,18 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		early_memunmap(tbl, sizeof(*tbl));
 	}
+
+	/*
+	 * We need to parse the BGRT table (which is an ACPI table not a UEFI
+	 * configuration table) by hand and figure out where the bitmap it
+	 * describes lives in memory so we can reserve it early on. Otherwise,
+	 * it may be clobbered by the time we get to it during the ordinary ACPI
+	 * table init sequence.
+	 */
+	if (IS_ENABLED(CONFIG_ACPI_BGRT) &&
+	    efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+		efi_bgrt_init(efi.acpi20);
+
 	return 0;
 }
 
diff --git a/include/linux/efi-bgrt.h b/include/linux/efi-bgrt.h
index e6cd51005633..528ea62d99ec 100644
--- a/include/linux/efi-bgrt.h
+++ b/include/linux/efi-bgrt.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_ACPI_BGRT
 
-void efi_bgrt_init(struct acpi_table_header *table);
+void efi_bgrt_init(unsigned long rsdp_phys);
 int __init acpi_parse_bgrt(struct acpi_table_header *table);
 
 /* The BGRT data itself; only valid if bgrt_image != NULL. */
@@ -15,7 +15,7 @@ extern struct acpi_table_bgrt bgrt_tab;
 
 #else /* !CONFIG_ACPI_BGRT */
 
-static inline void efi_bgrt_init(struct acpi_table_header *table) {}
+static inline void efi_bgrt_init(unsigned long rsdp_phys) {}
 static inline int __init acpi_parse_bgrt(struct acpi_table_header *table)
 {
 	return 0;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
