Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1C1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:57:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5372070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YD2+qJ2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5372070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GxUtTK6ThzgI1Z+gyTOyJ6fJZlNBKGYpZvh5RxUQD2Q=; b=YD2+qJ2fA1W8+T
	eb7Bri9ocgKux95Qd/cnRcT0NPWjpZeKeumLUji2c2ns1JHIa7qtd9HxvHbeGwdRbuCqBkg6oPn6m
	spyNLdv5mdAuntYZ/fuma2jasCM3fC9rJ0FtwwVSiW8H0UC7h+Y5LocI5G3PIXPogvrJYo5YdvvOM
	fEbLyPGNbRY919lcLtzBm2JvguGyEfTBhnFZnlQASuA+J+k574KZvjAC3Sb7XfIUu7jqPqeiRQ5UZ
	TxCJoFchEflOYIQ6Hub1Fpz+iXYftTK016U7R7QZMna9FGqV9LNFTJaezEpixFIExMn3V/zM/EnRJ
	vBMm/eAZdeyFigcyYe9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTsW-0006a9-87; Tue, 12 Feb 2019 08:57:20 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTsS-0006ZX-5E
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:57:17 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gtTsL-0004zi-Vz; Tue, 12 Feb 2019 09:57:09 +0100
Message-ID: <1549961829.2546.19.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: imx6q-pcie: Add "pcie_aux" clock for
 imx8mq
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Date: Tue, 12 Feb 2019 09:57:09 +0100
In-Reply-To: <20190212015108.16952-2-andrew.smirnov@gmail.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
 <20190212015108.16952-2-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_005716_372519_C74D4EDD 
X-CRM114-Status: GOOD (  12.52  )
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
cm5vdjoKPiBBZGQgYSBiaW5kaW5nIGZvciBhbiBleHRyYSBjbG9jayByZXF1aXJlZCBvbiBpLk1Y
OE1RLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTbWlybm92IDxhbmRyZXcuc21pcm5vdkBn
bWFpbC5jb20+Cj4gQ2M6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Cj4gQ2M6
IEZhYmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT4KPiBDYzogQ2hyaXMgSGVhbHkg
PGNwaGVhbHlAZ21haWwuY29tPgo+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25p
eC5kZT4KPiBDYzogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4KPiBD
YzogIkEucy4gRG9uZyIgPGFpc2hlbmcuZG9uZ0BueHAuY29tPgo+IENjOiBSaWNoYXJkIFpodSA8
aG9uZ3hpbmcuemh1QG54cC5jb20+Cj4gQ2M6IGxpbnV4LWlteEBueHAuY29tCj4gQ2M6IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKClJl
dmlld2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KCj4gLS0tCj4g
wqBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4
dCB8IDQgKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1w
Y2llLnR4dCAKPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlt
eDZxLXBjaWUudHh0Cj4gaW5kZXggOTIwY2E5Mzg3MGE4Li45MzNkOTgzMjhlMDcgMTAwNjQ0Cj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNp
ZS50eHQKPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxp
bXg2cS1wY2llLnR4dAo+IEBAIC01NSw2ICs1NSwxMCBAQCBBZGRpdGlvbmFsIHJlcXVpcmVkIHBy
b3BlcnRpZXMgZm9yIGlteDdkLXBjaWUgYW5kCj4gaW14OG1xLXBjaWU6Cj4gwqAJwqDCoMKgwqDC
oMKgwqAtICJhcHBzIgo+IMKgCcKgwqDCoMKgwqDCoMKgLSAidHVybm9mZiIKPiDCoAo+ICtBZGRp
dGlvbmFsIHJlcXVpcmVkIHByb3BlcnRpZXMgZm9yIGlteDhtcS1wY2llOgo+ICstIGNsb2NrLW5h
bWVzOiBNdXN0IGluY2x1ZGUgdGhlIGZvbGxvd2luZyBhZGRpdGlvbmFsIGVudHJpZXM6Cj4gKwkt
ICJwY2llX2F1eCIKPiArCj4gwqBFeGFtcGxlOgo+IMKgCj4gwqAJcGNpZUAwMTAwMDAwMCB7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
