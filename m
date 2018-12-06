Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7178BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:37:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDF820878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EUP7qFt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDF820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ekIqMBXInRjGWyvxqI1uRPtZWWFFXo7Ktv9pIRZ/VPA=; b=EUP7qFt9/nZnW/
	flE41ML8PA5FRSk2iBwziTnJWpxJnm23bH961bnAf5SWlwFZBKmGBcc1TT+I50yEclQ22o/w1Fuc7
	6fk9NCXm6J8+/0GLA10yg90vGbMdkaM2lhg5WbJVuaWxNuK0UMgEQG/xDJpBWPAR0Z0USRKCCYf72
	yo7AyMolqlwL6xDx+7QTCraABQ5TbeL82edEylM67OUV1Bj90S4BT8+FA49E95LJGSkAIkp3HUXL9
	zSLpkBGDjEC6S17oWBI6bLcGMQzLjX2M6g3uhLXjg0hxpcyTWVaLWcY+vbHNjhMSq5q4uMAb+/We/
	lSZ36dku+KRLmVUamFeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUry3-0008Gw-1v; Thu, 06 Dec 2018 11:37:19 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUrxz-0008G9-4H
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:37:17 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gUrxg-0006GY-Ld; Thu, 06 Dec 2018 12:36:56 +0100
Message-ID: <1544096216.3709.63.camel@pengutronix.de>
Subject: Re: [PATCH 5/5] irqchip/irq-imx-gpcv2: Add support for i.MX8MQ
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Marc Zyngier
 <marc.zyngier@arm.com>
Date: Thu, 06 Dec 2018 12:36:56 +0100
In-Reply-To: <20181206073125.7255-6-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
 <20181206073125.7255-6-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_033715_330812_5AD128A0 
X-CRM114-Status: GOOD (  18.16  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAwNS4xMi4yMDE4LCAyMzozMSAtMDgwMCBzY2hyaWViIEFuZHJleSBT
bWlybm92Ogo+IEFkZCBjb2RlIG5lZWRlZCB0byBzdXBwb3J0IGkuTVg4TVEuCj4gCj4gPiBDYzog
VGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4gPiBDYzogSmFzb24gQ29vcGVy
IDxqYXNvbkBsYWtlZGFlbW9uLm5ldD4KPiA+IENjOiBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2ll
ckBhcm0uY29tPgo+IENjOiBjcGhlYWx5QGdtYWlsLmNvbQo+IENjOiBsLnN0YWNoQHBlbmd1dHJv
bml4LmRlCj4gPiBDYzogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4K
PiA+IENjOiAiQS5zLiBEb25nIiA8YWlzaGVuZy5kb25nQG54cC5jb20+Cj4gPiBDYzogUmljaGFy
ZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPgo+IENjOiBsaW51eC1pbXhAbnhwLmNvbQo+IENj
OiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZwo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTbWlybm92IDxhbmRyZXcu
c21pcm5vdkBnbWFpbC5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL2lycWNoaXAvaXJxLWlteC1ncGN2
Mi5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDI5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaXJxY2hpcC9pcnEtaW14LWdwY3YyLmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1n
cGN2Mi5jCj4gaW5kZXggYzJiMmIzMTI4ZGRkLi4xN2EyZGFkMmQ0YzIgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtZ3BjdjIuYwo+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9p
cnEtaW14LWdwY3YyLmMKPiBAQCAtMTcsNiArMTcsOSBAQAo+IMKgCj4gPiDCoCNkZWZpbmUgR1BD
X0lNUjFfQ09SRTAJCTB4MzAKPiA+IMKgI2RlZmluZSBHUENfSU1SMV9DT1JFMQkJMHg0MAo+ID4g
KyNkZWZpbmUgR1BDX0lNUjFfQ09SRTIJCTB4MWMwCj4gPiArI2RlZmluZSBHUENfSU1SMV9DT1JF
MwkJMHgxZDAKPiArCj4gwqAKPiDCoHN0cnVjdCBncGN2Ml9pcnFjaGlwX2RhdGEgewo+ID4gPiDC
oAlzdHJ1Y3QgcmF3X3NwaW5sb2NrCXJsb2NrOwo+IEBAIC0xOTIsMTEgKzE5NSwxOSBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGlycV9kb21haW5fb3BzIGdwY3YyX2lycWNoaXBfZGF0YV9kb21haW5f
b3BzID0gewo+ID4gPiDCoAkuZnJlZQkJPSBpcnFfZG9tYWluX2ZyZWVfaXJxc19jb21tb24sCj4g
wqB9Owo+IMKgCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGdwY3YyX29mX21h
dGNoW10gPSB7Cj4gPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDdkLWdwYyIswqDCoC5kYXRh
ID0gKGNvbnN0IHZvaWQgKikgMiB9LAo+ID4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bXEt
Z3BjIiwgLmRhdGEgPSAoY29uc3Qgdm9pZCAqKSA0IH0sCj4gPiArCXsgLyogRU5EICovIH0KPiAr
fTsKPiArCj4gwqBzdGF0aWMgaW50IF9faW5pdCBpbXhfZ3BjdjJfaXJxY2hpcF9pbml0KHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbm9kZSwKPiA+IMKgCQkJwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNl
X25vZGUgKnBhcmVudCkKPiDCoHsKPiA+IMKgCXN0cnVjdCBpcnFfZG9tYWluICpwYXJlbnRfZG9t
YWluLCAqZG9tYWluOwo+ID4gwqAJc3RydWN0IGdwY3YyX2lycWNoaXBfZGF0YSAqY2Q7Cj4gPiAr
CWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKmlkOwo+ID4gKwl1bnNpZ25lZCBsb25nIGNvcmVf
bnVtOwo+ID4gwqAJaW50IGk7Cj4gwqAKPiA+IMKgCWlmICghcGFyZW50KSB7Cj4gQEAgLTIwNCw2
ICsyMTUsMTQgQEAgc3RhdGljIGludCBfX2luaXQgaW14X2dwY3YyX2lycWNoaXBfaW5pdChzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUsCj4gPiDCoAkJcmV0dXJuIC1FTk9ERVY7Cj4gPiDCoAl9Cj4g
wqAKPiA+ICsJaWQgPSBvZl9tYXRjaF9ub2RlKGdwY3YyX29mX21hdGNoLCBub2RlKTsKPiA+ICsJ
aWYgKCFpZCkgewo+ID4gKwkJcHJfZXJyKCIlcE9GOiB1bmtub3duIGNvbXBhdGliaWxpdHkgc3Ry
aW5nXG4iLCBub2RlKTsKPiA+ICsJCXJldHVybiAtRU5PREVWOwo+ID4gKwl9Cj4gKwo+ID4gKwlj
b3JlX251bSA9ICh1bnNpZ25lZCBsb25nKWlkLT5kYXRhOwo+ICsKPiA+IMKgCXBhcmVudF9kb21h
aW4gPSBpcnFfZmluZF9ob3N0KHBhcmVudCk7Cj4gPiDCoAlpZiAoIXBhcmVudF9kb21haW4pIHsK
PiA+IMKgCQlwcl9lcnIoIiVwT0Y6IHVuYWJsZSB0byBnZXQgcGFyZW50IGRvbWFpblxuIiwgbm9k
ZSk7Cj4gQEAgLTIzNiw4ICsyNTUsMTYgQEAgc3RhdGljIGludCBfX2luaXQgaW14X2dwY3YyX2ly
cWNoaXBfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsCj4gwqAKPiA+IMKgCS8qIEluaXRp
YWxseSBtYXNrIGFsbCBpbnRlcnJ1cHRzICovCj4gPiDCoAlmb3IgKGkgPSAwOyBpIDwgSU1SX05V
TTsgaSsrKSB7Cj4gPiAtCQl3cml0ZWxfcmVsYXhlZCh+MCwgY2QtPmdwY19iYXNlICsgR1BDX0lN
UjFfQ09SRTAgKyBpICogNCk7Cj4gPiAtCQl3cml0ZWxfcmVsYXhlZCh+MCwgY2QtPmdwY19iYXNl
ICsgR1BDX0lNUjFfQ09SRTEgKyBpICogNCk7Cj4gPiArCQl2b2lkIF9faW9tZW0gKnJlZyA9IGNk
LT5ncGNfYmFzZSArIGkgKiA0Owo+ICsKPiA+ICsJCXN3aXRjaCAoY29yZV9udW0pIHsKPiA+ICsJ
CWNhc2UgNDoKPiA+ICsJCQl3cml0ZWxfcmVsYXhlZCh+MCwgcmVnICsgR1BDX0lNUjFfQ09SRTIp
Owo+ID4gKwkJCXdyaXRlbF9yZWxheGVkKH4wLCByZWcgKyBHUENfSU1SMV9DT1JFMyk7Cj4gPiA+
ICsJCWNhc2UgMjoJwqDCoMKgwqDCoMKgLyogRkFMTFRIUk9VR0ggKi8KPiA+ICsJCQl3cml0ZWxf
cmVsYXhlZCh+MCwgcmVnICsgR1BDX0lNUjFfQ09SRTApOwo+ID4gKwkJCXdyaXRlbF9yZWxheGVk
KH4wLCByZWcgKyBHUENfSU1SMV9DT1JFMSk7Cj4gKwkJfQoKVGhlIHdyaXRlcyBiZWluZyBub3Qg
YmVpbmcgaW4gbGluZWFyIGRlc2NlbmRpbmcgY29yZSBvcmRlciBkb2VzIHRyaWdnZXIKc29tZXRo
aW5nIGluIG1lLCBidXQgb2J2aW91c2x5IHRoaXMgZG9lc24ndCBoYXMgYW55IGVmZmVjdCBvbiB0
aGUgY29kZSwKc286CgpSZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU+Cgo+IMKgCQljZC0+d2FrZXVwX3NvdXJjZXNbaV0gPSB+MDsKPiA+IMKgCX0KPiDCoAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
