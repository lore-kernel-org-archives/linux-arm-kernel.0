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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D87D206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TQCqhUX3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUohI3Aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D87D206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8MIUxOxpWyJ8cSciLa/8s1LE/j3QtgGI/z2BmOy+Gwc=; b=TQCqhUX3qcykut7Ii8Bl6nD5bJ
	tYx0ehIjZ6/fPbegvHbzsvwY4upBYKKb85uhVO/RIIIRrnL/p7WTDBzog/zAhkc1N5PBYtToYlv3V
	9UROdfEO2E1QoiEa5yBTWwVZoIn5VstsnXuFWegYwQNjeTxvgBEpm6PmQCnD8VA+MTol3JfXX/t+n
	fLa3CsmOc/laPMl0izImWlGY3uGiQhE70Y1TP/MV3zL68wIiQ3Vp/LkBfmjkh/gowPyDKnQdj5CRt
	9wYm+aa/WtpmKZmO5MFpbEXrENr3Qrc/iZ8P9BPfNmKJB6stegTF3GvJMRGu2JL026zZi3GgwDZTf
	UywA6Byg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLGF-0007cK-UZ; Fri, 04 Jan 2019 08:55:23 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLFb-0006Dr-86
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:54:54 +0000
Received: by mail-pg1-x544.google.com with SMTP id z11so17241476pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sAXI9KUfdDUDhWP7B1nKmtj4xb/BMelYpMd0QbjlSBM=;
 b=nUohI3AjWQx6ybvOgpH7SxHa8o5nsYzlNw8zm2CmuYood2//x0Ie4POL9QksnHBF2I
 YUbLZhd1Rp+Pw6ZIBVPNdREu5ob8/NSLRq6m6/VDtSShPyah6oXk0qwJ6GERJPgXeO6u
 EUrdYFIOaWou/NJf40/UaAiehOFsZxMS2TqrBcwpH33yZixYhEMZPtTbO+uZ+PPeOhxm
 zlA1ylEHJ9eNnEnCg0PxAzkRvuMGjQSok91W0OHcF2QBzYWHJGfBB0JFkC9KNPbDKMby
 Hmyv2RXoicnEdLehOZJWYCkBrWb+0Z28p/1rQQ6j0R0WDyLlpYjwaX0cBTOkQtA6E5YA
 Z3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sAXI9KUfdDUDhWP7B1nKmtj4xb/BMelYpMd0QbjlSBM=;
 b=SoMMAxhydxrBd5M6p+oQr/jjTA8K9Lo2/asxlrAe0hUDd1IW+HzDhHnN0vOeLKiNOA
 tcq1JndN3jQc0yNfDhpNSflz5eNoHAv/lwBsjRIrk/Pq3sPbnFg9L/wf1yUOQU0rkux3
 lSQLBUMCSSZcSAHU/1XMj8CdwKPyxqcrV50I9U6ZnRmOewVwKDpNcesv0ADTngPdPc/T
 lm5icnzWaQy2+G9GR3h/JvUHxqs3tNMo/rmD4yg8aWCMawfg/n8+FL7dz1pRhiCidd1s
 qtNXAVMo+jFtqbc9fApysS3EEaP383nUTB9Jg14ApEJ8kffYp294jiszkC3HGH9KHGJp
 FFPw==
X-Gm-Message-State: AJcUukdua3MwxU6An47H4xWTi87ekWtU+7Vkb0+ZM/WCfiOefKozEGls
 WgeX+mASsGF8m66QijQLNBM=
X-Google-Smtp-Source: ALg8bN7Fz7+aq6w8K/s4ukB3gYF8YzqWG/pOgvQxWE6lOgsKscCNdev/1KgoCdAPP4uOC2Ddj7PWew==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr842672pgo.369.1546592082509;
 Fri, 04 Jan 2019 00:54:42 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:41 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 3/11] KVM: Add spte's point in the struct kvm_mmu_page
Date: Fri,  4 Jan 2019 16:53:57 +0800
Message-Id: <20190104085405.40356-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005444_176021_73C983FB 
X-CRM114-Status: GOOD (  13.37  )
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

It's necessary to check whether mmu page is last or large page when add
mmu page into flush list. "spte" is needed for such check and so add
spte point in the struct kvm_mmu_page.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu.c              | 5 +++++
 arch/x86/kvm/paging_tmpl.h      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4660ce90de7f..78d2a6714c3b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -332,6 +332,7 @@ struct kvm_mmu_page {
 	int root_count;          /* Currently serving as active root */
 	unsigned int unsync_children;
 	struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
+	u64 *sptep;
 
 	/* The page is obsolete if mmu_valid_gen != kvm->arch.mmu_valid_gen.  */
 	unsigned long mmu_valid_gen;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ce770b446238..068694fa2371 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3160,6 +3160,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 			pseudo_gfn = base_addr >> PAGE_SHIFT;
 			sp = kvm_mmu_get_page(vcpu, pseudo_gfn, iterator.addr,
 					      iterator.level - 1, 1, ACC_ALL);
+			sp->sptep = iterator.sptep;
 
 			link_shadow_page(vcpu, iterator.sptep, sp);
 		}
@@ -3588,6 +3589,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		sp = kvm_mmu_get_page(vcpu, 0, 0,
 				vcpu->arch.mmu->shadow_root_level, 1, ACC_ALL);
 		++sp->root_count;
+		sp->sptep = NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = __pa(sp->spt);
 	} else if (vcpu->arch.mmu->shadow_root_level == PT32E_ROOT_LEVEL) {
@@ -3604,6 +3606,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 					i << 30, PT32_ROOT_LEVEL, 1, ACC_ALL);
 			root = __pa(sp->spt);
 			++sp->root_count;
+			sp->sptep = NULL;
 			spin_unlock(&vcpu->kvm->mmu_lock);
 			vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
@@ -3644,6 +3647,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				vcpu->arch.mmu->shadow_root_level, 0, ACC_ALL);
 		root = __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep = NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = root;
 		return 0;
@@ -3681,6 +3685,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				      0, ACC_ALL);
 		root = __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep = NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 
 		vcpu->arch.mmu->pae_root[i] = root | pm_mask;
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39829bc..833e8855bbc9 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -633,6 +633,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 			table_gfn = gw->table_gfn[it.level - 2];
 			sp = kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
 					      false, access);
+			sp->sptep = it.sptep;
 		}
 
 		/*
@@ -663,6 +664,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 
 		sp = kvm_mmu_get_page(vcpu, direct_gfn, addr, it.level-1,
 				      true, direct_access);
+		sp->sptep = it.sptep;
 		link_shadow_page(vcpu, it.sptep, sp);
 	}
 
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
