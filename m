Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C302CC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:50:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908F9222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T2DxUTW2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yDUVuNdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908F9222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JDequb2f/3UCYX3KgXg2SLgacdf7UtJ0s+mHho87zOg=; b=T2DxUTW2mRyheR
	AvudHVzga0+RW1cIBPsxADcSMljRhSLhaHPjJqY/M89JO6KW3KbfUpH7bRKP0ybzpQhIX8ZSdJxfZ
	/Hh7KYZvAJcfvAvi9yn4y5zAVnsQe/jKYA3zhMGXpAs2YY7iwAciWFTGsqGTaWoYs07hsCmkRRJvx
	QjMBEl+fPtM7FfHL1FPT44ZitHBnY+obdZN5mr65OOFrK0kScyoxmTaFsWq4I42MbQfIPleWw6v3N
	ncqe9uEWhLjiQCAUTIb6LZwyqjzoVsKijyPFMfYrOfGktqz5kYqk1+rNuRiIOhslHIBV3r1jKI695
	fFlzV4h+rtIWvhlxPPTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtt3Z-0006SO-9s; Wed, 13 Feb 2019 11:50:25 +0000
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtt3V-0006Qx-R4
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:50:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOg5zvBh6fkBNw83pzT9GeW6V1sh4agQVBP+6SXgKGQ=;
 b=yDUVuNdRumVgs6khB+g+PJmgKcfy/NvLOVVJuN3dvqPAd5arrd0HJIVzBt7Kgaywrr7zpRKu/jQGq0vw8KyZ7Yy0D57dPcxwSbjs28niuxOBDn8mASEM9okpMPXkEYZ5a0lRadabOD3uMP9TvChANgcKxZEi7c+V8omIoDz5tYs=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB4761.eurprd04.prod.outlook.com (20.176.233.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 13 Feb 2019 11:50:18 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 11:50:18 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH 2/3] arm64: mmu: early_pgtable_alloc: remove unnecessary
 comments
Thread-Topic: [PATCH 2/3] arm64: mmu: early_pgtable_alloc: remove unnecessary
 comments
Thread-Index: AQHUw3+88usP6fkoZk2E9fP50sbv3qXdlZAAgAAHwaA=
Date: Wed, 13 Feb 2019 11:50:18 +0000
Message-ID: <DB7PR04MB4490B00D34CCC1E3BC475B8888660@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
 <20190213094831.7292-2-peng.fan@nxp.com>
 <20190213112136.GB22119@lakrids.cambridge.arm.com>
In-Reply-To: <20190213112136.GB22119@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e79c3ad5-8deb-46a2-edb3-08d691a96d58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB4761; 
x-ms-traffictypediagnostic: DB7PR04MB4761:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjdQUjA0TUI0NzYxOzIzOkRtT1VhVVRFUHVJalR2SkF6S0lWMzNRMFRk?=
 =?gb2312?B?cGkvYmtjeTdqajlQaVZwSS9IZkNqekFCRUlKZW9yOCtzajhTcEh1aXZ6SFhO?=
 =?gb2312?B?YTJDWXdLaFhpRXhwZVpNV2NmeDdGSGFoaVpOZVF1ZVpveXhmMElhcER4TEha?=
 =?gb2312?B?QnhnT1BqdzNzRlBvSjF6aE1seUhpc2EvNnZseGgzcUpSV09BclpUMW9seE14?=
 =?gb2312?B?d0RXaml5RnlIcUxzckJvQTNld0Y2OGppWDJSK2NIL2lHNHFOZ1lpOHVGa1Ri?=
 =?gb2312?B?YnFRaDVkd2NxZlZnUnJwTll2MlZ3cUhZblM4eW1JK0NuMWpJbU5rTHdIaGN1?=
 =?gb2312?B?NWR3bGFGQUhGNzFzOUI0dGhWNDcwZUhFTmxXQmN6cVpRdk4vNHNZaitmTDVP?=
 =?gb2312?B?dmRBS1A1YTF3cllCSXZJYWMrS21FTlFNN1FiOFVkWktseVpGTXVvaEpNMVFl?=
 =?gb2312?B?M1F5UFA3d1V0dlh6dkoxbjJ4b3cwREcyekRFSUwrNGFpV2pCZldTRTRCUUVU?=
 =?gb2312?B?c204R1RVd0dqdDVhaE9jQ25SY1VDSDFwZXFDTHNZYjc1ajFXY01kcnhCeEw4?=
 =?gb2312?B?QWxOTTA4Qmh0L05USEZ4Y1BxWi9SMkxJZ2F1aGZnckZIU2ZUV1lGSEdkMUJz?=
 =?gb2312?B?dzBRb3kyV0tyQXFCaEJQbW5DRVRFTnRXY2JScndjMUl3TUtKbGd2eGcwaXkv?=
 =?gb2312?B?dTk2K01xMm1OZm1CZ2NSdUZ5UkZSeERWQmZHN2krTCtSQ0RLejNNelNRejZZ?=
 =?gb2312?B?ZVlRQW9GRis3NDlaSDVrVytEYjlMOGZYOTdPdnoyN1pXRDFIYlJHK1RCMHpQ?=
 =?gb2312?B?azRMR0JxMHl1SkVDUCtkQmJKbkJwVnB4T0sreXllRmdTOUU1RlgySjl5Q3dl?=
 =?gb2312?B?OHErVlV1TDgydVI0N2UzZTBIQWxVYXNodDRtTU9IUzladGNkdXpBeWhyQzJR?=
 =?gb2312?B?SkN6cXpBRUhaVnpHZERQMGx3QkFBdEp1ZVVyandiK1VNMkNXRUVUbU5uRlRW?=
 =?gb2312?B?eElLNUJ3eTExWGd3Y0w5eW9URTluMElWUkhncWdjdGpDaGFUZDYrVWdCenRX?=
 =?gb2312?B?aGx3aGFJSVd1OXFKckxZdjdvU25CVXZROUQyM0REMHRLTnJDbTNQbnhNYkFQ?=
 =?gb2312?B?TmYyTjJUTzVKc3pwTVZXeXdWZTV2SXIzSmtDeUJXTlhQMzdCbHp0RXVSeVFt?=
 =?gb2312?B?dlgxekYycmVEOVhuTk1KYnpHcUdOOXVJN0RzY2JlOXkxMldlOWlDdFBVbFhG?=
 =?gb2312?B?Vk4xVE5iZlBOMzBQQUt3V2FUM2JVdTgyRHZhcW5xcldSbkZjYmYzMjJTWnd1?=
 =?gb2312?B?dXNRL1p2bGtFbUtZRm1hYW11aXpQVGNXdTBWMVZZYkF1aTdVbmx5TzZTVlg5?=
 =?gb2312?B?ZXM2dzBXSUYrK1phVE52Qjd5eUxiU2xXaVpLbmZBWS9FdWhYa3R1bUppQXRG?=
 =?gb2312?B?OTVGOUdzcW01a0plQ25KRG5pL014YjNtalhrNkNLN2N1WUR6MWVhWUlZQjU4?=
 =?gb2312?B?WmVpckZ1N3ZtdmQ3alU2ZjZoMzFuc011cndjeUFlTkh5UnRSdTE0anlmK0hD?=
 =?gb2312?B?c2diZU03WGg0S3J4YzJ6RUM5WWp1bUx2VVdGMGhlK3VUbEU2QWozdzF6b255?=
 =?gb2312?B?Um9HVVZrY0JSN0hMWlpHSjNDeHhFY1pGMk1DejFBNHh4MmtzOGhRcnRMbVFB?=
 =?gb2312?Q?smeKn6jd+q/BBaXwVA=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB47617755A663B0DFAC41CC1188660@DB7PR04MB4761.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(39860400002)(376002)(366004)(396003)(13464003)(189003)(199004)(476003)(446003)(6116002)(3846002)(11346002)(486006)(44832011)(53936002)(6246003)(229853002)(7736002)(74316002)(305945005)(97736004)(6916009)(71200400001)(71190400001)(6506007)(6436002)(53546011)(26005)(102836004)(186003)(8936002)(7696005)(99286004)(105586002)(106356001)(478600001)(25786009)(2906002)(81156014)(81166006)(55016002)(9686003)(4326008)(14454004)(8676002)(86362001)(66066001)(54906003)(68736007)(7416002)(256004)(316002)(76176011)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB4761;
 H:DB7PR04MB4490.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0sD4P9bdtyTNKORioJKl9bCsRaXNs8GeTiY+0hxdDYSzy3mBXdvsMyU4GK8NNLXRvSuzHkNvYAEZJAETwDdJ+GGZSFjXU/UvVh+NJmlQ8tXSnOFAiiJgWfb/9mTB+YDVVU2MzkiToVQlVSReCpTwZa+E7XPPCA2uVxTdySSA20UBvRyp4JHx0YGRpjQCuWJvVDaO0HTEKLJe2UrUMUjhmU/U6i/Fm5AheDBnkn6EtbDL4/ya8t4P/hMMqaEbO76TTicPQHFY33rXJMzlMRB3/IrZmCb47jQDqlYsJTO2hM4l6w2UcJ7FnIQqwjkJ7jq4NN7HhgKFY3rULkylvhIqhfkww81XLayM0AasuWTYryVXg6hqQgafskJM0HnBbAoSDl1YRKQciQ7q6Eky00SkPUuWkCRWeFNv17YtI8BEhQQ=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79c3ad5-8deb-46a2-edb3-08d691a96d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 11:50:18.7627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4761
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_035021_881539_AB1DBDFA 
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
 "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
 "van.freenix@gmail.com" <van.freenix@gmail.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWFyaywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIFJ1
dGxhbmQgW21haWx0bzptYXJrLnJ1dGxhbmRAYXJtLmNvbV0NCj4gU2VudDogMjAxOcTqMtTCMTPI
1SAxOToyMg0KPiBUbzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IENjOiBjYXRhbGlu
Lm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gYXJkLmJpZXNoZXV2ZWxA
bGluYXJvLm9yZzsgeWFvanVuODU1ODM2M0BnbWFpbC5jb207DQo+IGNwYW5keWFAY29kZWF1cm9y
YS5vcmc7IHJvYmluLm11cnBoeUBhcm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZhbi5mcmVlbml4
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gYXJtNjQ6IG1tdTogZWFybHlf
cGd0YWJsZV9hbGxvYzogcmVtb3ZlDQo+IHVubmVjZXNzYXJ5IGNvbW1lbnRzDQo+IA0KPiBPbiBX
ZWQsIEZlYiAxMywgMjAxOSBhdCAwOTozNzoyOUFNICswMDAwLCBQZW5nIEZhbiB3cm90ZToNCj4g
PiBUaGUgZW1wdHkgemVybyBwYWdlIGhhcyBiZWVuIG1vdmVkIHRvIGJzcyBhcmVhIGJ5IGNvbW1p
dCA1MjI3Y2ZhNzFmOWUNCj4gPiAoImFybTY0OiBtbTogcGxhY2UgZW1wdHlfemVyb19wYWdlIGlu
IGJzcyIpLA0KPiA+IGFuZCBpdCBhbHJlYXkgYWRkZWQgImRzYiAgICAgaXNoc3QiIGluIGhlYWQu
UyB0byBtYWtlIHN1cmUgdGhlIGVtcHR5DQo+ID4gemVybyBwYWdlIHZpc2libGUgdG8gUFRXLg0K
PiA+DQo+ID4gVGhlcmUgaXMgbm8gY29kZSB0byByZWZsZWN0IHRoZSBjb21tZW50LCBzbyByZW1v
dmUgaXQuDQo+IA0KPiBUaGUgY29tbWVudCBiZWxvdyByZWZlcnMgdG8gdGhlIG1lbW9yeSBwb2lu
dGVkIHRvIGJ5IHB0ciwgd2hpY2ggaXMgemVyb2VkDQo+IGJ5IHRoZSBtZW1zZXQuIFRoZSBjb21t
ZW50IGRvZXMgbm90IHJlZmVyIHRvIHRoZSBnZW5lcmljDQo+IGVtcHR5X3plcm9fcGFnZS4NCj4g
DQo+IFRoaXMgY29tbWVudCBpcyBjb3JyZWN0LCBhbmQgc2hvdWxkIHN0YXkuIFBsZWFzZSBkcm9w
IHRoaXMgcGF0Y2guDQoNCkkgdW5kZXJzdGFuZCB3cm9uZy4gWW91IGFyZSByaWdodC4NCg0KVGhh
bmtzLA0KUGVuZy4NCg0KPiANCj4gVGhhbmtzLA0KPiBNYXJrLg0KPiANCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNo
L2FybTY0L21tL21tdS5jIHwgNCAtLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vbW11LmMgYi9hcmNoL2Fy
bTY0L21tL21tdS5jIGluZGV4DQo+ID4gMDY1MjAyZGEzYWQyLi5mNjFmYTdjOGZkMmUgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9tbS9tbXUuYw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvbW0v
bW11LmMNCj4gPiBAQCAtMTEzLDEwICsxMTMsNiBAQCBzdGF0aWMgcGh5c19hZGRyX3QgX19pbml0
DQo+ID4gZWFybHlfcGd0YWJsZV9hbGxvYyh2b2lkKQ0KPiA+DQo+ID4gIAltZW1zZXQocHRyLCAw
LCBQQUdFX1NJWkUpOw0KPiA+DQo+ID4gLQkvKg0KPiA+IC0JICogSW1wbGljaXQgYmFycmllcnMg
YWxzbyBlbnN1cmUgdGhlIHplcm9lZCBwYWdlIGlzIHZpc2libGUgdG8gdGhlIHBhZ2UNCj4gPiAt
CSAqIHRhYmxlIHdhbGtlcg0KPiA+IC0JICovDQo+ID4gIAlwdGVfY2xlYXJfZml4bWFwKCk7DQo+
ID4NCj4gPiAgCXJldHVybiBwaHlzOw0KPiA+IC0tDQo+ID4gMi4xNi40DQo+ID4NCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
