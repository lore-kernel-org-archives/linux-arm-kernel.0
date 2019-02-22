Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03121C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7892075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZX+KLLfu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFBImuIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7892075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=atyD1yUwm6eou8bwV7ETKDYVW1lGB8cJ1zmnO13Y3Iw=; b=ZX+KLLfuodKwAm6MsQWW0coKD1
	rmzVRxxa/nj1eW/Z23R6y1ITruwb4Qi+EmdOd622p4H1OfgANA0kIgmSIj6ng/nU6nBNYRkSQUasX
	j0FjFeK6DtJUJ1GeGoy+M8RWz6YYLkytLt6+Q7ojfCrWrGYXKl6bMm0pYx3MjZr50D35YKRTTPsYV
	P9PgEqR7DOAnvA9ncdTxaEPg53R2upSGOvDcr5PkicBK5GK6KB7OTzh388fknboTUqQxtHe9Uq+mH
	7hwuAgtq2iPEcdwilHC5rLJzl0n1XTjciv6gUoqpI5UWD+9LAoDF945E5tlX0b0CJ7/faW8xk/Owb
	TkRkJRLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCQQ-0000LA-3u; Fri, 22 Feb 2019 15:07:42 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCQ3-0008Tg-Og
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:07:26 +0000
Received: by mail-pl1-x644.google.com with SMTP id e5so1228973plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Mf/z10rMsVUftoqc8y3M+np7GkZ7fKmVzfglvuSuVXs=;
 b=CFBImuIfxVblpp2dVFSl9Lp9rPMyBKJbp6SYubcKgkfBvz6HEnk2yuVurnpcFMX2jU
 cTnhiQi/FOhPDBwkoIQDJLl0zyH3eS9nXM4J9QsHwFxLU0MIYCx/f0WjO0sKTtmcgRV8
 AxLNTbxwQz+kF7evW9hWhTBmzTA/d0zBmJcztZRYNpgfeo0j99UBLFidJY2Va7EAP1M1
 CmD+rEsUr+8L9SZnkQLZ18nAAAlVLhEpxaYU64OrDAXS0e/CFewKx4NO/okJzcUpM0Cb
 jQknNeAoXBSSXwIAomw0sE6m+7zn4B+9Ndv/Mmzu5dSlNwXJHDC/5kjPbjjc1tazRh38
 fSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Mf/z10rMsVUftoqc8y3M+np7GkZ7fKmVzfglvuSuVXs=;
 b=UajHHY0lCcwPb1EXFVbJGSh5JUwz4P1wVuvplYtf+GSGugKsfxfGLFtDDnFHfx9DU8
 Xi0wYMFzKbQ7WpQQq2x9xOQ9KyPHiR/0fiqyX9cfAwiSXH0Y2YnmPntmJyxvpVLT4Z/X
 l8cHLFNe+iri7P7jSX5SW2bp4MN5naYFP3WuZt+4CPkXvBun4vLoOI3yr6djD7In8jpi
 VFfXtvTzLCSweKjFiV4jiMGG3K7In2GWjmp1xSAYgeD55NvMOUinJCTKLMfnE1aNMfmY
 PGLIgS34n33CZzys5Us7HB3erZNBbz38LSmDaZA79pgnBgAVyR+R6oqUpFX9lgOw4pU0
 VDRw==
X-Gm-Message-State: AHQUAuaok0q9cGNWINZc6r9OST4FnuuiCB9mfJ1iEA4toOBPXREcUqEA
 BZu9haWeJTDBaGwEZkE3ebU=
X-Google-Smtp-Source: AHgI3IZvijtWlx7ZoYkznF2XUyI7kKJ/XBTUftVSqGMWnP6U+sXA5icoLNJDjyf30+XMJJVp91f3sw==
X-Received: by 2002:a17:902:2be8:: with SMTP id
 l95mr4682383plb.270.1550848039252; 
 Fri, 22 Feb 2019 07:07:19 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:18 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 3/10] KVM/MMU: Introduce tlb flush with range list
Date: Fri, 22 Feb 2019 23:06:30 +0800
Message-Id: <20190222150637.2337-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070720_085569_207DEB06 
X-CRM114-Status: GOOD (  11.98  )
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
 arch/x86/kvm/mmu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 8d43b7c0f56f..7a862c56b954 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -291,6 +291,20 @@ static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 
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
@@ -2719,6 +2733,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	HLIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2732,7 +2747,14 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
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
