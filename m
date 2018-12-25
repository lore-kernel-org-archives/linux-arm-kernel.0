Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F023CC07520
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:36:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7472173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yn9x/Nvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7472173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=P7TsNXU0gXeKpccHmbEYmtHEtDuxnVMEQWK6+XgavX8=; b=Yn9
	x/NviY+C195Ue1lkHISEgrn9N4mM1yVUQBz2HYLFLdRn0xIeG+zGj++N8eS9YKnsrPP4V3LmOy2l+
	Il8xZ06n3bNexshFSgXif2rNXVf9PiyfFh747fXvelkKH4Oz1dGwuYlEKGiIHh9Br1dTHNw7LmhNL
	5zYo1UIHapHQBmgoWXkvqKjk+F1LL18GndRaoHZRk6kiqKOW8Z9r3YY2CRO/nVW+hNn1+GKtppI1X
	+/zsA6NtFYXKIEoEV4LDxBerAwWtKgKqPJurQLnA/EDprs1LusKP7Be/eLqPJF1SDyTJDXSzbeW4Z
	vESiyVm87Q/4/AdlrcYtF9h05gEGweQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbeRm-0004Rh-Cz; Tue, 25 Dec 2018 04:36:02 +0000
Received: from mxhk.zte.com.cn ([63.217.80.70])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbeRh-0004Qg-AC
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 04:36:01 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 3C490B1CB244D08CF0E4;
 Tue, 25 Dec 2018 12:35:40 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id wBP4ZYcA091904;
 Tue, 25 Dec 2018 12:35:34 +0800 (GMT-8)
 (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2018122512354674-18598224 ;
 Tue, 25 Dec 2018 12:35:46 +0800 
From: Peng Hao <peng.hao2@zte.com.cn>
To: christoffer.dall@arm.com, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com
Subject: [PATCH]  kvm/arm : remove unnecessary local variable
Date: Tue, 25 Dec 2018 12:56:15 +0800
Message-Id: <1545713775-69870-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2018-12-25 12:35:46,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-25 12:35:30, Serialize complete at 2018-12-25 12:35:30
X-MAIL: mse01.zte.com.cn wBP4ZYcA091904
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_203557_512946_9BA17E7F 
X-CRM114-Status: GOOD (  11.42  )
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
Cc: Peng Hao <peng.hao2@zte.com.cn>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove unnecessary local variable in vgic_set_common_attr

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 virt/kvm/arm/vgic/vgic-kvm-device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index 114dce9..53e5df7 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -163,7 +163,7 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 static int vgic_set_common_attr(struct kvm_device *dev,
 				struct kvm_device_attr *attr)
 {
-	int r;
+	int r = 0;
 
 	switch (attr->group) {
 	case KVM_DEV_ARM_VGIC_GRP_ADDR: {
@@ -180,7 +180,6 @@ static int vgic_set_common_attr(struct kvm_device *dev,
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
 		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
 		u32 val;
-		int ret = 0;
 
 		if (get_user(val, uaddr))
 			return -EFAULT;
@@ -199,14 +198,14 @@ static int vgic_set_common_attr(struct kvm_device *dev,
 		mutex_lock(&dev->kvm->lock);
 
 		if (vgic_ready(dev->kvm) || dev->kvm->arch.vgic.nr_spis)
-			ret = -EBUSY;
+			r = -EBUSY;
 		else
 			dev->kvm->arch.vgic.nr_spis =
 				val - VGIC_NR_PRIVATE_IRQS;
 
 		mutex_unlock(&dev->kvm->lock);
 
-		return ret;
+		return r;
 	}
 	case KVM_DEV_ARM_VGIC_GRP_CTRL: {
 		switch (attr->attr) {
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
