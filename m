Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE43C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:34:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A74E2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OnVBeDdS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpPCZXBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A74E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G17SbRGe0aUA8x9f4V4Ke/wvkYK05vAVCK3bXvxbdRw=; b=OnVBeDdSrfByjp
	EatMP2k/ocKjTrA5qao8SKgM1c98vILvMAchyAC6WIboh2m6eN9i+xkK5KbcjiEAJ0aGwV2jDzRTS
	6v/5jmFbEVy3+gJown57nUvfmd76AD6HvWT8biAKnYija2kSEsmnaep0MruvsgcD3VBuPFGvI0jPD
	ddciiXf9V0dR30rpqzT0Y40aIGdtTceJ9OrmvZs9aLSy15dUpb/9bJfCvItL+AR3mddTtz3rxd2qC
	J4L0qT+MZ4Z8q0s/XuI6U4b+CIBdSfwbyS5ZHVSaOcQZvh/b2xm1LGEkmvpkKAzRfSL/TDBb6+uhz
	d7KBfgEI+Jp/Ley8gTFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt3J-00068W-Hl; Mon, 03 Dec 2018 18:34:41 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt0W-0003LE-4P
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=og/HhddhQV4kd5weptQo3NtZBBhCvSV4v/gbtQSKrLY=; b=ZpPCZXBldVxXz9Rij3sWGITP2d
 fGMm8RlzIxlmsrJS7RjDnYJzUaScv6n2+1jFQnzJTpYdoQcy70mou24KnLLWmdteWki6SPLqbPPYd
 5PjsxHYfs032Qd2U8SNt+DlbR6WsJ6WIvjlXBNZUSWPVtgGOp/H8GmqQPdnCMrZ4/Rj6ivM6PmPBN
 zHbkNWoiFRjhvitwAL8Qq/oeIJa28S3EwUM5FyW5zRSTMQ73xV6K4eJiY3sw0jx1Q3FA1Ve4bn6mm
 UyD7yiRRF50ZPwIvsEMpIVHnpIZwxFPxbDdsXmej80Rtuk3Mr/oZczrFm4VRlG/UM2wBki4VHazoR
 IEIoqaKA==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTscx-0001bo-2X
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A28C61682;
 Mon,  3 Dec 2018 10:07:19 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFF173F59C;
 Mon,  3 Dec 2018 10:07:16 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 12/25] ACPI / APEI: Switch NOTIFY_SEA to use the estatus
 queue
Date: Mon,  3 Dec 2018 18:06:00 +0000
Message-Id: <20181203180613.228133-13-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_130727_286775_8C6CF2F2 
X-CRM114-Status: GOOD (  19.58  )
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

Now that the estatus queue can be used by more than one notification
method, we can move notifications that have NMI-like behaviour over.

Switch NOTIFY_SEA over to use the estatus queue. This makes it behave
in the same way as x86's NOTIFY_NMI.

Remove Kconfig's ability to turn ACPI_APEI_SEA off if ACPI_APEI_GHES
is selected. This roughly matches the x86 NOTIFY_NMI behaviour, and means
each architecture has at least one user of the estatus-queue, meaning it
doesn't need guarding with ifdef.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v6:
 * Lost all the pool grow/shrink stuff,
 * Changed Kconfig so this can't be turned off to avoid kconfig complexity:
 * Dropped Tyler's tested-by.
 * For now we need #ifdef around the SEA code as the arch code assumes its there.
 * Removed Punit's reviewed-by due to the swirling #ifdeffery
---
 drivers/acpi/apei/Kconfig | 12 +-----------
 drivers/acpi/apei/ghes.c  | 22 +++++-----------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 52ae5438edeb..6b18f8bc7be3 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -41,19 +41,9 @@ config ACPI_APEI_PCIEAER
 	  Turn on this option to enable the corresponding support.
 
 config ACPI_APEI_SEA
-	bool "APEI Synchronous External Abort logging/recovering support"
+	bool
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
-	help
-	  This option should be enabled if the system supports
-	  firmware first handling of SEA (Synchronous External Abort).
-	  SEA happens with certain faults of data abort or instruction
-	  abort synchronous exceptions on ARMv8 systems. If a system
-	  supports firmware first handling of SEA, the platform analyzes
-	  and handles hardware error notifications from SEA, and it may then
-	  form a HW error record for the OS to parse and handle. This
-	  option allows the OS to look for such hardware error record, and
-	  take appropriate action.
 
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 00fe4785e469..4b33fa562e32 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -765,7 +765,6 @@ static struct notifier_block ghes_notifier_hed = {
 	.notifier_call = ghes_notify_hed,
 };
 
-#ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
  * Handlers for CPER records may not be NMI safe. For example,
  * memory_failure_queue() takes spinlocks and calls schedule_work_on().
@@ -905,7 +904,6 @@ static int ghes_estatus_queue_notified(struct list_head *rcu_list)
 
 	return ret;
 }
-#endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
@@ -916,16 +914,7 @@ static LIST_HEAD(ghes_sea);
  */
 int ghes_notify_sea(void)
 {
-	struct ghes *ghes;
-	int ret = -ENOENT;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
-		if (!ghes_proc(ghes))
-			ret = 0;
-	}
-	rcu_read_unlock();
-	return ret;
+	return ghes_estatus_queue_notified(&ghes_sea);
 }
 
 static void ghes_sea_add(struct ghes *ghes)
@@ -992,16 +981,15 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	 */
 	synchronize_rcu();
 }
+#else /* CONFIG_HAVE_ACPI_APEI_NMI */
+static inline void ghes_nmi_add(struct ghes *ghes) { }
+static inline void ghes_nmi_remove(struct ghes *ghes) { }
+#endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 static void ghes_nmi_init_cxt(void)
 {
 	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
 }
-#else /* CONFIG_HAVE_ACPI_APEI_NMI */
-static inline void ghes_nmi_add(struct ghes *ghes) { }
-static inline void ghes_nmi_remove(struct ghes *ghes) { }
-static inline void ghes_nmi_init_cxt(void) { }
-#endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 static int ghes_probe(struct platform_device *ghes_dev)
 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
