Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8504CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:04:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F59E20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tm/DOMAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F59E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eq37JQEDPqym0U5ibgQpmPrpD720QP1nbnvJcBmaZNw=; b=Tm/DOMAeDBlNc/
	oQ/0AnDbDsM2p+FHpsDf2LNw63Yqd9NJwqtAx/+wOmN3VpNN0hNJRDviHS7ry4VwXkiG3fcBkk4Xf
	zH0bX8eCE2+U/75fcCl+cVJ5MwkzBRfJZgTRBa6FTfeRs5unNInnhsCqP3MmQF9hNZMgj+do8wt5I
	7E2ZkmLNXIKZKuNCTaMzJDtpl7Q6p0A4hR7xb+vtbScoKYFkO+k2/5pu/53iqYRMKNyOWdeBRslbg
	0rDbgbQNQGZLTxG5zPpnm/3taAQhxiGg/O0Bt3wlFeC9/gyPEvZGox9ne2RoRLMmRFmwDWpb8QNQv
	dH5hc8VgzNNcpbT0NruQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEOJ-0002P1-Pl; Thu, 17 Jan 2019 20:35:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEN6-0008SX-F4
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:34:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06FBFEBD;
 Thu, 17 Jan 2019 12:34:40 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B97B3F819;
 Thu, 17 Jan 2019 12:34:37 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 05/25] KVM: arm64: Add missing #include of <linux/bitmap.h>
 to kvm_host.h
Date: Thu, 17 Jan 2019 20:33:19 +0000
Message-Id: <1547757219-19439-6-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_123440_816365_18AE75D4 
X-CRM114-Status: GOOD (  10.30  )
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

a3ZtX2hvc3QuaCB1c2VzIERFQ0xBUkVfQklUTUFQKCkgdG8gZGVjbGFyZSB0aGUgZmVhdHVyZXMg
bWVtYmVyIG9mCnN0cnVjdCB2Y3B1X2FyY2gsIGJ1dCB0aGUgY29ycmVzcG9uZGluZyAjaW5jbHVk
ZSBmb3IgdGhpcyBpcwptaXNzaW5nLgoKVGhpcyBwYXRjaCBhZGRzIGEgc3VpdGFibGUgI2luY2x1
ZGUgZm9yIDxsaW51eC9iaXRtYXAuaD4uICBBbHRob3VnaAp0aGUgaGVhZGVyIGJ1aWxkcyB3aXRo
b3V0IGl0IHRvZGF5LCB0aGlzIHNob3VsZCBoZWxwIHRvIGF2b2lkCmZ1dHVyZSBzdXJwcmlzZXMu
CgpTaWduZWQtb2ZmLWJ5OiBEYXZlIE1hcnRpbiA8RGF2ZS5NYXJ0aW5AYXJtLmNvbT4KUmV2aWV3
ZWQtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4KLS0tCiBhcmNoL2Fy
bTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCBi
L2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCA3NzMyZDBiLi44NDA1NmE0
IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKKysrIGIvYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0yMiw2ICsyMiw3IEBACiAjaWZuZGVm
IF9fQVJNNjRfS1ZNX0hPU1RfSF9fCiAjZGVmaW5lIF9fQVJNNjRfS1ZNX0hPU1RfSF9fCiAKKyNp
bmNsdWRlIDxsaW51eC9iaXRtYXAuaD4KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogI2luY2x1
ZGUgPGxpbnV4L2t2bV90eXBlcy5oPgogI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+Ci0tIAoy
LjEuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
