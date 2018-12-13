Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFA4C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:18:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4136D20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ujAOgIcK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DmbsLOYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4136D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yLQt4rWWY8oVR6JQW/s0EHxCbO25MP0cK+WWzPAMhgo=; b=ujAOgIcKWwk54C
	8iyUUpCjLKwH+ZRpY/KTvjpRhvrTRLRXcl5pprXwyMW8WVjgDViUtH03cE2AgF6l2RdrxeneNftHm
	YT60KID/uQ2tpVpK0B3z+wRazJZW+KTy2h3pCc9PGOKKwGu2wHfLbBgFlpkNvYSe3wCsKb50ac944
	aV3Px0goukoSYyAGjtJPtBESU6UIjUSU73iAcRXmRqlDiQ31pjDiltjBcryBiSrtmMuYsRgajcF3r
	wLSABs6jJoF9fR3a3cKVQF3G2GB26GJfRtsxXgSkiM8PNQxnzGzciU4tOQ2dJ8vCVXxUUkfBa2aD4
	1UlgSd26gJZ+OBiqZMgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXN8o-0008Nc-9p; Thu, 13 Dec 2018 09:18:46 +0000
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXN8l-0007yB-3c
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 09:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZJtLkCabnbbw3F04qwMr5duLnxLmIBnbCvZeMBjsMI=;
 b=DmbsLOYJ69+LENlQmIAdQ2FByEf5+KyBFkyztPPki2UYUiM8irNx18cw981169TI/Q7YVyc/d2KdBRbb039eFroIS2nHzilIwbV77byq4GPs7KrtHW8qDHUehC/iXGUggmpd1ri/G+QAIsE0OMLlyGECgrLuPDfKTSl4RsKpsf4=
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com (20.177.40.15) by
 AM0PR04MB4482.eurprd04.prod.outlook.com (52.135.148.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 09:18:28 +0000
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2]) by AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 09:18:28 +0000
From: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To: Olof Johansson <olof@lixom.net>, Horia Geanta <horia.geanta@nxp.com>
Subject: RE: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
Thread-Topic: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO
Thread-Index: AQHUd8koxYJVBFxMc06CwkRt5aCKLqV8cASAgAApl+A=
Date: Thu, 13 Dec 2018 09:18:28 +0000
Message-ID: <AM0PR04MB4994403A3270455721C446D994A00@AM0PR04MB4994.eurprd04.prod.outlook.com>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
 <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20181213064803.kd7p7fzsegu6nhnl@localhost>
In-Reply-To: <20181213064803.kd7p7fzsegu6nhnl@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4482;
 6:J4m9b+T5yuTTxEbPlCWkeUjRgmbIGKDqXYPbXrieR7mZdklccdzqYKCpfR7QwdPQNXiy8II+ajXxkxFydhCuX3juhlOGWegC4DebgQ+by+7rTrcTQVqTBLl/b/L32bB7OzjFsQGfYp+mVLmlxTCcgQGRzQM1FKmh/qCKW7rB7Fv+5gQ4vIA0iL+sx7ZY09bU3UD+hO7o3yUMVLYnIOVA+1wpWuNUCLFNCbDuQk8lpPZ7raay4biSomZ3eghQRB7PBz+Z81sOI65MfqCOP6s+sZJ8/Zy2NlZTtADlYSoCBa8Ure/jaBPTSwjwWbvJOjCvbZZfXnqDq9dgMffEO20KW5Y2qIK+5czg4o/qWI6w3DOALAizxzrHO1Fxm5+8eslhcjJMi6jIwmBzc7DYf+RMJ2x7tr40WMPnlCAm3oSzeo3UvPXzoqfqZ7h2NLlrTBFofy+CekXoxid3qFwK+uQ3Zg==;
 5:L2W1r47lRe/5F0ix0BiJGurD9DBV+NpZtNaFmCO2j7OAOkjenuoj77nreQXK0nHb/D5gEPP0w8caBDi6I/u+edA8FU+H9u5SdE7EtthK9dwt4NLs4r2kS7urzsIMoV9ojYvuvmH+FFjndM9co+ymKfECxntWekPk8vsVbnayrcA=;
 7:3yov0Usee+fMK098CKo6B7gqbf+FOxYrOm7anyHyOfX9Oxcd1Z7DLo3SLuaaQkIvP9qz7+fupdsHbxlqxyP4V7GCiEfrrM2+3LOXWeVicdS4AkxzzdrdaRgVS/qh1EVRWTGUMfEVFf77a+YgjktPdA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6673ada3-8cf9-4c69-efaf-08d660dbf15c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4482; 
x-ms-traffictypediagnostic: AM0PR04MB4482:
x-microsoft-antispam-prvs: <AM0PR04MB4482D23FCA5E1C95F3F46E5A94A00@AM0PR04MB4482.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4482; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4482; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(396003)(136003)(366004)(346002)(199004)(189003)(13464003)(33656002)(81156014)(76176011)(2906002)(7736002)(53936002)(97736004)(7696005)(3846002)(6636002)(229853002)(6116002)(93886005)(71200400001)(5660300001)(74316002)(6436002)(81166006)(102836004)(256004)(66066001)(99286004)(6246003)(6346003)(486006)(8676002)(71190400001)(53546011)(6506007)(106356001)(316002)(68736007)(55016002)(9686003)(26005)(8936002)(14454004)(186003)(446003)(11346002)(110136005)(476003)(54906003)(105586002)(4326008)(478600001)(25786009)(86362001)(305945005)(15866825006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4482;
 H:AM0PR04MB4994.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-microsoft-antispam-message-info: jLjW+WQ2kAPb9Vb5az1OJjEHIFYAOSYAsMboGotYeKDwe2JIhG+8I4IXY2DtQBul8+dspCTzLxnOikKBaWHhUlYX4SAsPrpyEyipICmIY6HQSVtX+T6WLmQKls4FLgUkrPZkm+lhOMnUaE+h2ovVykQe49dbJgt1lEdD9QV1j5WgLDvhEqdSaMnHk/+yeSOmaDUjbg7C5IEvE4alaiSSuL+c9qZjQ6e1b+FowlfCwPFWGIPWpqCVJcUn0E9p205kmNlc74P+OJDQYZUqTRa8GrR6wJ2+ajtSWxX1drtFHjQMf6DM1DRyQokEfL+RDYEJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6673ada3-8cf9-4c69-efaf-08d660dbf15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 09:18:28.1877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4482
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_011843_149257_632B56F3 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1rZXJuZWwtb3duZXJA
dmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWwtDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4g
T24gQmVoYWxmIE9mIE9sb2YgSm9oYW5zc29uDQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAx
MywgMjAxOCA4OjQ4IEFNDQo+IFRvOiBIb3JpYSBHZWFudGEgPGhvcmlhLmdlYW50YUBueHAuY29t
Pg0KPiBDYzogTWFyYyBHb256YWxleiA8bWFyYy53LmdvbnphbGV6QGZyZWUuZnI+OyBhcm0tc29j
IDxhcm1Aa2VybmVsLm9yZz47DQo+IExpbnV4IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnPjsgTEtNTCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNy85XSBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgRlNM
X01DX0JVUyBhbmQNCj4gRlNMX01DX0RQSU8NCj4gDQo+IE9uIEZyaSwgTm92IDA5LCAyMDE4IGF0
IDA2OjA1OjI0QU0gKzAwMDAsIEhvcmlhIEdlYW50YSB3cm90ZToNCj4gPiBPbiAxMS85LzIwMTgg
MzoxMSBBTSwgTWFyYyBHb256YWxleiB3cm90ZToNCj4gPiA+IENvbW1pdCBlODM0MmNjNzk1NGUg
KCJlbmFibGUgQ0FBTSBjcnlwdG8gZW5naW5lIG9uIFFvcklRIERQQUEyDQo+IFNvQ3MiKQ0KPiA+
ID4gZW5hYmxlZCBDUllQVE9fREVWX0ZTTF9EUEFBMl9DQUFNLCB3aGljaCBkZXBlbmRzIG9uDQo+
IEZTTF9NQ19EUElPLA0KPiA+ID4gd2hpY2ggaXMgbm90IHNldC4gRW5hYmxlIEZTTF9NQ19CVVMs
IGFuZCBidWlsZCBGU0xfTUNfRFBJTyBhbmQNCj4gPiA+IENSWVBUT19ERVZfRlNMX0RQQUEyX0NB
QU0gYXMgbW9kdWxlcy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEdvbnphbGV6
IDxtYXJjLncuZ29uemFsZXpAZnJlZS5mcj4NCj4gPiBSZXZpZXdlZC1ieTogSG9yaWEgR2VhbnTE
gyA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQo+IA0KPiBJIGhhZCB0byByZWRvIHRoaXMgb25lLCBh
bmQgd2hlbiBJIGRpZCBJIG5vdGljZWQgdGhhdCB0aGVyZSdzIGFsc28gYW4gZXRoZXJuZXQNCj4g
ZHJpdmVyLiBTaG91bGQgdGhhdCBiZSBlbmFibGVkIGFzIHdlbGw/DQoNClllcywgaXQgd291bGQg
YmUgYmVzdCB0byBoYXZlIHRoZSBldGhlcm5ldCBkcml2ZXIgZW5hYmxlZCB0b28uDQoNClRoYW5r
cywNCklvYW5hDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
