Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:28:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7C52146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ogiq1M0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7C52146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4JBkUwTkKtW2B0sNj3Ogw8BCnWEj/NbihnUYbcwsZB8=; b=ogiq1M0v6dZLDQ
	RH3WkXJ/oSvRGGgOwjxD67hMOkOrh4DqAEtAw9DtEkh5+X/DGHirfA6dDFxEvzs4rvuW75KbGpnyF
	Z8ratgXfLEKCvHzQXuil7ZTm69jiZ5GEc3igeY60eF2wXggvIgdqPpJj60GRdm+3MRhvTAkY7FTVy
	AEFy112zXccr1L8mfialDJudagXcbzud0SDZ1MIOJ+dq6vPvzGrCuC7MhxAe2fP2zWdcBpSYT0MW9
	M4uNQzkQxmPKPKW/3iZuLmR3yZWtAWNY30+qdqwP1oRJI5MzljbgKJvmXsWMYUAcMZQI2kQfzLdoB
	kq6Kuxz4iorazbltuP+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYq8I-0007Lm-8C; Mon, 17 Dec 2018 10:28:18 +0000
Received: from smtprelay06.ispgateway.de ([80.67.31.95])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYq8E-0007KY-07
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 10:28:16 +0000
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay06.ispgateway.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <LW@KARO-electronics.de>)
 id 1gYq7v-0005oC-F2; Mon, 17 Dec 2018 11:27:55 +0100
Date: Mon, 17 Dec 2018 11:27:52 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V9 2/7] clk: imx: add scu clock common part
Message-ID: <20181217112752.07e43d05@karo-electronics.de>
In-Reply-To: <AM0PR04MB4211E44C3B64033C3795BDB380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-3-git-send-email-aisheng.dong@nxp.com>
 <154447896872.17204.13777399275077720705@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211E44C3B64033C3795BDB380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_022814_037252_B179F5C9 
X-CRM114-Status: GOOD (  15.50  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiBUdWUsIDExIERlYyAyMDE4IDAzOjM1OjQ4ICswMDAwIEFpc2hlbmcgRG9uZyB3cm90
ZToKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBTdGVwaGVuIEJveWQg
W21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQo+ID4gUXVvdGluZyBBaXNoZW5nIERPTkcgKDIwMTgt
MTItMDQgMDY6Mzk6MjUpICAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9LY29u
ZmlnIGIvZHJpdmVycy9jbGsvaW14L0tjb25maWcgaW5kZXgKPiA+ID4gNDNhM2VjYy4uNjNlN2Iw
MSAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L0tjb25maWcKPiA+ID4gKysrIGIv
ZHJpdmVycy9jbGsvaW14L0tjb25maWcKPiA+ID4gQEAgLTMsMyArMyw3IEBACj4gPiA+ICBjb25m
aWcgTVhDX0NMSwo+ID4gPiAgICAgICAgIGJvb2wKPiA+ID4gICAgICAgICBkZXBlbmRzIG9uIEFS
Q0hfTVhDCj4gPiA+ICsKPiA+ID4gK2NvbmZpZyBNWENfQ0xLX1NDVSAgCj4gPiAKPiA+IElzIHRo
ZXJlIGFueSByZWFzb24gdG8gbWFrZSB0aGlzIGEgaGlkZGVuIG9wdGlvbiBpbnN0ZWFkIG9mIG1h
a2luZyBpdCBhCj4gPiBzZWxlY3RhYmxlIG9wdGlvbj8gSXQgY2FuIHN0aWxsIGRlcGVuZCBvbiBB
UkNIX01YQyBhbmQgQVJNNjQsIGJ1dCBvdGhlcndpc2UKPiA+IGl0IHNob3VsZCBiZSBjb21waWxh
YmxlIGFzIGxvbmcgYXMgQ09ORklHX0lNWF9TQ1UgaXMgZGVmaW5lZCAodGhpcyBzaG91bGQKPiA+
IGFsc28gYmUgYSBjb25maWcgd2UgZGVwZW5kIG9uIGhlcmUpLgo+ID4gICAKPiAKPiBUaGlzIGlz
IG1vc3RseSBmb2xsb3dpbmcgdGhlIGV4aXN0IHVzaW5nIHRoYXQgQ0xLIGlzIHNlbGVjdGVkIGJ5
IFNvQyBjb25maWcgb3B0aW9uLgo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gv
MTA2NzczMDkvCj4gCj4gQXMgQ0xLIHVzdWFsbHkgaXMgcmVxdWlyZWQgZm9yIHBsYXRmb3JtIHRv
IHJ1biB3ZWxsLCBzbyB3ZSBkaWQgbm90IG1ha2UgaXQgc2VsZWN0YWJsZS4KPiAKPiA+ID4gKyAg
ICAgICBib29sCj4gPiA+ICsgICAgICAgZGVwZW5kcyBvbiBBUkNIX01YQyAmJiBBUk02NAo+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L01ha2VmaWxlIGIvZHJpdmVycy9jbGsvaW14
L01ha2VmaWxlIGluZGV4Cj4gPiA+IGY4NTA0MjQuLjRhYmVkMzcgMTAwNjQ0Cj4gPiA+IC0tLSBh
L2RyaXZlcnMvY2xrL2lteC9NYWtlZmlsZQo+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvTWFr
ZWZpbGUKPiA+ID4gQEAgLTIwLDYgKzIwLDkgQEAgb2JqLSQoQ09ORklHX01YQ19DTEspICs9IFwK
PiA+ID4gICAgICAgICBjbGstcGxsdjQubyBcCj4gPiA+ICAgICAgICAgY2xrLXNjY2ctcGxsLm8K
PiA+ID4KPiA+ID4gK29iai0kKENPTkZJR19NWENfQ0xLX1NDVSkgKz0gXAo+ID4gPiArICAgICAg
IGNsay1zY3Uubwo+ID4gPiArCj4gPiA+ICBvYmotJChDT05GSUdfU09DX0lNWDEpICAgKz0gY2xr
LWlteDEubwo+ID4gPiAgb2JqLSQoQ09ORklHX1NPQ19JTVgyMSkgICs9IGNsay1pbXgyMS5vCj4g
PiA+ICBvYmotJChDT05GSUdfU09DX0lNWDI1KSAgKz0gY2xrLWlteDI1Lm8gZGlmZiAtLWdpdAo+
ID4gPiBhL2RyaXZlcnMvY2xrL2lteC9jbGstc2N1LmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLXNj
dS5jIG5ldyBmaWxlIG1vZGUKPiA+ID4gMTAwNjQ0IGluZGV4IDAwMDAwMDAuLmVjOGE0NzEKPiA+
ID4gLS0tIC9kZXYvbnVsbAo+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLXNjdS5jCj4g
PiA+IEBAIC0wLDAgKzEsMjY1IEBACj4gPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMCsKPiA+ID4gKy8qCj4gPiA+ICsgKiBDb3B5cmlnaHQgMjAxOCBOWFAKPiA+ID4gKyAq
ICAgRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4KPiA+ID4gKyAqLwo+ID4gPiAr
Cj4gPiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+Cj4gPiA+ICsjaW5jbHVkZSA8
bGludXgvZXJyLmg+Cj4gPiA+ICsjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+ID4gPiArCj4gPiA+
ICsjaW5jbHVkZSAiY2xrLXNjdS5oIgo+ID4gPiArCj4gPiA+ICtzdHJ1Y3QgaW14X3NjX2lwYyAq
Y2NtX2lwY19oYW5kbGU7ICAKPiA+IAo+ID4gV2h5IGRvZXMgdGhpcyBuZWVkIHRvIGJlIGEgZ2xv
YmFsPyBDYW4gaXQgYmUgaW4gZWFjaCBjbGtfc2N1IGluc3RhbmNlIGluc3RlYWQ/Cj4gPiAgIAo+
IAo+IE5vLCBubyBuZWVkIHRvIGJlIGluIGVhY2ggY2xrX3NjdSBpbnN0YW5jZS4KPiBUaGVyZSdz
IG9ubHkgb25lIGhhbmRsZXIuCj4gClNob3VsZG4ndCBpdCBiZSAnc3RhdGljJz8KCgpMb3RoYXIg
V2HDn21hbm4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
