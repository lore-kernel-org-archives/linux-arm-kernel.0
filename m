Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23062C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86DD2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M2ZOUOBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86DD2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UxjKAEK7Q58we12fSDTBBEiKRC7DOmDwAJeLRi+MZq4=; b=M2ZOUOBiKsAMdA
	bnRYagzLjpkWmcbVlf1l8Oizjjsm0FwtBXFx4TQlmclLkPuND8+9inojIKXFTWLNvp8MeR9GRfeT2
	+jk1fPD4aa46orLT4bhHXH+EAheMPnoblgiP1IQ/0fwpT9gR87rHiPtHf2dce4ZsHcm+e/lwQIVSG
	/UvuDXsQRbbUbCkHxtZShB17OejYBq7dtmgBe5IGJ9dQSY//D8WBUpC/T9Sf8PfirMwK0SIMJ7NUV
	jSlio0iA99p2Cvph8YtoOF/2wt/k3YO6ji60wIokXV/k0VR78HaXuXqA4skI4quHWKLG6Hy/m7w64
	Z81OB8wYWk9nGbIpbMBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkQkZ-00066J-Om; Fri, 18 Jan 2019 09:47:43 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQkW-00065K-5u; Fri, 18 Jan 2019 09:47:41 +0000
X-UUID: 6783b32f7dbc4519882851d5a4889a03-20190118
X-UUID: 6783b32f7dbc4519882851d5a4889a03-20190118
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 672631624; Fri, 18 Jan 2019 01:47:37 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 01:47:36 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 17:47:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 17:47:33 +0800
Message-ID: <1547804853.8124.9.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From: Ryder Lee <ryder.lee@mediatek.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Fri, 18 Jan 2019 17:47:33 +0800
In-Reply-To: <20190118080552.ppwgxboh3gt3nasv@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <20190118080552.ppwgxboh3gt3nasv@pengutronix.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_014740_219499_C4A0AAA2 
X-CRM114-Status: GOOD (  20.75  )
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
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMDE5LTAxLTE4IGF0IDA5OjA1ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToKPiBIZWxsbywKPiAKPiBqdXN0IHJlYWxpemVkIGFub3RoZXIgaXNzdWUgd2hpbGUgbG9va2lu
ZyB1cCBhIGRyaXZlciBkZXRhaWwgLi4uCj4gCj4gT24gRnJpLCBKYW4gMTgsIDIwMTkgYXQgMTE6
MjQ6NDFBTSArMDgwMCwgUnlkZXIgTGVlIHdyb3RlOgo+ID4gVGhpcyBhZGRzIGEgcHJvcGVydHkg
Im1lZGlhdGVrLG51bS1wd21zIiB0byBhdm9pZCBoYXZpbmcgYW4gZW5kbGVzcwo+ID4gbGlzdCBv
ZiBjb21wYXRpYmxlcyB3aXRoIG5vIGRpZmZlcmVuY2VzIGZvciB0aGUgc2FtZSBkcml2ZXIuCj4g
PiAKPiA+IFRodXMsIHRoZSBkcml2ZXIgc2hvdWxkIGhhdmUgYmFja3dhcmRzIGNvbXBhdGliaWxp
dHkgdG8gb2xkZXIgRFRzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVy
LmxlZUBtZWRpYXRlay5jb20+Cj4gPiAtLS0KPiA+IENoYW5nZXMgc2luY2UgdjE6IGFkZCBzb21l
IGNoZWNrcyBmb3IgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkuCj4gPiAtLS0KPiA+ICBkcml2ZXJz
L3B3bS9wd20tbWVkaWF0ZWsuYyB8IDI3ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+ID4gCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMgYi9kcml2ZXJzL3B3bS9w
d20tbWVkaWF0ZWsuYwo+ID4gaW5kZXggZWI2Njc0Yy4uODFiN2U1ZSAxMDA2NDQKPiA+IC0tLSBh
L2RyaXZlcnMvcHdtL3B3bS1tZWRpYXRlay5jCj4gPiArKysgYi9kcml2ZXJzL3B3bS9wd20tbWVk
aWF0ZWsuYwo+ID4gQEAgLTU1LDcgKzU1LDcgQEAgZW51bSB7Cj4gPiAgfTsKPiA+ICAKPiA+ICBz
dHJ1Y3QgbXRrX3B3bV9wbGF0Zm9ybV9kYXRhIHsKPiA+IC0JdW5zaWduZWQgaW50IG51bV9wd21z
Owo+ID4gKwl1bnNpZ25lZCBpbnQgbnVtX3B3bXM7CS8qIGl0IHNob3VsZCBub3QgYmUgdXNlZCBp
biB0aGUgZnV0dXJlIFNvQ3MgKi8KPiA+ICAJYm9vbCBwd200NV9maXh1cDsKPiA+ICAJYm9vbCBo
YXNfY2xrczsKPiA+ICB9Owo+ID4gQEAgLTIyNiwyNyArMjI2LDM2IEBAIHN0YXRpYyB2b2lkIG10
a19wd21fZGlzYWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpw
d20pCj4gPiAgCj4gPiAgc3RhdGljIGludCBtdGtfcHdtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCj4gPiAgewo+ID4gLQljb25zdCBzdHJ1Y3QgbXRrX3B3bV9wbGF0Zm9ybV9k
YXRhICpkYXRhOwo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25v
ZGU7Cj4gPiAgCXN0cnVjdCBtdGtfcHdtX2NoaXAgKnBjOwo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2Ug
KnJlczsKPiA+IC0JdW5zaWduZWQgaW50IGk7Cj4gPiArCXVuc2lnbmVkIGludCBpLCBudW1fcHdt
czsKPiA+ICAJaW50IHJldDsKPiA+ICAKPiA+ICAJcGMgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRl
diwgc2l6ZW9mKCpwYyksIEdGUF9LRVJORUwpOwo+ID4gIAlpZiAoIXBjKQo+ID4gIAkJcmV0dXJu
IC1FTk9NRU07Cj4gPiAgCj4gPiAtCWRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBk
ZXYtPmRldik7Cj4gPiAtCWlmIChkYXRhID09IE5VTEwpCj4gPiAtCQlyZXR1cm4gLUVJTlZBTDsK
PiA+IC0JcGMtPnNvYyA9IGRhdGE7Cj4gPiArCXBjLT5zb2MgPSBvZl9kZXZpY2VfZ2V0X21hdGNo
X2RhdGEoJnBkZXYtPmRldik7Cj4gPiAgCj4gPiAgCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJj
ZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7Cj4gPiAgCXBjLT5yZWdzID0gZGV2bV9pb3JlbWFw
X3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7Cj4gPiAgCWlmIChJU19FUlIocGMtPnJlZ3MpKQo+
ID4gIAkJcmV0dXJuIFBUUl9FUlIocGMtPnJlZ3MpOwo+ID4gIAo+ID4gLQlmb3IgKGkgPSAwOyBp
IDwgZGF0YS0+bnVtX3B3bXMgKyAyICYmIHBjLT5zb2MtPmhhc19jbGtzOyBpKyspIHsKPiA+ICsJ
LyogQ2hlY2sgaWYgd2UgaGF2ZSBzZXQgJ251bS1wd21zJyBpbiBEVHMuICovCj4gPiArCXJldCA9
IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAibWVkaWF0ZWssbnVtLXB3bXMiLCAmbnVtX3B3bXMp
Owo+ID4gKwlpZiAocmV0IDwgMCkgewo+ID4gKwkJLyogSWYgbm8sIGZhbGxiYWNrIHRvIHVzZSBT
b0MgZGF0YSBmb3IgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkuICovCj4gPiArCQlpZiAocGMtPnNv
Yy0+bnVtX3B3bXMpIHsKPiA+ICsJCQludW1fcHdtcyA9IHBjLT5zb2MtPm51bV9wd21zOwo+ID4g
KwkJfSBlbHNlIHsKPiA+ICsJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IHB3
bSBudW1iZXI6ICVkXG4iLCByZXQpOwo+ID4gKwkJCXJldHVybiByZXQ7Cj4gPiArCQl9Cj4gPiAr
CX0KPiA+ICsKPiA+ICsJZm9yIChpID0gMDsgaSA8IG51bV9wd21zICsgMiAmJiBwYy0+c29jLT5o
YXNfY2xrczsgaSsrKSB7Cj4gPiAgCQlwYy0+Y2xrc1tpXSA9IGRldm1fY2xrX2dldCgmcGRldi0+
ZGV2LCBtdGtfcHdtX2Nsa19uYW1lW2ldKTsKPiAKPiBJZiBhIGR0IGNvbnRhaW5zCj4gCj4gCW1l
ZGlhdGVrLG51bS1wd21zID0gPDE3PjsKPiAKPiB5b3UncmUgYWNjZXNzaW5nIHBjLT5jbGtzWzE4
XSB3aGljaCBpcyBhbiBvdXQtb2YtYm91bmRzIGFjY2Vzcywgc28KPiBiZXR0ZXIgY2hlY2sgdGhl
IGxpbWl0IG9yIGFsbG9jYXRlIHRoZSBjbGtzIGFycmF5IGR5bmFtaWNhbGx5Lgo+IAoKVGhhbmtz
IGZvciB0aGUgcmVtaW5kZXIuIEkgd2lsbCBmaXggaXQgaW4gdjIuCgpSeWRlcgoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
