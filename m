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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936F9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:56:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496E8206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fNprD6We";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bERgKUKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496E8206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=aq+h55ljYd8Gd8U8xYYfSGKCu5DbDJXKArbAg2y3wxs=; b=fNprD6WewSpFBJZH2vcQmsD7HW
	Jf5KKMpxnai3+EWP+QBW7+Sdh1GbPyjGwOsMQI+jvwyRAYQrbP28QVzRHh+DGXNTmBkW3Km1V7bzX
	TeyOfg0qrpwxK9V0vNlGSZHdKBTg8ttDBGANlkGT4eFwWUg3FqG6jUqSjjYkTPJcgYmgh0ZUxQuO4
	nDc2oC1BBHpfznVyCzjDuUQvddz7JX9rdwI/+H05juzwO9ryjn7y07P4g08Zzt0oHBvltkecWOfL1
	3tpK4aUQwg/fSYU4iPJutZ1QxMNlbok7K6HhQuXCLZyqLKGCGXyYb/NySQ+69f6sJlnjBHC2ohMEm
	bvhK+fOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLHW-0000mQ-RY; Fri, 04 Jan 2019 08:56:42 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLG4-00078a-Ve
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:55:25 +0000
Received: by mail-pf1-x443.google.com with SMTP id w73so17986251pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3CQvyPlxafLLMYYmnidZXL6MopPPAyOd1R4OKDK3Tg8=;
 b=bERgKUKu51PAzYg3Rrzv52DBjdnCcfNkUuGl0QEWhiWj6W0MmP1KserqG3gw+V0uOz
 717BaRsb17KQy9DlLpRwN73NDF+JlNIwIa6Vtid3Wn7/unsJsMpEWzLVhDoWsO+jPqBK
 CXzhbDQK4O0iY5rU0gimk9NZuMJOLue/IM7psgZOst2rkKV6QjkUQ+xy9R5CHlRtE0yf
 6eYDVGquJEt/gVb0OBEtL7uwYx/NIUXuq7ZJAts2E7VLsvPLZYf9o1OEXSsCvqx1R+Fm
 FOz/j9UPfBj3duCoLjjODwHV5/2+j1i4jVT/zc46j+B8Sqj4H5cNFpIum3Jq9ABDTfbu
 UfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3CQvyPlxafLLMYYmnidZXL6MopPPAyOd1R4OKDK3Tg8=;
 b=gJfRqQukH73dQoJu2fK+li0hE/1N+xSEXjtz/df2Rk4dh3ChJgrp7t51dYOzyv1Uxk
 Z1SE2PaKYE1knIiGh2ESMg3zrlX54bbT2Q//hjaygQqxHSZuEUv8nDJGcY/vutbZ1kBU
 RNQP7y7A7jjGDycVUTcAJi8laQjXHGkRwwOZ00RIa7jUCyXvLbY2/0UkNC+IBa5feYfJ
 QENQFFF0vxl62QiBmOYx9wcDsU+YFYZ2byZ+EGGnpkzgGOZVEzOmRgzrt0lz/XM9cdnt
 iSgg0uG6xWPLjIEYzqx2x2d28qBRw5AY79mcTnck8J3goBAAjDAh/jbpgc/U8LRCFIzj
 j5Qg==
X-Gm-Message-State: AJcUukfZkbd1a6kTYgsl//Iv9NsvS93O5D1S0hRPhyAQUHb/3/qz7hTk
 +WxFMF0ZbOoJOEk95Smf3Gw=
X-Google-Smtp-Source: ALg8bN52JNWJUY4wd3KWz56nhScCreos1hBMy4NTN0TRzwOHpvOyEaRyBz6+s+XGkePV/idoh2nHEQ==
X-Received: by 2002:a63:557:: with SMTP id 84mr19472589pgf.411.1546592112418; 
 Fri, 04 Jan 2019 00:55:12 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:55:11 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 7/11] KVM: Remove redundant check in the
 kvm_get_dirty_log_protect()
Date: Fri,  4 Jan 2019 16:54:01 +0800
Message-Id: <20190104085405.40356-8-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005513_283010_7B7935F9 
X-CRM114-Status: GOOD (  12.03  )
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

The dirty bits have already been checked in the previous check of
"dirty_bitmap" and mask must be non-zero value at this point.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 virt/kvm/kvm_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf7cc0554094..e75dbb15fd09 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1206,11 +1206,9 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			mask = xchg(&dirty_bitmap[i], 0);
 			dirty_bitmap_buffer[i] = mask;
 
-			if (mask) {
-				offset = i * BITS_PER_LONG;
-				kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-									offset, mask);
-			}
+			offset = i * BITS_PER_LONG;
+			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
+								offset, mask);
 		}
 		spin_unlock(&kvm->mmu_lock);
 	}
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
