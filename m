Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:36:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C4D20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S2Pc04EC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CCD6vVGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C4D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rJvWZ0yVLFOHwS5nNViocU3Z90J5U706iKARBzTrvto=; b=S2Pc04ECEccxA3
	ddaKf1imbKtsS1fQguzvjg7niD9sx+5gOwC3/SIapwEc+9W92tsre5g9G13GByb42XbJBIs1B9neq
	QgB8BQJwP0tllhg1FYSn66/ZgDKwCs3N33utTwD3B2MCnE3Bg/oUdft2FX6sy40hMrIaEqa5T0LqH
	fDaAsVbqp9JF2YQFy0Y379jFMhz96IrBxXmTCYfxudIZIx1S1eG2MG9Lq4v7sjWMpSJdZU/bZ40BM
	zlrGqGgQ7F9BngIZERlutwdgnFYHHahLEtpYeMaTGXBzXxU6xcePhnIepRpNCgJweVeotO5V1QsoB
	fiAhwOyNm06kVHVmsqbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRgu-0000FW-RN; Tue, 29 Jan 2019 11:36:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRgj-0000Ab-3C; Tue, 29 Jan 2019 11:36:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v5KDhjrHiLixwS8yNzXS4R8ljKw6xEYTjw2+QACuDXE=; b=CCD6vVGwFPXGdXAupPlmzbIIdL
 rn417Fa0StSA5sZDr7T8psTsiarp74z/QDPFU4nOY/x7wH3BMtb++1/4Mgt6L3PXZxKloaRl9415J
 BlKYHGThEiA6SFbHbigwNx5c43rUW3fpR3qrUctqi2bDyukQ+XQLymMuQDS1nyehMKHpKJrEg05/2
 8CDELQAKD/yyKIPnfmwuafTKWSd8lcXZUQSUcyJsZEICl/6O9yz/A7Bw5nZ0YX9QK4+5fpmMRc2dc
 TfQlcy3zwy1LlxNOyw8dMqvt1I8mSeO0oyNZqOwhK/KvnFZYxSrn1lsnxPSpXTEbW1BAOpekji8Vg
 HcG6+10w==;
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRgf-00062u-HG; Tue, 29 Jan 2019 11:36:19 +0000
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
 (Authenticated sender: hadess@hadess.net)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 670D8C0005;
 Tue, 29 Jan 2019 11:35:43 +0000 (UTC)
Message-ID: <40a185818ed76b2965b117d62fae2d21264d1fb7.camel@hadess.net>
Subject: Re: [PATCH v2] input: goodix - support Goodix gt5688
From: Bastien Nocera <hadess@hadess.net>
To: Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Date: Tue, 29 Jan 2019 12:35:42 +0100
In-Reply-To: <20190129111113.GA32222@bogon.m.sigxcpu.org>
References: <20190129111113.GA32222@bogon.m.sigxcpu.org>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_113617_587381_1E09E491 
X-CRM114-Status: GOOD (  16.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMDE5LTAxLTI5IGF0IDEyOjExICswMTAwLCBHdWlkbyBHw7xudGhlciB3cm90ZToK
PiBGcm9tIHdoYXQgSSd2ZSBzZWVuIGluIHZlbmRvciB0cmVlcyBpdCdzIGZpbmUgdG8gdHJlYXQg
dGhpcyBhcyBndDF4wrkuCj4gVGVzdGVkIG9uIHRoZSBQdXJpc20gTGlicmVtIDUgRGV2a2l0IChS
b2NrdGVjaCBKSDA1N04wMDkwMCBwYW5lbCkuCj4gCj4gWzFdOiAKPiBodHRwczovL2dpdGh1Yi5j
b20vVGFkaVQ3L2FuZHJvaWRfa2VybmVsX210ay00LjQvdHJlZS9tYXN0ZXIvZHJpdmVycy9pbnB1
dC90b3VjaHNjcmVlbi9tZWRpYXRlay9HVDU2ODgKPiAKPiBTaWduZWQtb2ZmLWJ5OiBHdWlkbyBH
w7xudGhlciA8YWd4QHNpZ3hjcHUub3JnPgoKTm90IHN1cGVyIGZvbmQgb2YgdGhlIGNhc3VhbCBj
b21taXQgbWVzc2FnZSwgYnV0IHRoZSBjb2RlIGFuZApleHBsYW5hdGlvbiBhcmUgZmluZS4KClJl
dmlld2VkLWJ5OiBCYXN0aWVuIE5vY2VyYSA8aGFkZXNzQGhhZGVzcy5uZXQ+Cgo+IC0tLQo+IENo
YW5nZXMgZnJvbSB2MToKPiAqIEFkZCB0ZXN0ZWQgYm9hcmQgdG8gY29tbWl0IG1lc3NhZ2UKPiAK
PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L3RvdWNoc2NyZWVuL2dv
b2RpeC50eHQgfCAxICsKPiAgZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9nb29kaXguYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAyCj4gKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0Cj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LnR4dAo+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC50eHQKPiBpbmRleCBm
N2U5NWM1MmYzYzcuLjU3ZDNkODg3MGEwOSAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LnR4dAo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC90b3VjaHNjcmVlbi9nb29kaXgu
dHh0Cj4gQEAgLTMsNiArMyw3IEBAIERldmljZSB0cmVlIGJpbmRpbmdzIGZvciBHb29kaXggR1Q5
eHggc2VyaWVzCj4gdG91Y2hzY3JlZW4gY29udHJvbGxlcgo+ICBSZXF1aXJlZCBwcm9wZXJ0aWVz
Ogo+ICAKPiAgIC0gY29tcGF0aWJsZQkJOiBTaG91bGQgYmUgImdvb2RpeCxndDExNTEiCj4gKwkJ
CQkgb3IgImdvb2RpeCxndDU2ODgiCj4gIAkJCQkgb3IgImdvb2RpeCxndDkxMSIKPiAgCQkJCSBv
ciAiZ29vZGl4LGd0OTExMCIKPiAgCQkJCSBvciAiZ29vZGl4LGd0OTEyIgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC5jCj4gYi9kcml2ZXJzL2lucHV0L3Rv
dWNoc2NyZWVuL2dvb2RpeC5jCj4gaW5kZXggZjJkOWMyYzQxODg1Li40N2IxY2VkNDE1NzYgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9nb29kaXguYwo+ICsrKyBiL2Ry
aXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LmMKPiBAQCAtMjE2LDYgKzIxNiw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZ29vZGl4X2NoaXBfZGF0YQo+ICpnb29kaXhfZ2V0X2NoaXBfZGF0
YSh1MTYgaWQpCj4gIHsKPiAgCXN3aXRjaCAoaWQpIHsKPiAgCWNhc2UgMTE1MToKPiArCWNhc2Ug
NTY4ODoKPiAgCQlyZXR1cm4gJmd0MXhfY2hpcF9kYXRhOwo+ICAKPiAgCWNhc2UgOTExOgo+IEBA
IC05NDIsNiArOTQzLDcgQEAgTU9EVUxFX0RFVklDRV9UQUJMRShhY3BpLCBnb29kaXhfYWNwaV9t
YXRjaCk7Cj4gICNpZmRlZiBDT05GSUdfT0YKPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgZ29vZGl4X29mX21hdGNoW10gPSB7Cj4gIAl7IC5jb21wYXRpYmxlID0gImdvb2RpeCxn
dDExNTEiIH0sCj4gKwl7IC5jb21wYXRpYmxlID0gImdvb2RpeCxndDU2ODgiIH0sCj4gIAl7IC5j
b21wYXRpYmxlID0gImdvb2RpeCxndDkxMSIgfSwKPiAgCXsgLmNvbXBhdGlibGUgPSAiZ29vZGl4
LGd0OTExMCIgfSwKPiAgCXsgLmNvbXBhdGlibGUgPSAiZ29vZGl4LGd0OTEyIiB9LAoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
