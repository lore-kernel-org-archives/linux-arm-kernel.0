Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F08206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VuFrfx5D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjfjDlet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F08206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7deutLApuZhhFRHV4pGQsRhn1ZSZGvfhAQO2yembTBw=; b=VuFrfx5DOl6cusI4LLlyItmLoE
	1xM6U8hUYIt6OqMRi8wJe9wd0NgShJWWPrjnJ84fmSnkXcwiaELoWDGZr9bzPwlHlRQt5NPIqHqbJ
	MvwFsmQ1TotMX9Y1Q4++UtlShqpo+kpwNdDi3Syq7WwM2COR3TrL3PsZaUMNd0g3YNH9/7pTk41f8
	3GsnnhDBsJDIXYUvnBvuLFdkmnW39nqt7i/dQdnjxkNZC59adibSazRIriOHnObvOn6wnh2AuaYTb
	dRrNXrwyltX3b7xi/ipwDfyOpy0lYLUvl30jF8MAH3PYW/FfES6HCb1a6lHkMiviXOQcefOG+cHp4
	/gas1K2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx67r-0002D8-As; Fri, 22 Feb 2019 08:24:07 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx67Z-0001qN-4T
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:23:52 +0000
Received: by mail-pl1-x641.google.com with SMTP id r14so749226pls.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 00:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kVzojLvyJg8CcO1+5mzWEKYitIoofAkDltlfNCBnwRI=;
 b=KjfjDletYe2Gtz8dr94Kle7Id+AdDFAyRuqtC1gVPe2D+yRqWa5Mp7QaMT7TdxW380
 gbyuZhHjXcVxhcKWGjGvlVS/34VShvvl5tUyfFciiLIR7IgI1IASoxuRxWiDvjvRijUR
 k2Zeh2pj3ZZ44oZ+fRoJxZFaUjBrdB2M/vMa3HF88jMxOswoaVlgCWSGsi+9MJM6oApn
 TlRpSyxbIRr8xdLdjLjy6YZUUNxTIS7oong30k9mQ6Icmtnu2zWZrZ2VBYl88+SoM2gJ
 d7OE2cRo1TL0bSCUm5nJ6h4M9TDVdkd474mi0zYsD6fvJ4wPs99XtNDOKmJNhxsUbgPs
 nQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kVzojLvyJg8CcO1+5mzWEKYitIoofAkDltlfNCBnwRI=;
 b=bSuLHwDRhlImUC7txBzQFD5Bg8ZARRW13kW40el2e8XdhAONXHVGmvR9jkyTk/DOa+
 or8HqxNH9Ugpv7n3i1ceNkzHlDr8c1ckMnHWN6rNXdEDBPodWwUYG3d1zNaererzK4+t
 117kxU2ko35EGm7+xIJ2yuEe8QFwlAeqixGu49Vo5CrHDQu9oqxWpFbsSKk01ZHHzcP9
 5buxgWcTxgmQazanwfb0fqp9686xlvZIDR47gq9ut3OFTND4n89HGgw0LKPTI0h5NY5i
 9BPkavAEJ1/ijrG0F6Z2DSmo+GxKB3qYe8GLlZorxW+46U14a2nnhYWe8i4V8sSQFxvF
 AB5g==
X-Gm-Message-State: AHQUAuYVd4M+1I3Fm01NXBf2mRUgRKDgPNxZ1W05Ag2NWcBWmC0x1VwO
 JqyMAMJ4VXNcOmrP1OlLpxuoOFiLTqrUDQ==
X-Google-Smtp-Source: AHgI3IZ55XtbrNFbkQrDgrsmr7mdr4l6vEwAO7J8uZuW5jEBEg9XUvtG8XtenIsY3FNaYjdMyX7w4w==
X-Received: by 2002:a17:902:b20e:: with SMTP id
 t14mr2927069plr.97.1550823828410; 
 Fri, 22 Feb 2019 00:23:48 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com.
 [45.79.96.158])
 by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 00:23:47 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 James Morse <james.morse@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Jun Yao <yaojun8558363@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] KVM: arm/arm64: vgic: Improve comment on
 kvm_vgic_inject_irq
Date: Fri, 22 Feb 2019 16:23:24 +0800
Message-Id: <20190222082327.3312-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222082327.3312-1-leo.yan@linaro.org>
References: <20190222082327.3312-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_002349_606691_4507025C 
X-CRM114-Status: GOOD (  14.52  )
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
Cc: Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The function kvm_vgic_inject_irq() is not only used by PPIs but also can
be used to inject interrupt for SPIs; this patch improves comment for
argument @cpuid to reflect support SPIs as well.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 virt/kvm/arm/vgic/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 7cfdfbc910e0..79fe64c15051 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -394,7 +394,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
 /**
  * kvm_vgic_inject_irq - Inject an IRQ from a device to the vgic
  * @kvm:     The VM structure pointer
- * @cpuid:   The CPU for PPIs
+ * @cpuid:   The CPU for PPIs and SPIs
  * @intid:   The INTID to inject a new state to.
  * @level:   Edge-triggered:  true:  to trigger the interrupt
  *			      false: to ignore the call
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
