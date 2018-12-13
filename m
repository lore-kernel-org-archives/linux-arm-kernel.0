Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E64FC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:24:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC0F20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gWtRACq9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AfR6TF6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC0F20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZkX2pbskWqUuK+6OCJENdD1JkSdT0qIINAs2Dz2+QEM=; b=gWtRACq9q+/69k
	HI2X1Elo9QXyH4UHYnXNRskaszPL408IVtEHUUEpPfqiFA8Hxq0jp+nnobUwai1WNswHiM+sA4Vo7
	CfWF/4oJnOzVeFeIx2sMk/kFqRFb2xx0VLS+EW+JSTY98/gX3fKIeQYCc99yN1GnNnK0nqVIlVtbR
	iRXDTojsMBvS1kKHO/U7O/mpzTkl+9Wo2PREkoG1Q7mS5ynUf9kmN59DRHqRQYhCl+TmiDCAF8v79
	QxIs5BnuViU6YPy4/IgkR6sW3yA4QKagAUmePlgGp6u4jRh5zoSHGDi0APvmD4kSrIVQ2GNj2GIgw
	6HRdKSBkSFDtq+q17ewQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXMI2-0004bp-6y; Thu, 13 Dec 2018 08:24:14 +0000
Received: from mail-am5eur03on061f.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::61f]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXMHx-0004aT-QT
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 08:24:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdVzmFRsLBSGoFxJY2TJLeQXwRaCZg+Qsbp5Upy0zlE=;
 b=AfR6TF6LNVv57jM0UbVXBaJx4UQKSXSxo0WpZuEePjBJvIsZF51QPh419r7w2Jmw50zjvSP6xM5F/4+pqEgFpvDEW9s0DCF1/8+2x4Ffe+iBHGjqeyCVxBsf4tGWtcJzBRGdC9Ed44/LuzwFHrDCdX+WKm1uLrIyUVrXZJBFSRM=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3508.eurprd04.prod.outlook.com (52.133.45.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 08:23:52 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 08:23:52 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: RE: [v2] PCI: imx: make msi work without pcieportbus
Thread-Topic: [v2] PCI: imx: make msi work without pcieportbus
Thread-Index: AQHUkron3jfJ309qkk6cQky/juy8waV8UcQAgAABmoA=
Date: Thu, 13 Dec 2018 08:23:52 +0000
Message-ID: <AM0PR0402MB357061ADF5FAFD253C1A5B8A8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
 <87zht96e15.fsf@tkos.co.il>
In-Reply-To: <87zht96e15.fsf@tkos.co.il>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR0402MB3508;
 6:HpcwGl8uPgbrL4FpoPTsXwkO6IdBLb2SExwGk4HYsfOc5/Ab7+srOqONBnz8TGdW+TsfoKFnE8Xo34VJouF6L5JS0/MRzPwrhgxINMFPbbJ/wm1RssUSpQaJX2f9OGhvkE0vZWOgcuxViaej4Sl3DhEmjLc6nLJ9fStJHS4WgjnymMgBFUf/mUbIKYRjeCIilBDoNp7SqmPlpDIYMNygXlHaQ6mfUsznVhIDO1uk6WHnHReZVCiaCcWKfVIwI3fGo4PtRCeLYSAFly1wQFgkyKk+FZ7VR+9cnHbYNov9Gm7Z+a+jRIzodftIzzuJSLmOiN5uuAfwQ8lqnC63yqG93g/0X/3ET3QFVK45+Tr8cIPDilM8NKbwsv7rzVccsFrsl7lDcYz6WoLSpwMLcyjrpuv6IFTwFW6vOVnV2Rwbps6Y90wmV92n68fZikwJ8sI3wwKMQVAddwJ1X60AIjXYbA==;
 5:lyBws3t3jDdbIjBguPS6W3vkVEUpNhXo/XuPn+jKVmwDa+e1cwHJtcCLE5/xObtPGMIY7/rSqVG/GB1YiDlkwHgKt7NV+xJCx4N3j98HYLFkTAeAXXKfzEpP+UrFE6qj/c/fGgOW5DmHk50elyBCI8OA8Gd07CVYF+AvbpYXEaA=;
 7:Noq1NqBS0pCtYIo5NAT9KlmO/0mmhF1bpYVhWdOjWCBlD8Qy+sRARIDjEYHu2mCNKbO07Q9NC1rS+H0Mi7ea3algoeCaNrbTgLvCUtuKijHNZ4gbiV5c5bTtUXZLrapaglakDqTLtiS2b6KPY6yE8g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b63298cc-d6c7-4d11-b25c-08d660d450a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR0402MB3508; 
x-ms-traffictypediagnostic: AM0PR0402MB3508:
x-microsoft-antispam-prvs: <AM0PR0402MB35089885D83BCC3C08C29B5C8CA00@AM0PR0402MB3508.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231475)(944501520)(4982022)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR0402MB3508; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3508; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(13464003)(11346002)(966005)(446003)(6506007)(229853002)(186003)(66066001)(14454004)(102836004)(6436002)(53546011)(26005)(76176011)(476003)(6916009)(45080400002)(7696005)(256004)(486006)(71190400001)(71200400001)(25786009)(14444005)(99286004)(97736004)(8936002)(5660300001)(54906003)(33656002)(4326008)(305945005)(81156014)(8676002)(575784001)(86362001)(478600001)(39060400002)(74316002)(68736007)(3846002)(2906002)(9686003)(6246003)(106356001)(6116002)(6306002)(7736002)(105586002)(53936002)(81166006)(316002)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3508;
 H:AM0PR0402MB3570.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mIQ6xs+ld5crUyPuCkQc69fW4jIc1c/iraumN1rgJYvnOxNYnZoqxemWtu9epe/Z2nsY2qJRSdfwFAWpnstnMkx7gfDt9FQFZqEEtHwZwv7S7/U2N5mW5RIo8SRRsIbqOhl1mDGVrj+RFcOmNUNOdXSKDoSYx0RAziigqAMUFaJzIaUWv6TP6OynwzfvCikh5Z7nOc0lsKV9wnJ347fmQAJRzZX+OdTmnGjbqeXZg0F9Ipfyk4ss8SkPE69bDKGiAvBUoeOsM2Bji3Wjz5MulvFXQghXcxGe9ApMbzzG15a7hXuOHUYlodaIEET/muMW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63298cc-d6c7-4d11-b25c-08d660d450a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 08:23:52.0721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3508
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_002409_861393_7EF01A5B 
X-CRM114-Status: GOOD (  23.39  )
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
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFydWNoIFNpYWNoIFtt
YWlsdG86YmFydWNoQHRrb3MuY28uaWxdDQo+IFNlbnQ6IDIwMTjE6jEy1MIxM8jVIDE2OjEzDQo+
IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBiaGVsZ2Fhc0Bn
b29nbGUuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiBsLnN0YWNoQHBlbmd1dHJv
bml4LmRlOyBhbmRyZXcuc21pcm5vdkBnbWFpbC5jb207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW3YyXSBQQ0k6IGlteDogbWFrZSBt
c2kgd29yayB3aXRob3V0IHBjaWVwb3J0YnVzDQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gT25l
IG1vcmUgY29tbWVudCB0aGF0IG9jY3VycmVkIHRvIG1lIG9ubHkgbm93Lg0KPiANCj4gUmljaGFy
ZCBaaHUgd3JpdGVzOg0KPiA+IE1TSV9FTiBvZiBpTVggUENJZSBSQyB3b3VsZCBiZSBhc3NlcnRl
ZCB3aGVuIFBDSUVQT1JUQlVTIGRyaXZlciBpcw0KPiA+IHNlbGVjdGVkLg0KPiA+IFRodXMsIHRo
ZSBNU0kgd29ya3MgZmluZSBvbiBpTVggUENJZSBiZWZvcmUuDQo+ID4gQXNzZXJ0IGl0IHVuY29u
ZGl0aW9uYWxseSB3aGVuIE1TSSBpcyBzdXBwb3J0ZWQuDQo+ID4gT3RoZXJ3aXNlLCB0aGUgTVNJ
IHdvdWxkbid0IGJlIHRyaWdnZXJlZCBhbHRob3VnaCB0aGUgRVAgaXMgcHJlc2VudA0KPiA+IGFu
ZCB0aGUgTVNJcyBhcmUgYXNzaWduZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMNCj4gPiBpbmRleCAyNjA4N2IzLi5kM2U0Mjk2IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTc0LDYgKzc0LDcgQEAgc3RydWN0
IGlteDZfcGNpZSB7DQo+ID4gICNkZWZpbmUgUEhZX1BMTF9MT0NLX1dBSVRfVVNMRUVQX01BWAky
MDANCj4gPg0KPiA+ICAvKiBQQ0llIFJvb3QgQ29tcGxleCByZWdpc3RlcnMgKG1lbW9yeS1tYXBw
ZWQpICovDQo+ID4gKyNkZWZpbmUgUENJX01TSV9DQVAJCQkJMHg1MA0KPiA+ICAjZGVmaW5lIFBD
SUVfUkNfTENSCQkJCTB4N2MNCj4gPiAgI2RlZmluZSBQQ0lFX1JDX0xDUl9NQVhfTElOS19TUEVF
RFNfR0VOMQkweDENCj4gPiAgI2RlZmluZSBQQ0lFX1JDX0xDUl9NQVhfTElOS19TUEVFRFNfR0VO
MgkweDINCj4gPiBAQCAtOTI2LDYgKzkyNyw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2Ug
KmRiaV9iYXNlOw0KPiA+ICAJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2Rl
Ow0KPiA+ICAJaW50IHJldDsNCj4gPiArCXUxNiB2YWw7DQo+ID4NCj4gPiAgCWlteDZfcGNpZSA9
IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqaW14Nl9wY2llKSwgR0ZQX0tFUk5FTCk7DQo+ID4g
IAlpZiAoIWlteDZfcGNpZSkNCj4gPiBAQCAtMTA3MCw2ICsxMDcyLDExIEBAIHN0YXRpYyBpbnQg
aW14Nl9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAly
ZXQgPSBpbXg2X2FkZF9wY2llX3BvcnQoaW14Nl9wY2llLCBwZGV2KTsNCj4gPiAgCWlmIChyZXQg
PCAwKQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfUENJ
X01TSSkpIHsNCj4gDQo+IENPTkZJR19QQ0lfSU1YNiBkZXBlbmRzIG9uIENPTkZJR19QQ0lfTVNJ
X0lSUV9ET01BSU4gdGhhdCBpbiB0dXJuDQo+IGRlcGVuZHMgb24gQ09ORklHX1BDSV9NU0kuIFNv
IHRoaXMgY29uZGl0aW9uIHNob3VsZCBhbHdheXMgYmUgdHJ1ZS4gSWYgc28sDQo+IHlvdSBjYW4g
ZHJvcCB0aGlzIG9uZSBhcyB3ZWxsLg0KW1JpY2hhcmQgWmh1XSBUaGFua3MuDQpDYW4gd2UgaGF2
ZSB0aGUgZG91YmxlIGNoZWNrIGhlcmU/DQpUaHVzLCBpdCdzIGFsaWduZWQgdG8gdGhlIE1TSSBl
bmFibGUgY29kZXMgaW4gdGhlIG90aGVyIHBsYWNlIG9mIHRoZSBkcml2ZXIuDQpGb3IgZXhhbXBs
ZToNCi4uLg0KCSAgICAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX1BDSV9NU0kpKQ0KICAgICAg
ICAgICAgICAgIGR3X3BjaWVfbXNpX2luaXQocHApOw0KLi4uDQpTZWNvbmRseSwgdGhlIGRyaXZl
ciBoYXMgYSBiZXR0ZXIgcG9ydGFiaWxpdHkgd2l0aCB0aGUgZG91YmxlIGNoZWNrIGhlcmUuDQpI
b3cgZG8geW91IHRoaW5rIGFib3V0IGl0Pw0KDQo+IA0KPiA+ICsJCXZhbCA9IGR3X3BjaWVfcmVh
ZHdfZGJpKHBjaSwgUENJX01TSV9DQVAgKyBQQ0lfTVNJX0ZMQUdTKTsNCj4gPiArCQl2YWwgfD0g
UENJX01TSV9GTEFHU19FTkFCTEU7DQo+ID4gKwkJZHdfcGNpZV93cml0ZXdfZGJpKHBjaSwgUENJ
X01TSV9DQVAgKyBQQ0lfTVNJX0ZMQUdTLCB2YWwpOw0KPiA+ICsJfQ0KPiA+DQo+ID4gIAlyZXR1
cm4gMDsNCj4gPiAgfQ0KPiANCj4gYmFydWNoDQo+IA0KPiAtLQ0KPiANCj4gaHR0cHM6Ly9lbWVh
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGYmFy
dQ0KPiBjaC5zaWFjaC5uYW1lJTJGYmxvZyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDaG9uZ3hpbmcu
emh1JTQwbnhwLmNvDQo+IG0lN0NhY2I5NWRiZDNjMjY0NDJkZjZmNjA4ZDY2MGQyYzA0MiU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5DQo+IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODAyODU1NjQ4
Nzk5NjQ0JmFtcDtzZGF0YT1xaklpMDA0VXJiVFlyVA0KPiBWakRMJTJCMVRIVkNiWmJUZmt3VHUl
MkJlenRsRTZOWFklM0QmYW1wO3Jlc2VydmVkPTANCj4gfi4gLn4gICBUayBPcGVuIFN5c3RlbXMN
Cj4gPX0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1vb08t
LVUtLU9vby0tLS0tLS0tLS0tLXs9DQo+ICAgIC0gYmFydWNoQHRrb3MuY28uaWwgLSB0ZWw6ICs5
NzIuNTIuMzY4LjQ2NTYsDQo+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dw0KPiAudGtvcy5jby5pbCZhbXA7ZGF0YT0w
MiU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3Q2FjYjk1ZGJkMw0KPiBjMjY0NDJkZjZm
NjA4ZDY2MGQyYzA0MiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMA0KPiAl
N0MwJTdDNjM2ODAyODU1NjQ4Nzk5NjQ0JmFtcDtzZGF0YT1EUU9aUjJadndrQWlXbWRIc0dKQlQ3
aA0KPiBOd0VkcFFqNkJNZEc5dng5MGdTdyUzRCZhbXA7cmVzZXJ2ZWQ9MCAtDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
