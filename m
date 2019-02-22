Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36EAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FAE2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V0RTIgC0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIyl/DXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FAE2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HOVqXQ79nJqZcMQUTIWmXq4/oPAC+3DI9mgBCBRIaxY=; b=V0RTIgC0jQJNqhd2XX9lhLL1eE
	yH7g5qYPPdedvXcTeIoNVqUfddqU2yx/Yp8JXjqbJlcjxk5NSytjy3yr2Uw59hoZ3+gCmtNi4DZ0E
	ZVwYccpXeI9EhTuJZl+mIS1PQTgRzwEBd8L5S/mE9LrJCCu/TCnPUyH5w9d6MvOV3uXaRHzgxCvjz
	q/tdFqg9bQpWwan6nuTWbxYMcQRwzzBmUL8xlddllbqXuFsJc88gsGaU3RNBh8n0DYwM6a39s/aw6
	+ZM+Qyl+JAFOtGl+ZuDciq6wAyXAdKYx91njKeVXEXvjzeQ8yDfFLopv4jCGPN9p8hgNV2x/h4mDp
	+f/aMG4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCPu-0008IW-Tq; Fri, 22 Feb 2019 15:07:10 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCPo-0008Aw-Ek
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:07:06 +0000
Received: by mail-pl1-x641.google.com with SMTP id 101so1221296pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XOGqMApv5NREZBijyNBtk5Mq8chNh80zkhgEbpmMbVY=;
 b=bIyl/DXXoGgQ4YrmVh1iadO3QT3Swk9cSFXEkSmL/zgA6U5uSOK3j/JZSbs9Qtn+qa
 S0pmsqlkUsMp0oIEQ+Pt4CQ6Q3Cd/sKIFlYfcMIRRXe+Cq8f4I/9jlvjiaYi5WqcZmHz
 wJCQqz6u1iv0Ns7GKuH2nmuhofoUU1g88ZohSdRaH4x+ZQyljcbTpY2SiHBhskEuCmFb
 IDqMu8v+TxxqQch73KOvnX7gyDpvry5EPBWhnMOQXwm9mRacBeSzxaj1q1DLUaayBKEU
 4BCaeriqTYrulXkLn9cB1HowchpJzY6P4U6kyBnvCTvp3xXgSi/GPRYdMXQqbQBNxiRb
 CXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XOGqMApv5NREZBijyNBtk5Mq8chNh80zkhgEbpmMbVY=;
 b=KuefpVkKpSo/BQu9M+7rfIQ+ILRdn9b4RfZxF5xwsls7MkrXoSMpk1s1l/N0NF5Rx7
 gIBJog39snk71D/7KUBLiexhZhG7EGYeO3r7MgNxWxpolSCRqEpkaj+MZwiFaFeMTaM4
 B5p79D1EsrsW9DoOWrr/4TeflB8JCwjrHeFhfq1e0s9OD0ZcQM/j7GsDPSWPPOUI8/ki
 H8x4vnRB0ki51QRrr6PggFWhXDVFkQlydmxjTIuUpYw+XZ3r+YnHMVS7bLaxcmyS6nZk
 mtfYggwXnpgw/2MHk2316Gke6DZ/AKZFbGHUPN/98T8UtFfe+6XV/xnNghXI3+YYj5z9
 lprg==
X-Gm-Message-State: AHQUAuYGeDWHw6nKbaOC/XZhH9VmTQ/i+Td2E27uqiSq/ZkpAKfcBAkL
 hf+YnmXohGsGuubpJblrMqU=
X-Google-Smtp-Source: AHgI3IZnxTMvvgIxIDjzAuWz/HznH+k+Vt2jo6Sat5I/rRyjGjsyeBvU0wvI0UHS3T9mvcSEjBCnPA==
X-Received: by 2002:a17:902:724c:: with SMTP id
 c12mr4652130pll.110.1550848023631; 
 Fri, 22 Feb 2019 07:07:03 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.06.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:02 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 1/10] X86/Hyper-V: Add parameter offset for
 hyperv_fill_flush_guest_mapping_list()
Date: Fri, 22 Feb 2019 23:06:28 +0800
Message-Id: <20190222150637.2337-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070704_796470_176B16BD 
X-CRM114-Status: GOOD (  12.85  )
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
 sashal@kernel.org, sthemmin@microsoft.com, mpe@ellerman.id.au, x86@kernel.org,
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
index 4950bb20e06a..77b5379e3655 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -433,7 +433,7 @@ static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush
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
