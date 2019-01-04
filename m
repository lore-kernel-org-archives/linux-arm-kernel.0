Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE682C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:56:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC4A21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aq04nka5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW2Ji7XB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC4A21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3f60fUsf/Ijf8zO3nfEp5o49BEVbpiCF8kpo6doKIVc=; b=aq04nka5AxX6KyX0yzGSoLYVmY
	5q86G/SeyH52VPLYpmPPwusPDkO2KKS2RF6sk+3Ilu7XVaLPYqRPzc9DFF0vFLAqHdu3nK/zRWT71
	nZzZrt8jwKA2EfiLGkf17hVrMjPZ/HaCTUDesGdGI4+3YEsw/DcwGTzEACh1cKC8ZG4NkspgbhSVL
	mUkpFR0FXb0oN1DWqEouK5z7JTlIbdTJw3TK0IwQXzgLS3cBmSCtPLESujKCHJp4HeIcxr0CtwntT
	leZrIlMHH+RO/yr1wXsZ3CrW9v5rP+3mikwkBwMAArtnEECf0ohYe8BSYAqzmwGPB/1HOtoRC/jQm
	+1rqaN/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLGt-0000C7-C0; Fri, 04 Jan 2019 08:56:03 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLFq-0006UD-7Z
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:55:15 +0000
Received: by mail-pg1-x541.google.com with SMTP id y4so17213531pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lVVdEslgom8hND2ea3FWWDCI/x9Q6uJ8jZfIIsF2DSM=;
 b=OW2Ji7XBSYB1+gGPVjstYoLKPTzQ1AmfMKSKOstz5QdPudY86VQ380UUUsnf/zGmVM
 xn6Mh0pYG3xrcy20WnDqchjHf0s2vor5WP0jYSxpDbJWJjbYB3QmqZJ0fwIHRl8AAQNK
 lxbecV+o95hItU6JP7PaPD8X3TJPHKx2mAM6ZTHdq6sV5V9Krp4xs8TdoVqrAT8V0Xt9
 X9+ykYR1/2wD4+G1Z4KIV0Ml1JTrhu5uudJqftY/TkXmydDiAMUHPf4qFOrUwiy9y1Gm
 C8XClO7UzUvFQDxjE0HxdBZXHppJjVWt0tiZIPFJ3583Ah2FqOq6EH1oP+MPBMLn9PvU
 zBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lVVdEslgom8hND2ea3FWWDCI/x9Q6uJ8jZfIIsF2DSM=;
 b=iGU80oWWy7/DLEAMYVMBbS9Ojdr6FIvigPWajwxxRgyT3+AZHXBXt8Zuf3KP8OyopU
 0QPG0cjeM4clyYjjSx3dvldS0MNzAE0MJuMkDwe0ZzY32Wr3AqRSC21wPWNP+X4nBrvk
 cJ9E4s8ieQW4FIzsLwc2ToVqrC/Q7OgNRdBt2FR6zIro5eTXFRXKPlwC2CFFdmrt+DpB
 flF0i8sgKC0GT61r1f1aFyTLT2TAFviSafrVUX82okKZZnbCoiy5Z9S7A9t6LgzqbTaD
 W6C3LbiB3biUnkYRSwS9k6InbHb0Rt3O8q2gTe8FoQmUXNrB/Ph3q8xPSnrcklPCo6aM
 DpXw==
X-Gm-Message-State: AA+aEWZLUC4nVh7qtnDA7k0N62AMROt/4f2BWh6ADbWH/yNIXlWtbAdq
 Kfk2ZnbFkxA51RxPY3r8wo4=
X-Google-Smtp-Source: ALg8bN6Kuw2ITWSZOeeG0JAVP4GO5UzPiaRW5tnwjEiTZXlCq7w6q2DQ3Tfsj+QkVgS7pj1Cmr9+qg==
X-Received: by 2002:a62:56c7:: with SMTP id h68mr53695204pfj.134.1546592097417; 
 Fri, 04 Jan 2019 00:54:57 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:56 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 5/11] KVM/MMU: Flush tlb directly in the
 kvm_mmu_slot_gfn_write_protect()
Date: Fri,  4 Jan 2019 16:53:59 +0800
Message-Id: <20190104085405.40356-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005458_522184_7FE93C77 
X-CRM114-Status: GOOD (  10.67  )
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
index d3272c5066ea..6d4f7dfeaa57 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1715,6 +1715,11 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
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
