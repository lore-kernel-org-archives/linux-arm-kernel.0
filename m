Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED67C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CE92070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GJ28nJdn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVTWaQnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CE92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wneZgIC84FnW/2y/+d162B74vkzDsKM4HLullQQLZWI=; b=GJ28nJdnm6xEjwFEhKHh78wH0O
	6tGmR3/Cj/n0j5OtCphSd8bUuMPrQCloNY+hM99I236P6dnsMzMbDPvyFsZA9xqfcXfuxsI7/eS77
	38ruUVUcAq7bohpuno4FcTQSBmmtLF5r5khtvyFAMM6j3jmNFyj9GsSPyANtLTI+BOE5awfc309KO
	E0jH0m/o7pPBCqO5Cvj0BWmkzibCKgXPaOpSEQuImDrQfH4k/6ggZcCtxc+kLMVh5DT1dok6FiggP
	XUYii1Tk4qNyF39ao/g08zO5xV7K/r/YvWeXoT+84u9Ysh5WaXV1B0xrCkWDVW6TEW7Ft7TXs0pKV
	HVEtZ16g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCQC-000080-Fz; Fri, 22 Feb 2019 15:07:28 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCPv-0008Jt-S2
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:07:16 +0000
Received: by mail-pl1-x641.google.com with SMTP id e5so1228821plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Q0P5XgUhHSeogEE24zx3HNxWmK4nJsBPit2rUo7j0iI=;
 b=VVTWaQnAfH2eioa468QYwi8FCfMVGxfTUkZ1MqTKn4GjsZOFCHMNz49Hi7A6Ca5Lp9
 prEuk2Pk3UMgw+0LuXko8oH4teeiagMaMwpxbrWUKc1M+qc5Jp9VDoYeCSlLGaptlatg
 rWPZ77LiAzAHabZciKq1NuQ795+t/yhYaKJq5kgZHSB1rhI1qUnivpbXq5O7aThbedLC
 eq1WSwTpJri9Z2l5ITc7QB53GZd1R+5h9gSpqBUWC0Hwt0V16EdNsgTgWjLPgJN5K2c7
 Yff0G/aB75brz6zuq0/sI9Dp22FEy4SF12u1enbC3QzY62hltFL5Y88E19PzAMCVNqj+
 wpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Q0P5XgUhHSeogEE24zx3HNxWmK4nJsBPit2rUo7j0iI=;
 b=p/MtyafsFun9f8klhpUG18GkIqbaF51cAB0EGBMecceYZT5K0rURqDqFNm1oRavXdr
 s5UBl8wMFugBVgzi7GVqK22Reh71AO/yXnif3vVVx0eus3gQohKaqgxx2u+eoq1vaEwq
 a1yLrc/oBEqS6qJyrA61q7LAfQ+M2xhqLXJbh84/AudbEHx/Q5Lj4Kg/9AxZQiL79n9H
 JIzKsbqo1gAei6OXW4wMpvs6Nz6ycewCE15QaABZi88mho/x/tbQssM0iS4MzBqc3yh1
 P5SegvIjRatxZ3CB8Gn3eSgzJXU6uNkgWIaSLfXQ/Mh7OqEtYU0P2z3X91rpb1sYd690
 QQsg==
X-Gm-Message-State: AHQUAubHhqRXtyzBU1mr7TeP+abewBfunCCToIBPJGqacDhm7LO49KX2
 kGL1Ts6WsoJe6qmiSjp4ZK8=
X-Google-Smtp-Source: AHgI3IYt1nmRnL4fTVfYPNhScGJwllP9ezkrwos1wRWo49n4OUOin7xMzg9Vx3TPBgs0S4KkcyRnlw==
X-Received: by 2002:a17:902:5a8d:: with SMTP id
 r13mr4655676pli.190.1550848031497; 
 Fri, 22 Feb 2019 07:07:11 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:10 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 2/10] KVM/VMX: Fill range list in
 kvm_fill_hv_flush_list_func()
Date: Fri, 22 Feb 2019 23:06:29 +0800
Message-Id: <20190222150637.2337-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070712_258356_E8D2D91C 
X-CRM114-Status: GOOD (  14.58  )
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

Populate ranges on the flush list into struct hv_guest_mapping_flush_list
when flush list is available in the struct kvm_tlb_range.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
	- Fix calculation of flush pages in the kvm_fill_hv_flush_list_func()
---
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/vmx/vmx.c          | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 875ae7256608..9fc9dd0c92cb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -318,6 +318,12 @@ struct kvm_rmap_head {
 
 struct kvm_mmu_page {
 	struct list_head link;
+
+	/*
+	 * Tlb flush with range list uses struct kvm_mmu_page as list entry
+	 * and all list operations should be under protection of mmu_lock.
+	 */
+	struct hlist_node flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
 	bool mmio_cached;
@@ -441,6 +447,7 @@ struct kvm_mmu {
 struct kvm_tlb_range {
 	u64 start_gfn;
 	u64 pages;
+	struct hlist_head *flush_list;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 77b5379e3655..85139d318490 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -432,9 +432,23 @@ static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush
 		void *data)
 {
 	struct kvm_tlb_range *range = data;
+	struct kvm_mmu_page *sp;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
-			range->pages);
+	if (!range->flush_list) {
+		return hyperv_fill_flush_guest_mapping_list(flush,
+			0, range->start_gfn, range->pages);
+	} else {
+		int offset = 0;
+
+		hlist_for_each_entry(sp, range->flush_list, flush_link) {
+			int pages = KVM_PAGES_PER_HPAGE(sp->role.level + 1);
+
+			offset = hyperv_fill_flush_guest_mapping_list(flush,
+					offset, sp->gfn, pages);
+		}
+
+		return offset;
+	}
 }
 
 static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
