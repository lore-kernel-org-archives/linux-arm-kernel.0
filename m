Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50587C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED012087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TuyAT71i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNDxPbyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED012087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JF6Hc15TwPfuMXNCQOJK6pBAvy44vKEgsQ+6YKNYm9k=; b=TuyAT71iwTRePoSMAXQdSeGJFM
	O8Hycc2tJQWGdbvEh89o+s3RbaIChrtfUcrQYOqvKh9LD2MzCQa2aUoVCxMhP2VJmlTB/mvHt1dMv
	nBvcQuSmZ7urxQQa5VF9aGcHvpgnIy5uqPm/b+lNn6c+/EYtmX5EhqAYHP5umYsPQa/pMQS5dxT6/
	zjSD+jr/EVLFS7QXVWbmG2x82wfEczMy7gbMYtOaaJod3j/ea01Nr8Pr5dlrpZmL/LVazZw9f0U8q
	Kz2K1AsrfCYqO9sqhAiKL+shsYAPBdVH60lxtbk8nsKnh8jelje7ezINnRzNA78O4MRs6lpOmnLmm
	KXRGRPPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx68Q-0002sJ-34; Fri, 22 Feb 2019 08:24:42 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx67k-00025o-N6
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:24:06 +0000
Received: by mail-pl1-x644.google.com with SMTP id q3so774729pll.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 00:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yToDsQHz3ALMgK9EtUQgb46vvC2ZQAohlXLeU3oKRKI=;
 b=iNDxPbyyWhQMppHJsSCDsV+gjSyBJy0WimqXj0Zezyafuk6tomK/Xpt2ifNex/GF18
 zN2zDgecC0MfI5c8GruuMobJ7jBysUACkeUYWFdaCIusTrt0ucF8l1vVINzPUJpHFBsr
 2FogixqkYPdDK3t9W8RZj9rmOdCqTjYuyPUekjVq+gnNopoRq8U1KEykJxMMgLU5gMj7
 Tm5zVXAykk1ldds6XoIzsBxawpkkhfJjsvyqoFbnpi9ntVN/9GXEHQQ1/eogTqeC8Xfu
 L7E2Abc5Xe0RowZjqh7fpUuPuOWqaqXkbwUJIZ1rRmGHkg8r8aM+pFjhPsx4+F4Roo3k
 1N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yToDsQHz3ALMgK9EtUQgb46vvC2ZQAohlXLeU3oKRKI=;
 b=LYFgOx7Zr50M9OubLt50LjaZQdoY8PEAhia5zsY+fpgb6lYNflhekCL1vaVIvWDeu5
 cMGyR0RGBw7T8ZaSMwC+/vgqeUW47PdJpY3dPUm/FPDC3Q+AIzufNB9QAKyBr0cEdXDl
 RSjrgnYArFkBPYlrKukKviH4g6MjrZjuU4Qg+iS41hK/E90MwbPIgApD6XT09AICoHfh
 uJyyzguAcdh3wMTAs1bEleYaIkijeMOIl7FbbNoee/GFInY0WstFxRkA9Oal/HLIhFtI
 oITNB0ps5cFw5qkRY+OPIwOxFsw5i89f4CiU1PoE6UvZeg+hNh4ri/jEuT4y3CG/JC9m
 sWkg==
X-Gm-Message-State: AHQUAuZnPhs3tC9nuWeJZ3d4QJ4Y/Jsjdls+hVMZ3nvrJ5SqywkgdVl1
 jEe4Ldf3ENdrsUa7waN2LSP55Q==
X-Google-Smtp-Source: AHgI3IaV33tJQbsIeXVfmlMvaEdoQdrnhGr4bVSBQNDS2guL74fAKBX27EW4pzq3bzzTzFOEQyF+/Q==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr3026924plp.8.1550823840196; 
 Fri, 22 Feb 2019 00:24:00 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com.
 [45.79.96.158])
 by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 00:23:59 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 James Morse <james.morse@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Jun Yao <yaojun8558363@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] KVM: arm/arm64: Fix comment on create_hyp_mappings()
Date: Fri, 22 Feb 2019 16:23:26 +0800
Message-Id: <20190222082327.3312-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222082327.3312-1-leo.yan@linaro.org>
References: <20190222082327.3312-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_002401_311715_5F26BE05 
X-CRM114-Status: GOOD (  14.44  )
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

Since commit f7bec68d2fae ("arm/arm64: KVM: Prune unused #defines"), the
macro HYP_PAGE_OFFSET has been removed, but it's kept in the comment for
the function create_hyp_mappings().

This patch uses PAGE_OFFSET to replace HYP_PAGE_OFFSET and this is
consistent with what is doing in the function.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 virt/kvm/arm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 5eca48bdb1a6..9634f47c2c8b 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -734,7 +734,7 @@ static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
  * @prot:	The protection to be applied to this range
  *
  * The same virtual address as the kernel virtual address is also used
- * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
+ * in Hyp-mode mapping (modulo PAGE_OFFSET) to the same underlying
  * physical pages.
  */
 int create_hyp_mappings(void *from, void *to, pgprot_t prot)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
