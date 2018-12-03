Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EC2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:32:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11AA208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bukvJZm5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mU9QPFrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11AA208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h+o/J4sc2oAlwpojzknhOvXMdcZUEXsctmDbu8vJ5uc=; b=bukvJZm5LZLjC3
	PWONyHINaYhBvVu958/dcZAyjQ44NE+ds0ylMThpgqxDl/gWMZkCFPpgWjg+V2r7WXoS0DpXmZnKD
	I8EzVJb8Yyt8BYC3uUhifgDfinbxH+SEDWiYoLa+8/MH5noKtjGeU6D3+tvq3cjo2MkopsNl5QAAE
	M1gM0du0raNU8WA5HBx7olubG8MQ6CWmeoSyAylL9rCXcAT8TbUhsl6d30CIQtOk+WqolVsGYCMrY
	kUqjUBvnQuj9/C/LfXGpheTI/FyzOrnI44LZU03TeRXZkW4LTTQTJ2Kjh3sZHm8pVsCQ63EGYcBAX
	Eu96TJ0DLUY72sfQGbKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt1J-0004JU-S9; Mon, 03 Dec 2018 18:32:37 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt0N-0003LE-K6
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h30DZ5QsoanOwOfyV3bhyCWkTrBNg0fy/1dD74I5bNY=; b=mU9QPFrvTYGiu1P1TkhHq86gS1
 erU5ed+2S6Bs9FBkbfEoQ3owIBhfKNdjBATH7nsrVl+uQuqz8UYPAqSTOXw/jjD8YAiNv1baruqIl
 dTovcteOB06/YTFtJSztGzefiDN1QxeEHH1gDOcm/ssHuxkbAb3CHXVpkzhRi6Vyn2hRY5eNLtfu5
 TQw7tRuj/jsjhxtUjIdyoVn+/ZhRFed++GgjFDTLMWNZmghpbWsBHIFu2VH5dHpjlqLTlF3ng28tz
 /DRBMjF9jatf9hIQwBVJv1HlrKUiJ3RiRHIfO1RKRSjuatpKKqErY9Og0vEHvEMBFfqnA8St3bLd9
 qAEncyLA==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsdQ-0001eM-Et
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE3DD1713;
 Mon,  3 Dec 2018 10:07:44 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A853F59C;
 Mon,  3 Dec 2018 10:07:41 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 19/25] ACPI / APEI: Only use queued estatus entry during
 _in_nmi_notify_one()
Date: Mon,  3 Dec 2018 18:06:07 +0000
Message-Id: <20181203180613.228133-20-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_130756_699243_D7692C00 
X-CRM114-Status: GOOD (  18.97  )
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

Each struct ghes has an worst-case sized buffer for storing the
estatus. If an error is being processed by ghes_proc() in process
context this buffer will be in use. If the error source then triggers
an NMI-like notification, the same buffer will be used by
_in_nmi_notify_one() to stage the estatus data, before
__process_error() copys it into a queued estatus entry.

Merge __process_error()s work into _in_nmi_notify_one() so that
the queued estatus entry is used from the beginning. Use the new
ghes_peek_estatus() to know how much memory to allocate from
the ghes_estatus_pool before reading the records.

Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: James Morse <james.morse@arm.com>

Change since v6:
 * Added a comment explaining the 'ack-error, then goto no_work'.
 * Added missing esatus-clearing, which is necessary after reading the GAS,
---
 drivers/acpi/apei/ghes.c | 59 ++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 07a12aac4c1a..849da0d43a21 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -856,43 +856,43 @@ static void ghes_print_queued_estatus(void)
 	}
 }
 
-/* Save estatus for further processing in IRQ context */
-static void __process_error(struct ghes *ghes,
-			    struct acpi_hest_generic_status *src_estatus)
+static int _in_nmi_notify_one(struct ghes *ghes, int fixmap_idx)
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
+	rc = __ghes_peek_estatus(ghes, fixmap_idx, &tmp_header, &buf_paddr);
+	if (rc) {
+		ghes_clear_estatus(&tmp_header, buf_paddr, fixmap_idx);
+		return rc;
+	}
 
-	len = cper_estatus_len(src_estatus);
-	node_len = GHES_ESTATUS_NODE_LEN(len);
+	rc = __ghes_check_estatus(ghes, &tmp_header);
+	if (rc) {
+		ghes_clear_estatus(&tmp_header, buf_paddr, fixmap_idx);
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
-
-static int _in_nmi_notify_one(struct ghes *ghes, int fixmap_idx)
-{
-	struct acpi_hest_generic_status *estatus = ghes->estatus;
-	u64 buf_paddr;
-	int sev;
 
-	if (ghes_read_estatus(ghes, estatus, &buf_paddr, fixmap_idx)) {
+	if (__ghes_read_estatus(estatus, buf_paddr, len, fixmap_idx)) {
 		ghes_clear_estatus(estatus, buf_paddr, fixmap_idx);
-		return -ENOENT;
+		rc = -ENOENT;
+		goto no_work;
 	}
 
 	sev = ghes_severity(estatus->error_severity);
@@ -901,14 +901,25 @@ static int _in_nmi_notify_one(struct ghes *ghes, int fixmap_idx)
 		__ghes_panic(ghes, estatus);
 	}
 
-	__process_error(ghes, estatus);
 	ghes_clear_estatus(estatus, buf_paddr, fixmap_idx);
 
 	if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 				    "Failed to ack error status block!\n");
 
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
 
 static int ghes_estatus_queue_notified(struct list_head *rcu_list,
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
