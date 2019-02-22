Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9BEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299E02070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pv7SK7wj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFEDariz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299E02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3fAnoxMTthii5JRisKa+6fhBzsz9SZDb+cE+qTtsbiU=; b=Pv7SK7wjmeCa/TjCrqaHvP9rzU
	oCr8G/d/4YEiCljcorasMerdKLY2IPYfNVYgDfdHAhezEmCEgKsJQ1OacNYKXn1Ew1qnTkm2Mcub9
	sq9J5vPd+qb18gAmiMbupGenNKGzKPZjYVPk+KMwrYOeV8dno7o79q5XfFpEqLAE2+9pbhaANQs3r
	d0s2kG6LPIV2gPLNxgJTreaFnXMEqs6/hwifMQGADwy0BppcMw7dzPdUBlAhCDqOqFCg9hngc3yOB
	NuogiVp1kL1W5qF0n3M7qmXdFkRFrRVeqrzW3D1bEBUM1J4KRL34j25sPY7Zl0vIk8cQCPCB9P0HF
	Yw9KtOUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCQn-0000ew-Pr; Fri, 22 Feb 2019 15:08:05 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCQB-00007o-Ur
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:07:31 +0000
Received: by mail-pg1-x542.google.com with SMTP id h11so1274402pgl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HSIeB4k5ZuogmL6MUD/u+Ar8YyEEuP4vsoidGitcBOo=;
 b=VFEDarizmQAexjrnIXw10DNn/NEU/q3swR8bwAjLeGeWR5tr50z2EvERNhdjvyBtb4
 VqcDze6oJyEG2pknFT+FiETqiVnE0DZHnLwja3h0uY8qOOjM21+Dp6SLpG/BC3cE4h81
 SF/psiWa1QApresuj0e8ND3u+47m/GWHAnUBUNUC7nvhjODQgJkjJ6VL5W9Z5qzpBEql
 aj+3/jBXo1eCh94oYlGSFb8sc69YJn3TYkh/EmPjUsk5AMD6kLLfgTmUnd3sAw1vBVnr
 hJaY7uoZAfxkdaMxF06564Gne0Mr7a2eQI5ZiDFFUQvgZkp3OVmUBVZyCVYSG/kRWDXN
 qDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HSIeB4k5ZuogmL6MUD/u+Ar8YyEEuP4vsoidGitcBOo=;
 b=ASkCImrp/8uuGyBKoslnvhuAIHO4RoJalu42xXS+KTSNqlklBYA1AzCX0gr3R7QPOY
 1cZ2k+mvERg2aqREnmVzk/tS8WxQj8SyOopd60aGkzWY0DS83QhKgVn3gG/e3srzYIAO
 JFTT8Hkzwp8IaYy88aIUOpN34JeyxDyCsFePrQsz7dUa2x+j4kpZw43NaUi0xxvjjbVH
 GHsDbNndZaMazqi+D/v4XMGE91Khih4oZp36PJNBoa/OTuFs4HRVnbZm9Jg1g/GmMvyj
 hwIaQsbhTvfNxsqtk8a0m4dimT6evjMZX+xO2RAoV7cxNlv8YFMO/K/JCG6Q6Hk91dOy
 UgXA==
X-Gm-Message-State: AHQUAuZRiJeIbFRCEZFxjGl29DlufChZhteZBHGNvD10VwdQVvJJ/0S7
 wEcHd8p2yyGsisRFiU21P0o=
X-Google-Smtp-Source: AHgI3IYeKFBy5DfEgi7+NoEfVT1WeWulgurOSdqM73OPfGXKYCvFjRfn6bTV8zsuwtVzgFf4mlVMaQ==
X-Received: by 2002:a63:2ccb:: with SMTP id s194mr4379235pgs.214.1550848047046; 
 Fri, 22 Feb 2019 07:07:27 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:26 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 4/10] KVM/MMU: Use range flush in sync_page()
Date: Fri, 22 Feb 2019 23:06:31 +0800
Message-Id: <20190222150637.2337-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070728_155496_6CC1EE9C 
X-CRM114-Status: GOOD (  12.51  )
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

This patch is to use range flush to flush tlbs of input struct
kvm_mmu_page in the sync_page(). If range flush is not available,
kvm_flush_remote_tlbs_with_address() will call kvm_flush_remote_tlbs().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/paging_tmpl.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39829bc..768c5c64e3f8 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -1033,8 +1033,9 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 					 true, false, host_writable);
 	}
 
-	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+
+	kvm_flush_remote_tlbs_with_address(vcpu->kvm, sp->gfn,
+			KVM_PAGES_PER_HPAGE(sp->role.level + 1));
 
 	return nr_present;
 }
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
