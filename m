Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B819C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:05:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2745A20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0MGx478";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nDj6+Bo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2745A20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CHNKBAwnqa86A6HCdVVI5lNZHNQG/SXE7saYDQQI6hQ=; b=K0MGx478Foqv3Lwo5j89WJbDO8
	dMcDKdExRrR4e4gWFMEJwKCiJvw88OV64Amfvc279RkrNxN8lg6so8y2EYec0BuHQaCtB4u4TVwew
	rWtVbNU8hhzQk0LTDk1FmY0aqtyRZgFbiy/IJlqciKnyaDLNL264Qg2k52s8dzL9BvPVNSpEwtlcs
	WE+DjhIFktEXw93ZEVA7NvatWlGKHH7qocJoChejoE9F1rN2ieoab8SYwpI2bN4/OBNWIqmIOTyFV
	haragd+t4Mu4zO/+NL5OcIx+WstSxGEmKNnsEK479vTUAxGL02LdUsZqiX+OFCxZxVvdJAf5T2jYe
	6iXVfMKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEcp-0002hU-Ol; Thu, 17 Jan 2019 20:50:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEcO-0001Wh-3u
 for linux-arm-kernel@bombadil.infradead.org; Thu, 17 Jan 2019 20:50:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/YCWTeEyfO+hdjjXjIlRlHvj5/Bvv5tK6JvzqSOU2CI=; b=nDj6+Bo4kDDogDOiTY0k0BHiO
 Ablbi1sx8jeaR2OBlX5A1RnhYiEpd0VIID9N5jutzXl/XB9mf9OGz6f5RRwuv4GOD8IhR739KvThZ
 x4Ys99AEUEJVQbgSNbzDL53H6KxipTDtw1qjhUfHjXpRyILyfJxbza66UBfDnN/E87a8x5ToBa6TA
 7PKSOdtqN7FadO5qOLgxqzodSiTMZ1xKO10chCsIq0QQxY/ttjMiS56P4eQ3ao9/DYjxCyXny28zs
 Ymtep6mZjPkILgOvVZ/eObIaTziPk/VI3lSGDoUl8PxG9yb72Wc0Xw9nhf8ebL29B5U6ejtfU9sKB
 40ukAh8bw==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENi-0006ny-A5
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 872C4169E;
 Thu, 17 Jan 2019 12:35:17 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E3B93F819;
 Thu, 17 Jan 2019 12:35:15 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 23/25] KVM: arm64: Add a capabillity to advertise SVE
 support
Date: Thu, 17 Jan 2019 20:33:37 +0000
Message-Id: <1547757219-19439-24-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_203518_498962_2B3CE2D0 
X-CRM114-Status: GOOD (  11.05  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To provide a uniform way to check for KVM SVE support amongst other
features, this patch adds a suitable capability KVM_CAP_ARM_SVE,
and reports it as present when SVE is available.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kvm/reset.c   | 8 ++++++++
 include/uapi/linux/kvm.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ff2360..6e3482e 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -35,6 +35,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_mmu.h>
+#include <asm/virt.h>
 
 /* Maximum phys_shift supported for any VM on this host */
 static u32 kvm_ipa_limit;
@@ -93,6 +94,9 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_VM_IPA_SIZE:
 		r = kvm_ipa_limit;
 		break;
+	case KVM_CAP_ARM_SVE:
+		r = system_supports_sve();
+		break;
 	default:
 		r = 0;
 	}
@@ -115,6 +119,10 @@ static int kvm_reset_sve(struct kvm_vcpu *vcpu)
 	if (!system_supports_sve())
 		return -EINVAL;
 
+	/* Verify that KVM startup enforced this when SVE was detected: */
+	if (WARN_ON(!has_vhe()))
+		return -EINVAL;
+
 	/* If resetting an already-configured vcpu, just zero the SVE regs: */
 	if (vcpu->arch.sve_state) {
 		size_t size = vcpu_sve_state_size(vcpu);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index dc77a5a..4ea0d92 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -988,6 +988,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
 #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
 #define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_ARM_SVE 168
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
