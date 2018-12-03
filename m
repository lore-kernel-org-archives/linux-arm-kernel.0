Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8463AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:31:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117F82145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j5qTLDSi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XAEXhf3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117F82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VKdUs0/RBYcIF67Mhdf9AvZMdYg3sktEFG3MN/7qz+c=; b=j5qTLDSiLr+eG+
	yArNUjIV5wmJps+WwNutoH+knW7bKx9diDKiDg1yOdlVHc9u8KiVOdy++44AvO8u2AA1xZILeQicf
	P+qmMOQ3RSWnt3ErTVENDQ0FFbaZCzO9Feq4hy/BQEyjBuM7si3DxmzCVAQNrGTyEtEUOUgceddEP
	sl7tZaFJ/FHATzCcnFKhzFWutdv3b1HfgIFRmONmRGYmZ8YKMFjN33u6KCT7t+Gv8LShd1lg51TxG
	oVvJKqUFKXk9blj6IWGtJMl0xxRsm6TzQnRxcLOsgJjUq4TUSZ6VQWfPxHy2owfOkPLUkeMvvhzCg
	cQRviZcSNoyLkttJPnHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt0S-0003Y6-4v; Mon, 03 Dec 2018 18:31:44 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt0I-0003LE-Dn
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gMemP6CVYESD7JPOg7f7tWzOngUpBjOLmcBn3e9J/LM=; b=XAEXhf3pVoMViWZLVYhtTgIgtZ
 /JaO8o0c8xSEQsC//N+kbuQnHxxhSJfkal9yTRtMbUHit9+6atkPeNvKkOUbH8T2STKWa/bQdL1er
 66bZh/F1i2yJg5/4/3H6DtEeyjROFbED3Zsfdrb1XSQ73UmnKsy9ehqN2NIJEsq7SB7veQOVa02RB
 3lFtgJlEoIUG1xWYzdj0zY+xtXhI77x9/UQQiUqB7CJOe1SIZTlnmZE5HGE7cqvEDmad97G1kXFln
 FkA0HMO5P/wG6tbcONy5tVLXM2Mvgkb1Bs9ZNA6F2y2niGvWMUdsg9uQ5kASnwiMwE+VYAuwd7vH7
 1kBv5/7A==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsdh-0001gl-9m
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:08:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 660F71713;
 Mon,  3 Dec 2018 10:08:02 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 950123F59C;
 Mon,  3 Dec 2018 10:07:59 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 24/25] firmware: arm_sdei: Add ACPI GHES registration helper
Date: Mon,  3 Dec 2018 18:06:12 +0000
Message-Id: <20181203180613.228133-25-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_130813_564489_CFDBE2BF 
X-CRM114-Status: GOOD (  24.06  )
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

APEI's Generic Hardware Error Source structures do not describe
whether the SDEI event is shared or private, as this information is
discoverable via the API.

GHES needs to know whether an event is normal or critical to avoid
sharing locks or fixmap entries, but GHES shouldn't have to know about
the SDEI API.

Add a helper to register the GHES using the appropriate normal or
critical callback.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v4:
 * Moved normal/critical callbacks into the helper, as APEI needs to know.
 * Tinkered with the commit message.
 * Dropped Punit's Reviewed-by.

Changes since v3:
 * Removed acpi_disabled() checks that aren't necessary after v2s #ifdef
   change.

Changes since v2:
 * Added header file, thanks kbuild-robot!
 * changed ifdef to the GHES version to match the fixmap definition

Changes since v1:
 * ghes->fixmap_idx variable rename
---
 arch/arm64/include/asm/fixmap.h |  4 ++
 drivers/firmware/arm_sdei.c     | 70 +++++++++++++++++++++++++++++++++
 include/linux/arm_sdei.h        |  6 +++
 3 files changed, 80 insertions(+)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 966dd4bb23f2..f987b8a8f325 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -56,6 +56,10 @@ enum fixed_addresses {
 	/* Used for GHES mapping from assorted contexts */
 	FIX_APEI_GHES_IRQ,
 	FIX_APEI_GHES_SEA,
+#ifdef CONFIG_ARM_SDE_INTERFACE
+	FIX_APEI_GHES_SDEI_NORMAL,
+	FIX_APEI_GHES_SDEI_CRITICAL,
+#endif
 #endif /* CONFIG_ACPI_APEI_GHES */
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1ea71640fdc2..4bcbe3a3f597 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2017 Arm Ltd.
 #define pr_fmt(fmt) "sdei: " fmt
 
+#include <acpi/ghes.h>
 #include <linux/acpi.h>
 #include <linux/arm_sdei.h>
 #include <linux/arm-smccc.h>
@@ -32,6 +33,8 @@
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 
+#include <asm/fixmap.h>
+
 /*
  * The call to use to reach the firmware.
  */
@@ -887,6 +890,73 @@ static void sdei_smccc_hvc(unsigned long function_id,
 	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, 0, 0, res);
 }
 
+int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
+		       sdei_event_callback *critical_cb)
+{
+	int err;
+	u64 result;
+	u32 event_num;
+	sdei_event_callback *cb;
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
+		return -EOPNOTSUPP;
+
+	event_num = ghes->generic->notify.vector;
+	if (event_num == 0) {
+		/*
+		 * Event 0 is reserved by the specification for
+		 * SDEI_EVENT_SIGNAL.
+		 */
+		return -EINVAL;
+	}
+
+	err = sdei_api_event_get_info(event_num, SDEI_EVENT_INFO_EV_PRIORITY,
+				      &result);
+	if (err)
+		return err;
+
+	if (result == SDEI_EVENT_PRIORITY_CRITICAL)
+		cb = critical_cb;
+	else
+		cb = normal_cb;
+
+	err = sdei_event_register(event_num, cb, ghes);
+	if (!err)
+		err = sdei_event_enable(event_num);
+
+	return err;
+}
+
+int sdei_unregister_ghes(struct ghes *ghes)
+{
+	int i;
+	int err;
+	u32 event_num = ghes->generic->notify.vector;
+
+	might_sleep();
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
+		return -EOPNOTSUPP;
+
+	/*
+	 * The event may be running on another CPU. Disable it
+	 * to stop new events, then try to unregister a few times.
+	 */
+	err = sdei_event_disable(event_num);
+	if (err)
+		return err;
+
+	for (i = 0; i < 3; i++) {
+		err = sdei_event_unregister(event_num);
+		if (err != -EINPROGRESS)
+			break;
+
+		schedule();
+	}
+
+	return err;
+}
+
 static int sdei_get_conduit(struct platform_device *pdev)
 {
 	const char *method;
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 942afbd544b7..393899192906 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -11,6 +11,7 @@ enum sdei_conduit_types {
 	CONDUIT_HVC,
 };
 
+#include <acpi/ghes.h>
 #include <asm/sdei.h>
 
 /* Arch code should override this to set the entry point from firmware... */
@@ -39,6 +40,11 @@ int sdei_event_unregister(u32 event_num);
 int sdei_event_enable(u32 event_num);
 int sdei_event_disable(u32 event_num);
 
+/* GHES register/unregister helpers */
+int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
+		       sdei_event_callback *critical_cb);
+int sdei_unregister_ghes(struct ghes *ghes);
+
 #ifdef CONFIG_ARM_SDE_INTERFACE
 /* For use by arch code when CPU hotplug notifiers are not appropriate. */
 int sdei_mask_local_cpu(void);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
