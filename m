Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF082C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:30:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743BC2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EYtPXywe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743BC2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0H3YKstoTkdoez/fBqj34bn6zCWfWkP41XgblrPU+js=; b=EYtPXywe96j71n
	viJqIfg0PYt2/kRDZ6dxKKLvo5jjA0PX/1KndUBuVhhHnM6Z26RFTCNFfOEjqxccEeQAoYnDy2xqR
	aZKvrU/CjERut/AXhkI3QoLAPr4+hU9x3jO0715aJai8VHHgDGx18ezoCvBOHBXQS/uNENok6H/Iw
	OernO84J4u6/gj/xAltFcjpItb4omSv11aMoDj4nvH9tB52d8ekv36VV8XyQt3MesHTjKEaPVxa5l
	LSD5W7SqIvV+P5jkwVXm+Z3DGYJblaPEsncVK87M++GVveTIK1r1Twa6u2L3GCGTgxZEfqFFQFr9t
	Pq4FJ5Obdju68JAfXepA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjK6u-0001Ax-4K; Tue, 15 Jan 2019 08:30:12 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjK6p-0000Tq-HK
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 08:30:10 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gjK6j-0004ih-34; Tue, 15 Jan 2019 09:30:01 +0100
Message-ID: <1547540998.4339.0.camel@pengutronix.de>
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Add pwm
From: Lucas Stach <l.stach@pengutronix.de>
To: Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
Date: Tue, 15 Jan 2019 09:29:58 +0100
In-Reply-To: <20190114170316.GB4168@bogon.m.sigxcpu.org>
References: <20190114170316.GB4168@bogon.m.sigxcpu.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_003007_763921_F2557974 
X-CRM114-Status: GOOD (  14.05  )
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

QW0gTW9udGFnLCBkZW4gMTQuMDEuMjAxOSwgMTg6MDMgKzAxMDAgc2NocmllYiBHdWlkbyBHw7xu
dGhlcjoKPiBXZSBjYW4gcmV1c2UgdGhlIHB3bSBmcm9tIGZzbCxpbXgyNy1wd20gYXMgd2l0aCBv
dGhlciBpbXggU09Dcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBHdWlkbyBHw7xudGhlciA8YWd4QHNp
Z3hjcHUub3JnPgoKUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4
LmRlPgoKPiAtLS0KPiBDaGFuZ2VzIGZyb20gdjEgKHRoYW5rcyBMdWNhcyBTdGFjaCBmb3IgdGhl
IHJldmlldyk6Cj4gwqAgLSBmaXggaW5kZW50YXRpb24gb2YgbXVsdGluZSBlbnRyaWVzCj4gwqAg
LSBtb3ZlIHRvIEFJUFMyIGJ1cwo+IAo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1xLmR0c2kgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDQ0IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bXEuZHRzaQo+IGluZGV4IDhlOWQ2ZDVlZDdiMi4uMGI0MmZjYjFlY2FhIDEwMDY0NAo+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiBAQCAtMjU5LDYgKzI1OSw1
MCBAQAo+ID4gwqAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+IMKgCQkJI3NpemUtY2VsbHMg
PSA8MT47Cj4gPiDCoAkJCXJhbmdlcyA9IDwweDMwNDAwMDAwIDB4MzA0MDAwMDAgMHg0MDAwMDA+
Owo+ICsKPiA+ID4gKwkJCXB3bTE6IHB3bUAzMDY2MDAwMCB7Cj4gPiArCQkJCWNvbXBhdGlibGUg
PSAiZnNsLGlteDhtcS1wd20iLCAiZnNsLGlteDI3LXB3bSI7Cj4gPiArCQkJCXJlZyA9IDwweDMw
NjYwMDAwIDB4MTAwMDA+Owo+ID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODEgSVJRX1RZ
UEVfTEVWRUxfSElHSD47Cj4gPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfUFdNMV9S
T09UPiwKPiA+ICsJCQkJwqDCoMKgwqDCoMKgwqDCoMKgPCZjbGsgSU1YOE1RX0NMS19QV00xX1JP
T1Q+Owo+ID4gKwkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsKPiA+ICsJCQkJI3B3bS1j
ZWxscyA9IDwyPjsKPiA+ICsJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+ICsJCQl9Owo+ICsK
PiA+ID4gKwkJCXB3bTI6IHB3bUAzMDY3MDAwMCB7Cj4gPiArCQkJCWNvbXBhdGlibGUgPSAiZnNs
LGlteDhtcS1wd20iLCAiZnNsLGlteDI3LXB3bSI7Cj4gPiArCQkJCXJlZyA9IDwweDMwNjcwMDAw
IDB4MTAwMDA+Owo+ID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODIgSVJRX1RZUEVfTEVW
RUxfSElHSD47Cj4gPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfUFdNMl9ST09UPiwK
PiA+ICsJCQkJwqDCoMKgwqDCoMKgwqDCoMKgPCZjbGsgSU1YOE1RX0NMS19QV00yX1JPT1Q+Owo+
ID4gKwkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsKPiA+ICsJCQkJI3B3bS1jZWxscyA9
IDwyPjsKPiA+ICsJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+ICsJCQl9Owo+ICsKPiA+ID4g
KwkJCXB3bTM6IHB3bUAzMDY4MDAwMCB7Cj4gPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDht
cS1wd20iLCAiZnNsLGlteDI3LXB3bSI7Cj4gPiArCQkJCXJlZyA9IDwweDMwNjgwMDAwIDB4MTAw
MDA+Owo+ID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODMgSVJRX1RZUEVfTEVWRUxfSElH
SD47Cj4gPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfUFdNM19ST09UPiwKPiA+ICsJ
CQkJwqDCoMKgwqDCoMKgwqDCoMKgPCZjbGsgSU1YOE1RX0NMS19QV00zX1JPT1Q+Owo+ID4gKwkJ
CQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsKPiA+ICsJCQkJI3B3bS1jZWxscyA9IDwyPjsK
PiA+ICsJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+ICsJCQl9Owo+ICsKPiA+ID4gKwkJCXB3
bTQ6IHB3bUAzMDY5MDAwMCB7Cj4gPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1wd20i
LCAiZnNsLGlteDI3LXB3bSI7Cj4gPiArCQkJCXJlZyA9IDwweDMwNjkwMDAwIDB4MTAwMDA+Owo+
ID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODQgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4g
PiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfUFdNNF9ST09UPiwKPiA+ICsJCQkJwqDC
oMKgwqDCoMKgwqDCoMKgPCZjbGsgSU1YOE1RX0NMS19QV000X1JPT1Q+Owo+ID4gKwkJCQljbG9j
ay1uYW1lcyA9ICJpcGciLCAicGVyIjsKPiA+ICsJCQkJI3B3bS1jZWxscyA9IDwyPjsKPiA+ICsJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+ICsJCQl9Owo+ID4gwqAJCX07Cj4gwqAKPiA+IMKg
CQlidXNAMzA4MDAwMDAgeyAvKiBBSVBTMyAqLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
