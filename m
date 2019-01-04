Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:57:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586C62184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m/bJ+a+g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1NjRFrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586C62184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=K1Re2XPhYsQak9KhVE/Ld59y2W8WzURP64lEzj/k1Aw=; b=m/bJ+a+gVfYj5ubclOFH9U1LsH
	ve8tY+pIMlDdxeg9moS6ONTbVZ4ecG4ZVioCSAPh2khryxoUbUIqD5Ao5cUOABPiOaguzC9q/+gA/
	H8hAc1zhOVWtSP/2S/Z5M89wsxhrMF9tM6b+Xvs2ogoirk+nZfRbue0lZ38LUlTpeUgR2rI+8L/RH
	shxOfSayLSQIAtLRwtIXfJ/WtPLXR6ffZohiiqt3YLLJ//Thd30Reh9DGCKYT/1eBc7eY7SKSh0SC
	iMbTpZD/uD8BG93QHzNfS0es8hX+I0hphcAWk5niek61F0wa1Wwk012aDvhwTRhMJGDC/zgZmJTlF
	ptu/u2Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLI7-0001Ic-78; Fri, 04 Jan 2019 08:57:19 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLGK-00084a-5X
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:55:41 +0000
Received: by mail-pf1-x442.google.com with SMTP id 64so17993089pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZK8Ep/iS40KCOfUlldAdh4saGJOIzh8GKtl9Mv0nhLM=;
 b=G1NjRFrN/C6osVf7UtbSVtMVpqA9Ea/+QkseFh5fipznXIehIqBOj+WICVCUWsH4fm
 XXrhC1ChDLsoNN78/Jf69XvF4QTvyKS9C0EiG02MtsqGdb/vznYx/ApjHr3GqQaAnc59
 iAzfvakgMPJ9lrvgBNJm4sYCxASvjQdGTWmPXRnBeoYThC7wrSDBO3dfRbcb5WIyDr3H
 /Cn6OmQEBoOqFU++9g31s+9rVVQi9bp8oJg2/DBj/pdk8x12iaIwwR0R4dkwHBh3RkSW
 8wMmO9dWO47ftRi5WiiLwFVdRdVrMEsSK046I7vBDMukcSQjf0h6zVVmkLcMYlYK+egF
 HwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZK8Ep/iS40KCOfUlldAdh4saGJOIzh8GKtl9Mv0nhLM=;
 b=GknRF/px1xGMIupzJ2eq2ZwfmwPF1gKBI56SwRzV9C9Z39zFBRFvxh3NAJbtN/74XR
 Pos2C3BMYxJchb1y9c9JMK2Xl04eBWORsf1Ea0c8gZbpli+H+Zmy9Gkg5oPlL4fo6fDo
 bswNts69fSXGFT6EdQYZRpiLOTBJx/8qeC/+IATn2eqvbp9q9CVHRZwpjwZ0DpwADMYz
 N9yzyHEusqYPJ7TcctVhn8Q65u6fFLILXhen41nY/zFWxy0pTTb9Pv2X8TiUusufgfwh
 Fg/ofSbTzTYmV4ohZqL4zH2xQQa3VMn5GwntzVZ97px8X00/xPqcEUHiHprKJMtrS4ZT
 kTYw==
X-Gm-Message-State: AJcUukctdyExuZL8+aTxd0K+QJAi7fLCrwtvKJH4ZDHkRhQVp/zxuv0/
 elAX4hYCKWVA4jiMqaVqeGY=
X-Google-Smtp-Source: ALg8bN75sfO1wfGgbU1C9NYyKaexIVA3NbEhpqovnyfTJeb3GDT9BdXc/J/k5irnfWBqolOtTpXZ/g==
X-Received: by 2002:a63:da45:: with SMTP id l5mr909998pgj.111.1546592127395;
 Fri, 04 Jan 2019 00:55:27 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:55:26 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 9/11] KVM/MMU: Flush tlb in the
 kvm_mmu_write_protect_pt_masked()
Date: Fri,  4 Jan 2019 16:54:03 +0800
Message-Id: <20190104085405.40356-10-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005529_041361_7600C5D9 
X-CRM114-Status: GOOD (  13.47  )
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

This patch is to flush tlb in the kvm_mmu_write_protect_pt_masked() when
tlb range flush is available and make kvm_mmu_write_protect_pt_masked()
return flush request.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 9d8ee6ea02db..30ed7a79335b 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1624,20 +1624,30 @@ static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
  * Used when we do not need to care about huge page mappings: e.g. during dirty
  * logging we do not have any such mappings.
  */
-static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+static bool kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 				     struct kvm_memory_slot *slot,
 				     gfn_t gfn_offset, unsigned long mask)
 {
 	struct kvm_rmap_head *rmap_head;
+	bool flush = false;
 
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PT_PAGE_TABLE_LEVEL, slot);
-		__rmap_write_protect(kvm, rmap_head, false);
+		flush |= __rmap_write_protect(kvm, rmap_head, false);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
 	}
+
+	if (flush && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm,
+				slot->base_gfn + gfn_offset,
+				hweight_long(mask));
+		flush = false;
+	}
+
+	return flush;
 }
 
 /**
@@ -1683,13 +1693,14 @@ bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				struct kvm_memory_slot *slot,
 				gfn_t gfn_offset, unsigned long mask)
 {
-	if (kvm_x86_ops->enable_log_dirty_pt_masked)
+	if (kvm_x86_ops->enable_log_dirty_pt_masked) {
 		kvm_x86_ops->enable_log_dirty_pt_masked(kvm, slot, gfn_offset,
 				mask);
-	else
-		kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
-
-	return true;
+		return true;
+	} else {
+		return kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset,
+				mask);
+	}
 }
 
 /**
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
