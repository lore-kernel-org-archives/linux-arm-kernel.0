Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:31:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDE820834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IWL7Z1bL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ANYz5Xbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDE820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oCd4LUFpbe+On/ueraklqnbriX8PNHuv/kVo0sP/+RA=; b=IWL7Z1bLi2kc/X
	JmiDo0ZIwB2vTGgmaO8wZcas286hkmVkn0B/BT/F+5rLuqwtW3thlx/+miTd9aifZvipmXX8ap9TK
	QpwevSB4m8LiP2uXQhswDnsOdo8G0yVfpg8yqXecZOf9IqolIc8c8arrHXlgnlvfAoAV33NTUGCQY
	3UmI3bkXS1WbM9SbozU/ve4cn7dG/vVf3XyiKNdSh6QKDGcKsZ6Rtor53L/FlHcllVHj1rA87PQRv
	yDWQK2MkwRjvImPe3x1v40A/1yKtb/RJbhCEGQ7IVoRCL/36P1kd0+e3z2KT6iYqk1Cf2YOsR9dI1
	tcmCHN2N7qL8eNZKJdCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSlhV-0006NE-He; Fri, 30 Nov 2018 16:31:33 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSlhN-0006Df-Tm
 for linux-arm-kernel@bombadil.infradead.org; Fri, 30 Nov 2018 16:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AED7NkUWzyz694rK7r0Lk4H9tVOXzfv60efytOWchtY=; b=ANYz5Xbf2lZC3g3UaO7wwq0UHZ
 wURyx2uZrgyAmg+xTAlKltFPAyRuDoBJX0JEI1JBos9xj0HKqYyE4ft0YExm1Sn0Lb8VojnNQYgB9
 OBbhYC7Xwx6/FFlvhLhSaUiA4UBSbqalVCHa+CmafWSDT1q2bD0rDmqpp+rYb47J1wWLkgza8g36O
 2jrpxXENOcwRtnr+3vqqTsRVglFOgh11drTqqVxCka9d0BU1YyREE8QOGFMuQ/t1nUBvb7x/LpT5M
 dII4OVN1A7OOifEq+RqLubcnR4r0w/SEmXwe+5SE4CQYIcL55SpRxoHkx5ei9hT2lD+A2AJFhko42
 e+hqOoEg==;
Received: from mail.bootlin.com ([62.4.15.54])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkuc-0004iV-R0
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:41:03 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A90F220DC1; Fri, 30 Nov 2018 16:40:49 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9087020D17;
 Fri, 30 Nov 2018 16:40:18 +0100 (CET)
Date: Fri, 30 Nov 2018 16:40:16 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/7] ata: libahci_platform: comply to PHY framework
Message-ID: <20181130164016.7699efb3@xps13>
In-Reply-To: <f14c6e8e-73a9-0b62-0dbc-87d390789c0c@redhat.com>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
 <20181123101556.29888-2-miquel.raynal@bootlin.com>
 <f14c6e8e-73a9-0b62-0dbc-87d390789c0c@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_104103_102515_669BA854 
X-CRM114-Status: GOOD (  26.32  )
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
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSGFucywKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCkhhbnMgZGUgR29lZGUgPGhkZWdvZWRl
QHJlZGhhdC5jb20+IHdyb3RlIG9uIEZyaSwgMjMgTm92IDIwMTggMTE6MzM6MTUKKzAxMDA6Cgo+
IEhpIE1pcXVlbCwKPiAKPiBPbiAyMy0xMS0xOCAxMToxNSwgTWlxdWVsIFJheW5hbCB3cm90ZToK
PiA+IEN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgdGhlIGxpYmFoY2kgZG9lcyBub3QgdGFrZSBp
bnRvIGFjY291bnQgdGhlCj4gPiBuZXcgUEhZIGZyYW1ld29yay4gQ29ycmVjdCB0aGUgc2l0dWF0
aW9uIGJ5IGFkZGluZyBhIGNhbGwgdG8KPiA+IHBoeV9zZXRfbW9kZSgpIGJlZm9yZSBwaHlfcG93
ZXJfb24oKSBhbmQgYnkgYWRkaW5nIGNhbGxzIHRvCj4gPiBhaGNpX3BsYXRmb3JtX2VuYWJsZS9k
aXNhYmxlX3BoeXMoKSBhdCBzdXNwZW5kL3Jlc3VtZV9ob3N0KCkgdGltZS4KPiA+IAo+ID4gU2ln
bmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KPiA+
IC0tLQo+ID4gICBkcml2ZXJzL2F0YS9saWJhaGNpX3BsYXRmb3JtLmMgfCAxMSArKysrKysrKysr
Kwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0Zm9ybS5jIGIvZHJpdmVycy9hdGEvbGliYWhj
aV9wbGF0Zm9ybS5jCj4gPiBpbmRleCA0YjkwMGZjNjU5ZjcuLjlmMzNmNzJiNjc0YiAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYwo+ID4gKysrIGIvZHJpdmVy
cy9hdGEvbGliYWhjaV9wbGF0Zm9ybS5jCj4gPiBAQCAtNTYsNiArNTYsMTIgQEAgc3RhdGljIGlu
dCBhaGNpX3BsYXRmb3JtX2VuYWJsZV9waHlzKHN0cnVjdCBhaGNpX2hvc3RfcHJpdiAqaHByaXYp
Cj4gPiAgIAkJaWYgKHJjKQo+ID4gICAJCQlnb3RvIGRpc2FibGVfcGh5czsgIAo+ID4gICA+ICsJ
CXJjID0gcGh5X3NldF9tb2RlKGhwcml2LT5waHlzW2ldLCBQSFlfTU9ERV9TQVRBKTsgIAo+ID4g
KwkJaWYgKHJjKSB7Cj4gPiArCQkJcGh5X2V4aXQoaHByaXYtPnBoeXNbaV0pOwo+ID4gKwkJCWdv
dG8gZGlzYWJsZV9waHlzOwo+ID4gKwkJfQo+ID4gKyAgCj4gCj4gSSBzZWUgdGhhdCBwaHlfc2V0
X21vZGUgcmV0dXJucyAwIGZvciBkcml2ZXJzIHdoaWNoIGRvIG5vdCBpbXBsZW1lbnQgaXQsCj4g
c28gdGhpcyBzaG91bGQgYmUgZmluZS4KPiAKPiAKPiA+ICAgCQlyYyA9IHBoeV9wb3dlcl9vbiho
cHJpdi0+cGh5c1tpXSk7Cj4gPiAgIAkJaWYgKHJjKSB7Cj4gPiAgIAkJCXBoeV9leGl0KGhwcml2
LT5waHlzW2ldKTsKPiA+IEBAIC03MzgsNiArNzQ0LDggQEAgaW50IGFoY2lfcGxhdGZvcm1fc3Vz
cGVuZF9ob3N0KHN0cnVjdCBkZXZpY2UgKmRldikKPiA+ICAgCXdyaXRlbChjdGwsIG1taW8gKyBI
T1NUX0NUTCk7Cj4gPiAgIAlyZWFkbChtbWlvICsgSE9TVF9DVEwpOyAvKiBmbHVzaCAqLyAgCj4g
PiAgID4gKwlhaGNpX3BsYXRmb3JtX2Rpc2FibGVfcGh5cyhocHJpdik7ICAKPiA+ICsKPiA+ICAg
CXJldHVybiBhdGFfaG9zdF9zdXNwZW5kKGhvc3QsIFBNU0dfU1VTUEVORCk7Cj4gPiAgIH0KPiA+
ICAgRVhQT1JUX1NZTUJPTF9HUEwoYWhjaV9wbGF0Zm9ybV9zdXNwZW5kX2hvc3QpOyAgCj4gCj4g
SSdtIGFmcmFpZCB0aGF0IHRoaXMgYW5kIHRoZSBtYXRjaGluZyBjaGFuZ2UgaW4gYWhjaV9wbGF0
Zm9ybV9zdXNwZW5kX2hvc3QKPiBuZWVkcyB0byBiZSBndWFyZGVkIGJ5IGEgZmxhZywgdGhlcmUg
YXJlIHF1aXRlIGEgZmV3IHNhdGEgZHJpdmVycwo+IHVzaW5nIHRoZSBsaWJhaGNpX3BsYXRmb3Jt
IGZ1bmN0aW9ucyBhcyB3ZWxsIGFzIHF1aXRlIGEgZmV3IHNhdGEgZHJpdmVycwo+IGNvbWJpbmlu
ZyB0aGlzIHdpdGggdXNpbmcgcGh5IGRyaXZlcnMuCj4gCj4gSSdtIHdvcnJpZWQgdGhhdCBkb2lu
ZyB0aGlzIHVuY29uZGl0aW9uYWxseSBvbiBkcml2ZXJzIHdoaWNoIGhhdmUKPiBub3QgYmVlbiB0
ZXN0ZWQgd2l0aCB0aGlzIGNoYW5nZSBteSBicmVhayB0aGluZ3MuCj4gCj4gSSB0aGluayBpdCBt
aWdodCBiZSBjbGVhbmVzdCB0byBleHRlbmQgdGhlIGV4aXN0aW5nIGZsYWdzIHBhc3NlZAo+IHRv
IGFoY2lfcGxhdGZvcm1fZ2V0X3Jlc291cmNlcyB3aXRoIGEgZmxhZyBmb3IgdGhpcyBhbmQgc3Rv
cmluZyB0aGVtCj4gc29tZXdoZXJlIGluIGFoY2lfaG9zdF9wcml2IHNvIHRoYXQgdGhlIHN1c3Bl
bmQvcmVzdW1lIGZ1bmN0aW9ucyBjYW4KPiBnZXQgdG8gdGhlbS4KCkkgdW5kZXJzdGFuZCB5b3Vy
IGNvbmNlcm4sIHBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGUgdjIgd2hpY2ggYWRkcmVzc2VzCnRo
aXMgdGhlIHdheSB5b3Ugc3VnZ2VzdGVkLgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
