Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BAAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:32:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B0C208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dPJxTTH5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VVOrGXjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B0C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dqy+BE15kDC3UIUVgEbpSC88R66TdBm0v6uMwRRFrCw=; b=dPJxTTH5JsaazO
	iwZEULN22NUYn/FslUnXA5UsLKMeZH5FJF/JRjdp7PkV5lj2XWzHiXpF7qEnOSwyNQQn5aAHlNEqN
	SzLGRAoYYUlphh3gIoJ6niUKuyfBaWA0zPEfcOyisBqnV8JtezptjitUjWTN5keRVAUBo/aQfZtSO
	oKwVXCIzacESUwlcSoMIoarN1U+A5IsFtbDPdfAynvoT06T+nsQhAo2tc5bAKsUfvOULjPEHY6koc
	7rmpog4BVfADYbKOX22RMjLtiZrRmnWulOh6C7wk5F68VKsou9cTFBsYI8E5udgfc95saYaIirJNV
	HDWudo5yLaXw6SQ8YAWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt16-00045M-Io; Mon, 03 Dec 2018 18:32:24 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt0K-0003LE-00
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yYwIdTKWeRNtz5QSmMouRNEU9UwxT/m3QVZga4V1oPc=; b=VVOrGXjB1xy8+IIE+nk97wzP9W
 XAXPK5nIvz9TBSuwPC0xASwgCXJTWK6sG8bzdW33lLxPp4uC/8IZo/yldVIV8cF1+T83k0AHqsvB0
 2muh9xy4zekhD/uXP4bqnbJjhBNgXtU3Z28QpSCp2XVaO6zzJCOKsLX/zhjj23reqRNqjf4Wj53h/
 rmO8HbFKtX0qZPTmRayiZOW2l6S0oqV9WlhKdg4u0FZ+icYXhGxHYmb3u9Q12UplcjGNaVrOZjNnV
 3mw6zjJ4hPk+UDwRQqDaHPLc4UQuKl8w3ijBGZgzZ5yp5sNJJkUmzINE1+2AOTh0fPvxW7gksjCp6
 zE3bh44w==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsdT-0001f2-0q
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:08:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE757169E;
 Mon,  3 Dec 2018 10:07:58 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A36C3F59C;
 Mon,  3 Dec 2018 10:07:55 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 23/25] arm64: acpi: Make apei_claim_sea() synchronise with
 APEI's irq work
Date: Mon,  3 Dec 2018 18:06:11 +0000
Message-Id: <20181203180613.228133-24-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_130759_324280_786B31BB 
X-CRM114-Status: GOOD (  21.19  )
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

APEI is unable to do all of its error handling work in nmi-context, so
it defers non-fatal work onto the irq_work queue. arch_irq_work_raise()
sends an IPI to the calling cpu, but this is not guaranteed to be taken
before returning to user-space.

Unless the exception interrupted a context with irqs-masked,
irq_work_run() can run immediately. Otherwise return -EINPROGRESS to
indicate ghes_notify_sea() found some work to do, but it hasn't
finished yet.

With this apei_claim_sea() returning '0' means this external-abort was
also notification of a firmware-first RAS error, and that APEI has
processed the CPER records.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
CC: Xie XiuQi <xiexiuqi@huawei.com>
CC: gengdongjiu <gengdongjiu@huawei.com>
---
Changes since v6:
 * Added pr_warn() for the EINPROGRESS case so panic-tracebacks show
   'APEI was here'.
 * Tinkered with the commit message

Changes since v2:
 * Removed IS_ENABLED() check, done by the caller unless we have a dummy
   definition.
---
 arch/arm64/kernel/acpi.c | 22 +++++++++++++++++++++-
 arch/arm64/mm/fault.c    |  9 ++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 803f0494dd3e..421331157e8f 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irq_work.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/smp.h>
@@ -268,13 +269,17 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 int apei_claim_sea(struct pt_regs *regs)
 {
 	int err = -ENOENT;
-	unsigned long current_flags;
+	unsigned long current_flags, interrupted_flags;
 
 	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
 		return err;
 
 	current_flags = arch_local_save_flags();
 
+	interrupted_flags = current_flags;
+	if (regs)
+		interrupted_flags = regs->pstate;
+
 	/*
 	 * SEA can interrupt SError, mask it and describe this as an NMI so
 	 * that APEI defers the handling.
@@ -283,6 +288,21 @@ int apei_claim_sea(struct pt_regs *regs)
 	nmi_enter();
 	err = ghes_notify_sea();
 	nmi_exit();
+
+	/*
+	 * APEI NMI-like notifications are deferred to irq_work. Unless
+	 * we interrupted irqs-masked code, we can do that now.
+	 */
+	if (!err) {
+		if (!arch_irqs_disabled_flags(interrupted_flags)) {
+			local_daif_restore(DAIF_PROCCTX_NOIRQ);
+			irq_work_run();
+		} else {
+			pr_warn("APEI work queued but not completed");
+			err = -EINPROGRESS;
+		}
+	}
+
 	local_daif_restore(current_flags);
 
 	return err;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 956afc7d932a..c26ee1f1cc36 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -629,11 +629,10 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 
 	inf = esr_to_fault_info(esr);
 
-	/*
-	 * Return value ignored as we rely on signal merging.
-	 * Future patches will make this more robust.
-	 */
-	apei_claim_sea(regs);
+	if (apei_claim_sea(regs) == 0) {
+		/* APEI claimed this as a firmware-first notification */
+		return 0;
+	}
 
 	if (esr & ESR_ELx_FnV)
 		siaddr = NULL;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
