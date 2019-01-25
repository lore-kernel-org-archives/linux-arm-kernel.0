Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057D5C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:48:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2A921855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TpZsLk3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2A921855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y4vADlM+PEHWbunpQf9KEgcmszdqQi0NyZXRqBzclfw=; b=TpZsLk3/j5/cVn
	lQSS3ikm5xo8iepxVfQSohx40liu2e2zBmOnRaVcWD58HFhYeclKVv7aTn+kZu0q6Lkm5MaXvRW2a
	F77TJwchcv9PkQmtzdBbov7cMidwgoiC7hYLpTJXeImi4XKXLufbCqav7sAW4DJLjYGAu8v0iVTID
	PWb14JuKEh+9nDG5rGObfX9rcLuWF65yYA+3mbSmR6pmunynwXXQ5sClRIY+V+LVgDvlFbYAO51hk
	1S1Ty74IPHMH24+xm5VLcWlsf6K5QoOw4b5/UUNxEY4Q2rCWDtitI1e7OUp3nth1WmwUlfV9XpJlT
	N/MTEwSqV2k3bOu51GZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmsU7-0001S4-Mm; Fri, 25 Jan 2019 03:48:51 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmsU4-0001Ra-DD; Fri, 25 Jan 2019 03:48:50 +0000
X-UUID: e70389fcf37f4110b6302cc55657fb0c-20190124
X-UUID: e70389fcf37f4110b6302cc55657fb0c-20190124
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1325140564; Thu, 24 Jan 2019 19:48:40 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 19:48:39 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 25 Jan 2019 11:48:35 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 25 Jan 2019 11:48:36 +0800
Message-ID: <1548388116.29237.15.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From: Ryder Lee <ryder.lee@mediatek.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 "John Crispin" <blogic@openwrt.org>
Date: Fri, 25 Jan 2019 11:48:36 +0800
In-Reply-To: <20190121084948.frpcgg6wkdjxkl7k@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <c007d399-af86-98d3-94f9-b9762efdc219@gmail.com>
 <1547866487.14213.10.camel@mtkswgap22>
 <20190121084948.frpcgg6wkdjxkl7k@pengutronix.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_194848_449754_912FC74E 
X-CRM114-Status: GOOD (  28.43  )
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
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sean Wang <sean.wang@kernel.org>,
 Weijie Gao =?UTF-8?Q?=28=E9=AB=98=E6=83=9F=E6=9D=B0=29?=
 <Weijie.Gao@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry
 Reding <thierry.reding@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

K0pvaG4KCkhJIEpvaG4sCgpPbiBNb24sIDIwMTktMDEtMjEgYXQgMTY6NDkgKzA4MDAsIFV3ZSBL
bGVpbmUtS8O2bmlnIHdyb3RlOgo+IE9uIFNhdCwgSmFuIDE5LCAyMDE5IGF0IDEwOjU0OjQ3QU0g
KzA4MDAsIFJ5ZGVyIExlZSB3cm90ZToKPiA+IE9uIEZyaSwgMjAxOS0wMS0xOCBhdCAwOTo0MyAr
MDEwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToKPiA+ID4KPiA+ID4gT24gMTgvMDEvMjAxOSAw
NDoyNCwgUnlkZXIgTGVlIHdyb3RlOgo+ID4gPiA+IFRoaXMgYWRkcyBhIHByb3BlcnR5ICJtZWRp
YXRlayxudW0tcHdtcyIgdG8gYXZvaWQgaGF2aW5nIGFuIGVuZGxlc3MKPiA+ID4gPiBsaXN0IG9m
IGNvbXBhdGlibGVzIHdpdGggbm8gZGlmZmVyZW5jZXMgZm9yIHRoZSBzYW1lIGRyaXZlci4KPiA+
ID4gPgo+ID4gPiA+IFRodXMsIHRoZSBkcml2ZXIgc2hvdWxkIGhhdmUgYmFja3dhcmRzIGNvbXBh
dGliaWxpdHkgdG8gb2xkZXIgRFRzLgo+ID4gPiA+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUnlk
ZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+IENoYW5n
ZXMgc2luY2UgdjE6IGFkZCBzb21lIGNoZWNrcyBmb3IgYmFja3dhcmRzIGNvbXBhdGliaWxpdHku
Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvcHdtL3B3bS1tZWRpYXRlay5jIHwgMjcgKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcHdtL3B3bS1tZWRpYXRlay5jIGIvZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMKPiA+
ID4gPiBpbmRleCBlYjY2NzRjLi44MWI3ZTVlIDEwMDY0NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
cHdtL3B3bS1tZWRpYXRlay5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wd20vcHdtLW1lZGlhdGVr
LmMKPiA+ID4gPiBAQCAtNTUsNyArNTUsNyBAQCBlbnVtIHsKPiA+ID4gPiAgfTsKPiA+ID4gPgo+
ID4gPiA+ICBzdHJ1Y3QgbXRrX3B3bV9wbGF0Zm9ybV9kYXRhIHsKPiA+ID4gPiAtIHVuc2lnbmVk
IGludCBudW1fcHdtczsKPiA+ID4gPiArIHVuc2lnbmVkIGludCBudW1fcHdtczsgIC8qIGl0IHNo
b3VsZCBub3QgYmUgdXNlZCBpbiB0aGUgZnV0dXJlIFNvQ3MgKi8KPiA+ID4gPiAgIGJvb2wgcHdt
NDVfZml4dXA7Cj4gPiA+ID4gICBib29sIGhhc19jbGtzOwo+ID4gPiA+ICB9Owo+ID4gPiA+IEBA
IC0yMjYsMjcgKzIyNiwzNiBAQCBzdGF0aWMgdm9pZCBtdGtfcHdtX2Rpc2FibGUoc3RydWN0IHB3
bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtKQo+ID4gPiA+Cj4gPiA+ID4gIHN0
YXRpYyBpbnQgbXRrX3B3bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4g
PiA+ICB7Cj4gPiA+ID4gLSBjb25zdCBzdHJ1Y3QgbXRrX3B3bV9wbGF0Zm9ybV9kYXRhICpkYXRh
Owo+ID4gPiA+ICsgc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOwo+
ID4gPiA+ICAgc3RydWN0IG10a19wd21fY2hpcCAqcGM7Cj4gPiA+ID4gICBzdHJ1Y3QgcmVzb3Vy
Y2UgKnJlczsKPiA+ID4gPiAtIHVuc2lnbmVkIGludCBpOwo+ID4gPiA+ICsgdW5zaWduZWQgaW50
IGksIG51bV9wd21zOwo+ID4gPiA+ICAgaW50IHJldDsKPiA+ID4gPgo+ID4gPiA+ICAgcGMgPSBk
ZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpwYyksIEdGUF9LRVJORUwpOwo+ID4gPiA+
ICAgaWYgKCFwYykKPiA+ID4gPiAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4gPiA+ID4KPiA+
ID4gPiAtIGRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7Cj4gPiA+
ID4gLSBpZiAoZGF0YSA9PSBOVUxMKQo+ID4gPiA+IC0gICAgICAgICByZXR1cm4gLUVJTlZBTDsK
PiA+ID4gPiAtIHBjLT5zb2MgPSBkYXRhOwo+ID4gPiA+ICsgcGMtPnNvYyA9IG9mX2RldmljZV9n
ZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsKPiA+ID4gPgo+ID4gPiA+ICAgcmVzID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKPiA+ID4gPiAgIHBjLT5y
ZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7Cj4gPiA+ID4gICBp
ZiAoSVNfRVJSKHBjLT5yZWdzKSkKPiA+ID4gPiAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIocGMt
PnJlZ3MpOwo+ID4gPiA+Cj4gPiA+ID4gLSBmb3IgKGkgPSAwOyBpIDwgZGF0YS0+bnVtX3B3bXMg
KyAyICYmIHBjLT5zb2MtPmhhc19jbGtzOyBpKyspIHsKPiA+ID4gPiArIC8qIENoZWNrIGlmIHdl
IGhhdmUgc2V0ICdudW0tcHdtcycgaW4gRFRzLiAqLwo+ID4gPiA+ICsgcmV0ID0gb2ZfcHJvcGVy
dHlfcmVhZF91MzIobnAsICJtZWRpYXRlayxudW0tcHdtcyIsICZudW1fcHdtcyk7Cj4gPiA+ID4g
KyBpZiAocmV0IDwgMCkgewo+ID4gPiA+ICsgICAgICAgICAvKiBJZiBubywgZmFsbGJhY2sgdG8g
dXNlIFNvQyBkYXRhIGZvciBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eS4gKi8KPiA+ID4gPiArICAg
ICAgICAgaWYgKHBjLT5zb2MtPm51bV9wd21zKSB7Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
bnVtX3B3bXMgPSBwYy0+c29jLT5udW1fcHdtczsKPiA+ID4KPiA+ID4gTWF5YmUgdGhhdCdzIGJp
a2Ugc2hlZGRpbmcsIGJ1dCBJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBjYXJ2ZSBvdXQg
dGhlCj4gPiA+IG51bV9wd21zIGZyb20gdGhlIG10a19wd21fcGxhdGZvcm1fZGF0YSBhbmQgY2hl
Y2sgYWdhaW5zdCB0aGUgY29tcGF0aWJsZSBoZXJlLgo+ID4KPiA+IEknbSBub3Qgc3VyZSBob3cg
dG8gcHJvcGVybHkgY3VydmUgaXQgb3V0PyBJIHRoaW5rIHdlIHN0aWxsIG5lZWQgdGhpcwo+ID4g
dmFyaWFibGUgdG8gc2F2ZSB0aGUgc3BlY2lmaWMgdmFsdWUgZm9yIHNvbWUgbGVnYWN5IFNvQ3Mg
KHdpdGggb2xkZXIKPiA+IERUcykuCj4gCj4gSSBndWVzcyBoZSBtZWFucyAgc29tZXRoaW5nIGxp
a2U6Cj4gCj4gICAgICAgICBpZiAoaXNfY29tcGF0aWJsZV90b192YXJpYW50X0EoZGV2KSkKPiAg
ICAgICAgICAgICAgICAgbnVtX3B3bXMgPSAxMjsKPiAgICAgICAgIGVsc2UgaWYgKGlzX2NvbXBh
dGlibGVfdG9fdmFyaWFudF9CKGRldikpCj4gICAgICAgICAgICAgICAgIG51bV9wd21zID0gMjsK
PiAKPiAuIEluIG15IGV5ZXMgdGhlIGJpa2Ugc2hlZCBzaG91bGQgYmUgbGlnaHQgcmVkIGFuZCBJ
IHByZWZlciB0byBjb2xsZWN0Cj4gdGhlIGZhbGxiYWNrIG51bV9wd21zIGluIHRoZSBjb21wYXRp
YmxlX2RhdGEgYXMgaXMgdG8ga2VlcCB0aGUgY29kZQo+IHNpbXBsZXIuIE1heWJlIHJlbmFtZSB0
aGUgbWVtYmVyIGZyb20gbnVtX3B3bXMgdG8gZmFsbGJhY2tfbnVtX3B3bXMgdG8KPiBtYWtlIGl0
IG1vcmUgb2J2aW91cyB0aGF0IGl0IGRvZXNuJ3QgcmVwcmVzZW50IHRoZSBhY3R1YWxseSB1c2Vk
IHZhbHVlLgo+IAo+ID4gPiBXaXRoIGEgZXhwcmVzc2l2ZSBjb21tZW50IGl0IHdpbGwgaGVscCBv
dGhlciBkcml2ZXIgZGV2ZWxvcGVycyB0byBub3Qgc3RhcnQKPiA+ID4gYWRkaW5nIG51bV9wd21z
IGluIHRoZSBwbGF0Zm9ybSBkYXRhIGluIHRoZWlyIGZpcnN0IGF0dGVtcHQuCj4gPgo+ID4gRGVm
aW5pdGVseS4KPiAKPiBNeSBzdWdnZXN0aW9uIHdhcyB0byBhZGQgYSBkZXZfd2Fybiwgd2hpY2gg
SU1ITyBpcyBzdGlsbCBiZXR0ZXIgdGhhbiBhCj4gY29tbWVudC4KPiAKPiBCZXN0IHJlZ2FyZHMK
PiBVd2UKPiAKClVucmVsYXRlZCB0byB0aGlzIHBhdGNoOiBJJ20gcmVhZHkgdG8gc2VuZCB2MiB0
byBhbGxvY2F0ZSB0aGUgY2xrcyBhcnJheQpkeW5hbWljYWxseSwgYnV0IEkgZ3Vlc3MgTVQ3NjI4
IGNvdWxkbid0IHdvcmsgaW4gb3JpZ2luYWwgY29kZS4KCgpJbiBtdGtfcHdtX2NvbmZpZygpOgoK
CWNsayA9IHBjLT5jbGtzW01US19DTEtfUFdNMSArIHB3bS0+aHdwd21dOyAKCS4uLi4KCXJlc29s
dXRpb24gPSAodTY0KU5TRUNfUEVSX1NFQyAqIDEwMDA7Cglkb19kaXYocmVzb2x1dGlvbiwgY2xr
X2dldF9yYXRlKGNsaykpOwoJLi4uLgoKSSB0aGluayBjbGsgc2hvdWxkIGJlIE5VTEwgYW5kIHJl
c29sdXRpb24gaXMgYWx3YXlzIDAgaGVyZS4gCgoKUnlkZXIKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
