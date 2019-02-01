Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EB9C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:49:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38662086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Smw3oIQr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YHQSdVV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38662086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qAcTJVllUf+vxPk+a0GwDAS75ReeSTJ5vjKx/YvuFq0=; b=Smw3oIQrI1ewUc
	3QVQK8rOvWUR3GVQEd/0NlfYMok2mRXkDLJIKiGi6TJRWQUgCjA7Mj6eK/eexnLK91rxYzwwVh5Dw
	S/oiggwkPa6DKrpECcWWjqfRvvqlFLFCn0iyoO2OXfqZD4xk0PAW8fN9gEFDJ+84jdM6kcnY5e/2S
	gmDRYvtXzmx/XT8lyTUB1vncmsDtFFHln8bNUgYk8XtOhwqlALsw5SLe/4eyLw/2HNwPbtJkPzNqc
	vTEoejkO3jLdZ/L5B/tl3Q49cRP3i6D/nwX6EpXXda56j6Rj+1OXfHDDOCBZymvGvyLHeuWQiC6Kt
	t7f3fKlJCBSLvpgsW2nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb4J-0001AZ-KH; Fri, 01 Feb 2019 15:49:27 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpaz0-0003Eg-Nd
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:44:39 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c5469130000>; Fri, 01 Feb 2019 07:43:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 07:43:57 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 01 Feb 2019 07:43:57 -0800
Received: from [10.26.11.142] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 15:43:54 +0000
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <5490ad66-7d20-7093-7025-1d0ec8da6dec@nvidia.com>
 <3c9b86ba-32dd-76b2-9a51-6cd86782cadf@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ab418999-a45c-bd9c-b9bd-5c382e86d26c@nvidia.com>
Date: Fri, 1 Feb 2019 15:43:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3c9b86ba-32dd-76b2-9a51-6cd86782cadf@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549035795; bh=7tWvPUVcFfbkX+cD1EPvPlm73UTCxWv69EygudXiKLA=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=YHQSdVV3fbg60DbOV2yNY9pFKY8jaH+z+MI0vFjmgPrTIFwL0y/df6vTLWv5SlDJi
 cw4PKgb9JvndfcI8Mno52NNUjokbo5k32Dmn1mXEpbIzf3pBDlb0hLq9nUlvi2mOdB
 +MlFH2SfkwLRzDnN6IbyChD3f/7//nK+/husbLBgUA3V1mzvq9qVBtwNlkLgmD+i3b
 2eFHkIDFKTEwjYe3gqgTG6wHvTz8pcDPXERZ/q+wcwzLDpfNR2AmJaOkhR6OmhXfJL
 wixfZRDHJSq5RF/h0OElUUTpOWDV5YQuYdqnjpXtsXndmgHski21iyOveFECONo/XB
 FYbfoal1Zh3kA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074359_428040_8C1A1706 
X-CRM114-Status: GOOD (  16.63  )
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

CgpPbiAwMS8wMi8yMDE5IDE0OjM5LCBKb3NlcGggTG8gd3JvdGU6Cj4gT24gMi8xLzE5IDg6NDQg
UE0sIEpvbiBIdW50ZXIgd3JvdGU6Cj4+Cj4+IE9uIDAxLzAyLzIwMTkgMDM6MzYsIEpvc2VwaCBM
byB3cm90ZToKPj4+IEFkZCBzdXBwb3J0IGZvciB0aGUgVGVncmEyMTAgdGltZXIgdGhhdCBydW5z
IGF0IG9zY2lsbGF0b3IgY2xvY2sKPj4+IChUTVIxMC1UTVIxMykuIFdlIG5lZWQgdGhlc2UgdGlt
ZXJzIHRvIHdvcmsgYXMgY2xvY2sgZXZlbnQgZGV2aWNlIGFuZCB0bwo+Pj4gcmVwbGFjZSB0aGUg
QVJNdjggYXJjaGl0ZWN0ZWQgdGltZXIgZHVlIHRvIGl0IGNhbid0IHN1cnZpdmUgYWNyb3NzIHRo
ZQo+Pj4gcG93ZXIgY3ljbGUgb2YgdGhlIENQVSBjb3JlIG9yIENQVVBPUkVTRVQgc2lnbmFsLiBT
byBpdCBjYW4ndCBiZSBhCj4+PiB3YWtlLXVwCj4+PiBzb3VyY2Ugd2hlbiBDUFUgc3VzcGVuZHMg
aW4gcG93ZXIgZG93biBzdGF0ZS4KPj4+Cj4+PiBBbHNvIGNvbnZlcnQgdGhlIG9yaWdpbmFsIGRy
aXZlciB0byB1c2UgdGltZXItb2YgQVBJLgo+Pgo+PiBJdCBtYXkgaGF2ZSBiZWVuIG5pY2UgdG8g
c3BsaXQgdGhpcyBpbnRvIDIgcGF0Y2hlcyB0byBtYWtlIGl0IGVhc2llciB0bwo+PiBzZWUgd2hh
dCBpcyBnb2luZyBvbiBidXQgbm90IGEgYmlnIGRlYWwuCj4+Cj4+PiBDYzogRGFuaWVsIExlemNh
bm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+Cj4+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0
Z2x4QGxpbnV0cm9uaXguZGU+Cj4+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+
Pj4gU2lnbmVkLW9mZi1ieTogSm9zZXBoIExvIDxqb3NlcGhsQG52aWRpYS5jb20+Cj4+PiBBY2tl
ZC1ieTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT4KPj4+IC0tLQo+Pj4gdjU6
Cj4+PiDCoCAqIGFkZCBhY2sgdGFnIGZyb20gVGhpZXJyeQo+Pj4gdjQ6Cj4+PiDCoCAqIG1lcmdl
IHRpbWVyLXRlZ3JhMjEwLmMgaW4gcHJldmlvdXMgdmVyc2lvbiBpbnRvIHRpbWVyLXRlZ3JhMjAu
Ywo+Pj4gdjM6Cj4+PiDCoCAqIHVzZSB0aW1lci1vZiBBUEkKPj4+IHYyOgo+Pj4gwqAgKiBhZGQg
ZXJyb3IgY2xlYW4tdXAgY29kZQo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2Nsb2Nrc291cmNlL0tj
b25maWfCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKy0KPj4+IMKgIGRyaXZlcnMvY2xvY2tzb3Vy
Y2UvdGltZXItdGVncmEyMC5jIHwgMzY5ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPj4+
IMKgIGluY2x1ZGUvbGludXgvY3B1aG90cGx1Zy5owqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEg
Kwo+Pj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAyNzIgaW5zZXJ0aW9ucygrKSwgMTAwIGRlbGV0aW9u
cygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL0tjb25maWcgYi9k
cml2ZXJzL2Nsb2Nrc291cmNlL0tjb25maWcKPj4+IGluZGV4IGE5ZTI2ZjZhODFhMS4uNmFmNzg1
MzRhMjg1IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnCj4+PiAr
KysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL0tjb25maWcKPj4+IEBAIC0xMzEsNyArMTMxLDcgQEAg
Y29uZmlnIFNVTjVJX0hTVElNRVIKPj4+IMKgIGNvbmZpZyBURUdSQV9USU1FUgo+Pj4gwqDCoMKg
wqDCoCBib29sICJUZWdyYSB0aW1lciBkcml2ZXIiIGlmIENPTVBJTEVfVEVTVAo+Pj4gwqDCoMKg
wqDCoCBzZWxlY3QgQ0xLU1JDX01NSU8KPj4+IC3CoMKgwqAgZGVwZW5kcyBvbiBBUk0KPj4+ICvC
oMKgwqAgc2VsZWN0IFRJTUVSX09GCj4+PiDCoMKgwqDCoMKgIGhlbHAKPj4+IMKgwqDCoMKgwqDC
oMKgIEVuYWJsZXMgc3VwcG9ydCBmb3IgdGhlIFRlZ3JhIGRyaXZlci4KPj4+IMKgIGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXRlZ3JhMjAuYwo+Pj4gYi9kcml2ZXJzL2Ns
b2Nrc291cmNlL3RpbWVyLXRlZ3JhMjAuYwo+Pj4gaW5kZXggNDI5Mzk0M2Y0ZTJiLi45NmE4MDkz
NDFjOWIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXRlZ3JhMjAu
Ywo+Pj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci10ZWdyYTIwLmMKPj4+IEBAIC0x
NSwyMSArMTUsMjQgQEAKPj4+IMKgwqAgKgo+Pj4gwqDCoCAqLwo+Pj4gwqAgLSNpbmNsdWRlIDxs
aW51eC9pbml0Lmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgo+Pj4gKyNpbmNsdWRlIDxs
aW51eC9jbG9ja2NoaXBzLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L2NwdS5oPgo+Pj4gKyNpbmNs
dWRlIDxsaW51eC9jcHVtYXNrLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+Cj4+PiDC
oCAjaW5jbHVkZSA8bGludXgvZXJyLmg+Cj4+PiAtI2luY2x1ZGUgPGxpbnV4L3RpbWUuaD4KPj4+
IMKgICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KPj4+IC0jaW5jbHVkZSA8bGludXgvaXJx
Lmg+Cj4+PiAtI2luY2x1ZGUgPGxpbnV4L2Nsb2NrY2hpcHMuaD4KPj4+IC0jaW5jbHVkZSA8bGlu
dXgvY2xvY2tzb3VyY2UuaD4KPj4+IC0jaW5jbHVkZSA8bGludXgvY2xrLmg+Cj4+PiAtI2luY2x1
ZGUgPGxpbnV4L2lvLmg+Cj4+PiDCoCAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPgo+Pj4g
wqAgI2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPgo+Pj4gLSNpbmNsdWRlIDxsaW51eC9zY2hlZF9j
bG9jay5oPgo+Pj4gLSNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgo+Pj4gKyNpbmNsdWRlIDxsaW51
eC9wZXJjcHUuaD4KPj4+ICsjaW5jbHVkZSA8bGludXgvc3lzY29yZV9vcHMuaD4KPj4+ICsjaW5j
bHVkZSA8bGludXgvdGltZS5oPgo+Pj4gKwo+Pj4gKyNpbmNsdWRlICJ0aW1lci1vZi5oIgo+Pj4g
wqAgKyNpZmRlZiBDT05GSUdfQVJNCj4+PiDCoCAjaW5jbHVkZSA8YXNtL21hY2gvdGltZS5oPgo+
Pj4gKyNlbmRpZgo+Pj4gwqAgwqAgI2RlZmluZSBSVENfU0VDT05EU8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMHgwOAo+Pj4gwqAgI2RlZmluZSBSVENfU0hBRE9XX1NFQ09ORFPCoMKgwqDCoCAweDBj
Cj4+PiBAQCAtNDMsNzAgKzQ2LDE0NyBAQAo+Pj4gwqAgI2RlZmluZSBUSU1FUjJfQkFTRSAweDgK
Pj4+IMKgICNkZWZpbmUgVElNRVIzX0JBU0UgMHg1MAo+Pj4gwqAgI2RlZmluZSBUSU1FUjRfQkFT
RSAweDU4Cj4+PiAtCj4+PiAtI2RlZmluZSBUSU1FUl9QVFYgMHgwCj4+PiAtI2RlZmluZSBUSU1F
Ul9QQ1IgMHg0Cj4+PiAtCj4+PiArI2RlZmluZSBUSU1FUjEwX0JBU0UgMHg5MAo+Pj4gKwo+Pj4g
KyNkZWZpbmUgVElNRVJfUFRWwqDCoMKgwqDCoMKgwqAgMHgwCj4+PiArI2RlZmluZSBUSU1FUl9Q
VFZfRU7CoMKgwqDCoMKgwqDCoCBCSVQoMzEpCj4+PiArI2RlZmluZSBUSU1FUl9QVFZfUEVSwqDC
oMKgwqDCoMKgwqAgQklUKDMwKQo+Pj4gKyNkZWZpbmUgVElNRVJfUENSwqDCoMKgwqDCoMKgwqAg
MHg0Cj4+PiArI2RlZmluZSBUSU1FUl9QQ1JfSU5UUl9DTFLCoMKgwqAgQklUKDMwKQo+Pj4gKwo+
Pj4gKyNpZmRlZiBDT05GSUdfQVJNCj4+PiArI2RlZmluZSBUSU1FUl9CQVNFIFRJTUVSM19CQVNF
Cj4+PiArI2Vsc2UKPj4+ICsjZGVmaW5lIFRJTUVSX0JBU0UgVElNRVIxMF9CQVNFCj4+PiArI2Vu
ZGlmCj4+PiArI2RlZmluZSBUSU1FUjEwX0lSUV9JRFjCoMKgwqDCoMKgwqDCoCAxMAo+Pj4gKyNk
ZWZpbmUgVElNRVJfRk9SX0NQVShjcHUpIChUSU1FUl9CQVNFICsgKGNwdSkgKiA4KQo+Pj4gKyNk
ZWZpbmUgSVJRX0lEWF9GT1JfQ1BVKGNwdSnCoMKgwqAgKFRJTUVSMTBfSVJRX0lEWCArIGNwdSkK
Pj4KPj4gVElNRVIxMF9JUlFfSURYIGFuZCBJUlFfSURYX0ZPUl9DUFUgYXJlIG9ubHkgYXBwbGlj
YWJsZSB0byBBUk02NCBhbmQgc28KPj4gd2Ugc2hvdWxkIHByb2JhYmx5IG5vdCBkZWZpbmVkIGZv
ciBBUk0gdG8gYXZvaWQgYW55IGNvbmZ1c2lvbi4KPiBPa2F5LCB3aWxsIGRvLgo+Pgo+PiBGdXJ0
aGVybW9yZSwgYSBsb3Qgb2YgdGhlc2UgVElNRVJ4X0JBU0UgZGVmaW5pdGlvbnMgYXJlIHVudXNl
ZCBBRkFJQ1QuCj4+IFdvdWxkIGJlIGdvb2QgdG8gZ2V0IHJpZCBvZiB0aGVzZS4KPiAKPiBPa2F5
Lgo+Pgo+PiBNYXliZSB3ZSBjb3VsZCBqdXN0IGhhdmUgLi4uCj4+Cj4+IMKgICsjaWZkZWYgQ09O
RklHX0FSTQo+PiDCoCArI2RlZmluZSBUSU1FUl9DUFUwIDMKPj4gwqAgKyNlbHNlCj4+IMKgICsj
ZGVmaW5lIFRJTUVSX0NQVTAgMTAKPj4gwqAgKyNlbmRpZgo+PiDCoCArI2RlZmluZSBUSU1FUl9C
QVNFX0ZPUl9DUFUoY3B1KSAoKFRJTUVSX0NQVTAgKyBjcHUpICogOCkKPj4gwqAgKyNkZWZpbmUg
VElNRVJfRk9SX0NQVShjcHUpIChUSU1FUl9DUFUwICsgY3B1KQo+Pgo+IFRoaXMgY2FuJ3QgZ2V0
IHRoZSB0aW1lciBiYXNlIGFkZHJlc3MuIEkgdGhpbmsgeW91IG1lYW4gLi4uCj4gCj4gKyNpZmRl
ZiBDT05GSUdfQVJNCj4gKyNkZWZpbmUgVElNRVJfQ1BVMCAweDUwIC8qIFRJTUVSMyAqLwo+ICsj
ZWxzZQo+ICsjZGVmaW5lIFRJTUVSX0NQVTAgMHg5MCAvKiBUSU1FUjEwICovCj4gKyNlbmRpZgo+
ICsjZGVmaW5lIFRJTUVSX0JBU0VfRk9SX0NQVShjcHUpIChUSU1FUl9DUFUwICsgKGNwdSkgKiA4
KQoKQWggSSBzZWUuCgo+IFRoaXMgZG9lc24ndCBuZWVkLgo+ICsjZGVmaW5lIFRJTUVSX0ZPUl9D
UFUoY3B1KSAoVElNRVJfQ1BVMCArIGNwdSkKSG93IGNvbWU/IERvbid0IHlvdSBzdGlsbCBuZWVk
IHRvIGtub3cgdGhlIHRpbWVyIGluZGV4IGZvciBhIGdpdmVuIENQVT8KCkNoZWVycwpKb24KCi0t
IApudnB1YmxpYwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
