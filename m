Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B882C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:29:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95C02081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GkzAxSCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95C02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ksnM34vDobSFBvSZ9/xtlgrPv/c0jv/Cy4jlxt07niY=; b=GkzAxSCmbQbroJ
	a9Ogy+bLdYhjbQGlz+DmH3eFslyL3do/3OfMeStEHRVpWEguz5Sk2CPfw/oZx4V6gjdh4EQ54Rkl2
	kGJGEt+5K+byArj6QozPHFNyu1e/r/JOjpZGJSKh5r9/7dUZ8VmN/wJjwljWfukF97zuEVa6nKp4N
	FZr+SCcinf1OOAb8PPmqUWHUP6my1M/c9+uGkk4IQQI2y9wsvd5UxAbCXfHPDF7dlHKPdsJjMKgqg
	KvvoQDHi7XmbL5EddJzNg8dYoWDiKZdw7Sfqv0JiwZDOv/xYAWE4X5w1TEHok4OCx95GO1KUBqWu0
	x8vNrd6dX1YQarCC4b8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWbXc-00080g-1B; Tue, 11 Dec 2018 06:29:12 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWbXW-0007ya-W3; Tue, 11 Dec 2018 06:29:09 +0000
X-UUID: d2d6ad3b42854a759334fc83043f32ad-20181211
X-UUID: d2d6ad3b42854a759334fc83043f32ad-20181211
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1434808722; Tue, 11 Dec 2018 14:28:30 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 11 Dec 2018 14:28:28 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Dec 2018 14:28:28 +0800
Message-ID: <1544509708.14641.6.camel@mhfsdcap03>
Subject: Re: [PATCH 1/5] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
From: mtk15107 <qii.wang@mediatek.com>
To: Sean Wang <sean.wang@kernel.org>
Date: Tue, 11 Dec 2018 14:28:28 +0800
In-Reply-To: <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-2-git-send-email-qii.wang@mediatek.com>
 <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_222907_366543_764403BE 
X-CRM114-Status: GOOD (  13.96  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com,
 srv_heupstream@mediatek.com, wsa@the-dreams.de, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMDE4LTEyLTA0IGF0IDEyOjE5IC0wODAwLCBTZWFuIFdhbmcgd3JvdGU6Cj4gPHFp
aS53YW5nQG1lZGlhdGVrLmNvbT4g5pa8IDIwMTjlubQxMuaciDPml6Ug6YCx5LiAIOS4iuWNiDU6
MzTlr6vpgZPvvJoKPiA+Cj4gPiBGcm9tOiBxaWkgd2FuZyA8cWlpLndhbmdAbWVkaWF0ZWsuY29t
Pgo+ID4KPiA+IEFkZCBNVDc2MjkgaTJjIGJpbmRpbmcgdG8gaTJjLW10MjcxMi50eHQgYW5kIHRo
ZXJlIGlzIG5vIG5lZWQgdG8KPiAKPiB3aGVyZSdzIGkyYy1tdDI3MTIudHh0IG1lbnRpb25lZCBo
ZXJlPwo+IAoKU29ycnksIEkgd2lsbCByZXdyaXRlIHRoaXMgY29tbWl0LiBTdWNoIGFzOgoKQWRk
IE1UNzYyOSBpMmMgYmluZGluZyB0byBiaW5kaW5nIGZpbGUuIAoKPiA+IG1vZGlmeSBpMmMgZHJp
dmVyLgo+IAo+IHN1Z2dlc3Qgbm90IHRvIG1lbnRpb24gZHJpdmVyIGluIGFueSBkdC1iaW5kaW5n
LCBkdC1iaW5kaW5nIHNlbGYKPiBzaG91bGQgYmUgb3MtYWdub3N0aWMKPiAKClllcywgSSB3aWxs
IHJlbW92ZSBpdC4KCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogcWlpIHdhbmcgPHFpaS53YW5nQG1l
ZGlhdGVrLmNvbT4KPiA+IC0tLQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pMmMvaTJjLW10ay50eHQgfCAgICAxICsKPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2kyYy9pMmMtbXRrLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
MmMvaTJjLW10ay50eHQKPiA+IGluZGV4IGUxOTk2OTUuLjc3MjllNTcgMTAwNjQ0Cj4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdGsudHh0Cj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdGsudHh0Cj4g
PiBAQCAtMTAsNiArMTAsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ID4gICAgICAgICJtZWRp
YXRlayxtdDY1ODktaTJjIjogZm9yIE1lZGlhVGVrIE1UNjU4OQo+ID4gICAgICAgICJtZWRpYXRl
ayxtdDc2MjItaTJjIjogZm9yIE1lZGlhVGVrIE1UNzYyMgo+ID4gICAgICAgICJtZWRpYXRlayxt
dDc2MjMtaTJjIiwgIm1lZGlhdGVrLG10NjU3Ny1pMmMiOiBmb3IgTWVkaWFUZWsgTVQ3NjIzCj4g
PiArICAgICAgIm1lZGlhdGVrLG10NzYyOS1pMmMiLCAibWVkaWF0ZWssbXQyNzEyLWkyYyI6IGZv
ciBNZWRpYVRlayBtdDc2MjkKPiAKPiBjaGFuZ2UgbXQ3NjI5IHRvIE1UNzYyOSB0byBhbGlnbiB0
byB0aGUgb3RoZXJzCj4gCgpPSy4KCj4gPiAgICAgICAgIm1lZGlhdGVrLG10ODE3My1pMmMiOiBm
b3IgTWVkaWFUZWsgTVQ4MTczCj4gPiAgICAtIHJlZzogcGh5c2ljYWwgYmFzZSBhZGRyZXNzIG9m
IHRoZSBjb250cm9sbGVyIGFuZCBkbWEgYmFzZSwgbGVuZ3RoIG9mIG1lbW9yeQo+ID4gICAgICBt
YXBwZWQgcmVnaW9uLgo+ID4gLS0KPiA+IDEuNy45LjUKPiA+Cj4gPgo+ID4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+IExpbnV4LW1lZGlhdGVrIG1h
aWxpbmcgbGlzdAo+ID4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZwo+ID4gaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlawoK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
