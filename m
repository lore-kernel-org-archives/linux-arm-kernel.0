Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACA9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A94D20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eJnQwy9F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLHIycFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A94D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XSUYOr8gHzqXLExM8TEunlSqppibXRATIY0Z+HV9SHY=; b=eJnQwy9FgYD0jJaUDoTvfOJN4G
	7xCiyWrjVXrit4Qn+TzkBhVfu4gkO00s5+6mNNAhjSzcg/0N9fF05WTNzGX9sski4c3Y+kD1+tPrh
	LDvNK6XKoRfX4FvuWxwjx7iYfdeQZvWmvlnYvV0BCFUqYTRBv1ca2pRBrFhYoq73Gkc/qkFYjSvyM
	oBUNZak0N2Q6+FIn+PbbA4lzucRmSOxIDzLxx2A4vIK/diRp2p1RoB8yuTnjOqpZ3vWZgnNdRQJdM
	tBITUQ629X9kAKru664CYUWZatEQNKwKhvaiC4y1PygJSc3p1iIpxrnkkKx1g+SBsR1Gp28JFM5ac
	HAsncZ2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtbF-0002bh-CN; Thu, 06 Dec 2018 13:21:53 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtb7-0002Qp-3l
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:21:48 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so141143pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yl5M/YR6xjWoRgtWFGXbuS2VcfNF+kKFSMttnjzt4tA=;
 b=WLHIycFYaXQ0FyPdeQRQYs8WC6bRrqlmuBnn6QQ5Su48WMNqzCTGkVaprlW0Q2x/bR
 UTsOxyI7d2K6WaP40kFHCNbt34I9aSTgcPkW/UOAWKkTj+Yf4RP3ggqyJY5zjH2QJLo6
 CRe6IcNHI7A2foaAs4cDYedVKh+LVY9grpe2ZRjRNAO9muRrWJ4xg+bJ8rIFaVGMHU4G
 sBb3UAAH7MIql9s0cdbCgYuTZUaFHJwULgDmpVjYWOZ0NM+cKXTZa0QIaA9SJsdRKxA+
 7L+uQ8nxkQ4T70pnsws420LQGf2DRAWlBWVTwdT8YRngx6/RzjUYw3zCZ1TWxnr19JrP
 XcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yl5M/YR6xjWoRgtWFGXbuS2VcfNF+kKFSMttnjzt4tA=;
 b=ooLi3+2AW6vltFRzjarV5RgsWue4WskLtjBEtCwl0xFuMu+EmOL4w8KV8YAMP/6ZcH
 8kbuQ979y3A89tviVEHQFkz7k1PcMrAcTB4gofPIriw5RbuleMdYlT7jjZFEvgRMArcO
 y8F72MbEAmjKtClEkYMnU0UI4p3FhhzcpAuwNPm4EKpwe8jf35RMyxKotj7dPf4dS12D
 yyHSmJoc4EaTs1W151PiEgV+BlemZifDoMF/Mu+2PUVqPSaJn5GidE9NMLtfyjCuISlE
 n+bSOZzR368SiZtgURO2CFoCOle2zvQ360g8IoIeG+lZQoOaWZKlFTS8QrzsabzGksQp
 4iLw==
X-Gm-Message-State: AA+aEWZGsQ+k2bYYETSUKP5mfJInE0q5zIkREkKd8kaWbn6jBcVszM7u
 KqgChvZWg04nl2/uZiEDTiQ=
X-Google-Smtp-Source: AFSGD/Vad2NHYMuKRk3TpLn/tHk7cqeYYELuO43hDvsNWnBZeImb5HMnRC3+z6OQuE1c3wZTRRDOFA==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr29644460pfg.183.1544102494752; 
 Thu, 06 Dec 2018 05:21:34 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:21:34 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 1/10] KVM: Add tlb_remote_flush_with_range callback
 in kvm_x86_ops
Date: Thu,  6 Dec 2018 21:21:04 +0800
Message-Id: <20181206132113.2691-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_052145_561921_019B0DC8 
X-CRM114-Status: GOOD (  11.33  )
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 paulus@ozlabs.org, hpa@zytor.com, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com, mpe@ellerman.id.au,
 x86@kernel.org, linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 mingo@redhat.com, benh@kernel.crashing.org, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 devel@linuxdriverproject.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Add flush range call back in the kvm_x86_ops and platform can use it
to register its associated function. The parameter "kvm_tlb_range"
accepts a single range and flush list which contains a list of ranges.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Change "end_gfn" to "pages" to aviod confusion as to whether
"end_gfn" is inclusive or exlusive.
---
 arch/x86/include/asm/kvm_host.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fbda5a917c5b..fc7513ecfc13 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,6 +439,11 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
 
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+};
+
 enum pmc_type {
 	KVM_PMC_GP = 0,
 	KVM_PMC_FIXED,
@@ -1042,6 +1047,8 @@ struct kvm_x86_ops {
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 	int  (*tlb_remote_flush)(struct kvm *kvm);
+	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
+			struct kvm_tlb_range *range);
 
 	/*
 	 * Flush any TLB entries associated with the given GVA.
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
