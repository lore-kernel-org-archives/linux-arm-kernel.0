Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C2FC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:37:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4C120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KHHAyR/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4C120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hCI4HoXATFK1/Y48qsF1hdzg+s7OC2dumiU9TJPopes=; b=KHHAyR/jqRsDh8
	Ba35wMakpmBsxXZq6TSSVn5QG234OsfAqPXOcCXC0WcRHRnXzuLtFhs32PqV6Rww/KNMJ/1hpB3cJ
	Zx4Fp7iWXN0LOWRREtQGI0O3dRTSG1aW8JGVTngDHU1QK+J26iPiIMK7h6n1qzhW6NYvnjDIheSZs
	38l/1+w2Fa0X/DGA1WA6jc3XTUl8miQ1RnBNED/nBbB8VjwQHXRgV3V+RVRzMJror2xnrqDhhPJtb
	aCxbmTQmqfdSYgtp5/6JuU8AuLM/yKKCwulDyALfvHbjplNZLRL4bYI8DTp0shAcWin93tw4eWQpF
	0x9JIXGWgvmG8jwTh3TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkENZ-0000ch-Dl; Thu, 17 Jan 2019 20:35:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEN1-0008O9-SC
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:34:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C988EBD;
 Thu, 17 Jan 2019 12:34:35 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9240D3F819;
 Thu, 17 Jan 2019 12:34:33 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 03/25] KVM: arm64: Delete orphaned declaration for
 __fpsimd_enabled()
Date: Thu, 17 Jan 2019 20:33:17 +0000
Message-Id: <1547757219-19439-4-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_123436_320649_AA7F1A74 
X-CRM114-Status: UNSURE (   9.93  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

X19mcHNpbWRfZW5hYmxlZCgpIG5vIGxvbmdlciBleGlzdHMsIGJ1dCBhIGRhbmdsaW5nIGRlY2xh
cmF0aW9uIGhhcwpzdXJ2aXZlZCBpbiBrdm1faHlwLmguCgpUaGlzIHBhdGNoIGdldHMgcmlkIG9m
IGl0LgoKU2lnbmVkLW9mZi1ieTogRGF2ZSBNYXJ0aW4gPERhdmUuTWFydGluQGFybS5jb20+ClJl
dmlld2VkLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+Ci0tLQogYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faHlwLmggfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faHlwLmgg
Yi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9oeXAuaAppbmRleCBhODBhN2VmLi5iZDdhMDU1
IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9oeXAuaAorKysgYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL2t2bV9oeXAuaApAQCAtMTQ4LDcgKzE0OCw2IEBAIHZvaWQgX19k
ZWJ1Z19zd2l0Y2hfdG9faG9zdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwogCiB2b2lkIF9fZnBz
aW1kX3NhdmVfc3RhdGUoc3RydWN0IHVzZXJfZnBzaW1kX3N0YXRlICpmcF9yZWdzKTsKIHZvaWQg
X19mcHNpbWRfcmVzdG9yZV9zdGF0ZShzdHJ1Y3QgdXNlcl9mcHNpbWRfc3RhdGUgKmZwX3JlZ3Mp
OwotYm9vbCBfX2Zwc2ltZF9lbmFibGVkKHZvaWQpOwogCiB2b2lkIGFjdGl2YXRlX3RyYXBzX3Zo
ZV9sb2FkKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiB2b2lkIGRlYWN0aXZhdGVfdHJhcHNfdmhl
X3B1dCh2b2lkKTsKLS0gCjIuMS40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
