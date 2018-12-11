Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77D2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:09:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD792081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aiRfmyKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD792081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VA5dcHx1hLwQBPuP0uTSq46uM/t5S7L98WA1rnzqrZc=; b=aiRfmyKbslI3+Pa3JjIXhzTls5
	opoQ7Gzv6KMXBKl3y2NebirLjClKwLxJlf6IecKga/kZhHjxi3+zMqat9ognqR2BZqiHakYvO4mUB
	FIujwZdt8UnycZOTYiiL/Wsn/nxoYWImEXmNNe2j6DaXzvcaZ7UJVaBUbDtYv31AhneyHOiXULogg
	meVlnjTwViWlxeRbA3j5REBWHJPt2d4PfZ9FxrE0MQK+h5nLZcJaPdpe7hBpKbtirQ+W+Wwz9rJdg
	gN9/rUEO7QxDANPVOfyi8qaao4GL+Whw/1Xfj+TXkl0nAkqsmsEZIeMXDh3skGzAeCM/Htim5O0+N
	0HKY3gIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlXB-0000MZ-UY; Tue, 11 Dec 2018 17:09:25 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlX7-0000M4-NJ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:09:24 +0000
Received: from tarshish (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 7AD08440205;
 Tue, 11 Dec 2018 19:09:05 +0200 (IST)
References: <8a9652066a649b5349b76c823bef946024161275.1544441887.git.baruch@tkos.co.il>
 <87efaot70c.fsf@bootlin.com>
User-agent: mu4e 1.0; emacs 25.2.2
From: Baruch Siach <baruch@tkos.co.il>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] arm64: dts: marvell: mcbin: fix PCIe reset signal
In-reply-to: <87efaot70c.fsf@bootlin.com>
Date: Tue, 11 Dec 2018 19:09:05 +0200
Message-ID: <87bm5s6le6.fsf@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_090921_980377_E08FC62A 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgR3JlZ29yeSwKCkdyZWdvcnkgQ0xFTUVOVCB3cml0ZXM6Cj4gIE9uIGx1bi4sIGTDqWMuIDEw
IDIwMTgsIEJhcnVjaCBTaWFjaCA8YmFydWNoQHRrb3MuY28uaWw+IHdyb3RlOgo+Cj4+IFRoZSBN
UFA1MiBzaWduYWwgaXMgb24gdGhlIHNlY29uZHMgR1BJTyBpbnN0YW5jZSBvZiBDUDAsIHdoaWNo
Cj4+IGNvcnJlc3BvbmRzIHRvIHRoZSAmY3AwX2dwaW8yIGhhbmRsZS4KPj4KPj4gUmVuYW1lIHRo
ZSBwcm9wZXJ0eSBuYW1lIHRvIHRoZSBzdGFuZGFyZCAnLWdwaW9zJyBzdWZmaXggd2hpbGUgYXQg
aXQuCj4+Cj4+IEZpeGVzOiBiODNlMTY2OWFkY2U2ICgiYXJtNjQ6IGR0czogbWFydmVsbDogbWNi
aW46IGFkZCBzdXBwb3J0IGZvciBQQ0llIikKPj4gU2lnbmVkLW9mZi1ieTogQmFydWNoIFNpYWNo
IDxiYXJ1Y2hAdGtvcy5jby5pbD4KPgo+IFdpdGggdGhlIGxhc3QgY2hhbmdlIGluIGFybWFkYS04
MDQwLW1jYmluLmR0cyB0aGlzIHBhdGNoIG5vIG1vcmUgYXBwbHkKPiBvbiBtdmVidS9kdDY0LgoK
SSB0aG91Z2h0IHRoYXQgdGhpcyBmaXggc2hvdWxkIGdvIHRvIDQuMjAuIEkgd2lsbCBnZW5lcmF0
ZSBhIHBhdGNoIGFnYWluc3QKbXZlYnUvZHQ2NCBpZiB5b3UgcHJlZmVyLgoKYmFydWNoCgo+PiAt
LS0KPj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC1tY2Jpbi5kdHMg
fCAyICstCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0
MC1tY2Jpbi5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAtbWNi
aW4uZHRzCj4+IGluZGV4IDU2ZmE0NDg2MDkwOS4uNDZkYWNmYzA4Y2VjIDEwMDY0NAo+PiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAtbWNiaW4uZHRzCj4+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC1tY2Jpbi5kdHMKPj4g
QEAgLTE4Myw3ICsxODMsNyBAQAo+PiAgCXBpbmN0cmwtMCA9IDwmY3AwX3BjaWVfcGlucz47Cj4+
ICAJbnVtLWxhbmVzID0gPDQ+Owo+PiAgCW51bS12aWV3cG9ydCA9IDw4PjsKPj4gLQlyZXNldC1n
cGlvID0gPCZjcDBfZ3BpbzEgMjAgR1BJT19BQ1RJVkVfTE9XPjsKPj4gKwlyZXNldC1ncGlvcyA9
IDwmY3AwX2dwaW8yIDIwIEdQSU9fQUNUSVZFX0xPVz47Cj4+ICAJc3RhdHVzID0gIm9rYXkiOwo+
PiAgfTsKCi0tIAogICAgIGh0dHA6Ly9iYXJ1Y2guc2lhY2gubmFtZS9ibG9nLyAgICAgICAgICAg
ICAgICAgIH4uIC5+ICAgVGsgT3BlbiBTeXN0ZW1zCj19LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tb29PLS1VLS1Pb28tLS0tLS0tLS0tLS17PQogICAtIGJh
cnVjaEB0a29zLmNvLmlsIC0gdGVsOiArOTcyLjUyLjM2OC40NjU2LCBodHRwOi8vd3d3LnRrb3Mu
Y28uaWwgLQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
