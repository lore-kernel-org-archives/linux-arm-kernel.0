Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ECFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:07:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6680220661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eLqvp0oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6680220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rX8fhGsMEnfsO6AvCHHmI4qis0vgHJc+OkjPScXw3tk=; b=eLqvp0oGi47mzL
	ChatYgJvgTELSrGH2efEMiwkjBjlemia7nM9JB+qukD7eIenhe3/Y8VOPIpyuF0WSvQofkrxYWf7q
	XfpA1QHQZb9g1Y80/AeqoJbj0pi/AmiZTl3E6mUZEe2UCpSy9hzQhbgy8Sptk62nrHNdZo8aWUquq
	LRrN0v54msaVmIhNvQxibaQ71rudrLjxTkPELJblk/xW2GwcJzWo8fYA9OWU/izc+Gsq6BEME+K2B
	Tca0xowcEZc7sSOL6ij8xb9+QIpPUC/STd1IlTQEN/42E1JKzvNTnQ6FOXPfsHK21AAf1JeSkWAhM
	hsCSepkGw8+EFsP0955Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzrs-0005T5-A9; Wed, 27 Feb 2019 14:07:28 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzro-0005SW-KG; Wed, 27 Feb 2019 14:07:26 +0000
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4A65CC000F;
 Wed, 27 Feb 2019 14:07:14 +0000 (UTC)
Date: Wed, 27 Feb 2019 15:07:13 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 25/27] mtd: nand: Add helpers to manage ECC engines
 and configurations
Message-ID: <20190227150713.116a0ad3@xps13>
In-Reply-To: <20190222154431.66c6911f@kernel.org>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-13-miquel.raynal@bootlin.com>
 <20190222154431.66c6911f@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_060724_962581_340B7567 
X-CRM114-Status: GOOD (  25.78  )
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
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUg
b24gRnJpLCAyMiBGZWIgMjAxOQoxNTo0NDozMSArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMzo1ODowNCArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gQWRkIHRoZSBsb2dpYyBpbiB0aGUgTkFORCBjb3JlIHRvIGZpbmQg
dGhlIHJpZ2h0IEVDQyBlbmdpbmUgZGVwZW5kaW5nCj4gPiBvbiB0aGUgTkFORCBjaGlwIHJlcXVp
cmVtZW50cyBhbmQgdGhlIHVzZXIgZGVzaXJlcy4gUmlnaHQgbm93LCB0aGUKPiA+IGNob2ljZSBt
YXkgYmUgbWFkZSBiZXR3ZWVuIChtb3JlIHdpbGwgY29tZSk6Cj4gPiAqIHNvZnR3YXJlIEhhbW1p
bmcKPiA+ICogc29mdHdhcmUgQkNICj4gPiAqIG9uLWRpZSAoU1BJLU5BTkQgZGV2aWNlcyBvbmx5
KQo+ID4gCj4gPiBPbmNlIHRoZSBFQ0MgZW5naW5lIGhhcyBiZWVuIGZvdW5kLCB0aGUgRUNDIGVu
Z2luZSBtdXN0IGJlCj4gPiBjb25maWd1cmVkLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1
ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVy
cy9tdGQvbmFuZC9jb3JlLmMgIHwgMTA3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwo+ID4gIGluY2x1ZGUvbGludXgvbXRkL25hbmQuaCB8ICAgNCArKwo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXRkL25hbmQvY29yZS5jIGIvZHJpdmVycy9tdGQvbmFuZC9jb3JlLmMKPiA+IGluZGV4IDg3
MmQ0NmI1ZmMwZi4uOWZlYjExOGM5ZjY4IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9tdGQvbmFu
ZC9jb3JlLmMKPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvY29yZS5jCj4gPiBAQCAtMjA3LDYg
KzIwNywxMTMgQEAgaW50IG5hbmRkZXZfbXRkX21heF9iYWRfYmxvY2tzKHN0cnVjdCBtdGRfaW5m
byAqbXRkLCBsb2ZmX3Qgb2Zmcywgc2l6ZV90IGxlbikKPiA+ICB9Cj4gPiAgRVhQT1JUX1NZTUJP
TF9HUEwobmFuZGRldl9tdGRfbWF4X2JhZF9ibG9ja3MpOwo+ID4gIAo+ID4gKy8qKgo+ID4gKyAq
IG5hbmRkZXZfZmluZF9lY2NfZW5naW5lKCkgLSBGaW5kIGEgc3VpdGFibGUgRUNDIGVuZ2luZQo+
ID4gKyAqIEBuYW5kOiBOQU5EIGRldmljZQo+ID4gKyAqLwo+ID4gK3N0YXRpYyBpbnQgbmFuZGRl
dl9maW5kX2VjY19lbmdpbmUoc3RydWN0IG5hbmRfZGV2aWNlICpuYW5kKSAgCj4gCj4gQ2FuIHdl
IHBhc3MgdGhlIGNvbmYgaW4gYXJndW1lbnQgaW5zdGVhZCBvZiByZWFkaW5nIGl0IGZyb20KPiBu
YW5kLT5lY2MudXNlcl9jb25mPwoKSSBqdXN0IGNoYW5nZWQgdGhlIHJvb3Qgc3RydWN0dXJlcywg
dGhlcmUgaXMgYQoKICAgICAgIHN0cnVjdCBuYW5kX2VjY19jb25mIGRlZmF1bHRzOwoKZW50cnkg
bm93IGluIHRoZSBuYW5kX2VjY19lbmdpbmUgc3RydWN0dXJlLCB3aGljaCBldmVyeSBsYXllci9k
cml2ZXIKY2FuIG92ZXJ3cml0ZSB0byBpbmZvcm0gdGhlIE5BTkQgY29yZSBvZiBhIGRlZmF1bHQg
dmFsdWUuCgpMYXRlciBpbiB0aGlzIGZ1bmN0aW9uLCBJIGNoZWNrIHVzZXJfY29uZiAod2hpY2gg
SSBtaWdodCBjYWxsCiJkZXNpcmVzIiBub3cgdGhhdCB3ZSBoYXZlIGEgImRlZmF1bHRzIiBhbmQg
YSAicmVxdWlyZW1lbnRzIiBlbnRyaWVzKSwKYnV0IGlmIHRoZSB2YWx1ZSBpcyBtaXNzaW5nIEkg
ZmFsbGJhY2sgdG8gdGhlICJkZWZhdWx0cyIgb25lIGlmIGZpbGxlZC4KSGF2aW5nIGFsbCB0aGVz
ZSBzdHJ1Y3R1cmVzIGJlaW5nIHBhc3NlZCBhcyBwYXJhbWV0ZXJzIGRvZXMgbm90IG1ha2UKc2Vu
c2UgdG8gbWUgc28gSSB3b3VsZCBwcmVmZXIgc3RpY2tpbmcgdG8gdGhlIHNpbmdsZSAibmFuZCIg
cGFyYW1ldGVyLgoKPiAKPiA+ICt7Cj4gPiArCWJvb2wgaXNfc3BpbmFuZCA9IG10ZF90eXBlX2lz
X3NwaW5hbmQoJm5hbmQtPm10ZCk7ICAKPiAKPiBBbmQgaGVyZSBpcyB0aGUgcmVhc29uIGZvciB0
aGUgU1BJTkFORCB0eXBlLgoKVGhpcyBkb2VzIG5vdCBleGlzdCBhbnltb3JlIGFzIHlvdSBzdWdn
ZXN0ZWQuCgo+IAo+ID4gKwo+ID4gKwkvKiBSZWFkIHRoZSB1c2VyIGRlc2lyZXMgaW4gdGVybXMg
b2YgRUNDIGVuZ2luZS9jb25maWd1cmF0aW9uICovCj4gPiArCW5hbmRfZWNjX3JlYWRfdXNlcl9j
b25mKG5hbmQpOwo+ID4gKwo+ID4gKwkvKiBObyBFQ0MgZW5naW5lIHJlcXVlc3RlZG4sIGxldCdz
IHJldHVybiB3aXRob3V0IGVycm9yICovCj4gPiArCWlmIChuYW5kLT5lY2MudXNlcl9jb25mLm1v
ZGUgPT0gTkFORF9FQ0NfTk9ORSkKPiA+ICsJCXJldHVybiAwOwo+ID4gKwo+ID4gKwkvKiBSYXcg
TkFORCBkZWZhdWx0IG1vZGUgaXMgaGFyZHdhcmUgKi8KPiA+ICsJaWYgKCFpc19zcGluYW5kICYm
IG5hbmQtPmVjYy51c2VyX2NvbmYubW9kZSA8IDApCj4gPiArCQluYW5kLT5lY2MudXNlcl9jb25m
Lm1vZGUgPSBOQU5EX0VDQ19IVzsgIAo+IAo+IFdlIHNob3VsZCBsZXQgdGhlIHJhdyBOQU5EIGxh
eWVyIHRha2UgdGhpcyBkZWNpc2lvbiAoYWN0dWFsbHksIGl0J3MKPiBldmVuIGEgcmF3IE5BTkQg
Y29udHJvbGxlciBkcml2ZXIgZGVjaXNpb24pLiBQbGVhc2UgY29tcGxhaW4gaWYKPiB1c2VyX2Nv
bmYubW9kZSBpcyBpbnZhbGlkLgo+IFRoaXMgd2F5IHlvdSB3b24ndCBuZWVkIHRoZSBTUElOQU5E
IHR5cGUgeW91IGFkZGVkIGluIG9uZSBvZiB5b3VyCj4gcHJldmlvdXMgcGF0Y2guCgpTZWUgYWJv
dmUgZm9yIHRoZSBzb2x1dGlvbiBJIGNob29zZS4KCj4gCj4gPiArCj4gPiArCS8qIFNQSS1OQU5E
IGRlZmF1bHQgbW9kZSBpcyBvbi1kaWUgKi8KPiA+ICsJaWYgKGlzX3NwaW5hbmQgJiYgbmFuZC0+
ZWNjLnVzZXJfY29uZi5tb2RlIDwgMCkKPiA+ICsJCW5hbmQtPmVjYy51c2VyX2NvbmYubW9kZSA9
IE5BTkRfRUNDX09OX0RJRTsKPiA+ICsKPiA+ICsJc3dpdGNoIChuYW5kLT5lY2MudXNlcl9jb25m
Lm1vZGUpIHsKPiA+ICsJY2FzZSBOQU5EX0VDQ19TT0ZUOgo+ID4gKwkJbmFuZC0+ZWNjLmVuZ2lu
ZSA9IG5hbmRfZWNjX3N3X2dldF9lbmdpbmUobmFuZCk7Cj4gPiArCQlicmVhazsKPiA+ICsJY2Fz
ZSBOQU5EX0VDQ19PTl9ESUU6Cj4gPiArCQlpZiAoaXNfc3BpbmFuZCkKPiA+ICsJCQluYW5kLT5l
Y2MuZW5naW5lID0gc3BpbmFuZF9vbmRpZV9lY2NfZ2V0X2VuZ2luZSgpOyAgCj4gCj4gU28sIG1h
eWJlIGl0J3Mgd29ydGggaGF2aW5nIHRoZSBvbmRpZSBFQ0MgZW5naW5lIGluc3RhbmNlIGRpcmVj
dGx5Cj4gZW1iZWRkZWQgaW4gbmFuZF9kZXZpY2UgaW5zdGVhZCBvZiBzcGluYW5kLCBvciBtYXli
ZSBqdXN0IGEgcG9pbnRlciwgc28KPiB0aGF0IHlvdSBkb24ndCByZXNlcnZlIGV4dHJhIHNwYWNl
IHdoZW4gdGhlIE5BTkQgZGV2aWNlIGRvZXMgbm90IGhhdmUKPiBvbi1kaWUgRUNDLgoKSXQgaXMg
bm93OiB0aGUgbmFuZF9lY2NfZW5naW5lIHN0cnVjdHVyZSBmZWF0dXJlcyBhICplbmdpbmUgYW5k
IGEKKm9uZGllX2VuZ2luZSBwb2ludGVyLgoKVGhlIG5hbmRfZWNjX2dldF9vbmRpZV9lbmdpbmUo
bmFuZCkgaGVscGVyIGp1c3QKcmV0dXJucyBuYW5kLT5lY2Mub25kaWVfZW5naW5lLgoKPiAKPiA+
ICsJCWVsc2UKPiA+ICsJCQlwcl9lcnIoIk9uLWRpZSBFQ0MgZW5naW5lcyBmb3Igbm9uIFNQSSBk
ZXZpY2VzIG5vdCBzdXBwb3J0ZWQgeWV0XG4iKTsKPiA+ICsJCWJyZWFrOwo+ID4gKwljYXNlIE5B
TkRfRUNDX0hXOgo+ID4gKwkJcHJfZXJyKCJIYXJkd2FyZSBFQ0MgZW5naW5lcyBub3Qgc3VwcG9y
dGVkIHlldFxuIik7Cj4gPiArCQlicmVhazsKPiA+ICsJZGVmYXVsdDoKPiA+ICsJCXByX2Vycigi
TWlzc2luZyBFQ0MgZW5naW5lIHByb3BlcnR5XG4iKTsKPiA+ICsJfQo+ID4gKwo+ID4gKwlpZiAo
IW5hbmQtPmVjYy5lbmdpbmUpCj4gPiArCQlyZXR1cm4gIC1FSU5WQUw7Cj4gPiArCj4gPiArCXJl
dHVybiAwOwo+ID4gK30gIAo+IAoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
