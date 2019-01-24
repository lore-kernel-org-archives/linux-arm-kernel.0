Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD5C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:12:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03D32184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VPOGcEAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03D32184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UlDrmhcodTKJv7e8PEfnYxodYiy1ZQgDnk56CLjCQ/Y=; b=VPOGcEAAxGtFe/
	eb1cc+wdVx/WkFmWtrrnUbOUKl85zpTZRUUkNtz88RnYU4iE66wW/5+fXurXLmGcaID9z+uX1YYVL
	r6EhJENEc9I3RormAOe3TX9tiA2rJ40MOI66wgCxgneNUImTGrb+rd1N8xeLn/DvXUT6wBE0xUC9Z
	k+xZzOVuoIzo4sdbJGH+E3/IphV8YnVoT0/qsBSkM36k0hcGBOW4lzw8JELQRQMZVLUFpJpKk+eUA
	y6Z7PRp+XJ/hZHT9dAlfBrhM6eLyBWMfbOQZ06ke19ZKLkpUmI4YjvjS3JFbFDlrpS5cChIvbUmwe
	/3qaiXQKXVl9X7otlgnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmb3N-0008Er-I2; Thu, 24 Jan 2019 09:12:05 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmb3K-0008Dr-1G
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:12:03 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gmb3F-00088q-5O; Thu, 24 Jan 2019 10:11:57 +0100
Message-ID: <1548321116.6014.1.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 24 Jan 2019 10:11:56 +0100
In-Reply-To: <CAHQ1cqH1F2ivi57SuAdhzm-iCV=YsNKf-E+_GfxxjabFVDt0qQ@mail.gmail.com>
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
 <20181220010700.8598-3-andrew.smirnov@gmail.com>
 <1547743553.4009.16.camel@pengutronix.de>
 <CAHQ1cqG+3K+SKptZJ-FQ6xAa+2LMs_W24TEgqyV+9kR_iAz+cg@mail.gmail.com>
 <1548240735.3904.8.camel@pengutronix.de>
 <CAHQ1cqH1F2ivi57SuAdhzm-iCV=YsNKf-E+_GfxxjabFVDt0qQ@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_011202_232040_8B126A19 
X-CRM114-Status: GOOD (  19.07  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQW5kcmV5LAoKT24gV2VkLCAyMDE5LTAxLTIzIGF0IDIxOjMzIC0wODAwLCBBbmRyZXkgU21p
cm5vdiB3cm90ZToKPiBPbiBXZWQsIEphbiAyMywgMjAxOSBhdCAyOjUyIEFNIFBoaWxpcHAgWmFi
ZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgo+ID4gCj4gPiBPbiBUaHUsIDIwMTkt
MDEtMTcgYXQgMTQ6MzggLTA4MDAsIEFuZHJleSBTbWlybm92IHdyb3RlOgo+ID4gWy4uLl0KPiA+
ID4gPiBUbyBiZSBob25lc3QsIEkgZG9uJ3QgbGlrZSB0aGVzZSB0d28sIEknbSBub3QgY29udmlu
Y2VkIGFueW1vcmUgdGhhdAo+ID4gPiA+IHRoZXkgYWN0dWFsbHkgcXVhbGlmeSBhcyByZXNldCBz
aWduYWxzLiBUbyBtZSBpdCBsb29rcyBsaWtlIHRoaXMgaXMKPiA+ID4gPiBzb21ldGhpbmcgdGhh
dCB0aGUgUENJZSBnbHVlIGNvZGUgc2hvdWxkIGhhbmRsZSB2aWEgc3lzY29uIGxpa2UgaS5NWDYu
Cj4gPiA+ID4gTGVvbmFyZCwgTHVjYXMsIHdoYXQgZG8geW91IHRoaW5rPwo+ID4gPiAKPiA+ID4g
T0ssIG9uZSB0aGluZyB0byBrZWVwIGluIG1pbmQgYWJvdXQgdGhpcyBpcyB0aGF0IHRob3NlIGJp
dHMgYXJlCj4gPiA+IGFscmVhZHkgZXhwb3NlZCBmb3IgaS5NWDdEIGFuZCBJIHRoaW5rIChjb3Jy
ZWN0IG1lIGlmIEkgYW0gd3JvbmcpCj4gPiA+IHRoZXJlJ3Mgbm8gZ29pbmcgYmFjayB0aGVyZS4K
PiA+IAo+ID4gVGhhdCdzIG5vdCBhIHJlYXNvbiB0byByZXBlYXQgdGhlIHNhbWUgbWlzdGFrZSBm
b3IgaS5NWDhRTSwgYnV0IGF0IHRoZQo+ID4gbW9tZW50IEknbSBzdGlsbCB0cnlpbmcgdG8gZmln
dXJlIG91dCBpZiBpdCBhY3R1YWxseSB3YXMgYSBtaXN0YWtlLgo+ID4gCj4gCj4gSXQgYWJzb2x1
dGVseSBpcy4gCgpPaywgdGhhdCB3YXMgYSBzbG9wcHkgZXhwcmVzc2lvbi4gSSdtIGdsYWQgeW91
IGdvdCBteSBtZWFuaW5nIGFueXdheS4KT2YgY291cnNlIGl0IGlzIGEgcmVhc29uLCBidXQgaXQn
cyBub3QgYSBnb29kIG9uZS4KCj4gUmVtb3ZpbmcgdGhvc2UgcmVzZXRzIHdpbGwgbm90IG1lYW5p
bmdmdWxseSBzaW1wbGlmeQo+IG1haW50ZW5hbmNlIGJ1cmRlbiBmb3IgdGhpcyBkcml2ZXIgKGEg
b25lIGxpbmUgY2hhbmdlKSwKCkknbSBsZXNzIHdvcnJpZWQgYWJvdXQgdGhlIG1haW50ZW5hbmNl
IGJ1cmRlbiBvbiB0aGlzIHJlc2V0IGRyaXZlciBhbmQKbW9yZSBhYm91dCBseWluZyBpbiB0aGUg
ZGV2aWNlIHRyZWUgZGVzY3JpcHRpb24gYW5kIHBvc3NpYmx5IHNldHRpbmcgYQpiYWQgcHJlY2Vk
ZW50LgoKPiBidXQgaXQgd2lsbCBjYXVzZSBhZGRpdGlvbmFsIGNvZGUgY2h1cm4gb24gUENJIHNp
ZGUgb2YgdGhpbmdzLgo+IFlvdSBtYXkgbm90IGFncmVlwqB3aXRoIG1lIHRoYXQgaXQgaXMgYSBf
Z29vZF8gcmVhc29uIHRvIG5vdCB0byByZW1vdmUKPiB0aG9zZSByZXNldHMsIGJ1dCBpdCBpcyBh
IHJlYXNvbiBub25ldGhlbGVzcy4KCkV4YWN0bHkuIENvZGUgY2h1cm4gaW4gb25lIGRyaXZlciBp
bXBsZW1lbnRhdGlvbiBzaG91bGQgbm90IHN0b3AgdXMgZnJvbQpmaXhpbmcgZGV2aWNlIHRyZWUg
YmluZGluZ3MgKGluIGEgYmFja3dhcmRzIGNvbXBhdGlibGUgZmFzaGlvbikuCk1pbmQgeW91LCB0
aGlzIGlzIGFsbCB1bmRlciBteSBhc3N1bXB0aW9uIHRoYXQgdGhlIGJpdHMgaW4gcXVlc3Rpb24g
ZG8Kbm90IGNvbnRyb2wgcmVzZXRzIGFuZCBzaG91bGQgbmV2ZXIgaGF2ZSBiZWVuIGRlc2NyaWJl
ZCBhcyByZXNldHMgaW4gdGhlCmRldmljZSB0cmVlLgoKcmVnYXJkcwpQaGlsaXBwCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
