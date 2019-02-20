Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE120C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:24:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8862086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DviyzBc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8862086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g+ZPcjeNQOj7sYotaE8iZHmrrlezTCBEKmljemHnMqI=; b=DviyzBc+1VN2cT
	a2KmfffL2PUHCLeKF85w4kjzYEmlO7Sc/KeAkk7qjRFge8kz2IdHJWe5aTvunv9zM61YLNMbyUygv
	KpFIZCEMc1iCUWv+kh/lh0MoPIV3v9sIGHBmd7JYpmXvTAiHG+uXHMZAPrHDJsKquku0SyC3n7Fuk
	6M67luGTcy9/rwONNpzHqbxZ9ktIsOoouxTbCWe0+qZT496V6MowEZC/n1EmIFvXvp7Nz3tCFEZ3b
	COS7ILvoLlab27m3skUljQhJ0vcM0lYGtMqqhJFjk8v3qi4uBgS31V7jiHem76K6EHglhSTu4rHFc
	cGaYKh+9vkbyGaj5YshQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTj5-0006Su-A3; Wed, 20 Feb 2019 15:23:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTj2-0006SQ-8F
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:23:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 540AF15AB;
 Wed, 20 Feb 2019 07:23:54 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8681F3F5C1;
 Wed, 20 Feb 2019 07:23:52 -0800 (PST)
Date: Wed, 20 Feb 2019 15:23:50 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v5 05/26] KVM: arm64: Add missing #include of
 <linux/bitmap.h> to kvm_host.h
Message-ID: <20190220152349.GE4763@lakrids.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-6-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550519559-15915-6-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_072356_299546_DB5723B7 
X-CRM114-Status: GOOD (  16.98  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgMDc6NTI6MThQTSArMDAwMCwgRGF2ZSBNYXJ0aW4gd3Jv
dGU6Cj4ga3ZtX2hvc3QuaCB1c2VzIERFQ0xBUkVfQklUTUFQKCkgdG8gZGVjbGFyZSB0aGUgZmVh
dHVyZXMgbWVtYmVyIG9mCj4gc3RydWN0IHZjcHVfYXJjaCwgYnV0IHRoZSBjb3JyZXNwb25kaW5n
ICNpbmNsdWRlIGZvciB0aGlzIGlzCj4gbWlzc2luZy4KPiAKPiBUaGlzIHBhdGNoIGFkZHMgYSBz
dWl0YWJsZSAjaW5jbHVkZSBmb3IgPGxpbnV4L2JpdG1hcC5oPi4gIEFsdGhvdWdoCj4gdGhlIGhl
YWRlciBidWlsZHMgd2l0aG91dCBpdCB0b2RheSwgdGhpcyBzaG91bGQgaGVscCB0byBhdm9pZAo+
IGZ1dHVyZSBzdXJwcmlzZXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGF2ZSBNYXJ0aW4gPERhdmUu
TWFydGluQGFybS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVA
bGluYXJvLm9yZz4KPiAtLS0KPiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIHwg
MSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNt
L2t2bV9ob3N0LmgKPiBpbmRleCA3NzMyZDBiLi44NDA1NmE0IDEwMDY0NAo+IC0tLSBhL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAo+ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9h
c20va3ZtX2hvc3QuaAo+IEBAIC0yMiw2ICsyMiw3IEBACj4gICNpZm5kZWYgX19BUk02NF9LVk1f
SE9TVF9IX18KPiAgI2RlZmluZSBfX0FSTTY0X0tWTV9IT1NUX0hfXwo+ICAKPiArI2luY2x1ZGUg
PGxpbnV4L2JpdG1hcC5oPgo+ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KPiAgI2luY2x1ZGUg
PGxpbnV4L2t2bV90eXBlcy5oPgo+ICAjaW5jbHVkZSA8YXNtL2NwdWZlYXR1cmUuaD4KCkZyb20g
YSBxdWljayBzY2FuIG9mIHRoZSBmaWxlLCB3ZSdyZSBhbHNvIG1pc3Npbmc6CgojaW5jbHVkZSA8
bGludXgvanVtcF9sYWJlbC5oPgojaW5jbHVkZSA8bGludXgvcGVyY3B1Lmg+CiNpbmNsdWRlIDxs
aW51eC90aHJlYWRfaW5mby5oPgoKI2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+CgouLi4gd2hpY2gg
bWlnaHQgYmUgd29ydGggYWRkaW5nIGF0IHRoZSBzYW1lIHRpbWUuCgpUaGFua3MsCk1hcmsuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
