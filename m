Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9C0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:39:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB4B2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dE1Ok0Av";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="f9DC3s3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB4B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oimOg4k7ovYvHnp6x3GrIio4IfggVlMhwU2odDRA/KU=; b=dE1Ok0Av2SWkgO
	v8jxGib8gbi7Y6QDjkm0relpDU6OFxp1EP2RfgQYQZXawmVtUHNPXpy2YeaZ4fLJ0VxtoImDdOjyC
	5GJVJOVY8482WAEthobda3+OjODvH2YElXtoAqmuY37hS5anbPjCzb1NywD17ibyvHWmmQZH/pNNJ
	1AWfnBtGE7nLJqBvqKN8zatmXfkrrhiO1s20vvdT0SMyofpacr0cqI6c0AmCtR/jBDeMJpklFpEbF
	+wBYmOS4YBWIKE9+qZX6YY2/ag9bMipQUC+k4NYxeiTYUBDw3brVSce0tqfaXz0L92hRRxArFAMyK
	pbWJzwWr2b0cLqU/a2sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk48h-0003Zg-EV; Thu, 17 Jan 2019 09:39:07 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk48a-0003Vi-5d
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:39:05 +0000
X-IronPort-AV: E=Sophos;i="5.56,488,1539673200"; d="scan'208";a="23507779"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 17 Jan 2019 02:38:57 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 17 Jan 2019 02:38:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is3PtBt1v7cnY7dDj0lsgiHuqYQyV6irFm4guMzxCHs=;
 b=f9DC3s3jpWOPsFSU0W6Hq9hV7qAdxhwXc3VZh1o1MU/m9eFBhC3JEggwXM34vNy8EfBMOoLPifzqHsnSSGsbjBAzo2MhMEb6Zqlzbg6rg3JYk2smBXUR81k5Bx7+QI9jLsKYO4Vp4iKfR5VC0VLbZUVhIlFrRjbYU99wk28Ma4Y=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1741.namprd11.prod.outlook.com (10.175.52.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 17 Jan 2019 09:38:54 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5%7]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 09:38:53 +0000
From: <Nicolas.Ferre@microchip.com>
To: <mirq-linux@rere.qmqm.pl>, <linux-clk@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <sboyd@kernel.org>,
 <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3] clk: at91: optimize clk_round_rate() for AUDIO_PLL
Thread-Topic: [PATCH v3] clk: at91: optimize clk_round_rate() for AUDIO_PLL
Thread-Index: AQHUrkh1502hqd2qBkWT3ydFay3+rg==
Date: Thu, 17 Jan 2019 09:38:53 +0000
Message-ID: <834542a0-2895-0b73-162c-7bfea622eae8@microchip.com>
References: <70db24a03b552ca553e6435306d895644fb08545.1545131728.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <70db24a03b552ca553e6435306d895644fb08545.1545131728.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::30) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1741;
 6:go/bHqby96Kn3eg0WmkEo5aKgfIBxVNg7IHW31Pvqya2XLSqmR2V+YjNSicnjDj0c1GELNt4Kmn7oukQUax8CGUIiso4vibhLdmgmWIl4TSqjp9crGvw3ZuFI4il4gYl9lbpniYs/rJcoNLjvIzyOZzK1HpwV90wQk62oI2sok7GdUQBODR9cbYz+ymiIAeo20Gg6kSuNR7Su+qdJJhzgcwUp85RtFX7oKSxi0EkUxvh1VtZVA28AHs2apvE4cK46TcMs9Wo/27FSBHAYbuED9IbkuxjAaJSTZxg9eM51y6YJHky/+VLIvbrqnhBJ7fHIsUGScGz8r2/QMoAAam5u+chAthLl/GpiHC6XORRPsFpBYOQ0NurAnII0Mk8Q808sW5XA86GhdZVFCn85GXu5yOZYKi05vgBdnf/AJAg5hMOmayBG+wMTIa/0i6UvrrZ2LguB9b637sru9+HmWRK9A==;
 5:sKAeekDe4rS9rccWJWrPlWax1t+AXiKDbQoqwK5sUyG2etseViynXIrovNbMfnLDe/pkNu/ekRS1UFAvFMMrfOZ1028n3ity+f9EWRnCrWDYdVIpiTeCSdZ9Kx4qYg1RggJeJt8+t9jNmwaKIE9H/pV/7w6FteCUWygW/5RPiXKSsIRjbKodrECUxOFnKhlLHVbD7JRnHnxrOVlZFd5XCA==;
 7:qa64kqGia0UdOwAUKtecm0s4Gnt/mMEsxwa3YMSkvTjKizceOlw/+I5QZuz6fBuWB4lfoGRvpc6WOX4QzpX9hgzwTyd7qQq6BQ2Uod05768Devby/KX60S6keH/Nzf3tCRJL+iRbvyav+R4G9AqBVw==
x-ms-office365-filtering-correlation-id: 61471143-d26a-4798-c884-08d67c5f9816
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1741; 
x-ms-traffictypediagnostic: MWHPR11MB1741:
x-microsoft-antispam-prvs: <MWHPR11MB17412BB9FAD475E1B8DF2FA0E0830@MWHPR11MB1741.namprd11.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(346002)(136003)(39860400002)(396003)(199004)(189003)(4326008)(25786009)(86362001)(2201001)(2501003)(8676002)(66574012)(6486002)(476003)(186003)(8936002)(54906003)(31696002)(68736007)(446003)(99286004)(110136005)(81156014)(11346002)(81166006)(6246003)(2906002)(2616005)(316002)(26005)(7736002)(3846002)(478600001)(52116002)(486006)(102836004)(5660300001)(97736004)(6116002)(31686004)(105586002)(106356001)(6436002)(305945005)(6506007)(14444005)(256004)(53546011)(53936002)(36756003)(76176011)(71200400001)(71190400001)(229853002)(66066001)(14454004)(386003)(6512007)(72206003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1741;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nGkk4mrEywH0sseEj7LIpo4l/cQdnJ09l64Hr1TQX2jaq6FilVTSIxfdwbsfA9ZkmGDTkfGWp36WeA5RCjiUeMYzwSHMzXPjuZm/WSV0UszWT4oAzW+4d9uhu3o8oN98ovMw//lOEa9sIrHb2x0MgnbUzJnI6S4eSd+MM2e2heUOnnCbzF7fpxB4x2vi5PzrnQfDoXcjT6RO/+75BB4Dqo1ROKRJtoUcPzJYdurgXXIrXhWBVAzMgVfpYinbraP9oxG7qUjj5oMwhZ4Ckckh/LtPX938X+9zeFEGnY67fC9EqknY8NkvmD80bCRFcP0Vi1Gq3q0AX2r8RdzYJYDx6/7xEzwqNysbDF/jG9B6xEzQSydtQ8dVCpVmoQ/mf59F1MoTThYHMB1goYog8f68cdroSNU9mMToLuy6wou82QA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <D36EB94EB1DB014496250DD322A22D0B@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 61471143-d26a-4798-c884-08d67c5f9816
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 09:38:51.4303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1741
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_013900_682949_FFFE30B6 
X-CRM114-Status: GOOD (  15.65  )
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
Cc: mturquette@baylibre.com, Ludovic.Desroches@microchip.com,
 bbrezillon@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTgvMTIvMjAxOCBhdCAxMjoyMCwgTWljaGHFgiBNaXJvc8WCYXcgd3JvdGU6DQo+IFN0b3Ag
dGhlIHNlYXJjaCBmb3IgcGFyZW50IHJhdGUgd2hlbiBleGFjdCBtYXRjaCBpcyBmb3VuZC4NCj4g
DQo+IFRoaXMgbWFrZXMgZm9yIDMgY2xrX3JvdW5kX3JhdGUoKSBjYWxscyBpbnN0ZWFkIG9mIDY0
IG9mIHRoZW0gb24NCj4gU0FNQTVEMi1iYXNlZCBib2FyZCB3aGVuIHNlYXJjaGluZyBmb3IgMTIu
Mjg4TUh6IGNsb2NrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGHFgiBNaXJvc8WCYXcgPG1p
cnEtbGludXhAcmVyZS5xbXFtLnBsPg0KDQpJdCBsb29rcyBjb3JyZWN0IHRvIG1lOg0KUmV2aWV3
ZWQtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCg0KVGhh
bmtzIE1pY2hhxYIhDQoNCkJlc3QgcmVnYXJkcywNCiAgIE5pY29sYXMNCg0KDQo+IC0tLQ0KPiAg
IHYyOiByZWJhc2VkIG9uIHY0LjIwLXJjNw0KPiAgIHYzOiBmb3JtYXR0aW5nIGFuZCBjb21taXQg
ZGVzY3JpcHRpb24gY2hhbmdlcw0KPiAtLS0NCj4gICBkcml2ZXJzL2Nsay9hdDkxL2Nsay1hdWRp
by1wbGwuYyB8IDkgKysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvY2xr
LWF1ZGlvLXBsbC5jIGIvZHJpdmVycy9jbGsvYXQ5MS9jbGstYXVkaW8tcGxsLmMNCj4gaW5kZXgg
MzZkNzcxNDZhM2JkLi4zY2M0YTgyZjRlOWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2F0
OTEvY2xrLWF1ZGlvLXBsbC5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWF1ZGlvLXBs
bC5jDQo+IEBAIC0zNDAsNyArMzQwLDEyIEBAIHN0YXRpYyBsb25nIGNsa19hdWRpb19wbGxfcG1j
X3JvdW5kX3JhdGUoc3RydWN0IGNsa19odyAqaHcsIHVuc2lnbmVkIGxvbmcgcmF0ZSwNCj4gICAJ
cHJfZGVidWcoIkEgUExML1BNQzogJXMsIHJhdGUgPSAlbHUgKHBhcmVudF9yYXRlID0gJWx1KVxu
IiwgX19mdW5jX18sDQo+ICAgCQkgcmF0ZSwgKnBhcmVudF9yYXRlKTsNCj4gICANCj4gLQlmb3Ig
KGRpdiA9IDE7IGRpdiA8PSBBVURJT19QTExfUURQTUNfTUFYOyBkaXYrKykgew0KPiArCWlmICgh
cmF0ZSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwliZXN0X3BhcmVudF9yYXRlID0gY2xrX3Jv
dW5kX3JhdGUocGNsay0+Y2xrLCAxKTsNCj4gKwlkaXYgPSBtYXgoYmVzdF9wYXJlbnRfcmF0ZSAv
IHJhdGUsIDFVTCk7DQo+ICsJZm9yICg7IGRpdiA8PSBBVURJT19QTExfUURQTUNfTUFYOyBkaXYr
Kykgew0KPiAgIAkJYmVzdF9wYXJlbnRfcmF0ZSA9IGNsa19yb3VuZF9yYXRlKHBjbGstPmNsaywg
cmF0ZSAqIGRpdik7DQo+ICAgCQl0bXBfcmF0ZSA9IGJlc3RfcGFyZW50X3JhdGUgLyBkaXY7DQo+
ICAgCQl0bXBfZGlmZiA9IGFicyhyYXRlIC0gdG1wX3JhdGUpOw0KPiBAQCAtMzUwLDYgKzM1NSw4
IEBAIHN0YXRpYyBsb25nIGNsa19hdWRpb19wbGxfcG1jX3JvdW5kX3JhdGUoc3RydWN0IGNsa19o
dyAqaHcsIHVuc2lnbmVkIGxvbmcgcmF0ZSwNCj4gICAJCQliZXN0X3JhdGUgPSB0bXBfcmF0ZTsN
Cj4gICAJCQliZXN0X2RpZmYgPSB0bXBfZGlmZjsNCj4gICAJCQl0bXBfcWQgPSBkaXY7DQo+ICsJ
CQlpZiAoIWJlc3RfZGlmZikNCj4gKwkJCQlicmVhazsJLyogZ290IGV4YWN0IG1hdGNoICovDQo+
ICAgCQl9DQo+ICAgCX0NCj4gICANCj4gDQoNCg0KLS0gDQpOaWNvbGFzIEZlcnJlDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
