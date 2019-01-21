Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B3BC31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:31:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FC82084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L5eQoycg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FC82084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y4vpIwYVQYbU6SFy38yi3WlhD1nig0AdhCnaOyQUbC0=; b=L5eQoycgP6UtEA
	IJU0hIfOGAYDMZFZSoXr/bb+EH/0TGTUpdCZPlg3oxDiTny8P60wwH3mHEPHQGHrE87hY+XDbh66r
	AhtVAyMLshzCgpFeIQXC2NuDlrCd8yd5KIGhKs6hLmokoc5hBaGt3N0d3axt3H7w2lK7HqC9KaWRZ
	hMgiibq1i1N3OzoIaCnCIUKOd/HwuMGux+f3eE3VnufoNdvkFDCKh4f5IxWo1aJxdFiRncIFbRg9m
	bpXvDwAZmnD4iPSZzP0g6bQWLB7uQBxwoPNg+03D+6IwhGt6lo3E2zEk0nmM/MireOK+xi8oabVJl
	MORb15QzC7rsQtcycxIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldQH-0001eC-GZ; Mon, 21 Jan 2019 17:31:45 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldQD-0001do-Rr
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:31:43 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gldQA-0003IJ-3F; Mon, 21 Jan 2019 18:31:38 +0100
Message-ID: <1548091897.2465.10.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>
Date: Mon, 21 Jan 2019 18:31:37 +0100
In-Reply-To: <CAOMZO5BFZVUT8x8o57TkYfwfT9OF1a=g5pNo48bW1qwfYXUrRg@mail.gmail.com>
References: <20190115110446.19077-1-l.stach@pengutronix.de>
 <VI1PR0402MB3357FAB48888D99A809F41AEF99F0@VI1PR0402MB3357.eurprd04.prod.outlook.com>
 <AM6PR04MB51581FBD4D21FEFDCAC2B27FE39F0@AM6PR04MB5158.eurprd04.prod.outlook.com>
 <7f92c150219832eb9fb54e72021116ad78ae71c3.camel@nxp.com>
 <CAOMZO5BFZVUT8x8o57TkYfwfT9OF1a=g5pNo48bW1qwfYXUrRg@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_093142_052953_94EC09EB 
X-CRM114-Status: GOOD (  13.24  )
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
Cc: "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTW9udGFnLCBkZW4gMjEuMDEuMjAxOSwgMTU6MzAgLTAyMDAgc2NocmllYiBGYWJpbyBFc3Rl
dmFtOgo+IEhpIERhbmllbCwKPiAKPiA+IE9uIE1vbiwgSmFuIDIxLCAyMDE5IGF0IDM6MjUgUE0g
RGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPiB3cm90ZToKPiAKPiA+IEhpIEZh
YmlvLAo+ID4gCj4gPiBZb3VyIHBhdGNoIGhlbHBzLgo+IAo+IFRoYW5rcyBmb3IgdGVzdGluZy4g
SSB3aWxsIHNlbmQgaXQgYXMgYSBmb3JtYWwgcGF0Y2guCgpJZiB5b3UgbG9vayBjbG9zZWx5IHRo
YXQncyBleGFjdGx5IHRoZSBwYXRjaCAyLzIgZnJvbSB0aGlzIHNlcmllcy4KClJlZ2FyZHMsCkx1
Y2FzCgo+IAo+ID4gTm93IHRoZSBjb25zb2xlIHdvcmtzLiBBbnlob3csIGl0IHNlZW1zIHRoYXQg
bm93IHRoZXJlCj4gPiBpcyBhIHByb2JsZW0gd2l0aCB0aGUgbmV0d29yayBjYXJkLgo+ID4gCj4g
PiBbwqDCoMKgwqAwLjgzMTQ1NF0gbWRpb19idXMgMzBiZTAwMDAuZXRoZXJuZXQtMTowMDogZXJy
b3IgLTIgbG9hZGluZyBQSFkgZHJpdmVyIG1vZHVsZSBmb3IgSUQgMHgwMDRkZDA3NAo+ID4gW8Kg
wqDCoMKgMC44NDA3OTZdIGZlYyAzMGJlMDAwMC5ldGhlcm5ldDogRHJvcHBpbmcgdGhlIGxpbmsg
dG8gcmVndWxhdG9yLjAKPiA+IFvCoMKgwqDCoDAuODQ3MjEyXSBmZWM6IHByb2JlIG9mIDMwYmUw
MDAwLmV0aGVybmV0IGZhaWxlZCB3aXRoIGVycm9yIC0yCj4gPiAKPiA+IEJvb3RpbmcgZmFpbHMg
bm93IGJlY2F1c2Uga2VybmVsIGlzbid0IGFibGUgdG8gbW91bnQgdG8gbmZzIHJvb3Rmcy4KPiA+
IAo+ID4gW8KgwqAxMTEuNjUyMTM0XSBWRlM6IFVuYWJsZSB0byBtb3VudCByb290IGZzIHZpYSBO
RlMsIHRyeWluZyBmbG9wcHkuCj4gPiBbwqDCoDExMS42NTg1MTBdIFZGUzogQ2Fubm90IG9wZW4g
cm9vdCBkZXZpY2UgIm5mcyIgb3IgdW5rbm93bi1ibG9jaygyLDApOiBlcnJvciAtNgo+ID4gCj4g
PiBUaGlzIHByb2JsZW0gaXMgc2ltaWxhciB3aXRoIHRoZSBvbmUgbWV0IG9uIGkuTVggOFFYUC4K
PiAKPiBEb2VzIHRoaXMgcGF0Y2ggaGVscD8KPiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0
cy9uZXRkZXYvbXNnNTQ1NTczLmh0bWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
