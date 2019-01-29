Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49964C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:41:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183D521473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pIAD77T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183D521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7AFkLxEypLBJhAsbPDmgxPgf+MTw5u3ptibXsMO5lCM=; b=pIAD77T932fYIh
	iSJFUjcpXJP2J+9X5XQ7ULIpokveKwksovLpTGMKxExa7KakQjzv/uDY8n4PFBEwlZ5xWw2+04+Bu
	mCTqtL4E1UYWLWYqcjZLHsAObMyZWKzD/joiB3LZsG45h41pcEYy2fPzDHcUjYdbMMwT0PAjNfOG6
	pB3S2G3TDSoi3s4DcM805+kRG1dxxxCCB2ayBAJi5CbWhntPnMLGmmPx2uErhIaj2Igbyuw7yLP3u
	qSiMJ8mce8eZJOooJjDafphsl6xhQnsHm73EbcuSGG0l8E+WFQ64uIejo1ZgdsJr7zJoipWHCKGXC
	BsMLrBeiwNwHqM1xADIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXNm-00007M-HR; Tue, 29 Jan 2019 17:41:10 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXNj-00006q-7J
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:41:08 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1goXNW-0000kO-3z; Tue, 29 Jan 2019 18:40:54 +0100
Message-ID: <1548783652.6869.11.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add QuadSPI controller
From: Lucas Stach <l.stach@pengutronix.de>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 29 Jan 2019 18:40:52 +0100
In-Reply-To: <3ff2f0d6-07d2-9ed4-878f-011406f09da3@baylibre.com>
References: <20190129163457.7107-1-ccaione@baylibre.com>
 <1548780179.6869.9.camel@pengutronix.de>
 <3ff2f0d6-07d2-9ed4-878f-011406f09da3@baylibre.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_094107_418959_D336B845 
X-CRM114-Status: GOOD (  17.06  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRGllbnN0YWcsIGRlbiAyOS4wMS4yMDE5LCAxNjo1NCArMDAwMCBzY2hyaWViIENhcmxvIENh
aW9uZToKPiBPbiAyOS8wMS8yMDE5IDE2OjQyLCBMdWNhcyBTdGFjaCB3cm90ZToKPiA+IEhpIENh
cmxvLAo+IAo+IEhpIEx1Y2FzLAo+IAo+ID4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEuZHRzaQo+ID4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXEuZHRzaQo+ID4gPiBAQCAtNTE2LDYgKzUxNiwxOSBAQAo+ID4gPiA+ID4gPiA+
ID4gwqDCoAkJCX07Cj4gPiA+ID4gwqDCoAkJfTsKPiA+ID4gCj4gPiA+IMKgwqAKPiA+ID4gKwkJ
c3BpMDogc3BpQDMwYmIwMDAwIHsKPiA+IAo+ID4gMzBiYjAwMDAgaXMgcGFydCBvZiB0aGUgQUlQ
UzMgYnVzIGFkZHJlc3Mgc3BhY2UsIHNvIHBsZWFzZSBtb3ZlIHRoaXMgdG8KPiA+IHRoZSBjb3Jy
ZWN0IGxvY2F0aW9uIHdpdGhpbiB0aGlzIGJ1cyBub2RlLgo+IAo+IFRoZSBwcm9ibGVtIGlzIHRo
YXQgdGhlICJRdWFkU1BJLW1lbW9yeSIgcmVnaW9uIGRvZXNuJ3QgZmFsbCB3aXRoaW4gdGhlwqAK
PiBtZW1vcnkgcmFuZ2Ugb2YgdGhlIEFJUFMzIGJ1cywgc28gdGhlIGRldm1faW9yZW1hcF9yZXNv
dXJjZSBpcyBmYWlsaW5nwqAKPiB3aGVuIG1vdmluZyB0aGUgbm9kZSB0aGVyZS4KClVoLCB0aGF0
J3MgaW50ZXJlc3RpbmcuIE5vcm1hbGx5IHRoZSBEVHMgYXJlIG9yZ2FuaXplZCBhbG9uZyB0aGUK
Y29udHJvbCBwYXRoIGFuZCBJIGd1ZXNzIHRoZSBRdWFkU1BJLW1lbW9yeSBpcyBub3QgcmVhbGx5
IGEgY29udHJvbApwYXRoLCBidXQgdGhlIGZhc3QgbWVtb3J5IGFjY2VzcyBwYXRoLiBNYXliZSB0
aGlzIGlzIHNvbWV0aGluZyB0aGUgRFQKZm9sa3MgY291bGQgdGFrZSBhIGxvb2sgYXQuCgpCdXQg
dGhlbiBJIHdvdWxkIHN0aWxsIHByZWZlciB0byBoYXZlIHRoZSBRU1BJIGNvbnRyb2xsZXIgbW92
ZWQgaW50bwp0aGUgY29ycmVjdCBjb250cm9sIGJ1cy4gSSBndWVzcyB3ZSBjYW4gd29yayBhcm91
bmQgeW91cgpkZXZtX2lvcmVtYXBfcmVzb3VyY2UgZmFpbGluZyBpc3N1ZSBieSBhZGRpbmcgdGhl
IFFTUEktbWVtb3J5IHJlZ2lvbiB0bwp0aGUgQUlQUzMgYnVzIHJhbmdlcy4KCj4gPiA+ICsJCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+ID4gPiArCQkJI3NpemUtY2VsbHMgPSA8MD47Cj4gPiA+
IAo+ID4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14N2QtcXNwaSI7Cj4gPiAKPiA+IFBsZWFz
ZSBhZGQgYSAiZnNsLGlteDhtcS1xc3BpIiBjb21wYXRpYmxlIGhlcmUsIGFzIHdhcyBkb25lIHdp
dGggYWxsCj4gPiB0aGUgb3RoZXIgbm9kZXMgaW4gdGhpcyBmaWxlLCBzbyB3ZSBjYW4gbWF0Y2gg
dGhpcyBpbiB0aGUgZHJpdmVyIHNob3VsZAo+ID4gdGhlIG5lZWQgYXJpc2UuCj4gCj4gVGhpcyBp
cyBvZGQgc2luY2UgYXQgbGVhc3QgZm9yIHRoZSBBbUxvZ2ljIFNvQ3Mgd2UgYXJlIGdvaW5nIGV4
YWN0bHkgaW7CoAo+IHRoZSBvcHBvc2l0ZSBkaXJlY3Rpb24gd2hlcmUgd2UgYXZvaWQgdG8gYWRk
IHVubmVjZXNzYXJ5IGNvbXBhdGlibGVzIGlmwqAKPiB0aGF0J3Mgbm90IHN0cmljdGx5IHJlcXVp
cmVkLgoKSXQncyBhIHNhZmV0eSBuZXQsIHNvIHdlIGRvbid0IG5lZWQgdG8gY2hhbmdlIGV4aXN0
aW5nIERUQnMgaWYgaXQgdHVybnMKb3V0IHRoYXQgYSBzcGVjaWZpYyBTb0MgaW50ZWdyYXRpb24g
aGFzIGEgYnVnIHRoYXQgbmVlZHMgYSB3b3JrYXJvdW5kCmluIHRoZSBkcml2ZXIuCgpUaGlzIGlz
IG9uZSBvZiB0aGluZ3MgSSd2ZSBwcm9wb3NlZCBpbiBteSBFTEMtRSB0YWxrICJTdGFibGUgRGV2
aWNldHJlZQpBQkk6IGl0J3MgcG9zc2libGUhIiwgd2hpY2ggd2FzIGdlbmVyYWxseSB3ZWxsIHJl
Y2VpdmVkIGJ5IHRoZSBEVApmb2xrcy4KClJlZ2FyZHMsCkx1Y2FzCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
