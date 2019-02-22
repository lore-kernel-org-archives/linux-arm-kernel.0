Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1A3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B5C2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s/d+cRuT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZn34zh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B5C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xcMnYO4yS9qtG6FJsRc+aRc+BKb6H9voz7FW2CoLb0M=; b=s/d+cRuTYc3sF4YsixqTDxqxbm
	i+bpA6eN/3R2we2k/ibMGMuvUH+8idMH0wJOnKjIxCVqFvjEj0s9HS5V0MFFvGo5XnYy1+a7TpzxS
	rjmT88sPQiAImuYGZYLfM2zCzVXQfXgNXvC1aJvK/9aDDINVd7t8mRS99pcWjnBVnBjwMiQ0m0kNR
	HfhWjMlSQ+GOWHJ3TVPFyMB+EQGuE3i7Ugtfj793pMw/vAJY2fYCcMaY4meOPdAHnVnxjigk3O/oQ
	VKSJpbGO6AzpcPTQ0mqiXVr6Tz4M7AW1wOspXXNzhEF2jEnT/gON92te82GsaDxv9EgIvvTFKR3yy
	D7p5aX4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCR9-000153-EO; Fri, 22 Feb 2019 15:08:27 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCQQ-0000N3-SR
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:07:50 +0000
Received: by mail-pl1-x642.google.com with SMTP id p19so1236200plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CpN/0CU4PssPimucBDW3qrQE8gB87OVfmQk4MBzKcb0=;
 b=sZn34zh121esQ9rHu7OfdWYgI567kymvyPtthBEFuNmOfJWc+SL6SiHZRqxvpLi/DS
 5j/HkSPzuvMHTcnA3dFymxGR4aVkky9kxKZwNg/3Y/dwfBbb5Au9iqewX8XYNPB1VdL0
 6k+2hIADWR2i5LzFzyDDyL7AG59h18992mECk/VkD80umCmdi5UmrWr9Px/rOmt7JwN9
 Zaxl2vdv628qNQ5yrIMbynBoCupTr5SOdm9HZF35o07h8qIZNoYKY+FGD0/1lErJMkiS
 Qrm986aMPblJDFt1pQK+S/V7cGMf2wMl/qZYusz1PX9Ia+wGbYclVCX4a2J/up3pieyZ
 ugpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CpN/0CU4PssPimucBDW3qrQE8gB87OVfmQk4MBzKcb0=;
 b=qLusQkZqH8VPBDhl23HUfz5iqZytvWvjJqWRWO7Gj1wxk64Jzkwr4wu3v8D76ggcwC
 X2tys7QDQ+H3L2BCn5dBCO+npPWk4OA4a1FdiRNGVRP3VZ4rnc2F06Pbofb0nUAmWf6A
 +4PcW8RAWH0Lo3wat27ZvFZzWRSl+fm3EpQSjcdcULogAbCtmnwfiS1wAWfB4narXXG1
 T6tySk2UXcvUJ5dbbsUFDNdE0JkUvgM5aC5K0752nYfXC8W1dVQZnCFRtMXt0q6Zi+2R
 wMPN8agCeuNmcAdc4NSubiV+iWzE3ZS/wu1fpHuCYZ9EgzC6wB/2FwHPBacVeGuD/fFz
 gHeQ==
X-Gm-Message-State: AHQUAua9glIfqv+Bg0OR3VG5ixvJZaB2m8ZmYRFN3mK68BKmpepWb38x
 zx1xKXa0cyo1UY8774LeDDA=
X-Google-Smtp-Source: AHgI3IYMepLojh2DFE0IB9ZwxY853xtXspAtLpEVzZyrdb9ij0IMu6tFRllJJBjnpjslRP6pU0AOLQ==
X-Received: by 2002:a17:902:bd97:: with SMTP id
 q23mr4685513pls.210.1550848062453; 
 Fri, 22 Feb 2019 07:07:42 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:41 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 6/10] KVM: Add kvm_get_memslot() to get memslot via slot id
Date: Fri, 22 Feb 2019 23:06:33 +0800
Message-Id: <20190222150637.2337-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070743_406098_1289AD19 
X-CRM114-Status: GOOD (  13.15  )
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

This patch is to add kvm_get_memslot() to get struct kvm_memory_slot
via slot it and remove redundant codes. The function will also be used
in the following changes.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 45 +++++++++++++++++++--------------------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9d55c63db09b..87e665069f6d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -779,6 +779,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			      struct kvm_dirty_log *log, bool *flush);
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush);
+struct kvm_memory_slot *kvm_get_memslot(struct kvm *kvm, u32 slot);
 
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					struct kvm_memory_slot *slot,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 276af92ace6c..61ddc3f0425c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1099,22 +1099,30 @@ static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
 	return kvm_set_memory_region(kvm, mem);
 }
 
+struct kvm_memory_slot *kvm_get_memslot(struct kvm *kvm, u32 slot)
+{
+	struct kvm_memslots *slots;
+	int as_id, id;
+
+	as_id = slot >> 16;
+	id = (u16)slot;
+	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
+		return NULL;
+
+	slots = __kvm_memslots(kvm, as_id);
+	return id_to_memslot(slots, id);
+}
+
 int kvm_get_dirty_log(struct kvm *kvm,
 			struct kvm_dirty_log *log, int *is_dirty)
 {
-	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int i, as_id, id;
 	unsigned long n;
 	unsigned long any = 0;
+	int i;
 
-	as_id = log->slot >> 16;
-	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-		return -EINVAL;
+	memslot = kvm_get_memslot(kvm, log->slot);
 
-	slots = __kvm_memslots(kvm, as_id);
-	memslot = id_to_memslot(slots, id);
 	if (!memslot->dirty_bitmap)
 		return -ENOENT;
 
@@ -1158,20 +1166,13 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
 int kvm_get_dirty_log_protect(struct kvm *kvm,
 			struct kvm_dirty_log *log, bool *flush)
 {
-	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int i, as_id, id;
 	unsigned long n;
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
+	int i;
 
-	as_id = log->slot >> 16;
-	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-		return -EINVAL;
-
-	slots = __kvm_memslots(kvm, as_id);
-	memslot = id_to_memslot(slots, id);
+	memslot = kvm_get_memslot(kvm, log->slot);
 
 	dirty_bitmap = memslot->dirty_bitmap;
 	if (!dirty_bitmap)
@@ -1227,24 +1228,16 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log_protect);
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush)
 {
-	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int as_id, id;
 	gfn_t offset;
 	unsigned long i, n;
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
-	as_id = log->slot >> 16;
-	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-		return -EINVAL;
-
 	if ((log->first_page & 63) || (log->num_pages & 63))
 		return -EINVAL;
 
-	slots = __kvm_memslots(kvm, as_id);
-	memslot = id_to_memslot(slots, id);
+	memslot = kvm_get_memslot(kvm, log->slot);
 
 	dirty_bitmap = memslot->dirty_bitmap;
 	if (!dirty_bitmap)
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
