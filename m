Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C1BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC9120880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dcy77raH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJR+T569"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC9120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i35yVxG3/BtqpGrFIelNvnARYKeIsss8+8YiosJWfIE=; b=Dcy77raHoPXD4W
	3BPi5dDH1fTwdmkqtb6fsAk7tOei/NJ7hWTB1aDZPeQGop7orGjLnKGTiocpD8eY3+op9/QHfVeHV
	UbBvA94Z+Pq9GqiwHKjXKt11jKED5cfk9yprs9VFOtXYiXqvv+Wmv1S5uqvbYixSG9ZpAi3lvJgtT
	R01aO6IBLm2KKAPFcxqd/RRKXba1uBCOfDjNFY+JKs+B7mvvIdWQRJXOKx90E2rHft2PcazgN0dTK
	PXHUavm4iKE1gw/qGn9rN0fn/Ux0sF+aaFslKIu2xrWpN7bqZHpxbboetlqk4PPrpRj4ETF+74/Yk
	64hqbrhgziXPpt0nCqQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYoC-00064X-Pn; Tue, 29 Jan 2019 19:12:32 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYmZ-0004kD-9Y
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 19:10:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QOY/2hNJALFKKfjWnlCJcXzlT4qedTCy7caAQiFnm7o=; b=SJR+T569MttesH1De5w4ZthWt1
 24twNPWZBukkgFsgvD3hO5s59JVo5Ydhx7Xv7OsqaekPpWkcxGs5ym+Ck91hXDTTDb8bUOCV8eZB0
 jibpYJVeYjEaJS15HB3CGxdTNLJMWelWOgErOXKWkRFuxypIOgwFszMs2UC7D2L1AlrRPnVFNhV6S
 6u2PFm+1WloR3Z5A4scA59Mgim2cAg7Mgbz9v3qx7CtxVKPUkP51KLmFrhytmazUsiW9YsbltI7N5
 cUBQgSCFybhKhGhznW7nPrd4NVcJVfSEjoKgkjxr9io3baY9VB+v/RWb/7EHuG0lve/zJOWZJXTwD
 BRGM/QBg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYT0-0005ZU-Au
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA8F15AB;
 Tue, 29 Jan 2019 10:50:37 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 827933F557;
 Tue, 29 Jan 2019 10:50:34 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 20/26] ACPI / APEI: Only use queued estatus entry during
 in_nmi_queue_one_entry()
Date: Tue, 29 Jan 2019 18:48:56 +0000
Message-Id: <20190129184902.102850-21-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_135038_620972_461BC43E 
X-CRM114-Status: GOOD (  19.39  )
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

Each struct ghes has an worst-case sized buffer for storing the
estatus. If an error is being processed by ghes_proc() in process
context this buffer will be in use. If the error source then triggers
an NMI-like notification, the same buffer will be used by
in_nmi_queue_one_entry() to stage the estatus data, before
__process_error() copys it into a queued estatus entry.

Merge __process_error()s work into in_nmi_queue_one_entry() so that
the queued estatus entry is used from the beginning. Use the new
ghes_peek_estatus() to know how much memory to allocate from
the ghes_estatus_pool before reading the records.

Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>

Change since v6:
 * Added a comment explaining the 'ack-error, then goto no_work'.
 * Added missing esatus-clearing, which is necessary after reading the GAS,
---
 drivers/acpi/apei/ghes.c | 64 +++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 12375a82fa03..957c1559ebf5 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -862,57 +862,67 @@ static void ghes_print_queued_estatus(void)
 	}
 }
 
-/* Save estatus for further processing in IRQ context */
-static void __process_error(struct ghes *ghes,
-			    struct acpi_hest_generic_status *src_estatus)
+static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
+				       enum fixed_addresses fixmap_idx)
 {
-	u32 len, node_len;
+	struct acpi_hest_generic_status *estatus, tmp_header;
 	struct ghes_estatus_node *estatus_node;
-	struct acpi_hest_generic_status *estatus;
+	u32 len, node_len;
+	u64 buf_paddr;
+	int sev, rc;
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG))
-		return;
+		return -EOPNOTSUPP;
 
-	if (ghes_estatus_cached(src_estatus))
-		return;
+	rc = __ghes_peek_estatus(ghes, &tmp_header, &buf_paddr, fixmap_idx);
+	if (rc) {
+		ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
+		return rc;
+	}
 
-	len = cper_estatus_len(src_estatus);
-	node_len = GHES_ESTATUS_NODE_LEN(len);
+	rc = __ghes_check_estatus(ghes, &tmp_header);
+	if (rc) {
+		ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
+		return rc;
+	}
 
+	len = cper_estatus_len(&tmp_header);
+	node_len = GHES_ESTATUS_NODE_LEN(len);
 	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
 	if (!estatus_node)
-		return;
+		return -ENOMEM;
 
 	estatus_node->ghes = ghes;
 	estatus_node->generic = ghes->generic;
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-	memcpy(estatus, src_estatus, len);
-	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
-}
 
-static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
-				       enum fixed_addresses fixmap_idx)
-{
-	struct acpi_hest_generic_status *estatus = ghes->estatus;
-	u64 buf_paddr;
-	int sev;
-
-	if (ghes_read_estatus(ghes, estatus, &buf_paddr, fixmap_idx)) {
+	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
 		ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
-		return -ENOENT;
+		rc = -ENOENT;
+		goto no_work;
 	}
 
 	sev = ghes_severity(estatus->error_severity);
 	if (sev >= GHES_SEV_PANIC) {
 		ghes_print_queued_estatus();
 		__ghes_panic(ghes, estatus, buf_paddr, fixmap_idx);
-
 	}
 
-	__process_error(ghes, estatus);
-	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
+	ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
 
-	return 0;
+	/* This error has been reported before, don't process it again. */
+	if (ghes_estatus_cached(estatus))
+		goto no_work;
+
+	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
+
+	return rc;
+
+no_work:
+	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
+		      node_len);
+
+	return rc;
 }
 
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
