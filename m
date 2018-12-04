Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D71C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:19:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FF42087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d0h3f4A0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WmxoxMiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FF42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xa8MRYRYKp1tlzhJqghqrYbwvpQ3KyYMccfZZcSDPzw=; b=d0h3f4A0HFEf4E
	VICpqjCq41TTgPrqXG49HfPzJ5ExZojRO0rjGlriyWjAD+Ig3Jf8zbZiRCC6KpACHThCvjbin7cwA
	lTrwXJ2j4qWGfusCtMxg4CMBZkl3bBbW8+i7qVRRjLFN6NNN37t8BpzA1rePVlM4BVG+JmpLESytY
	U92vOE5IJTAtT+kenYqfAmSln6f2XXLEF3JZs29zpy67uBsMCMpG4kQn3HtZNPaffYdbJmbIEeqi/
	RTA0h2GK4HX8grdpRljEiVU8eZxva/wRJO31VY5OafCBpzCS1yTxH6yEzuJifP3+YWWqUZLvsei+U
	FZXE8PM5WX/VjserUNdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU43P-0001b1-7X; Tue, 04 Dec 2018 06:19:31 +0000
Received: from mail-am5eur03on062d.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::62d]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU43L-0001Zw-Fm
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 06:19:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA5PuuBIcKMrjf2fx48s4rvcUrjnGY5f3mG3h0k29rs=;
 b=WmxoxMiI6eYArX09FcOmI5OdmXPmGIPmtXpOcv+bkuQD+FtyZ2+z/lS56hFakLIhTnD/awQoz3PwMUQo+FaiN2gYuAzsqxoqz7LzaSTF2w8rDOf67H5IZj7nZjb8xQEzaSiv6S2Gz9ToX4qdjAT/qBSqE0TS7xHQwKFpoO0nGQU=
Received: from AM0PR04MB5314.eurprd04.prod.outlook.com (20.177.42.87) by
 AM0PR04MB4721.eurprd04.prod.outlook.com (20.176.214.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 06:19:11 +0000
Received: from AM0PR04MB5314.eurprd04.prod.outlook.com
 ([fe80::7456:34a:3cbc:a78a]) by AM0PR04MB5314.eurprd04.prod.outlook.com
 ([fe80::7456:34a:3cbc:a78a%4]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 06:19:11 +0000
From: PETER CHEN <peter.chen@nxp.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH v2 2/3] usb: chipidea: imx: Warn if oc polarity isn't
 specified
Thread-Topic: [PATCH v2 2/3] usb: chipidea: imx: Warn if oc polarity isn't
 specified
Thread-Index: AQHUioa2aEcyUBE7mEqSginF1f8B26VuHJXQ
Date: Tue, 4 Dec 2018 06:19:11 +0000
Message-ID: <AM0PR04MB53148CE406ED8DBFABA5A79B8BAF0@AM0PR04MB5314.eurprd04.prod.outlook.com>
References: <20181202213325.26017-1-u.kleine-koenig@pengutronix.de>
 <20181202213325.26017-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20181202213325.26017-2-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4721;
 6:5EdXEZNxXxWjSuuGMs2lYuAvrAyqo2ysCXBlMK/iynxsmE7oO15JUR1SoDDC6NYvyYaylk2KMh6QWeSfdWzfOxrlL3GiVPCF3zsUK2jzXgu/w8JuBvyhSYO4zcOO+tbYRY3cjxlxHIZbeFukqU2wNDYl04YP+XqOzVQlvrTGvrv8MEOy6kP8wD92FLf6/6v65GUdpbFo++f5cMo4q9XelKE/wzfHhJq2z5neU8g3/RR98nOmHJIFn/O+V+zhHcR9Cz01wrClmWSvhW1vkQdQ0uKd1b+YjmIjO7+Vd1/7a1Nk9+VThOsbXt2LR4yYTBp2vCFyNYkHQjHOePI+w+GySGGylhm7wcEjsu5qqL72WIglE2vaSMR+PnJ/Bq0ZlUzh20D3C3uWWHjN7PgokQEB+XCDMX47pzA59YyKxdXzL4u1I5wqd0iAQkFoVbHzftLqfxqT4yhDLQVdfmPM71Y61w==;
 5:3CfDxV0RyGFbpLrjsl2zCuRC+sRPRP4C+4wnGJWLtUmwzZ6dvEYjDNciadaxjW+c4a0JyAFPObTk999KvdA8FsTXUzTZGiy/0y6mvoPM1ZC2iYJ5NPb0tyzDl1G14pEI3WP8ewO2bNXit0FK/IlxHYibRieqx0WSnA4qO4yplKU=;
 7:sziC5Oqr9J5Ezfb9+gUTwtEJFTMhBbQKdpqnGooUDUvlrh14KGmMxLWNeDRt4Q0JRCgiYSEju6Qu7nrLfO/quYKJUurKQ4FHxb/24H6rOjJL6tfegWnxgI3YTToCguyEirlZpca8EU65kaqJI29w+Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 338f6061-d574-46d1-04f5-08d659b06830
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4721; 
x-ms-traffictypediagnostic: AM0PR04MB4721:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB4721ABFA488B8C1324FE4B2E8BAF0@AM0PR04MB4721.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4721; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4721; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(9686003)(3846002)(6436002)(6506007)(66066001)(97736004)(71200400001)(14454004)(55016002)(102836004)(25786009)(7696005)(71190400001)(74316002)(8936002)(53346004)(99286004)(68736007)(76176011)(26005)(6246003)(53936002)(81166006)(476003)(575784001)(229853002)(81156014)(54906003)(11346002)(110136005)(2906002)(486006)(7736002)(256004)(4326008)(86362001)(8676002)(305945005)(105586002)(316002)(106356001)(6116002)(446003)(186003)(478600001)(5660300001)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4721;
 H:AM0PR04MB5314.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n/eS8MBtEvSGvdrzrtv75PeVd/oVD6BSCDKgBTT1D39dKlnPKNNURwYL15ncEHQs2tz3nmw6PuGRW9ELKsaZEujwFBJE0HBH39b/7TK+rUFH7G9N+Qf7+p0fEG2noQrpv5lVeTxGy+h0MUDq4gWwU5csbj88bncjl390bJele0jFrfY77zNPc67pcO0F4QvRvEK11Iw9wK+f31rtUcQKp2n0lhHCI5/GEhk2pM8lfY5pZrOQy/5YUpHP8J9XTLSrYLYgIDzacJt122Ir9suzgLrYI9kvDQ0goGMdIPJ4paMG+ruTxiKbulaJUKUvLxVZiC9xeRLAovT2It0raTCCZmorWkl2k2kN9DcBUomNgEk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338f6061-d574-46d1-04f5-08d659b06830
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 06:19:11.6107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4721
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_221927_527625_0F079860 
X-CRM114-Status: GOOD (  15.93  )
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
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "mstarr@hedonline.com" <mstarr@hedonline.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBl
bmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfaW14
LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvY2hpcGlkZWEvY2lfaGRyY19pbXguYyBiL2RyaXZlcnMvdXNi
L2NoaXBpZGVhL2NpX2hkcmNfaW14LmMNCj4gaW5kZXggODBiNGU0ZWY5YjY4Li4zZGNmZDBkOTdm
OTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfaW14LmMNCj4g
KysrIGIvZHJpdmVycy91c2IvY2hpcGlkZWEvY2lfaGRyY19pbXguYw0KPiBAQCAtMTQxLDYgKzE0
MSw4IEBAIHN0YXRpYyBzdHJ1Y3QgaW14X3VzYm1pc2NfZGF0YQ0KPiAqdXNibWlzY19nZXRfaW5p
dF9kYXRhKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAl9IGVsc2UgaWYgKG9mX2ZpbmRfcHJvcGVy
dHkobnAsICJvdmVyLWN1cnJlbnQtYWN0aXZlLWxvdyIsIE5VTEwpKSB7DQo+ICAJCWRhdGEtPm9j
X3BvbF9hY3RpdmVfbG93ID0gMTsNCj4gIAkJZGF0YS0+b2NfcG9sX2NvbmZpZ3VyZWQgPSAxOw0K
PiArCX0gZWxzZSB7DQo+ICsJCWRldl93YXJuKGRldiwgIk5vIG92ZXIgY3VycmVudCBwb2xhcml0
eSBkZWZpbmVkXG4iKTsNCj4gIAl9DQoNCklmIHRoZSBwbGF0Zm9ybSBkb2Vzbid0IHN1cHBvcnQg
T0MsIHRoZSBwb2xhcml0eSBzZXR0aW5nIGlzIG5vdCBuZWVkZWQuIFlvdSBjb3VsZCBjb25zaWRl
cg0KZ2V0dGluZyBwb2xhcml0eSBwcm9wZXJ0eSBvbmx5ICJkaXNhYmxlLW92ZXItY3VycmVudCIg
aXMgbm90IGZvdW5kIGF0IHBhdGNoIDEuDQoNClBldGVyDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
