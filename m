Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09599C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:23:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1982087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eEPWlGqB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQwoXI4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1982087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ycO009YJHNltldqXfg9TX9jLxv3uK2iurCWHSEB5FL8=; b=eEPWlGqBcxr5a3
	7Oq0Zkn7zdD71UGZbHpEZCcA6gcz5U6iamIBu5s47c3+0j7wgCtQ83tO6CWZFVE1Ww8+w/73xygSq
	lFYJGVMvmw5UKxQtC4Th6gztqzcYeuE8sv0VuNHx+mlOfWuYgsVm6dyCJkMdzxVsOlGfXQw6Nwrce
	vftfHZSWSzTRByPiOOOlwGjFSoaaerwIiLIxP/ruznf2eHdJPo1Ff4N43TvepZWR0cecma7xM3DPO
	LRwJMe9Yd+3cqcc5ouB9DG49Yui+rWgE37ItQXLxYjs6B4tnNpfMiTvxswBNT6XKEOAxS5BNzxSAb
	8sqbGJkEkhUe9j907p7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTss3-00062V-NG; Mon, 03 Dec 2018 18:23:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsrc-0005NH-Gw
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hg9/PBkd/JojkmEyrb+e6z1c3DIezwsNzyf9guMbWPs=; b=qQwoXI4pqJrXwgyG52p16ON+v6
 SHsvZNjmfikhXbcmCxwXouMF+UlLiTgr9gSLUPpHxuyRpF+DzqBimLgpcLzFPH+4Qlsh16Cmp+sFD
 te36FAzlWVh7Vyl3tBhtqvJ2A2URg69E+1rQEsP88pgJNSECy/WQqzW4nT7/4EqWT3nMMFAfkLdo9
 izp+LqZReT9J1BwAEuuEEGuJHshrE0IqGbLWPWUR1kyW/8mZLYeMoElRmMJKUmLwllj7aIH1bxQIg
 GeuhHv0EvgYwPZ25U/CM4Ofbc3Fhr/lyEmZF9MCp+7qIoSkBtQVK/A8Z4H1vMEDTZkRlBo/blr3Hf
 qQBj3eSA==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsdK-0001Hc-Lz
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D35571993;
 Mon,  3 Dec 2018 10:07:37 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F40A3F59C;
 Mon,  3 Dec 2018 10:07:34 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 17/25] ACPI / APEI: Pass ghes and estatus separately to
 avoid a later copy
Date: Mon,  3 Dec 2018 18:06:05 +0000
Message-Id: <20181203180613.228133-18-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_180751_022076_0D634CA9 
X-CRM114-Status: GOOD (  18.34  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The NMI-like notifications scribble over ghes->estatus, before
copying it somewhere else. If this interrupts the ghes_probe() code
calling ghes_proc() on each struct ghes, the data is corrupted.

All the NMI-like notifications should use a queued estatus entry
from the beginning, instead of the ghes version, then copying it.
To do this, break up any use of "ghes->estatus" so that all
functions take the estatus as an argument.

This patch just moves these ghes->estatus dereferences into separate
arguments, no change in behaviour. struct ghes becomes unused in
ghes_clear_estatus() as it only wanted ghes->estatus, which we now
pass directly. This is removed.

Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v6:
 * Changed subject
 * Renamed ghes_estatus to src_estatus, which is a little clearer
 * Removed struct ghes from ghes_clear_estatus() now that this becomes
   unused in this patch.
 * Mangled the commit message to be different
---
 drivers/acpi/apei/ghes.c | 84 +++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b5c31f65a1c0..b70f5fd962cc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -277,8 +277,9 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 	}
 }
 
-static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr, int fixmap_idx)
-
+static int ghes_read_estatus(struct ghes *ghes,
+			     struct acpi_hest_generic_status *estatus,
+			     u64 *buf_paddr, int fixmap_idx)
 {
 	struct acpi_hest_generic *g = ghes->generic;
 	u32 len;
@@ -295,25 +296,25 @@ static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr, int fixmap_idx)
 	if (!*buf_paddr)
 		return -ENOENT;
 
-	ghes_copy_tofrom_phys(ghes->estatus, *buf_paddr,
-			      sizeof(*ghes->estatus), 1, fixmap_idx);
-	if (!ghes->estatus->block_status) {
+	ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
+			      fixmap_idx);
+	if (!estatus->block_status) {
 		*buf_paddr = 0;
 		return -ENOENT;
 	}
 
 	rc = -EIO;
-	len = cper_estatus_len(ghes->estatus);
-	if (len < sizeof(*ghes->estatus))
+	len = cper_estatus_len(estatus);
+	if (len < sizeof(*estatus))
 		goto err_read_block;
 	if (len > ghes->generic->error_block_length)
 		goto err_read_block;
-	if (cper_estatus_check_header(ghes->estatus))
+	if (cper_estatus_check_header(estatus))
 		goto err_read_block;
-	ghes_copy_tofrom_phys(ghes->estatus + 1,
-			      *buf_paddr + sizeof(*ghes->estatus),
-			      len - sizeof(*ghes->estatus), 1, fixmap_idx);
-	if (cper_estatus_check(ghes->estatus))
+	ghes_copy_tofrom_phys(estatus + 1,
+			      *buf_paddr + sizeof(*estatus),
+			      len - sizeof(*estatus), 1, fixmap_idx);
+	if (cper_estatus_check(estatus))
 		goto err_read_block;
 	rc = 0;
 
@@ -325,12 +326,13 @@ static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr, int fixmap_idx)
 	return rc;
 }
 
-static void ghes_clear_estatus(struct ghes *ghes, u64 buf_paddr, int fixmap_idx)
+static void ghes_clear_estatus(struct acpi_hest_generic_status *estatus,
+			       u64 buf_paddr, int fixmap_idx)
 {
-	ghes->estatus->block_status = 0;
+	estatus->block_status = 0;
 	if (buf_paddr)
-		ghes_copy_tofrom_phys(ghes->estatus, buf_paddr,
-				      sizeof(ghes->estatus->block_status), 0,
+		ghes_copy_tofrom_phys(estatus, buf_paddr,
+				      sizeof(estatus->block_status), 0,
 				      fixmap_idx);
 }
 
@@ -638,9 +640,10 @@ static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 	return apei_write(val, &gv2->read_ack_register);
 }
 
-static void __ghes_panic(struct ghes *ghes)
+static void __ghes_panic(struct ghes *ghes,
+			 struct acpi_hest_generic_status *estatus)
 {
-	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
+	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
 	/* reboot to log the error! */
 	if (!panic_timeout)
@@ -650,25 +653,25 @@ static void __ghes_panic(struct ghes *ghes)
 
 static int ghes_proc(struct ghes *ghes)
 {
+	struct acpi_hest_generic_status *estatus = ghes->estatus;
 	u64 buf_paddr;
 	int rc;
 
-	rc = ghes_read_estatus(ghes, &buf_paddr, FIX_APEI_GHES_IRQ);
+	rc = ghes_read_estatus(ghes, estatus, &buf_paddr, FIX_APEI_GHES_IRQ);
 	if (rc)
 		goto out;
 
-	if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC) {
-		__ghes_panic(ghes);
-	}
+	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
+		__ghes_panic(ghes, estatus);
 
-	if (!ghes_estatus_cached(ghes->estatus)) {
-		if (ghes_print_estatus(NULL, ghes->generic, ghes->estatus))
-			ghes_estatus_cache_add(ghes->generic, ghes->estatus);
+	if (!ghes_estatus_cached(estatus)) {
+		if (ghes_print_estatus(NULL, ghes->generic, estatus))
+			ghes_estatus_cache_add(ghes->generic, estatus);
 	}
-	ghes_do_proc(ghes, ghes->estatus);
+	ghes_do_proc(ghes, estatus);
 
 out:
-	ghes_clear_estatus(ghes, buf_paddr, FIX_APEI_GHES_IRQ);
+	ghes_clear_estatus(estatus, buf_paddr, FIX_APEI_GHES_IRQ);
 
 	if (rc == -ENOENT)
 		return rc;
@@ -819,17 +822,20 @@ static void ghes_print_queued_estatus(void)
 }
 
 /* Save estatus for further processing in IRQ context */
-static void __process_error(struct ghes *ghes)
+static void __process_error(struct ghes *ghes,
+			    struct acpi_hest_generic_status *src_estatus)
 {
-#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 	u32 len, node_len;
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic_status *estatus;
 
-	if (ghes_estatus_cached(ghes->estatus))
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG))
 		return;
 
-	len = cper_estatus_len(ghes->estatus);
+	if (ghes_estatus_cached(src_estatus))
+		return;
+
+	len = cper_estatus_len(src_estatus);
 	node_len = GHES_ESTATUS_NODE_LEN(len);
 
 	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
@@ -839,29 +845,29 @@ static void __process_error(struct ghes *ghes)
 	estatus_node->ghes = ghes;
 	estatus_node->generic = ghes->generic;
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-	memcpy(estatus, ghes->estatus, len);
+	memcpy(estatus, src_estatus, len);
 	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
-#endif
 }
 
 static int _in_nmi_notify_one(struct ghes *ghes, int fixmap_idx)
 {
+	struct acpi_hest_generic_status *estatus = ghes->estatus;
 	u64 buf_paddr;
 	int sev;
 
-	if (ghes_read_estatus(ghes, &buf_paddr, fixmap_idx)) {
-		ghes_clear_estatus(ghes, buf_paddr, fixmap_idx);
+	if (ghes_read_estatus(ghes, estatus, &buf_paddr, fixmap_idx)) {
+		ghes_clear_estatus(estatus, buf_paddr, fixmap_idx);
 		return -ENOENT;
 	}
 
-	sev = ghes_severity(ghes->estatus->error_severity);
+	sev = ghes_severity(estatus->error_severity);
 	if (sev >= GHES_SEV_PANIC) {
 		ghes_print_queued_estatus();
-		__ghes_panic(ghes);
+		__ghes_panic(ghes, estatus);
 	}
 
-	__process_error(ghes);
-	ghes_clear_estatus(ghes, buf_paddr, fixmap_idx);
+	__process_error(ghes, estatus);
+	ghes_clear_estatus(estatus, buf_paddr, fixmap_idx);
 
 	if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
 		pr_warn_ratelimited(FW_WARN GHES_PFX
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
