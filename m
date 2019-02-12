Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C78C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:36:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA622186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tLsfyCRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA622186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C5Y4pkDcX/sQ9hRnRONFoE66FJoNUCIkVqKGlY/zzqQ=; b=tLsfyCRSfooyn8
	QMyJYOPSjJ2lqo0lSkaB0YYslHADUSeDVF2FF/L8MCZj/Kt5M332nR6c4AVjRPrJriQ41JaY2VipB
	M5h6Q5Wu9h/DBFOyfAgXYktWy72pSEmtvs+/p3UaS67W30w0Qs45Y63PX6o7S7B/UmObJJ7NNmmSk
	QcBm99Mtkuifna89nYL5reOPWt2rxIGHbpIEx64cbGCTeAOPmcNwSTda0KT6hn5bbc3gsd+17SUzg
	Yle54EIgjL/zBZREJN7CpPuTSw9/f0clbFZwq68AIiNI7AQ0qnKBi7BZ8PGJcFd6ANMCQnmIqpXI0
	WBxl1pAo81xRGF6eCURQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtUUC-0007aK-TK; Tue, 12 Feb 2019 09:36:16 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtUU9-0007ZY-N5
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:36:15 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gtUU3-0001IR-Ng; Tue, 12 Feb 2019 10:36:07 +0100
Message-ID: <1549964166.2546.21.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx6: Add code to request/control "pcie_aux"
 clock for i.MX8MQ
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Date: Tue, 12 Feb 2019 10:36:06 +0100
In-Reply-To: <20190212015108.16952-3-andrew.smirnov@gmail.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
 <20190212015108.16952-3-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_013613_922367_0342E274 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTW9udGFnLCBkZW4gMTEuMDIuMjAxOSwgMTc6NTEgLTA4MDAgc2NocmllYiBBbmRyZXkgU21p
cm5vdjoKPiBQQ0llIElQIGJsb2NrIGhhcyBhZGRpdGlvbmFsIGNsb2NrLCAicGNpZV9hdXgiLCB0
aGF0IG5lZWRzIHRvIGJlCj4gY29udHJvbGxlZCBieSB0aGUgZHJpdmVyLiBBZGQgY29kZSB0byBz
dXBwb3J0IHRoYXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNtaXJub3YgPGFuZHJldy5z
bWlybm92QGdtYWlsLmNvbT4KPiBDYzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNv
bT4KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPgo+IENjOiBDaHJp
cyBIZWFseSA8Y3BoZWFseUBnbWFpbC5jb20+Cj4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBl
bmd1dHJvbml4LmRlPgo+IENjOiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAu
Y29tPgo+IENjOiAiQS5zLiBEb25nIiA8YWlzaGVuZy5kb25nQG54cC5jb20+Cj4gQ2M6IFJpY2hh
cmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4KPiBDYzogbGludXgtaW14QG54cC5jb20KPiBD
YzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZwo+IENjOiBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZwoKUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgoK
PiAtLS0KPiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAxNiArKysr
KysrKysrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYwo+IGluZGV4IDdjZGY4ZjlhYjI0NC4uMWE3
MDMxNzgyODQ2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1p
bXg2LmMKPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jCj4gQEAg
LTY1LDYgKzY1LDcgQEAgc3RydWN0IGlteDZfcGNpZSB7Cj4gwqAJc3RydWN0IGNsawkJKnBjaWVf
cGh5Owo+IMKgCXN0cnVjdCBjbGsJCSpwY2llX2luYm91bmRfYXhpOwo+IMKgCXN0cnVjdCBjbGsJ
CSpwY2llOwo+ICsJc3RydWN0IGNsawkJKnBjaWVfYXV4Owo+IMKgCXN0cnVjdCByZWdtYXAJCSpp
b211eGNfZ3ByOwo+IMKgCXUzMgkJCWNvbnRyb2xsZXJfaWQ7Cj4gwqAJc3RydWN0IHJlc2V0X2Nv
bnRyb2wJKnBjaWVwaHlfcmVzZXQ7Cj4gQEAgLTQyMSw2ICs0MjIsMTIgQEAgc3RhdGljIGludCBp
bXg2X3BjaWVfZW5hYmxlX3JlZl9jbGsoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKQo+IMKg
CWNhc2UgSU1YN0Q6Cj4gwqAJCWJyZWFrOwo+IMKgCWNhc2UgSU1YOE1ROgo+ICsJCXJldCA9IGNs
a19wcmVwYXJlX2VuYWJsZShpbXg2X3BjaWUtPnBjaWVfYXV4KTsKPiArCQlpZiAocmV0KSB7Cj4g
KwkJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGVuYWJsZSBwY2llX2F1eCBjbG9ja1xuIik7Cj4g
KwkJCWJyZWFrOwo+ICsJCX0KPiArCj4gwqAJCW9mZnNldCA9IGlteDZfcGNpZV9ncnBfb2Zmc2V0
KGlteDZfcGNpZSk7Cj4gwqAJCS8qCj4gwqAJCcKgKiBTZXQgdGhlIG92ZXIgcmlkZSBsb3cgYW5k
IGVuYWJsZWQKPiBAQCAtOTA0LDYgKzkxMSw5IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9jbGtf
ZGlzYWJsZShzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpCj4gwqAJCQkJwqDCoMKgSU1YN0Rf
R1BSMTJfUENJRV9QSFlfUkVGQ0xLX1NFTCwKPiDCoAkJCQnCoMKgwqBJTVg3RF9HUFIxMl9QQ0lF
X1BIWV9SRUZDTEtfU0VMKTsKPiDCoAkJYnJlYWs7Cj4gKwljYXNlIElNWDhNUToKPiArCQljbGtf
ZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llX2F1eCk7Cj4gKwkJYnJlYWs7Cj4gwqAJ
ZGVmYXVsdDoKPiDCoAkJYnJlYWs7Cj4gwqAJfQo+IEBAIC0xMDQ5LDYgKzEwNTksMTIgQEAgc3Rh
dGljIGludCBpbXg2X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiDC
oAkJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBQQ0lFIEFQUFMgcmVzZXQgY29udHJvbFxu
Iik7Cj4gwqAJCQlyZXR1cm4gUFRSX0VSUihpbXg2X3BjaWUtPmFwcHNfcmVzZXQpOwo+IMKgCQl9
Cj4gKwo+ICsJCWlteDZfcGNpZS0+cGNpZV9hdXggPSBkZXZtX2Nsa19nZXQoZGV2LCAicGNpZV9h
dXgiKTsKPiArCQlpZiAoSVNfRVJSKGlteDZfcGNpZS0+cGNpZV9hdXgpKSB7Cj4gKwkJCWRldl9l
cnIoZGV2LCAicGNpZV9hdXggY2xvY2sgc291cmNlIG1pc3Npbmcgb3IgaW52YWxpZFxuIik7Cj4g
KwkJCXJldHVybiBQVFJfRVJSKGlteDZfcGNpZS0+cGNpZV9hdXgpOwo+ICsJCX0KPiDCoAkJYnJl
YWs7Cj4gwqAJZGVmYXVsdDoKPiDCoAkJYnJlYWs7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
