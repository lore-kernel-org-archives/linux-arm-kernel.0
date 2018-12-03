Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F7AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:33:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF93208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cAtelgyR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PGVuXfTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF93208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XpE6xlvmJt+7cM+N8RRsJIIFLXNiBqshHVHZiVsq/uQ=; b=cAtelgyRSOriAV
	Er5xau1NMJ/N14+6tl2fm/gFWjT61HSLW1d0BnjurEbTool5MfS5euxqUJRJYV3hRl4e/arDoAwmZ
	VE3jUYtjnC2XMU3/cY2hy0gnUbMmRqxL1enJ/BDMcMwT1vVNt2gQlOprvT2Zshf3m0j2yoc5tqlnf
	UX3tpjakuNIePG+YcbZzdcPi4YhMqcPK1Iz4b/KOBfnE3QZjrmU1VuH6RkD+tSC37EgLf3E7vGNw7
	h+TutK7btNkVbajXn3y98o8ADucm6z3OHQTHhE6MmbttWrNE0sq44Fk6t5UWBdmqRm0C3yziZDRX7
	G3w9iiRlh/0e/3M10TTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt1p-0004gE-QQ; Mon, 03 Dec 2018 18:33:09 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt0L-0003LE-Lu
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:31:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EBSpijSkolzccED4lKghWiZT1vIhGy2WcfQBL5IIU28=; b=PGVuXfTgH5SEt0caIAiwNL+5rN
 byWfGeL9yhU7CIsIE2ZQHojJCUrGq29tVtyz5Am8LvpSRTfX/Zvjab6g1F21VZHgajQ5/rTDf9R/+
 +CU/lLJmXj5hduW/JKjUlB+4TXt7LXBxFl0Lut0wZ/lpc/2a6K7Am649bLYajUDfhvZuA6IU6nVss
 122W/23TkCWds8Q3JFW4o+/2PWaPkXqimufxbYsh6IR91lKV47+TsCD5fLDRkXEtU6Ns1Hv3ZgAGg
 HyrrCBj8QB7PnCUll0CXiIxK9cTfErC6u81wlMNQbIgobBQ8xApdy46tHNtviZ+jh8lSYp643zeWI
 29udWWQg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsdQ-0001fE-Eu
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48E11169E;
 Mon,  3 Dec 2018 10:07:55 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7788E3F59C;
 Mon,  3 Dec 2018 10:07:52 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 22/25] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
Date: Mon,  3 Dec 2018 18:06:10 +0000
Message-Id: <20181203180613.228133-23-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_130756_708523_D0E7C123 
X-CRM114-Status: GOOD (  24.64  )
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

memory_failure() offlines or repairs pages of memory that have been
discovered to be corrupt. These may be detected by an external
component, (e.g. the memory controller), and notified via an IRQ.
In this case the work is queued as not all of memory_failure()s work
can happen in IRQ context.

If the error was detected as a result of user-space accessing a
corrupt memory location the CPU may take an abort instead. On arm64
this is a 'synchronous external abort', and on a firmware first
system it is replayed using NOTIFY_SEA.

This notification has NMI like properties, (it can interrupt
IRQ-masked code), so the memory_failure() work is queued. If we
return to user-space before the queued memory_failure() work is
processed, we will take the fault again. This loop may cause platform
firmware to exceed some threshold and reboot when Linux could have
recovered from this error.

If a ghes notification type indicates that it may be triggered again
when we return to user-space, use the task-work and notify-resume
hooks to kick the relevant memory_failure() queue before returning
to user-space.

Signed-off-by: James Morse <james.morse@arm.com>

---
current->mm == &init_mm ? I couldn't find a helper for this.
The intent is not to set TIF flags on kernel threads. What happens
if a kernel-thread takes on of these? Its just one of the many
not-handled-very-well cases we have already, as memory_failure()
puts it: "try to be lucky".

I assume that if NOTIFY_NMI is coming from SMM it must suffer from
this problem too.
---
 drivers/acpi/apei/ghes.c | 65 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6cbf9471b2a2..3e7da9243153 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -47,6 +47,7 @@
 #include <linux/sched/clock.h>
 #include <linux/uuid.h>
 #include <linux/ras.h>
+#include <linux/task_work.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -136,6 +137,26 @@ static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_panic_timeout __read_mostly = 30;
 
+static bool ghes_is_synchronous(struct ghes *ghes)
+{
+	switch (ghes->generic->notify.type) {
+	case ACPI_HEST_NOTIFY_NMI:	/* fall through */
+	case ACPI_HEST_NOTIFY_SEA:
+		/*
+		 * These notifications could be repeated if the interrupted
+		 * instruction is run again. e.g. a read of bad-memory causing
+		 * a trap to platform firmware.
+		 */
+		return true;
+	default:
+		/*
+		 * Other notifications are asynchronous, and not related to the
+		 * interrupted instruction. e.g. an IRQ.
+		 */
+		return false;
+	}
+}
+
 static void __iomem *ghes_map(u64 pfn, int fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -379,14 +400,33 @@ static void ghes_clear_estatus(struct acpi_hest_generic_status *estatus,
 				      fixmap_idx);
 }
 
-static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
+struct ghes_memory_failure_work {
+	int cpu;
+	struct callback_head work;
+};
+
+static void ghes_kick_memory_failure(struct callback_head *head)
+{
+	struct ghes_memory_failure_work *callback;
+
+	callback = container_of(head, struct ghes_memory_failure_work, work);
+	memory_failure_queue_kick(callback->cpu);
+	kfree(callback);
+}
+
+static void ghes_handle_memory_failure(struct ghes *ghes,
+				       struct acpi_hest_generic_data *gdata,
+				       int sev)
 {
-#ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
 	unsigned long pfn;
-	int flags = -1;
+	int flags = -1, ret;
+	struct ghes_memory_failure_work	*callback;
 	int sec_sev = ghes_severity(gdata->error_severity);
 	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
+		return;
+
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
@@ -407,7 +447,22 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 
 	if (flags != -1)
 		memory_failure_queue(pfn, flags);
-#endif
+
+	/*
+	 * If the notification indicates that it was the interrupted
+	 * instruction that caused the error, try to kick the
+	 * memory_failure() queue before returning to user-space.
+	 */
+	if (ghes_is_synchronous(ghes) && current->mm != &init_mm) {
+		callback = kzalloc(sizeof(*callback), GFP_ATOMIC);
+		if (!callback)
+			return;
+		callback->work.func = ghes_kick_memory_failure;
+		callback->cpu = smp_processor_id();
+		ret = task_work_add(current, &callback->work, true);
+		if (ret)
+			kfree(callback);
+	}
 }
 
 /*
@@ -480,7 +535,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			ghes_handle_memory_failure(gdata, sev);
+			ghes_handle_memory_failure(ghes, gdata, sev);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
