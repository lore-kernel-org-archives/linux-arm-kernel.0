Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE375C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:02:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEF42087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u2zCEnYq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTuPjW5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEF42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Cgeu9IDZ5eDA80H7DnQCsbeZUw75+p0nAaIxkwYppP8=; b=u2zCEnYqh6ZIs8
	6hpR3EGiJCGqxMBAwklrqj63MxhKo7ywSN8g9JIysqeWwU849XETRiJgXCoqDr4zFQPEkMqj+s/HG
	ul2KzGmp5qouBl8tcQVTa8eJGQuFxxtJ4l67lzwrFFp9VaZffEt2JP787rSu9ztIUdPr9rsGBw3Oo
	3tA61Kl6VHcRuYn5cL1e+VymeIdMxXUCpYSLXsb9lCtIP7QqXIvbt0BFB4/2NZtkE2PLFGSGvKHdP
	rOzJh43oRxEcOWKjw4//PYoJ23czXYoZc3Ots1nGgC2L4v6Tpp/guBMmchXUc1HYdX3HcKQuW+Jcm
	WIKQVarr/R3M8GqV7Bfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVqD-0006uG-Rc; Tue, 29 Jan 2019 16:02:25 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVq7-0006tV-EK
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:02:23 +0000
Received: by mail-wm1-x343.google.com with SMTP id p6so18350080wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 08:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hZo5cnYA2LMW+KRzEkpP91TinvaP53HQziJxPDha+Yg=;
 b=FTuPjW5S+W4lBBxUleRC84wtvKriSmpU3r1RMBCIL2y3+dQUzFeX0WGLeZLzdix7E/
 10RnCKJ+Lqu7OFHT7QXCUGuK4dNZ3m2X4EUmCLIIy0NhXomz2CfnI/TpsI9TVBLf7Kn1
 MrsP6QedgCiQwR7EXpZpradZviAVNQMPzQjRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hZo5cnYA2LMW+KRzEkpP91TinvaP53HQziJxPDha+Yg=;
 b=NpYcI10LNIPxJmvKZ/Vq19VUqBLJ7N8BRoCdiSz6y/aQ9evypdKrho/a2hmvHcohll
 a9o1IrdI/7w0JHzml9bzc8mPCYCOiESN8/wI1SNjDiRbklKtlzM2qXqDGVbk9jN26pyt
 tbTuy+N25xy/9haEHz7YQH0exLjdnugEXSeXHBTg/zN9XpnpJ4wfXd14vLqheAQrxSDx
 huL2dE8I6vmyTQp+KGKKpoDgg6PPG+cB++YGfqO8k3105jebi5vl+Uj9krOO9pzdpUQR
 Mp8YdOO45CzAfHuxmhjAkqotLCgwN9PuHARIivMmoWEM7eACx5MOwH7J0QbSJbDfu6Pv
 UXvQ==
X-Gm-Message-State: AJcUukds9rBYjHPvrNzkYD+83boW629josM2yECuKMPHRX9OKN3v/2Mz
 K8M+UAxLFSYE4F81YB/fQz0qqg==
X-Google-Smtp-Source: ALg8bN74v3bMU7iJ0oBMayl0+9a4FaXjkySGa7cK425JYWtEfSCMMbPX25Bu2cgYbhkOse/PmuBVuQ==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr22509434wmg.75.1548777737370; 
 Tue, 29 Jan 2019 08:02:17 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-39-7.w90-86.abo.wanadoo.fr. [90.86.94.7])
 by smtp.gmail.com with ESMTPSA id 127sm5347414wmm.45.2019.01.29.08.02.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 08:02:15 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v2] acpi: bgrt: parse BGRT to obtain BMP address before it
 gets clobbered
Date: Tue, 29 Jan 2019 17:00:52 +0100
Message-Id: <20190129160052.2058-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_080219_492443_92E6B609 
X-CRM114-Status: GOOD (  23.05  )
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
 linux-efi@vger.kernel.org, michael.d.kinney@intel.com,
 harry.l.hsiung@intel.com, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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
v2:
- Reshuffle the code a bit so we never leave things mapped on an error.
  This should fix the two issues spotted by Lorenzo.
- use R/O mappings for all the tables

There was some discussion regarding parsing the status field, but that
is a separate change in any case, so I have ignored that for now.

If there are no further concerns, I intend to get this queued for
v5.1 by the end of the week.

 arch/arm64/kernel/acpi.c        |  2 -
 arch/x86/kernel/acpi/boot.c     |  2 -
 drivers/acpi/bgrt.c             |  6 --
 drivers/firmware/efi/efi-bgrt.c | 84 ++++++++++++++++++--
 drivers/firmware/efi/efi.c      | 13 +++
 include/linux/efi-bgrt.h        |  4 +-
 6 files changed, 92 insertions(+), 19 deletions(-)

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
index b22ccfb0c991..b2d98e16c7bf 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -27,24 +27,94 @@ struct bmp_header {
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
+	u64 xsdt_phys = 0;
+	u32 rsdt_phys = 0;
+	unsigned long len;
 
-	if (acpi_disabled)
+	if (!efi_enabled(EFI_MEMMAP))
 		return;
 
-	if (!efi_enabled(EFI_MEMMAP))
+	/* map the root pointer table to find the xsdt/rsdt values */
+	rsdp = early_memremap_ro(rsdp_phys, sizeof(*rsdp));
+	if (rsdp) {
+		if (ACPI_VALIDATE_RSDP_SIG(rsdp->signature)) {
+			xsdt_phys = rsdp->xsdt_physical_address;
+			rsdt_phys = rsdp->rsdt_physical_address;
+		}
+		early_memunmap(rsdp, sizeof(*rsdp));
+	}
+
+	if (WARN_ON(!xsdt_phys && !rsdt_phys))
 		return;
 
-	if (table->length < sizeof(bgrt_tab)) {
-		pr_notice("Ignoring BGRT: invalid length %u (expected %zu)\n",
-		       table->length, sizeof(bgrt_tab));
+	/* obtain the length of whichever table we will be using */
+	hdr = early_memremap_ro(xsdt_phys ?: rsdt_phys, sizeof(*hdr));
+	if (WARN_ON(!hdr))
+		return;
+	len = hdr->length;
+	early_memunmap(hdr, sizeof(*hdr));
+
+	/* remap with the correct length */
+	hdr = early_memremap_ro(xsdt_phys ?: rsdt_phys, len);
+	if (WARN_ON(!hdr))
+		return;
+
+	if (xsdt_phys) {
+		struct acpi_table_xsdt *xsdt = (void *)hdr;
+		int i;
+
+		for (i = 0; i < (len - sizeof(*hdr)) / sizeof(u64); i++) {
+			table = early_memremap_ro(xsdt->table_offset_entry[i],
+						  sizeof(*table));
+			if (WARN_ON(!table))
+				break;
+
+			if (ACPI_COMPARE_NAME(table->header.signature,
+					      ACPI_SIG_BGRT))
+				break;
+			early_memunmap(table, sizeof(*table));
+			table = NULL;
+		}
+	} else if (rsdt_phys) {
+		struct acpi_table_rsdt *rsdt = (void *)hdr;
+		int i;
+
+		for (i = 0; i < (len - sizeof(*hdr)) / sizeof(u32); i++) {
+			table = early_memremap_ro(rsdt->table_offset_entry[i],
+						  sizeof(*table));
+			if (WARN_ON(!table))
+				break;
+
+			if (ACPI_COMPARE_NAME(table->header.signature,
+					      ACPI_SIG_BGRT))
+				break;
+			early_memunmap(table, sizeof(*table));
+			table = NULL;
+		}
+	}
+	early_memunmap(hdr, len);
+
+	if (!table)
 		return;
+
+	len = table->header.length;
+	memcpy(bgrt, table, min(len, sizeof(bgrt_tab)));
+	early_memunmap(table, sizeof(*table));
+
+	if (len < sizeof(bgrt_tab)) {
+		pr_notice("Ignoring BGRT: invalid length %lu (expected %zu)\n",
+		       len, sizeof(bgrt_tab));
+		goto out;
 	}
-	*bgrt = *(struct acpi_table_bgrt *)table;
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
