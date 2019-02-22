Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA3EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:35:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8D62086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jTjUJAbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8D62086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=i1seyPCu6NGoTHHWwHYpX9T5ZE211HQm4yynzRVNJ+w=; b=jTjUJAbL3At6gQ
	2gblIhUIQ7rwseNUuIJYU+SUnAf18JDwiWVyNd7P4JAU6fzISZZybPSenQpmtX3PJR9R4e2v7Q6Vt
	pWOVSOW7EvrjHSTvsA78ODq+LQb/uuHaoWEvc9fE7p7TcgRNqkqeu36d6aitO3ibkcg56FS9b2l8q
	bxHpbo8ofjGLFY4D0chUvOerj3jYyJ/1dxEr+i9lT2BI8NPqNRtBN8XzAd1TknC5kRJw+cvU1XdtF
	0KDlMumOKhXNYGU4nSehvHRp6hprJ0MDv7biCUquNt+4rA8unt7WkhTWE+nXlt1v34urcR/Xew1TM
	ng3QeV/gQPrwP+Ncf0Lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx4Qn-0005pw-7f; Fri, 22 Feb 2019 06:35:33 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx4Qk-0005pU-91
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 06:35:31 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BE727F7ACCFA1759A1E9;
 Fri, 22 Feb 2019 14:35:20 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Feb 2019 14:35:14 +0800
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH -next] KVM: arm/arm64: Remove unused timer variable
Date: Fri, 22 Feb 2019 14:34:29 +0800
Message-ID: <1550817269-57405-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_223530_491186_26F87B1E 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
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
Cc: Suzuki K
 Pouloze <suzuki.poulose@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>, James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The 'timer' local variable became unused after commit bee038a67487
("KVM: arm/arm64: Rework the timer code to use a timer_map").
Remove it to avoid [-Wunused-but-set-variable] warning.

Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 virt/kvm/arm/arch_timer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index af8f2f1d01cc..3417f2dbc366 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -236,14 +236,12 @@ static enum hrtimer_restart kvm_hrtimer_expire(struct hrtimer *hrt)
 
 static bool kvm_timer_should_fire(struct arch_timer_context *timer_ctx)
 {
-	struct arch_timer_cpu *timer;
 	enum kvm_arch_timers index;
 	u64 cval, now;
 
 	if (!timer_ctx)
 		return false;
 
-	timer = vcpu_timer(timer_ctx->vcpu);
 	index = arch_timer_ctx_index(timer_ctx);
 
 	if (timer_ctx->loaded) {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
