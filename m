Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD43BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:08:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D40218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d2jP84Ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D40218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YM2VPBkBgWlBf+MdprXGa97W3G4Md0fGyC7Q6AWB81M=; b=d2jP84IpGDx2js
	VP4c+buqvdGrGrDUwOO6X8duv1op8mAN0fCU1tSXDIMpTtc4zq7dAd5uBDUae3jkwIDwL1iNl+iyO
	EV/xxHiIrtcv8724JKTojBHs9AFG9YsAFjVud/B0AwH5sPyEtCfIpJK/pFvCGjaJw8/K3z+AcblRO
	ZVq2IhkBRWqKxBk8wPpL1LjS139cKGUo7vVhBrI+f4fkmfjQV7vC5qes3LPNcndH4qsb2Ae4aV8Pq
	9795a1G0syb+Qn/OyNGD5mDfa1BUO3jzaFLGoIyjC4PeXlQAluZW3lhgrwYzGGcz76X6SE3FtJNSW
	cNy1p9Jwrd4oIso+N+4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grUQm-0000XC-R7; Wed, 06 Feb 2019 21:08:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grUQi-0000WK-LS
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 21:08:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36D9AEBD;
 Wed,  6 Feb 2019 13:08:21 -0800 (PST)
Received: from [192.168.3.111] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83F213F675;
 Wed,  6 Feb 2019 13:08:18 -0800 (PST)
Subject: Re: [PATCH v4 01/12] Documentation: Document arm64 kpti control
To: Jeremy Linton <jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-2-jeremy.linton@arm.com>
 <20190130180247.15ab0577@donnerap.cambridge.arm.com>
 <69fceac6-7e83-7b38-44fb-2c02245f51df@arm.com>
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <7bf0faad-1064-69cb-32fe-1782e6c742d2@arm.com>
Date: Wed, 6 Feb 2019 21:06:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <69fceac6-7e83-7b38-44fb-2c02245f51df@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_130824_710771_BC3D951E 
X-CRM114-Status: GOOD (  17.20  )
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
Cc: stefan.wahren@i2se.com, Jonathan Corbet <corbet@lwn.net>,
 julien.thierry@arm.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, linux-doc@vger.kernel.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 shankerd@codeaurora.org, ykaukab@suse.de, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDYvMDIvMjAxOSAxOToyNCwgSmVyZW15IExpbnRvbiB3cm90ZToKPiBIaSwKPiAKPiAKPiBJ
IGp1c3QgcmVhbGl6ZWQgSSByZXBsaWVkIHRvIHRoaXMgb2ZmLWxpc3QuCj4gCj4gT24gMDEvMzAv
MjAxOSAxMjowMiBQTSwgQW5kcmUgUHJ6eXdhcmEgd3JvdGU6Cj4+IE9uIEZyaSwgMjUgSmFuIDIw
MTkgMTI6MDc6MDAgLTA2MDAKPj4gSmVyZW15IExpbnRvbiA8amVyZW15LmxpbnRvbkBhcm0uY29t
PiB3cm90ZToKPj4KPj4gSGksCj4+Cj4+PiBGb3IgYSB3aGlsZSBBcm02NCBoYXMgYmVlbiBjYXBh
YmxlIG9mIGZvcmNlIGVuYWJsaW5nCj4+PiBvciBkaXNhYmxpbmcgdGhlIGtwdGkgbWl0aWdhdGlv
bnMuIExldHMgbWFrZSBzdXJlIHRoZQo+Pj4gZG9jdW1lbnRhdGlvbiByZWZsZWN0cyB0aGF0Lgo+
Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEplcmVteSBMaW50b24gPGplcmVteS5saW50b25AYXJtLmNv
bT4KPj4+IENjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pgo+Pj4gQ2M6IGxpbnV4
LWRvY0B2Z2VyLmtlcm5lbC5vcmcKPj4+IC0tLQo+Pj4gwqAgRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgfCA2ICsrKysrKwo+Pj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Fk
bWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAo+Pj4gYi9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBpbmRleAo+Pj4gYjc5OWJjZjY3ZDdiLi45NDc1
ZjAyYzc5ZGEgMTAwNjQ0IC0tLQo+Pj4gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5l
bC1wYXJhbWV0ZXJzLnR4dCArKysKPj4+IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJu
ZWwtcGFyYW1ldGVycy50eHQgQEAgLTE5ODIsNiArMTk4MiwxMgo+Pj4gQEAgQnVpbHQgd2l0aCBD
T05GSUdfREVCVUdfS01FTUxFQUtfREVGQVVMVF9PRkY9eSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHRoZSBkZWZhdWx0IGlzIG9mZi4KPj4+IMKgICvCoMKgwqAga3B0aT3CoMKgwqDC
oMKgwqDCoCBbQVJNNjRdIENvbnRyb2wgcGFnZSB0YWJsZSBpc29sYXRpb24gb2YKPj4+IHVzZXIK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFuZCBrZXJuZWwgYWRkcmVzcyBzcGFjZXMuCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEZWZhdWx0OiBlbmFibGVkIG9uIGNvcmVzIHdoaWNo
IG5lZWQKPj4+IG1pdGlnYXRpb24uCj4+Cj4+IFdvdWxkIHRoaXMgYmUgYSBnb29kIHBsYWNlIHRv
IG1lbnRpb24gdGhhdCB3ZSBlbmFibGUgaXQgd2hlbgo+PiBDT05GSUdfUkFORE9NSVpFX0JBU0Ug
aXMgZW5hYmxlZCBhbmQgd2UgaGF2ZSBhIHZhbGlkIGthc2xyX29mZnNldD8gSQo+PiBmb3VuZCB0
aGlzIHNvbWV3aGF0IHN1cnByaXNpbmcsIGFsc28gaXQncyB1bnJlbGF0ZWQgdG8gdGhlCj4+IHZ1
bG5lcmFiaWxpdHkuCj4gCj4gTWF5YmUsIGJ1dCBJIHRlbmQgdG8gdGhpbmsgc2luY2UgdGhpcyBj
b21tYW5kIGxpbmUgZm9yY2VzIGl0IG9uL29mZgo+IHJlZ2FyZGxlc3Mgb2YgUkFORE9NSVpFX0JB
U0UsIHRoYXQgYSBiZXR0ZXIgcGxhY2UgdG8gbWVudGlvbiB0aGF0Cj4gUkFORE9NSVpFX0JBU0Ug
Zm9yY2VzIGtwdGkgb24gaXMgdGhlIEtjb25maWcgb3B0aW9uLgoKVHJ1ZSwga3B0aT0gdGFrZXMg
cHJlY2VkZW5jZSwgaW4gYm90aCB3YXlzLiBEaXNyZWdhcmQgbXkgY29tbWVudCB0aGVuLAp0aGlz
IGlzIGluZGVlZCBub3QgdGhlIHJpZ2h0IHBsYWNlIHRvIG1lbnRpb24gUkFORE9NSVpFX0JBU0Uu
CgpDaGVlcnMsCkFuZHJlLgoKPiAKPiBCVFc6IFRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoaXMuCj4g
Cj4gCj4+Cj4+IENoZWVycywKPj4gQW5kcmUKPj4KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDA6IGZvcmNlIGRpc2FibGVkCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxOiBmb3JjZSBl
bmFibGVkCj4+PiArCj4+PiDCoMKgwqDCoMKgIGt2bS5pZ25vcmVfbXNycz1bS1ZNXSBJZ25vcmUg
Z3Vlc3QgYWNjZXNzZXMgdG8gdW5oYW5kbGVkCj4+PiBNU1JzLiBEZWZhdWx0IGlzIDAgKGRvbid0
IGlnbm9yZSwgYnV0IGluamVjdCAjR1ApCj4+PiDCoCAKPj4KPiAKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
