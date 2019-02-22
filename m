Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FF72070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sndb+bav";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESb80kNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FF72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XmNASWLcKzmd5LRzD8X+qLdfHTr6ylAPzkxCF7e889I=; b=Sndb+bavxxg8NDTZrOIUc6d/ZJ
	ORE0kZaNdp8MyTJqGvUHMO41zkISDIY2AfPzK9SupEgkyS2k0ldydQ1wJDBftdA3PJ757Pr6ae0lO
	k38d8eERKA5hxGanl8fJk4f6+gyLb0WymQwDR2LfURbvVnOmsbab0Wy2DWE0Os/9AmeuiLGKfcfm7
	2Z6fDqg/As7PPkAVb/zDDFP+hS+VK4lKgjBw0lQ6oP/mfUrSt1W16qs4sf94SZLy9LnfNGbcgkU1P
	lD/Ay+Qf8OBsESRJgn1pL/GwglNcle5lgjxIwrFs4XJdCcUqC1xrclhGh7w44tnckCi+JyhKfe/sS
	FlmDI+1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCQy-0000pK-F0; Fri, 22 Feb 2019 15:08:16 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCQJ-0000Fx-7z
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:07:39 +0000
Received: by mail-pg1-x542.google.com with SMTP id s198so1268359pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YM3seOtHGatq4lqSEDt4Wr16opyBlW43DUEP6U3tUmw=;
 b=ESb80kNiQ9yog25hPeo9L5hKj8CkvoWsClwvZnFApBr+huWEHDWQTXqNuizJjyoiLZ
 CiXdav6OWZyQC9tqLSnqze0GiMae/oOAqV9Ud+Bd0ydew6/OsD/5XGOh4zoWPCGpyzum
 RvRhzwTNo7shXmgxFxA0oErxpGAnGACXRAIV2H/5+tE9/MOPelqqfgFQgoPkHrPGJcva
 OFNYA0CbwxPF4AS95pELF6Np+sXag6o6tqlsTWOYsfVykohWQxclNwxjcwzsbz78YRtX
 ArQsaIhAhxE+H3rU76V/GO1lQSdXD6+ZWGqrTKkUG1aU8t+bF50qLOCpSMN2Xyqn7kh1
 JrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YM3seOtHGatq4lqSEDt4Wr16opyBlW43DUEP6U3tUmw=;
 b=eFzursYqVuU9ba3Y6Yq14ZJwmlht8cK4p8Qwr641EOhklzNlPqoD6YIpoqIDroN0mu
 hDBLpssoj3/nXKbMDnHYERPe1hbfOaG7lTz3Y66DKqcG3UzS6Toded+1m1UEj5PgcHr8
 FQOUKvpL0vLpWuNXbv2PY7bRAyaBt/3dGn9ErO5neAikp8RlvwiYayqS32/8ryH/g1cn
 Rz9a1fu8CF/AX6TXeBzvzf6wdvdkNnSRAdpozysUYE9xv8Pn0wW5philgAaROTtSjmV4
 1Q0vuvW3QSOqFli0qikE8UhJNw9dY5rTK6+6Bb0U2vRigC9AJYmxQwAr+WPNLrugT5qL
 jbuA==
X-Gm-Message-State: AHQUAuazO13HOBxGD8S1gDQGYDaVP6cntM/Aig35OE/sadEsTxASHwbf
 DBY7lwrC+Q+LpPmG5Ky7hBU=
X-Google-Smtp-Source: AHgI3IZ4Yi0roB+29f2OCEvwvH3n/OYYmCvsm0Fts14g6RKRhp0fOWP4XzYAgutWF3KiQlBf5I9nbw==
X-Received: by 2002:a62:48c1:: with SMTP id q62mr4660304pfi.113.1550848054699; 
 Fri, 22 Feb 2019 07:07:34 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:33 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 5/10] KVM/MMU: Flush tlb directly in the
 kvm_mmu_slot_gfn_write_protect()
Date: Fri, 22 Feb 2019 23:06:32 +0800
Message-Id: <20190222150637.2337-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070736_539002_0B04EF95 
X-CRM114-Status: GOOD (  10.74  )
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

This patch is to flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 7a862c56b954..60b1771e400e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1729,6 +1729,11 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
 	}
 
+	if (write_protected && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		write_protected = false;
+	}
+
 	return write_protected;
 }
 
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
