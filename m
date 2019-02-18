Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76C6C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:58:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211D021773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L6gjc2GD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oT0sdyJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211D021773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K86NqADj7cDxul5RepHlVKI0Xc16k9Ca4uqH0xE71uU=; b=L6gjc2GDVgu77/
	0TXZBt85jhiCfuPI75kI4BFijEMBgwnc/FlU5zVW91M6SUQ4fgx+lPJj0syi1nqj2SJuHjh7jvMJT
	DFbL1E5Hq5lhbMOXkD+rde+lAjsa9KgcJrXRXPc8gRNPQXJc51jrtGwzYLMd/+3LRLWxGh2+4FiJZ
	pYzhuoyzuV5rmu34wBpfo004/vmXYPS+lSrra64z2h3It2BLV8LNgncdE23gB6xS6Oo8q/Ea9LEdv
	dvpulebcU+XDMq5Rqnb+Ct74xGeBCKgbeSgoXzyaVP+MXUM58cBHNUOCjf1yCSB2rLRc6orbRCr0c
	ENuhI3Z91aEgZJ4QFBYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp3x-0002Yz-2L; Mon, 18 Feb 2019 19:58:49 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozv-00057b-MU
 for linux-arm-kernel@bombadil.infradead.org; Mon, 18 Feb 2019 19:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjcoX3lFkT8gwGuRjszqebsG4knPmjd6wRJ5XZVkjqA=; b=oT0sdyJvTkSngEGgN9ooqFcqmh
 fj1S52wkFuqMfrOaSjCVmP1ePFpk4vhMCzuKfo1zKp+0rhHCYettBInprjTCpnGBywjuKZUwv6xFQ
 IZdZCJQ36laab9fh5X9hnL4LgqpAfCE7Ay2kCxJXg1mSn2YZxFEPxcrwMNEUOzleklvf2ZxdFbVa4
 +ezBUIUX6hp1puroLnDtqIdrB11mq185t2J4+22t+A5Fm2s8e1q+Fsd03Ko+kVZDb9rENahpZOtFf
 vKyEFhrYfUJWVdmIHN/i3QF2//kJ/kU0NMjktPvDmyBTogfJqwYH0GRMrizTkOFpq63p/aZqle/cK
 d+oPGoDw==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvozs-0005mj-7H
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:54:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3CC21DCB;
 Mon, 18 Feb 2019 11:54:30 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F23043FBA7;
 Mon, 18 Feb 2019 11:54:23 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 26/26] KVM: arm64/sve: Document KVM API extensions for SVE
Date: Mon, 18 Feb 2019 19:52:39 +0000
Message-Id: <1550519559-15915-27-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_195436_606011_6BD02ECB 
X-CRM114-Status: GOOD (  17.09  )
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
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Julien Grall <julien.grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaCBhZGRzIHNlY3Rpb25zIHRvIHRoZSBLVk0gQVBJIGRvY3VtZW50YXRpb24gZGVz
Y3JpYmluZwp0aGUgZXh0ZW5zaW9ucyBmb3Igc3VwcG9ydGluZyB0aGUgU2NhbGFibGUgVmVjdG9y
IEV4dGVuc2lvbiAoU1ZFKQppbiBndWVzdHMuCgpTaWduZWQtb2ZmLWJ5OiBEYXZlIE1hcnRpbiA8
RGF2ZS5NYXJ0aW5AYXJtLmNvbT4KCi0tLQoKQ2hhbmdlcyBzaW5jZSB2NDoKCiAqIEFkZCBub3Rl
IGFib3V0IHdoaWNoIFNWRSByZWdpc3RlciBzbGljZXMgYXJlIHZpc2libGUsIGFuZCB0aGUKICAg
YmVoYXZpb3VyIG9mIG5vbi12aXNpYmxlIHNsaWNlcy4KLS0tCiBEb2N1bWVudGF0aW9uL3ZpcnR1
YWwva3ZtL2FwaS50eHQgfCA2OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0KIDEgZmlsZSBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYXBpLnR4dCBiL0RvY3VtZW50YXRp
b24vdmlydHVhbC9rdm0vYXBpLnR4dAppbmRleCBjYjE1ZjJhLi42YTZlMDI5IDEwMDY0NAotLS0g
YS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL2FwaS50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi92
aXJ0dWFsL2t2bS9hcGkudHh0CkBAIC0xODU2LDYgKzE4NTYsNyBAQCBQYXJhbWV0ZXJzOiBzdHJ1
Y3Qga3ZtX29uZV9yZWcgKGluKQogUmV0dXJuczogMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSB2YWx1
ZSBvbiBmYWlsdXJlCiBFcnJvcnM6CiAgwqBFTk9FTlQ6IMKgwqBubyBzdWNoIHJlZ2lzdGVyCisg
wqBFUEVSTTogwqDCoMKgcmVnaXN0ZXIgYWNjZXNzIGZvcmJpZGRlbiBmb3IgYXJjaGl0ZWN0dXJl
LWRlcGVuZGVudCByZWFzb25zCiAgwqBFSU5WQUw6IMKgwqBvdGhlciBlcnJvcnMsIHN1Y2ggYXMg
YmFkIHNpemUgZW5jb2RpbmcgZm9yIGEga25vd24gcmVnaXN0ZXIKIAogc3RydWN0IGt2bV9vbmVf
cmVnIHsKQEAgLTIxMTAsMTMgKzIxMTEsMjAgQEAgU3BlY2lmaWNhbGx5OgogICAweDYwMzAgMDAw
MCAwMDEwIDAwNGMgU1BTUl9VTkQgICAgNjQgIHNwc3JbS1ZNX1NQU1JfVU5EXQogICAweDYwMzAg
MDAwMCAwMDEwIDAwNGUgU1BTUl9JUlEgICAgNjQgIHNwc3JbS1ZNX1NQU1JfSVJRXQogICAweDYw
NjAgMDAwMCAwMDEwIDAwNTAgU1BTUl9GSVEgICAgNjQgIHNwc3JbS1ZNX1NQU1JfRklRXQotICAw
eDYwNDAgMDAwMCAwMDEwIDAwNTQgVjAgICAgICAgICAxMjggIGZwX3JlZ3MudnJlZ3NbMF0KLSAg
MHg2MDQwIDAwMDAgMDAxMCAwMDU4IFYxICAgICAgICAgMTI4ICBmcF9yZWdzLnZyZWdzWzFdCisg
IDB4NjA0MCAwMDAwIDAwMTAgMDA1NCBWMCAgICAgICAgIDEyOCAgZnBfcmVncy52cmVnc1swXSAg
ICAoKikKKyAgMHg2MDQwIDAwMDAgMDAxMCAwMDU4IFYxICAgICAgICAgMTI4ICBmcF9yZWdzLnZy
ZWdzWzFdICAgICgqKQogICAgIC4uLgotICAweDYwNDAgMDAwMCAwMDEwIDAwZDAgVjMxICAgICAg
ICAxMjggIGZwX3JlZ3MudnJlZ3NbMzFdCisgIDB4NjA0MCAwMDAwIDAwMTAgMDBkMCBWMzEgICAg
ICAgIDEyOCAgZnBfcmVncy52cmVnc1szMV0gICAoKikKICAgMHg2MDIwIDAwMDAgMDAxMCAwMGQ0
IEZQU1IgICAgICAgIDMyICBmcF9yZWdzLmZwc3IKICAgMHg2MDIwIDAwMDAgMDAxMCAwMGQ1IEZQ
Q1IgICAgICAgIDMyICBmcF9yZWdzLmZwY3IKIAorKCopIFRoZXNlIGVuY29kaW5ncyBhcmUgbm90
IGFjY2VwdGVkIGZvciBTVkUtZW5hYmxlZCB2Y3B1cy4gIFNlZQorICAgIEtWTV9BUk1fVkNQVV9J
TklULgorCisgICAgVGhlIGVxdWl2YWxlbnQgcmVnaXN0ZXIgY29udGVudCBjYW4gYmUgYWNjZXNz
ZWQgdmlhIGJpdHMgWzEyNzowXSBvZgorICAgIHRoZSBjb3JyZXNwb25kaW5nIFNWRSBabiByZWdp
c3RlcnMgaW5zdGVhZCBmb3IgdmNwdXMgdGhhdCBoYXZlIFNWRQorICAgIGVuYWJsZWQgKHNlZSBi
ZWxvdykuCisKIGFybTY0IENDU0lEUiByZWdpc3RlcnMgYXJlIGRlbXVsdGlwbGV4ZWQgYnkgQ1NT
RUxSIHZhbHVlOgogICAweDYwMjAgMDAwMCAwMDExIDAwIDxjc3NlbHI6OD4KIApAQCAtMjEyNiw2
ICsyMTM0LDU4IEBAIGFybTY0IHN5c3RlbSByZWdpc3RlcnMgaGF2ZSB0aGUgZm9sbG93aW5nIGlk
IGJpdCBwYXR0ZXJuczoKIGFybTY0IGZpcm13YXJlIHBzZXVkby1yZWdpc3RlcnMgaGF2ZSB0aGUg
Zm9sbG93aW5nIGJpdCBwYXR0ZXJuOgogICAweDYwMzAgMDAwMCAwMDE0IDxyZWdubzoxNj4KIAor
YXJtNjQgU1ZFIHJlZ2lzdGVycyBoYXZlIHRoZSBmb2xsb3dpbmcgYml0IHBhdHRlcm5zOgorICAw
eDYwODAgMDAwMCAwMDE1IDAwIDxuOjU+IDxzbGljZTo1PiAgIFpuIGJpdHNbMjA0OCpzbGljZSAr
IDIwNDcgOiAyMDQ4KnNsaWNlXQorICAweDYwNTAgMDAwMCAwMDE1IDA0IDxuOjQ+IDxzbGljZTo1
PiAgIFBuIGJpdHNbMjU2KnNsaWNlICsgMjU1IDogMjU2KnNsaWNlXQorICAweDYwNTAgMDAwMCAw
MDE1IDA2MCA8c2xpY2U6NT4gICAgICAgIEZGUiBiaXRzWzI1NipzbGljZSArIDI1NSA6IDI1Nipz
bGljZV0KKyAgMHg2MDYwIDAwMDAgMDAxNSBmZmZmICAgICAgICAgICAgICAgICBLVk1fUkVHX0FS
TTY0X1NWRV9WTFMgcHNldWRvLXJlZ2lzdGVyCisKK0FjY2VzcyB0byBzbGljZXMgYmV5b25kIHRo
ZSBtYXhpbXVtIHZlY3RvciBsZW5ndGggY29uZmlndXJlZCBmb3IgdGhlCit2Y3B1IChpLmUuLCB3
aGVyZSAxNiAqIHNsaWNlID49IG1heF92cSAoKiopKSB3aWxsIGZhaWwgd2l0aCBFTk9FTlQuCisK
K1RoZXNlIHJlZ2lzdGVycyBhcmUgb25seSBhY2Nlc3NpYmxlIG9uIHZjcHVzIGZvciB3aGljaCBT
VkUgaXMgZW5hYmxlZC4KK1NlZSBLVk1fQVJNX1ZDUFVfSU5JVCBmb3IgZGV0YWlscy4KKworS1ZN
X1JFR19BUk02NF9TVkVfVkxTIGlzIGEgcHNldWRvLXJlZ2lzdGVyIHRoYXQgYWxsb3dzIHRoZSBz
ZXQgb2YgdmVjdG9yCitsZW5ndGhzIHN1cHBvcnRlZCBieSB0aGUgdmNwdSB0byBiZSBkaXNjb3Zl
cmVkIGFuZCBjb25maWd1cmVkIGJ5Cit1c2Vyc3BhY2UuICBXaGVuIHRyYW5zZmVycmVkIHRvIG9y
IGZyb20gdXNlciBtZW1vcnkgdmlhIEtWTV9HRVRfT05FX1JFRworb3IgS1ZNX1NFVF9PTkVfUkVH
LCB0aGUgdmFsdWUgb2YgdGhpcyByZWdpc3RlciBpcyBvZiB0eXBlIF9fdTY0WzhdLCBhbmQKK2Vu
Y29kZXMgdGhlIHNldCBvZiB2ZWN0b3IgbGVuZ3RocyBhcyBmb2xsb3dzOgorCitfX3U2NCB2ZWN0
b3JfbGVuZ3Roc1s4XTsKKworaWYgKHZxID49IFNWRV9WUV9NSU4gJiYgdnEgPD0gU1ZFX1ZRX01B
WCAmJgorICAgICgodmVjdG9yX2xlbmd0aHNbKHZxIC0gMSkgLyA2NF0gPj4gKCh2cSAtIDEpICUg
NjQpKSAmIDEpKQorCS8qIFZlY3RvciBsZW5ndGggdnEgKiAxNiBieXRlcyBzdXBwb3J0ZWQgKi8K
K2Vsc2UKKwkvKiBWZWN0b3IgbGVuZ3RoIHZxICogMTYgYnl0ZXMgbm90IHN1cHBvcnRlZCAqLwor
CisoKiopIFRoZSBtYXhpbXVtIHZhbHVlIHZxIGZvciB3aGljaCB0aGUgYWJvdmUgY29uZGl0aW9u
IGlzIHRydWUgaXMKK21heF92cS4gIFRoaXMgaXMgdGhlIG1heGltdW0gdmVjdG9yIGxlbmd0aCBh
dmFpbGFibGUgdG8gdGhlIGd1ZXN0IG9uCit0aGlzIHZjcHUsIGFuZCBkZXRlcm1pbmVzIHdoaWNo
IHJlZ2lzdGVyIHNsaWNlcyBhcmUgdmlzaWJsZSB0aHJvdWdoCit0aGlzIGlvY3RsIGludGVyZmFj
ZS4KKworKFNlZSBEb2N1bWVudGF0aW9uL2FybTY0L3N2ZS50eHQgZm9yIGFuIGV4cGxhbmF0aW9u
IG9mIHRoZSAidnEiCitub21lbmNsYXR1cmUuKQorCitLVk1fUkVHX0FSTTY0X1NWRV9WTFMgaXMg
b25seSBhY2Nlc3NpYmxlIGFmdGVyIEtWTV9BUk1fVkNQVV9JTklULgorS1ZNX0FSTV9WQ1BVX0lO
SVQgaW5pdGlhbGlzZXMgaXQgdG8gdGhlIGJlc3Qgc2V0IG9mIHZlY3RvciBsZW5ndGhzIHRoYXQK
K3RoZSBob3N0IHN1cHBvcnRzLgorCitVc2Vyc3BhY2UgbWF5IHN1YnNlcXVlbnRseSBtb2RpZnkg
aXQgaWYgZGVzaXJlZCB1bnRpbCB0aGUgdmNwdQorY29uZmlndXJhdGlvbiBpcyBmaW5hbGl6ZWQg
YnkgYWNjZXNzaW5nIHRoZSBndWVzdCdzIFNWRSByZWdpc3RlcnMsIG9yCitlbnVtZXJhdGluZyB0
aGVtIHZpYSBLVk1fR0VUX1JFR19MSVNULCBvciBzZXR0aW5nIHRoZSBjcHUgcnVubmluZyB2aWEK
K0tWTV9SVU4uCisKK0FwYXJ0IGZyb20gc2ltcGx5IHJlbW92aW5nIGFsbCB2ZWN0b3IgbGVuZ3Ro
cyBmcm9tIHRoZSBob3N0IHNldCB0aGF0CitleGNlZWQgc29tZSB2YWx1ZSwgc3VwcG9ydCBmb3Ig
YXJiaXRyYXJpbHkgY2hvc2VuIHNldHMgb2YgdmVjdG9yIGxlbmd0aHMKK2lzIGhhcmR3YXJlLWRl
cGVuZGVudCBhbmQgbWF5IG5vdCBiZSBhdmFpbGFibGUuICBBdHRlbXB0aW5nIHRvIGNvbmZpZ3Vy
ZQorYW4gaW52YWxpZCBzZXQgb2YgdmVjdG9yIGxlbmd0aHMgdmlhIEtWTV9TRVRfT05FX1JFRyB3
aWxsIGZhaWwgd2l0aAorRUlOVkFMLgorCitBZnRlciB0aGUgdmNwdSdzIGNvbmZpZ3VyYXRpb24g
aXMgZmluYWxpemVkLCBmdXJ0aGVyIGF0dGVtcHRzIHRvIHdyaXRlCit0aGlzIHJlZ2lzdGVyIHdp
bGwgZmFpbCB3aXRoIEVQRVJNLgorCiAKIE1JUFMgcmVnaXN0ZXJzIGFyZSBtYXBwZWQgdXNpbmcg
dGhlIGxvd2VyIDMyIGJpdHMuICBUaGUgdXBwZXIgMTYgb2YgdGhhdCBpcwogdGhlIHJlZ2lzdGVy
IGdyb3VwIHR5cGU6CkBAIC0yMTgwLDYgKzIyNDAsNyBAQCBQYXJhbWV0ZXJzOiBzdHJ1Y3Qga3Zt
X29uZV9yZWcgKGluIGFuZCBvdXQpCiBSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIG5lZ2F0aXZlIHZh
bHVlIG9uIGZhaWx1cmUKIEVycm9yczoKICDCoEVOT0VOVDogwqDCoG5vIHN1Y2ggcmVnaXN0ZXIK
KyDCoEVQRVJNOiDCoMKgwqByZWdpc3RlciBhY2Nlc3MgZm9yYmlkZGVuIGZvciBhcmNoaXRlY3R1
cmUtZGVwZW5kZW50IHJlYXNvbnMKICDCoEVJTlZBTDogwqDCoG90aGVyIGVycm9ycywgc3VjaCBh
cyBiYWQgc2l6ZSBlbmNvZGluZyBmb3IgYSBrbm93biByZWdpc3RlcgogCiBUaGlzIGlvY3RsIGFs
bG93cyB0byByZWNlaXZlIHRoZSB2YWx1ZSBvZiBhIHNpbmdsZSByZWdpc3RlciBpbXBsZW1lbnRl
ZApAQCAtMjY3Miw2ICsyNzMzLDggQEAgUG9zc2libGUgZmVhdHVyZXM6CiAJICBEZXBlbmRzIG9u
IEtWTV9DQVBfQVJNX1BTQ0lfMF8yLgogCS0gS1ZNX0FSTV9WQ1BVX1BNVV9WMzogRW11bGF0ZSBQ
TVV2MyBmb3IgdGhlIENQVS4KIAkgIERlcGVuZHMgb24gS1ZNX0NBUF9BUk1fUE1VX1YzLgorCS0g
S1ZNX0FSTV9WQ1BVX1NWRTogRW5hYmxlcyBTVkUgZm9yIHRoZSBDUFUgKGFybTY0IG9ubHkpLgor
CSAgRGVwZW5kcyBvbiBLVk1fQ0FQX0FSTV9TVkUuCiAKIAogNC44MyBLVk1fQVJNX1BSRUZFUlJF
RF9UQVJHRVQKLS0gCjIuMS40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
