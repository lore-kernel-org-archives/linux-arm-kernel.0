Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:43:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926682086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E5USPFAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926682086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n6FgDDYrFCsHhXyKNHUVc3kF5M1KcS9EpS21Zs9xTnA=; b=E5USPFApbDXsOe
	kgpO3ucAFSv5FuDMONzmRlADV8YqXeXnHHsT0wFjECzfNE36ci9CZkS0h3hV3BVwXmZQ757ZOgmqL
	C8QxNv9UGkGcijYYtD0filO5qYrO2gQiTdJhVehMJXct+R98vsXUCGuJ7+McFpp8pRxoDIlngVL3/
	wSTeXJdC615fIPCEaYJchyutnAeeIl4LyN2UXtQt2NnMSMxga6o0qYoQ3+IvU0nL+hHIBLsazrhuN
	kYfAuhh+bn8dLGTvPweJrkoGuFlBLxngsFrWnwyNJAxmJz+Cl/wLhAseuYDHNaB0t9aStBalsMPHF
	FMiQVSgjDmr7pcBnOh0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkQgG-0003gJ-CB; Fri, 18 Jan 2019 09:43:16 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQgB-0003fO-Tc; Fri, 18 Jan 2019 09:43:13 +0000
X-UUID: 64a169ccea3a4134aa0e15e68a791507-20190118
X-UUID: 64a169ccea3a4134aa0e15e68a791507-20190118
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1340580828; Fri, 18 Jan 2019 01:42:58 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 01:42:56 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 17:42:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 17:42:53 +0800
Message-ID: <1547804574.8124.6.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From: Ryder Lee <ryder.lee@mediatek.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Fri, 18 Jan 2019 17:42:54 +0800
In-Reply-To: <20190118075925.noilab6glzm3cig6@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <20190118075925.noilab6glzm3cig6@pengutronix.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_014311_959178_A9B384B8 
X-CRM114-Status: GOOD (  23.78  )
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

T24gRnJpLCAyMDE5LTAxLTE4IGF0IDA4OjU5ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToKPiBIZWxsbywKPiAKPiBPbiBGcmksIEphbiAxOCwgMjAxOSBhdCAxMToyNDo0MUFNICswODAw
LCBSeWRlciBMZWUgd3JvdGU6Cj4gPiBUaGlzIGFkZHMgYSBwcm9wZXJ0eSAibWVkaWF0ZWssbnVt
LXB3bXMiIHRvIGF2b2lkIGhhdmluZyBhbiBlbmRsZXNzCj4gPiBsaXN0IG9mIGNvbXBhdGlibGVz
IHdpdGggbm8gZGlmZmVyZW5jZXMgZm9yIHRoZSBzYW1lIGRyaXZlci4KPiA+IAo+ID4gVGh1cywg
dGhlIGRyaXZlciBzaG91bGQgaGF2ZSBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSB0byBvbGRlciBE
VHMuCj4gCj4gSSBzdGlsbCB0aGluayBUaGllcnJ5IHNob3VsZCBibGVzcyAibnVtLXB3bXMiIHdp
dGhvdXQgdmVuZG9yIHByZWZpeC4KCk9rYXkuCgo+ID4gU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVl
IDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOiBh
ZGQgc29tZSBjaGVja3MgZm9yIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5Lgo+ID4gLS0tCj4gPiAg
ZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMgfCAyNyArKysrKysrKysrKysrKysrKystLS0tLS0t
LS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkK
PiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1tZWRpYXRlay5jIGIvZHJpdmVy
cy9wd20vcHdtLW1lZGlhdGVrLmMKPiA+IGluZGV4IGViNjY3NGMuLjgxYjdlNWUgMTAwNjQ0Cj4g
PiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYwo+ID4gKysrIGIvZHJpdmVycy9wd20v
cHdtLW1lZGlhdGVrLmMKPiA+IEBAIC01NSw3ICs1NSw3IEBAIGVudW0gewo+ID4gIH07Cj4gPiAg
Cj4gPiAgc3RydWN0IG10a19wd21fcGxhdGZvcm1fZGF0YSB7Cj4gCj4gVW5yZWxhdGVkIHRvIHRo
aXMgcGF0Y2g6IFRoaXMgbmFtZSBpcyBiYWQuIFRoaXMgc3RydWN0IGlzIG5vdCB1c2VkIGFzCj4g
cGxhdGZvcm1fZGF0YSBhbmQgc28gc2hvdWxkIGJldHRlciBiZSBuYW1lZCBtdGtfcHdtX29mX2Rh
dGEuIFdoaWxlIGF0Cj4gY3JpdGljaXppbmcgZXhpc3Rpbmcgc3R1ZmY6IEknZCBwcmVmZXIgcHdt
X21lZGlhdGVrIGFzIGNvbW1vbiBwcmVmaXggdG8KPiBtYXRjaCB0aGUgZmlsZW5hbWUuCgpJIHRo
aW5rIHdlIGNhbiB0YWtlIGNhcmUgYWJvdXQgdGhhdCBpbiBhbm90aGVyIHBhdGNoLgoKPiA+IC0J
dW5zaWduZWQgaW50IG51bV9wd21zOwo+ID4gKwl1bnNpZ25lZCBpbnQgbnVtX3B3bXM7CS8qIGl0
IHNob3VsZCBub3QgYmUgdXNlZCBpbiB0aGUgZnV0dXJlIFNvQ3MgKi8KPiAKPiBJJ2QgZHJvcCB0
aGlzIGNvbW1lbnQgaW4gZmF2b3VyIG9mIGEgcnVudGltZSB3YXJuaW5nLgoKU29ycnksIEkgY2Fu
J3QgZ2V0IHlvdSBoZXJlLgoKPiA+ICAJYm9vbCBwd200NV9maXh1cDsKPiA+ICAJYm9vbCBoYXNf
Y2xrczsKPiA+ICB9Owo+ID4gQEAgLTIyNiwyNyArMjI2LDM2IEBAIHN0YXRpYyB2b2lkIG10a19w
d21fZGlzYWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20p
Cj4gPiAgCj4gPiAgc3RhdGljIGludCBtdGtfcHdtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpCj4gPiAgewo+ID4gLQljb25zdCBzdHJ1Y3QgbXRrX3B3bV9wbGF0Zm9ybV9kYXRh
ICpkYXRhOwo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7
Cj4gPiAgCXN0cnVjdCBtdGtfcHdtX2NoaXAgKnBjOwo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJl
czsKPiA+IC0JdW5zaWduZWQgaW50IGk7Cj4gPiArCXVuc2lnbmVkIGludCBpLCBudW1fcHdtczsK
PiA+ICAJaW50IHJldDsKPiA+ICAKPiA+ICAJcGMgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwg
c2l6ZW9mKCpwYyksIEdGUF9LRVJORUwpOwo+ID4gIAlpZiAoIXBjKQo+ID4gIAkJcmV0dXJuIC1F
Tk9NRU07Cj4gPiAgCj4gPiAtCWRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYt
PmRldik7Cj4gPiAtCWlmIChkYXRhID09IE5VTEwpCj4gPiAtCQlyZXR1cm4gLUVJTlZBTDsKPiA+
IC0JcGMtPnNvYyA9IGRhdGE7Cj4gPiArCXBjLT5zb2MgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2Rh
dGEoJnBkZXYtPmRldik7Cj4gCj4gVGhpcyBtaWdodCByZXR1cm4gTlVMTCB3aGljaCAuLi4KClRo
ZSBvbmx5IHdheSB0byBjYWxsIHByb2JlKCkgaXMgdG8gbWF0Y2ggYW4gZW50cnkgaW4KbXRrX3B3
bV9vZl9tYXRjaFtdLCBzbyBtYXRjaCBjYW5ub3QgYmUgTlVMTC4KCj4gPiAgCj4gPiAgCXJlcyA9
IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7Cj4gPiAgCXBj
LT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7Cj4gPiAgCWlm
IChJU19FUlIocGMtPnJlZ3MpKQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIocGMtPnJlZ3MpOwo+ID4g
IAo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgZGF0YS0+bnVtX3B3bXMgKyAyICYmIHBjLT5zb2MtPmhh
c19jbGtzOyBpKyspIHsKPiA+ICsJLyogQ2hlY2sgaWYgd2UgaGF2ZSBzZXQgJ251bS1wd21zJyBp
biBEVHMuICovCj4gPiArCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAibWVkaWF0ZWss
bnVtLXB3bXMiLCAmbnVtX3B3bXMpOwo+ID4gKwlpZiAocmV0IDwgMCkgewo+ID4gKwkJLyogSWYg
bm8sIGZhbGxiYWNrIHRvIHVzZSBTb0MgZGF0YSBmb3IgYmFja3dhcmRzIGNvbXBhdGliaWxpdHku
ICovCj4gPiArCQlpZiAocGMtPnNvYy0+bnVtX3B3bXMpIHsKPiAKPiAuLi4gaGVyZSB0aGVuIHJl
c3VsdHMgaW4gYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuIEkgdGhpbmsgeW91IHdhbnQKClNv
IHdlIGhhdmUgbm8gY2hhbmNlIHRvIGdldCBhIE5VTEwgcG9pbnRlciwgcmlnaHQ/Cgo+IAkJaWYg
KHBjLT5zb2MpCj4gCj4gaGVyZS4KPiAKPiA+ICsJCQludW1fcHdtcyA9IHBjLT5zb2MtPm51bV9w
d21zOwo+ID4gKwkJfSBlbHNlIHsKPiA+ICsJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQg
dG8gZ2V0IHB3bSBudW1iZXI6ICVkXG4iLCByZXQpOwo+ID4gKwkJCXJldHVybiByZXQ7Cj4gPiAr
CQl9Cj4gPiArCX0KPiA+ICsKPiA+ICsJZm9yIChpID0gMDsgaSA8IG51bV9wd21zICsgMiAmJiBw
Yy0+c29jLT5oYXNfY2xrczsgaSsrKSB7Cj4gPiAgCQlwYy0+Y2xrc1tpXSA9IGRldm1fY2xrX2dl
dCgmcGRldi0+ZGV2LCBtdGtfcHdtX2Nsa19uYW1lW2ldKTsKPiA+ICAJCWlmIChJU19FUlIocGMt
PmNsa3NbaV0pKSB7Cj4gPiAgCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiY2xvY2s6ICVzIGZhaWw6
ICVsZFxuIiwKPiA+IEBAIC0yNjAsNyArMjY5LDcgQEAgc3RhdGljIGludCBtdGtfcHdtX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiAgCXBjLT5jaGlwLmRldiA9ICZwZGV2
LT5kZXY7Cj4gPiAgCXBjLT5jaGlwLm9wcyA9ICZtdGtfcHdtX29wczsKPiA+ICAJcGMtPmNoaXAu
YmFzZSA9IC0xOwo+ID4gLQlwYy0+Y2hpcC5ucHdtID0gZGF0YS0+bnVtX3B3bXM7Cj4gPiArCXBj
LT5jaGlwLm5wd20gPSBudW1fcHdtczsKPiA+ICAKPiA+ICAJcmV0ID0gcHdtY2hpcF9hZGQoJnBj
LT5jaGlwKTsKPiA+ICAJaWYgKHJldCA8IDApIHsKPiAKPiBCZXN0IHJlZ2FyZHMKPiBVd2UKPiAK
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
