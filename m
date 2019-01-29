Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:11:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76CF20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J2ylSy9M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t3kSVdYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76CF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GLpL4XX+Gh3snnzjE6YGG0tMheVbMnni4lOLhRT9FKI=; b=J2ylSy9MwZdg0n
	Gbj61kP04xbMJrQjHRlSOBSQMjASCirkNkffQCdAIOe1oYIjvUwFzEzVirpZGuwzUabIvIW30bqTJ
	iCccbB05cwe5q3rJ+E4tdclCUeG7mvAcp3goLG+hLuEPcy5tfltudKYfAorcxB/iAF+HDli44JRNH
	/uTYGICvyUWZfXOCNbTNRb5pXsNFF2LEZtn88zuYh7/A3KytGQTfJvoFPD48LbhzTDirmkvcw3L0K
	jWHjen91KqLEPIMlypBfSmUO2CoNVmNbtJOoqfCThS4rqkyLcCXSXFgexqxd/HIRPSB2oT++4dNEN
	A1Y2XzfWekbZc5eEUy0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYmk-0004yO-1K; Tue, 29 Jan 2019 19:11:02 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYmT-0004kD-7Y
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 19:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z0mOO2ifhiBIvsjdnVsmHqOe6F85CHxFTHq9HFgxSC0=; b=t3kSVdYMdcfE5NwTX086kpRzRw
 kDwGx7YU2V7lrBophH8p4JujJ818Ya9O7zhIKVYaYRSmCBVLpPfYjpcVAnTmGBKoL7eE7SjjsVnSp
 RtP4OqBXBaAQeoX63QIqTsKkvYQ0ogtcRd9nd+zQNg+uT5vx0uJpG/i938SH3JeBM/OlVIkjNiJnh
 iGGny8rHsobPk0DpsGMmWKIRhvrGp0QDjm+eZc79T2hOzfbGiM7QsmYFjuGWW03Sc8JXKDf4z76cH
 xfkoKlUCJabe4slISyAThxtNemLBkt9c8ap+/YMP/QT9UC0Mv19NLekp1qH3bTX1YaFZwhVPoqaY4
 5kzoONtQ==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYTG-0005aU-R7
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB4FA15BF;
 Tue, 29 Jan 2019 10:50:54 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A4D13F557;
 Tue, 29 Jan 2019 10:50:51 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 26/26] ACPI / APEI: Add support for the SDEI GHES
 Notification type
Date: Tue, 29 Jan 2019 18:49:02 +0000
Message-Id: <20190129184902.102850-27-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_135055_026492_6B34ED20 
X-CRM114-Status: GOOD (  20.09  )
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

If the GHES notification type is SDEI, register the provided event
using the SDEI-GHES helper.

SDEI may be one of two types of event, normal and critical. Critical
events can interrupt normal events, so these must have separate
fixmap slots and locks in case both event types are in use.

Signed-off-by: James Morse <james.morse@arm.com>

--
Changes since v7:
 * Use __end_of_fixed_addresses as an arch-agnostic invalid fixmap entry
 * Move the locks definition into the function that uses them to make it
   clear these are NMI only.

Changes since v6:
 * Tinkering due to the absence of #ifdef
 * Added SDEI to the new ghes_is_synchronous() helper.

---
 drivers/acpi/apei/ghes.c | 85 ++++++++++++++++++++++++++++++++++++++++
 include/linux/arm_sdei.h |  3 ++
 2 files changed, 88 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index dfa8f155f964..d0f0a219bf8f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -25,6 +25,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -86,6 +87,15 @@
 	((struct acpi_hest_generic_status *)				\
 	 ((struct ghes_estatus_node *)(estatus_node) + 1))
 
+/*
+ *  NMI-like notifications vary by architecture, before the compiler can prune
+ *  unused static functions it needs a value for these enums.
+ */
+#ifndef CONFIG_ARM_SDE_INTERFACE
+#define FIX_APEI_GHES_SDEI_NORMAL	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
+#endif
+
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
@@ -1088,6 +1098,63 @@ static void ghes_nmi_init_cxt(void)
 	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
 }
 
+static int __ghes_sdei_callback(struct ghes *ghes,
+				enum fixed_addresses fixmap_idx)
+{
+	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+		irq_work_queue(&ghes_proc_irq_work);
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int ghes_sdei_normal_callback(u32 event_num, struct pt_regs *regs,
+				      void *arg)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sdei_normal);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sdei_normal);
+	err = __ghes_sdei_callback(ghes, FIX_APEI_GHES_SDEI_NORMAL);
+	raw_spin_unlock(&ghes_notify_lock_sdei_normal);
+
+	return err;
+}
+
+static int ghes_sdei_critical_callback(u32 event_num, struct pt_regs *regs,
+				       void *arg)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sdei_critical);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sdei_critical);
+	err = __ghes_sdei_callback(ghes, FIX_APEI_GHES_SDEI_CRITICAL);
+	raw_spin_unlock(&ghes_notify_lock_sdei_critical);
+
+	return err;
+}
+
+static int apei_sdei_register_ghes(struct ghes *ghes)
+{
+	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
+		return -EOPNOTSUPP;
+
+	return sdei_register_ghes(ghes, ghes_sdei_normal_callback,
+				 ghes_sdei_critical_callback);
+}
+
+static int apei_sdei_unregister_ghes(struct ghes *ghes)
+{
+	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
+		return -EOPNOTSUPP;
+
+	return sdei_unregister_ghes(ghes);
+}
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
@@ -1123,6 +1190,13 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			goto err;
 		}
 		break;
+	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
+		if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d notified via SDE Interface is not supported!\n",
+				generic->header.source_id);
+			goto err;
+		}
+		break;
 	case ACPI_HEST_NOTIFY_LOCAL:
 		pr_warning(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			   generic->header.source_id);
@@ -1186,6 +1260,11 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_add(ghes);
 		break;
+	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
+		rc = apei_sdei_register_ghes(ghes);
+		if (rc)
+			goto err;
+		break;
 	default:
 		BUG();
 	}
@@ -1211,6 +1290,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static int ghes_remove(struct platform_device *ghes_dev)
 {
+	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1243,6 +1323,11 @@ static int ghes_remove(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_remove(ghes);
 		break;
+	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
+		rc = apei_sdei_unregister_ghes(ghes);
+		if (rc)
+			return rc;
+		break;
 	default:
 		BUG();
 		break;
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 393899192906..3305ea7f9dc7 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -12,7 +12,10 @@ enum sdei_conduit_types {
 };
 
 #include <acpi/ghes.h>
+
+#ifdef CONFIG_ARM_SDE_INTERFACE
 #include <asm/sdei.h>
+#endif
 
 /* Arch code should override this to set the entry point from firmware... */
 #ifndef sdei_arch_get_entry_point
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
