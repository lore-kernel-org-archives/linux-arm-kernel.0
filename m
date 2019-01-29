Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00CFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:43:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3172175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XkE7wr4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3172175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/wP6woXz+D++1ejJFAI9Udc7r/CwdryhkSmALM8rvNE=; b=XkE7wr4T1gkZ55
	zlUiicttWdP87K94GqazrTIevvA434sfzAFyRCD0nqMxwwXZ6+Fvk9IGt0Yfkrd1fxR8Ul7m8CGBj
	yzMLA3wYFydDwcX3xCiUDZIM15VRv9ZlouS77Nf1+sO2R4l34oxXd1Lk0H0h/DT0Pm6GvT3Rx+HaB
	f3LfVCXFvSJi80WFdmsdCzUuKifwj/Lkdxv/cBSdO0DhvfIKv9Li9WUpod7U1OmO31nCGFqvARMUu
	Y8/5HQ0rwpA2J5Zrv0tvlc4I2xAvEds0+Cq3zkpTvjtJZ9bDVSI5nHNKIbcLCyb7Uf18NA7UJPexn
	9RSJxQC+Oh8Z9072OZVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWTh-0007uQ-NR; Tue, 29 Jan 2019 16:43:13 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWTd-0007tU-85
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:43:10 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1goWTV-0002t7-Tq; Tue, 29 Jan 2019 17:43:01 +0100
Message-ID: <1548780179.6869.9.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add QuadSPI controller
From: Lucas Stach <l.stach@pengutronix.de>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 29 Jan 2019 17:42:59 +0100
In-Reply-To: <20190129163457.7107-1-ccaione@baylibre.com>
References: <20190129163457.7107-1-ccaione@baylibre.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_084309_443022_18749A4D 
X-CRM114-Status: GOOD (  15.12  )
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

SGkgQ2FybG8sCgpBbSBEaWVuc3RhZywgZGVuIDI5LjAxLjIwMTksIDE2OjM0ICswMDAwIHNjaHJp
ZWIgQ2FybG8gQ2Fpb25lOgo+IEFkZCBhIG5vZGUgZm9yIHRoZSBGcmVlc2NhbGUvTlhQIFF1YWRT
UEkgY29udHJvbGxlciB3aXRoIGEgcHJvcGVyCj4gcGluY3RybCBzZXQgYW5kIGVuYWJsZSBpdCBm
b3IgdGhlIGkuTVg4TVEgRVZLIGJvYXJkLgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogQ2FybG8gQ2Fp
b25lIDxjY2Fpb25lQGJheWxpYnJlLmNvbT4KPiAtLS0KPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzIHwgMjcgKysrKysrKysrKysrKysrKysrKysKPiDCoGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpwqDCoMKgwqB8IDEzICsrKysr
KysrKysKPiDCoDIgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzCj4gaW5kZXggZjc0YjEzYWE1
YWE1Li5hZTE4MWMyYTUwMDMgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1xLWV2ay5kdHMKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXEtZXZrLmR0cwo+IEBAIC0xMzcsNiArMTM3LDIxIEBACj4gPiDCoAlzdGF0dXMgPSAi
b2theSI7Cj4gwqB9Owo+IMKgCj4gKyZzcGkwIHsKPiA+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsKPiA+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX3FzcGk+Owo+ID4gKwlzdGF0dXMgPSAi
b2theSI7Cj4gKwo+ID4gPiArCWZsYXNoMDogbjI1cTI1NmFAMCB7Cj4gPiArCQlyZWcgPSA8MD47
Cj4gPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+ICsJCSNzaXplLWNlbGxzID0gPDE+Owo+
ID4gKwkJY29tcGF0aWJsZSA9ICJtaWNyb24sbjI1cTI1NmEiLCAiamVkZWMsc3BpLW5vciI7Cj4g
PiArCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwyOTAwMDAwMD47Cj4gPiArCQlzcGktbm9yLGRkci1x
dWFkLXJlYWQtZHVtbXkgPSA8Nj47Cj4gPiArCX07Cj4gK307Cj4gKwo+IMKgJnVzZGhjMSB7Cj4g
PiDCoAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAic3RhdGVfMTAwbWh6IiwgInN0YXRlXzIw
MG1oeiI7Cj4gPiDCoAlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfdXNkaGMxPjsKPiBAQCAtMTk1LDYg
KzIxMCwxOCBAQAo+ID4gwqAJCT47Cj4gPiDCoAl9Owo+IMKgCj4gPiArCXBpbmN0cmxfcXNwaTog
cXNwaWdycCB7Cj4gPiArCQlmc2wscGlucyA9IDwKPiA+ID4gKwkJCU1YOE1RX0lPTVVYQ19OQU5E
X0FMRV9RU1BJX0FfU0NMSwkweDgyCj4gPiA+ICsJCQlNWDhNUV9JT01VWENfTkFORF9DRTBfQl9R
U1BJX0FfU1MwX0IJMHg4Mgo+ID4gPiArCQkJTVg4TVFfSU9NVVhDX05BTkRfREFUQTAwX1FTUElf
QV9EQVRBMAkweDgyCj4gPiA+ICsJCQlNWDhNUV9JT01VWENfTkFORF9EQVRBMDFfUVNQSV9BX0RB
VEExCTB4ODIKPiA+ID4gKwkJCU1YOE1RX0lPTVVYQ19OQU5EX0RBVEEwMl9RU1BJX0FfREFUQTIJ
MHg4Mgo+ID4gPiArCQkJTVg4TVFfSU9NVVhDX05BTkRfREFUQTAzX1FTUElfQV9EQVRBMwkweDgy
Cj4gKwo+ID4gKwkJPjsKPiA+ICsJfTsKPiArCj4gPiDCoAlwaW5jdHJsX3JlZ191c2RoYzI6IHJl
Z3VzZGhjMmdycGdwaW8gewo+ID4gwqAJCWZzbCxwaW5zID0gPAo+ID4gPiDCoAkJCU1YOE1RX0lP
TVVYQ19TRDJfUkVTRVRfQl9HUElPMl9JTzE5CQkweDQxCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1xLmR0c2kKPiBpbmRleCBkYmVkYzRhNWU3ZmIuLmUwMDU5ZjQ1MTU5MSAx
MDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+
ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gQEAgLTUx
Niw2ICs1MTYsMTkgQEAKPiA+IMKgCQkJfTsKPiA+IMKgCQl9Owo+IMKgCj4gKwkJc3BpMDogc3Bp
QDMwYmIwMDAwIHsKCjMwYmIwMDAwIGlzIHBhcnQgb2YgdGhlIEFJUFMzIGJ1cyBhZGRyZXNzIHNw
YWNlLCBzbyBwbGVhc2UgbW92ZSB0aGlzIHRvCnRoZSBjb3JyZWN0IGxvY2F0aW9uIHdpdGhpbiB0
aGlzIGJ1cyBub2RlLgoKPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4gPiArCQkJI3NpemUt
Y2VsbHMgPSA8MD47Cj4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDdkLXFzcGkiOwoKUGxlYXNl
IGFkZCBhICJmc2wsaW14OG1xLXFzcGkiIGNvbXBhdGlibGUgaGVyZSwgYXMgd2FzIGRvbmUgd2l0
aCBhbGwKdGhlIG90aGVyIG5vZGVzIGluIHRoaXMgZmlsZSwgc28gd2UgY2FuIG1hdGNoIHRoaXMg
aW4gdGhlIGRyaXZlciBzaG91bGQKdGhlIG5lZWQgYXJpc2UuCgo+ICsJCQlyZWcgPSA8MHgzMGJi
MDAwMCAweDEwMDAwPiwgPDB4MDgwMDAwMDAgMHgxMDAwMDAwMD47Cj4gPiArCQkJcmVnLW5hbWVz
ID0gIlF1YWRTUEkiLCAiUXVhZFNQSS1tZW1vcnkiOwo+ID4gKwkJCWludGVycnVwdHMgPSA8R0lD
X1NQSSAxMDcgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4gPiArCQkJY2xvY2tzID0gPCZjbGsgSU1Y
OE1RX0NMS19RU1BJX1JPT1Q+LAo+ICsJCQk8JmNsayBJTVg4TVFfQ0xLX1FTUElfUk9PVD47CgpQ
bGVhc2UgYWxpZ24gdGhlIHNlY29uZCBjbG9jayByZWZlcmVuY2UsIGFzIGlzIGRvbmUgZm9yIGFs
bCBvdGhlcgpwZXJpcGhlcmFsIG5vZGVzIGluIHRoaXMgZmlsZS4KClJlZ2FyZHMsCkx1Y2FzCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
