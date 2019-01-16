Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD68C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:22:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80C520866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Un4VgTCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80C520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=31JFJt9qMV6ODPnUpv5EbVaP4q4qjANBYUp1kGnaEQ0=; b=Un4VgTCHsvRK63
	tOwHKRVU9B8bNuQYXLMbllc38ZnCRBXnQcoYP2hpHy3Eg0fRUMoVdINVUQhiIpq1bUbMevSCct+Qk
	nB+jnwW3vBYb5D5zrQtg5cKh6NDIREjPPZh6amUueZEkIOJ5hR7t3mE2phfmM9dyE7L0AfAWaYDdp
	E1SDCF7IO4wVzPRbtFYoXCXGWLguCs6B+N+unpmEk243FFGQLUctIJ2IdUTLc3HF2RiiS4glNWTRN
	h8VuuQ1aJeOcoinJqlO1HM1qGoxgK4hvRveXmfFOYtKnu9zZNdzepep0tRgccQUGLT3Vd1ck2Mqvx
	+Lp7Xv1u2BKGi8FUZdeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjhP3-0006gy-Gl; Wed, 16 Jan 2019 09:22:29 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjhP0-0006gC-Ax
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 09:22:27 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gjhOt-0006hh-I7; Wed, 16 Jan 2019 10:22:19 +0100
Message-ID: <1547630539.4339.22.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] arm64: dts: fsl: imx8mq: add USB nodes
From: Lucas Stach <l.stach@pengutronix.de>
To: Jun Li <jun.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Date: Wed, 16 Jan 2019 10:22:19 +0100
In-Reply-To: <VI1PR04MB455880021886BD03D29126DA89820@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <20190115110325.13236-1-l.stach@pengutronix.de>
 <VI1PR04MB455880021886BD03D29126DA89820@VI1PR04MB4558.eurprd04.prod.outlook.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_012226_529527_5EB6073C 
X-CRM114-Status: GOOD (  14.07  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSnVuLAoKQW0gTWl0dHdvY2gsIGRlbiAxNi4wMS4yMDE5LCAwNDozMCArMDAwMCBzY2hyaWVi
IEp1biBMaToKPiBIaSBMdWNhcywKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiA+
ID4gRnJvbTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cj4gPiBTZW50OiAy
MDE55bm0MeaciDE15pelIDE5OjAzCj4gPiA+ID4gVG86IFNoYXduIEd1byA8c2hhd25ndW9Aa2Vy
bmVsLm9yZz4KPiA+ID4gPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29t
PjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47Cj4gPiA+ID4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7Cj4gPiBwYXRj
aHdvcmstbHN0QHBlbmd1dHJvbml4LmRlCj4gPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBhcm02NDog
ZHRzOiBmc2w6IGlteDhtcTogYWRkIFVTQiBub2Rlcwo+ID4gCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cj4gPiAtLS0KPiA+IMKgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgfCA2NiArKysrKysrKysrKysr
KysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQo+ID4gCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kK
PiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiA+IGluZGV4
IDViZDFmMTA2ZWQ4NC4uZDI1YWI1MGQ2Yjg4IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gPiBAQCAtNDcwLDYgKzQ3MCw3MiBAQAo+ID4gPiA+
IMKgCQkJfTsKPiA+ID4gPiDCoAkJfTsKPiA+IAo+ID4gPiA+ID4gPiArCQl1c2JfZHdjM18wOiB1
c2JAMzgxMDAwMDAgewo+ID4gPiA+ICsJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtZHdjMyIs
ICJzbnBzLGR3YzMiOwo+ID4gPiA+ICsJCQlyZWcgPSA8MHgzODEwMDAwMCAweDEwMDAwPjsKPiA+
ID4gPiArCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19VU0JfQlVTPiwKPiA+ID4gPiArCQkJ
wqDCoMKgwqDCoMKgwqDCoMKgPCZjbGsgSU1YOE1RX0NMS19VU0JfQ09SRV9SRUY+LAo+ID4gPiA+
ICsJCQnCoMKgwqDCoMKgwqDCoMKgwqA8JmNsayBJTVg4TVFfQ0xLX1VTQjFfQ1RSTF9ST09UPjsK
PiA+ID4gPiArCQkJY2xvY2stbmFtZXMgPSAiYnVzX2Vhcmx5IiwgInJlZiIsICJzdXNwZW5kIjsK
PiA+ID4gPiArCQkJYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19VU0JfQlVTPiwK
PiA+ID4gPiArCQkJwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPCZjbGsgSU1Y
OE1RX0NMS19VU0JfQ09SRV9SRUY+Owo+ID4gPiA+ICsJCQlhc3NpZ25lZC1jbG9jay1wYXJlbnRz
ID0gPCZjbGsgSU1YOE1RX1NZUzJfUExMXzUwME0+LAo+ID4gPiA+ICsJCQnCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDwmY2xrIElNWDhNUV9TWVMxX1BM
TF8xMDBNPjsKPiA+ID4gPiArCQkJYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8NTAwMDAwMDAwPiwg
PDEwMDAwMDAwMD47Cj4gPiA+ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA0MCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsKPiA+ID4gPiArCQkJcGh5cyA9IDwmdXNiM19waHkwPiwgPCZ1c2IzX3Bo
eTA+Owo+ID4gPiA+ICsJCQlwaHktbmFtZXMgPSAidXNiMi1waHkiLCAidXNiMy1waHkiOwo+ID4g
PiA+ICsJCQlwb3dlci1kb21haW5zID0gPCZwZ2Nfb3RnMT47Cj4gPiArCQkJc25wcyxwb3dlci1k
b3duLXNjYWxlID0gPDI+Owo+IAo+IFRoaXMgcHJvcGVydHkgZG9lcyBub3QgZXhpc3Qgb24gdXBz
dHJlYW0sIG5lZWQgZmlyc3RseSBpbnRyb2R1Y2UgaXQgZm9yIGR3YzMgZHJpdmVyCj4gYmVmb3Jl
IGFkZCBpdCBpbiBkdHMsIEkgY2FuIGRvIHRoYXQgaWYgeW91IGFyZSBub3QgZ29pbmcgdG8gdGFr
ZSBjYXJlIG9mIGl0LgoKSSdtIGdvaW5nIHRvIHJlbW92ZSB0aGlzIGZyb20gdGhpcyBwYXRjaCBp
biB0aGUgbmV4dCByZXZpc2lvbi4gSSdtIG5vdApzdXJlIHdoZW4gSSdtIGdvaW5nIHRvIGdldCBh
cm91bmQgdG8gbG9vayBtb3JlIGF0IFVTQiwgc28gcGxlYXNlIENDIG1lCmlmL3doZW4geW91IGFy
ZSBpbnRyb2R1Y2luZyB0aGlzIHRvIHRoZSBEV0MzIGRyaXZlci4KClJlZ2FyZHMsCkx1Y2FzCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
