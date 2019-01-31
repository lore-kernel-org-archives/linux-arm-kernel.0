Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A33C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:18:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82DB218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cg8rFjCI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkm+7iM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82DB218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L12Z/fgmZ1IFgJ/1ct8bRo8A5t1omHWPMwE89S5x+QM=; b=Cg8rFjCI+z5b56
	Ia0Yl8ti5C4X4St64p/tQ2fszdS4emr6QLIEICuwsQIvK1fgWFdX0W8346nyEtP8t6EQ+CUOSDjY2
	I323+AlNk4We1QtD+flbyioHyY7soqkhcrTb8P1Yl3sLXrWmP6A4px3os+br4aHhg6Wq106WspefH
	ly2Ahk6pcWn8b1Y8QVGtjctKzjgB6Noe4wrHV5RPjyArnr8xgOJCw8Asg1wFlqljPoRg1u/Vo8HnX
	cmNgnDqLe50mN0CAfqRO5LI4bht5TlBuZeHV6QZ/ybLiR3kCEfLKO+zyYr1bnS4dzjkvgIZIUZyti
	aiGvhS71ZAE06P/axvhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCEK-0003Nq-Tf; Thu, 31 Jan 2019 13:18:08 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCDl-0002uI-FC
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:17:42 +0000
Received: by mail-wm1-x342.google.com with SMTP id f188so2493683wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Fa/9eqHA0GGzzc70iN6ald5hFT5n/MB5Izjbqe6468U=;
 b=dkm+7iM6mUiHZZ3SnD0uIkQ7FORxOGgBWo2bSLI/LN4ODX632roTvN17f8ZZ9DqO4p
 01fTsxcgEl4GWebjMjRp+oy4WTbb7N2AHlcLrQlnNkvFfS0tX61jLndUQ+EpiSynUu3+
 pqfHJPt/aA4f5QP2k4g3zqnyCiGBhHGjLKmZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fa/9eqHA0GGzzc70iN6ald5hFT5n/MB5Izjbqe6468U=;
 b=cY+qN6bR/HyHPGYbNWS1fyH9JpRzKxXuHGv5P8rrtGSvLf9PMjxuzQOCoAXHaX2U8z
 KMFDQbd3sBoPcmE2yjKfloQAKmbH8BCNfwFKnj0wEgEYT9sdxRhKtozTuEUjTqDZtvNR
 e8qUqM0Z2CDTHAO12WLS9+uKp6ck2JhG2fZxRWy5N/SIPMBWNvLWh74bgCiqma4xiOL4
 xc/3HSR2p3gqkE9O5qrU9UHK+x5AjKvPMoIe/jun2EUDN7mIHNaFqQbbR2BaXiFWMlDT
 vQlHcKGdDot186e2ADZv5ZeQaVw5cbBod2bGTHq+6Ue8QiWXgXAAg2kLos7b/ZAp8Die
 ZelA==
X-Gm-Message-State: AJcUukc4GMTlrF0du+B3uNymcAgclvB2fqECFtrrBkSwie4EcnpqNiX0
 Jg0it39q1paDUfuIgCz4QX8iNC5/Rng=
X-Google-Smtp-Source: ALg8bN7OMdxQ05KpdIw5UxOAYDfrY8V5m4fs1NI/7gUDO4S/42mqoXzwbdagxKHlPP9fewpE95d9PA==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr28890965wme.1.1548940651289;
 Thu, 31 Jan 2019 05:17:31 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id d16sm3211495wru.52.2019.01.31.05.17.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:17:30 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: kvm: describe data or unified caches as having
 1 set and 1 way
Date: Thu, 31 Jan 2019 14:17:18 +0100
Message-Id: <20190131131718.1627-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131131718.1627-1-ard.biesheuvel@linaro.org>
References: <20190131131718.1627-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_051733_684364_3BBFB6C9 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: marc.zyngier@arm.com, christoffer.dall@arm.com, Suzuki.Poulose@arm.com,
 kvmarm@lists.cs.columbia.edu, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On SMP ARM systems, cache maintenance by set/way should only ever be
done in the context of onlining or offlining CPUs, which is typically
done by bare metal firmware and never in a virtual machine. For this
reason, we trap set/way cache maintenance operations and replace them
with conditional flushing of the entire guest address space.

Due to this trapping, the set/way arguments passed into the set/way
ops are completely ignored, and thus irrelevant. This also means that
the set/way geometry is equally irrelevant, and we can simply report
it as 1 set and 1 way, so that legacy 32-bit ARM system software (i.e.,
the kind that only receives odd fixes) doesn't take a performance hit
due to the trapping when iterating over the cachelines.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/kvm_emulate.h |  3 ++-
 arch/arm64/kvm/sys_regs.c            | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 87f9c1b6387e..c450b15511b7 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -78,7 +78,8 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 	if (!vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 |= HCR_TID3;
 
-	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE))
+	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
+	    vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 |= HCR_TID2;
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1312aebf74e6..5882e3410acc 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1188,6 +1188,21 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
 	p->regval = get_ccsidr(csselr);
+
+	/*
+	 * Guests should not be doing cache operations by set/way at all, and
+	 * for this reason, we trap them and attempt to infer the intent, so
+	 * that we can flush the entire guest's address space at the appropriate
+	 * time.
+	 * To prevent this trapping from causing performance problems, let's
+	 * expose the geometry of all data and unified caches (which are
+	 * guaranteed to be PIPT and thus non-aliasing) as 1 set and 1 way.
+	 * [If guests should attempt to infer aliasing properties from the
+	 * geometry (which is not permitted by the architecture), they would
+	 * only do so for virtually indexed caches.]
+	 */
+	if (!(csselr & 1)) // data or unified cache
+		p->regval &= ~GENMASK(27, 3);
 	return true;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
