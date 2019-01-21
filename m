Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC0EC2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:43:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856122087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nqmvQEPA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="QLXptzoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856122087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:From:Date:
	MIME-Version:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XOTR8fD+UQfPjazmDhEBn14OJX4QpU4AK7xoyeVMkbE=; b=nqmvQEPAtw3H8VAueArprDHX7
	7aA8cBCYQyMqS3QOvTsooC1edu9ODy1us8AAI3xqWTv83MxV9AJmukqCmNO8BkmJVJ8P5NU7HK0CG
	BtDSkb0QeGYCu29MX6Cvohfh3GHsy5WpDvapBpdmBznFcwAdy5nbY7XuO0BjF3n9tZVfpjg6bEMTU
	c+PXg6X2xWT+Omg/zTiUGCvFYGpGQgDfO9sLaCBfplQPn1ezKdQ7L679w+H50Ihlbc1rYoLOqXxFC
	WxMaL+ELFc+F4dr0mrsoj3NDQ6qr8i4v7yS6scsshBhoWu/QrnT2VAdueOawQ6d8bkW+XXlp7ahKk
	tYPKiQyzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glanV-0008OM-Gv; Mon, 21 Jan 2019 14:43:33 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glanR-0008Ng-6n
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 14:43:31 +0000
Received: by node.akkea.ca (Postfix, from userid 33)
 id 6F17E4E204B; Mon, 21 Jan 2019 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548081806; bh=PaDiI42TfKSPDuelZsZieMJYcPLeXFEJWesQZ3LpWLY=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References;
 b=QLXptzoUkCCGpY88/FzENFgIwodblmp4F4YaWD6TZEGMUP+KLXx/Ziq8fnfZ+7PaG
 5xY0i5M6y1yL7hmUfljAbWhjtRSm7BtwF15f+g0cQwLe0H2+b7mVA0r8f3IB5aRZPx
 UmDW1UrXCNFeJzq5XQginzLR102LhZMzxekPmwmU=
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 2/3] dma: imx-sdma: add clock ratio 1:1 check
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Date: Mon, 21 Jan 2019 07:43:26 -0700
From: Angus Ainslie <angus@akkea.ca>
In-Reply-To: <1548062262.2465.5.camel@pengutronix.de>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190120023150.17138-3-angus@akkea.ca>
 <1548062262.2465.5.camel@pengutronix.de>
Message-ID: <141a054976519d22aa195affca633c21@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_064329_630222_6D4B3F84 
X-CRM114-Status: GOOD (  14.81  )
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
Cc: linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTHVjYXMsCgpPbiAyMDE5LTAxLTIxIDAyOjE3LCBMdWNhcyBTdGFjaCB3cm90ZToKPiBIaSBB
bmd1cywKPiAKPiBBbSBTYW1zdGFnLCBkZW4gMTkuMDEuMjAxOSwgMTk6MzEgLTA3MDAgc2Nocmll
YiBBbmd1cyBBaW5zbGllIChQdXJpc20pOgo+PiBPbiBpLm14OCBtc2NhbGUgQjAgY2hpcCwgQUhC
L1NETUEgY2xvY2sgcmF0aW8gMjoxIGNhbid0IGJlIHN1cHBvcnR0ZWQsCj4+IHNpbmNlIFNETUEg
Y2xvY2sgcmF0aW8gaGFzIHRvIGJlIGluY3JlYXNlZCB0byAyNTBNaHosIEFIQiBjYW4ndCByZWFj
aAo+PiB0byA1MDBNaHosIHNvIHVzZSAxOjEgaW5zdGVhZC4KPj4gCj4+IGJhc2VkIG9uIE5YUCBj
b21taXQgTUxLLTE2ODQxLTEKPj4gCj4+ID4gU2lnbmVkLW9mZi1ieTogQW5ndXMgQWluc2xpZSAo
UHVyaXNtKSA8YW5ndXNAYWtrZWEuY2E+Cj4+IC0tLQo+PiDCoC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2RtYS9mc2wtaW14LXNkbWEudHh0wqDCoHzCoMKgMSArCj4+IMKgZHJpdmVycy9kbWEvaW14
LXNkbWEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwg
MjAgCj4+ICsrKysrKysrKysrKysrKy0tLS0KPj4gwqAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0IAo+PiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4dAo+PiBpbmRleCAz
YzlhNTdhODQ0M2IuLjE3NTQ0YzE4MjBiNyAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0Cj4+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4dAo+PiBAQCAtNjcs
NiArNjcsNyBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOgo+PiDCoMKgwqDCoMKgcmVnIGlzIHRoZSBH
UFIgcmVnaXN0ZXIgb2Zmc2V0Lgo+PiDCoMKgwqDCoMKgc2hpZnQgaXMgdGhlIGJpdCBwb3NpdGlv
biBpbnNpZGUgdGhlIEdQUiByZWdpc3Rlci4KPj4gwqDCoMKgwqDCoHZhbCBpcyB0aGUgdmFsdWUg
b2YgdGhlIGJpdCAoMCBvciAxKS4KPj4gKy0gZnNsLHJhdGlvLTEtMTogQUhCL1NETUEgY29yZSBj
bG9jayByYXRpb24gMToxLCAyOjEgd2l0aG91dCB0aGlzLgo+IAo+IFdoeSBkb2VzIHRoaXMgbmVl
ZCBhIHNlcGFyYXRlIERUIHByb3BlcnR5PyBTaG91bGRuJ3QgdGhlIGRyaXZlciBiZSBhYmxlCj4g
dG8gaW5mZXIgdGhpcyBmcm9tIHRoZSBjbG9jayByYXRlcyBnb2luZyBpbnRvIHRoZSBTRE1BIGhh
cmR3YXJlPwo+IAoKVGhhdCdzIHByb2JhYmx5IGEgYmV0dGVyIHdheSB0byBkbyBpdCB0aGVuIHNl
dHRpbmcgdGhlIHByb3BlcnR5IGNhbid0CmdldCBtaXNzZWQuIEknbGwgYWRkcmVzcyBpdCBpbiB2
My4KCkFuZ3VzCgo+IFJlZ2FyZHMsCj4gTHVjYXMKPiAKPj4gwqBFeGFtcGxlczoKPj4gwqAKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jCj4+IGluZGV4IDBiM2E2N2ZmOGU4Mi4uNjVkYWRhMjFkM2MxIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2RtYS9pbXgtc2RtYS5jCj4+ICsrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMKPj4g
QEAgLTQ0MCw2ICs0NDAsOCBAQCBzdHJ1Y3Qgc2RtYV9lbmdpbmUgewo+PiA+ID4gwqAJdW5zaWdu
ZWQgaW50CQkJaXJxOwo+PiA+ID4gwqAJZG1hX2FkZHJfdAkJCWJkMF9waHlzOwo+PiA+ID4gwqAJ
c3RydWN0IHNkbWFfYnVmZmVyX2Rlc2NyaXB0b3IJKmJkMDsKPj4gPiArCS8qIGNsb2NrIHJhdGlv
IGZvciBBSEI6U0RNQSBjb3JlLiAxOjEgaXMgMSwgMjoxIGlzIDAqLwo+PiA+ID4gKwlib29sCQkJ
CWNsa19yYXRpbzsKPj4gwqB9Owo+PiDCoAo+PiDCoHN0YXRpYyBpbnQgc2RtYV9jb25maWdfd3Jp
dGUoc3RydWN0IGRtYV9jaGFuICpjaGFuLAo+PiBAQCAtNjYyLDggKzY2NCwxNCBAQCBzdGF0aWMg
aW50IHNkbWFfcnVuX2NoYW5uZWwwKHN0cnVjdCBzZG1hX2VuZ2luZSAKPj4gKnNkbWEpCj4+ID4g
wqAJCWRldl9lcnIoc2RtYS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBDSDAgcmVhZHlcbiIp
Owo+PiDCoAo+PiA+IMKgCS8qIFNldCBiaXRzIG9mIENPTkZJRyByZWdpc3RlciB3aXRoIGR5bmFt
aWMgY29udGV4dCBzd2l0Y2hpbmcgKi8KPj4gPiAtCWlmIChyZWFkbChzZG1hLT5yZWdzICsgU0RN
QV9IX0NPTkZJRykgPT0gMCkKPj4gPiAtCQl3cml0ZWxfcmVsYXhlZChTRE1BX0hfQ09ORklHX0NT
TSwgc2RtYS0+cmVncyArIFNETUFfSF9DT05GSUcpOwo+PiA+ICsJaWYgKHJlYWRsKHNkbWEtPnJl
Z3MgKyBTRE1BX0hfQ09ORklHKSA9PSAwKSB7Cj4+ID4gKwkJaWYgKHNkbWEtPmNsa19yYXRpbykK
Pj4gPiArCQkJcmVnID0gU0RNQV9IX0NPTkZJR19DU00gfCBTRE1BX0hfQ09ORklHX0FDUjsKPj4g
PiArCQllbHNlCj4+ID4gKwkJCXJlZyA9IFNETUFfSF9DT05GSUdfQ1NNOwo+PiArCj4+ID4gKwkJ
d3JpdGVsX3JlbGF4ZWQocmVnLCBzZG1hLT5yZWdzICsgU0RNQV9IX0NPTkZJRyk7Cj4+ID4gKwl9
Cj4+IMKgCj4+ID4gwqAJcmV0dXJuIHJldDsKPj4gwqB9Cj4+IEBAIC0xODgwLDggKzE4ODgsMTAg
QEAgc3RhdGljIGludCBzZG1hX2luaXQoc3RydWN0IHNkbWFfZW5naW5lICpzZG1hKQo+PiA+IMKg
CXdyaXRlbF9yZWxheGVkKDB4NDA1MCwgc2RtYS0+cmVncyArIFNETUFfQ0hOMEFERFIpOwo+PiDC
oAo+PiA+IMKgCS8qIFNldCBiaXRzIG9mIENPTkZJRyByZWdpc3RlciBidXQgd2l0aCBzdGF0aWMg
Y29udGV4dCBzd2l0Y2hpbmcgKi8KPj4gPiAtCS8qIEZJWE1FOiBDaGVjayB3aGV0aGVyIHRvIHNl
dCBBQ1IgYml0IGRlcGVuZGluZyBvbiBjbG9jayByYXRpb3MgKi8KPj4gPiAtCXdyaXRlbF9yZWxh
eGVkKDAsIHNkbWEtPnJlZ3MgKyBTRE1BX0hfQ09ORklHKTsKPj4gPiArCWlmIChzZG1hLT5jbGtf
cmF0aW8pCj4+ID4gKwkJd3JpdGVsX3JlbGF4ZWQoU0RNQV9IX0NPTkZJR19BQ1IsIHNkbWEtPnJl
Z3MgKyBTRE1BX0hfQ09ORklHKTsKPj4gPiArCWVsc2UKPj4gPiArCQl3cml0ZWxfcmVsYXhlZCgw
LCBzZG1hLT5yZWdzICsgU0RNQV9IX0NPTkZJRyk7Cj4+IMKgCj4+ID4gwqAJd3JpdGVsX3JlbGF4
ZWQoY2NiX3BoeXMsIHNkbWEtPnJlZ3MgKyBTRE1BX0hfQzBQVFIpOwo+PiDCoAo+PiBAQCAtMTk3
NSw2ICsxOTg1LDggQEAgc3RhdGljIGludCBzZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgCj4+ICpwZGV2KQo+PiA+IMKgCWlmICghc2RtYSkKPj4gPiDCoAkJcmV0dXJuIC1FTk9NRU07
Cj4+IMKgCj4+ID4gKwlzZG1hLT5jbGtfcmF0aW8gPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAs
ICJmc2wscmF0aW8tMS0xIik7Cj4+ICsKPj4gPiDCoAlzcGluX2xvY2tfaW5pdCgmc2RtYS0+Y2hh
bm5lbF8wX2xvY2spOwo+PiDCoAo+PiA+IMKgCXNkbWEtPmRldiA9ICZwZGV2LT5kZXY7CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
