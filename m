Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9B4C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:32:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D898620882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pIQYCOnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D898620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2W3m8kfyydpfDAIo5nv3MsZLU5SrvxLuUN09J8FdLfI=; b=pIQYCOnQVVTPxo
	LmWcFHJtkIinRrzasljF2PoTxvdCfVVvaWg8HW/ApPRXdOR3rYxOQb8ujwHwxx03Q64gPghhPnrlb
	0FuMzrEbSjn2hxErQFQ3y8p70g9gND+XTfQvHwjwMAvfkE3pTCx4KNsjb2oiNpH/c5HF+gnQPkkmt
	/hqRWXlBtSjXtf6HciHl57cue8BDsxsvCkPX+S29Qg8UrCkkbVs7kz4sirZuAgG1fbfarwzfSC2s7
	+QaJ1Ercf2Eh+UToM7yox0ckc+gvUdKOIfCoDpugFdUw2qELJURhvH0mnamp55VYvwQJ/Un7kiiEu
	6qzBqtjxG1njF3u/zJoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomEV-00079c-HA; Wed, 30 Jan 2019 09:32:35 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomEQ-00078Y-6F; Wed, 30 Jan 2019 09:32:32 +0000
X-Originating-IP: 90.88.147.226
Received: from xps13 (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B2F1240018;
 Wed, 30 Jan 2019 09:32:21 +0000 (UTC)
Date: Wed, 30 Jan 2019 10:32:20 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liang Yang <liang.yang@amlogic.com>
Subject: Re: [PATCH] mtd: rawnand: meson: Fix linking error on 32-bit platforms
Message-ID: <20190130103220.27b13ab9@xps13>
In-Reply-To: <42d2e92e-9f5a-62b2-c0af-b7f3544d79d2@amlogic.com>
References: <20190129214657.5877-1-natechancellor@gmail.com>
 <42d2e92e-9f5a-62b2-c0af-b7f3544d79d2@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_013230_386658_A88A1B2B 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 linux-amlogic@lists.infradead.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTGlhbmcsIE5hdGhhbiwKCkxpYW5nIFlhbmcgPGxpYW5nLnlhbmdAYW1sb2dpYy5jb20+IHdy
b3RlIG9uIFdlZCwgMzAgSmFuIDIwMTkgMTc6MjY6MzkKKzA4MDA6Cgo+IEhpIE5hdGhhbiwKPiAK
PiBPbiAyMDE5LzEvMzAgNTo0NiwgTmF0aGFuIENoYW5jZWxsb3Igd3JvdGU6Cj4gPiBPbiBhcm0g
bGl0dGxlIGVuZGlhbiBhbGx5ZXNjb25maWc6Cj4gPiAKPiA+ICAgIGxkLmxsZDogZXJyb3I6IHVu
ZGVmaW5lZCBzeW1ib2w6IF9fYWVhYmlfdWxkaXZtb2QgIAo+ID4gICAgPj4+IHJlZmVyZW5jZWQg
YnkgbWVzb25fbmFuZC5jCj4gPiAgICA+Pj4gbXRkL25hbmQvcmF3L21lc29uX25hbmQubzoobWVz
b25fbmZjX3NldHVwX2RhdGFfaW50ZXJmYWNlKSBpbiBhcmNoaXZlIGRyaXZlcnMvYnVpbHQtaW4u
YSAgCj4gPiAKPiA+IFRoZSBkaXZpZGVuZCB0QkVSU19tYXggaXMgdTY0LCBtZWFuaW5nIHdlIG5l
ZWQgdG8gdXNlIERJVl9ST1VORF9VUF9VTEwKPiA+ICh3aGljaCB3cmFwcyBkb19kaXYpIHRvIHBy
ZXZlbnQgdGhlIGNvbXBpbGVyIGZyb20gZW1pdHRpbmcKPiA+IF9fYWViaV91bGRpdm1vZC4KPiA+
IAo+ID4gRml4ZXM6IDJkNTcwYjM0YjQxYSAoIm10ZDogcmF3bmFuZDogbWVzb246IGFkZCBzdXBw
b3J0IGZvciBBbWxvZ2ljIE5BTkQgZmxhc2ggY29udHJvbGxlciIpCj4gPiBTaWduZWQtb2ZmLWJ5
OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxsb3JAZ21haWwuY29tPgo+ID4gLS0tCj4g
PiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L21lc29uX25hbmQuYyB8IDQgKystLQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWVzb25fbmFuZC5jIGIvZHJpdmVycy9tdGQv
bmFuZC9yYXcvbWVzb25fbmFuZC5jCj4gPiBpbmRleCBlODU4ZDU4ZDk3YjAuLjZmMTJhOTYxOTVk
MSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L21lc29uX25hbmQuYwo+ID4g
KysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWVzb25fbmFuZC5jCj4gPiBAQCAtMTExNiw4ICsx
MTE2LDggQEAgaW50IG1lc29uX25mY19zZXR1cF9kYXRhX2ludGVyZmFjZShzdHJ1Y3QgbmFuZF9j
aGlwICpuYW5kLCBpbnQgY3NsaW5lLAo+ID4gICAJCQkJICAgICAgIGRpdiAqIE5GQ19DTEtfQ1lD
TEUpOwo+ID4gICAJbWVzb25fY2hpcC0+dGFkbCA9IERJVl9ST1VORF9VUChQU0VDX1RPX05TRUMo
dGltaW5ncy0+dEFETF9taW4pLAo+ID4gICAJCQkJCWRpdiAqIE5GQ19DTEtfQ1lDTEUpOwo+ID4g
LQl0YmVyc19jbG9ja3MgPSBESVZfUk9VTkRfVVAoUFNFQ19UT19OU0VDKHRpbWluZ3MtPnRCRVJT
X21heCksCj4gPiAtCQkJCSAgICBkaXYgKiBORkNfQ0xLX0NZQ0xFKTsKPiA+ICsJdGJlcnNfY2xv
Y2tzID0gRElWX1JPVU5EX1VQX1VMTChQU0VDX1RPX05TRUModGltaW5ncy0+dEJFUlNfbWF4KSwK
PiA+ICsJCQkJCWRpdiAqIE5GQ19DTEtfQ1lDTEUpOyAgCj4gCj4gTG9va3MgZ29vZCB0byBtZToK
PiAKPiBBY2tlZC1ieTogTGlhbmcgWWFuZyA8bGlhbmcueWFuZ0BhbWxvZ2ljLmNvbT4KClRoaXMg
aXMgbmFuZC9uZXh0IG1hdGVyaWFsLCBzbyBpZiB5b3UgZG9uJ3QgbWluZCBJIHdvdWxkIGxpa2Ug
dG8gc3F1YXNoCnRoaXMgZml4IGludG8gdGhlIG9yaWdpbmFsIGNvbW1pdCBpbnNlcnRpbmcgdGhl
IGRyaXZlci4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
