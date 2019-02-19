Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4AAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:23:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE8121848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="im/7syvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE8121848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bwd3Sjgv3p5L3/ZX6zRHgTKOqWGYoOcjGJZw5mdchWE=; b=im/7syvrgE3Tj/
	4MK5T/mn8b8TYut3C+TxGRbvOHnqtLZGUEBvXah1zNtje0UilDi0wPpX/4vFbcscNhcoWHEAOaDLq
	IAkFUQ6ehQ+hU/va4/LsilDZsKQi8FvZe0jGGzEKhcToTRI4pvb0QxuJ+PBj+vxmHQim5rQLH8I+c
	yTpaajTaWkzzYcvw2lYX2pZ8Jb5COnSW5kcsj7kZK0eXLb/jT8aWcvGuZ944yzNbHKjimhDcZ+R0z
	qLrkPBBZAodXbgM4QKs0aE0+fVEU3CjtmReqXVRL4eOLi3BcKGt+llTsn5Re+3dm8ye5VUIQ1O5Z0
	87FvSq94KC/MxIBqpWOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1cr-0002wp-4l; Tue, 19 Feb 2019 09:23:41 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1co-0002tI-5i
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:23:39 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D8BD498BC1813DEED724;
 Tue, 19 Feb 2019 17:23:29 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 17:23:21 +0800
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH] KVM: arm/arm64: Remove unused gpa_end variable
Date: Tue, 19 Feb 2019 17:22:21 +0800
Message-ID: <1550568141-22796-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_012338_387415_F1C7C27E 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The 'gpa_end' local variable is never used and let's remove it.

Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 virt/kvm/arm/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 30251e288629..eac6ff15bd3a 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1598,14 +1598,13 @@ static void kvm_send_hwpoison_signal(unsigned long address,
 static bool fault_supports_stage2_pmd_mappings(struct kvm_memory_slot *memslot,
 					       unsigned long hva)
 {
-	gpa_t gpa_start, gpa_end;
+	gpa_t gpa_start;
 	hva_t uaddr_start, uaddr_end;
 	size_t size;
 
 	size = memslot->npages * PAGE_SIZE;
 
 	gpa_start = memslot->base_gfn << PAGE_SHIFT;
-	gpa_end = gpa_start + size;
 
 	uaddr_start = memslot->userspace_addr;
 	uaddr_end = uaddr_start + size;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
