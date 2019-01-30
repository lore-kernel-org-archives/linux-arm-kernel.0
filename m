Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A199C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:30:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB41F20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aa3Ilo4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB41F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YG3l/UbuIYqIJT35+d1Awf0R8riMdRxJY78Rm3yUX3Q=; b=aa3Ilo4paRWraf
	O9tDl+//jEi7II/0t82HoNpePKshEHWoPDVUPlvFpOg8tRQbQLWOdT2t4D14Fzn27oapqzAl2wHP2
	+NOj7ZF+cP4NkE90vi3LdemcyKpWtH5hLxeArvX04CNwrUA6Q5kPNg97rR9QGLeouIEORIGkug+mz
	3CDQHpIFTpdkSLR57s57qB0GY99frY2B/3bqua1795CGdZjGIjf9v7IuI1xfvwlXfcBVy65Zuw1+2
	SZtNN54giTX7XFSHNwKMiPVBSzjXQElvenQO9kXy/kK4D5CMK1MYTBZFtsWNdFx3F+IJ1/CVSVCI5
	Se9MqVEQ+D9kZvgHGsfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomCt-0006pP-CS; Wed, 30 Jan 2019 09:30:55 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomCq-0006oy-DT
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:30:53 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gomCl-0002eM-1J; Wed, 30 Jan 2019 10:30:47 +0100
Message-ID: <1548840646.6869.15.camel@pengutronix.de>
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Add QuadSPI controller
From: Lucas Stach <l.stach@pengutronix.de>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 30 Jan 2019 10:30:46 +0100
In-Reply-To: <20190130091953.20131-1-ccaione@baylibre.com>
References: <20190130091953.20131-1-ccaione@baylibre.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_013052_614980_1BAACF78 
X-CRM114-Status: GOOD (  14.66  )
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

QW0gTWl0dHdvY2gsIGRlbiAzMC4wMS4yMDE5LCAwOToxOSArMDAwMCBzY2hyaWViIENhcmxvIENh
aW9uZToKPiBBZGQgYSBub2RlIGZvciB0aGUgRnJlZXNjYWxlL05YUCBRdWFkU1BJIGNvbnRyb2xs
ZXIgd2l0aCBhIHByb3Blcgo+IHBpbmN0cmwgc2V0IGFuZCBlbmFibGUgaXQgZm9yIHRoZSBpLk1Y
OE1RIEVWSyBib2FyZC4KPiBFeHRlbmQgYWxzbyB0aGUgQUlQUzMgbWVtb3J5IHJhbmdlIHRvIGFj
Y29tbW9kYXRlIHRoZSBRdWFkU1BJLW1lbW9yeQo+IHJlZ2lvbi4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBDYXJsbyBDYWlvbmUgPGNjYWlvbmVAYmF5bGlicmUuY29tPgoKSSB3b3VsZCBwcmVmZXIgdGhp
cyB0byBiZSBzcGxpdCBpbnRvIDIgcGF0Y2hlcyBiZXR3ZWVuIHRoZSBiYXNlIERUIGFuZAp0aGUg
RVZLIGJvYXJkIHN1cHBvcnQuIEJ1dCBJIGRvbid0IHRoaW5rIGl0IHdhcnJhbnRzIGEgcmVzcGlu
IGp1c3QgZm9yCnRoaXMsIHNvOgoKUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBl
bmd1dHJvbml4LmRlPgoKPiAtLS0KPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcS1ldmsuZHRzIHwgMjcgKysrKysrKysrKysrKysrKysrKysKPiDCoGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpwqDCoMKgwqB8IDE2ICsrKysrKysrKysrLQo+IMKg
MiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWV2ay5kdHMKPiBpbmRleCBmNzRi
MTNhYTVhYTUuLmFlMTgxYzJhNTAwMyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cwo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcS1ldmsuZHRzCj4gQEAgLTEzNyw2ICsxMzcsMjEgQEAKPiA+IMKgCXN0YXR1
cyA9ICJva2F5IjsKPiDCoH07Cj4gwqAKPiArJnNwaTAgewo+ID4gKwlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOwo+ID4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcXNwaT47Cj4gPiArCXN0YXR1
cyA9ICJva2F5IjsKPiArCj4gPiA+ICsJZmxhc2gwOiBuMjVxMjU2YUAwIHsKPiA+ICsJCXJlZyA9
IDwwPjsKPiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Owo+ID4gKwkJI3NpemUtY2VsbHMgPSA8
MT47Cj4gPiArCQljb21wYXRpYmxlID0gIm1pY3JvbixuMjVxMjU2YSIsICJqZWRlYyxzcGktbm9y
IjsKPiA+ICsJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDI5MDAwMDAwPjsKPiA+ICsJCXNwaS1ub3Is
ZGRyLXF1YWQtcmVhZC1kdW1teSA9IDw2PjsKPiA+ICsJfTsKPiArfTsKPiArCj4gwqAmdXNkaGMx
IHsKPiA+IMKgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzdGF0ZV8xMDBtaHoiLCAic3Rh
dGVfMjAwbWh6IjsKPiA+IMKgCXBpbmN0cmwtMCA9IDwmcGluY3RybF91c2RoYzE+Owo+IEBAIC0x
OTUsNiArMjEwLDE4IEBACj4gPiDCoAkJPjsKPiA+IMKgCX07Cj4gwqAKPiA+ICsJcGluY3RybF9x
c3BpOiBxc3BpZ3JwIHsKPiA+ICsJCWZzbCxwaW5zID0gPAo+ID4gPiArCQkJTVg4TVFfSU9NVVhD
X05BTkRfQUxFX1FTUElfQV9TQ0xLCTB4ODIKPiA+ID4gKwkJCU1YOE1RX0lPTVVYQ19OQU5EX0NF
MF9CX1FTUElfQV9TUzBfQgkweDgyCj4gPiA+ICsJCQlNWDhNUV9JT01VWENfTkFORF9EQVRBMDBf
UVNQSV9BX0RBVEEwCTB4ODIKPiA+ID4gKwkJCU1YOE1RX0lPTVVYQ19OQU5EX0RBVEEwMV9RU1BJ
X0FfREFUQTEJMHg4Mgo+ID4gPiArCQkJTVg4TVFfSU9NVVhDX05BTkRfREFUQTAyX1FTUElfQV9E
QVRBMgkweDgyCj4gPiA+ICsJCQlNWDhNUV9JT01VWENfTkFORF9EQVRBMDNfUVNQSV9BX0RBVEEz
CTB4ODIKPiArCj4gPiArCQk+Owo+ID4gKwl9Owo+ICsKPiA+IMKgCXBpbmN0cmxfcmVnX3VzZGhj
MjogcmVndXNkaGMyZ3JwZ3BpbyB7Cj4gPiDCoAkJZnNsLHBpbnMgPSA8Cj4gPiA+IMKgCQkJTVg4
TVFfSU9NVVhDX1NEMl9SRVNFVF9CX0dQSU8yX0lPMTkJCTB4NDEKPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+IGluZGV4IGRiZWRjNGE1ZTdmYi4uYzIwZjQzZjYz
YzRlIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5k
dHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiBA
QCAtMzc5LDcgKzM3OSw4IEBACj4gPiDCoAkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1haXBz
LWJ1cyIsICJzaW1wbGUtYnVzIjsKPiA+IMKgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4gPiDC
oAkJCSNzaXplLWNlbGxzID0gPDE+Owo+ID4gLQkJCXJhbmdlcyA9IDwweDMwODAwMDAwIDB4MzA4
MDAwMDAgMHg0MDAwMDA+Owo+ID4gKwkJCXJhbmdlcyA9IDwweDMwODAwMDAwIDB4MzA4MDAwMDAg
MHg0MDAwMDA+LAo+ID4gKwkJCQnCoDwweDA4MDAwMDAwIDB4MDgwMDAwMDAgMHgxMDAwMDAwMD47
Cj4gwqAKPiA+ID4gwqAJCQl1YXJ0MTogc2VyaWFsQDMwODYwMDAwIHsKPiA+IMKgCQkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDhtcS11YXJ0IiwKPiBAQCAtNDk3LDYgKzQ5OCwxOSBAQAo+ID4gwqAJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+IMKgCQkJfTsKPiDCoAo+ID4gPiArCQkJc3BpMDog
c3BpQDMwYmIwMDAwIHsKPiA+ICsJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4gPiArCQkJCSNz
aXplLWNlbGxzID0gPDA+Owo+ID4gKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtcXNwaSIs
ICJmc2wsaW14N2QtcXNwaSI7Cj4gPiArCQkJCXJlZyA9IDwweDMwYmIwMDAwIDB4MTAwMDA+LCA8
MHgwODAwMDAwMCAweDEwMDAwMDAwPjsKPiA+ICsJCQkJcmVnLW5hbWVzID0gIlF1YWRTUEkiLCAi
UXVhZFNQSS1tZW1vcnkiOwo+ID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTA3IElSUV9U
WVBFX0xFVkVMX0hJR0g+Owo+ID4gKwkJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX1FTUElf
Uk9PVD4sCj4gPiArCQkJCQnCoDwmY2xrIElNWDhNUV9DTEtfUVNQSV9ST09UPjsKPiA+ICsJCQkJ
Y2xvY2stbmFtZXMgPSAicXNwaV9lbiIsICJxc3BpIjsKPiA+ICsJCQkJc3RhdHVzID0gImRpc2Fi
bGVkIjsKPiA+ICsJCQl9Owo+ICsKPiA+ID4gwqAJCQlmZWMxOiBldGhlcm5ldEAzMGJlMDAwMCB7
Cj4gPiDCoAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtZmVjIiwgImZzbCxpbXg2c3gtZmVj
IjsKPiA+IMKgCQkJCXJlZyA9IDwweDMwYmUwMDAwIDB4MTAwMDA+OwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
