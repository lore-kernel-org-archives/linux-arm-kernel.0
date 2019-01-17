Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE831C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:03:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD90A20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V5Ia2Og9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="neX6j1Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD90A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SU7Eu3UtGEDE0KjK4fO44peJhCE/KneU9CSqLgpzI2U=; b=V5Ia2Og92S6jXM
	n5BragV56RJXR3OeeslnDnGCnk5V8i1OaHB6C95VsT7zhnGa9Snbe6nAIn9BeR8vM7q+Mg8SjU6fw
	uT7eyLmAWrLCvWNy9nulbAfvx6W18wbH8E2tlIJFjh9JS8k6y1+mnwno1L0gHA1TZtfdtdTwT9Adw
	TzH52KCA5KHT7xSCVAQr0S7ZA0J8RTtfQlzNRdlfeJl1PKhOf0OStSMNyx4P21eBS61ihEpuqSozS
	De4OCOTZqUSAH5WNF3I9up3CfNKAo9yozHMO8HH9RomUqVfcShCUq0PYSpUlseu7JQfNvYrz2eSYB
	G0ruFhGOxmqkX8o8S7tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEca-0002Qv-97; Thu, 17 Jan 2019 20:50:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEcN-0001sB-R0
 for linux-arm-kernel@bombadil.infradead.org; Thu, 17 Jan 2019 20:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KFFoOvaOUxJZl3H9ierQC8chvOqGIJ7zyZb7SBpEGpw=; b=neX6j1RlM58su9tNrxRjzsF+78
 CQBZ1v5DL6bMnbThvsQGDULaJG9q/ZirAxGZmuwLKXCUUFpXGxK5HgiWiLBufdwH5fK/zIoBDxq1d
 tRgXzehpLWfzxYKE8v+YIAQAbDj6jzH/cpmyQ503reJRy9+LQ1QrE+znzPzfLH/LhvVOj7sWwYmur
 1KtaUuUqIFa8/cpqGxUoLrjbawFzGUv+qvC0R6iN2FM4zh6zbZ0iNv5jIbqo4MXlYQQF5kD0lfOPj
 rMPUpTcCLNCZduXkuTE42uCfgFMGplZKMGYywt88a/fyRg1OQp13V7q/KsTAlFVI9wK993TzWJ2X+
 DzjW0lLg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENk-0006oJ-Kj
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEED21715;
 Thu, 17 Jan 2019 12:35:19 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C57AD3F819;
 Thu, 17 Jan 2019 12:35:17 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 24/25] KVM: Document errors for KVM_GET_ONE_REG and
 KVM_SET_ONE_REG
Date: Thu, 17 Jan 2019 20:33:38 +0000
Message-Id: <1547757219-19439-25-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_203520_832811_EACBA4ED 
X-CRM114-Status: UNSURE (   8.09  )
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

S1ZNX0dFVF9PTkVfUkVHIGFuZCBLVk1fU0VUX09ORV9SRUcgcmV0dXJuIHNvbWUgZXJyb3IgY29k
ZXMgdGhhdAphcmUgbm90IGRvY3VtZW50ZWQgKGJ1dCBob3BlZnVsbHkgbm90IHN1cnByaXNpbmcg
ZWl0aGVyKS4gIFRvIGdpdmUKYW4gaW5kaWNhdGlvbiBvZiB3aGF0IHRoZXNlIG1heSBtZWFuLCB0
aGlzIHBhdGNoIGFkZHMgYnJpZWYKZG9jdW1lbnRhdGlvbi4KClNpZ25lZC1vZmYtYnk6IERhdmUg
TWFydGluIDxEYXZlLk1hcnRpbkBhcm0uY29tPgotLS0KIERvY3VtZW50YXRpb24vdmlydHVhbC9r
dm0vYXBpLnR4dCB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hcGkudHh0IGIvRG9jdW1lbnRh
dGlvbi92aXJ0dWFsL2t2bS9hcGkudHh0CmluZGV4IDA5N2I4YmEuLmNiMTVmMmEgMTAwNjQ0Ci0t
LSBhL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYXBpLnR4dAorKysgYi9Eb2N1bWVudGF0aW9u
L3ZpcnR1YWwva3ZtL2FwaS50eHQKQEAgLTE4NTQsNiArMTg1NCw5IEBAIEFyY2hpdGVjdHVyZXM6
IGFsbAogVHlwZTogdmNwdSBpb2N0bAogUGFyYW1ldGVyczogc3RydWN0IGt2bV9vbmVfcmVnIChp
bikKIFJldHVybnM6IDAgb24gc3VjY2VzcywgbmVnYXRpdmUgdmFsdWUgb24gZmFpbHVyZQorRXJy
b3JzOgorIMKgRU5PRU5UOiDCoMKgbm8gc3VjaCByZWdpc3RlcgorIMKgRUlOVkFMOiDCoMKgb3Ro
ZXIgZXJyb3JzLCBzdWNoIGFzIGJhZCBzaXplIGVuY29kaW5nIGZvciBhIGtub3duIHJlZ2lzdGVy
CiAKIHN0cnVjdCBrdm1fb25lX3JlZyB7CiAgICAgICAgX191NjQgaWQ7CkBAIC0yMTc1LDYgKzIx
NzgsOSBAQCBBcmNoaXRlY3R1cmVzOiBhbGwKIFR5cGU6IHZjcHUgaW9jdGwKIFBhcmFtZXRlcnM6
IHN0cnVjdCBrdm1fb25lX3JlZyAoaW4gYW5kIG91dCkKIFJldHVybnM6IDAgb24gc3VjY2Vzcywg
bmVnYXRpdmUgdmFsdWUgb24gZmFpbHVyZQorRXJyb3JzOgorIMKgRU5PRU5UOiDCoMKgbm8gc3Vj
aCByZWdpc3RlcgorIMKgRUlOVkFMOiDCoMKgb3RoZXIgZXJyb3JzLCBzdWNoIGFzIGJhZCBzaXpl
IGVuY29kaW5nIGZvciBhIGtub3duIHJlZ2lzdGVyCiAKIFRoaXMgaW9jdGwgYWxsb3dzIHRvIHJl
Y2VpdmUgdGhlIHZhbHVlIG9mIGEgc2luZ2xlIHJlZ2lzdGVyIGltcGxlbWVudGVkCiBpbiBhIHZj
cHUuIFRoZSByZWdpc3RlciB0byByZWFkIGlzIGluZGljYXRlZCBieSB0aGUgImlkIiBmaWVsZCBv
ZiB0aGUKLS0gCjIuMS40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
