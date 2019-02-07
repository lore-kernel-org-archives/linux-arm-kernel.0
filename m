Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0155C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:20:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBBE2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gdTjCe3A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lZ6JcGj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBBE2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UwDUoWVyKySoQgm6WY4hGjpLX4qNmOWacCDiE7LeSH0=; b=gdTjCe3Ao+C1SB
	p0MhRL2PaeuIZK4ZAs+X2dgyEPLq9AhMYTxByrlS/ue/M51YtkVN/FHPpwiyDU9dUirvR2jMEba0+
	24uabRT1EfhOzte3CSxozG3y+bFCodNbo1sfCP0XiBEOCUzcIj2L4ps3vfuZTILEw+rfB9xTuIP8r
	EmD5Gy4RCSC51Yb0jMlVHWVk4E4JerB336VDAWJJ8E6I+ogKeDTu4N6hpvgpTSWXV9g+OSa+4p2Jq
	HeZI2p85KseeGxIABd/KwGIohWWIzBCVSwYlbcswup5zTuK1H46kD2tq5omEvnNs33BfOPU0B5OjY
	PSSE/vJ8shab4r669jmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjbh-0004sR-Pu; Thu, 07 Feb 2019 13:20:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjaV-0002Yi-7X
 for linux-arm-kernel@bombadil.infradead.org; Thu, 07 Feb 2019 13:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E9gmLFAIZpQhdBCkjBeHg/fm5KlvZmFnqrfp12eQrQc=; b=lZ6JcGj0UjzlgJrVO3WtZq2sIP
 8GCMzSujooDy/KibL0O3iHETEI0n5FrlvXMyd2DS3Q4eiQIw8XcVpN1b3uRHnfn7Fs9U/RI1N3gep
 1suyx3CkByiuRlkKd1ESoyCOTOUS9HnG/lKWwzXnkIOeoB7Vm1Ni/5PKgi0RYuFzc0iA/FigTb0qz
 yiT90OefMfErN0TM7+4EJy/KZgbhwrGuMZdlDxFrmTPc0m4LHZr3PMUxcaK5z3XlfadoWegD2iFZi
 +1RAhlqGAhmkaadAKvCuVNnjle66CF0ygVqXghwP2iute0hC45ujgH+umLhA50By4FA57Gp5l65qK
 E4IZOG0g==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjaS-0004iS-C1
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:19:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 195C31682;
 Thu,  7 Feb 2019 05:19:23 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D715D3F675;
 Thu,  7 Feb 2019 05:19:20 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 10/11] KVM: arm64: Relax the restriction on using stage2 PUD
 huge mapping
Date: Thu,  7 Feb 2019 13:18:42 +0000
Message-Id: <20190207131843.157210-11-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207131843.157210-1-marc.zyngier@arm.com>
References: <20190207131843.157210-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_081928_496258_D228FDEE 
X-CRM114-Status: GOOD (  14.34  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We restrict mapping the PUD huge pages in stage2 to only when the
stage2 has 4 level page table, leaving the feature unused with
the default IPA size. But we could use it even with a 3
level page table, i.e, when the PUD level is folded into PGD,
just like the stage1. Relax the condition to allow using the
PUD huge page mappings at stage2 when it is possible.

Cc: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index fbdf3ac2f001..30251e288629 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1695,11 +1695,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	vma_pagesize = vma_kernel_pagesize(vma);
 	/*
-	 * PUD level may not exist for a VM but PMD is guaranteed to
-	 * exist.
+	 * The stage2 has a minimum of 2 level table (For arm64 see
+	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
+	 * use PMD_SIZE huge mappings (even when the PMD is folded into PGD).
+	 * As for PUD huge maps, we must make sure that we have at least
+	 * 3 levels, i.e, PMD is not folded.
 	 */
 	if ((vma_pagesize == PMD_SIZE ||
-	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pud(kvm))) &&
+	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
 	    !force_pte) {
 		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
 	}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
