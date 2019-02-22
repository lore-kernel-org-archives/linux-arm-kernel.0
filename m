Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF9BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B49520700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TFekhZH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B49520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rvJBaKTd9hwlC2qzvtu4U47RwWH/a0R+Z9/kb1sFVu4=; b=TFekhZH83rOvUd
	r3vIF/eXlkGqClqVxJhmaDhExGFgFM/wpZcThiVQLnK3MMBXbWeXqWqRiaXwrWNXmlLx3QYib3qik
	DW40gZJ44Xzg3VWymdP8OyuQkWf2I8Gro5pk4VoNV0oi6zyiijnyX5BdC1Y8wkj8HcakIbiCcL4t6
	no8ljoTWhJOp3lyQF3nGrnNPHeB9jGroovED0Yvh9hwbFMD8WPiu2iiWG/vvly5LWe4e/rONch1NN
	pKzlCPVb7NZyG5wSZbyZMltRMCsqNJEBFDRAbhwTvK8Q7JZ5sHB5w6c6JWfxRE6Kx48bsH4tk5QTI
	1XFTtNYBGzZAuy2jKWeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDk5-0004d3-Al; Fri, 22 Feb 2019 16:32:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDgx-0000Lo-MC
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:28:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8010680D;
 Fri, 22 Feb 2019 08:28:51 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 E830A3F5C1; Fri, 22 Feb 2019 08:28:46 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 22/27] KVM: arm/arm64: Update MAINTAINERS entries
Date: Fri, 22 Feb 2019 16:26:00 +0000
Message-Id: <20190222162605.5054-23-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222162605.5054-1-marc.zyngier@arm.com>
References: <20190222162605.5054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_082851_724949_E898EBA0 
X-CRM114-Status: UNSURE (   8.66  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvm@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Zenghui Yu <yuzenghui@huawei.com>, Colin Ian King <colin.king@canonical.com>,
 Dave Martin <Dave.Martin@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For historical reasons, KVM/arm and KVM/arm64 have had different
entries in the MAINTAINER file. This makes little sense, as they are
maintained together.

On top of that, we have a bunch of talented people helping with
the reviewing, and they deserve to be mentioned in the consolidated
entry.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 MAINTAINERS | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..5d68f050d155 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8297,29 +8297,25 @@ S:	Maintained
 F:	arch/x86/include/asm/svm.h
 F:	arch/x86/kvm/svm.c
 
-KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
+KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64)
 M:	Christoffer Dall <christoffer.dall@arm.com>
 M:	Marc Zyngier <marc.zyngier@arm.com>
+R:	James Morse <james.morse@arm.com>
+R:	Julien Thierry <julien.thierry@arm.com>
+R:	Suzuki K Pouloze <suzuki.poulose@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	kvmarm@lists.cs.columbia.edu
 W:	http://systems.cs.columbia.edu/projects/kvm-arm
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
-S:	Supported
+S:	Maintained
 F:	arch/arm/include/uapi/asm/kvm*
 F:	arch/arm/include/asm/kvm*
 F:	arch/arm/kvm/
-F:	virt/kvm/arm/
-F:	include/kvm/arm_*
-
-KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
-M:	Christoffer Dall <christoffer.dall@arm.com>
-M:	Marc Zyngier <marc.zyngier@arm.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	kvmarm@lists.cs.columbia.edu
-S:	Maintained
 F:	arch/arm64/include/uapi/asm/kvm*
 F:	arch/arm64/include/asm/kvm*
 F:	arch/arm64/kvm/
+F:	virt/kvm/arm/
+F:	include/kvm/arm_*
 
 KERNEL VIRTUAL MACHINE FOR MIPS (KVM/mips)
 M:	James Hogan <jhogan@kernel.org>
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
