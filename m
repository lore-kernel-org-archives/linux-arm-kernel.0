Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700EEC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:40:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412D420844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mP6Na6yh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYWWdogH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412D420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NRfD7QQJoZEAfPnl5AR95aD6iweGjPkGfMkXob96miM=; b=mP6Na6yhoDAiyliGqCpZcmq2bN
	xoZTrq0S8V5dbKfc68v41r8AnCxG8DZODt2Hc2SoipgaT/2K5R6Bf7XBz2hRchlDqor1jbYyU3nb/
	lwWfzES8CkUxm10Vni7iTAS6KxPYVeBBF5F+EVVtfLpXSr6zRXex+lU17uW8NgUcB1RpOzZ8rk/ET
	aGi7ZkB/NlWDdN1kVGUCkw19QtK85aDnerufO7W+CJZfCtWcQ18c7r6YYEqbH1c5OskDZcwa1JE8R
	sNuDL1irE/5ZmcmnF6WZhXh2iBW5QorSgX9DLgCI2VccHX7qj7axrtCsar/7pHgRuUDvCrchU6Tjm
	u2IRT7gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpkI0-00052e-Hu; Sat, 02 Feb 2019 01:40:12 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpkH9-0003tT-9O
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 01:39:55 +0000
Received: by mail-pg1-x542.google.com with SMTP id n2so3760854pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 17:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6fivvub99Xix9SC3KKfxY3DnEgPVHfJZb9qun3OaRWg=;
 b=rYWWdogHyyfoXHNw5vYGz1rLozTLpmOkP0KHq197u7SHmMLbh+SkNqa7NpQtSdMfQq
 Sg2+fJLGoIFUvNopzkSuf+xcc4vTZubXH7cPBLLLEF9z9cMpKmuLzM00WWcaWtYOlYoY
 8QZOVzS/gUsOqXwweSfmeSAQirZ8DFeZxbW/1g1BV9EA1eQNZMAK5En0+ASsQb0IFPtW
 9ehITCoiqh4YiLLPrNJ9/A5Hqo5hIs9LcngkxxNaQ7bQ2DORxuesRxtd5sJsPHHiZCUq
 iuLVUhdb9FEKI7KaHoyxW5MzXqgNtzYoWOuflVepi2+pqZY5pl9G0HkcTbOHhVZ1b240
 7JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6fivvub99Xix9SC3KKfxY3DnEgPVHfJZb9qun3OaRWg=;
 b=pcRGXAMpqDRk6Ms4lcybhUJKMsNTV2/j/bWnYfRNzeRbzr99yKGckHCMufzhc460Xw
 plqvB0KDo+kZzh7dXPTf4PoXciTVhu22G7T1I23UKj8C/vWh9YuC3z/8U4Jvy+1u42ID
 czQHSUZpXzsRJkZ21BixVtWDXQggqViobN2xcX29KXi9nRJMmeLHVdNCkij3ipm50jfv
 /nv0/8W6BZW+lSL4nmkpIyzX60elmukOXMbnn+vcLf4DJa5ujBtXveVUcm1BpUSPvE8F
 mlffqxcVruemD0vWkIU/02hsvWKOUmEoNSurfIC7setZgDvcoBGVX3CPZ1MfiubvBgdZ
 VW1g==
X-Gm-Message-State: AJcUukcNfcIHB8EeknuWgqw9c1Nl3Upn6fuGXVJjcun+ZQQDlqIz9rhF
 YpxYcFTBFVMhzRLdPQThl5E=
X-Google-Smtp-Source: ALg8bN7W+aadejbG7oa19lQl7G9yPYUZCeqRb9Yml4K7aisKFkTmeYC8Fchg3oAyUGiZP9Vgewt9Xw==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr41603341pfw.256.1549071557589; 
 Fri, 01 Feb 2019 17:39:17 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:16 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 4/10] KVM/MMU: Introduce tlb flush with range list
Date: Sat,  2 Feb 2019 09:38:20 +0800
Message-Id: <20190202013825.51261-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_173920_062418_E292BA04 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, benh@kernel.crashing.org,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to introduce tlb flush with range list interface and use
struct kvm_mmu_page as list entry. Use flush list function in the
kvm_mmu_commit_zap_page().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 70cafd3f95ab..d57574b49823 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -289,6 +289,20 @@ static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 
 	range.start_gfn = start_gfn;
 	range.pages = pages;
+	range.flush_list = NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct hlist_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	if (hlist_empty(flush_list))
+		return;
+
+	range.flush_list = flush_list;
 
 	kvm_flush_remote_tlbs_with_range(kvm, &range);
 }
@@ -2708,6 +2722,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	HLIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2721,7 +2736,15 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
+			if (sp->last_level)
+				hlist_add_head(&sp->flush_link, &flush_list);
+
+		kvm_flush_remote_tlbs_with_list(kvm, &flush_list);
+	} else {
+		kvm_flush_remote_tlbs(kvm);
+	}
 
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
 		WARN_ON(!sp->role.invalid || sp->root_count);
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
