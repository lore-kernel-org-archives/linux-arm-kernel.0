Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D90C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:11:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549B120869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qcp9HxOd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zfvnstm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549B120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kn20IcRUy1j0JL8me/g7VRWL2PyXJ+6yQAcUo5AblYo=; b=Qcp9HxOdWLHNHn
	3Xzysd34bhiugeLv0fn4uYIHd20vgMbV7ahGHJCl2EY/ssBFicNArRiX/V3PUtDtkpEPRj35e2mor
	phZVeFJmS9F79viFtDN/7y4nrMxO6fdhRGqj/w+r0m5qgt/h1CSzknK7xpZFCelZVAUC49J65Kagw
	Qw6CmdCr3GbTeu3AzurunxHnVdoMF59/5kJL29l/fUjXwV58p+PWabFc1DgFTMXK1fHnODA1IJ2SE
	jfUmQQkT0CmKFqKdLXMSuVfy4XJSad1X4WGbCeQhjMvN0gdysYAeJulYFVYUTxi3IeY4i4+YjlAIm
	UTL2VKB+6KBMzIWNoA1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYnW-0005hg-Cy; Tue, 29 Jan 2019 19:11:50 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYmX-0004kD-PD
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 19:10:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WYxvlKVfAa6t/tNZfSF0UteJyG2GjojemqgH68lA8Pg=; b=Zfvnstm72WTWp2pqIhutRRMK66
 w+VxiHzdgHfb6yJjgtPB+z+HD5IeLCN1V7bz67IUCf7rJA7iKim8NgPB2brduDybe3/11Br59/UOW
 ACDqGsM+viKiJFd+DFgSinS2yNqYG9vb32WSYRXh2UJw/fsQe0OP/F5UOLvDFFsuvvw4Q19WVwW7P
 ypu5d+SGBn5unUw/Mb9DO/aUAJ0MEWMisfdChqTnHOOxYUvIhJGn56lTFGOhTEk67Bzma7kkfXQfj
 EHn0LpfxYOjjeO4t00dS6gamZOzgzMIEdsmwexO2PjXWwzecNtYOdIQWgX5nx7MkZWomtsCWdYDgA
 BZzi/arA==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYT2-0005ZU-8t
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B90315AB;
 Tue, 29 Jan 2019 10:50:40 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E72A3F557;
 Tue, 29 Jan 2019 10:50:37 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 21/26] ACPI / APEI: Use separate fixmap pages for arm64
 NMI-like notifications
Date: Tue, 29 Jan 2019 18:48:57 +0000
Message-Id: <20190129184902.102850-22-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_135040_421960_08735E03 
X-CRM114-Status: GOOD (  15.85  )
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
Changes since v7:
 * Removed v6's #ifdefs, these aren't needed now that SEA/NMI can't be
   turned off on their respective architectures.

Changes since v6:
 * Added #ifdef definitions of each missing fixmap entry.

Changes since v3:
 * idx/lock are now in a separate struct.
 * Add to the comment above ghes_fixmap_lock_irq so that it makes more
   sense in isolation.
---
 arch/arm64/include/asm/fixmap.h | 2 +-
 drivers/acpi/apei/ghes.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index 957c1559ebf5..e6f0d176b245 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -958,7 +958,7 @@ int ghes_notify_sea(void)
 	int rv;
 
 	raw_spin_lock(&ghes_notify_lock_sea);
-	rv = ghes_in_nmi_spool_from_list(&ghes_sea, FIX_APEI_GHES_NMI);
+	rv = ghes_in_nmi_spool_from_list(&ghes_sea, FIX_APEI_GHES_SEA);
 	raw_spin_unlock(&ghes_notify_lock_sea);
 
 	return rv;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
