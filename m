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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02396C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C6B2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IFXY5IEi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo2D+LA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C6B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=eV44gW/vqxd1VC/HVqcGR5Y6gAFRdCHfupmcQC7Iulo=; b=IFXY5IEiEVLnJ9aUSbRCHHm682
	Df2ZnOOGqfpI7+E2HjS/na2SP6EV4Y0QrqlCyA9kKY2yVp6wbEcz3mvbyOH49Q3Qn5roJL/atiLyl
	XJoVStTe9kaQEcMR+LbsREiSWsUWsvfQBh+gKM2EQlnjafT/O/b6CmRtBeo5n4GGggBV6AqWVmCWq
	L4W6e44hmKfhjPX8GeIwwric7LpPrUQUD4XkvbaPJxVmQzIep/P0XyIBAZvUWFgtHHD0gougmPoFd
	ZTe+twPORKbwQ4/VeYXzfx3HOJoqFx2cuY6f6CVuER5flnvVzYLv5RiPTyqEOj0iYj9jMis7GbjuO
	DIwXqFcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpkH8-0003rf-6A; Sat, 02 Feb 2019 01:39:18 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpkGs-0003b3-GJ
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 01:39:08 +0000
Received: by mail-pg1-x541.google.com with SMTP id g189so3760023pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 17:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xNQ01b3YQcncQcyZ7/8o/Bl5YsleBiAszwwH1EpMGyk=;
 b=Qo2D+LA2DH0Xd98ZgKOyGosKOaLUNvRcl8albFhAHWIgW4SuiFPDTPXliCZhxwU9lo
 KuuHRNm0DC2NEuc+wOFl8VdvU8buZBjimk+zdX1acGwI0ZOAf1OgyamVONKBCjgRenKp
 GxbK6DvdmvX4NKNFXt2+kraiR1ZDN4arbq3lKp/4zhu+A2145+lTvVbUti6VrRcOGkoV
 a4QDX0M3aYO8xuOOntVq9CTNfb+ooOC9th262XOMJZlEEjaJSWChR0+LEBoFacmJsJxV
 tGoUdzOf2NlbeOOo8kF7j5yZgsQg6E/LAjE4U2dpcaLJgFYeA3umIkUnyJFgteWFffI2
 Rlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xNQ01b3YQcncQcyZ7/8o/Bl5YsleBiAszwwH1EpMGyk=;
 b=Sdkc3vAQLSH0B5yN5wR0q5STiGoznKJXF3kztbizr7oUykWUVreDpXJf+jqvNY9gJO
 AJ77t7mkSNXi7k1Ta5xzbspoTZBTiEm+9v0FvTcAUU0Pxtuxlr3Eh+LqEgnoyfJS4iZA
 aarS8I0e/YUT83+OGGy2CQtyp2gFCY3dH8jYUvICpMpq3Ctsot22GpcI4ks2Kh6xSuR5
 3kGh4pujadVWqz0yPW23G30C7hCVOfuUJ2YEEw4sWYLeUMMrql3zRvsE+Yx3+8ujBYi1
 WDlrHyExOscrUWZr3w2LGsqeojydv9napgIDpUz++dusWQ4nNQQJ55nPxyuTGWUhaaeH
 YLdw==
X-Gm-Message-State: AJcUukemeayfQNnHQIqnayO7JFyzqm3GQnKq9d4VwhTNzXmGaRr1eVP5
 DDqXwLhtfIz6cilfKSXwPNA=
X-Google-Smtp-Source: ALg8bN52qHZIAftboT3KzOVgAevCJ9IrwTwxVL8yULXyNRr/rVn5RkQZ3gqqqU8ZvuoQTn18Iq1NIQ==
X-Received: by 2002:a62:1e87:: with SMTP id
 e129mr41458755pfe.221.1549071542091; 
 Fri, 01 Feb 2019 17:39:02 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.38.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:01 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 2/10] KVM/VMX: Fill range list in
 kvm_fill_hv_flush_list_func()
Date: Sat,  2 Feb 2019 09:38:18 +0800
Message-Id: <20190202013825.51261-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_173903_092959_06F86606 
X-CRM114-Status: GOOD (  14.68  )
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
Change since v1:
       Make flush list as a "hlist" instead of a "list" in order to 
       keep struct kvm_mmu_page size.

arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/vmx/vmx.c          | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 49f449f56434..4a3d3e58fe0a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -317,6 +317,12 @@ struct kvm_rmap_head {
 
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
 
@@ -443,6 +449,7 @@ struct kvm_mmu {
 struct kvm_tlb_range {
 	u64 start_gfn;
 	u64 pages;
+	struct hlist_head *flush_list;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9d954b4adce3..6452d0efd2cc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -427,9 +427,23 @@ int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
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
+			int pages = KVM_PAGES_PER_HPAGE(sp->role.level);
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
