Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E4C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:30:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9159F20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WJycJ7S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9159F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mRNO0wH8zYShHQ77xmDfT6Ask0ir7pGOHl+0HkqKstw=; b=WJycJ7S4alTkve
	rO1gGHkn460dBP5bmV6vOEyhN8ab67fyUzdghyy79e8SUam2veKsjL1xJCErqPD19qTBYeiWM9yo/
	0BJgMwNAg4YXSFupXTZqIsxeNhuGG+y51DaZL5C36Mj05vF01wOq39tjabJ0b4b3FM4NRgcR0Jz0L
	cM5spBegPgBWmRZwD5OQpCVEr0tO/U2tI2qPy3k2u0xNxlGWXsHW7JQCPmZbBpHR23o5jiy0N61MB
	axaeiY0ZLYjGba+2bIIDy7dq0PCJAAHSiS1rRO7XDnj9a5TQ9eshBX2oseqbqcVGvxEn01vfdv4+j
	mGC2w+JSctJwIWRtJvgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrTl-0004wO-Um; Tue, 11 Dec 2018 23:30:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTV-0003mn-O6
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1B6615AB;
 Tue, 11 Dec 2018 15:29:57 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBD683F614;
 Tue, 11 Dec 2018 15:29:55 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 04/24] KVM: arm64: Add missing #include of
 <linux/bitmap.h> to kvm_host.h
Date: Tue, 11 Dec 2018 23:28:41 +0000
Message-Id: <1544570941-7377-5-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153001_960752_B34A7E0D 
X-CRM114-Status: GOOD (  12.25  )
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
 Will Deacon <will.deacon@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

a3ZtX2hvc3QuaCB1c2VzIERFQ0xBUkVfQklUTUFQKCkgdG8gZGVjbGFyZSB0aGUgZmVhdHVyZXMg
bWVtYmVyIG9mCnN0cnVjdCB2Y3B1X2FyY2gsIGJ1dCB0aGUgY29ycmVzcG9uZGluZyAjaW5jbHVk
ZSBmb3IgdGhpcyBpcwptaXNzaW5nLgoKVGhpcyBwYXRjaCBhZGRzIGEgc3VpdGFibGUgI2luY2x1
ZGUgZm9yIDxsaW51eC9iaXRtYXAuaD4uICBBbHRob3VnaAp0aGUgaGVhZGVyIGJ1aWxkcyB3aXRo
b3V0IGl0IHRvZGF5LCB0aGlzIHNob3VsZCBoZWxwIHRvIGF2b2lkCmZ1dHVyZSBzdXJwcmlzZXMu
CgpTaWduZWQtb2ZmLWJ5OiBEYXZlIE1hcnRpbiA8RGF2ZS5NYXJ0aW5AYXJtLmNvbT4KUmV2aWV3
ZWQtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4KLS0tCiBhcmNoL2Fy
bTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCBi
L2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCA1MmZiYzgyLi4zNjYyZWUw
IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKKysrIGIvYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0yMiw2ICsyMiw3IEBACiAjaWZuZGVm
IF9fQVJNNjRfS1ZNX0hPU1RfSF9fCiAjZGVmaW5lIF9fQVJNNjRfS1ZNX0hPU1RfSF9fCiAKKyNp
bmNsdWRlIDxsaW51eC9iaXRtYXAuaD4KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogI2luY2x1
ZGUgPGxpbnV4L2t2bV90eXBlcy5oPgogI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+Ci0tIAoy
LjEuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
