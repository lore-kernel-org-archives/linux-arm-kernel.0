Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:02:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA092206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="obAeXncw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA092206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KYDPQb4LkQ9vwg1AQT+h1pzaM4noPVTCZzPPih+w62g=; b=obAeXncwk8IOjc
	yLux9g3/7Q01WpUa6EvsfRfnlTeTxC6Q6I1j5R7b8+rde04pyNLyPdKxUlKQ40Ja5Q8k4fceD1QbE
	faezT7DlqrboqlpMeBR9w3vl4gkxMzsH0XjL1Rx6dEGC+imn9OMR1v7xbdEiw8srHmqd8R8UcgYUz
	1ZhBU7/p/ixz8ylGpqrpVWiDcM3GrW1S3vAFlQWVkuZS4bLE3Qt7mCyi1NuQmOZoqxD333gI2no10
	vHuxNMUnEns2GHzXFiSYempFVKujaEExeZdehiG522oEbxLC+7wBJ9/DyQU/PsyW0HNkplTwGjXYm
	tGi6B+eaPBFglZThfK+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giraI-00009g-TB; Mon, 14 Jan 2019 02:02:38 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giraE-00008t-4o; Mon, 14 Jan 2019 02:02:36 +0000
X-UUID: 99e9807855d246ac99366b22ddf33ca5-20190113
X-UUID: 99e9807855d246ac99366b22ddf33ca5-20190113
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 17507042; Sun, 13 Jan 2019 18:02:21 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 13 Jan 2019 18:02:20 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Jan 2019 10:02:18 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Jan 2019 10:02:17 +0800
Message-ID: <1547431338.29750.7.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
From: CK Hu <ck.hu@mediatek.com>
To: Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Date: Mon, 14 Jan 2019 10:02:18 +0800
In-Reply-To: <afe6ba3f-77ee-1b7c-072e-64ccb161119e@tronnes.org>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
 <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
 <20190110200225.GN21184@phenom.ffwll.local>
 <1547176809.12054.11.camel@mtksdaap41>
 <20190111092042.GP21184@phenom.ffwll.local>
 <1547200155.4209.4.camel@mtksdaap41>
 <20190111102503.GU21184@phenom.ffwll.local>
 <afe6ba3f-77ee-1b7c-072e-64ccb161119e@tronnes.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_180234_193897_2411294C 
X-CRM114-Status: GOOD (  32.07  )
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
Cc: Frank Wunderlich <frank-w@public-files.de>, David Airlie <airlied@linux.ie>,
 Alexander Ryabchenko <d3adme4t@gmail.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMDE5LTAxLTExIGF0IDE3OjA3ICswMTAwLCBOb3JhbGYgVHLDuG5uZXMgd3JvdGU6
Cj4gCj4gRGVuIDExLjAxLjIwMTkgMTEuMjUsIHNrcmV2IERhbmllbCBWZXR0ZXI6Cj4gPiBPbiBG
cmksIEphbiAxMSwgMjAxOSBhdCAwNTo0OToxNVBNICswODAwLCBDSyBIdSB3cm90ZToKPiA+PiBI
aSwgRGFuaWVsOgo+ID4+Cj4gPj4gT24gRnJpLCAyMDE5LTAxLTExIGF0IDEwOjIwICswMTAwLCBE
YW5pZWwgVmV0dGVyIHdyb3RlOgo+ID4+PiBPbiBGcmksIEphbiAxMSwgMjAxOSBhdCAxMToyMDow
OUFNICswODAwLCBDSyBIdSB3cm90ZToKPiA+Pj4+IEhpLCBEYW5pZWw6Cj4gPj4+Pgo+ID4+Pj4g
T24gVGh1LCAyMDE5LTAxLTEwIGF0IDIxOjAyICswMTAwLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+
ID4+Pj4+IE9uIFRodSwgSmFuIDEwLCAyMDE5IGF0IDA4OjAxOjM3UE0gKzAxMDAsIEZyYW5rIFd1
bmRlcmxpY2ggd3JvdGU6Cj4gPj4+Pj4+IEhpIERhbmllbCwKPiA+Pj4+Pj4KPiA+Pj4+Pj4+PiBX
b3VsZCBiZSBnb29kIHRvIHVzZSB0aGUgbmV3IGdlbmVyaWMgZmJkZXYgZW11bGF0aW9uIGNvZGUg
aGVyZSwgZm9yIGV2ZW4KPiA+Pj4+Pj4+PiBsZXNzIGNvZGUuIE9yIGF0IGxlYXN0IGtub3cgd2h5
IHRoaXMgaXNuJ3QgcG9zc2libGUgdG8gdXNlIGZvciBtdGsgKGFuZAo+ID4+Pj4+Pj4+IG1heWJl
IGFkZHJlc3MgdGhhdCBpbiB0aGUgY29yZSBjb2RlKS4gSGFuZC1yb2xsaW5nIGZiZGV2IGNvZGUg
c2hvdWxkbid0IGJlCj4gPj4+Pj4+Pj4gbmVlZGVkIGFueW1vcmUuCj4gPj4+Pj4+Pgo+ID4+Pj4+
Pj4gQmFjayBvbiB0aGUgbWFpbGluZyBsaXN0LCBubyBwcml2YXRlIHJlcGxpZXMgcGxlYXNlOgo+
ID4+Pj4+Pgo+ID4+Pj4+PiBpIGRvbid0IHdhbnRlZCB0byBzcGFtIGFsbCBwZW9wbGUgd2l0aCBk
dW1iIHF1ZXN0aW9ucyA7KQo+ID4+Pj4+Cj4gPj4+Pj4gVGhlcmUncyBubyBkdW1iIHF1ZXN0aW9u
cywgb25seSBpbnN1ZmZpY2llbnQgZG9jdW1lbnRhdGlvbiA6LSkKPiA+Pj4+Pgo+ID4+Pj4+Pj4g
Rm9yIGV4YW1wbGVzIHBsZWFzZSBncmVwIGZvciBkcm1fZmJkZXZfZ2VuZXJpY19zZXR1cCgpLiBU
aGVyZSdzIGFsc28gYQo+ID4+Pj4+Pj4gc3RpbGwgaW4tZmxpZ2h0IHNlcmllcyBmcm9tIEdlcmQg
SG9mZm1hbm4gdG8gY29udmVydCBvdmVyIGJvY2hzLiBUaGF0LAo+ID4+Pj4+Pj4gcGx1cyBhbGwg
dGhlIGtlcm5lbGRvYyBsaW5rZWQgZnJvbSB0aGVyZSBzaG91bGQgZ2V0IHlvdSBzdGFydGVkLgo+
ID4+Pj4+Pj4gLURhbmllbAo+ID4+Pj4+Pgo+ID4+Pj4+PiB0aGlzIGlzIG9uZSBvZiBnb29nbGUg
YmVzdCBmb3VuZHMgaWYgaSBzZWFyY2ggZm9yIGRybV9mYmRldl9nZW5lcmljX3NldHVwOgo+ID4+
Pj4+Pgo+ID4+Pj4+PiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC8xMi8xOS8zMDUKPiA+Pj4+
Pj4KPiA+Pj4+Pj4gbm90IHZlcnkgaGVscGZ1bC4uLgo+ID4+Pj4+Pgo+ID4+Pj4+PiBzbyBpIHRy
aWVkIGtlcm5lbC1kb2MKPiA+Pj4+Pj4KPiA+Pj4+Pj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9k
b2MvaHRtbC9sYXRlc3QvZ3B1L2RybS1rbXMtaGVscGVycy5odG1sP2hpZ2hsaWdodD1kcm1fZmJk
ZXZfZ2VuZXJpY19zZXR1cCNjLmRybV9mYmRldl9nZW5lcmljX3NldHVwCj4gPj4+Pj4+Cj4gPj4+
Pj4+IHdoaWNoIGlzIG5pY2UgZnVuY3Rpb24tcmVmZXJlbmNlIGJ1dCBpJ3ZlIGZvdW5kIG5vIGdl
bmVyaWMgd29ya2Zsb3cKPiA+Pj4+Pj4KPiA+Pj4+Pj4gYXMgdGhlIHBvc3RlZCBkcml2ZXIgaXMg
Im9ubHkiIGEgZHJpdmVyIHBvcnRlZCBmcm9tIGtlcm5lbCA0LjQgYnkgQWxleGFuZGVyLCBpIGRv
bid0IGtub3cgaWYgdGhpcyBuZXcgZnJhbWV3b3JrIGNhbiBiZSB1c2VkIGFuZCB3aGljaCBwYXJ0
cyBuZWVkIHRvIGJlIGNoYW5nZWQuIEkgb25seSB0cnkgdG8gYnJpbmcgaGlzIGNvZGUgTWFpbmxp
bmUuLi4uCj4gPj4+Pj4+IE1heWJlIENLIEh1IGNhbiBoZWxwIGhlcmUgYmVjYXVzZSBkcml2ZXIg
aXMgb3JpZ2luYWxseSBmcm9tIGhpbSBhbmQgaGUga25vd3MgaW50ZXJuYWxzLiBPciBtYXliZSB5
b3UgY2FuIGhlbHAgaGVyZT8KPiA+Pj4+Pj4KPiA+Pj4+Pj4gaSBwZXJzb25hbGx5IG1ha2UgbXkg
Zmlyc3Qgc3RlcHMgYXMgc3BhcmUtdGltZSBrZXJuZWwtZGV2ZWxvcGVyIDopCj4gPj4+Pj4KPiA+
Pj4+PiBUaGVyZSdzIGEgdG9uIG9mIGluLWtlcm5lbCB1c2VycyBvZiB0aGF0IGZ1bmN0aW9uIGFs
cmVhZHksIEkgbWVhbnQgeW91IGNhbgo+ID4+Pj4+IHVzZSB0aG9zZSB0byBzZXJ2ZSBhcyBleGFt
cGxlcyAuLi4gSWYgdGhvc2UgKyB0aGUga2VybmVsZG9jIGFyZW4ndAo+ID4+Pj4+IGdvb2QgZW5v
dWdoLCB0aGVuIHdlIG5lZWQgdG8gaW1wcm92ZSB0aGVtLgo+ID4+Pj4+IC1EYW5pZWwKPiA+Pj4+
Cj4gPj4+PiBJJ3ZlIHRyaWVkIHdpdGggZHJtX2ZiZGV2X2dlbmVyaWNfc2V0dXAoKSBhbmQgaXQg
d29ya3MgZmluZSB3aXRoIHNpbXBsZQo+ID4+Pj4gbW9kaWZpY2F0aW9uLiBUaGUgcGF0Y2ggaXMK
PiA+Pj4+Cj4gPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYu
Ywo+ID4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMKPiA+
Pj4+IEBAIC0xNiw2ICsxNiw3IEBACj4gPj4+PiAgI2luY2x1ZGUgPGRybS9kcm1fYXRvbWljLmg+
Cj4gPj4+PiAgI2luY2x1ZGUgPGRybS9kcm1fYXRvbWljX2hlbHBlci5oPgo+ID4+Pj4gICNpbmNs
dWRlIDxkcm0vZHJtX2NydGNfaGVscGVyLmg+Cj4gPj4+PiArI2luY2x1ZGUgPGRybS9kcm1fZmJf
aGVscGVyLmg+Cj4gPj4+PiAgI2luY2x1ZGUgPGRybS9kcm1fZ2VtLmg+Cj4gPj4+PiAgI2luY2x1
ZGUgPGRybS9kcm1fZ2VtX2NtYV9oZWxwZXIuaD4KPiA+Pj4+ICAjaW5jbHVkZSA8ZHJtL2RybV9v
Zi5oPgo+ID4+Pj4gQEAgLTM3OSw2ICszODAsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2ttc19k
ZWluaXQoc3RydWN0IGRybV9kZXZpY2UKPiA+Pj4+ICpkcm0pCj4gPj4+PiAgICAgICAgIC5nZW1f
cHJpbWVfZ2V0X3NnX3RhYmxlID0gbXRrX2dlbV9wcmltZV9nZXRfc2dfdGFibGUsCj4gPj4+PiAg
ICAgICAgIC5nZW1fcHJpbWVfaW1wb3J0X3NnX3RhYmxlID0gbXRrX2dlbV9wcmltZV9pbXBvcnRf
c2dfdGFibGUsCj4gPj4+PiAgICAgICAgIC5nZW1fcHJpbWVfbW1hcCA9IG10a19kcm1fZ2VtX21t
YXBfYnVmLAo+ID4+Pj4gKyAgICAgICAuZ2VtX3ByaW1lX3ZtYXAgPSBtdGtfZHJtX2dlbV9wcmlt
ZV92bWFwLAo+ID4+Pj4gICAgICAgICAuaW9jdGxzID0gbXRrX2lvY3RscywKPiA+Pj4+ICAgICAg
ICAgLm51bV9pb2N0bHMgPSBBUlJBWV9TSVpFKG10a19pb2N0bHMpLAo+ID4+Pj4gICAgICAgICAu
Zm9wcyA9ICZtdGtfZHJtX2ZvcHMsCj4gPj4+PiBAQCAtNDE2LDYgKzQxOCw4IEBAIHN0YXRpYyBp
bnQgbXRrX2RybV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldikKPiA+Pj4+ICAgICAgICAgaWYgKHJl
dCA8IDApCj4gPj4+PiAgICAgICAgICAgICAgICAgZ290byBlcnJfZGVpbml0Owo+ID4+Pj4KPiA+
Pj4+ICsgICAgICAgZHJtX2ZiZGV2X2dlbmVyaWNfc2V0dXAoZHJtLCAzMik7Cj4gPj4+PiArCj4g
Pj4+PiAgICAgICAgIHJldHVybiAwOwo+ID4+Pj4KPiA+Pj4+Cj4gPj4+PiBCdXQgSSBpbXBsZW1l
bnQgLmdlbV9wcmltZV92bWFwIHdpdGggYSB3b3JrYXJvdW5kLAo+ID4+Pj4KPiA+Pj4+Cj4gPj4+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYwo+ID4+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMKPiA+Pj4+IEBAIC0yODAs
MyArMjgwLDggQEAgaW50IG10a19nZW1fY3JlYXRlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsCj4gPj4+PiB2b2lkICpkYXRhLAo+ID4+Pj4gICAgICAgICBtdGtfZHJtX2dlbV9mcmVlX29i
amVjdCgmbXRrX2dlbS0+YmFzZSk7Cj4gPj4+PiAgICAgICAgIHJldHVybiByZXQ7Cj4gPj4+PiAg
fQo+ID4+Pj4gKwo+ID4+Pj4gK3ZvaWQgKm10a19kcm1fZ2VtX3ByaW1lX3ZtYXAoc3RydWN0IGRy
bV9nZW1fb2JqZWN0ICpvYmopCj4gPj4+PiArewo+ID4+Pj4gKyAgICAgICByZXR1cm4gKHZvaWQg
KikxOwo+ID4+Pj4gK30KPiA+Pj4+Cj4gPj4+PiBDdXJyZW50IGRybV9mYl9oZWxwZXIgZGVwZW5k
cyBvbiBkcm1fY2xpZW50IHRvIGNyZWF0ZSBmYmRldi4gV2hlbgo+ID4+Pj4gZHJtX2NsaWVudCBj
cmVhdGUgZHJtX2NsaWVudF9idWZmZXIsIGl0IG5lZWQgdG8gdm1hcCB0byBnZXQga2VybmVsCj4g
Pj4+PiB2YWRkci4gQnV0IEkgdGhpbmsgZm9yIGZiZGV2LCB0aGUgdmFkZHIgaXMgdXNlbGVzcy4g
RG8geW91IGFncmVlIHRoYXQgSQo+ID4+Pj4gdGVtcG9yYXJpbHkgaW1wbGVtZW50IC5nZW1fcHJp
bWVfdm1hcCBpbiBzdWNoIHdheT8KPiA+Pj4KPiA+Pj4gVGhlIHZtYXAgaXMgdXNlZCBieSBmYmNv
biwgd2l0aG91dCB0aGF0IGZiZGV2IHdvbid0IHJlYWxseSB3b3JrIEkgdGhpbmsuCj4gPj4+IFNv
IEknbSByYXRoZXIgY29uZnVzZWQgb24gd2hhdCB5b3UgdGVzdGVkIC4uLgo+ID4+Pgo+ID4+PiBB
ZGRpbmcgTm9yYWxmLCBoZSdzIHRoZSBleHBlcnQgaGVyZS4KPiA+Pj4gLURhbmllbAo+ID4+Cj4g
Pj4gSSB0ZXN0IHdpdGggZmJfdGVzdCBbMV0sIGl0IGlzIGEgdXNlciBzcGFjZSBwcm9ncmFtIGp1
c3Qgb3BlbiAvZGV2L2ZiMAo+ID4+IGFuZCBtbWFwIGl0IHRvIHVzZXIgc3BhY2UuIEkgZG9lcyBu
b3QgdHVybiBvbiBmYmNvbiBzbyBldmVyeXRoaW5nIGxvb2tzCj4gPj4gd2VsbC4gSWYgc3VwcG9y
dCBmYmNvbiBpcyBlc3NlbnRpYWwsIEkgd291bGQgaW1wbGVtZW50IHZtYXAgY29ycmVjdGx5Lgo+
ID4+IElmIGl0J3Mgbm90IGVzc2VudGlhbCwgSSB0aGluayBJIGNvdWxkIHJldHVybiAwIHdoZW4K
PiA+PiBDT05GSUdfRlJBTUJVRkZFUl9DT05TT0xFIGlzIGRlZmluZWQuCj4gPiAKPiA+IEkgdGhp
bmsgZmJkZXYgZW11bGF0aW9uIHdpdGhvdXQgd29ya2luZyBmYmNvbiBpcyBmYWlybHkgdXNlbGVz
cy4gQW5kIGl0Cj4gPiBzaG91bGRuJ3QgYmUgdGhhdCBtdWNoIHdvcmsgdG8gbWFrZSBpdCB3b3Jr
LCB3ZSBoYXZlIHF1aXRlIGEgZmV3IG1vcmUKPiA+IGhlbGVycyBmb3IgZ2VtIGJvIG5vd2FkYXlz
Lgo+IAo+IElmIHRoZSB2aXJ0dWFsIGFkZHJlc3MgaXMgbm90IHNldCwgZmJjb24gY2FuJ3QgYmUg
dXNlZCBhbmQgdGhhdCBtZWFucyBpdAo+IGhhcyB0byBiZSBkaXNhYmxlZCB1c2luZyBzb21ldGhp
bmcgbGlrZSB0aGlzIGluIHRoZSBkcml2ZXIgS2NvbmZpZzoKPiAJZGVwZW5kcyBvbiAhRlJBTUVC
VUZGRVJfQ09OU09MRQo+IAo+IE90aGVyd2lzZSBpdCB3aWxsIGNyYXNoIGlmIHNvbWVvbmUgdHJp
ZXMgdG8gdXNlIGl0Lgo+IAo+IFRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCB0aGlzIGRyaXZlciBk
b2Vzbid0IG1hcCBhIHZpcnR1YWwgYWRkcmVzcyBmb3IKPiBpdHMgYnVmZmVyczoKPiAJbXRrX2dl
bS0+ZG1hX2F0dHJzIHw9IERNQV9BVFRSX05PX0tFUk5FTF9NQVBQSU5HOwo+IAo+IFByb2JhYmx5
IGJlY2F1c2Ugb2YgbGltaXRlZCB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2UuCj4gcm9ja2NoaXAgaXMg
aW4gdGhlIHNhbWUgc2l0dWF0aW9uLgo+IAo+IEknbSBhd2FyZSBvZiB0aGlzIHNob3J0Y29taW5n
IG9mIHRoZSBnZW5lcmljIGVtdWxhdGlvbiwgYnV0IEkgZG9uJ3Qgc2VlCj4gaG93IGl0IGNhbiBi
ZSBzb2x2ZWQgd2l0aG91dCB1c2luZyBzb21la2luZCBvZiBmbGFnIGF0dGFjaGVkIHRvIHRoZSBk
dW1iCj4gYnVmZmVyIGNyZWF0aW9uIHJlcXVlc3QuCgpUaGUgdmlydHVhbCBhZGRyZXNzIHNwYWNl
IGlzIGxpbWl0ZWQgc28gd2UgZG8gbm90IG1hcCBpdCBieSBkZWZhdWx0LiBJCmFsc28gc2VlIHRo
ZSBzaG9ydGNvbWluZyBvZiB0aGUgZ2VuZXJpYyBlbXVsYXRpb24sIHNvIEkgd291bGQgcmVmZXIg
dG8Kcm9ja2NoaXAgdG8gaW1wbGVtZW50IHRoaXMgbWFwcGluZy4KClJlZ2FyZHMsCkNLCgo+IAo+
IE5vcmFsZi4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
