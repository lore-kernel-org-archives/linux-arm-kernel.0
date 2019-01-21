Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B884C31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F243620989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dUMjOEYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F243620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6xy6RgHKHJIMxZx7TcdyXzAobJa0QIfYfVvrM0jDMO8=; b=dUMjOEYI9KiKqp
	2LV+cH4648b6mqiBArxYKDUfUG51TyPtR+7VYiYUnwNFoLRGpDTDp7FovUkEsco8JNanaC6aRwxVj
	vm6bU2D5bvlsbhRGNvQ7Q/jL06AHl3tnmoWlpSsrJU2Yoc52ADzWe/OlrcnBJv+jQF8rj19uZAaWE
	SV7VffeWQEt66fgSYQtYhVijImbATyaxL1IxUmfmDRbqaIoZLnyqpJJ484GmkmuC23kAHyt2yBc20
	089loalg65Tn0dtvjLo4uWEPYk3+ZXOE9DqB2PEFm58RHRuRkZo1rhNfgoIk/pFibW6aC6SdwaQau
	/vlMSnIboFReGW2rKnZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldam-0006ai-0t; Mon, 21 Jan 2019 17:42:36 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldai-0006aI-FF
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:42:34 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gldaf-0004Yt-A2; Mon, 21 Jan 2019 18:42:29 +0100
Message-ID: <1548092548.2465.12.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 Jan 2019 18:42:28 +0100
In-Reply-To: <CAOMZO5D3E_pBOXoZXNMiFMofpx4eCU80iWjcXcCQ3cAKsXxEjA@mail.gmail.com>
References: <20190115110446.19077-1-l.stach@pengutronix.de>
 <VI1PR0402MB3357FAB48888D99A809F41AEF99F0@VI1PR0402MB3357.eurprd04.prod.outlook.com>
 <AM6PR04MB51581FBD4D21FEFDCAC2B27FE39F0@AM6PR04MB5158.eurprd04.prod.outlook.com>
 <7f92c150219832eb9fb54e72021116ad78ae71c3.camel@nxp.com>
 <CAOMZO5BFZVUT8x8o57TkYfwfT9OF1a=g5pNo48bW1qwfYXUrRg@mail.gmail.com>
 <1548091897.2465.10.camel@pengutronix.de>
 <CAOMZO5D3E_pBOXoZXNMiFMofpx4eCU80iWjcXcCQ3cAKsXxEjA@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_094232_756198_ECFBF1E7 
X-CRM114-Status: GOOD (  11.17  )
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
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
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

QW0gTW9udGFnLCBkZW4gMjEuMDEuMjAxOSwgMTU6MzQgLTAyMDAgc2NocmllYiBGYWJpbyBFc3Rl
dmFtOgo+IEhpIEx1Y2FzLAo+IAo+ID4gT24gTW9uLCBKYW4gMjEsIDIwMTkgYXQgMzozMSBQTSBM
dWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4gd3JvdGU6Cj4gCj4gPiBJZiB5b3Ug
bG9vayBjbG9zZWx5IHRoYXQncyBleGFjdGx5IHRoZSBwYXRjaCAyLzIgZnJvbSB0aGlzIHNlcmll
cy4KPiAKPiBPaCwgdGhhdCdzIHRydWUgOi0pCj4gCj4gQWZ0ZXIgeW91ciBwYXRjaCBnZXRzIGFw
cGxpZWQgSSB3aWxsIGFsc28gbWFrZSB0aGUgbXg4bSBwaW5jdHJsIGRyaXZlcgo+IHRvIGJlIHNl
bGVjdGVkLgoKSSBndWVzcyB0aGUganVkZ2VzIGFyZSBzdGlsbCBvdXQgb24gd2hldGhlciB0aGlz
IHNob3VsZCBvbmx5IGJlIGVuYWJsZWQKaW4gdGhlIGRlZmNvbmZpZyBvciBzZWxlY3RlZCBmcm9t
IHRoZSAocmVhbGx5IGJyb2FkKSBBUkNIX01YQyBzeW1ib2wuwqAKCk15IHByZWZlcmVuY2UgaXMg
YWxzbyB0byBoYXZlIHRoZSBzZWxlY3QsIGJ1dCB0aGF0IG1lYW5zIHdlIG15IGVuZCB1cAp3aXRo
IGEgbG90IG9mIGRyaXZlcnMgZm9yY2UtZW5hYmxlZCB0aGF0IG1heSBub3QgYmUgcmVsZXZhbnQg
Zm9yIHRoZQpTb0MgdGhlIGtlcm5lbCBpcyBjb25maWd1cmVkIHRvIHJ1biBvbi4gTGlrZSBhbGwg
dGhlIGkuTVg4TSBzdHVmZiBiZWluZwp1c2VsZXNzIG9uIGkuTVg4WC4KClJlZ2FyZHMsCkx1Y2Fz
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
