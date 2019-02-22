Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81634C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEFD2077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rPAFtA2g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glVX89Xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEFD2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=icW3cOluFYTCB92WkEqSmZNHvcvPwCkmSex4h9dvh6M=; b=rPAFtA2gxUvJVRfDPC8wt50kKJ
	xQtT59oHvXF5Qvd3D0uMMzMHq5I6hehUzJT2NIE3XFp9gz0VAnXVmGYiGZt/D7WYvztsfsJ0AkN4r
	JaMOOmAJNqSI45ioHvC4dsZRg6xDOH7kSn8YH99auZUITIBaIwJrsM6pr6Hg8Yj7n805kDQdu67al
	PTXfN9kyMQVoKSR99nCMt+pVx/XzNWcCU4dHwwrzHs2BSnY6SqgW+Y6fqI0w1vJloYVtPTcz+OCGH
	VUAqHyyGqK9P8lZaIDVoaLXsiHndqvsBr4emiupuOYzuAYdY6BKBkX3bubVhV/E6Cr7w+gTv1F9vE
	+LYi+75g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx68J-0002jk-00; Fri, 22 Feb 2019 08:24:35 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx67f-0001yF-7Y
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:23:56 +0000
Received: by mail-pf1-x442.google.com with SMTP id n22so788954pfa.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 00:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bgi/EwWWX2Li81Mw0qcYS+JuoX7DsHGY+9JFpKlkgdc=;
 b=glVX89XfORwvW7FkND8gZJzWrHSHwaG4itLrZHBr4FtkNJ6lMhUsHHTNzqDKS+iDZU
 bDGk298KA7z/RP0due2fQziBZ1CPnNU5zcNXON30p1+uPXUpkTTxg1TvH1i771k0me3p
 VAQys7QShIJSO7z3/1EpSU4HBnERZ7ZESzp98tv8XgB37kyCSfqd6sr/13ohOgbRHjEb
 nlVeJ/tRVyyq6BG92HILxgNZs42uQ7uk6hV695t8Hhm07nf1JeSlHTJGs09pQdG2KWox
 DgFleQLZaYeMp2ARvyttG9DHqV1d/+6Dm5adgI16HdcMCRNk1O+awlRX7d4wh396+frB
 zrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bgi/EwWWX2Li81Mw0qcYS+JuoX7DsHGY+9JFpKlkgdc=;
 b=hBbf0yN2sV6uEGgG7X7OVk5QYG3cBgJyqNP1ReiikCAHJCl56l8Q00FN0WX485N9FN
 Y2zz9rVQzteHMCEaZLwKck1uuwBIk8mvqtYgWVzNAqvMAD4UBDwKTO4CN8FJzyeI2D0u
 8Ql5/eLmLepMXfOvEfDyYtzuU+OVMkivb8+U01YNTxeoMj7RxyZEl/cjarTwO+0ut6Bx
 8/ZFR2Z/ZQA7XqdyLYzbTz1LF9U9dT1lW9e3gg4f9IRzhkcuBoX7MyJSV81NmMWZo9+Y
 FN7YHR5uTqgArOggY5+ALhSpJtFrKGYQnBz45KiRL/sDJV8rbF6y3TpxV20CPEcBXZlp
 LyeQ==
X-Gm-Message-State: AHQUAuaf5a9a0LAUcuf6Oji1Pjwc8HV6q6mGZ0zRidqALlvML+Ccn1+8
 65iP8dB1Wxvgkjam+eN5fOdfQQ==
X-Google-Smtp-Source: AHgI3Ia5hNRiwxytszVdshV3NZynVSqQC4W3Tw34lPMYufhILVuh352r8QGCnNq/B8RT2OANfG46xA==
X-Received: by 2002:a62:e716:: with SMTP id s22mr2984891pfh.35.1550823834722; 
 Fri, 22 Feb 2019 00:23:54 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com.
 [45.79.96.158])
 by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 00:23:54 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 James Morse <james.morse@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Jun Yao <yaojun8558363@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] KVM: arm/arm64: Define TCR_EL2_T0SZ_MASK as
 TCR_T0SZ_MASK
Date: Fri, 22 Feb 2019 16:23:25 +0800
Message-Id: <20190222082327.3312-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222082327.3312-1-leo.yan@linaro.org>
References: <20190222082327.3312-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_002355_276073_37008C99 
X-CRM114-Status: GOOD (  12.41  )
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

Define macro TCR_EL2_T0SZ_MASK as TCR_T0SZ_MASK, so can remove the hard
number 0x3f.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6f602af5263c..d945a787f36e 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -99,7 +99,7 @@
 #define TCR_EL2_SH0_MASK	TCR_SH0_MASK
 #define TCR_EL2_ORGN0_MASK	TCR_ORGN0_MASK
 #define TCR_EL2_IRGN0_MASK	TCR_IRGN0_MASK
-#define TCR_EL2_T0SZ_MASK	0x3f
+#define TCR_EL2_T0SZ_MASK	TCR_T0SZ_MASK
 #define TCR_EL2_MASK	(TCR_EL2_TG0_MASK | TCR_EL2_SH0_MASK | \
 			 TCR_EL2_ORGN0_MASK | TCR_EL2_IRGN0_MASK | TCR_EL2_T0SZ_MASK)
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
