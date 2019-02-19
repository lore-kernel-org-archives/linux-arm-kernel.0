Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B674C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5C521738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="okWE7k2+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQOXdal+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5C521738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u55Pcf7lyGVeVWELi34LzbhG65ty8Y2z/d43dRy1yqk=; b=okWE7k2+dNJKIy
	aFHmEi5E4pooLEIaVvYWW0RbGHw6+jBq0z2konEvK7WihmvtytxoBXVW1fVsE4M1G2VoeKERjhgY2
	0xJ7jxf4SOmThMt47hMR70DQ3kKGmB5e9sP3hnrmrncYdjXj47eoaYcDuIRmIxt0DxQAFpEt6oC6T
	0I9eMsRVuJcZ8uZAx4mdA2FGjUC1qn5Hj66jyk6IX7KUhByShaRRCGdU8luQm0UAX6BPjDX+r/OK9
	s6vtOzUH3PMU7fSHHMxj75Qcx8v3vPKXoJRMIScSP3VLYcOhwilxXkQXzoHHVMFIRp3r3gte6zmBQ
	R3AzWKBRfaPr5yCesNtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1m2-0000SM-9G; Tue, 19 Feb 2019 09:33:10 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1lz-0000Rw-62
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:33:09 +0000
Received: by mail-wm1-x344.google.com with SMTP id y185so1712257wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 01:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mQxIo1ZMyjW0GP38yhE3IEsI0SGeFAkz1y9D+vI6hL8=;
 b=cQOXdal+gTPLY+nk9MW6ArpleXVYPe7y5KZA5QGsKOiPUj1jMo05IvxLNBN53Xd7HW
 3gBjGD5EMoqw7fggNpZOkgOxxiipAQr2SdbDJ9u9E8Jlgqq3C+fNJfaARhqThyFF7fqm
 oPzSlW5APz1Q3pBFIBn8eV7a+b2AGfmJeqtyAet2bUpovWg0iBLlQkF/nptyPk9rP/Zo
 fuPbzrUUnGotXuYrq/lvx+bWygA+IfdSV7Wv/XyGaIEbr9On8WrpFFPmkgNNUwIJiyXm
 X7AgLCsB8eykT40OgurrwzE8rwdlZbJP3QoM7frr5PqGp3KOmEu1GI/uMKYmnoIWbVV6
 H75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mQxIo1ZMyjW0GP38yhE3IEsI0SGeFAkz1y9D+vI6hL8=;
 b=CCIiO3YnM+JEfO+H72vf0mw6OS1t0vjueQ52ZGw842y9sbl0YoGLl5vM5V92/nE6QP
 lbRgBryORzILIk6mY7zpR0Xdl4/F1Gvs21MQoAMpGsWemhvI1vHocvdmgXhEUs/AgKsx
 fdVhWGgd3nDXVz03H+vZi0QtwMkDO2TONT/d2vECbP3HpZJCGOn+Q4HYrLZO4+JrP+wq
 Yfj0TRUX3JpYH+G/gOkxwmZWGp/JxYDEEgoKTE11h02+aaz9ae1cfCe+yf+xOvpY3A1W
 NZnuBtq5QXlxGdoYdf9vbPrjLWMX4V3uHyl6QDWSS/oZfC3WzKQpGNs/QeEqq7RH8Rml
 FUdA==
X-Gm-Message-State: AHQUAuYlerzHc65CobVkZampT9J9CFJXupHnyz5QZIojy26h80kruBhT
 qKDNNmonf6A4LuBPhWbOC5ZLNA==
X-Google-Smtp-Source: AHgI3IadpDilMyX4X68EM/JSp5nV/VI8q19THA2qajSiUsSq8Yi5TagNKfYFhzyqJK5LoxChW6xjRg==
X-Received: by 2002:a1c:80d6:: with SMTP id b205mr2217949wmd.109.1550568785168; 
 Tue, 19 Feb 2019 01:33:05 -0800 (PST)
Received: from [192.168.0.41] (175.247.136.77.rev.sfr.net. [77.136.247.175])
 by smtp.googlemail.com with ESMTPSA id c65sm2375871wma.24.2019.02.19.01.33.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 01:33:04 -0800 (PST)
Subject: Re: [PATCH V6 2/7] clocksource: tegra: add Tegra210 timer support
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-3-josephl@nvidia.com>
 <3849a41f-ab36-d7e0-b2ce-1aa5c4e34aec@linaro.org>
 <87731d61-10f6-0842-a90f-0c78ffba9ef7@nvidia.com>
 <d2aff40c-5ec5-ad66-0d69-a76cdd6c0e9c@linaro.org>
 <a9b6e870-258d-492f-1f1d-5d6ceea24795@nvidia.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0690a2a2-06e6-62ee-0a5d-dda008fb7fef@linaro.org>
Date: Tue, 19 Feb 2019 10:33:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a9b6e870-258d-492f-1f1d-5d6ceea24795@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_013307_232641_E7FFC4A8 
X-CRM114-Status: GOOD (  20.22  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTkvMDIvMjAxOSAxMDowMCwgSm9zZXBoIExvIHdyb3RlOgo+IE9uIDIvMTgvMTkgNTozOSBQ
TSwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4+IE9uIDE4LzAyLzIwMTkgMTA6MDEsIEpvc2VwaCBM
byB3cm90ZToKPj4+IE9uIDIvMTUvMTkgMTE6MTQgUE0sIERhbmllbCBMZXpjYW5vIHdyb3RlOgo+
Pj4+IE9uIDAxLzAyLzIwMTkgMTc6MTYsIEpvc2VwaCBMbyB3cm90ZToKPj4+Pj4gQWRkIHN1cHBv
cnQgZm9yIHRoZSBUZWdyYTIxMCB0aW1lciB0aGF0IHJ1bnMgYXQgb3NjaWxsYXRvciBjbG9jawo+
Pj4+PiAoVE1SMTAtVE1SMTMpLiBXZSBuZWVkIHRoZXNlIHRpbWVycyB0byB3b3JrIGFzIGNsb2Nr
IGV2ZW50IGRldmljZQo+Pj4+PiBhbmQgdG8KPj4+Pj4gcmVwbGFjZSB0aGUgQVJNdjggYXJjaGl0
ZWN0ZWQgdGltZXIgZHVlIHRvIGl0IGNhbid0IHN1cnZpdmUgYWNyb3NzIHRoZQo+Pj4+PiBwb3dl
ciBjeWNsZSBvZiB0aGUgQ1BVIGNvcmUgb3IgQ1BVUE9SRVNFVCBzaWduYWwuIFNvIGl0IGNhbid0
IGJlIGEKPj4+Pj4gd2FrZS11cAo+Pj4+PiBzb3VyY2Ugd2hlbiBDUFUgc3VzcGVuZHMgaW4gcG93
ZXIgZG93biBzdGF0ZS4KPj4+Pj4KPj4+Pj4gQWxzbyBjb252ZXJ0IHRoZSBvcmlnaW5hbCBkcml2
ZXIgdG8gdXNlIHRpbWVyLW9mIEFQSS4KPj4+Pj4KPj4+Pj4gQ2M6IERhbmllbCBMZXpjYW5vIDxk
YW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgo+Pj4+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+Cj4+Pj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBMbyA8am9zZXBobEBudmlkaWEuY29tPgo+Pj4+PiBB
Y2tlZC1ieTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT4KPj4+Pj4gQWNrZWQt
Ynk6IEpvbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gdjY6
Cj4+Pj4+IMKgwqAgKiByZWZpbmUgdGhlIHRpbWVyIGRlZmluZXMKPj4+Pj4gwqDCoCAqIGFkZCBh
Y2sgdGFnIGZyb20gSm9uLgo+Pj4+PiB2NToKPj4+Pj4gwqDCoCAqIGFkZCBhY2sgdGFnIGZyb20g
VGhpZXJyeQo+Pj4+PiB2NDoKPj4+Pj4gwqDCoCAqIG1lcmdlIHRpbWVyLXRlZ3JhMjEwLmMgaW4g
cHJldmlvdXMgdmVyc2lvbiBpbnRvIHRpbWVyLXRlZ3JhMjAuYwo+Pj4+PiB2MzoKPj4+Pj4gwqDC
oCAqIHVzZSB0aW1lci1vZiBBUEkKPj4+Pj4gdjI6Cj4+Pj4+IMKgwqAgKiBhZGQgZXJyb3IgY2xl
YW4tdXAgY29kZQo+Pj4+PiAtLS0KPiBbc25pcF0KPj4+Pj4gK8KgwqDCoCBmb3JfZWFjaF9wb3Nz
aWJsZV9jcHUoY3B1KSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGltZXJfb2YgKmNw
dV90bzsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgY3B1X3RvID0gcGVyX2NwdV9wdHIo
JnRlZ3JhX3RvLCBjcHUpOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgY3B1X3RvLT5vZl9iYXNlLmJh
c2UgPSB0aW1lcl9yZWdfYmFzZSArCj4+Pj4+IFRJTUVSX0JBU0VfRk9SX0NQVShjcHUpOwo+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgY3B1X3RvLT5vZl9jbGsucmF0ZSA9IHRpbWVyX29mX3JhdGUodG8p
Owo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgY3B1X3RvLT5jbGtldnQuY3B1bWFzayA9IGNwdW1hc2tf
b2YoY3B1KTsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgY3B1X3RvLT5jbGtldnQuaXJx
ID0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXJxX29mX3BhcnNlX2FuZF9tYXAobnAs
IElSUV9JRFhfRk9SX0NQVShjcHUpKTsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghY3B1X3Rv
LT5jbGtldnQuaXJxKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2VycigiJXM6
IGNhbid0IG1hcCBJUlEgZm9yIENQVSVkXG4iLAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIF9fZnVuY19fLCBjcHUpOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXQgPSAtRUlOVkFMOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91
dDsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+Pj4gKwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
aXJxX3NldF9zdGF0dXNfZmxhZ3MoY3B1X3RvLT5jbGtldnQuaXJxLCBJUlFfTk9BVVRPRU4pOwo+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gcmVxdWVzdF9pcnEoY3B1X3RvLT5jbGtldnQuaXJx
LCB0ZWdyYV90aW1lcl9pc3IsCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIElSUUZfVElNRVIgfCBJUlFGX05PQkFMQU5DSU5HLAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjcHVfdG8tPmNsa2V2dC5uYW1lLCAmY3B1X3RvLT5jbGtldnQp
Owo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkgewo+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwcl9lcnIoIiVzOiBjYW5ub3Qgc2V0dXAgaXJxICVkIGZvciBDUFUlZFxuIiwKPj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2Z1bmNfXywgY3B1X3RvLT5jbGtl
dnQuaXJxLCBjcHUpOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAtRUlOVkFM
Owo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9pcnE7Cj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCB9Cj4+Pj4+ICvCoMKgwqAgfQo+Pj4+Cj4+Pj4gWW91IHNob3VsZCBjb25maWd1
cmUgdGhlIHRpbWVyIGluIHRoZSB0ZWdyYV90aW1lcl9zZXR1cCgpIGZ1bmN0aW9uCj4+Pj4gaW5z
dGVhZCBvZiB1c2luZyB0aGlzIGNwdSBsb29wLgo+Pj4+Cj4+Pgo+Pj4gSSB0aGluayBJIHN0aWxs
IG5lZWQgdG8gbGVhdmUgJ2lycV9vZl9wYXJzZV9hbmRfbWFwJyBhbmQgJ3JlcXVlc3RfaXJxJwo+
Pj4gaGVyZS4gSXMgdGhhdCBvaz8KPj4KPj4gUGVyaGFwcyB5b3UgY2FuIHN0b3JlIHRoZSBucCBw
b2ludGVyIGluIHRoZSBwcml2YXRlIGRhdGEgc3RydWN0dXJlIG9mCj4+IHRpbWVyLW9mIGFuZCBs
ZXQgdGhlIHRpbWVyX29mIEFQSSB0byByZXRyaWV2ZSB0aGUgaXJxIGluIHRoZSBjcHVocAo+PiBj
YWxsYmFja3MuCj4+Cj4+IGlycV9vZl9wYXJzZV9hbmRfbWFwIHdpbGwgYmUgY2FsbGVkIGJ5IHRp
bWVyLW9mLgo+Pgo+PiBJJ20gbm90IHN1cmUgaXJxX3NldF9zdGF0dXNfZmxhZ3MgcmVhbGx5IG9w
ZXJhdGVzIG9uIHRoZSBpcnEgYmVjYXVzZSBpdAo+PiBpcyBjYWxsZWQgYWZ0ZXIgcmVxdWVzdF9p
cnEuCj4+Cj4gCj4gSSBkaWQgc29tZSBleHBlcmltZW50cyB0b2RheS4gVGhlICdpcnFfb2ZfcGFy
c2VfYW5kX21hcCcsICdyZXF1ZXN0X2lycScKPiBhbmQgJ3NldHVwX2lycScgYXJlIG5vdCBhYmxl
IHRvIHJ1biBpbiB0aGUgYXRvbWljIHNlY3Rpb24gdGhhdAo+IHRlZ3JhX3RpbWVyX3NldHVwIHdv
dWxkIGJlIHRyaWdnZXJlZCBpbi4KCk9oIC4uLiByaWdodAoKPiBTbyBJIHRoaW5rIEkgc3RpbGwg
bmVlZCB0byBsZWF2ZSB0aGUgSVJRIGNvbmZpZ3VyYXRpb24gY29kZSBoZXJlIGluIHRoZQo+IGxv
b3AuIFNob3VsZCBJIG1vdmUgb3RoZXJzIHRvICd0ZWdyYV90aW1lcl9zZXR1cCcgb3IganVzdCBr
ZWVwIGFzIHRoZQo+IHNhbWUgaW4gdGhpcyBwYXRjaD8KCkZvciB0aGUgbW9tZW50LCBJIHN1Z2dl
c3QgeW91IGtlZXAgaXQgYXMgaXQgd2FzIGluaXRpYWxseS4KCkEgc2lkZSBub3RlLCBub3QgcmVs
YXRlZCB0byB0aGlzIGNvbW1lbnQgYnV0IGFib3V0IHRoZSBEWU5JUlEgZmxhZy4KQWN0dWFsbHkg
aXQgaXMgbm90IG5lZWRlZCBiZWNhdXNlIHRoZSB0aW1lcnMgYXJlIHBlci1jcHUuCgpUaGFua3MK
CiAgLS0gRGFuaWVsCgoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDi
lIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0
dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3
aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcv
bGluYXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
