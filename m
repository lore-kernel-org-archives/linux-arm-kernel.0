Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D93C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:36:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436A62148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L3fRiPo6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qKOZ06eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436A62148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rd4vPXm81kmfbHq6a1XR+Mki/qqYwDFoK2611Gc/TWk=; b=L3fRiPo6AU7o5F
	O3zU+TKW9kDYhri4cssSQwjzSshpvmJKf5S+EvNrJ5HdOj9Aefx+rt+q1m2Og10lm6LTfs+09U+ZP
	TjQ9+uUCzuan6Xc5qshvobuIoG0JEkJEeixlJoyvyFeLgr4H3iZtL8SiRjTbL+mUJxouETjD1K2KW
	33AL/W+icOfNqqDVTJNr84DE/BIFPlIKlj5ocdjh7K4Ui5MhqzgemdSM3mkFIa/6AZkWkk3Ypm6DP
	6Dfad34PjzSVcLKI0yUWQH/oYgAf5hL+ovmfjALK/ayUWL+02jsvxWrM1WZbuHYAWguw4bFJowm+S
	EdFqPW75iK2VmXg05yQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go8xu-0004R6-0q; Mon, 28 Jan 2019 15:36:50 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go8xs-0004Qw-0m
 for linux-arm-kernel@bombadil.infradead.org; Mon, 28 Jan 2019 15:36:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HBvmq3pGprB2BkAH3raH5U3m1TJVl9+kHg9F6PXiw/8=; b=qKOZ06eS6f/Vu55OH6NDODkiTj
 cbbdcj+ok+vcyEZ2h1IAecFuWwN9dtVg1A9/MkTYGecnufDj/t7oZN+JbRKhpwDRFWjDC88cHO6p4
 EOH6iys0Gaj0kWXZjHg4M+1HFjZ/YX6vse6n3fvc2awkmOhQFmGD08iZzgodOmauZYAgU/SJ/DMTb
 bTwZIXnesCU2mhpzDlR3KkUJaNwbOpaxiCchaXUnYX8WVmDJFYIUM/OzK1URLyxUH2ScmN13BHCQC
 /czruLc7E/N6EXn1zWrskwSynNJjDK6i6FlRZD72aRiy3AicHQZoWhlATcPlPrbTol/yuf5kiVQ3Y
 w8Ulihcg==;
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go8xo-00082g-Fl
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 15:36:45 +0000
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id B6F2620000C;
 Mon, 28 Jan 2019 15:36:05 +0000 (UTC)
Date: Mon, 28 Jan 2019 16:36:04 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v4 04/10] usb: ehci-orion: add S2RAM support
Message-ID: <20190128163604.6c34bdb7@xps13>
In-Reply-To: <Pine.LNX.4.44L0.1901281025190.1450-100000@iolanthe.rowland.org>
References: <20190128113350.603b2be3@xps13>
 <Pine.LNX.4.44L0.1901281025190.1450-100000@iolanthe.rowland.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103644_632641_943CD6A4 
X-CRM114-Status: GOOD (  22.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQWxhbiwKCkFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+IHdyb3RlIG9u
IE1vbiwgMjggSmFuIDIwMTkKMTA6Mjc6NTMgLTA1MDAgKEVTVCk6Cgo+IE9uIE1vbiwgMjggSmFu
IDIwMTksIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gCj4gPiBIaSBBbGFuLAo+ID4gCj4gPiBBbGFu
IFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1PiB3cm90ZSBvbiBGcmksIDI1IEphbiAy
MDE5Cj4gPiAyMTo1NjoyNyAtMDUwMCAoRVNUKToKPiA+ICAgCj4gPiA+IE9uIEZyaSwgMjUgSmFu
IDIwMTksIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gPiA+ICAgCj4gPiA+ID4gQWRkIHN1c3BlbmQv
cmVzdW1lIGNhbGxiYWNrcyB0byByZXNldCB0aGUgaG9zdCBjb250cm9sbGVyIHByb3Blcmx5Cj4g
PiA+ID4gZHVyaW5nIFMyUkFNIG9wZXJhdGlvbi4KPiA+ID4gPiAKPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+ID4gPiA+IC0t
LQo+ID4gPiA+ICBkcml2ZXJzL3VzYi9ob3N0L2VoY2ktb3Jpb24uYyB8IDE4ICsrKysrKysrKysr
KysrKysrKwo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQo+ID4gPiA+
IAo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktb3Jpb24uYyBiL2Ry
aXZlcnMvdXNiL2hvc3QvZWhjaS1vcmlvbi5jCj4gPiA+ID4gaW5kZXggMzEwOWYwODI5NDllLi4w
ZGFiMDk5YjVkMTUgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC9laGNpLW9y
aW9uLmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktb3Jpb24uYwo+ID4gPiA+
IEBAIC0xODIsNiArMTgyLDIzIEBAIHN0YXRpYyBpbnQgZWhjaV9vcmlvbl9kcnZfcmVzZXQoc3Ry
dWN0IHVzYl9oY2QgKmhjZCkKPiA+ID4gPiAgCXJldHVybiByZXQ7Cj4gPiA+ID4gIH0KPiA+ID4g
PiAgCj4gPiA+ID4gK3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgZWhjaV9vcmlvbl9kcnZfc3Vz
cGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gPiA+ID4gK3sKPiA+ID4gPiArCXN0cnVjdCB1c2Jf
aGNkICpoY2QgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKPiA+ID4gPiArCj4gPiA+ID4gKwlyZXR1
cm4gZWhjaV9zdXNwZW5kKGhjZCwgZGV2aWNlX21heV93YWtldXAoZGV2KSk7ICAgIAo+ID4gPiAK
PiA+ID4gT2theSwgZ29vZC4KPiA+ID4gICAKPiA+ID4gPiArfQo+ID4gPiA+ICsKPiA+ID4gPiAr
c3RhdGljIGludCBfX21heWJlX3VudXNlZCBlaGNpX29yaW9uX2Rydl9yZXN1bWUoc3RydWN0IGRl
dmljZSAqZGV2KQo+ID4gPiA+ICt7Cj4gPiA+ID4gKwlzdHJ1Y3QgdXNiX2hjZCAqaGNkID0gZGV2
X2dldF9kcnZkYXRhKGRldik7Cj4gPiA+ID4gKwo+ID4gPiA+ICsJcmV0dXJuIGVoY2lfcmVzdW1l
KGhjZCwgZGV2aWNlX21heV93YWtldXAoZGV2KSk7ICAgIAo+ID4gPiAKPiA+ID4gTm90IHNvIGdv
b2QuICBUaGUgc2Vjb25kIGFyZ3VtZW50IGhlcmUgaXMgZm9yY2VfcmVzZXQ7IHByZXN1bWFibHkg
eW91IAo+ID4gPiB3YW50IGl0IGFsd2F5cyB0byBiZSBmYWxzZS4gIChOb3RlIHRoYXQgdGhlIHYz
IHZlcnNpb24gb2YgdGhpcyBwYXRjaCAKPiA+ID4gZGlkIG5vdCBjYWxsIGRldmljZV9tYXlfd2Fr
ZXVwKCkgaW4gZWhjaV9vcmlvbl9kcnZfcmVzdW1lLikKPiA+ID4gCj4gPiA+IFllcywgdGhlIEFQ
SSBpcyBub3Qgc3ltbWV0cmljYWwuICBTbyBzdWUgbWUuLi4gIAo+ID4gCj4gPiBPaCByaWdodCwg
SSBjb21wbGV0ZWx5IG92ZXJsb29rZWQgdGhhdCBvbmUuIEluZGVlZCB0aGUgc2Vjb25kIHBhcmFt
ZXRlcgo+ID4gc2hvdWxkIGJlICJmYWxzZSIsIGFzIGluIHRoZSB2My4gRG8geW91IG1pbmQgaWYg
SSBzZW5kIGEgdjUgb25seSBmb3IKPiA+IHRoaXMgcGF0Y2g/IElmIHRoZSByZXN0IGxvb2tzIGdv
b2QgdG8geW91IG9mIGNvdXJzZS4gIAo+IAo+IFRvIGF2b2lkIGNvbmZ1c2luZyBHcmVnLCBpdCB3
b3VsZCBiZSBiZXN0IHRvIHNlbmQgdjUgb2YgYWxsIHRoZSBwYXRjaGVzCj4gdGhhdCBoZSBzaG91
bGQgYXBwbHkuICBUaGUgcmVzdCBvZiB0aGUgRUhDSSBjaGFuZ2VzIGxvb2sgb2theSwgYW5kIHdo
ZW4KPiB5b3UgZml4IHRoaXMgeW91IGNhbiBhZGQ6Cj4gCj4gQWNrZWQtYnk6IEFsYW4gU3Rlcm4g
PHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+CgpTdXJlIQoKClRoYW5rcywKTWlxdcOobAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
