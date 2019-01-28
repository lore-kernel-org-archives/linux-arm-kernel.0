Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB73C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:07:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D048D2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yu25FL6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D048D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cw5O2yRsVU1aJ3GRry4Pnha46TKLe+Owi9fExiLUT/I=; b=Yu25FL6WO63b4H
	0f3gruKke1OcH/VddJMw7pxlbtVdSQ165nqau117sH0Hzi8OWqdLoBwvyDYRuf9RZqonBvdGXix9x
	vzqtfun1MTq8T8jIGYtggIYuHv/JCj/lCg7fDdvLgyGHMJuiqP/UwPEmMqaS+w9WAdLMmpPkTsePY
	FZzH934Z8IXHVbl2C6TYMgzA/FaiR9X1Db6sl9xs/UCDXzsdFSZZnO1w8K449e7sDLDsXxiRX4B5Y
	7MGLqWyYVVRnhcNzXebYtAgOfs4lLLcxQIPdl2lNDZT4ek5NP14Z7CBGkKckiz9DlnQFYIX2K9+Tl
	Z3vWklb8u6rJz2TFtszA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3ol-0007Ld-Va; Mon, 28 Jan 2019 10:07:03 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3oi-0007Kx-6Y
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:07:02 +0000
X-Originating-IP: 90.88.29.206
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1F277E000D;
 Mon, 28 Jan 2019 10:06:51 +0000 (UTC)
Date: Mon, 28 Jan 2019 11:06:50 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/4] clk: core: link consumer with clock driver
Message-ID: <20190128110650.76367606@xps13>
In-Reply-To: <154845170894.136743.2408260720819956377@swboyd.mtv.corp.google.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
 <20181204192440.12125-3-miquel.raynal@bootlin.com>
 <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
 <20190104165406.3b52399a@xps13>
 <154845170894.136743.2408260720819956377@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_020700_543859_AA861754 
X-CRM114-Status: GOOD (  25.04  )
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
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3RlcGhlbiwKClN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGUgb24gRnJp
LCAyNSBKYW4gMjAxOSAxMzoyODoyOAotMDgwMDoKCj4gUXVvdGluZyBNaXF1ZWwgUmF5bmFsICgy
MDE5LTAxLTA0IDA3OjU0OjA2KQo+ID4gSGkgU3RlcGhlbiwKPiA+IAo+ID4gU3RlcGhlbiBCb3lk
IDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZSBvbiBUdWUsIDExIERlYyAyMDE4IDA5OjEyOjU1Cj4g
PiAtMDgwMDoKPiA+ICAgCj4gPiA+IFNvcnJ5LCBJJ20gbm90IHJldmlld2luZyB0aGUgd2hvbGUg
cGF0Y2ggcmlnaHQgbm93LCBqdXN0IHRoaXMgb25lIGxpdHRsZQo+ID4gPiBiaXQgYmVjYXVzZSBJ
J20gYWxzbyB3b3JraW5nIGluIHRoZSBzYW1lIGFyZWEuCj4gPiA+IAo+ID4gPiBRdW90aW5nIE1p
cXVlbCBSYXluYWwgKDIwMTgtMTItMDQgMTE6MjQ6MzgpICAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9jbGstcHJvdmlkZXIuaCBiL2luY2x1ZGUvbGludXgvY2xrLXByb3ZpZGVy
LmgKPiA+ID4gPiBpbmRleCA2MGM1MTg3MWIwNGIuLjcyMWQ2YjU1YjJmYSAxMDA2NDQKPiA+ID4g
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Nsay1wcm92aWRlci5oCj4gPiA+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9jbGstcHJvdmlkZXIuaAo+ID4gPiA+IEBAIC03ODEsNiArNzgxLDggQEAgdm9pZCBk
ZXZtX2Nsa19od191bnJlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGNsa19odyAq
aHcpOwo+ID4gPiA+ICBjb25zdCBjaGFyICpfX2Nsa19nZXRfbmFtZShjb25zdCBzdHJ1Y3QgY2xr
ICpjbGspOwo+ID4gPiA+ICBjb25zdCBjaGFyICpjbGtfaHdfZ2V0X25hbWUoY29uc3Qgc3RydWN0
IGNsa19odyAqaHcpOwo+ID4gPiA+ICBzdHJ1Y3QgY2xrX2h3ICpfX2Nsa19nZXRfaHcoc3RydWN0
IGNsayAqY2xrKTsKPiA+ID4gPiArdm9pZCBjbGtfbGlua19jb25zdW1lcihzdHJ1Y3QgZGV2aWNl
ICpjb25zdW1lciwgc3RydWN0IGNsayAqY2xrKTsKPiA+ID4gPiArdm9pZCBjbGtfdW5saW5rX2Nv
bnN1bWVyKHN0cnVjdCBjbGsgKmNsayk7ICAgIAo+ID4gPiAKPiA+ID4gV2Ugc2hvdWxkbid0IG5l
ZWQgdG8gYWRkIHRoZXNlIGZ1bmN0aW9ucyBhcyBmYXIgYXMgSSBjYW4gdGVsbC4gVGhhdCdzCj4g
PiA+IGJlY2F1c2UgX19jbGtfZ2V0KCkgaGFzIGJlY29tZSBhbiBpbnRlcm5hbCBBUEkgYmV0d2Vl
biBjbGtkZXYuYyBhbmQKPiA+ID4gY2xrLmMgdGhhdCBkb2VzIG5vdGhpbmcgbm93IG9uIGltcGxl
bWVudGF0aW9ucyB0aGF0IGFyZW4ndCB0aGUgQ0NGLiBXZQo+ID4gPiBjYW4gZXZlbiBjaGFuZ2Ug
dGhpcyBBUEkgdG8gdGFrZSBhIGNsa19odyBwb2ludGVyIGluc3RlYWQgb2YgYSBjbGsKPiA+ID4g
cG9pbnRlci4KPiA+ID4gCj4gPiA+IEknZCByYXRoZXIgc2VlIHVzIHBsdW1iIGEgc3RydWN0IGRl
dmljZSBhbmQgY2xrX2h3IHN0cnVjdHVyZSBkb3duIGludG8KPiA+ID4gX19jbGtfZ2V0KCkgYW5k
IGZvbGQgaXQgYWxsIGludG8gX19jbGtfY3JlYXRlX2NsaywgcG9zc2libHkgZXZlbgo+ID4gPiBy
ZW5hbWluZyBfX2Nsa19jcmVhdGVfY2xrIHRvIGNsa19od19jcmVhdGVfY2xrKCkuIFRoYXQgd2F5
IHdlIGNhbiBnZXQKPiA+ID4gdGhlIGNhbGxpbmcgZGV2aWNlIGFuZCBjbGtfaHcgcG9pbnRlciBp
biBvbmUgY2FsbCBpbiB0aGUgY2xrIGZyYW1ld29yaywKPiA+ID4gYWxvbmcgd2l0aCB0aGUgZGV2
aWNlIG5hbWUgYW5kIGNvbm5lY3Rpb24gbmFtZSwgYW5kIHRoZW4gZ2VuZXJhdGUgdGhlCj4gPiA+
IHN0cnVjdCBjbGsgcmlnaHQgdGhlcmUuIFRoaXMgY2FuIHNpbXBsaWZ5IHNvbWUgY29kZSBhbmQg
bWFrZSBpdCBlYXNpZXIKPiA+ID4gdG8gZXh0ZW5kIHRoaXMgdG8gYXNzb2NpYXRlIGNhbGxpbmcg
ZGV2aWNlcyB3aXRoIHRoZSBjbGsgY29uc3VtZXIKPiA+ID4gc29tZWhvdy4KPiA+ID4gCj4gPiA+
IEhlcmUncyB0aGUgZGlmZi4gV2l0aCB0aGlzLCB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gYWRkIGFu
ZCByZW1vdmUgZGV2aWNlCj4gPiA+IGxpbmtzIGluIGNsa19od19jcmVhdGVfY2xrKCkgd2hlbiBk
ZXYgIT0gTlVMTC4gIAo+ID4gCj4gPiBUaGFua3MgZm9yIHRoZSBoZWxwOyBJIHVwZGF0ZWQgbXkg
d29yayBvbiB0b3Agb2YgeW91cnMsIGl0IGxvb2tzIG9rIGJ1dAo+ID4gSSBuZWVkIHRvIHJ1biBz
b21lIG1vcmUgdGVzdHMuCj4gPiAKPiA+IEhvd2V2ZXIgSSBoYWQgdG8gdHdlYWsgYSBwYXJhbWV0
ZXIgaW4gb25lIG9mIHlvdXIgcmVjZW50IGNoYW5nZXMsIHlvdQo+ID4gdXNlZCAnLTEnIGFzIGlu
ZGV4IGluIF9fb2ZfY2xvY2tfZ2V0KCkgd2hpbGUgaXQgaXMgbm90IGEgdmFsaWQgdmFsdWUKPiA+
IChyZXR1cm5pbmcgYW4gZXJyb3IpLiBBcyBpbiB0aGUgX19vZl9jbGtfZ2V0X2J5X25hbWUoKSBm
dW5jdGlvbiB5b3UKPiA+IHJlbW92ZWQgaW5kZXggd2FzIGp1c3Qgc2V0IHRvIDAgYXQgdGhlIHRv
cCBvZiB0aGUgZnVuY3Rpb24sIEkgdGhpbmsgdGhlCj4gPiBiZWxvdyBmaXggaXMgdmFsaWQuICAK
PiAKPiBUaGFua3MuIE1ha2VzIHNlbnNlIHNvIEkgZm9sZGVkIGl0IGluLgoKR3JlYXQhCgpDYW4g
eW91IHVwZGF0ZSBtZSB3aXRoIHRoZSBzdGF0dXMgb2YgdGhpcyBzZXJpZXM/IElzIGl0IGdvaW5n
IGluIGZvciA1LjE/CgpMb3JlbnpvLCB0aGUgUENJIG1haW50YWluZXIsIGlzIHdhaXRpbmcgZm9y
IHRoaXMgc2VyaWVzIHRvIGVudGVyIGJlZm9yZQphY2NlcHRpbmcgYW5vdGhlciBzZXJpZXMgZGVw
ZW5kaW5nIG9uIGl0OyBzbyBwbGVhc2UgZG8gbm90IGhlc2l0YXRlIHRvCmtlZXAgbWUgdXBkYXRl
ZC4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
