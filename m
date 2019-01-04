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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DC1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23AA206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SX8WJkVb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdMxIz2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23AA206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YTsojIJeqRljoE8kCSdadlKJ7hego/VgMU1euk5hooY=; b=SX8WJkVbBeOzVBdKyJFtBmiq+x
	G23elmsHDz8o9ClBa17xhEfC3pzknKhB8XRzOTbpXIH/d+ML4K8/A22o5X7+wqxMVGUePZ2aWb4r6
	cMPmfEWByC7OvDgYIJiIbwriPj2dncAGSEWmuPL4UrYAxhrk5EOD0WaNlZwozfPB1Zr9kGP+un53O
	MVvbyln81cK6zoLRQIkcWg3dgCTzzxggRN3g4Qh7KsmUMElbFbEdgzauhlZUEJC+ukbSP7pn60ON7
	Z0cBk0GpmOlERPmHTzxS8sJqXxLu3k6O+JlY9SkaaUoWP/ry5P3OHfAU+q43GCzMaaMo8Fm+fp5Uo
	D2Y2mHmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLFY-0006A0-Az; Fri, 04 Jan 2019 08:54:40 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLFL-0005xX-R8
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:54:30 +0000
Received: by mail-pl1-x643.google.com with SMTP id 101so17158359pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=i8dTC8urZcLwzyeR/Vu4fyO0uZy0FNHekKBQ29Y6YMc=;
 b=bdMxIz2guzLdRdqjth6wjnjPZpbVIL8eDJoyDtFD6lpVDG7+fysF4tr92TwaeGD1UJ
 qRmQlP4GDRzHhqiUly7mOgKQGoRufG5jOxCQprD7BlFuSMnoSILnCdYWNYs+6Ifx/Sln
 BGPnkmqSEvmUauOGa4FkchQZedbLOMT0dOl6y1mzlvMOjHfyYIKmxF2lovPJcLAPFIyg
 gILasOp6WzoJ3XwF459ntkbpt1eusiDJxR2P1Wx8GAlWuPYMWPGZ7tqoeLUStKpgHcy+
 lM5Z8J2RLqWHa11em3HaSKFHjEgz+xGNaSjMe9S5fSyqT57yTB128mxRtrlcPWt36UEC
 q27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=i8dTC8urZcLwzyeR/Vu4fyO0uZy0FNHekKBQ29Y6YMc=;
 b=n0pXblJhk83UXNSDIVg99oD4DqBolf2bGa5syItfWKougH1kQ9yVBFPbGLNzbolibd
 LpTtFiXKuxLwX5eLLTNrcmMTDw2vV8Vyae4mQdB3hghRbvlty50JmogYtHxIo4mfgXFM
 yYSeYJG5Ld3PO3Mr+o7zEiLobMFrkAja4KiboRumbj2hLmwyTYGeQoQNTog16CBSVFdj
 0Qhto9n2Uc8BBxcL8jIx+AUkBx2qMgeg2Hd5NdejMF2SARGbUfzuMlS0Kt463xkIbjGn
 tqgLuQDS6KLb0BvXKhDO3C9pAclM3J3FE3aw9jcPDi0bfLnNpJ3uapldPo3NQ2M9T0L3
 ZEDg==
X-Gm-Message-State: AJcUukdvc9fqyUKS7/FEhFue5I5JTrfHaarewCbOryh0AgO3wWfehBna
 hFP+EkdyImAorboP8KxBuXyagRfkCTEIlA==
X-Google-Smtp-Source: ALg8bN7Hd/i8EVRwXrchiQNQpGOa141b9ceEW8y8b4HLeNCBSzMideSbEpZ9osZHG5VKjOcZ5XywAA==
X-Received: by 2002:a17:902:59c8:: with SMTP id
 d8mr50066601plj.116.1546592067395; 
 Fri, 04 Jan 2019 00:54:27 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:26 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 1/11] X86/Hyper-V: Add parameter offset for
 hyperv_fill_flush_guest_mapping_list()
Date: Fri,  4 Jan 2019 16:53:55 +0800
Message-Id: <20190104085405.40356-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005428_225643_33AD5F98 
X-CRM114-Status: GOOD (  12.57  )
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
 will.deacon@arm.com, linux-kernel@vger.kernel.org, paulus@ozlabs.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 sthemmin@microsoft.com, mpe@ellerman.id.au, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 benh@kernel.crashing.org, jhogan@kernel.org, linux-mips@vger.kernel.org,
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

Add parameter offset to specify start position to add flush ranges in
guest address list of struct hv_guest_mapping_flush_list.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/nested.c        | 4 ++--
 arch/x86/include/asm/mshyperv.h | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index dd0a843f766d..96f8bac7476d 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -58,11 +58,11 @@ EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
 
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
-		u64 start_gfn, u64 pages)
+		int offset, u64 start_gfn, u64 pages)
 {
 	u64 cur = start_gfn;
 	u64 additional_pages;
-	int gpa_n = 0;
+	int gpa_n = offset;
 
 	do {
 		/*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index cc60e617931c..d6be685ab6b0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -357,7 +357,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 		hyperv_fill_flush_list_func fill_func, void *data);
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
-		u64 start_gfn, u64 end_gfn);
+		int offset, u64 start_gfn, u64 end_gfn);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 87224e4c2fd9..2c159efedc40 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -428,7 +428,7 @@ int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
 {
 	struct kvm_tlb_range *range = data;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, range->start_gfn,
+	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
 			range->pages);
 }
 
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
