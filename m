Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BAC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:08:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53FC2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FGE7nBle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53FC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tMgRixNzJTa1GZmT5WJYoMW60x4dyZlzd8kJe58Qmgo=; b=FGE7nBleZFk6z6
	kl0YD7fHjdRN1vjY2q+rk0l0ESBxD75UNhbhse+KyO24yplO9hgYUf2r063W+LQ7xFl+F5qQAJbRK
	TCYzOajC5tK+mYXuwsgRryqAYjTJIUNREa3Hed+/XunC6QFEKs2G8y/KwmATL3+32ebW1qn1rOQnm
	wwXj8W/IMvLfBjjppIF5KVuEP5jphy3pdElE9/4B2PbAWWZCAvadPYDx4z/u0PFjS4hpnH4pRxwSu
	CXHTxbRhWlrBt8afOXF/P4PQvqKxGazy0XHstuSFLLq4WheHFNLlwy0YLi7kADl3ma9Bptxt7/bGL
	GomFvxujmPRKHSHtfziA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWe19-0001ih-Au; Tue, 11 Dec 2018 09:07:51 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWe13-0001hS-Sw; Tue, 11 Dec 2018 09:07:47 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CD42320862; Tue, 11 Dec 2018 10:07:28 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 504AC20723;
 Tue, 11 Dec 2018 10:07:18 +0100 (CET)
Date: Tue, 11 Dec 2018 10:07:18 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liang Yang <liang.yang@amlogic.com>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181211100718.51d2cd6c@xps13>
In-Reply-To: <356aed95-518d-7cd0-4337-184f181472ad@amlogic.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13>
 <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
 <20181210123809.5ade45c4@bbrezillon>
 <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
 <20181210155057.38788656@xps13>
 <d60bac6f-732d-0ddc-2644-17f650dfa885@amlogic.com>
 <20181211085445.68e57e0e@xps13>
 <356aed95-518d-7cd0-4337-184f181472ad@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_010746_212593_E72BC0AC 
X-CRM114-Status: GOOD (  20.95  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@bootlin.com>, Jian Hu <jian.hu@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTGlhbmcsCgpMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90ZSBvbiBU
dWUsIDExIERlYyAyMDE4IDE2OjM2OjQ3CiswODAwOgoKPiBIaSBNaXF1ZWwsCj4gCj4gVGhhbmtz
IGZvciB5b3VyIHF1aWNrbHkgcmVwbHkuCj4gCj4gT24gMjAxOC8xMi8xMSAxNTo1NCwgTWlxdWVs
IFJheW5hbCB3cm90ZToKPiA+IEhpIExpYW5nLAo+ID4gCj4gPiBMaWFuZyBZYW5nIDxsaWFuZy55
YW5nQGFtbG9naWMuY29tPiB3cm90ZSBvbiBUdWUsIDExIERlYyAyMDE4IDA5OjU2OjI1Cj4gPiAr
MDgwMDoKPiA+ICAgCj4gPj4gSGkgTWlxdWVsLAo+ID4+Cj4gPj4gT24gMjAxOC8xMi8xMCAyMjo1
MCwgTWlxdWVsIFJheW5hbCB3cm90ZTogIAo+ID4+PiBIaSBMaWFuZywKPiA+Pj4KPiA+Pj4gTGlh
bmcgWWFuZyA8bGlhbmcueWFuZ0BhbWxvZ2ljLmNvbT4gd3JvdGUgb24gTW9uLCAxMCBEZWMgMjAx
OCAyMDoxMjozOQo+ID4+PiArMDgwMDogIAo+ID4+PiAgICA+Pj4+IE9uIDIwMTgvMTIvMTAgMTk6
MzgsIEJvcmlzIEJyZXppbGxvbiB3cm90ZTogIAo+ID4+Pj4+IE9uIE1vbiwgMTAgRGVjIDIwMTgg
MTk6MjM6NDYgKzA4MDAKPiA+Pj4+PiBMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29t
PiB3cm90ZTogIAo+ID4+Pj4+ICAgICA+Pj4+Pj4gKwkJCW10ZC0+ZWNjX3N0YXRzLmZhaWxlZCsr
OyAgCj4gPj4+Pj4+Pj4gKwkJCWNvbnRpbnVlOwo+ID4+Pj4+Pj4+ICsJCX0KPiA+Pj4+Pj4+PiAr
CQltdGQtPmVjY19zdGF0cy5jb3JyZWN0ZWQgKz0gRUNDX0VSUl9DTlQoKmluZm8pOwo+ID4+Pj4+
Pj4+ICsJCWJpdGZsaXBzID0gbWF4X3QodTMyLCBiaXRmbGlwcywgRUNDX0VSUl9DTlQoKmluZm8p
KTsKPiA+Pj4+Pj4+PiArCX0gIAo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+IEFyZSB5b3Ugc3VyZSB5b3Ug
aGFuZGxlIGNvcnJlY3RseSBlbXB0eSBwYWdlcyB3aXRoIGJmPyAgCj4gPj4+Pj4+PiAgICAgID4+
IGlmIHNjcmFtYmxlIGlzIGVuYWJsZSwgaSB3b3VsZCBzYXkgeWVzIGhlcmUuICAKPiA+Pj4+Pj4g
d2hlbiBzY3JhbWJsZSBpcyBkaXNhYmxlZCwgaSBhbSBjb25zaWRlcmluZyBob3cgdG8gdXNlIHRo
ZSBoZWxwZXIKPiA+Pj4+Pj4gbmFuZF9jaGVja19lcmFzZWRfZWNjX2NodW5rLCBidXQgaXQgc2Vl
bXMgdGhhdCBpIGNhbid0IGdldCB0aGUgZWNjCj4gPj4+Pj4+IGJ5dGVzIHdoaWNoIGlzIGNhY3Vs
YXRlZCBieSBlY2MgZW5naW5lLmJ5IHRoZSB3YXksIG5mYyBkbWEgZG9lc24ndCBzZW5kCj4gPj4+
Pj4+IG91dCB0aGUgZWNjIHBhcml0eSBieXRlcy4gIAo+ID4+Pj4+Cj4gPj4+Pj4gRXZlbiBpZiB0
aGUgRUNDIGVuZ2luZSBpcyBkaXNhYmxlZD8gIAo+ID4+Pj4+ICAgICA+PiBOby4gIAo+ID4+Pj4g
V2hlbiBFQ0MgZW5naW5lIGlzIGRpc2FibGVkLCBpdCBjYW4gcmVhZCB0aGUgZWNjIHBhcml0eSBi
eXRlcyA7IGJ1dCB0aGVyZSBpcyBhbm90aGVyIHByb2JsZW0gdGhhdCBpIG5lZWQgdG8gY29uc2lk
ZXIgaG93IGNvZGUgc3RydWN0IGxvb2tzIGJldHRlciB3aGVuIHJlYWRpbmcgZXJyb3Igd2l0aCBl
Y2Mgb3BlbmVkIGFuZCB0aGVuIHRyeSB0byByYXcgcmVhZC4KPiA+Pj4+IElzIHRoZXJlIGEgZ29v
ZCBpZGVhPyAgCj4gPj4+Cj4gPj4+IFdoZW4gcmVhZGluZyB3aXRoIEVDQyBlbmFibGVkLCBpbiBj
YXNlIG9mIHVuY29ycmVjdGFibGUgZXJyb3IgeW91Cj4gPj4+IG11c3QgcmUtcmVhZCB3aXRob3V0
IEVDQywgdGhlbiBjaGVjayBpZiB0aGUgcGFnZSBpcyBlbXB0eSBvciBub3Qgd2l0aAo+ID4+PiB0
aGUgY29yZSBoZWxwZXJzIChuYW5kX2NoZWNrX2VyYXNlZF8qKCkpLgo+ID4+Pgo+ID4+PiBJcyB0
aGlzIHdoYXQgeW91IG1lYW50PyAgCj4gPj4+ICAgID4+IHllcy4gd2hlbiB1bmNvcnJlY3RhYmxl
IEVDQyBlcnJvciwgaSBuZWVkIGZpcnN0bHkgcmVhZCBvdXQgdGhlIEVDQyBieXRlcyB3aXRob3V0
IEVDQyBlbmdpbmUgYW5kIHRoZW4gdXNlIHRoZSBoZWxwZXIgbmFuZF9jaGVja19lcmFzZWRfZWNj
X2NodW5rIHRvIGNoZWNrIGlmIGJsYW5rIHBhZ2UuICAKPiA+PiBPZiBjb3Vyc2UsIHRoZSBwcmVj
b25kaXRpb24gaXMgd2l0aG91dCBzY3JhbWJsZXIsIG9yIHRoZSBibGFuZCBwYWdlIGNhbiBiZSBk
ZXRlY3RlZCBieSBtZXNvbiBORkMuICAKPiA+IAo+ID4gQSBzdXBwb3NlIHlvdSBtZWFudCAiYmxh
bmsgcGFnZSI/IElmIHllcywgdGhlbiB5b3UgZG9uJ3QgbmVlZCB0aGUKPiA+IGhlbHBlciB0byBj
aGVjayBmb3Igb25seS0weEZGIHBhZ2VzLiBJZiB0aGUgY29udHJvbGxlciB0ZWxscyB5b3UgaWYg
dGhlCj4gPiBwYWdlIHdhcyBibGFuaywgdGhlbiBqdXN0IGNoZWNrIGZvciB0aGF0IGJpdC4KPiA+
ICAgCj4gCj4gaSB0aGluayBub3QuIHdlIG5lZWQgdG8gcmV0dXJuIGJhY2sgdGhlIHByZXZpb3Vz
IHByb2JsZW0gdGhhdCBob3cgaSBjYW4gZ2V0IHRoZSBiaXRmbGlwcyBvZiBvbmUgYmxhbmsgcGFn
ZS4gaSB0aGluayBpIG5lZWQgdGhlIGhlbHBlci4KCllvdSBhcmUgcmlnaHQsIEkgc3VwcG9zZSB0
aGUgImJsYW5rIHBhZ2UiIGZsYWcgaXMgb25seSB0cmlnZ2VyZWQgaWYKdGhlcmUgaXMgbm8gYml0
ZmxpcC4gSW4gdGhpcyBjYXNlIHlvdSBjYW4gYXNzdW1lIHRoZXJlIGFyZSBubwpiaXRmbGlwcy4g
T3RoZXJ3aXNlIHRoZSBjb250cm9sbGVyIHdpbGwgdHJpZ2dlciBhbgp1bmNvcnJlY3RhYmxlIGVy
cm9yIGV2ZW50IGFuZCB5b3Ugd2lsbCBoYXZlIHRvIHJlLXJlYWQgdGhlIHBhZ2UKd2l0aG91dCBF
Q0MgYW5kIGNoZWNrIGZvciBiaXRmbGlwcyB3aXRoIHRoZSBoZWxwZXIuCgoKVGhhbmtzLApNaXF1
w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
