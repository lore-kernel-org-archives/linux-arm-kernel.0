Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C70DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA6321902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pEQMhDTi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QKSbY6rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA6321902
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s4rVJyK7rljsq/Zy1KnVAf2SSb18lCRYaGiv786wAJs=; b=pEQMhDTirz66QhgWYNLiHe/7D
	iA/3rmo3IBIDj0y/eOd22fhybfe6A6+7W6BYKphy0v7bPIn2nKmnfW7o+XMYMqwqDgARX3hgJQNMs
	AAnvuwo2fXgdcZ5S812O0Y729S/PyI/PRPxoAsncIOiKy6Nhotu9zSUMcULTI5cQdur6v5l67qAc4
	57gmWM2srjA+bufAncmXcXQK0Nyy88an0rnL5zee2pJJPoZLPvaBS9Z1NUF/Fnoj1hy2vFQtrdgtT
	2gZY08heyOuX8j9mGz4ptcIUoN61H+v7h7Nn4WM9sEgBPBInq1zqonlrFLINZiI0DmzaTioxBWmWa
	a4k4twpFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1H8-0000Iq-A8; Tue, 19 Feb 2019 09:01:14 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1H0-0000I8-T7
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:01:12 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c6bc5d10000>; Tue, 19 Feb 2019 01:01:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 19 Feb 2019 01:01:06 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 19 Feb 2019 01:01:06 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 09:01:04 +0000
Subject: Re: [PATCH V6 2/7] clocksource: tegra: add Tegra210 timer support
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Thomas
 Gleixner <tglx@linutronix.de>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-3-josephl@nvidia.com>
 <3849a41f-ab36-d7e0-b2ce-1aa5c4e34aec@linaro.org>
 <87731d61-10f6-0842-a90f-0c78ffba9ef7@nvidia.com>
 <d2aff40c-5ec5-ad66-0d69-a76cdd6c0e9c@linaro.org>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <a9b6e870-258d-492f-1f1d-5d6ceea24795@nvidia.com>
Date: Tue, 19 Feb 2019 17:00:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d2aff40c-5ec5-ad66-0d69-a76cdd6c0e9c@linaro.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1550566865; bh=Of4rckaBTBqLneyOBEUuKLGJJlzZ4kNfxRlShvTeqDk=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=QKSbY6rl1KF1YrRJquZIHwyPTETZqepZduF23SQDETBLYDSJY6OgfT/x6ZKME5iL2
 sP1kk09TW9Z5i9pBiFZBR1+odIGP2fCn9Re2MvhciQ4DayMS8JLjq+pOdnK6HwFjLG
 IQvh7x+GwDXf+s40E1DhVlTOs1RJnzoDmirsKFYndIZ1xkiaSpP0AX77AEss5KP6rV
 azK8h32QzC8bEMfPM9aRNMT/MSBoIlp34IJk7YPQ7p71evnpBg0DSGV6Q2SLaqny+0
 pOxLd2cQgENSmUWtwKiu3f4hCZfhD6cF2WczGRuC+AxHFG/jAuTg5zoe94+RHjDIh5
 iw8k0QE0i6Wsg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_010106_957392_343E723A 
X-CRM114-Status: GOOD (  15.40  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8xOC8xOSA1OjM5IFBNLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToKPiBPbiAxOC8wMi8yMDE5
IDEwOjAxLCBKb3NlcGggTG8gd3JvdGU6Cj4+IE9uIDIvMTUvMTkgMTE6MTQgUE0sIERhbmllbCBM
ZXpjYW5vIHdyb3RlOgo+Pj4gT24gMDEvMDIvMjAxOSAxNzoxNiwgSm9zZXBoIExvIHdyb3RlOgo+
Pj4+IEFkZCBzdXBwb3J0IGZvciB0aGUgVGVncmEyMTAgdGltZXIgdGhhdCBydW5zIGF0IG9zY2ls
bGF0b3IgY2xvY2sKPj4+PiAoVE1SMTAtVE1SMTMpLiBXZSBuZWVkIHRoZXNlIHRpbWVycyB0byB3
b3JrIGFzIGNsb2NrIGV2ZW50IGRldmljZSBhbmQgdG8KPj4+PiByZXBsYWNlIHRoZSBBUk12OCBh
cmNoaXRlY3RlZCB0aW1lciBkdWUgdG8gaXQgY2FuJ3Qgc3Vydml2ZSBhY3Jvc3MgdGhlCj4+Pj4g
cG93ZXIgY3ljbGUgb2YgdGhlIENQVSBjb3JlIG9yIENQVVBPUkVTRVQgc2lnbmFsLiBTbyBpdCBj
YW4ndCBiZSBhCj4+Pj4gd2FrZS11cAo+Pj4+IHNvdXJjZSB3aGVuIENQVSBzdXNwZW5kcyBpbiBw
b3dlciBkb3duIHN0YXRlLgo+Pj4+Cj4+Pj4gQWxzbyBjb252ZXJ0IHRoZSBvcmlnaW5hbCBkcml2
ZXIgdG8gdXNlIHRpbWVyLW9mIEFQSS4KPj4+Pgo+Pj4+IENjOiBEYW5pZWwgTGV6Y2FubyA8ZGFu
aWVsLmxlemNhbm9AbGluYXJvLm9yZz4KPj4+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+Cj4+Pj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPj4+PiBT
aWduZWQtb2ZmLWJ5OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZpZGlhLmNvbT4KPj4+PiBBY2tlZC1i
eTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT4KPj4+PiBBY2tlZC1ieTogSm9u
IEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+Cj4+Pj4gLS0tCj4+Pj4gdjY6Cj4+Pj4gIMKg
ICogcmVmaW5lIHRoZSB0aW1lciBkZWZpbmVzCj4+Pj4gIMKgICogYWRkIGFjayB0YWcgZnJvbSBK
b24uCj4+Pj4gdjU6Cj4+Pj4gIMKgICogYWRkIGFjayB0YWcgZnJvbSBUaGllcnJ5Cj4+Pj4gdjQ6
Cj4+Pj4gIMKgICogbWVyZ2UgdGltZXItdGVncmEyMTAuYyBpbiBwcmV2aW91cyB2ZXJzaW9uIGlu
dG8gdGltZXItdGVncmEyMC5jCj4+Pj4gdjM6Cj4+Pj4gIMKgICogdXNlIHRpbWVyLW9mIEFQSQo+
Pj4+IHYyOgo+Pj4+ICDCoCAqIGFkZCBlcnJvciBjbGVhbi11cCBjb2RlCj4+Pj4gLS0tCltzbmlw
XQo+Pj4+ICvCoMKgwqAgZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkgewo+Pj4+ICvCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgdGltZXJfb2YgKmNwdV90bzsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIGNwdV90byA9IHBlcl9jcHVfcHRyKCZ0ZWdyYV90bywgY3B1KTsKPj4+PiArwqDCoMKgwqDC
oMKgwqAgY3B1X3RvLT5vZl9iYXNlLmJhc2UgPSB0aW1lcl9yZWdfYmFzZSArCj4+Pj4gVElNRVJf
QkFTRV9GT1JfQ1BVKGNwdSk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGNwdV90by0+b2ZfY2xrLnJh
dGUgPSB0aW1lcl9vZl9yYXRlKHRvKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgY3B1X3RvLT5jbGtl
dnQuY3B1bWFzayA9IGNwdW1hc2tfb2YoY3B1KTsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGNwdV90by0+Y2xrZXZ0LmlycSA9Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXJxX29m
X3BhcnNlX2FuZF9tYXAobnAsIElSUV9JRFhfRk9SX0NQVShjcHUpKTsKPj4+PiArwqDCoMKgwqDC
oMKgwqAgaWYgKCFjcHVfdG8tPmNsa2V2dC5pcnEpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwcl9lcnIoIiVzOiBjYW4ndCBtYXAgSVJRIGZvciBDUFUlZFxuIiwKPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZnVuY19fLCBjcHUpOwo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IC1FSU5WQUw7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXQ7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+PiArCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGlycV9zZXRfc3RhdHVzX2ZsYWdzKGNwdV90by0+Y2xrZXZ0LmlycSwgSVJRX05P
QVVUT0VOKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gcmVxdWVzdF9pcnEoY3B1X3RvLT5j
bGtldnQuaXJxLCB0ZWdyYV90aW1lcl9pc3IsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSVJRRl9USU1FUiB8IElSUUZfTk9CQUxBTkNJTkcsCj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1X3RvLT5jbGtldnQubmFtZSwgJmNwdV90by0+
Y2xrZXZ0KTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkgewo+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHByX2VycigiJXM6IGNhbm5vdCBzZXR1cCBpcnEgJWQgZm9yIENQVSVkXG4i
LAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIGNwdV90by0+
Y2xrZXZ0LmlycSwgY3B1KTsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAtRUlO
VkFMOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2lycTsKPj4+PiArwqDC
oMKgwqDCoMKgwqAgfQo+Pj4+ICvCoMKgwqAgfQo+Pj4KPj4+IFlvdSBzaG91bGQgY29uZmlndXJl
IHRoZSB0aW1lciBpbiB0aGUgdGVncmFfdGltZXJfc2V0dXAoKSBmdW5jdGlvbgo+Pj4gaW5zdGVh
ZCBvZiB1c2luZyB0aGlzIGNwdSBsb29wLgo+Pj4KPj4KPj4gSSB0aGluayBJIHN0aWxsIG5lZWQg
dG8gbGVhdmUgJ2lycV9vZl9wYXJzZV9hbmRfbWFwJyBhbmQgJ3JlcXVlc3RfaXJxJwo+PiBoZXJl
LiBJcyB0aGF0IG9rPwo+IAo+IFBlcmhhcHMgeW91IGNhbiBzdG9yZSB0aGUgbnAgcG9pbnRlciBp
biB0aGUgcHJpdmF0ZSBkYXRhIHN0cnVjdHVyZSBvZgo+IHRpbWVyLW9mIGFuZCBsZXQgdGhlIHRp
bWVyX29mIEFQSSB0byByZXRyaWV2ZSB0aGUgaXJxIGluIHRoZSBjcHVocAo+IGNhbGxiYWNrcy4K
PiAKPiBpcnFfb2ZfcGFyc2VfYW5kX21hcCB3aWxsIGJlIGNhbGxlZCBieSB0aW1lci1vZi4KPiAK
PiBJJ20gbm90IHN1cmUgaXJxX3NldF9zdGF0dXNfZmxhZ3MgcmVhbGx5IG9wZXJhdGVzIG9uIHRo
ZSBpcnEgYmVjYXVzZSBpdAo+IGlzIGNhbGxlZCBhZnRlciByZXF1ZXN0X2lycS4KPiAKCkkgZGlk
IHNvbWUgZXhwZXJpbWVudHMgdG9kYXkuIFRoZSAnaXJxX29mX3BhcnNlX2FuZF9tYXAnLCAncmVx
dWVzdF9pcnEnIAphbmQgJ3NldHVwX2lycScgYXJlIG5vdCBhYmxlIHRvIHJ1biBpbiB0aGUgYXRv
bWljIHNlY3Rpb24gdGhhdCAKdGVncmFfdGltZXJfc2V0dXAgd291bGQgYmUgdHJpZ2dlcmVkIGlu
LgoKU28gSSB0aGluayBJIHN0aWxsIG5lZWQgdG8gbGVhdmUgdGhlIElSUSBjb25maWd1cmF0aW9u
IGNvZGUgaGVyZSBpbiB0aGUgCmxvb3AuIFNob3VsZCBJIG1vdmUgb3RoZXJzIHRvICd0ZWdyYV90
aW1lcl9zZXR1cCcgb3IganVzdCBrZWVwIGFzIHRoZSAKc2FtZSBpbiB0aGlzIHBhdGNoPwoKVGhh
bmtzLApKb3NlcGgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
