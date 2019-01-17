Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F09C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:00:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BB020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WyQxIK8+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="plxHI/FB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BB020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uwhwCEFwtbzpSH9aacIMY+hHXf+mlhoX8OAYjYOQwwY=; b=WyQxIK8+z6mUSA
	CcxcRGVHlziAb2ZunZzxrJzuIIdgX6jAsM+g3E57GuJUKr318L/EucvsGgRvCUn0jwSp1zdyAypB7
	DgwMPJQuKe1D2LcJ/C1GRaM7D2PWQrsEOsKq3zQruhD99CcrvRCtRSNnhkeWfWpXbbg6rxz8zBMoe
	tjWOAgZ6HAme4wUvamT8TGoKsWs4oBbrZJRdfTyD6BX1ST9qd4D/ERzqb8SxmmgGQciceh6JfvfoF
	KEFEgDT21IBtrOh6Rcd2gKtuoWIE1+0dJsrr99HrSdxWQ2bewFw+3CNrAgrKQ5IUDAEepC0Vs1dtU
	f9tr7OKkljHccHNt5WIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEdP-0003E4-Go; Thu, 17 Jan 2019 20:51:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEcP-0001Wh-99
 for linux-arm-kernel@bombadil.infradead.org; Thu, 17 Jan 2019 20:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WQji0zoQdgw2l3qF2B87HpOLp59RlVngA2aOYfCMRTI=; b=plxHI/FBTzzmaVs6aZpAmjUzas
 LIdMTuFlXtc8flKbWJKXvLPycVZltzzMGPegI1QkUpSXx/TGFtYD9U5UuLMG3aoZvFO3UY+TWTw3U
 4E3tnUZh4QhcBA2F/P6Yy3Y3qMB6VN6TuX5YMpgoQxmT8hdA2CqQrGWdDZgdQZzPsHasfIWIL2MVN
 Cls0jUeKNVbSFs0aamKjwFw5HneI42dyc+qwE/cUUflDrt8GrIDr3B2NFTye4MCxU46VcorlxXLPV
 G0xCdHKRilaXjY/0AqPi0YKV695z/YmczN7BD6F/wuSBIGVj2oWgezxaLpcfscblMbW5luPgHfCKT
 38SXgqaQ==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENa-0006n0-0d
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FAFB16A3;
 Thu, 17 Jan 2019 12:35:09 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61B053F819;
 Thu, 17 Jan 2019 12:35:07 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 19/25] arm64/sve: In-kernel vector length availability
 query interface
Date: Thu, 17 Jan 2019 20:33:33 +0000
Message-Id: <1547757219-19439-20-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_203510_358269_7C789187 
X-CRM114-Status: GOOD (  18.92  )
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

S1ZNIHdpbGwgbmVlZCB0byBpbnRlcnJvZ2F0ZSB0aGUgc2V0IG9mIFNWRSB2ZWN0b3IgbGVuZ3Ro
cwphdmFpbGFibGUgb24gdGhlIHN5c3RlbS4KClRoaXMgcGF0Y2ggZXhwb3NlcyB0aGUgcmVsZXZh
bnQgYml0cyB0byB0aGUga2VybmVsLCBhbG9uZyB3aXRoIGEKc3ZlX3ZxX2F2YWlsYWJsZSgpIGhl
bHBlciB0byBjaGVjayB3aGV0aGVyIGEgcGFydGljdWxhciB2ZWN0b3IKbGVuZ3RoIGlzIHN1cHBv
cnRlZC4KCnZxX3RvX2JpdCgpIGFuZCBiaXRfdG9fdnEoKSBhcmUgbm90IGludGVuZGVkIGZvciB1
c2Ugb3V0c2lkZSB0aGVzZQpmdW5jdGlvbnMuCgpTaWduZWQtb2ZmLWJ5OiBEYXZlIE1hcnRpbiA8
RGF2ZS5NYXJ0aW5AYXJtLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5u
ZWVAbGluYXJvLm9yZz4KLS0tCiBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2Zwc2ltZC5oIHwgMjkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtNjQva2VybmVsL2Zwc2ltZC5j
ICAgICAgfCAzNSArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBj
aGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2luY2x1ZGUvYXNtL2Zwc2ltZC5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9m
cHNpbWQuaAppbmRleCBkZjdhMTQzLi5hZDZkMmU0IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2lu
Y2x1ZGUvYXNtL2Zwc2ltZC5oCisrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vZnBzaW1kLmgK
QEAgLTI0LDEwICsyNCwxMyBAQAogCiAjaWZuZGVmIF9fQVNTRU1CTFlfXwogCisjaW5jbHVkZSA8
bGludXgvYml0bWFwLmg+CiAjaW5jbHVkZSA8bGludXgvYnVpbGRfYnVnLmg+CisjaW5jbHVkZSA8
bGludXgvYnVnLmg+CiAjaW5jbHVkZSA8bGludXgvY2FjaGUuaD4KICNpbmNsdWRlIDxsaW51eC9p
bml0Lmg+CiAjaW5jbHVkZSA8bGludXgvc3RkZGVmLmg+CisjaW5jbHVkZSA8bGludXgvdHlwZXMu
aD4KIAogI2lmIGRlZmluZWQoX19LRVJORUxfXykgJiYgZGVmaW5lZChDT05GSUdfQ09NUEFUKQog
LyogTWFza3MgZm9yIGV4dHJhY3RpbmcgdGhlIEZQU1IgYW5kIEZQQ1IgZnJvbSB0aGUgRlBTQ1Ig
Ki8KQEAgLTg5LDYgKzkyLDMyIEBAIGV4dGVybiB1NjQgcmVhZF96Y3JfZmVhdHVyZXModm9pZCk7
CiAKIGV4dGVybiBpbnQgX19yb19hZnRlcl9pbml0IHN2ZV9tYXhfdmw7CiBleHRlcm4gaW50IF9f
cm9fYWZ0ZXJfaW5pdCBzdmVfbWF4X3ZpcnR1YWxpc2FibGVfdmw7CisvKiBTZXQgb2YgYXZhaWxh
YmxlIHZlY3RvciBsZW5ndGhzLCBhcyB2cV90b19iaXQodnEpOiAqLworZXh0ZXJuIF9fcm9fYWZ0
ZXJfaW5pdCBERUNMQVJFX0JJVE1BUChzdmVfdnFfbWFwLCBTVkVfVlFfTUFYKTsKKworLyoKKyAq
IEhlbHBlcnMgdG8gdHJhbnNsYXRlIGJpdCBpbmRpY2VzIGluIHN2ZV92cV9tYXAgdG8gVlEgdmFs
dWVzIChhbmQKKyAqIHZpY2UgdmVyc2EpLiAgVGhpcyBhbGxvd3MgZmluZF9uZXh0X2JpdCgpIHRv
IGJlIHVzZWQgdG8gZmluZCB0aGUKKyAqIF9tYXhpbXVtXyBWUSBub3QgZXhjZWVkaW5nIGEgY2Vy
dGFpbiB2YWx1ZS4KKyAqLworc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgX192cV90b19iaXQo
dW5zaWduZWQgaW50IHZxKQoreworCXJldHVybiBTVkVfVlFfTUFYIC0gdnE7Cit9CisKK3N0YXRp
YyBpbmxpbmUgdW5zaWduZWQgaW50IF9fYml0X3RvX3ZxKHVuc2lnbmVkIGludCBiaXQpCit7CisJ
aWYgKFdBUk5fT04oYml0ID49IFNWRV9WUV9NQVgpKQorCQliaXQgPSBTVkVfVlFfTUFYIC0gMTsK
KworCXJldHVybiBTVkVfVlFfTUFYIC0gYml0OworfQorCisvKiBFbnN1cmUgdnEgPj0gU1ZFX1ZR
X01JTiAmJiB2cSA8PSBTVkVfVlFfTUFYIGJlZm9yZSBjYWxsaW5nIHRoaXMgZnVuY3Rpb24gKi8K
K3N0YXRpYyBpbmxpbmUgYm9vbCBzdmVfdnFfYXZhaWxhYmxlKHVuc2lnbmVkIGludCB2cSkKK3sK
KwlyZXR1cm4gdGVzdF9iaXQoX192cV90b19iaXQodnEpLCBzdmVfdnFfbWFwKTsKK30KIAogI2lm
ZGVmIENPTkZJR19BUk02NF9TVkUKIApkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvZnBz
aW1kLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYwppbmRleCAwOWVlMjY0Li5hYzAwM2Ni
IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9mcHNpbWQuYworKysgYi9hcmNoL2FybTY0
L2tlcm5lbC9mcHNpbWQuYwpAQCAtMTM2LDcgKzEzNiw3IEBAIHN0YXRpYyBpbnQgc3ZlX2RlZmF1
bHRfdmwgPSAtMTsKIGludCBfX3JvX2FmdGVyX2luaXQgc3ZlX21heF92bCA9IFNWRV9WTF9NSU47
CiBpbnQgX19yb19hZnRlcl9pbml0IHN2ZV9tYXhfdmlydHVhbGlzYWJsZV92bCA9IFNWRV9WTF9N
SU47CiAvKiBTZXQgb2YgYXZhaWxhYmxlIHZlY3RvciBsZW5ndGhzLCBhcyB2cV90b19iaXQodnEp
OiAqLwotc3RhdGljIF9fcm9fYWZ0ZXJfaW5pdCBERUNMQVJFX0JJVE1BUChzdmVfdnFfbWFwLCBT
VkVfVlFfTUFYKTsKK19fcm9fYWZ0ZXJfaW5pdCBERUNMQVJFX0JJVE1BUChzdmVfdnFfbWFwLCBT
VkVfVlFfTUFYKTsKIC8qIFNldCBvZiB2ZWN0b3IgbGVuZ3RocyBwcmVzZW50IG9uIGF0IGxlYXN0
IG9uZSBjcHU6ICovCiBzdGF0aWMgX19yb19hZnRlcl9pbml0IERFQ0xBUkVfQklUTUFQKHN2ZV92
cV9wYXJ0aWFsX21hcCwgU1ZFX1ZRX01BWCk7CiBzdGF0aWMgdm9pZCBfX3BlcmNwdSAqZWZpX3N2
ZV9zdGF0ZTsKQEAgLTI3MCwyNSArMjcwLDYgQEAgdm9pZCBmcHNpbWRfc2F2ZSh2b2lkKQogfQog
CiAvKgotICogSGVscGVycyB0byB0cmFuc2xhdGUgYml0IGluZGljZXMgaW4gc3ZlX3ZxX21hcCB0
byBWUSB2YWx1ZXMgKGFuZAotICogdmljZSB2ZXJzYSkuICBUaGlzIGFsbG93cyBmaW5kX25leHRf
Yml0KCkgdG8gYmUgdXNlZCB0byBmaW5kIHRoZQotICogX21heGltdW1fIFZRIG5vdCBleGNlZWRp
bmcgYSBjZXJ0YWluIHZhbHVlLgotICovCi0KLXN0YXRpYyB1bnNpZ25lZCBpbnQgdnFfdG9fYml0
KHVuc2lnbmVkIGludCB2cSkKLXsKLQlyZXR1cm4gU1ZFX1ZRX01BWCAtIHZxOwotfQotCi1zdGF0
aWMgdW5zaWduZWQgaW50IGJpdF90b192cSh1bnNpZ25lZCBpbnQgYml0KQotewotCWlmIChXQVJO
X09OKGJpdCA+PSBTVkVfVlFfTUFYKSkKLQkJYml0ID0gU1ZFX1ZRX01BWCAtIDE7Ci0KLQlyZXR1
cm4gU1ZFX1ZRX01BWCAtIGJpdDsKLX0KLQotLyoKICAqIEFsbCB2ZWN0b3IgbGVuZ3RoIHNlbGVj
dGlvbiBmcm9tIHVzZXJzcGFjZSBjb21lcyB0aHJvdWdoIGhlcmUuCiAgKiBXZSdyZSBvbiBhIHNs
b3cgcGF0aCwgc28gc29tZSBzYW5pdHktY2hlY2tzIGFyZSBpbmNsdWRlZC4KICAqIElmIHRoaW5n
cyBnbyB3cm9uZyB0aGVyZSdzIGEgYnVnIHNvbWV3aGVyZSwgYnV0IHRyeSB0byBmYWxsIGJhY2sg
dG8gYQpAQCAtMzA5LDggKzI5MCw4IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgZmluZF9zdXBwb3J0
ZWRfdmVjdG9yX2xlbmd0aCh1bnNpZ25lZCBpbnQgdmwpCiAJCXZsID0gbWF4X3ZsOwogCiAJYml0
ID0gZmluZF9uZXh0X2JpdChzdmVfdnFfbWFwLCBTVkVfVlFfTUFYLAotCQkJICAgIHZxX3RvX2Jp
dChzdmVfdnFfZnJvbV92bCh2bCkpKTsKLQlyZXR1cm4gc3ZlX3ZsX2Zyb21fdnEoYml0X3RvX3Zx
KGJpdCkpOworCQkJICAgIF9fdnFfdG9fYml0KHN2ZV92cV9mcm9tX3ZsKHZsKSkpOworCXJldHVy
biBzdmVfdmxfZnJvbV92cShfX2JpdF90b192cShiaXQpKTsKIH0KIAogI2lmZGVmIENPTkZJR19T
WVNDVEwKQEAgLTY0OCw3ICs2MjksNyBAQCBzdGF0aWMgdm9pZCBzdmVfcHJvYmVfdnFzKERFQ0xB
UkVfQklUTUFQKG1hcCwgU1ZFX1ZRX01BWCkpCiAJCXdyaXRlX3N5c3JlZ19zKHpjciB8ICh2cSAt
IDEpLCBTWVNfWkNSX0VMMSk7IC8qIHNlbGYtc3luY2luZyAqLwogCQl2bCA9IHN2ZV9nZXRfdmwo
KTsKIAkJdnEgPSBzdmVfdnFfZnJvbV92bCh2bCk7IC8qIHNraXAgaW50ZXJ2ZW5pbmcgbGVuZ3Ro
cyAqLwotCQlzZXRfYml0KHZxX3RvX2JpdCh2cSksIG1hcCk7CisJCXNldF9iaXQoX192cV90b19i
aXQodnEpLCBtYXApOwogCX0KIH0KIApAQCAtNzE3LDcgKzY5OCw3IEBAIGludCBzdmVfdmVyaWZ5
X3ZxX21hcCh2b2lkKQogCSAqIE1pc21hdGNoZXMgYWJvdmUgc3ZlX21heF92aXJ0dWFsaXNhYmxl
X3ZsIGFyZSBmaW5lLCBzaW5jZQogCSAqIG5vIGd1ZXN0IGlzIGFsbG93ZWQgdG8gY29uZmlndXJl
IFpDUl9FTDIuTEVOIHRvIGV4Y2VlZCB0aGlzOgogCSAqLwotCWlmIChzdmVfdmxfZnJvbV92cShi
aXRfdG9fdnEoYikpIDw9IHN2ZV9tYXhfdmlydHVhbGlzYWJsZV92bCkgeworCWlmIChzdmVfdmxf
ZnJvbV92cShfX2JpdF90b192cShiKSkgPD0gc3ZlX21heF92aXJ0dWFsaXNhYmxlX3ZsKSB7CiAJ
CXByX3dhcm4oIlNWRTogY3B1JWQ6IFVuc3VwcG9ydGVkIHZlY3RvciBsZW5ndGgocykgcHJlc2Vu
dFxuIiwKIAkJCXNtcF9wcm9jZXNzb3JfaWQoKSk7CiAJCXJldHVybiAtRUlOVkFMOwpAQCAtODAx
LDggKzc4Miw4IEBAIHZvaWQgX19pbml0IHN2ZV9zZXR1cCh2b2lkKQogCSAqIHNvIHN2ZV92cV9t
YXAgbXVzdCBoYXZlIGF0IGxlYXN0IFNWRV9WUV9NSU4gc2V0LgogCSAqIElmIHNvbWV0aGluZyB3
ZW50IHdyb25nLCBhdCBsZWFzdCB0cnkgdG8gcGF0Y2ggaXQgdXA6CiAJICovCi0JaWYgKFdBUk5f
T04oIXRlc3RfYml0KHZxX3RvX2JpdChTVkVfVlFfTUlOKSwgc3ZlX3ZxX21hcCkpKQotCQlzZXRf
Yml0KHZxX3RvX2JpdChTVkVfVlFfTUlOKSwgc3ZlX3ZxX21hcCk7CisJaWYgKFdBUk5fT04oIXRl
c3RfYml0KF9fdnFfdG9fYml0KFNWRV9WUV9NSU4pLCBzdmVfdnFfbWFwKSkpCisJCXNldF9iaXQo
X192cV90b19iaXQoU1ZFX1ZRX01JTiksIHN2ZV92cV9tYXApOwogCiAJemNyID0gcmVhZF9zYW5p
dGlzZWRfZnRyX3JlZyhTWVNfWkNSX0VMMSk7CiAJc3ZlX21heF92bCA9IHN2ZV92bF9mcm9tX3Zx
KCh6Y3IgJiBaQ1JfRUx4X0xFTl9NQVNLKSArIDEpOwpAQCAtODMxLDcgKzgxMiw3IEBAIHZvaWQg
X19pbml0IHN2ZV9zZXR1cCh2b2lkKQogCQkvKiBObyB2aXJ0dWFsaXNhYmxlIFZMcz8gIFRoaXMg
aXMgYXJjaGl0ZWN0dXJhbGx5IGZvcmJpZGRlbi4gKi8KIAkJc3ZlX21heF92aXJ0dWFsaXNhYmxl
X3ZsID0gU1ZFX1ZRX01JTjsKIAllbHNlIC8qIGIgKyAxIDwgU1ZFX1ZRX01BWCAqLwotCQlzdmVf
bWF4X3ZpcnR1YWxpc2FibGVfdmwgPSBzdmVfdmxfZnJvbV92cShiaXRfdG9fdnEoYiArIDEpKTsK
KwkJc3ZlX21heF92aXJ0dWFsaXNhYmxlX3ZsID0gc3ZlX3ZsX2Zyb21fdnEoX19iaXRfdG9fdnEo
YiArIDEpKTsKIAogCWlmIChzdmVfbWF4X3ZpcnR1YWxpc2FibGVfdmwgPiBzdmVfbWF4X3ZsKQog
CQlzdmVfbWF4X3ZpcnR1YWxpc2FibGVfdmwgPSBzdmVfbWF4X3ZsOwotLSAKMi4xLjQKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
