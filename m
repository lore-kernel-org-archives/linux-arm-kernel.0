Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7784CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:10:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3E02082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F5HTI+AD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O7PVf2O/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3E02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JWPFtOlThwL3wGe21A2NOsCFE3mqCZ0dbZvmHd7KVm8=; b=F5HTI+AD/zmB7y
	ugq9DLJkKJolgbYYKoNQOGzvl6kWjEOg94kOCn4f0+FNeJl6mNEOLFhaLFneKzrCeX8L/pi/0kHyq
	Xpep87ouSAUfFmTj0UZUQ80/UfKyQ4wEfmx6DrwKRuWBdwHvTTlqQQndsBxxUOJtVnQvw1geRO4pi
	3bis1lRa6s9TXH+H3yWCv0/CuTinmehyO94n9/Rcj5UcywFbaDrQcZS5xI0JNWYOY90yolSXre5Rs
	sL26rmVQUSVKCgCfc7VDLHuDcdniYop/7F8Y56NLn0VTPBQo7l2CVcUenVX2Uq5HV831Nmp0lJ35H
	Z9aVBigB5Yj8lSQlo0Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjJ5-0002Ft-Kk; Mon, 03 Dec 2018 08:10:19 +0000
Received: from mail-db5eur01on0600.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::600]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjJ2-0000ui-55
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e66naGUxrdEvnlgnqVJJvjVjG9S8KqGXunnEBROFNCQ=;
 b=O7PVf2O/Vr/ZCrBKCiXkGrBqlqEleY5rs0vCwRKRPXsL1mEkRxkfI7QwF2OiXcylt1Sg19Vdi57+JOmmG/MgkXiIpGunarXBk+Whfb+/vhS9hut/6kKfWUlAQXc7wYSdp4FBVzadeTeTSXWqq+WJyidD3X4/uVSo2OrxSXNh/4M=
Received: from AM0PR04MB4532.eurprd04.prod.outlook.com (52.135.148.158) by
 AM0PR04MB4003.eurprd04.prod.outlook.com (52.134.90.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Mon, 3 Dec 2018 08:09:59 +0000
Received: from AM0PR04MB4532.eurprd04.prod.outlook.com
 ([fe80::8c48:f19b:f69:5f18]) by AM0PR04MB4532.eurprd04.prod.outlook.com
 ([fe80::8c48:f19b:f69:5f18%3]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:09:59 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
 Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH v3 4/5] spi: imx: rename config callback and add useful
 parameters
Thread-Topic: [PATCH v3 4/5] spi: imx: rename config callback and add useful
 parameters
Thread-Index: AQHUiHiaAWQFqS9rMkWv/MgdcllrMKVsq6eQ
Date: Mon, 3 Dec 2018 08:09:59 +0000
Message-ID: <AM0PR04MB4532047E26FD6FC62193A11689AE0@AM0PR04MB4532.eurprd04.prod.outlook.com>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-5-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20181130064709.6998-5-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4003;
 6:5kYrDY2SanvrMIcyJYT+UPgFvgFNU8mggAsGW7OfY8zeztN1PgCrlLk/aAgikIOBers9uwVpo/i7xYl85a4LRZalPs2DYGEbNToA12B87VhSdmw1UbfIUeEseP4WckBTRCMvw2/jrez5ovPCogGjZYyEtc4IzCffCWq5DCETpg1subUX4KCQ3suZldB9hbxUxzu/1JEQjNnpeR7FJn2qmGcb9v43rJgL3nH5OfAToHOYlTpTXDKMLZIM39ULu+OxnSOmHenpdgJxDtCWjGNJNla+oVdN9lNm71e1Lq2Be5dDUxDOvb+L8ExZG6XqMFs9gd5kGlTcB5o17sbFZ86cx2EJjRsBxByvAWz2cNxqkTQokXLp4YTdwd7FPNPYSmdeT+2MdIAW3tneHHPwUf7a0AN781zzQa+FnpJiJmCdxvKOPzwv/rIfA1SRonqBDGTicUo8V1OD9QeF2Kdp9bf8cw==;
 5:NZ/iNDR2TybZgt4NFZQ8RAOha8wH0C4+tyqecJj2V6eqJZTAJcCXzaFP2Z0Vicjjm4eL672uyGij8gf9TPyCMdIptvSd4e46nwatI24v1OoeppsdvvP5i2U6fCRbT5CEEaNOmI4YykbhibY7La0FJZNV01BUFt50JXvf4EUxBhg=;
 7:ExDb8Oxzm2gnlITVSYGj9+8HusOb3RFvLvdNmV6+2kjl52kNQiTo2mncwg4QTkjvHBbxZ53HSZN0/iZvL7s50SGRC5mnkkVhZXOqet+vzMpqGVFhHTVO9BopTJpcIWCkXMPwTsezcFMwsWwcpWfy5w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cbe2e42f-b401-4de8-64fa-08d658f6b83c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4003; 
x-ms-traffictypediagnostic: AM0PR04MB4003:
x-microsoft-antispam-prvs: <AM0PR04MB400315C83B5C22FE239FD66689AE0@AM0PR04MB4003.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4003; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4003; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(13464003)(256004)(186003)(25786009)(76176011)(97736004)(26005)(478600001)(7696005)(6116002)(102836004)(486006)(86362001)(81156014)(8676002)(81166006)(6436002)(4326008)(316002)(6506007)(3846002)(8936002)(53936002)(6246003)(446003)(33656002)(476003)(229853002)(11346002)(9686003)(99286004)(7736002)(5660300001)(2906002)(55016002)(68736007)(105586002)(66066001)(110136005)(54906003)(14454004)(106356001)(305945005)(74316002)(53546011)(71190400001)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4003;
 H:AM0PR04MB4532.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YfTR/L+X1JAC3Fj3LLlxDXlKGnGUZP1bQdjmCX4VNhFXF1I3NCzezloORXPtykScEn9qG3qUO2xT7JnemquP9CBGIIwCzeU5pHEzK4/hafpPlxaO7dWdrUTpBRQXxr5fDYKpr18QIzk1kHnoG5bzok20dChwXZkl+odxhk1ukW9FqIGfqVWlfjadfZGgg2OR2iTKjyTZIKm6PC2Q3Lul8nvIemW/4rLDFTAN1U9luJI6XH3WRGPTfAIg+5k8IlmPUKK734YXrTCZLw1MJ2OMfU4LEYmykiHlTNmuM+yuPH2EasSbbFGoTuf3cEedS1l5/N3q5na2oTsYNwWpyu07bpDBWzm8WKuLUnFpYkWeQAo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe2e42f-b401-4de8-64fa-08d658f6b83c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:09:59.4187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4003
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_001016_473839_DDDEA742 
X-CRM114-Status: GOOD (  22.59  )
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
Cc: Marek Vasut <marex@denx.de>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAxOOW5tDEx5pyI
MzDml6UgMTQ6NDcNCj4gVG86IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IFJvYmlu
IEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54
LmRlPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2MyA0LzVdIHNwaTogaW14OiBy
ZW5hbWUgY29uZmlnIGNhbGxiYWNrIGFuZCBhZGQgdXNlZnVsDQo+IHBhcmFtZXRlcnMNCj4gDQo+
IFRoZSBjb25maWcgY2FsbGJhY2sgaXMgY2FsbGVkIG9uY2UgcGVyIHRyYW5zZmVyIHdoaWxlIHNv
bWUgdGhpbmdzIGNhbiAoYW5kDQo+IHNob3VsZCkgYmUgZG9uZSBvbiBhIHBlciBtZXNzYWdlIG1h
bm5lci4gVG8gaGF2ZSB1bmFtYmlndW91cyBuYW1pbmcgaW4gdGhlDQo+IGVuZCBpbmNsdWRlICJ0
cmFuc2ZlciIgaW4gdGhlIGNhbGxiYWNrJ3MgbmFtZSBhbmQgcmVuYW1lIHRoZSBpbXBsZW1lbnRh
dGlvbnMNCj4gYWNjb3JkaW5nbHkuIEFsc28gcGFzcyB0aGUgZHJpdmVyIHN0cnVjdCBhbmQgdHJh
bnNmZXIgd2hpY2ggYWxsb3dzIGZ1cnRoZXINCj4gc2ltcGxpZmljYXRpb25zIGluIHRoZSBmb2xs
b3dpbmcgcGF0Y2guDQo+IA0KPiBUaGVyZSBpcyBubyBjaGFuZ2UgaW4gYmVoYXZpb3IgaW50ZW5k
ZWQgaGVyZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4N
Cj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5n
dXRyb25peC5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NwaS9zcGktaW14LmMgfCAzOSArKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3NwaS9zcGktaW14LmMgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMgaW5kZXgNCj4gZDk1NGI2ZDk1
OGMyLi43MmM4NzkyMjZhYmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1pbXguYw0K
PiArKysgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMNCj4gQEAgLTYwLDcgKzYwLDggQEAgc3RydWN0
IHNwaV9pbXhfZGF0YTsNCj4gIHN0cnVjdCBzcGlfaW14X2RldnR5cGVfZGF0YSB7DQo+ICAJdm9p
ZCAoKmludGN0cmwpKHN0cnVjdCBzcGlfaW14X2RhdGEgKiwgaW50KTsNCj4gIAlpbnQgKCpwcmVw
YXJlX21lc3NhZ2UpKHN0cnVjdCBzcGlfaW14X2RhdGEgKiwgc3RydWN0IHNwaV9tZXNzYWdlICop
Ow0KPiAtCWludCAoKmNvbmZpZykoc3RydWN0IHNwaV9kZXZpY2UgKik7DQo+ICsJaW50ICgqcHJl
cGFyZV90cmFuc2Zlcikoc3RydWN0IHNwaV9pbXhfZGF0YSAqLCBzdHJ1Y3Qgc3BpX2RldmljZSAq
LA0KPiArCQkJCXN0cnVjdCBzcGlfdHJhbnNmZXIgKik7DQo+ICAJdm9pZCAoKnRyaWdnZXIpKHN0
cnVjdCBzcGlfaW14X2RhdGEgKik7DQo+ICAJaW50ICgqcnhfYXZhaWxhYmxlKShzdHJ1Y3Qgc3Bp
X2lteF9kYXRhICopOw0KPiAgCXZvaWQgKCpyZXNldCkoc3RydWN0IHNwaV9pbXhfZGF0YSAqKTsN
Cj4gQEAgLTU1Niw5ICs1NTcsMTAgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3ByZXBhcmVfbWVz
c2FnZShzdHJ1Y3QNCj4gc3BpX2lteF9kYXRhICpzcGlfaW14LA0KPiAgCXJldHVybiAwOw0KPiAg
fQ0KPiANCj4gLXN0YXRpYyBpbnQgbXg1MV9lY3NwaV9jb25maWcoc3RydWN0IHNwaV9kZXZpY2Ug
KnNwaSkNCj4gK3N0YXRpYyBpbnQgbXg1MV9lY3NwaV9wcmVwYXJlX3RyYW5zZmVyKHN0cnVjdCBz
cGlfaW14X2RhdGEgKnNwaV9pbXgsDQo+ICsJCQkJICAgICAgIHN0cnVjdCBzcGlfZGV2aWNlICpz
cGksDQo+ICsJCQkJICAgICAgIHN0cnVjdCBzcGlfdHJhbnNmZXIgKnQpDQo+ICB7DQo+IC0Jc3Ry
dWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoc3BpLT5t
YXN0ZXIpOw0KU2luY2Ugc3BpX2lteCBjb3VsZCBiZSBnZXQgZnJvbSBzcGkgYXMgYmVmb3JlLCB3
aHkgbm90IHJlbW92ZSB0aGUgcGFyYW1ldGVyICpzcGlfaW14IGZvcg0KcHJlcGFyZV90cmFuc2Zl
cigpIGZ1bmN0aW9uPw0KPiAgCXUzMiBjdHJsID0gcmVhZGwoc3BpX2lteC0+YmFzZSArIE1YNTFf
RUNTUElfQ1RSTCk7DQo+ICAJdTMyIGNsayA9IHNwaV9pbXgtPnNwZWVkX2h6LCBkZWxheTsNCj4g
DQo+IEBAIC02ODUsOSArNjg3LDEwIEBAIHN0YXRpYyBpbnQgbXgzMV9wcmVwYXJlX21lc3NhZ2Uo
c3RydWN0DQo+IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
DQo+IC1zdGF0aWMgaW50IG14MzFfY29uZmlnKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICtz
dGF0aWMgaW50IG14MzFfcHJlcGFyZV90cmFuc2ZlcihzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlf
aW14LA0KPiArCQkJCSBzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLA0KPiArCQkJCSBzdHJ1Y3Qgc3Bp
X3RyYW5zZmVyICp0KQ0KPiAgew0KPiAtCXN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXggPSBz
cGlfbWFzdGVyX2dldF9kZXZkYXRhKHNwaS0+bWFzdGVyKTsNCj4gIAl1bnNpZ25lZCBpbnQgcmVn
ID0gTVgzMV9DU1BJQ1RSTF9FTkFCTEUgfCBNWDMxX0NTUElDVFJMX01BU1RFUjsNCj4gIAl1bnNp
Z25lZCBpbnQgY2xrOw0KPiANCj4gQEAgLTc4OSw5ICs3OTIsMTAgQEAgc3RhdGljIGludCBteDIx
X3ByZXBhcmVfbWVzc2FnZShzdHJ1Y3QNCj4gc3BpX2lteF9kYXRhICpzcGlfaW14LA0KPiAgCXJl
dHVybiAwOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyBpbnQgbXgyMV9jb25maWcoc3RydWN0IHNwaV9k
ZXZpY2UgKnNwaSkNCj4gK3N0YXRpYyBpbnQgbXgyMV9wcmVwYXJlX3RyYW5zZmVyKHN0cnVjdCBz
cGlfaW14X2RhdGEgKnNwaV9pbXgsDQo+ICsJCQkJIHN0cnVjdCBzcGlfZGV2aWNlICpzcGksDQo+
ICsJCQkJIHN0cnVjdCBzcGlfdHJhbnNmZXIgKnQpDQo+ICB7DQo+IC0Jc3RydWN0IHNwaV9pbXhf
ZGF0YSAqc3BpX2lteCA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoc3BpLT5tYXN0ZXIpOw0KPiAg
CXVuc2lnbmVkIGludCByZWcgPSBNWDIxX0NTUElDVFJMX0VOQUJMRSB8IE1YMjFfQ1NQSUNUUkxf
TUFTVEVSOw0KPiAgCXVuc2lnbmVkIGludCBtYXggPSBpc19pbXgyN19jc3BpKHNwaV9pbXgpID8g
MTYgOiAxODsNCj4gIAl1bnNpZ25lZCBpbnQgY2xrOw0KPiBAQCAtODY0LDkgKzg2OCwxMCBAQCBz
dGF0aWMgaW50IG14MV9wcmVwYXJlX21lc3NhZ2Uoc3RydWN0DQo+IHNwaV9pbXhfZGF0YSAqc3Bp
X2lteCwNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgaW50IG14MV9jb25maWco
c3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gK3N0YXRpYyBpbnQgbXgxX3ByZXBhcmVfdHJhbnNm
ZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwNCj4gKwkJCQlzdHJ1Y3Qgc3BpX2Rldmlj
ZSAqc3BpLA0KPiArCQkJCXN0cnVjdCBzcGlfdHJhbnNmZXIgKnQpDQo+ICB7DQo+IC0Jc3RydWN0
IHNwaV9pbXhfZGF0YSAqc3BpX2lteCA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoc3BpLT5tYXN0
ZXIpOw0KPiAgCXVuc2lnbmVkIGludCByZWcgPSBNWDFfQ1NQSUNUUkxfRU5BQkxFIHwgTVgxX0NT
UElDVFJMX01BU1RFUjsNCj4gIAl1bnNpZ25lZCBpbnQgY2xrOw0KPiANCj4gQEAgLTg5OSw3ICs5
MDQsNyBAQCBzdGF0aWMgdm9pZCBteDFfcmVzZXQoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lt
eCkNCj4gc3RhdGljIHN0cnVjdCBzcGlfaW14X2RldnR5cGVfZGF0YSBpbXgxX2NzcGlfZGV2dHlw
ZV9kYXRhID0gew0KPiAgCS5pbnRjdHJsID0gbXgxX2ludGN0cmwsDQo+ICAJLnByZXBhcmVfbWVz
c2FnZSA9IG14MV9wcmVwYXJlX21lc3NhZ2UsDQo+IC0JLmNvbmZpZyA9IG14MV9jb25maWcsDQo+
ICsJLnByZXBhcmVfdHJhbnNmZXIgPSBteDFfcHJlcGFyZV90cmFuc2ZlciwNCj4gIAkudHJpZ2dl
ciA9IG14MV90cmlnZ2VyLA0KPiAgCS5yeF9hdmFpbGFibGUgPSBteDFfcnhfYXZhaWxhYmxlLA0K
PiAgCS5yZXNldCA9IG14MV9yZXNldCwNCj4gQEAgLTkxMyw3ICs5MTgsNyBAQCBzdGF0aWMgc3Ry
dWN0IHNwaV9pbXhfZGV2dHlwZV9kYXRhDQo+IGlteDFfY3NwaV9kZXZ0eXBlX2RhdGEgPSB7ICBz
dGF0aWMgc3RydWN0IHNwaV9pbXhfZGV2dHlwZV9kYXRhDQo+IGlteDIxX2NzcGlfZGV2dHlwZV9k
YXRhID0gew0KPiAgCS5pbnRjdHJsID0gbXgyMV9pbnRjdHJsLA0KPiAgCS5wcmVwYXJlX21lc3Nh
Z2UgPSBteDIxX3ByZXBhcmVfbWVzc2FnZSwNCj4gLQkuY29uZmlnID0gbXgyMV9jb25maWcsDQo+
ICsJLnByZXBhcmVfdHJhbnNmZXIgPSBteDIxX3ByZXBhcmVfdHJhbnNmZXIsDQo+ICAJLnRyaWdn
ZXIgPSBteDIxX3RyaWdnZXIsDQo+ICAJLnJ4X2F2YWlsYWJsZSA9IG14MjFfcnhfYXZhaWxhYmxl
LA0KPiAgCS5yZXNldCA9IG14MjFfcmVzZXQsDQo+IEBAIC05MjgsNyArOTMzLDcgQEAgc3RhdGlj
IHN0cnVjdCBzcGlfaW14X2RldnR5cGVfZGF0YQ0KPiBpbXgyN19jc3BpX2RldnR5cGVfZGF0YSA9
IHsNCj4gIAkvKiBpLm14MjcgY3NwaSBzaGFyZXMgdGhlIGZ1bmN0aW9ucyB3aXRoIGkubXgyMSBv
bmUgKi8NCj4gIAkuaW50Y3RybCA9IG14MjFfaW50Y3RybCwNCj4gIAkucHJlcGFyZV9tZXNzYWdl
ID0gbXgyMV9wcmVwYXJlX21lc3NhZ2UsDQo+IC0JLmNvbmZpZyA9IG14MjFfY29uZmlnLA0KPiAr
CS5wcmVwYXJlX3RyYW5zZmVyID0gbXgyMV9wcmVwYXJlX3RyYW5zZmVyLA0KPiAgCS50cmlnZ2Vy
ID0gbXgyMV90cmlnZ2VyLA0KPiAgCS5yeF9hdmFpbGFibGUgPSBteDIxX3J4X2F2YWlsYWJsZSwN
Cj4gIAkucmVzZXQgPSBteDIxX3Jlc2V0LA0KPiBAQCAtOTQyLDcgKzk0Nyw3IEBAIHN0YXRpYyBz
dHJ1Y3Qgc3BpX2lteF9kZXZ0eXBlX2RhdGENCj4gaW14MjdfY3NwaV9kZXZ0eXBlX2RhdGEgPSB7
ICBzdGF0aWMgc3RydWN0IHNwaV9pbXhfZGV2dHlwZV9kYXRhDQo+IGlteDMxX2NzcGlfZGV2dHlw
ZV9kYXRhID0gew0KPiAgCS5pbnRjdHJsID0gbXgzMV9pbnRjdHJsLA0KPiAgCS5wcmVwYXJlX21l
c3NhZ2UgPSBteDMxX3ByZXBhcmVfbWVzc2FnZSwNCj4gLQkuY29uZmlnID0gbXgzMV9jb25maWcs
DQo+ICsJLnByZXBhcmVfdHJhbnNmZXIgPSBteDMxX3ByZXBhcmVfdHJhbnNmZXIsDQo+ICAJLnRy
aWdnZXIgPSBteDMxX3RyaWdnZXIsDQo+ICAJLnJ4X2F2YWlsYWJsZSA9IG14MzFfcnhfYXZhaWxh
YmxlLA0KPiAgCS5yZXNldCA9IG14MzFfcmVzZXQsDQo+IEBAIC05NTcsNyArOTYyLDcgQEAgc3Rh
dGljIHN0cnVjdCBzcGlfaW14X2RldnR5cGVfZGF0YQ0KPiBpbXgzNV9jc3BpX2RldnR5cGVfZGF0
YSA9IHsNCj4gIAkvKiBpLm14MzUgYW5kIGxhdGVyIGNzcGkgc2hhcmVzIHRoZSBmdW5jdGlvbnMg
d2l0aCBpLm14MzEgb25lICovDQo+ICAJLmludGN0cmwgPSBteDMxX2ludGN0cmwsDQo+ICAJLnBy
ZXBhcmVfbWVzc2FnZSA9IG14MzFfcHJlcGFyZV9tZXNzYWdlLA0KPiAtCS5jb25maWcgPSBteDMx
X2NvbmZpZywNCj4gKwkucHJlcGFyZV90cmFuc2ZlciA9IG14MzFfcHJlcGFyZV90cmFuc2ZlciwN
Cj4gIAkudHJpZ2dlciA9IG14MzFfdHJpZ2dlciwNCj4gIAkucnhfYXZhaWxhYmxlID0gbXgzMV9y
eF9hdmFpbGFibGUsDQo+ICAJLnJlc2V0ID0gbXgzMV9yZXNldCwNCj4gQEAgLTk3MSw3ICs5NzYs
NyBAQCBzdGF0aWMgc3RydWN0IHNwaV9pbXhfZGV2dHlwZV9kYXRhDQo+IGlteDM1X2NzcGlfZGV2
dHlwZV9kYXRhID0geyAgc3RhdGljIHN0cnVjdCBzcGlfaW14X2RldnR5cGVfZGF0YQ0KPiBpbXg1
MV9lY3NwaV9kZXZ0eXBlX2RhdGEgPSB7DQo+ICAJLmludGN0cmwgPSBteDUxX2Vjc3BpX2ludGN0
cmwsDQo+ICAJLnByZXBhcmVfbWVzc2FnZSA9IG14NTFfZWNzcGlfcHJlcGFyZV9tZXNzYWdlLA0K
PiAtCS5jb25maWcgPSBteDUxX2Vjc3BpX2NvbmZpZywNCj4gKwkucHJlcGFyZV90cmFuc2ZlciA9
IG14NTFfZWNzcGlfcHJlcGFyZV90cmFuc2ZlciwNCj4gIAkudHJpZ2dlciA9IG14NTFfZWNzcGlf
dHJpZ2dlciwNCj4gIAkucnhfYXZhaWxhYmxlID0gbXg1MV9lY3NwaV9yeF9hdmFpbGFibGUsDQo+
ICAJLnJlc2V0ID0gbXg1MV9lY3NwaV9yZXNldCwNCj4gQEAgLTk4Nyw3ICs5OTIsNyBAQCBzdGF0
aWMgc3RydWN0IHNwaV9pbXhfZGV2dHlwZV9kYXRhDQo+IGlteDUxX2Vjc3BpX2RldnR5cGVfZGF0
YSA9IHsgIHN0YXRpYyBzdHJ1Y3Qgc3BpX2lteF9kZXZ0eXBlX2RhdGENCj4gaW14NTNfZWNzcGlf
ZGV2dHlwZV9kYXRhID0gew0KPiAgCS5pbnRjdHJsID0gbXg1MV9lY3NwaV9pbnRjdHJsLA0KPiAg
CS5wcmVwYXJlX21lc3NhZ2UgPSBteDUxX2Vjc3BpX3ByZXBhcmVfbWVzc2FnZSwNCj4gLQkuY29u
ZmlnID0gbXg1MV9lY3NwaV9jb25maWcsDQo+ICsJLnByZXBhcmVfdHJhbnNmZXIgPSBteDUxX2Vj
c3BpX3ByZXBhcmVfdHJhbnNmZXIsDQo+ICAJLnRyaWdnZXIgPSBteDUxX2Vjc3BpX3RyaWdnZXIs
DQo+ICAJLnJ4X2F2YWlsYWJsZSA9IG14NTFfZWNzcGlfcnhfYXZhaWxhYmxlLA0KPiAgCS5yZXNl
dCA9IG14NTFfZWNzcGlfcmVzZXQsDQo+IEBAIC0xMjMwLDcgKzEyMzUsNyBAQCBzdGF0aWMgaW50
IHNwaV9pbXhfc2V0dXB4ZmVyKHN0cnVjdCBzcGlfZGV2aWNlICpzcGksDQo+ICAJCXNwaV9pbXgt
PnNsYXZlX2J1cnN0ID0gdC0+bGVuOw0KPiAgCX0NCj4gDQo+IC0Jc3BpX2lteC0+ZGV2dHlwZV9k
YXRhLT5jb25maWcoc3BpKTsNCj4gKwlzcGlfaW14LT5kZXZ0eXBlX2RhdGEtPnByZXBhcmVfdHJh
bnNmZXIoc3BpX2lteCwgc3BpLCB0KTsNCj4gDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IC0tDQo+
IDIuMTkuMg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
