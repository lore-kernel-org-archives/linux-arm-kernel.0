Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E4CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:45:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE22B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eFn55e3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE22B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wd1Llsccmyz4CTxhba89LxzrhDxJSSFpRkBexMV1ykE=; b=eFn55e3GLCXSc8
	kSOwcfSV//eXQujZDkx/E0LqIfIGOXeiS+9argQhKJDgd6t4VYDj8unbZp0u9gsewMh/Dxu7LZygr
	cZZdVkw3VHttlbQXDC62zZAcgwHlzgPYGHJswlU9UfQ5EfenszCdXNviu5DPjdNBlhfHKuRR3U/zL
	ft8t91kQ+6snj30SLyZxubNL4+SA3zXCW5K9vd1hs0YFwFhjDLbA6Umbh9y4NHKmMDKahQspc6q0u
	xQM5SoRjtcAXR2Ee5WiO80f4IiopVmjPZIIwft8/3lw3hj4VHrKL6IUiHhlJPN+bJ8ANCnl9zueLE
	U5dgNPbNRLzfsevhVrDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5Mr-0001ha-OQ; Mon, 14 Jan 2019 16:45:41 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5Mn-0001h9-PC
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:45:39 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gj5Mh-0000Hk-Ut; Mon, 14 Jan 2019 17:45:31 +0100
Message-ID: <1547484331.2718.8.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add pwm
From: Lucas Stach <l.stach@pengutronix.de>
To: Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
Date: Mon, 14 Jan 2019 17:45:31 +0100
In-Reply-To: <20190114163034.GA24531@bogon.m.sigxcpu.org>
References: <20190114163034.GA24531@bogon.m.sigxcpu.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_084537_969871_4414B17E 
X-CRM114-Status: GOOD (  14.36  )
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

SGkgR3VpZG8sCgpBbSBNb250YWcsIGRlbiAxNC4wMS4yMDE5LCAxNzozMCArMDEwMCBzY2hyaWVi
IEd1aWRvIEfDvG50aGVyOgo+IFdlIGNhbiByZXVzZSB0aGUgcHdtIGZyb20gZnNsLGlteDI3LXB3
bSBhcyB3aXRoIG90aGVyIGlteCBTT0NzLgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogR3VpZG8gR8O8
bnRoZXIgPGFneEBzaWd4Y3B1Lm9yZz4KPiAtLS0KPiBUaGlzIGlzIGFnYWluc3QgbGludXgtbmV4
dCAobmV4dC0yMDE5MDExNCkKPiAKPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcS5kdHNpIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA0NCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1xLmR0c2kKPiBpbmRleCA4ZTlkNmQ1ZWQ3YjIuLjUzZWQwYmRmYzA2YSAxMDA2NDQKPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gQEAgLTI1Miw2ICsyNTIsNTAg
QEAKPiA+IMKgCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfV0RPRzNfUk9PVD47Cj4gPiDC
oAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gwqAJCQl9Owo+ICsKPiA+ID4gKwkJCXB3bTE6
IHB3bUAzMDY2MDAwMCB7Cj4gPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1wd20iLCAi
ZnNsLGlteDI3LXB3bSI7Cj4gPiArCQkJCXJlZyA9IDwweDMwNjYwMDAwIDB4MTAwMDA+Owo+ID4g
KwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODEgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4gPiAr
CQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfUFdNMV9ST09UPiwKPiArCQkJCTwmY2xrIElN
WDhNUV9DTEtfUFdNMV9ST09UPjsKClBsZWFzZSBhbGlnbiB0aGUgc2Vjb25kIGVudHJ5IHdpdGgg
dGhlIGZpcnN0IG9uZSxhcyB3aXRoIGFsbCB0aGUgb3RoZXIKbm9kZXMgaW4gdGhpcyBmaWxlLgoK
PiArCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOwo+ID4gKwkJCQkjcHdtLWNlbGxzID0g
PDI+Owo+ID4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gKwkJCX07Cj4gKwo+ID4gPiAr
CQkJcHdtMjogcHdtQDMwNjcwMDAwIHsKPiA+ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1x
LXB3bSIsICJmc2wsaW14MjctcHdtIjsKPiA+ICsJCQkJcmVnID0gPDB4MzA2NzAwMDAgMHgxMDAw
MD47Cj4gPiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4MiBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsKPiA+ICsJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19QV00yX1JPT1Q+LAo+ID4gKwkJ
CQk8JmNsayBJTVg4TVFfQ0xLX1BXTTJfUk9PVD47Cj4gPiArCQkJCWNsb2NrLW5hbWVzID0gImlw
ZyIsICJwZXIiOwo+ID4gKwkJCQkjcHdtLWNlbGxzID0gPDI+Owo+ID4gKwkJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOwo+ID4gKwkJCX07Cj4gKwo+ID4gPiArCQkJcHdtMzogcHdtQDMwNjgwMDAwIHsK
PiA+ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLXB3bSIsICJmc2wsaW14MjctcHdtIjsK
PiA+ICsJCQkJcmVnID0gPDB4MzA2ODAwMDAgMHgxMDAwMD47Cj4gPiArCQkJCWludGVycnVwdHMg
PSA8R0lDX1NQSSA4MyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPiA+ICsJCQkJY2xvY2tzID0gPCZj
bGsgSU1YOE1RX0NMS19QV00zX1JPT1Q+LAo+ID4gKwkJCQk8JmNsayBJTVg4TVFfQ0xLX1BXTTNf
Uk9PVD47Cj4gPiArCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOwo+ID4gKwkJCQkjcHdt
LWNlbGxzID0gPDI+Owo+ID4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gKwkJCX07Cj4g
Kwo+ID4gPiArCQkJcHdtNDogcHdtQDMwNjkwMDAwIHsKPiA+ICsJCQkJY29tcGF0aWJsZSA9ICJm
c2wsaW14OG1xLXB3bSIsICJmc2wsaW14MjctcHdtIjsKPiA+ICsJCQkJcmVnID0gPDB4MzA2OTAw
MDAgMHgxMDAwMD47Cj4gPiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4NCBJUlFfVFlQRV9M
RVZFTF9ISUdIPjsKPiA+ICsJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19QV000X1JPT1Q+
LAo+ID4gKwkJCQk8JmNsayBJTVg4TVFfQ0xLX1BXTTRfUk9PVD47Cj4gPiArCQkJCWNsb2NrLW5h
bWVzID0gImlwZyIsICJwZXIiOwo+ID4gKwkJCQkjcHdtLWNlbGxzID0gPDI+Owo+ID4gKwkJCQlz
dGF0dXMgPSAiZGlzYWJsZWQiOwo+ICsJCQl9OwoKQWxsIHRob3NlIGFkZHJlc3NlcyBhcmUgd2l0
aGluIHRoZSBBSVBTMiBidXMgcmFuZ2UsIHNvIHRoaXMgcGF0Y2ggYWRkcwp0aGVtIHRvIHRoZSB3
cm9uZyBidXMuCgpSZWdhcmRzLApMdWNhcwoKPiDCoAkJfTsKPiDCoAo+ID4gwqAJCWJ1c0AzMDQw
MDAwMCB7IC8qIEFJUFMyICovCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
