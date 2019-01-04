Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004FE206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z4eZ5vri";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfoGxhg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004FE206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HlOpqr8s7wkln49xC87+s76BwtXtEmFwZ9y3lFOhKx0=; b=Z4eZ5vripDnIqHwU1QLgnfrqU4
	MpPBwDRW2BObC4ITWOCT3h8lrn7246+apKMWwTbgFynqNEJjHUjkTmjdbKyWdqHeU56m/rGmyfTH5
	2XjMKTfmC526STd5/1EMFkR7qjIBMWR+z5Pgd5HiOCtD1G+ykBj5vAj2YgxQMS8ZaxnaYQ6Z9dYvq
	2cyRZEnHROoWeW1lxAZ71uuxsPyLWGenh/sBiMhfl6oY3aLbecyLeSzI0WHywGTHiYDjeefMJcEvF
	ImrJchQnUu5Rl41AXxz2C5V52DYTHjneLO8W9Ix3RHvX9YivVQFwAJrbPIDqwTm/fg62BHulKMZP6
	rfnWNRbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLFq-0006TY-QM; Fri, 04 Jan 2019 08:54:58 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLFT-00065l-6s
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:54:38 +0000
Received: by mail-pl1-x643.google.com with SMTP id t13so17144617ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3xvjZ/wjhJvQ+EiSQdkuRkphovQlZ1pkKAij+DudaK0=;
 b=UfoGxhg+Hd437kHWcocOKD4R7AEnDRlzv3+9E9HJw9uGV7/pvCZrMR6ZoCK0BaqvmA
 77Mu3LTWe655ERI5Dx3fl4LFYedAvptTqCeFZZV9fkMKJGpW12xQcbXlTMWvnlaPeKtD
 1+xxgO+uhbCznYh4qlV1zGwrCM9GFUEipbnIkCZPi04bRrGL2ONf/Z9HO1fHrvkWEmJ0
 FD46PfpqMUag74dDDGZGWKMOsdJlPqLQM/KOrNyNNZjhHBQPqSwWFxJirOueeWMCLZn/
 xbs/7qlpNmF0vIj9CJjAubmh84omLHTWBxD1AhGu4ws7s4c0KGWR/JFEk5A2OpbMg3oa
 x9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3xvjZ/wjhJvQ+EiSQdkuRkphovQlZ1pkKAij+DudaK0=;
 b=I7V/2t0cEe5v6YZylZNDkTEzZrwT4WtXszxnjqi6fgtLR3mZFVrPENahG4mep5e2JT
 BmpmgN5uWVwEY71As/wPcNs6m7zZx04WoN9tqn3Mpy7GyclZCcG3VxqlJjTXKkruEjY1
 +CM0Y/MBnRJokfwEL48SKPSFlXrpATTRaFbCybDOKlcjaUf6G/80kzoqmaUudG+Rg0JS
 UYxrbvxiKvRRusf7rPmAzfTMs+qpKon7VVd5tGIbOtdaUEK4jCC0lytWbH60Ysop7qte
 K1y/TJok1rvTNqmlhUxpOu0R8MOzImO+cVBezoZFLnYGoVRoZZ/5y23cgD7Qgec+7MXl
 BT5Q==
X-Gm-Message-State: AJcUukfAYivHPrPHtklxNy2P13Q2qQ9Tyhwv66BnFshkHNOnf4txmEns
 /K4PJJT9HiY6HP/+YzwRYo4=
X-Google-Smtp-Source: ALg8bN5WGbG/X0YfKxi+O0qWupEnRFREachjWFJDxbXTB00aKKZLPgBmf4DoRkBwMh4mrFM0l5hDCw==
X-Received: by 2002:a17:902:6b87:: with SMTP id
 p7mr50903905plk.282.1546592074861; 
 Fri, 04 Jan 2019 00:54:34 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:34 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 2/11] KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
Date: Fri,  4 Jan 2019 16:53:56 +0800
Message-Id: <20190104085405.40356-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005435_584695_73EE8E54 
X-CRM114-Status: GOOD (  12.91  )
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
 arch/x86/kvm/vmx/vmx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2c159efedc40..384f4782afba 100644
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
+		list_for_each_entry(sp, range->flush_list, flush_link) {
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
