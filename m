Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE2C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:40:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3852D2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cCpT1AZC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcBSvhg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3852D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BqHBXDuB3JlBSLFwvgpALBievshGnIcQxP18hRt2erk=; b=cCpT1AZCcPrVSR1EO7CMlgLU5j
	kI/GMX6c0vgmCriV3AQv3Rsp5bACIRUPLjou2pcr9BcSk7bRmBzTiYSYjyFvBu5BCbBDDuHBHsOmu
	CVLrt0USihYFLR/x0Ngaw6jpGY3/kadfJ+ZQ/NCj+eqZq0hceU5j0nvLcVou7hOov5dmfl4Z/sr9y
	/mrRPa/32cuHk58Gh0aX6AFhM8sIt3cE4YBaB9rIdUgtK/+rZARoHJD1t8Dx5ZhKK1PQMtgnfvirf
	/bpN84uXaUBsVbMbCS3sRu/XodYbhPnsge49K61/1PlxozbJCwZHHKTFpOyCN2oIvSqNYEJ/j48E0
	25kDzJVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpkIH-0006BR-6s; Sat, 02 Feb 2019 01:40:29 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpkHF-00041n-Oj
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 01:39:59 +0000
Received: by mail-pf1-x442.google.com with SMTP id c73so4070878pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 17:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rByqLCOGvQ8nC7iVvwCr6DlPApr36fgfZWbbNDw3cPc=;
 b=JcBSvhg6DtXatbgMnyQPHGvUT0KXMV+vsEQvkE+bwnES3r8FwaD6AuXKWbGneMDz3s
 aEP9gz3gTzw9afwA1Vn2/whKrqSfJnjlvkxH/60fVrq78G65y2YhzxhMqoSMw/VRwiZC
 dgP1qtfqZasGPDUNv4b3GGuTWfjRYD5EqS8hLpq/97GVas2CizzxVgexa58vT7e4WITd
 azMgVpqULEKmZfeGFvw+m2BQka6NAtIoGdwOu76ZznsaS+VBDxpRT71E0Mc1h19Q5OlU
 d1sJPU2mHk8QHI42wWDvTqlVz6u7A3UgRLvity26FGTvlrRKwNuldw6wMGzlTElyz/zh
 iOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rByqLCOGvQ8nC7iVvwCr6DlPApr36fgfZWbbNDw3cPc=;
 b=BVSoCvjfLmiwq1ZjRHM4wULFQYpyvDZMKhExjMoym9g46k72w5u3Nzf2OH5rn/BdsM
 YyhJV5Ok0mxQPax4Yt/E7Es5rvMgoDvRUlNrjLlneefSF2PNjv/RmGxZIRCUnWKq9vXT
 mbjG7PQXynvMBkEc1OxL43iIydZNT+tCwyp4JTOQ6fTL/FOoJbtyTrolEYYdt047++v1
 UxV5Sz/ldSLC3y2HxmPWStU6nArf9ehD2NLmNF/L7Mh+c3fmjBzdpFHBsEn72ZOGzFbn
 zYXnoPtq/QhdM7RKvBGHZKui78Tve4BnbeR3x7hmPnBToPjVuFZpifB5JSR8+WUNQEBD
 /6Zw==
X-Gm-Message-State: AHQUAuZpsqQMYnw1e6tHJfvetih0f25zTE8M8EI0Hhq4JcTF65+BUWUH
 2dzeX2lyCictvE7q8DAEwBI=
X-Google-Smtp-Source: AHgI3IY4pbsGdSsiplWwzuSajzIs74vE3bWXmAl9AhEm/chKi5rYt5/pCLZhODFUahdG52LiNoncsw==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr4247053pgo.369.1549071565234;
 Fri, 01 Feb 2019 17:39:25 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:24 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 5/10] KVM/MMU: Flush tlb with range list in sync_page()
Date: Sat,  2 Feb 2019 09:38:21 +0800
Message-Id: <20190202013825.51261-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_173926_449879_49408258 
X-CRM114-Status: GOOD (  13.83  )
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

This patch is to flush tlb via flush list function. Put
page into flush list when return value of set_spte()
includes flag SET_SPTE_NEED_REMOTE_TLB_FLUSH. kvm_flush_remote_
tlbs_with_list() checks whether the flush list is empty
or not. It also checks whether range tlb flush is available
and go back to tradiion flush if not.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Use check of list_empty in the kvm_flush_remote_tlbs_with_list()
       to determine flush or not instead of checking set_spte_ret.
 
arch/x86/kvm/paging_tmpl.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39829bc..d84486e75345 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -970,7 +970,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	int i, nr_present = 0;
 	bool host_writable;
 	gpa_t first_pte_gpa;
-	int set_spte_ret = 0;
+	HLIST_HEAD(flush_list);
 
 	/* direct kvm_mmu_page can not be unsync. */
 	BUG_ON(sp->role.direct);
@@ -978,6 +978,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
+		int set_spte_ret = 0;
 		unsigned pte_access;
 		pt_element_t gpte;
 		gpa_t pte_gpa;
@@ -1027,14 +1028,20 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 
 		host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
 
-		set_spte_ret |= set_spte(vcpu, &sp->spt[i],
+		set_spte_ret = set_spte(vcpu, &sp->spt[i],
 					 pte_access, PT_PAGE_TABLE_LEVEL,
 					 gfn, spte_to_pfn(sp->spt[i]),
 					 true, false, host_writable);
+
+		if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH) {
+			struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
+					& PT64_BASE_ADDR_MASK);
+			hlist_add_head(&leaf_sp->flush_link, &flush_list);
+		}
+
 	}
 
-	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+	kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
 
 	return nr_present;
 }
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
