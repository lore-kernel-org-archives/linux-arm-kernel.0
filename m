Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA7AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7D72147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hP23ueU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7D72147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TaBKqQQjD+KqpQxZD7VbW0vxicql6XSWE4TQQBCQ+Jk=; b=hP23ueU4BMW69X
	9YYqguRQn0Bk0cNNXuJeAkUfwOfSOvz8Ab0E6Pu051Upu4bZ7FxI8nvnelUqMPerbQ4RomQTesM/j
	1nfuQXicaJuEilLgqbI2Fg7y8VwWU1nfZGkIiaINsMszassLwY39gzByG1D7fBN8lS/o+dhLTMsjX
	9Ty3oAieb3pU3bCAYiSSxk8rFV/5mjJbD9CIfj9sH7ZUulFnH6gQKVka9JUQy/EEpBgR5cALeDf+p
	SMALPzYRBn1W2nMTqOhq8lSwwa6m6hrAu79hNGV3CySbsGgR9Xe+8EXhCYHUVQTRuVJ0m632GOvRS
	uWWzJxgKw/HdqHCtoNgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz048-0002Ng-Iv; Wed, 27 Feb 2019 14:20:08 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz043-0001Ts-Ku; Wed, 27 Feb 2019 14:20:05 +0000
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id BE6A1C001B;
 Wed, 27 Feb 2019 14:19:58 +0000 (UTC)
Date: Wed, 27 Feb 2019 15:19:57 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [RFC PATCH 03/27] mtd: nand: Introduce the ECC engine abstraction
Message-ID: <20190227151957.4de6ff32@xps13>
In-Reply-To: <20190227150633.7d8f5c5c@collabora.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-4-miquel.raynal@bootlin.com>
 <20190225195543.27799e77@kernel.org>
 <20190227145607.24e49014@xps13>
 <20190227150633.7d8f5c5c@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_062003_994278_BA3B25C8 
X-CRM114-Status: GOOD (  22.16  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>, Boris Brezillon <bbrezillon@kernel.org>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBjb2xsYWJvcmEuY29t
PiB3cm90ZSBvbiBXZWQsIDI3IEZlYgoyMDE5IDE1OjA2OjMzICswMTAwOgoKPiBPbiBXZWQsIDI3
IEZlYiAyMDE5IDE0OjU2OjA3ICswMTAwCj4gTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBi
b290bGluLmNvbT4gd3JvdGU6Cj4gCj4gPiBIaSBCb3JpcywKPiA+IAo+ID4gQm9yaXMgQnJlemls
bG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+IHdyb3RlIG9uIE1vbiwgMjUgRmViIDIwMTkKPiA+
IDE5OjU1OjQzICswMTAwOgo+ID4gICAKPiA+ID4gT24gVGh1LCAyMSBGZWIgMjAxOSAxMTowMTo1
MiArMDEwMAo+ID4gPiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3
cm90ZToKPiA+ID4gICAgIAo+ID4gPiA+ICsKPiA+ID4gPiArLyoqCj4gPiA+ID4gKyAqIHN0cnVj
dCBuYW5kX2VjY19lbmdpbmVfb3BzIC0gR2VuZXJpYyBFQ0MgZW5naW5lIG9wZXJhdGlvbnMKPiA+
ID4gPiArICoKPiA+ID4gPiArICogQGluaXRfY3R4OiBnaXZlbiBhIGRlc2lyZWQgdXNlciBjb25m
aWd1cmF0aW9uIGZvciB0aGUgcG9pbnRlZCBOQU5EIGRldmljZSwKPiA+ID4gPiArICogICAgICAg
ICAgICByZXF1ZXN0cyB0aGUgRUNDIGVuZ2luZSBkcml2ZXIgdG8gc2V0dXAgYSBjb25maWd1cmF0
aW9uIHdpdGgKPiA+ID4gPiArICogICAgICAgICAgICB2YWx1ZXMgaXQgc3VwcG9ydHMuCj4gPiA+
ID4gKyAqIEBjbGVhbnVwX2N0eDogY2xlYW4gdGhlIGNvbnRleHQgaW5pdGlhbGl6ZWQgYnkgQGlu
aXRfY3R4Lgo+ID4gPiA+ICsgKiBAcHJlcGFyZV9pb19yZXE6IGlzIGNhbGxlZCBiZWZvcmUgcmVh
ZGluZy93cml0aW5nIGEgcGFnZSB0byBwcmVwYXJlIHRoZSBJL08KPiA+ID4gPiArICogICAgICAg
ICAgICAgICAgICByZXF1ZXN0IHRvIGJlIHBlcmZvcm1lZCB3aXRoIEVDQyBjb3JyZWN0aW9uLgo+
ID4gPiA+ICsgKiBAZmluaXNoX2lvX3JlcTogaXMgY2FsbGVkIGFmdGVyIHJlYWRpbmcvd3JpdGlu
ZyBhIHBhZ2UgdG8gdGVybWluYXRlIHRoZSBJL08KPiA+ID4gPiArICogICAgICAgICAgICAgICAg
IHJlcXVlc3QgYW5kIGVuc3VyZSBwcm9wZXIgRUNDIGNvcnJlY3Rpb24uCj4gPiA+ID4gKyAqLwo+
ID4gPiA+ICtzdHJ1Y3QgbmFuZF9lY2NfZW5naW5lX29wcyB7ICAgICAgCj4gPiA+IAo+ID4gPiBX
ZSBtaWdodCB3YW50IHRvIGFkZCBhCj4gPiA+IAo+ID4gPiAJdm9pZCAoKnB1dF9lbmdpbmUpKHN0
cnVjdCBuYW5kX2VjY19lbmdpbmUgKmVuZ2luZSk7Cj4gPiA+IAo+ID4gPiBoZXJlIGlmIHdlIHdh
bnQgdGhlIG5hbmRkZXYgY2xlYW51cCBwYXRoIHRvIGJlIGdlbmVyaWMuCj4gPiA+IFRoaXMgaG9v
ayB3b3VsZCBiZSBpbXBsZW1lbnRlZCBieSBkcml2ZXJzIHdoZXJlIHRoZSBFQ0MgZW5naW5lIG9i
amVjdCBpcwo+ID4gPiByZWZjb3VudGVkICh0eXBpY2FsbHkgdGhlIGNhc2UgZm9yIEhXIEVDQyBl
bmdpbmVzIHNoYXJlZCBieSB0aGUgcmF3IE5BTkQKPiA+ID4gY29udHJvbGxlciBhbmQgdGhlIFNQ
SSBjb250cm9sbGVyKS4KPiA+ID4gCj4gPiA+IEFsdGVybmF0aXZlbHksIHlvdSBjYW4ganVzdCBh
ZGQgb25lIG5hbmRfcHV0X3h4eF9lY2NfZW5naW5lKCkgZnVuYyBwZXIKPiA+ID4gZW5naW5lIGNs
YXNzIChTVywgb25kaWUgYW5kIEhXKS4gICAgCj4gPiAKPiA+IENhbid0IHRoaXMgYmUgaGFuZGxl
ZCBpbiB0aGUgaW5pdC9jbGVhbnVwX2N0eCgpIHBhdGggZGlyZWN0bHk/ICAKPiAKPiBZb3UgcmVh
bGx5IGhhdmUgdG8gZ2V0IHRoZSByZWZlcmVuY2UgYmVmb3JlIGluaXRfY3R4KCkgb3RoZXJ3aXNl
IHRoZQo+IGVuZ2luZSBtaWdodCBkaXNhcHBlYXIgYmV0d2VlbiB5b3VyIGdldCgpIGFuZCBpbml0
KCkgY2FsbCwgYW5kLCB0byBrZWVwCj4gdGhpbmdzIHN5bW1ldHJpYywgSSB0aGluayBpdCdzIGJl
c3QgdG8gaGFuZGxlIHRoZSBwdXQoKSBvdXRzaWRlIHRoZQo+IGNsZWFudXBfY3R4KCkgcGF0aC4K
PiAKPiA+IAo+ID4gRnVydGhlcm1vcmUgaWYgdGhpcyBpcyBqdXN0IGEgaG9vayB0byBkbyByZWZl
cmVuY2UgY291bnRpbmcuICAKPiAKPiBXZWxsLCB3aGF0IHRoaXMgcHV0KCkgZG9lcyBkZXBlbmRz
IG9uIHRoZSBjbGFzcyBvZiBlbmdpbmUuIEZvciBTVyBhbmQKPiBvbi1kaWUgRUNDIGl0IGNhbiBi
ZSBhIE5PT1AgKHRoYXQncyB0cnVlIG9ubHkgaWYgeW91IGtlZXAgdGhlIGFwcHJvYWNoCj4gd2hl
cmUgeW91IGhhdmUgYSBzaW5nbGUgaW5zdGFuY2Ugc2hhcmVkIGJ5IGV2ZXJ5b25lIGZvciBTVy1i
YXNlZCBFQ0MKPiBlbmdpbmVzKS4KPiBGb3IgSFctY29udHJvbGxlci1zaWRlIEVDQyBlbmdpbmVz
LCB5b3UnbGwgaGF2ZSB0byBjYWxsIGRldmljZV9nZXQoKSBvbgo+IHRoZSBwYXJlbnQgZGV2aWNl
IGluIHlvdXIgbmFuZF9nZXRfaHdfZWNjX2VuZ2luZSgpIGZ1bmN0aW9uIHdoaWxlIHlvdQo+IGhv
bGQgdGhlIGxvY2sgcHJvdGVjdGluZyB0aGUgRUNDIGVuZ2luZSBsaXN0LiBBbmQgZGV2aWNlX3B1
dCgpIHdpbGwgYmUKPiBjYWxsZWQgaW4gbmFuZF9wdXRfaHdfZWNjX2VuZ2luZSgpLgoKCkkgc2Vl
LgoKVGhlbiBJIHByZWZlciBrZWVwaW5nIHRoZSBsb2dpYyBpbiB0aGUgY29yZSwgbm90IGluIHRo
ZSBlbmdpbmUgZHJpdmVyCmFuZCBwcm9wb3NlIGEKCiAgICAgICAgdm9pZCBuYW5kX2VjY19wdXRf
ZW5naW5lKHN0cnVjdCBuYW5kX2VjY19lbmdpbmUgKmVuZ2luZSkKCndoaWNoIHdpbGwgZG8gbm90
aGluZyBmb3Igb24tZGllL3N3IGVuZ2luZXMgYW5kIGRyb3AgdGhlIHJlZmVyZW5jZSBmb3IKaHcg
ZW5naW5lcy4gSSB3aWxsIGFsc28gcmVuYW1lIHRoZSAiZmluZF9lY2NfZW5naW5lIiB0byAiZ2V0
X2VuZ2luZSIgc28KdGhhdCB0aGUgY2FsbCB0byB0aGUgInB1dCIgaGVscGVyIGhhcyBtb3JlIG1l
YW5pbmcuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
