Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:29:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377222075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jjxkQc+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377222075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lh8MGjUbodzWgGQ3Uv1XhdWJ3k9+HSu4nx1NIRPPs7g=; b=jjxkQc+NqFZgAd
	YxtIyM9JrkZBhvi1NhE13MVIIsFGW/4q55SWegvtj+RLm6SZjOQ5jclaW1yGkSw1+lh0LfZLEiic5
	B6Ca9RFYp6N0Q2Vwy+XdeJqL4rGcI4isoisVzFH8zpc66Do7s7ghBCWO0WIoTLAQeFSiyCe4n9A6F
	3ADEN5halyjBpYEEcBXbMojjxOx/CiWfVB+eKdUgnmXYCAGzwu0wYQJEGpnFyD0QtYQEH/phXV3k1
	wzfeY3mZQDP43eCzJRBXj9uK9HKmhaNFvM0LZQbTrzKKHNyDTkxN+Xdil+Cdz/Bo+xd8fYWRdSlXd
	MxxPHN01iGC/dDjeAQRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxClb-0001SE-DQ; Fri, 22 Feb 2019 15:29:35 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxClS-0001N6-HC
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:29:33 +0000
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 26590200017;
 Fri, 22 Feb 2019 15:29:12 +0000 (UTC)
Date: Fri, 22 Feb 2019 16:29:12 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 5/5] arm64: dts: marvell: armada-cp110: Switch to
 per-port SATA interrupts
Message-ID: <20190222162912.39e17579@xps13>
In-Reply-To: <20190222151335.r27yreym5bhaoqaw@shell.armlinux.org.uk>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-6-miquel.raynal@bootlin.com>
 <20190222151335.r27yreym5bhaoqaw@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_072926_876010_8FF72C6B 
X-CRM114-Status: GOOD (  19.83  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUnVzc2VsbCwKClRoYW5rcyBmb3IgdGhlIHJldmlldywKClJ1c3NlbGwgS2luZyAtIEFSTSBM
aW51eCBhZG1pbiA8bGludXhAYXJtbGludXgub3JnLnVrPiB3cm90ZSBvbiBGcmksIDIyCkZlYiAy
MDE5IDE1OjEzOjM1ICswMDAwOgoKPiBPbiBGcmksIEZlYiAyMiwgMjAxOSBhdCAwMzo1Mzo1NlBN
ICswMTAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+ID4gRnJvbTogVGhvbWFzIFBldGF6em9uaSA8
dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT4KPiA+IAo+ID4gVGhlcmUgYXJlIHR3byBTQVRB
IHBvcnRzIHBlciBDUDExMC4gRWFjaCBvZiB0aGVtIGhhcyBhIGRlZGljYXRlZAo+ID4gaW50ZXJy
dXB0LiBEZXNjcmliZSB0aGUgcmVhbCBoYXJkd2FyZSBieSBhZGRpbmcgdHdvIFNBVEEgcG9ydHMg
dG8gdGhlCj4gPiBDUDExMCBTQVRBIG5vZGUgYW5kIGVuYWJsaW5nIHRoZW0gaW4gYWxsIHRoZSBE
VHMgaW5jbHVkaW5nIGl0Cj4gPiAoNzA0MC1kYi84MDQwLWRiLzgwNDAtY2xlYXJmb2cpLgo+ID4g
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgUGV0YXp6b25pIDx0aG9tYXMucGV0YXp6b25pQGJv
b3RsaW4uY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5h
bEBib290bGluLmNvbT4KPiA+IC0tLQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9h
cm1hZGEtNzA0MC1kYi5kdHMgfCAgNyArKysrKystCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL2FybWFkYS04MDQwLWRiLmR0cyB8IDE0ICsrKysrKysrKysrKy0tCj4gPiAgYXJjaC9h
cm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDExMC5kdHNpICB8IDE2ICsrKysrKysrKysr
KysrLS0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJt
YWRhLTcwNDAtZGIuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS03MDQw
LWRiLmR0cwo+ID4gaW5kZXggNDEyZWZkYjQ2ZTdjLi41NGMxYzBkZGM4MTMgMTAwNjQ0Cj4gPiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTcwNDAtZGIuZHRzCj4gPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTcwNDAtZGIuZHRzCj4gPiBA
QCAtMTk0LDcgKzE5NCwxMiBAQAo+ID4gIH07Cj4gPiAgCj4gPiAgJmNwMF9zYXRhMCB7Cj4gPiAt
CXN0YXR1cyA9ICJva2F5IjsKPiA+ICsJc2F0YS1wb3J0QDAgeyAgCj4gCj4gRG9uJ3QgdGhlc2Ug
YWxsIG5lZWQgYSByZWcgPSA8Tj4gdG8gY29ycmVzcG9uZCB3aXRoIEBOIGluIHRoZSBub2RlIG5h
bWU/CgpZZXMgYSByZWcgcHJvcGVydHkgaXMgYWRkZWQgdG8gdGhlIHNhdGEtcG9ydChzKSBzdWIt
bm9kZXMgd2hlbiB0aGV5IGFyZQpkZWZpbmVkIChoZXJlIHRoZXkgYXJlIGp1c3QgZW5hYmxlZCwg
c2VlIGJlbG93KS4KCj4gCj4gPiArCQlzdGF0dXMgPSAib2theSI7Cj4gPiArCX07Cj4gPiArCXNh
dGEtcG9ydEAxIHsKPiA+ICsJCXN0YXR1cyA9ICJva2F5IjsKPiA+ICsJfTsKPiA+ICB9Owo+ID4g
IAo+ID4gICZjcDBfdXNiM18wIHsKPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L21hcnZlbGwvYXJtYWRhLTgwNDAtZGIuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxs
L2FybWFkYS04MDQwLWRiLmR0cwo+ID4gaW5kZXggMWJhYzQzNzM2OWExLi45ODhjYzdkYzE1ZDkg
MTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAt
ZGIuZHRzCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAt
ZGIuZHRzCj4gPiBAQCAtMTQ3LDcgKzE0NywxMiBAQAo+ID4gIAo+ID4gIC8qIENPTjQgb24gQ1Aw
IGV4cGFuc2lvbiAqLwo+ID4gICZjcDBfc2F0YTAgewo+ID4gLQlzdGF0dXMgPSAib2theSI7Cj4g
PiArCXNhdGEtcG9ydEAwIHsKPiA+ICsJCXN0YXR1cyA9ICJva2F5IjsKPiA+ICsJfTsKPiA+ICsJ
c2F0YS1wb3J0QDEgewo+ID4gKwkJc3RhdHVzID0gIm9rYXkiOwo+ID4gKwl9Owo+ID4gIH07Cj4g
PiAgCj4gPiAgLyogQ09OOSBvbiBDUDAgZXhwYW5zaW9uICovCj4gPiBAQCAtMjc5LDcgKzI4NCwx
MiBAQAo+ID4gIAo+ID4gIC8qIENPTjQgb24gQ1AxIGV4cGFuc2lvbiAqLwo+ID4gICZjcDFfc2F0
YTAgewo+ID4gLQlzdGF0dXMgPSAib2theSI7Cj4gPiArCXNhdGEtcG9ydEAwIHsKPiA+ICsJCXN0
YXR1cyA9ICJva2F5IjsKPiA+ICsJfTsKPiA+ICsJc2F0YS1wb3J0QDEgewo+ID4gKwkJc3RhdHVz
ID0gIm9rYXkiOwo+ID4gKwl9Owo+ID4gIH07Cj4gPiAgCj4gPiAgLyogQ09OOSBvbiBDUDEgZXhw
YW5zaW9uICovCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2Fy
bWFkYS1jcDExMC5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDEx
MC5kdHNpCj4gPiBpbmRleCBiOWQ5ZjMxZTNiYTEuLmYyN2VkZGRjYWNkMSAxMDA2NDQKPiA+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtY3AxMTAuZHRzaQo+ID4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1jcDExMC5kdHNpCj4gPiBAQCAt
MjkyLDEwICsyOTIsMjIgQEAKPiA+ICAJCQkiZ2VuZXJpYy1haGNpIjsKPiA+ICAJCQlyZWcgPSA8
MHg1NDAwMDAgMHgzMDAwMD47Cj4gPiAgCQkJZG1hLWNvaGVyZW50Owo+ID4gLQkJCWludGVycnVw
dHMgPSA8MTA3IElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4gIAkJCWNsb2NrcyA9IDwmQ1AxMTBf
TEFCRUwoY2xrKSAxIDE1PiwKPiA+ICAJCQkJIDwmQ1AxMTBfTEFCRUwoY2xrKSAxIDE2PjsKPiA+
IC0JCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Owo+
ID4gKwkJCSNzaXplLWNlbGxzID0gPDA+Owo+ID4gKwo+ID4gKwkJCXNhdGEtcG9ydEAwIHsKPiA+
ICsJCQkJcmVnID0gPDA+OwoKSGVyZSAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgo+ID4g
KwkJCQlpbnRlcnJ1cHRzID0gPDEwOSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPiA+ICsJCQkJc3Rh
dHVzID0gImRpc2FibGVkIjsKPiA+ICsJCQl9Owo+ID4gKwo+ID4gKwkJCXNhdGEtcG9ydEAxIHsK
PiA+ICsJCQkJcmVnID0gPDE+Owo+ID4gKwkJCQlpbnRlcnJ1cHRzID0gPDEwNyBJUlFfVFlQRV9M
RVZFTF9ISUdIPjsKPiA+ICsJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+ICsJCQl9Owo+ID4g
IAkJfTsKPiA+ICAKPiA+ICAJCUNQMTEwX0xBQkVMKHhvcjApOiB4b3JANmEwMDAwIHsKPiA+IC0t
IAo+ID4gMi4xOS4xCj4gPiAKPiA+IAo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cj4gPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo+ID4gICAKPiAKCgpU
aGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
