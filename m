Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D7A20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KJU1Tp14";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dg4bgoXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D7A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1HtJlqi8SXF5dP3S6+mycN8K36bXsWygJE6Y2zlQQjs=; b=KJU1Tp14aNqgCS
	uIQvIQB5tkv0uQ7bQoGL2JbjX6lP05/yTjEhnEpsUkrAI7rbS05zdL0vN5DdUZoO/0/9QH5s8UPJD
	B7tTQpCdfTD4vpieZUNRgnrjZC8UD97Ja56swY9NjQjfhea83y3eW0XXKOvcOz882sXenOzdXNWj3
	Ayxtq8LNVAAy9SNunlhKgpItbbWdFPZYA2aIzGV9BPWrCSdfuPbQIeL1yaVNyILdMpTNciORFdsJo
	hu47MzJSu89DPzrI/VetjSoq7BQTnZcg3h8MqQzokS0MQrguFhGtQTL6bbt4dyW4IUtYPZlE0GoNq
	yis3xKORfs6opRCIagXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYmU-0004kS-Lg; Tue, 29 Jan 2019 19:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYmR-0004kD-JP
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 19:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cGyWsH8E5iMe5/JM/wndPOtcKX97fv1WfR21Y9tGLcE=; b=Dg4bgoXFh91OeIp5Fw6AOv6S16
 IS2CxjiGc/tRi+BnAQhOoakLWcRBsFSsQOmTw18rY9o76hrd0Ym6luD/NC6zx34tNdl6PoaozwssV
 Pg0gSt+BQ0atNRd73rjUIJovvKcBErR5j6uyHzLwtoSUPYAcfz+pY8kb9dIgiCoUfTVZdFa9Q5utc
 pVGCGIOtLp1pHeTC7vbo6LHLBMuTHhGG9/Tdxo1BZkpbvEgCJ55bkjoClLzZU/UuuzReNbE4u2V+L
 FlgnEYqptYVr03+7r8JBRtIIGpODB68dG4JaLD/UWiBRGizNhLSPYjnTs/mAswoByTTmUImm7J6Xl
 BlmeOHAg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYT8-0005aU-Uk
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7D8B15AB;
 Tue, 29 Jan 2019 10:50:45 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46AB93F557;
 Tue, 29 Jan 2019 10:50:43 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 23/26] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
Date: Tue, 29 Jan 2019 18:48:59 +0000
Message-Id: <20190129184902.102850-24-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_135047_128003_61CCA95D 
X-CRM114-Status: GOOD (  24.65  )
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
 Xie XiuQi <xiexiuqi@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, james.morse@arm.com,
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

For NMIlike notifications keep track of whether memory_failure() work
was queued, and make task_work pending to flush out the queue.
To save memory allocations, the task_work is allocated as part of
the ghes_estatus_node, and free()ing it back to the pool is deferred.

Signed-off-by: James Morse <james.morse@arm.com>

---
current->mm == &init_mm ? I couldn't find a helper for this.
The intent is not to set TIF flags on kernel threads. What happens
if a kernel-thread takes on of these? Its just one of the many
not-handled-very-well cases we have already, as memory_failure()
puts it: "try to be lucky".

I assume that if NOTIFY_NMI is coming from SMM it must suffer from
this problem too.

Changes since v7:
 * Don't allocate memory, stuff it in estatus_node. This means passing
   back a 'queued' flag to ghes_proc_in_irq() which holds the estatus_node.
---
 drivers/acpi/apei/ghes.c | 68 +++++++++++++++++++++++++++++++++-------
 include/acpi/ghes.h      |  3 ++
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e6f0d176b245..dfa8f155f964 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -47,6 +47,7 @@
 #include <linux/sched/clock.h>
 #include <linux/uuid.h>
 #include <linux/ras.h>
+#include <linux/task_work.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -399,23 +400,46 @@ static void ghes_clear_estatus(struct ghes *ghes,
 		ghes_ack_error(ghes->generic_v2);
 }
 
-static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
+/*
+ * Called as task_work before returning to user-space.
+ * Ensure any queued work has been done before we return to the context that
+ * triggered the notification.
+ */
+static void ghes_kick_task_work(struct callback_head *head)
+{
+	struct acpi_hest_generic_status *estatus;
+	struct ghes_estatus_node *estatus_node;
+	u32 node_len;
+
+	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
+	memory_failure_queue_kick(estatus_node->task_work_cpu);
+
+	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
+	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
+	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
+}
+
+static bool ghes_handle_memory_failure(struct ghes *ghes,
+				       struct acpi_hest_generic_data *gdata,
+				       int sev)
 {
-#ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
 	unsigned long pfn;
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
 	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
+		return false;
+
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return;
+		return false;
 
 	pfn = mem_err->physical_addr >> PAGE_SHIFT;
 	if (!pfn_valid(pfn)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 		"Invalid address in generic error data: %#llx\n",
 		mem_err->physical_addr);
-		return;
+		return false;
 	}
 
 	/* iff following two events can be handled properly by now */
@@ -425,9 +449,12 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
 		flags = 0;
 
-	if (flags != -1)
+	if (flags != -1) {
 		memory_failure_queue(pfn, flags);
-#endif
+		return true;
+	}
+
+	return false;
 }
 
 /*
@@ -475,11 +502,12 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
-static void ghes_do_proc(struct ghes *ghes,
+static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
 	int sev, sec_sev;
 	struct acpi_hest_generic_data *gdata;
+	bool work_queued = false;
 	guid_t *sec_type;
 	guid_t *fru_id = &NULL_UUID_LE;
 	char *fru_text = "";
@@ -500,7 +528,8 @@ static void ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			ghes_handle_memory_failure(gdata, sev);
+			if (ghes_handle_memory_failure(ghes, gdata, sev))
+				work_queued = true;
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
@@ -517,6 +546,8 @@ static void ghes_do_proc(struct ghes *ghes,
 					       gdata->error_data_length);
 		}
 	}
+
+	return work_queued;
 }
 
 static void __ghes_print_estatus(const char *pfx,
@@ -812,7 +843,9 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
+	bool task_work_pending;
 	u32 len, node_len;
+	int ret;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
 	/*
@@ -827,14 +860,26 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 		len = cper_estatus_len(estatus);
 		node_len = GHES_ESTATUS_NODE_LEN(len);
-		ghes_do_proc(estatus_node->ghes, estatus);
+		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
 		if (!ghes_estatus_cached(estatus)) {
 			generic = estatus_node->generic;
 			if (ghes_print_estatus(NULL, generic, estatus))
 				ghes_estatus_cache_add(generic, estatus);
 		}
-		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
-			      node_len);
+
+		if (task_work_pending && current->mm != &init_mm) {
+			estatus_node->task_work.func = ghes_kick_task_work;
+			estatus_node->task_work_cpu = smp_processor_id();
+			ret = task_work_add(current, &estatus_node->task_work,
+					    true);
+			if (ret)
+				estatus_node->task_work.func = NULL;
+		}
+
+		if (!estatus_node->task_work.func)
+			gen_pool_free(ghes_estatus_pool,
+				      (unsigned long)estatus_node, node_len);
+
 		llnode = next;
 	}
 }
@@ -894,6 +939,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 
 	estatus_node->ghes = ghes;
 	estatus_node->generic = ghes->generic;
+	estatus_node->task_work.func = NULL;
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 
 	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index e3f1cddb4ac8..517a5231cc1b 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -33,6 +33,9 @@ struct ghes_estatus_node {
 	struct llist_node llnode;
 	struct acpi_hest_generic *generic;
 	struct ghes *ghes;
+
+	int task_work_cpu;
+	struct callback_head task_work;
 };
 
 struct ghes_estatus_cache {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
