Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F2DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:11:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA8E20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h758bvGR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S+jGx83p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA8E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kyQZ07GsJDmp1fuPkQWSzbmnqgEIpagpHR2I+VefGhY=; b=h758bvGRAxqvze
	OURU1so3P8tvVT+27cudvzsU25DVPz0jE8ayWQBjOiklVpM8mQLVBsQbUDFe+zYOv12vrbqbmhl2t
	A3kM9XMR3HaMbeQ5lajtMOYSmt48/3gKF5VeTBl6slqTaOGHNJJogPcE9ZZzzK6SBOSD0V+KqlU1X
	oVNPbZMbhKlts1XG5e1LVA7flKl60iEZF8jEG1K3XAqTIym21Zf5Z22jGULPIwHcD/+tLSTbWZLk1
	o0c9Nhf4pSVZPSxiTv4vDhUeRBwyFZIbd4hq2wDUvv+fcM00gymq8EwY+7ozTGM7ktbK5UkqEtvxG
	M/RYvS9KNbmHOzYEdeLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYn2-0005CH-27; Tue, 29 Jan 2019 19:11:20 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYmU-0004kD-SD
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 19:10:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j7b/Tpctf8lj076ai58Sj9p0zuBf66lnA97pNz2XZng=; b=S+jGx83p6m/0bfB75HLQNsd1SE
 Y5UC5TGxxL2RiMCIYzwEHoXb/f7i4VlBCju1wsXnzE2MP4izdnY4KmO305pTlRtA/ecJxpwWmrETa
 PfefckvH6F8k5bK041CpCPXzmKwo8LiJ7jkPDaNQ0ZXK8R7O7RozLYiQxBf100G/q1yD5UsUwGcML
 Czs+wBdVMO7lPHCfpBTxaeEDkdifoZ8UMaBVns6/yMkDK4r/KiaLyekZ7mzL6699NMhaGqK0zMIjw
 8Z5pxF4kcYt6n6hVr6PMl8nrqJmPE3uBzjjLSvXuxCU6pbxWH+7g4nklqKIFeBhKj/92TEeh2DLzR
 ifiJSUlg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYTD-0005aU-Te
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFB9815AB;
 Tue, 29 Jan 2019 10:50:51 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EBD83F557;
 Tue, 29 Jan 2019 10:50:48 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 25/26] firmware: arm_sdei: Add ACPI GHES registration helper
Date: Tue, 29 Jan 2019 18:49:01 +0000
Message-Id: <20190129184902.102850-26-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_135052_399034_9A6B5935 
X-CRM114-Status: GOOD (  24.23  )
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

APEI's Generic Hardware Error Source structures do not describe
whether the SDEI event is shared or private, as this information is
discoverable via the API.

GHES needs to know whether an event is normal or critical to avoid
sharing locks or fixmap entries, but GHES shouldn't have to know about
the SDEI API.

Add a helper to register the GHES using the appropriate normal or
critical callback.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>

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
 drivers/firmware/arm_sdei.c     | 68 +++++++++++++++++++++++++++++++++
 include/linux/arm_sdei.h        |  6 +++
 3 files changed, 78 insertions(+)

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
index c64c7da73829..e6376f985ef7 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2017 Arm Ltd.
 #define pr_fmt(fmt) "sdei: " fmt
 
+#include <acpi/ghes.h>
 #include <linux/acpi.h>
 #include <linux/arm_sdei.h>
 #include <linux/arm-smccc.h>
@@ -887,6 +888,73 @@ static void sdei_smccc_hvc(unsigned long function_id,
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
