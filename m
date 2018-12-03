Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:34:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A9F2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VTcgZ1Vr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GEyQABnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A9F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8a/W7Z2r7fKjme/vZ1nYKwMpJ8b2DQo2H7NxXQHO+Uo=; b=VTcgZ1Vr8tbZeo
	lfcYSGzzFUCB71yPHetauSnTgWZdoVOHzm9ssBv9rCkP2zK4tjRMkqrSc4LIujjn5GtPPZxCJQmxw
	TRvc6vBS4UdLSYXbf0xy5iJ+iRvb7gXsbqTkgBFQ4rfRp6FVigHKABqQGYj9NTMjvZaJ1ZSIf9I4M
	UPsSHnQlTU+EyNAJsfxZDR/Cxvdt9hovuGgYtXl8L93rXRUzcH0oULp78Viz5G3Bw/ii24Ex5vht7
	yuHzjE6x7cY1qYWk+LCwA1TfOC6umtGpaI+XGf+H9pMAhXc1PC01aw7KyLyE+vJnaQ3LqzsmHGFVB
	hxQoFo10VFioYxsnXxcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt2m-0005cV-IC; Mon, 03 Dec 2018 18:34:08 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt0S-0003LE-AO
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lk7Z0u07RFB1AXUDsGSy0KFoRuRRaLA70m1JekiZSS4=; b=GEyQABnQWmR9wpIJjpBm+v0SfX
 fXxzd5Fy4PWb6Om8IN7nR0jZDf/M/bZfkC5DENlf3dw79JIkaiNPwORY5ughF/IYl1izGK1noADyO
 lPyMp9pE14o1frGFxVnN63RW7jAQiSEOzWo2X/f2ujZIFaWQm5pLNQplpusJa1yEChsi35bn6MSkT
 IE1kHSbUcyy6mfXGyVO1LD8TTOX9BxYwP1VTGp8Kzmy/3lyzpMHDHfo0l6EyvcR5AZrnUCq777x5q
 cou6l7PyEodaKVqxzXaKYMJ7aJyq4MdzuSBIy5J2zNNBB4JRaaxBj8TaCwldTzfwHDW831x9LM7RY
 0HgFbnkw==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsd8-0001co-Ul
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D503C1713;
 Mon,  3 Dec 2018 10:07:30 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10F073F59C;
 Mon,  3 Dec 2018 10:07:27 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 15/25] ACPI / APEI: Move locking to the notification helper
Date: Mon,  3 Dec 2018 18:06:03 +0000
Message-Id: <20181203180613.228133-16-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_130739_186299_E603A842 
X-CRM114-Status: GOOD (  19.32  )
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

ghes_copy_tofrom_phys() takes different locks depending on in_nmi().
This doesn't work if there are multiple NMI-like notifications, that
can interrupt each other.

Now that NOTIFY_SEA is always called in the same context, move the
lock-taking to the notification helper. The helper will always know
which lock to take. This avoids ghes_copy_tofrom_phys() taking a guess
based on in_nmi().

This splits NOTIFY_NMI and NOTIFY_SEA to use different locks. All
the other notifications use ghes_proc(), and are called in process
or IRQ context. Move the spin_lock_irqsave() around their ghes_proc()
calls.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
Changes since v6:
 * Tinkered with the commit message
 * Lock definitions have moved due to the #ifdefs
---
 drivers/acpi/apei/ghes.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 4b33fa562e32..30490eff7704 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -114,11 +114,10 @@ static DEFINE_MUTEX(ghes_list_mutex);
  * handler, but general ioremap can not be used in atomic context, so
  * the fixmap is used instead.
  *
- * These 2 spinlocks are used to prevent the fixmap entries from being used
+ * This spinlock is used to prevent the fixmap entry from being used
  * simultaneously.
  */
-static DEFINE_RAW_SPINLOCK(ghes_ioremap_lock_nmi);
-static DEFINE_SPINLOCK(ghes_ioremap_lock_irq);
+static DEFINE_SPINLOCK(ghes_notify_lock_irq);
 
 static struct gen_pool *ghes_estatus_pool;
 static unsigned long ghes_estatus_pool_size_request;
@@ -272,7 +271,6 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 				  int from_phys)
 {
 	void __iomem *vaddr;
-	unsigned long flags = 0;
 	int in_nmi = in_nmi();
 	u64 offset;
 	u32 trunk;
@@ -280,10 +278,8 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 	while (len > 0) {
 		offset = paddr - (paddr & PAGE_MASK);
 		if (in_nmi) {
-			raw_spin_lock(&ghes_ioremap_lock_nmi);
 			vaddr = ghes_ioremap_pfn_nmi(paddr >> PAGE_SHIFT);
 		} else {
-			spin_lock_irqsave(&ghes_ioremap_lock_irq, flags);
 			vaddr = ghes_ioremap_pfn_irq(paddr >> PAGE_SHIFT);
 		}
 		trunk = PAGE_SIZE - offset;
@@ -297,10 +293,8 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 		buffer += trunk;
 		if (in_nmi) {
 			ghes_iounmap_nmi();
-			raw_spin_unlock(&ghes_ioremap_lock_nmi);
 		} else {
 			ghes_iounmap_irq();
-			spin_unlock_irqrestore(&ghes_ioremap_lock_irq, flags);
 		}
 	}
 }
@@ -727,8 +721,11 @@ static void ghes_add_timer(struct ghes *ghes)
 static void ghes_poll_func(struct timer_list *t)
 {
 	struct ghes *ghes = from_timer(ghes, t, timer);
+	unsigned long flags;
 
+	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	ghes_proc(ghes);
+	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 	if (!(ghes->flags & GHES_EXITING))
 		ghes_add_timer(ghes);
 }
@@ -736,9 +733,12 @@ static void ghes_poll_func(struct timer_list *t)
 static irqreturn_t ghes_irq_func(int irq, void *data)
 {
 	struct ghes *ghes = data;
+	unsigned long flags;
 	int rc;
 
+	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	rc = ghes_proc(ghes);
+	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 	if (rc)
 		return IRQ_NONE;
 
@@ -749,14 +749,17 @@ static int ghes_notify_hed(struct notifier_block *this, unsigned long event,
 			   void *data)
 {
 	struct ghes *ghes;
+	unsigned long flags;
 	int ret = NOTIFY_DONE;
 
+	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	rcu_read_lock();
 	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
 		if (!ghes_proc(ghes))
 			ret = NOTIFY_OK;
 	}
 	rcu_read_unlock();
+	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 
 	return ret;
 }
@@ -906,6 +909,7 @@ static int ghes_estatus_queue_notified(struct list_head *rcu_list)
 }
 
 #ifdef CONFIG_ACPI_APEI_SEA
+static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sea);
 static LIST_HEAD(ghes_sea);
 
 /*
@@ -914,7 +918,13 @@ static LIST_HEAD(ghes_sea);
  */
 int ghes_notify_sea(void)
 {
-	return ghes_estatus_queue_notified(&ghes_sea);
+	int rv;
+
+	raw_spin_lock(&ghes_notify_lock_sea);
+	rv = ghes_estatus_queue_notified(&ghes_sea);
+	raw_spin_unlock(&ghes_notify_lock_sea);
+
+	return rv;
 }
 
 static void ghes_sea_add(struct ghes *ghes)
@@ -943,6 +953,7 @@ static inline void ghes_sea_remove(struct ghes *ghes) { }
  */
 static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
 
+static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
 static LIST_HEAD(ghes_nmi);
 
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
@@ -952,8 +963,10 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
 		return ret;
 
+	raw_spin_lock(&ghes_notify_lock_nmi);
 	if (!ghes_estatus_queue_notified(&ghes_nmi))
 		ret = NMI_HANDLED;
+	raw_spin_unlock(&ghes_notify_lock_nmi);
 
 	atomic_dec(&ghes_in_nmi);
 	return ret;
@@ -995,6 +1008,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
 	struct ghes *ghes = NULL;
+	unsigned long flags;
 
 	int rc = -EINVAL;
 
@@ -1097,7 +1111,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	ghes_edac_register(ghes, &ghes_dev->dev);
 
 	/* Handle any pending errors right away */
+	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	ghes_proc(ghes);
+	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 
 	return 0;
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
