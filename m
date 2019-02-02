Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29EDC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786BA2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AXJ8OLFc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKl4t9Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786BA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OqMS8ORDM1zjjVAJrxI8WZnrOS8Vh0CU3TAJC+XYGVI=; b=AXJ8OLFcTUNKk3URsydlPLCx1F
	riSGx8MBEN9r4wtAsAN9AwFX/eJDWY4Ba4varKuAF5Lrl4fLQ/XrmZo89/FdBdbJqPeAQ5If4fZHk
	oHJgHNli/dSi5RGOjulpyFAtfE9APZfuEG0/n5NauaNfXy7pvtoJewcR0U3tXIUMwHbZJcJ7Yt4fU
	lP7inKXPPNbEryYCPpmFP3X4pPgWFNiSzcPzM4mupCcGP6to8z9q6CVAUK65gwzdztn948MgYKVRC
	FxhbHKJek8cUW1lGqF/WwCx9d2cMPd41tq/olJZHS+F+ARF3GFIpH63mhtynxsprjtm1jidg60OJI
	rRHWdrsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpkHN-00048h-US; Sat, 02 Feb 2019 01:39:33 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpkH0-0003kQ-IJ
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 01:39:19 +0000
Received: by mail-pg1-x543.google.com with SMTP id n2so3760757pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QkCKWdNQDd7n0mb8dlG6t1culFOMAQghK/Ej0OwX5M0=;
 b=JKl4t9SsRWFQRqm/2ykkdDbszCjiZIyL9GEDu1emOACGiirfjKR4PU2Y1yFEaeqHLe
 4Gg4rW7yrPMnpiI0rSIwiM8z2uBBUK/Ol8t+l1N1VxwoceQdtJBxJeNkd4oXCXGX81Ln
 /mA+Fi7RDYkiSi5AJlTWoN2SUEgpHbUuXQrcQbSmKlwxk2aHCImQkJLlezWkOovxwH/r
 pdVkbF/4t7THhVIvbGyuKG1ZlsttuJYikvG2qecvpaGfUuC9O3QNWZVxRbeg1svaAD8C
 EQJQrmp2Uw8Htj/sc9HDeAQO0XwYAHiepwQfXGOUnd4F6iyTf9QGL+LEgTPPwhG6DHWC
 qGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QkCKWdNQDd7n0mb8dlG6t1culFOMAQghK/Ej0OwX5M0=;
 b=pEQokPQBFzeXZrTIdbIHqJUuVsu0WMuXSvK9DbcrsGTllIF4qHcjLBqZU13KWzq3h0
 bevD571HLl5KrEW9k8H+1oOcEE7Ei/s7kSaT321FEuO29yZPIG5VVKZalPys40pPui4t
 5pcVfvCwAKaSTdyBOs3uk4Nyf/0OO9TB2TBZCXP2fTHsOqSUluVHvQj74CFJstIJQtDM
 TXuRFsleYrZpqwHz95nt3MfX1dXYCGuGSEGEe6G0UDubN2y14GOnNudJvjKWiwbBp/hc
 38J5LsxD+cXPJs55RuxjoeKtdFFR+zp6/a/DkHfzxYZrplPY+UcHtgwI8/Jebjju3sg4
 JNzw==
X-Gm-Message-State: AHQUAuYsOpjqxBWvedPl3f1Vfvn8CdYHjeR+yjSQjJi6HXYJrVLnQeys
 5B0Dyah0+3AK+NSLBbUT0iE=
X-Google-Smtp-Source: AHgI3IYtiYj+YWXlKinAagZU+CzzWQGsIguvJwkSw/9h/aC/bdhFYr+TlIVLI3IuHned8yzL8VgVKw==
X-Received: by 2002:a65:6542:: with SMTP id a2mr4544721pgw.389.1549071549793; 
 Fri, 01 Feb 2019 17:39:09 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:09 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 3/10] KVM/MMU: Add last_level in the struct mmu_spte_page
Date: Sat,  2 Feb 2019 09:38:19 +0800
Message-Id: <20190202013825.51261-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_173911_187740_96A8D5CD 
X-CRM114-Status: GOOD (  12.11  )
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

This patch is to add last_level in the struct kvm_mmu_page. When build
flush tlb range list, last_level will be used to identify whehter the
page should be added into list.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4a3d3e58fe0a..9d858d68c17a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -325,6 +325,7 @@ struct kvm_mmu_page {
 	struct hlist_node flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
+	bool last_level;
 
 	/*
 	 * The following two entries are used to key the shadow page in the
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ce770b446238..70cafd3f95ab 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2918,6 +2918,9 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 
 	if (level > PT_PAGE_TABLE_LEVEL)
 		spte |= PT_PAGE_SIZE_MASK;
+
+	sp->last_level = is_last_spte(spte, level);
+
 	if (tdp_enabled)
 		spte |= kvm_x86_ops->get_mt_mask(vcpu, gfn,
 			kvm_is_mmio_pfn(pfn));
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
