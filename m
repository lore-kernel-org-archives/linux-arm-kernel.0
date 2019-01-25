Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D8DC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:56:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC85218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SL/NbhTf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rQ8TEKWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC85218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H2o+0Po2NFeKj720zkUiWOmAPmjFHQL75+kWNQs7c9o=; b=SL/NbhTfBZ9R6d
	CkHUoiClkp77yxPIp4AgAVQwyT5CAzzA6PCQ28GnyDGwuKLu5Auq9AAh8RSjreQA8M7597Kl3rtvP
	YTgwqjDo0BPn1XIeLtMGjf7I2bAwTbufoMuSu0cq+fbZR6dy8kjm2L7KqGx3GLNxB8RghEQPuZ4yG
	zFdIrujLGzPHue6x6afi2XC0Cn811+bXcelqUSWsvsiJYMjkv9T+ZIVG4uOW3yBgI1qu3w6Tfosqr
	0OPMr2vYa0DuYa+hMG6sdm5HCENpoeCT/2c4HG7J1CNcDluISZOFwBAhFT+C3XukdtrvCCgjq/gZ8
	0DxnWmQzvQnTNqeFtEVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmz9d-0006ww-Sm; Fri, 25 Jan 2019 10:56:09 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz96-0006Ke-0Y
 for linux-arm-kernel@bombadil.infradead.org; Fri, 25 Jan 2019 10:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DWYqoTfCFtmfBpIg14Ei+Q+4zWgWsR+Rr9bK9nXTy+k=; b=rQ8TEKWTyZtvALmd5DQU1TBErx
 ryeGfrMKXXDIh07i8eBVduPP3am2RATFsJNDqZEn/lizDGu09QIYVkcB8MoHZtW1Huyl9hXODFVv4
 VHCG9G1+To/4S76vNlacd2SIXwClPcWGnwmtRqFBjv5yKuUfZqzEeSsBHdvmmzq4MgGd2yV9S2aOh
 ygm2pV6xHhIw+Chd9ycGT34sNqXoaryB2wfdNFqVIb3/VdCtSCqmezcNM5fN/CZLaiREXsRbjhACh
 nJkQviSMSZYOav2vlFHihf3hAzU4Nzj1YkcHyBedAHwBndVigVo1a+1JnGcgLHxp0XvHVrS4nUiPS
 0qpsAuTw==;
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmywb-0000Ub-CA
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:42:43 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmywX-0002CN-J6; Fri, 25 Jan 2019 11:42:37 +0100
Message-ID: <1548412956.28802.41.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 25 Jan 2019 11:42:36 +0100
In-Reply-To: <AM0PR04MB42114F3D625CC48343EA427080980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
 <1547801609.2626.5.camel@pengutronix.de>
 <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1547806960.2626.9.camel@pengutronix.de>
 <AM0PR04MB42111FE266342A2C2EAECC3580980@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1548154758.2465.20.camel@pengutronix.de>
 <AM0PR04MB4211B9003857795EBC79541480980@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1548161549.2465.24.camel@pengutronix.de>
 <AM0PR04MB42114F3D625CC48343EA427080980@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_104241_456699_04410906 
X-CRM114-Status: GOOD (  47.35  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpBbSBEaWVuc3RhZywgZGVuIDIyLjAxLjIwMTksIDEzOjE3ICswMDAwIHNjaHJpZWIgQWlz
aGVuZyBEb25nOgo+ID4gPiA+IEZyb206IEx1Y2FzIFN0YWNoIFttYWlsdG86bC5zdGFjaEBwZW5n
dXRyb25peC5kZV0KPiA+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjIsIDIwMTkgODo1MiBQTQo+
ID4gPiA+IFRvOiBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZwo+ID4gPiA+ID4gPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBkbC1saW51eC1pbXgKPiA+ID4g
PiA+ID4gPiA+IDxsaW51eC1pbXhAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7Cj4gPiA+ID4gdGdseEBsaW51dHJvbml4LmRlOyBNYXJjIFp5
bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29tPgo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzRd
IGlycTogaW14OiBpcnFzdGVlcjogYWRkIG11bHRpIG91dHB1dCBpbnRlcnJ1cHRzIHN1cHBvcnQK
PiA+IAo+ID4gQW0gRGllbnN0YWcsIGRlbiAyMi4wMS4yMDE5LCAxMjowMyArMDAwMCBzY2hyaWVi
IEFpc2hlbmcgRG9uZzoKPiA+ID4gPiA+ID4gRnJvbTogTHVjYXMgU3RhY2ggW21haWx0bzpsLnN0
YWNoQHBlbmd1dHJvbml4LmRlXQo+ID4gPiA+IAo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEphbnVh
cnkgMjIsIDIwMTkgNjo1OSBQTQo+ID4gPiA+IAo+ID4gPiA+IEFtIERpZW5zdGFnLCBkZW4gMjIu
MDEuMjAxOSwgMTA6MzkgKzAwMDAgc2NocmllYiBBaXNoZW5nIERvbmc6Cj4gPiA+ID4gPiA+ID4g
PiBGcm9tOiBMdWNhcyBTdGFjaCBbbWFpbHRvOmwuc3RhY2hAcGVuZ3V0cm9uaXguZGVdCj4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTgsIDIwMTkgNjoyMyBQ
TQo+ID4gPiA+ID4gCj4gPiA+ID4gPiBbLi4uXQo+ID4gPiA+ID4gPiA+ID4gVGhpcyBoYXMgYmVl
biBkaXNjdXNzZWQgd2hlbiB1cHN0cmVhbWluZyB0aGUgZHJpdmVyLiBUaGUKPiA+ID4gPiA+ID4g
PiA+IGNvbnRyb2xsZXIgbWF5IHN1cHBvcnQgbXVsdGlwbGUgb3V0cHV0IElSUXMsIGJ1dCBvbmx5
IG9uZQo+ID4gPiA+ID4gPiA+ID4gdGhlbSBpcyBhY3R1YWxseSB1c2VkIGRlcGVuZGluZyBvbiB0
aGUgQ0hBTkNUUkwgY29uZmlnLgo+ID4gPiA+ID4gPiA+ID4gVGhlcmUgaXMgbm8gdXNlIGluIGhv
b2tpbmcgdXAgYWxsIHRoZSBvdXRwdXQgSVJRcyBpbiBEVCwgaWYKPiA+ID4gPiA+ID4gPiA+IG9u
bHkgb25lIG9mIHRoZW0gaXMgYWN0dWFsbHkgdXNlZC4gU29tZSBvZiB0aGUgb3V0cHV0cyBtYXkK
PiA+ID4gPiA+ID4gPiA+IG5vdCBldmVuIGJlIHZpc2libGUgdG8gdGhlIExpbnV4IHN5c3RlbSwg
YnV0IG1heSBiZWxvbmcgdG8gYQo+ID4gPiA+ID4gPiA+ID4gQ29ydGV4IE00IHN1YnN5c3RlbS4g
QWxsIG9mIHRob3NlIGNvbmZpZ3VyYXRpb25zIGNhbiBiZQo+ID4gPiA+ID4gPiA+ID4gZGVzY3Jp
YmVkIGluIERUIGJ5IGNoYW5naW5nIHRoZSB1cHN0cmVhbSBpbnRlcnJ1cHQgYW5kCj4gPiA+ID4g
PiA+ID4gPiAiZnNsLGNoYW5uZWwiIGluIGEKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IGNvaGVy
ZW50IHdheS4KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gUGxlYXNlIGNvcnJlY3Qg
bWUgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyB0b3RhbGx5IHdyb25nLgo+ID4gPiA+ID4gPiA+IAo+
ID4gPiA+ID4gPiA+IEknbSBhZnJhaWQgeW91ciB1bmRlcnN0YW5kaW5nIG9mIENIQU4gc2VlbXMg
d3JvbmcuCj4gPiA+ID4gPiA+ID4gKEJpbmRpbmcgZG9jIG9mIHRoYXQgcHJvcGVydHkgbmVlZHMg
Y2hhbmdlIGFzIHdlbGwpLgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IE9uIFFYUCBEQyBT
UywgdGhlIElSUVNURUVSIHN1cHBvcnRzIDUxMiBpbnRlcnJ1cHRzIHdpdGggOAo+ID4gPiA+ID4g
PiA+IGludGVycnVwdCBvdXRwdXQgQ29ubnRlY3RlZCB0byBHSUMuCj4gPiA+ID4gPiA+ID4gVGhl
IGN1cnJlbnQgZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgaXQgYXMgaXQgYXNzdW1lcyBvbmx5IG9u
ZQo+ID4gPiA+ID4gPiA+IGludGVycnVwdAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gb3V0cHV0
IHVzZWQuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBPa2F5LCBzbyBsZXQncyB0YWtlIGEgc3Rl
cCBiYWNrLiBUaGUgZGVzY3JpcHRpb24gaW4gdGhlIFFYUCBSTQo+ID4gPiA+ID4gPiBpcyBhY3R1
YWxseSBiZXR0ZXIgdGhhbiB3aGF0IEkndmUgc2VlbiB1bnRpbCBub3cuIFN0aWxsIGl0J3MKPiA+
ID4gPiA+ID4gdG90YWxseSBjb25mdXNpbmcgdGhhdAo+ID4gPiA+IAo+ID4gPiA+IHRoZSAiY2hh
bm5lbCIKPiA+ID4gPiA+ID4gdGVybWlub2xvZ3kgdXNlZCB3aXRoIGRpZmZlcmVudCBtZWFuaW5n
cyBpbiBkb2NzLiBMZXQncyB0cnkgdG8KPiA+ID4gPiA+ID4gYXZvaWQgdGhpcyBhcyBtdWNoIGFz
IHBvc3NpYmxlLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gU28gdG8gZ2V0IHRoaW5ncyBzdHJh
aWdodDogRWFjaCBpcnFzdGVlciBjb250cm9sbGVyIGhhcyBhIG51bWJlcgo+ID4gPiA+ID4gPiBv
ZiBJUlEKPiA+ID4gPiAKPiA+ID4gPiBncm91cHMuCj4gPiA+ID4gPiA+IEFsbCB0aGUgaW5wdXQg
SVJRcyBvZiBvbmUgZ3JvdXAgYXJlIE9SZWQgdG9nZXRoZXIgdG8gZm9ybSBvbiBvdXRwdXQKPiA+
IAo+ID4gSVJRLgo+ID4gPiA+ID4gPiBEZXBlbmRpbmcgb24gdGhlIFNvQyBpbnRlZ3JhdGlvbiwg
YSBncm91cCBjYW4gY29udGFpbiAzMiBvcgo+ID4gPiA+ID4gPiA2NCBJUlFzLCB3aGVyZSBEQ1NT
IGlycXN0ZWVyIG9uIE1YOE0gYW5kIHRoZSBiaWcgNTEyIGlucHV0Cj4gPiA+ID4gPiA+IGNvbnRy
b2xsZXJzIG9uIFFYUCBhbmQgUU0gYm90aCB1c2UgNjQgSVJRcyBwZXIgZ3JvdXAuIFlvdSBhcmUK
PiA+ID4gPiA+ID4gY2xhaW1pbmcgdGhhdCB0aGUgc21hbGxlciBjb250cm9sbGVycyBvbiBib3Ro
IFFYUCBhbSBRTSBoYXZlCj4gPiA+ID4gPiA+IG9ubHkgMzIKPiA+ID4gPiAKPiA+ID4gPiBJUlFz
IHBlciBncm91cCwgcmlnaHQ/Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBTbyB0aGUgb25seSBj
aGFuZ2UgdGhhdCBpcyBuZWVkZWQgaXMgdGhhdCB0aGUgZHJpdmVyIG5lZWRzIHRvCj4gPiA+ID4g
PiA+IGtub3cgdGhlIG51bWJlciBvZiBpbnB1dCBJUlFzIHBlciBncm91cCwgd2l0aCBhIGRlZmF1
bHQgb2YgNjQgdG8KPiA+ID4gPiA+ID4gbm90IGJyZWFrIERUCj4gPiA+ID4gCj4gPiA+ID4gY29t
cGF0aWJpbGl0eS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+IE5vdCBleGFjdGx5
Lgo+ID4gPiA+ID4gZnJvbSBIVyBwb2ludCBvZiB2aWV3ICwgdGhlcmUncmUgdHdvIHBhcmFtZXRl
cnMgZHVyaW5nIElSUVNURUVSCj4gPiA+ID4gCj4gPiA+ID4gaW50ZWdyYXRpb24uCj4gPiA+ID4g
PiBGb3IgZXhhbXBsZSwKPiA+ID4gPiA+IERDIGluIFFYUDoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IHBhcmFtZXRlcsKgwqBJUlFDSEFOCQk9wqDCoDE7Cj4gPiAKPiA+IAkvL051
bWJlciBvZiBJUlEgQ2hhbm5lbHMvU2xvdHMKPiA+ID4gPiA+ID4gPiBwYXJhbWV0ZXLCoMKgTklO
VDMyCQk9wqDCoDg7CS8vTnVtYmVyIG9mIGludGVycnVwdHMgaW4KPiA+IAo+ID4gbXVsdGlwbGUK
PiA+ID4gPiAKPiA+ID4gPiBvZiAzMgo+ID4gPiA+IAo+ID4gPiA+IElmIHRoaXMgaXMgYWx3YXlz
IGluIG11bHRpcGxlcyBvZiAzMiwgdGhlIG9ubHkgY2hhbmdlIHdlIG5lZWQgdG8KPiA+ID4gPiBt
YWtlIHRvIHRoZSBkcml2ZXIgaXMgdG8gZml4IERUIGJpbmRpbmcgYW5kIGludGVycHJldGF0aW9u
IG9mIHRoZQo+ID4gPiA+ICJmc2wsaXJxLWdyb3VwcyIgcHJvcGVydHkgdG8gYmUgaW4gbXVsdGlw
bGVzIG9mIDMyLgo+ID4gPiA+IAo+ID4gPiA+IFRoaXMgbWVhbnMgaS5NWDhNUSBEQ1NTIGlycXN0
ZWVyIHdvdWxkIG5lZWQgdG8gY2hhbmdlIHRvIDIKPiA+ID4gPiBpcnEtZ3JvdXBzLCBidXQgYXMg
dGhpcyBpc24ndCB1c2VkIHVwc3RyZWFtIHlldCB3ZSBjYW4gc3RpbGwgZG8gdGhpcwo+ID4gPiA+
IGNoYW5nZSB3aXRob3V0IGJyZWFraW5nIHRvbyBtdWNoIHN0dWZmIGFuZCBJIHdvdWxkIHJhdGhl
ciBjb3JyZWN0Cj4gPiA+ID4gdGhpcyBub3cgdGhhbiBrZWVwaW5nIGEgRFQgYmluZGluZyBhcm91
bmQgdGhhdCBkb2Vzbid0IG1hdGNoIHRoZSBIVy4KPiA+ID4gPiAKPiA+ID4gCj4gPiA+IFdlIHdh
bnQgdG8gYXZvaWQgdXNpbmcgb2YgaXJxLWdyb3VwcyBhcyBpdCdzIHdyb25nLgo+ID4gPiBTdGlj
ayB0byBIVyBwYXJhbWV0ZXJzLCBvbmx5IGNoYW5uZWwgbnVtYmVyIGFuZCBpbnRlcnJ1cHRzIG51
bWJlciBzaG91bGQKPiA+IAo+ID4gYmUgdXNlZC4KPiA+IAo+ID4gVGhlIGZzbCxpcnEtZ3JvdXBz
IHByb3BlcnR5IGlzIGV4YWN0bHkgeW91ciBOSU5UMzIgcGFyYW1ldGVyIGFib3ZlLiBJIGp1c3QK
PiA+IHdyb25nbHkgYXNzdW1lZCB0aGF0IGl0J3MgYWx3YXlzIGluIG11bHRpcGxlcyBvZiA2NCwg
YXMgdGhhdCdzIHdoYXQgdGhlCj4gPiBpLk1YOE1RIERDU1MgaXJxc3RlZXIgbW9kdWxlIGxvb2tz
IGxpa2UuIFdlIHNob3VsZCBmaXggdGhpcyBhbmQgYmUgZG9uZSB3aXRoCj4gPiBpdC4KPiA+IAo+
IAo+IE5vLCBub3QgZXhhY3RseSB0aGUgc2FtZSB0aGluZy4gVXNpbmcgZ3JvdXAgd2lsbCBjb25m
dXNlIHBlb3BsZSB0aGF0IHRoZSBncm91cCBpcyAzMi4KPiBIb3dldmVyLCBpbnRlcm5hbGx5IEdy
b3VwIGlzIGZpeGVkIDY0IGludGVycnVwdHMgYWx0aG91Z2ggaXQgbWF5IG5vdCB1c2UgYWxsIHRo
ZQo+IDY0IGludGVycnVwdHMuIEUuZy4gMzIgaW50ZXJydXB0cy4KPiBTZWUgQ0huX01JTlRESVMg
cmVnaXN0ZXIgd2hpY2ggaXMgYWxzbyBkZWZpbmVkIGZpeGVkIHRvIDY0Lgo+IAo+IFRoZSB0d28g
SFcgcGFyYW1ldGVyIGZvciBpbnRlZ3JhdGlvbiBpcyBhbHJlYWR5IHZlcnkgY2xlYXIuIFdlIHNo
b3VsZCB1c2UgaW50ZXJydXB0cwo+IE51bWJlciBmb3IgdGhlIGNoYW5uZWwuIE5vdCBncm91cC7C
oAoKT2theSwgSSBzZWUgdGhhdCB0aGUgbmFtZSBpcnEtZ3JvdXBzIGlzIGNvbmZ1c2luZyBmb3Ig
eW91LiBCdXQgdGhlbiBJCmZpbmQgdGhlIC1wZXItY2hhbiBuYW1pbmcgY29uZnVzaW5nLgoKU28g
Z2l2ZW4gdGhhdCB3ZSBzZWVtIHRvIGFncmVlIHRvIHNwbGl0IGVhY2ggY2hhbm5lbCBpbnRvIGl0
J3Mgb3duIERUCm5vZGUsIHRoZXJlIGlzIG5vIG5lZWQgdG8gbmFtZSB0aGUgcHJvcGVydHkgInNv
bWV0aGluZy1wZXItY2hhbiIsIGFzCml0J3MgaW1wbGllZCBieSB0aGUgc3BsaXQgRFQgbm9kZXMg
dGhhdCBhbGwgcHJvcGVydGllcyBpbiBvbmUgbm9kZSBhcmUKcmVmZXJlbmNpbmcgYSBjaGFubmVs
LgoKTWF5IEkgc3VnZ2VzdCB0byBuYW1lIHRoZSBwcm9wZXJ0eSAiZnNsLG51bS1pcnFzIj8KClJl
Z2FyZHMsCkx1Y2FzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
