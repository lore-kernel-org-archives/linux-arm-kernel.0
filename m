Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A41C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:41:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5856E2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TsZKPxye";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wW/EgZlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5856E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=COZNGO81t6RuxH7KmouO4o4Mhh+GT5pSbQpBIKQQHDw=; b=TsZKPxyeUBaqHi
	QqFPLMJmm0JbSFzWNrZrfwC8RjVkvkjSOT90Kft5QJXTeDR4L3wAph45J/yUFOrPIRJdeFc8zyJFY
	3t4uGvp8d+F6oN6VTa3H5eZd9ACn908VC8CqZ/8OBu+iJ0/r2meLLpqJM7MCDpMfy3M5r5b4S6J2p
	uYNU+m5ROcWWONpu0MtirNnVLNl0hO4+buvO3rDf7Qw2qz3ROMoha0l2nnSCz/L69TDukInqflYHe
	sABb/3PQmSd47l3imEII6fGA9KMndFs2V6lke8wJYrfEsx63Ak8qi+yjLU590SsHXAiN1YxzFFspo
	rS6woi2iIMxCHQJYPJWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gci5O-0002aj-D5; Fri, 28 Dec 2018 02:41:18 +0000
Received: from mail-eopbgr150078.outbound.protection.outlook.com
 ([40.107.15.78] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gci5K-0002Zi-QQ
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 02:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMeKQlHdc47mtt/kG3ITMTvYt4LIZDdt5p4HkRAt1kM=;
 b=wW/EgZlOOidASIU9nObzsNNXWxkDlHxlw8efgP5GXWKcd7J3SNMKgkgJnzuRTl9LErryYX2s792Q4f3n42olXZpita4ftjmdqwqqnNsjRJYu43bUoLSLpleqggbT7wARfouhbAoElzf+5nttmkoW+ygoF/r7+o2sh5ZihLA6i10=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB5936.eurprd04.prod.outlook.com (20.178.205.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 28 Dec 2018 02:40:59 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148%3]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 02:40:59 +0000
From: BOUGH CHEN <haibo.chen@nxp.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Adrian Hunter
 <adrian.hunter@intel.com>
Subject: RE: [PATCH 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
Thread-Topic: [PATCH 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
Thread-Index: AQHUmDiTyHn+7tGsDkmINmEMtso266WSREcAgABJEYCAAO1BsA==
Date: Fri, 28 Dec 2018 02:40:58 +0000
Message-ID: <VI1PR04MB504033A6B1A1EC556C135FA190B70@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
 <1545292612-14471-2-git-send-email-haibo.chen@nxp.com>
 <cff15a85-3f72-a8ea-2e5f-731963175fde@intel.com>
 <20181227122254.GB26090@n2100.armlinux.org.uk>
In-Reply-To: <20181227122254.GB26090@n2100.armlinux.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5936;
 6:2RWvs4S5rOjvVt+EEepngfTj/mu4yJy3dU7cmGAyg0a9pdQIiRdY7wK6fZzoA1Nr8W+g/JV8YtdvXM2q2kYUT5Vaj4R8MB4PbCjbhoxOrU5ck3w4sNv+reluql5resRTwkQqPTUBDaTTOa7Eez2l6M9XwXba0hUO1FZU0+9lMq2rkNdYCpxobG+fWyjCZATu+6OM0OkRp/6FZ5hVITYHn2y7+PX2nBa2E4x9aZRPTvt8kjHrNfTCukIeRjsqe7aWVoXKtQI3v5ZREy/fiBfH1OVieQusjxfIyAhTI630KRK6YWXwIs3CWX9ZUmfWQ6F3S/CzvWVjm9fBR1ZwtM2K0pTclpdEQXZProSeDIdJ7yEMuORHan7qM/Iz+5SaXuuBTUyF1Ra6Fsp1Nk9wOIRzr7AOa91EuwaKZY524DPcWGIi5IHeVbWM8QlF8wXEeR3sIYOVv4guPpPcg2EjC1xZkA==;
 5:3QnaxzixOoX/QbMOQ6X1gkcMoSv7F2ocr1C7iXXozVI+mfW0UZRwJ4GxWBCsaJyHMpYJ5t7+EvkT0N9njypuMFeQ/06m/CB1BwLH1tc19eNxbaGftvzE7M1apMWWxuourUtG5wMScC3Rdb/ljeO/TRf1sXGUcEQdNFIeYJUU2bY=;
 7:udlJD3K0zpSGlg6KZ/xOkod8W0liVzXOqgYBuF3CNrXsztQIknmoPJzUVK8t6Pm03Z/D9G81+/yCPLJhH0dsYVOBVbqcTALE/HyAD7E8O3guOy/yQJDtU8/zGm4QL7rb/s9PF0sGdMdhOcRwW0ZcLw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8a063d6c-224a-4864-8e59-08d66c6de661
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5936; 
x-ms-traffictypediagnostic: VI1PR04MB5936:
x-microsoft-antispam-prvs: <VI1PR04MB59366E3090395F2B3E80C5A690B70@VI1PR04MB5936.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(10201501046)(3002001)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5936; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5936; 
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(396003)(366004)(346002)(39860400002)(13464003)(199004)(189003)(43544003)(446003)(53936002)(478600001)(106356001)(11346002)(86362001)(45080400002)(476003)(5660300001)(256004)(14444005)(486006)(14454004)(966005)(2906002)(316002)(105586002)(93886005)(8936002)(6306002)(9686003)(53346004)(6246003)(54906003)(97736004)(55016002)(110136005)(53546011)(6506007)(26005)(66066001)(186003)(4326008)(7696005)(33656002)(25786009)(81166006)(68736007)(6116002)(76176011)(3846002)(7416002)(99286004)(229853002)(74316002)(6436002)(81156014)(8676002)(305945005)(71190400001)(102836004)(7736002)(71200400001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5936;
 H:VI1PR04MB5040.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: czLUGqrddRufEzdxGuVI6G92vRcX+LKsos2sEkGELh/XB+3EKY9LxsGNJGIXdvIsNGoAbAkLZeIA8G4rCHZN56OzH3/bshcSRUTNDsxG5KeznbBcjbzHqWTetzkI+xO54Le4zI21WSc9ZOnPW+jQkfN9OKEljNTf3eJTbTFuFystwptYv4bzLg3XRckSxLzdoSv1YBaq+mmF0R6PR1ZUw3KiEAX08hBAEivWRMQr7Ys46xB7H9FdrBBCOCcOj3X9mdr67QF+YxYffvE5550WQy9/wJ2T0hi5AUe0aSD9R7ToC1SNXyHX9iPkNKFx+pdS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a063d6c-224a-4864-8e59-08d66c6de661
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 02:40:59.0661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5936
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_184114_861455_5B4E3B15 
X-CRM114-Status: GOOD (  24.09  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJ1c3NlbGwgS2luZyAtIEFS
TSBMaW51eCBbbWFpbHRvOmxpbnV4QGFybWxpbnV4Lm9yZy51a10NCj4gU2VudDogMjAxOMTqMTLU
wjI3yNUgMjA6MjMNCj4gVG86IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
Pg0KPiBDYzogQk9VR0ggQ0hFTiA8aGFpYm8uY2hlbkBueHAuY29tPjsgdWxmLmhhbnNzb25AbGlu
YXJvLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hh
d25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1
dHJvbml4LmRlOyBGYWJpbyBFc3RldmFtDQo+IDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gbW1jOiBzZGhjaS1lc2Ro
Yy1pbXg6IGFkZCBTRCBjbG9jayBsaW1pdGF0aW9uIGZvcg0KPiBpbXg2dWxsDQo+IA0KPiBPbiBU
aHUsIERlYyAyNywgMjAxOCBhdCAxMDowMToyNEFNICswMjAwLCBBZHJpYW4gSHVudGVyIHdyb3Rl
Og0KPiA+IE9uIDIwLzEyLzE4IDk6NDkgQU0sIEJPVUdIIENIRU4gd3JvdGU6DQo+ID4gPiBpLk1Y
NlVMTCBoYXMgZXJyYXRhIEVSUjAxMDQ1MCwgcG9pbnQgb3V0IHRoYXQgZHVlIHRvIFNPQyBJL08g
dGltaW5nDQo+ID4gPiBsaW1pdGF0aW9uLCBmb3IgZU1NQyBIUzIwMCBhbmQgU0QvU0RJTyAzLjAg
U0RSMTA0LCB0aGUgY2xvY2sgcmF0ZQ0KPiA+ID4gY2FuJ3QgZXhjZWVkIDE1ME1Iei4gQW5kIGZv
ciBlTU1DIEREUjUyIGFuZCBTRC9TRElPDQo+ID4gPiBERFI1MCBtb2RlLCB0aGUgY2xvY2sgcmF0
ZSBjYW4ndCBleGNlZWQgNDVNSHouDQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBhZGQgdGhpcyBs
aW1pdCBmb3IgaW14NnVsbC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVu
IDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBBcGFydCBmcm9tIHRoZSBrYnVpbGQgdGVz
dCByb2JvdCBjb21wbGFpbnRzIChkbyB0aGV5IG5lZWQgdG8gYmUgZml4ZWQ/KToNCj4gPg0KPiA+
IEFja2VkLWJ5OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gDQo+
IE5hY2tlZC1ieTogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4NCj4g
DQo+IFRoZSBrYnVpbGQgdGVzdCByb2JvdCBjb21wbGFpbnRzIGRvIG5lZWQgdG8gYmUgZml4ZWQg
Zmlyc3QuICBUaGV5J3JlIGNvbmZ1c2luZw0KPiBiZWNhdXNlIEdDQyBwcm9kdWNlcyBxdWl0ZSBh
IGxvdCBvZiBnYXJiYWdlIGluIGl0cyBlcnJvciBtZXNzYWdlcyBub3cuICBJZg0KPiB5b3UgbG9v
ayBhdCB0aGUgcGF0Y2gsIHRoZXJlJ3MgYSBodW5rIHRoYXQgaGFzOg0KPiANCj4gKyAgICAgICBp
ZiAoaW14X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19FUlIwMTA0NTApIHsNCj4g
KyAgICAgICAgICAgICAgIGlmIChpbXhfZGF0YS0+aXNfZGRyKQ0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBjbG9jayA9IGNsb2NrID4gNDUwMDAwMDAgPyA0NTAwMDAwMCA6IGNsb2NrOw0KPiAr
ICAgICAgICAgICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBjbG9jayA9IGNs
b2NrID4gMTUwMDAwMDAwID8gMTUwMDAwMDAwIDogY2xvY2s7DQo+ICsNCj4gDQo+IHdoaWNoIGlz
IG1pc3NpbmcgYSBjbG9zaW5nIGJyYWNlLiAgVGhpcyBwYXRjaCBjb3VsZCBub3QgaGF2ZSBiZWVu
IGJ1aWxkIHRlc3RlZA0KPiBiZWZvcmUgaXQgd2FzIG1haWxlZCB0byB0aGUgbGlzdCwgYW5kIHRo
ZSB0ZXN0IHJvYm90IGlzIGhpZ2hsaWdodGluZyB0aGF0IGZhY3QuDQo+IA0KDQpJJ20gcmVhbGx5
IHNvcnJ5IGFib3V0IHRoYXQuICBUaGFua3MgZm9yIHBvaW50IG91dCB0aGF0LCBJIHdpbGwgZG91
YmxlIGNoZWNrIG15IHBhdGNoIHdoZW4gSSBtYWlsIHRvIHRoZSBsaXN0IG5leHQgdGltZS4NCg0K
PiBJdCBtYXkgYWxzbyBiZSBhIGdvb2QgaWRlYSB0byBlbmNvdXJhZ2UgYSBkaWZmZXJlbnQgYXBw
cm9hY2ggdG8gdGhlIGFib3ZlDQo+IGFueXdheToNCj4gDQo+IAlpZiAoaW14X2RhdGEtPnNvY2Rh
dGEtPmZsYWdzICYgRVNESENfRkxBR19FUlIwMTA0NTApIHsNCj4gCQl1bnNpZ25lZCBsb25nIG1h
eF9jbG9jazsNCj4gDQo+IAkJbWF4X2Nsb2NrID0gaW14X2RhdGEtPmlzX2RkciA/IDQ1MDAwMDAw
IDogMTUwMDAwMDAwOw0KPiANCj4gCQljbG9jayA9IG1heChjbG9jaywgbWF4X2Nsb2NrKTsNCj4g
CX0NCj4gDQo+IHJhdGhlciB0aGFuIG9wZW4tY29kaW5nIHRoZSBtYXgoKSBzdHVmZiBpbiB0aGUg
ZHJpdmVyLg0KDQpUaGFua3MgZm9yIGdpdmluZyBzdWNoIGEgZ29vZCBzdWdnZXN0aW9uLCBJIHdp
bGwgdGFrZSBjYXJlIG9mIGl0LCB3aXRoIGEgbGl0dGxlIGNoYW5nZToNCgkJY2xvY2sgPSBtaW4o
Y2xvY2ssIG1heF9jbG9jayk7DQoNCkJlc3QgUmVnYXJkDQpCb3VnaCBDaGVuDQo+IA0KPiBUaGFu
a3MuDQo+IA0KPiAtLQ0KPiBSTUsncyBQYXRjaCBzeXN0ZW06DQo+IGh0dHBzOi8vZW1lYTAxLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4g
YXJtbGludXgub3JnLnVrJTJGZGV2ZWxvcGVyJTJGcGF0Y2hlcyUyRiZhbXA7ZGF0YT0wMiU3QzAx
JTdDaGFpYm8uDQo+IGNoZW4lNDBueHAuY29tJTdDMTNhZTU5NzYwZGUyNGRlMjlhN2MwOGQ2NmJm
NjExNzQlN0M2ODZlYTFkM2JjMg0KPiBiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYz
NjgxNTEwMTkzNzE0NjY0MiZhbXA7c2RhdGE9VVANCj4gUzd6MlVUTHBmZ3FneVdGUE0lMkZ5WFAl
MkJRdTFxVUxvYXZGT0JMRldrUWp3JTNEJmFtcDtyZXNlcnZlZA0KPiA9MA0KPiBGVFRDIGJyb2Fk
YmFuZCBmb3IgMC44bWlsZSBsaW5lIGluIHN1YnVyYmlhOiBzeW5jIGF0IDEyLjFNYnBzIGRvd24g
NjIya2Jwcw0KPiB1cCBBY2NvcmRpbmcgdG8gc3BlZWR0ZXN0Lm5ldDogMTEuOU1icHMgZG93biA1
MDBrYnBzIHVwDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
