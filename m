Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C0C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:06:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1681920849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ExX9OpPc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xJWsvg6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1681920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fn7RAdamZznKT/wHIwZw1sJ39yiOPCko9mJA+4g01Rw=; b=ExX9OpPcSGeiY+
	+COQkAwRZ4mFik4MZ9KRLz1l935u7/st9TL5OOQRaJo5cey+q/cvTKIdlC6dCyQwvdWtB4pcuTyUw
	pcR6i1tQCghiJprcqeGK+cSnqEWXO6j4ti9T/M6VZLIe/N7ZBhuNYrAByw5TgGUsc6W/LefVEdy/z
	5KEpAKAdG+rpEzJHsjusVPzI2Puusd2GgDyiAuDQb6EVhhWXbcouqXNLauLvOtZ+6Q5hY2dadK204
	6VISpg074Ztv79eaxZBN5ETEoanB7OxNjT6xPFcGtuacXnglB+8jQP9HWcGiDhJBwg/teYAEnpgOC
	5FjtilMjKZkBSvu/hR2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX65Y-0002TO-3l; Wed, 12 Dec 2018 15:06:16 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX631-00075Y-R2
 for linux-arm-kernel@bombadil.infradead.org; Wed, 12 Dec 2018 15:03:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S+40wVRbfcuz5+wA8Lkh6qsOi+ppkBJb4+4HzLh+M6Y=; b=xJWsvg6WuZj6lxsgm5YxyjWHXZ
 HgCgTDSjAM15xgqGtvxYFDz6Sjv42Zo9GISYhUaUM/2fYbBsZWd1Hfd4XFHbL0aAqx1Y6HUcy2L4N
 tiN6kEnqS0D+CWRS7rldT26HA/EaVoPGYphu0yeBpP6zNZp8n2WRm3cVaF4BzPINgvrlSNFZ9CP1M
 qaBZ5o3Fy6pzorxagn6C3ezrbzETRf/r+SNUVDnvszB+7A8XV2JjX28HsQs69wUV7YSJyWskIjAXb
 rq+L+5I0LtLbJPtP5uxvWK0P6Plc/eJL0iFh+g1+I/RLpU62UMQJ7tis425mTKZ+SZ3TJZ0vqZpOz
 VAGfJulg==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62v-0000zJ-Of
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:03:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 222EF1993;
 Wed, 12 Dec 2018 07:03:20 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AFB03F59C;
 Wed, 12 Dec 2018 07:03:18 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 12/12] KVM: arm64: Export LPT using PV_TIME device
Date: Wed, 12 Dec 2018 15:02:26 +0000
Message-Id: <20181212150226.38051-13-steven.price@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212150226.38051-1-steven.price@arm.com>
References: <20181212150226.38051-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_100333_958975_A94E87AA 
X-CRM114-Status: GOOD (  16.75  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Extend the PV_TIME device to allow setting up Live Physical Time and
saving/restoring the state necessary for migration.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/uapi/asm/kvm.h |  2 ++
 virt/kvm/arm/pvtime.c             | 55 +++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index e1d42ff35430..d3b0d70cdd9f 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -310,8 +310,10 @@ struct kvm_vcpu_events {
 /* Device Control API: PV_TIME */
 #define KVM_DEV_ARM_PV_TIME_PADDR	0
 #define  KVM_DEV_ARM_PV_TIME_ST		0
+#define  KVM_DEV_ARM_PV_TIME_LPT	1
 #define KVM_DEV_ARM_PV_TIME_STATE_SIZE	1
 #define KVM_DEV_ARM_PV_TIME_STATE	2
+#define KVM_DEV_ARM_PV_TIME_FREQUENCY	3
 
 #endif
 
diff --git a/virt/kvm/arm/pvtime.c b/virt/kvm/arm/pvtime.c
index e033f55e3ee4..345798aebebf 100644
--- a/virt/kvm/arm/pvtime.c
+++ b/virt/kvm/arm/pvtime.c
@@ -25,6 +25,14 @@ static int kvm_arm_pvtime_create(struct kvm_device *dev, u32 type)
 	if (!pvtime->st)
 		return -ENOMEM;
 
+	pvtime->lpt = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!pvtime->lpt) {
+		free_pages_exact(pvtime->st, max_stolen_size());
+		return -ENOMEM;
+	}
+
+	pvtime->lpt_fpv = arch_timer_get_rate();
+
 	return 0;
 }
 
@@ -32,8 +40,10 @@ static void kvm_arm_pvtime_destroy(struct kvm_device *dev)
 {
 	struct kvm_arch_pvtime *pvtime = &dev->kvm->arch.pvtime;
 
+	pvtime->lpt_base = GPA_INVALID;
 	pvtime->st_base = GPA_INVALID;
 	free_pages_exact(pvtime->st, max_stolen_size());
+	free_page((unsigned long)pvtime->lpt);
 }
 
 static int pvtime_map_pages(struct kvm *kvm, gpa_t guest_paddr,
@@ -50,6 +60,10 @@ static int pvtime_save_state(struct kvm *kvm, u64 type, void __user *user)
 	size_t size;
 
 	switch (type) {
+	case KVM_DEV_ARM_PV_TIME_LPT:
+		source = kvm->arch.pvtime.lpt;
+		size = sizeof(struct pvclock_vm_time_info);
+		break;
 	case KVM_DEV_ARM_PV_TIME_ST:
 		source = kvm->arch.pvtime.st;
 		size = sizeof(struct pvclock_vcpu_stolen_time_info) *
@@ -70,6 +84,10 @@ static int pvtime_restore_state(struct kvm *kvm, u64 type, void __user *user)
 	size_t size;
 
 	switch (type) {
+	case KVM_DEV_ARM_PV_TIME_LPT:
+		dest = kvm->arch.pvtime.lpt;
+		size = sizeof(struct pvclock_vm_time_info);
+		break;
 	case KVM_DEV_ARM_PV_TIME_ST:
 		dest = kvm->arch.pvtime.st;
 		size = sizeof(struct pvclock_vcpu_stolen_time_info) *
@@ -91,6 +109,7 @@ static int kvm_arm_pvtime_set_attr(struct kvm_device *dev,
 	struct kvm_arch_pvtime *pvtime = &dev->kvm->arch.pvtime;
 	u64 __user *user = (u64 __user *)attr->addr;
 	u64 paddr;
+	u32 frequency;
 	int ret;
 
 	switch (attr->group) {
@@ -100,6 +119,15 @@ static int kvm_arm_pvtime_set_attr(struct kvm_device *dev,
 		if (paddr & 63)
 			return -EINVAL;
 		switch (attr->attr) {
+		case KVM_DEV_ARM_PV_TIME_LPT:
+			if (pvtime->lpt_base != GPA_INVALID)
+				return -EEXIST;
+			ret = pvtime_map_pages(dev->kvm, paddr, pvtime->lpt,
+					PAGE_SIZE);
+			if (ret)
+				return ret;
+			pvtime->lpt_base = paddr;
+			return kvm_arm_update_lpt_sequence(dev->kvm);
 		case KVM_DEV_ARM_PV_TIME_ST:
 			if (pvtime->st_base != GPA_INVALID)
 				return -EEXIST;
@@ -111,6 +139,13 @@ static int kvm_arm_pvtime_set_attr(struct kvm_device *dev,
 			return 0;
 		}
 		break;
+	case KVM_DEV_ARM_PV_TIME_FREQUENCY:
+		if (attr->attr != KVM_DEV_ARM_PV_TIME_LPT)
+			break;
+		if (get_user(frequency, user))
+			return -EFAULT;
+		pvtime->lpt_fpv = frequency;
+		return kvm_arm_update_lpt_sequence(dev->kvm);
 	case KVM_DEV_ARM_PV_TIME_STATE_SIZE:
 		return -EPERM;
 	case KVM_DEV_ARM_PV_TIME_STATE:
@@ -128,14 +163,27 @@ static int kvm_arm_pvtime_get_attr(struct kvm_device *dev,
 	switch (attr->group) {
 	case KVM_DEV_ARM_PV_TIME_PADDR:
 		switch (attr->attr) {
+		case KVM_DEV_ARM_PV_TIME_LPT:
+			if (put_user(dev->kvm->arch.pvtime.lpt_base, user))
+				return -EFAULT;
+			return 0;
 		case KVM_DEV_ARM_PV_TIME_ST:
 			if (put_user(dev->kvm->arch.pvtime.st_base, user))
 				return -EFAULT;
 			return 0;
 		}
 		break;
+	case KVM_DEV_ARM_PV_TIME_FREQUENCY:
+		if (attr->attr != KVM_DEV_ARM_PV_TIME_LPT)
+			break;
+		if (put_user(dev->kvm->arch.pvtime.lpt_fpv, user))
+			return -EFAULT;
+		return 0;
 	case KVM_DEV_ARM_PV_TIME_STATE_SIZE:
 		switch (attr->attr) {
+		case KVM_DEV_ARM_PV_TIME_LPT:
+			size = sizeof(struct pvclock_vm_time_info);
+			break;
 		case KVM_DEV_ARM_PV_TIME_ST:
 			size = sizeof(struct pvclock_vcpu_stolen_time_info);
 			size *= atomic_read(&dev->kvm->online_vcpus);
@@ -160,10 +208,17 @@ static int kvm_arm_pvtime_has_attr(struct kvm_device *dev,
 	case KVM_DEV_ARM_PV_TIME_STATE_SIZE:
 	case KVM_DEV_ARM_PV_TIME_STATE:
 		switch (attr->attr) {
+		case KVM_DEV_ARM_PV_TIME_LPT:
 		case KVM_DEV_ARM_PV_TIME_ST:
 			return 0;
 		}
 		break;
+	case KVM_DEV_ARM_PV_TIME_FREQUENCY:
+		switch (attr->attr) {
+		case KVM_DEV_ARM_PV_TIME_LPT:
+			return 0;
+		}
+		break;
 	}
 	return -ENXIO;
 }
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
