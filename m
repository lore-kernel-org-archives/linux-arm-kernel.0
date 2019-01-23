Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B3C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:43:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40CF21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qpkTW9wE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="T+xOpF1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40CF21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:From:Date:
	MIME-Version:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bHHc3lAXfGQjczMSxxaAuOQ3SJhnKveTE+xta+cboBo=; b=qpkTW9wEThLTiZsgqJGun3oc8
	DEu1TC1Zw5bRjD29omgS1dil1Y0SIpUFc+M6Onm58sUXrMDWBwsCx0e6BTMIblX7DmXKKk5fZ4ASE
	GfhLpi0Yk8SUk9+OzSuzCINGqqqItJvdL2P2O8cLe/H07DzTdnFNMknmHOAgAvDlKS3k/bEtyRAoe
	2osxRNzS2UjP+fsQHu0xYvVOfgM2zaRaovPqdRCwhPqi9UloUJCStA/ebzs9Kgp2t+N5p2yb6Zn5N
	iNjv1xId/TsNf3FEt2myiFsaMVLcluwpiSKZctt0jQjL5iIhyg/mh5bPtBH6ZRdNwIf3yHTxYR/Kc
	UILRtoHBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKgC-00010Q-6Z; Wed, 23 Jan 2019 15:43:04 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKg8-0000yZ-QQ
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:43:02 +0000
Received: by node.akkea.ca (Postfix, from userid 33)
 id C26884E204B; Wed, 23 Jan 2019 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548258176; bh=hpydxlUbPNVTFjaIeaR+9n70cc5NfFN03bvjQEo1UbU=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References;
 b=T+xOpF1cXj7CVamez22PIzRepOMR9AHCkbPhlxwb7DeHfTYFjDH6nCIrfMbQLaTmc
 6G5vEFFUOJuhnl8hyLebeHO5Xp3hlPXeqiipnX0qXaJTH/POHSuY3GUGoX9NATuDUj
 7IS8xQFtsCqYEKpvUEKuMS7zt3ki9NWIvxXVy5Ug=
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v3 4/5] dma: imx-sdma: add an index for imx8mq multi sdma
 devices
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Date: Wed, 23 Jan 2019 08:42:56 -0700
From: Angus Ainslie <angus@akkea.ca>
In-Reply-To: <1548257514.28802.3.camel@pengutronix.de>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190123152310.11680-1-angus@akkea.ca>
 <20190123152310.11680-5-angus@akkea.ca>
 <1548257514.28802.3.camel@pengutronix.de>
Message-ID: <d5f73096cf62ef379e27c11e024c52ff@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_074301_078450_DB60C41C 
X-CRM114-Status: GOOD (  18.24  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMS0yMyAwODozMSwgTHVjYXMgU3RhY2ggd3JvdGU6Cj4gSGkgQW5ndXMsCj4gCj4g
QW0gTWl0dHdvY2gsIGRlbiAyMy4wMS4yMDE5LCAwODoyMyAtMDcwMCBzY2hyaWViIEFuZ3VzIEFp
bnNsaWUgCj4gKFB1cmlzbSk6Cj4+IE9uIGkubXg4bXEsIHRoZXJlIGFyZSB0d28gc2RtYSBpbnN0
YW5jZXMsIGFuZCB0aGUgY29tbW9uIGRtYSBmcmFtZXdvcmsKPj4gd2lsbCBnZXQgYSBjaGFubmVs
IGR5bmFtaWNhbGx5IGZyb20gYW55IGF2YWlsYWJsZSBzZG1hIGluc3RhbmNlIAo+PiB3aGV0aGVy
Cj4+IGl0J3MgdGhlIGZpcnN0IHNkbWEgZGV2aWNlIG9yIHRoZSBzZWNvbmQgc2RtYSBkZXZpY2Uu
IFNvbWUgSVBzIGxpa2UKPj4gU0FJIG9ubHkgd29yayB3aXRoIHNkbWEyIG5vdCBzZG1hMS4gVG8g
bWFrZSBzdXJlIHRoZSBzZG1hIGNoYW5uZWwgaXMgCj4+IGZyb20KPj4gdGhlIGNvcnJlY3Qgc2Rt
YSBkZXZpY2UsIHVzZSBhbiBpbmRleCB0byBtYXRjaC4KPj4gCj4+IEJhc2VkIG9uIE1MSy0xNjEw
NC0yIGJ5IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4KPiAKPiBUaGlzIHJlbGllcyBv
biB0aGUgcHJvYmUgb3JkZXIgb2YgdGhlIGRldmljZXMgKHdoaWNoIHNob3VsZCBiZSB0cmVhdGVk
Cj4gYXMgcmFuZG9tKSBmb3IgdGhlIG1hdGNoIHRvIGZpbmQgdGhlIHJpZ2h0IGRldmljZS4gVGhp
cyBpcyBub3QKPiBhY2NlcHRhYmxlIHVwc3RyZWFtLgo+IAo+IFRoZSBEVCAiZG1hcyIgcHJvcGVy
dHkgYWxyZWFkeSBzcGVjaWZpZXMgdGhlIGNvcnJlY3QgU0RNQSBkZXZpY2UgdG8gdXNlCj4gIGZv
ciBhIGNvbnN1bWVyLCBzbyB0aGUgZmlsdGVyIGZ1bmN0aW9uIHNob3VsZCByZWFsbHkgbWF0Y2gg
dGhlIE9GIG5vZGUKPiBvZiB0aGUgU0RNQSBkZXZpY2Ugd2l0aCB0aGUgbm9kZSBzcGVjaWZpZWQg
aW4gdGhlIGRtYXMgcGhhbmRsZSBpbiBvcmRlcgo+IHRvIHBpY2sgdGhlIHJpZ2h0IFNETUEgZW5n
aW5lLgo+IAoKVGhhbmtzIEx1Y2FzLCBJJ2xsIGZpeCBpdCBmb3IgcmV2IDQKCj4gUmVnYXJkcywK
PiBMdWNhcwo+IAo+PiAKPj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBBaW5zbGllIChQdXJpc20p
IDxhbmd1c0Bha2tlYS5jYT4KPj4gLS0tCj4+IMKgZHJpdmVycy9kbWEvaW14LXNkbWEuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCAxMiArKysrKysrKysrKysKPj4gwqBpbmNsdWRl
L2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC5oIHzCoMKgMSArCj4+IMKgMiBmaWxlcyBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMKPj4gaW5kZXggMmU2OTFiMWNkMGViLi5i
ZjM3NTJhNmE2NGYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMKPj4gKysr
IGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYwo+PiBAQCAtNDQyLDYgKzQ0Miw3IEBAIHN0cnVjdCBz
ZG1hX2VuZ2luZSB7Cj4+ID4gPiDCoAlzdHJ1Y3Qgc2RtYV9idWZmZXJfZGVzY3JpcHRvcgkqYmQw
Owo+PiA+IMKgCS8qIGNsb2NrIHJhdGlvIGZvciBBSEI6U0RNQSBjb3JlLiAxOjEgaXMgMSwgMjox
IGlzIDAqLwo+PiA+ID4gwqAJYm9vbAkJCQljbGtfcmF0aW87Cj4+ID4gPiArCWludAkJCQlpZHg7
Cj4+IMKgfTsKPj4gwqAKPj4gwqBzdGF0aWMgaW50IHNkbWFfY29uZmlnX3dyaXRlKHN0cnVjdCBk
bWFfY2hhbiAqY2hhbiwKPj4gQEAgLTYwNiw2ICs2MDcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBzZG1hX2R0X2lkc1tdID0gewo+PiDCoH07Cj4+IMKgTU9EVUxFX0RFVklD
RV9UQUJMRShvZiwgc2RtYV9kdF9pZHMpOwo+PiDCoAo+PiArc3RhdGljIGludCBzZG1hX2Rldl9p
ZHg7Cj4+ICsKPj4gPiDCoCNkZWZpbmUgU0RNQV9IX0NPTkZJR19EU1BETUEJQklUKDEyKSAvKiBp
bmRpY2F0ZXMgaWYgdGhlIERTUERNQSBpcyB1c2VkICovCj4+ID4gwqAjZGVmaW5lIFNETUFfSF9D
T05GSUdfUlREX1BJTlMJQklUKDExKSAvKiBpbmRpY2F0ZXMgaWYgUmVhbC1UaW1lIERlYnVnIHBp
bnMgYXJlIGVuYWJsZWQgKi8KPj4gPiDCoCNkZWZpbmUgU0RNQV9IX0NPTkZJR19BQ1IJQklUKDQp
wqDCoC8qIGluZGljYXRlcyBpZiBBSEIgZnJlcSAvY29yZSBmcmVxID0gMiBvciAxICovCj4+IEBA
IC0xOTM0LDYgKzE5MzcsMTEgQEAgc3RhdGljIGJvb2wgc2RtYV9maWx0ZXJfZm4oc3RydWN0IGRt
YV9jaGFuIAo+PiAqY2hhbiwgdm9pZCAqZm5fcGFyYW0pCj4+ID4gwqAJaWYgKCFpbXhfZG1hX2lz
X2dlbmVyYWxfcHVycG9zZShjaGFuKSkKPj4gPiDCoAkJcmV0dXJuIGZhbHNlOwo+PiDCoAo+PiA+
ICsJLyogcmV0dXJuIGZhbHNlIGlmIGl0J3Mgbm90IHRoZSByaWdodCBkZXZpY2UgKi8KPj4gPiAr
CWlmICgoc2RtYWMtPnNkbWEtPmRydmRhdGEgPT0gJnNkbWFfaW14OG1xKQo+PiA+ICsJCSYmIChz
ZG1hYy0+c2RtYS0+aWR4ICE9IGRhdGEtPmlkeCkpCj4+ID4gKwkJcmV0dXJuIGZhbHNlOwo+PiAr
Cj4+ID4gwqAJc2RtYWMtPmRhdGEgPSAqZGF0YTsKPj4gPiDCoAljaGFuLT5wcml2YXRlID0gJnNk
bWFjLT5kYXRhOwo+PiDCoAo+PiBAQCAtMTk2MSw2ICsxOTY5LDcgQEAgc3RhdGljIHN0cnVjdCBk
bWFfY2hhbiAqc2RtYV94bGF0ZShzdHJ1Y3QgCj4+IG9mX3BoYW5kbGVfYXJncyAqZG1hX3NwZWMs
Cj4+ID4gwqAJwqAqIGJlIHNldCB0byBzZG1hYy0+ZXZlbnRfaWQxLgo+PiA+IMKgCcKgKi8KPj4g
PiDCoAlkYXRhLmRtYV9yZXF1ZXN0MiA9IDA7Cj4+ID4gKwlkYXRhLmlkeCA9IHNkbWEtPmlkeDsK
Pj4gwqAKPj4gPiDCoAlyZXR1cm4gZG1hX3JlcXVlc3RfY2hhbm5lbChtYXNrLCBzZG1hX2ZpbHRl
cl9mbiwgJmRhdGEpOwo+PiDCoH0KPj4gQEAgLTIxNDksNiArMjE1OCw5IEBAIHN0YXRpYyBpbnQg
c2RtYV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIAo+PiAqcGRldikKPj4gPiDCoAkJb2Zf
bm9kZV9wdXQoc3BiYV9idXMpOwo+PiA+IMKgCX0KPj4gwqAKPj4gPiArCS8qIFRoZXJlIG1heWJl
IG11bHRpIHNkbWEgZGV2aWNlcyBzdWNoIGFzIGkubXg4bXEgKi8KPj4gPiArCXNkbWEtPmlkeCA9
IHNkbWFfZGV2X2lkeCsrOwo+PiArCj4+ID4gwqAJcmV0dXJuIDA7Cj4+IMKgCj4+IMKgZXJyX3Jl
Z2lzdGVyOgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2RtYS1p
bXguaCAKPj4gYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC5oCj4+IGluZGV4
IDdkOTY0ZTc4NzI5OS4uODQzZmFmMDgxMjgyIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4
L3BsYXRmb3JtX2RhdGEvZG1hLWlteC5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1f
ZGF0YS9kbWEtaW14LmgKPj4gQEAgLTU1LDYgKzU1LDcgQEAgc3RydWN0IGlteF9kbWFfZGF0YSB7
Cj4+ID4gwqAJaW50IGRtYV9yZXF1ZXN0MjsgLyogc2Vjb25kYXJ5IERNQSByZXF1ZXN0IGxpbmUg
Ki8KPj4gPiDCoAllbnVtIHNkbWFfcGVyaXBoZXJhbF90eXBlIHBlcmlwaGVyYWxfdHlwZTsKPj4g
PiDCoAlpbnQgcHJpb3JpdHk7Cj4+ID4gKwlpbnQgaWR4Owo+PiDCoH07Cj4+IMKgCj4+IMKgc3Rh
dGljIGlubGluZSBpbnQgaW14X2RtYV9pc19pcHUoc3RydWN0IGRtYV9jaGFuICpjaGFuKQoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
