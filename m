Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:22:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C710D2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K+V/P/yl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rPZcUrZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C710D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tjrcDrt5E5a3uwAWvZFGpZP+qxpoCaUNSSMDQm6arZA=; b=K+V/P/yljxwHMS
	pNI7M9MuBeGabTDBRP0O47gLWo6Wa78Hb6V/nNoyDjS8V8xZokqe0U7qUlhRajTsh/X8shO+da2Vl
	5Y0AdC7RVP11ApU3BvGo8TO5XK2wakF9aFVlEh69DKLYnY4n2s7Ph1YvOoVQ3T9lm5l5ydxorDIX3
	cyx0zztOCd1LPiZ9kUFTZIwW3206T7kDbUtr4BSTc7QQ2162tjZKrtcGACHDL0USKR40e6FEXHz8o
	q15An9iOq8VK21yh+jqnkVlaMo3WBlc7+91FXfJvBBJBQUZTH1HCz9Me/ZaGL5fGBpZeuusF/+EGL
	XMDoRF5qMPQcS6zIKKqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsrm-0005kp-Pn; Mon, 03 Dec 2018 18:22:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsrd-0005ML-4h
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JjFMpXuQdPX46XYZAzvi+XQG8d/WswNsuRYargo7X0o=; b=rPZcUrZHDc9QwwS5NC55wM/0r/
 dVlfqpEg2Zs5xFah/TYCVjocnvVBWByfEex0zxGAJquvxMzrTQNOX0prUz+xXBtZJd14xyVMCN15P
 jmnLam0j0TofyTaYfm1r+0mxWSFbHRU603intJzeGbxX1hFK/pCOXn/oJzNFbA6whAglabA8Q7o5C
 QxGOacfryQL0sJELwdHyagBCd1Ftdvi+kUeCnFo4W9aCj8s52SabDVHzqX7kpogKBElg3GS3Ga1wg
 bOhoc9BVrfFJx5hnP2k3i6vGUIXxgJLSBNKcc+/Fz1yjxl+w4mTHgQP2h0CTCD+gEzIoLp7t+99Ke
 A9hGe8Fg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsdK-0001IZ-HH
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496F0169E;
 Mon,  3 Dec 2018 10:07:48 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 792003F59C;
 Mon,  3 Dec 2018 10:07:45 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 20/25] ACPI / APEI: Use separate fixmap pages for arm64
 NMI-like notifications
Date: Mon,  3 Dec 2018 18:06:08 +0000
Message-Id: <20181203180613.228133-21-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_180750_715003_5A4803D3 
X-CRM114-Status: GOOD (  12.56  )
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

Now that ghes notification helpers provide the fixmap slots and
take the lock themselves, multiple NMI-like notifications can
be used on arm64.

These should be named after their notification method as they can't
all be called 'NMI'. x86's NOTIFY_NMI already is, change the SEA
fixmap entry to be called FIX_APEI_GHES_SEA.

Future patches can add support for FIX_APEI_GHES_SEI and
FIX_APEI_GHES_SDEI_{NORMAL,CRITICAL}.

Because all of ghes.c builds on both architectures, provide a
constant for each fixmap entry that the architecture will never
use.

Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v6:
 * Added #ifdef definitions of each missing fixmap entry.

Changes since v3:
 * idx/lock are now in a separate struct.
 * Add to the comment above ghes_fixmap_lock_irq so that it makes more
   sense in isolation.

fixup for split fixmap
---
 arch/arm64/include/asm/fixmap.h |  2 +-
 drivers/acpi/apei/ghes.c        | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index ec1e6d6fa14c..966dd4bb23f2 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -55,7 +55,7 @@ enum fixed_addresses {
 #ifdef CONFIG_ACPI_APEI_GHES
 	/* Used for GHES mapping from assorted contexts */
 	FIX_APEI_GHES_IRQ,
-	FIX_APEI_GHES_NMI,
+	FIX_APEI_GHES_SEA,
 #endif /* CONFIG_ACPI_APEI_GHES */
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 849da0d43a21..6cbf9471b2a2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -85,6 +85,14 @@
 	((struct acpi_hest_generic_status *)				\
 	 ((struct ghes_estatus_node *)(estatus_node) + 1))
 
+/* NMI-like notifications vary by architecture. Fill in the fixmap gaps */
+#ifndef CONFIG_HAVE_ACPI_APEI_NMI
+#define FIX_APEI_GHES_NMI	-1
+#endif
+#ifndef CONFIG_ACPI_APEI_SEA
+#define FIX_APEI_GHES_SEA	-1
+#endif
+
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
@@ -954,7 +962,7 @@ int ghes_notify_sea(void)
 	int rv;
 
 	raw_spin_lock(&ghes_notify_lock_sea);
-	rv = ghes_estatus_queue_notified(&ghes_sea, FIX_APEI_GHES_NMI);
+	rv = ghes_estatus_queue_notified(&ghes_sea, FIX_APEI_GHES_SEA);
 	raw_spin_unlock(&ghes_notify_lock_sea);
 
 	return rv;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
