Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F03C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:00:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364152081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uxKtjrQv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MNsWW+Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364152081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yohb33dAnZEE0sKpsq/MrDh7d/KRGDWG7dMOF91LI5w=; b=uxKtjrQvCDzjtG
	xo4EdaM5Wd2nt9Jjimy+R3fH9A0ZM6M2zMunutLrbd7Dk5Le1YxxVM+z8ADQP+cXgYFUfgti70/Zs
	wLSsfmCr3Rl01N6yfJqd3WlewkmmIgFHzCrQ1FQo2D8ln14P30tBldhSB89teoyshYcURiJZOd2ix
	ZMozekFPdFHJ8eqVR0Jo/FFTfM1VfHoaGnacY8Nbo3aqrN+HxViluqq6v6Kq8XiPwE5a9tDJxj3IB
	JT7KkKX0GLLgIfkpEByOH6wkbNqB0vUOrMdESt2F/Y+wlWj8vsJ6+/GqPcx1SEm8FqFA+cDDJjdLe
	0pMbHR1ZkAmmzamf7DHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTj9n-00058f-9a; Mon, 03 Dec 2018 08:00:43 +0000
Received: from mail-db3eur04on0627.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::627]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTj9j-000586-7x
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9Tex/0x4tjABoXVXoIAAvdZ6rrfmyHrpIBY/78cgas=;
 b=MNsWW+Kt8WDJVEgGjF5+IqLqnmplIhfk+hJ6pnpeNWGwUA2tNWX1fvY4vN8SLVIilsOzB56Bz7EowiHYBFZReOwiBIkxQFyvjfYGrIJeXv3kJCiaD/pAbXAp7hMGH0TVb1DYw7eRJYNFpwpcS49UBNNshi3QdpblAXbOgalbZnU=
Received: from AM0PR04MB4532.eurprd04.prod.outlook.com (52.135.148.158) by
 AM0PR04MB5793.eurprd04.prod.outlook.com (20.178.202.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 08:00:21 +0000
Received: from AM0PR04MB4532.eurprd04.prod.outlook.com
 ([fe80::8c48:f19b:f69:5f18]) by AM0PR04MB4532.eurprd04.prod.outlook.com
 ([fe80::8c48:f19b:f69:5f18%3]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:00:21 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
 Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH v3 2/5] spi: imx: mx51-ecspi: Move some initialisation to
 prepare_message hook.
Thread-Topic: [PATCH v3 2/5] spi: imx: mx51-ecspi: Move some initialisation to
 prepare_message hook.
Thread-Index: AQHUiHiYFJQ+04xkUE+Y2kPcq6JooaVsqY5g
Date: Mon, 3 Dec 2018 08:00:21 +0000
Message-ID: <AM0PR04MB4532C74AD347B0A30EDB7FC489AE0@AM0PR04MB4532.eurprd04.prod.outlook.com>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20181130064709.6998-3-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5793;
 6:k7q36PwZvXsU3qnrjZaZjiBAYWadf4IkQg7rvPJTTzLRwdfPWzKzXqlLuoai25u+LirTCEiQ4boe6o+TInOrJo0mvhwX1+hFkCPwGbSp1P14l4cGT2/kefV9FNRbEZV4TuEME+8KQNPeLkFSnSgimgpsWg9ce2zfcZvxawoBMYPIxOkWTZRSB35iXG1c+LeT9zOWL/IZtYHhkdn48bpbQp9HJuUn6OLaHkRd7J6Xn+doLgkgGKTYPelCa++qn1za1IFxzNHntzV4jSLIpwMBmtlhGNGZyouJB0gNM6UdWUlvf0ZPdZ0s2pL3OTFThtrDZjcQ6DxOFKvajHxpWnNJH68lCdwsOBkHoc+7Q68+pp90F0atkdjSCqOUrNInp4vNu7GRrtFwOM/T3xY9GKwrIDM7rM3i/liZhNtk4Nmak31r8ecXFV4hy1m+iy+WUhUamD9WyVlX9MgV2bLm15XpXQ==;
 5:dupnoTSUzxKDnr6GkiGk4ZOdd0RgwioNMMufo8a30Eh6/PLepyaJDqGdAJuB7ZCvKX3mzMfMPQ40njT4cUfrwACXUzzJpx+Pwfebq0rQUQzq4gz2jNV5KFAAk7rHKrEjMGXmioKlmLEoBPJig3bj8UmZ4+OWUbz47e/LRuuwd4o=;
 7:z0/PBfDdeg9xnZa5+hIRdwhrvT2otiKgjZXOUem0tDrWUflrcHP7exBkzvoPBnglqURcDMmhSxEoHC7CinU8w703N+1XNWj0/m42yEQxkiLxKH6DAP5PguC2+a6oAYvvsTedRh69v5o/AOjuyqFQeg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1197060b-3db9-44ec-9c1d-08d658f55fd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5793; 
x-ms-traffictypediagnostic: AM0PR04MB5793:
x-microsoft-antispam-prvs: <AM0PR04MB57939F7A319695C973C3897D89AE0@AM0PR04MB5793.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5793; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5793; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(13464003)(199004)(189003)(11346002)(575784001)(6116002)(3846002)(316002)(71200400001)(97736004)(446003)(6246003)(486006)(476003)(71190400001)(106356001)(74316002)(66574009)(25786009)(66066001)(86362001)(305945005)(54906003)(478600001)(4326008)(68736007)(102836004)(110136005)(76176011)(53546011)(256004)(55016002)(6506007)(14444005)(6436002)(26005)(186003)(5660300001)(8676002)(99286004)(8936002)(7736002)(7696005)(33656002)(53936002)(14454004)(9686003)(81166006)(81156014)(2906002)(105586002)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5793;
 H:AM0PR04MB4532.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ep6o0DEAWa4IGpnAox1gyKjIaql1wXy2W5emB2imZv2LQWBo7zq1eJjmIwAPomrMrZW7QsGXtrkArvv7YX/G7OY4kakfioBxHPr2z7h5d9cNbpyfklJgkp8PJJEy1gWXz1nHTXYUGgOZ8JyqHr51Qrz9Ml2JAHhokH+nWYd22f2ILPImFuCyN9LBGt1njDOwRiKUzd+B02K1ywRRdAsOVFuaKxnh8K8O0hS/LidZSqjAXZWU47vR46GQb53Qf0smmsKaj7wMVZ0pGpwHc0VzJYCvrqnGde5/tpHUEoX4EKwg8uUQHNemgQjty6FkCJ0Q25KC2vPGIA+t/f4xhtpU10lzj1G3Q5YfIl+kqkC1bh4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1197060b-3db9-44ec-9c1d-08d658f55fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:00:21.6370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5793
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_000039_700459_D7EFC677 
X-CRM114-Status: GOOD (  24.55  )
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFV3ZSBLbGVpbmUtS8O2bmln
IDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTjlubQxMeaciDMw
5pelIDE0OjQ3DQo+IFRvOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBSb2JpbiBH
b25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+IENjOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5k
ZT47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjMgMi81XSBzcGk6IGlteDogbXg1
MS1lY3NwaTogTW92ZSBzb21lIGluaXRpYWxpc2F0aW9uIHRvDQo+IHByZXBhcmVfbWVzc2FnZSBo
b29rLg0KPiANCj4gVGhlIHJlbGV2YW50IGRpZmZlcmVuY2UgYmV0d2VlbiBwcmVwYXJlX21lc3Nh
Z2UgYW5kIGNvbmZpZyBpcyB0aGF0IHRoZQ0KPiBmb3JtZXIgaXMgcnVuIGJlZm9yZSB0aGUgQ1Mg
c2lnbmFsIGlzIGFzc2VydGVkLiBTbyB0aGUgcG9sYXJpdHkgb2YgdGhlIENMSyBsaW5lDQo+IG11
c3QgYmUgY29uZmlndXJlZCBpbiBwcmVwYXJlX21lc3NhZ2UgYXMgYW4gZWRnZSBnZW5lcmF0ZWQg
YnkgY29uZmlnIG1pZ2h0DQo+IGFscmVhZHkgcmVzdWx0IGluIGEgbGF0Y2ggb2YgdGhlIE1PU0kg
bGluZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1r
b2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9zcGkvc3BpLWlteC5jIHwg
NjcgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1pbXguYyBiL2RyaXZlcnMvc3BpL3NwaS1pbXguYyBpbmRl
eA0KPiBjN2RiNDJkNmIzYmMuLmQzYTFlNzEwNDU1NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9z
cGkvc3BpLWlteC5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1pbXguYw0KPiBAQCAtNDkwLDE0
ICs0OTAsOSBAQCBzdGF0aWMgdm9pZCBteDUxX2Vjc3BpX2Rpc2FibGUoc3RydWN0IHNwaV9pbXhf
ZGF0YQ0KPiAqc3BpX2lteCkgIHN0YXRpYyBpbnQgbXg1MV9lY3NwaV9wcmVwYXJlX21lc3NhZ2Uo
c3RydWN0IHNwaV9pbXhfZGF0YQ0KPiAqc3BpX2lteCwNCj4gIAkJCQkgICAgICBzdHJ1Y3Qgc3Bp
X21lc3NhZ2UgKm1zZykNCj4gIHsNCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLQ0KPiAtc3RhdGlj
IGludCBteDUxX2Vjc3BpX2NvbmZpZyhzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKSAtew0KPiAtCXN0
cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXggPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKHNwaS0+
bWFzdGVyKTsNCj4gKwlzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpID0gbXNnLT5zcGk7DQo+ICAJdTMy
IGN0cmwgPSBNWDUxX0VDU1BJX0NUUkxfRU5BQkxFOw0KPiAtCXUzMiBjbGsgPSBzcGlfaW14LT5z
cGVlZF9oeiwgZGVsYXksIHJlZzsNCj4gKwl1MzIgdGVzdHJlZzsNCj4gIAl1MzIgY2ZnID0gcmVh
ZGwoc3BpX2lteC0+YmFzZSArIE1YNTFfRUNTUElfQ09ORklHKTsNCj4gDQo+ICAJLyogc2V0IE1h
c3RlciBvciBTbGF2ZSBtb2RlICovDQo+IEBAIC01MTIsMTkgKzUwNywyMSBAQCBzdGF0aWMgaW50
IG14NTFfZWNzcGlfY29uZmlnKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICAJaWYgKHNwaS0+
bW9kZSAmIFNQSV9SRUFEWSkNCj4gIAkJY3RybCB8PSBNWDUxX0VDU1BJX0NUUkxfRFJDVEwoc3Bp
X2lteC0+c3BpX2RyY3RsKTsNCj4gDQo+IC0JLyogc2V0IGNsb2NrIHNwZWVkICovDQo+IC0JY3Ry
bCB8PSBteDUxX2Vjc3BpX2Nsa2RpdihzcGlfaW14LCBzcGlfaW14LT5zcGVlZF9oeiwgJmNsayk7
DQo+IC0Jc3BpX2lteC0+c3BpX2J1c19jbGsgPSBjbGs7DQo+IC0NCj4gIAkvKiBzZXQgY2hpcCBz
ZWxlY3QgdG8gdXNlICovDQo+ICAJY3RybCB8PSBNWDUxX0VDU1BJX0NUUkxfQ1Moc3BpLT5jaGlw
X3NlbGVjdCk7DQo+IA0KPiAtCWlmIChzcGlfaW14LT5zbGF2ZV9tb2RlICYmIGlzX2lteDUzX2Vj
c3BpKHNwaV9pbXgpKQ0KPiAtCQljdHJsIHw9IChzcGlfaW14LT5zbGF2ZV9idXJzdCAqIDggLSAx
KQ0KPiAtCQkJPDwgTVg1MV9FQ1NQSV9DVFJMX0JMX09GRlNFVDsNCj4gKwkvKg0KPiArCSAqIFRo
ZSBjdHJsIHJlZ2lzdGVyIG11c3QgYmUgd3JpdHRlbiBmaXJzdCwgd2l0aCB0aGUgRU4gYml0IHNl
dCBvdGhlcg0KPiArCSAqIHJlZ2lzdGVycyBtdXN0IG5vdCBiZSB3cml0dGVuIHRvLg0KPiArCSAq
Lw0KPiArCXdyaXRlbChjdHJsLCBzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9DVFJMKTsNCj4g
Kw0KPiArCXRlc3RyZWcgPSByZWFkbChzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9URVNUUkVH
KTsNCj4gKwlpZiAoc3BpLT5tb2RlICYgU1BJX0xPT1ApDQo+ICsJCXRlc3RyZWcgfD0gTVg1MV9F
Q1NQSV9URVNUUkVHX0xCQzsNCj4gIAllbHNlDQo+IC0JCWN0cmwgfD0gKHNwaV9pbXgtPmJpdHNf
cGVyX3dvcmQgLSAxKQ0KPiAtCQkJPDwgTVg1MV9FQ1NQSV9DVFJMX0JMX09GRlNFVDsNCj4gKwkJ
dGVzdHJlZyAmPSB+TVg1MV9FQ1NQSV9URVNUUkVHX0xCQzsNCj4gKwl3cml0ZWwodGVzdHJlZywg
c3BpX2lteC0+YmFzZSArIE1YNTFfRUNTUElfVEVTVFJFRyk7DQo+IA0KPiAgCS8qDQo+ICAJICog
ZUNTUEkgYnVyc3QgY29tcGxldGlvbiBieSBDaGlwIFNlbGVjdCBzaWduYWwgaW4gU2xhdmUgbW9k
ZSBAQCAtNTQ4LDI1DQo+ICs1NDUsNDIgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX2NvbmZpZyhz
dHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgCQljZmcgJj0gfk1YNTFfRUNTUElfQ09ORklHX1ND
TEtQT0woc3BpLT5jaGlwX3NlbGVjdCk7DQo+ICAJCWNmZyAmPSB+TVg1MV9FQ1NQSV9DT05GSUdf
U0NMS0NUTChzcGktPmNoaXBfc2VsZWN0KTsNCj4gIAl9DQo+ICsNCj4gIAlpZiAoc3BpLT5tb2Rl
ICYgU1BJX0NTX0hJR0gpDQo+ICAJCWNmZyB8PSBNWDUxX0VDU1BJX0NPTkZJR19TU0JQT0woc3Bp
LT5jaGlwX3NlbGVjdCk7DQo+ICAJZWxzZQ0KPiAgCQljZmcgJj0gfk1YNTFfRUNTUElfQ09ORklH
X1NTQlBPTChzcGktPmNoaXBfc2VsZWN0KTsNCj4gDQo+IC0JaWYgKHNwaV9pbXgtPnVzZWRtYSkN
Cj4gLQkJY3RybCB8PSBNWDUxX0VDU1BJX0NUUkxfU01DOw0KPiArCXdyaXRlbChjZmcsIHNwaV9p
bXgtPmJhc2UgKyBNWDUxX0VDU1BJX0NPTkZJRyk7DQo+IA0KPiAtCS8qIENUUkwgcmVnaXN0ZXIg
YWx3YXlzIGdvIGZpcnN0IHRvIGJyaW5nIG91dCBjb250cm9sbGVyIGZyb20gcmVzZXQgKi8NCj4g
LQl3cml0ZWwoY3RybCwgc3BpX2lteC0+YmFzZSArIE1YNTFfRUNTUElfQ1RSTCk7DQo+ICsJcmV0
dXJuIDA7DQo+ICt9DQo+IA0KPiAtCXJlZyA9IHJlYWRsKHNwaV9pbXgtPmJhc2UgKyBNWDUxX0VD
U1BJX1RFU1RSRUcpOw0KPiAtCWlmIChzcGktPm1vZGUgJiBTUElfTE9PUCkNCj4gLQkJcmVnIHw9
IE1YNTFfRUNTUElfVEVTVFJFR19MQkM7DQo+ICtzdGF0aWMgaW50IG14NTFfZWNzcGlfY29uZmln
KHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpIHsNCj4gKwlzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlf
aW14ID0gc3BpX21hc3Rlcl9nZXRfZGV2ZGF0YShzcGktPm1hc3Rlcik7DQo+ICsJdTMyIGN0cmwg
PSByZWFkbChzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9DVFJMKTsNCj4gKwl1MzIgY2xrID0g
c3BpX2lteC0+c3BlZWRfaHosIGRlbGF5Ow0KPiArDQo+ICsJLyogQ2xlYXIgQkwgZmllbGQgYW5k
IHNldCB0aGUgcmlnaHQgdmFsdWUgKi8NCj4gKwljdHJsICY9IH5NWDUxX0VDU1BJX0NUUkxfQkxf
TUFTSzsNCj4gKwlpZiAoc3BpX2lteC0+c2xhdmVfbW9kZSAmJiBpc19pbXg1M19lY3NwaShzcGlf
aW14KSkNCj4gKwkJY3RybCB8PSAoc3BpX2lteC0+c2xhdmVfYnVyc3QgKiA4IC0gMSkNCj4gKwkJ
CTw8IE1YNTFfRUNTUElfQ1RSTF9CTF9PRkZTRVQ7DQo+ICAJZWxzZQ0KPiAtCQlyZWcgJj0gfk1Y
NTFfRUNTUElfVEVTVFJFR19MQkM7DQo+IC0Jd3JpdGVsKHJlZywgc3BpX2lteC0+YmFzZSArIE1Y
NTFfRUNTUElfVEVTVFJFRyk7DQo+ICsJCWN0cmwgfD0gKHNwaV9pbXgtPmJpdHNfcGVyX3dvcmQg
LSAxKQ0KPiArCQkJPDwgTVg1MV9FQ1NQSV9DVFJMX0JMX09GRlNFVDsNCj4gDQo+IC0Jd3JpdGVs
KGNmZywgc3BpX2lteC0+YmFzZSArIE1YNTFfRUNTUElfQ09ORklHKTsNCj4gKwkvKiBzZXQgY2xv
Y2sgc3BlZWQgKi8NCj4gKwljdHJsICY9IH4oMHhmIDw8IE1YNTFfRUNTUElfQ1RSTF9QT1NURElW
X09GRlNFVCB8DQo+ICsJCSAgMHhmIDw8IE1YNTFfRUNTUElfQ1RSTF9QUkVESVZfT0ZGU0VUKTsN
Cj4gKwljdHJsIHw9IG14NTFfZWNzcGlfY2xrZGl2KHNwaV9pbXgsIHNwaV9pbXgtPnNwZWVkX2h6
LCAmY2xrKTsNCj4gKwlzcGlfaW14LT5zcGlfYnVzX2NsayA9IGNsazsNCj4gKw0KPiArCWlmIChz
cGlfaW14LT51c2VkbWEpDQo+ICsJCWN0cmwgfD0gTVg1MV9FQ1NQSV9DVFJMX1NNQzsNCj4gKw0K
PiArCXdyaXRlbChjdHJsLCBzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9DVFJMKTsNCj4gDQo+
ICAJLyoNCj4gIAkgKiBXYWl0IHVudGlsIHRoZSBjaGFuZ2VzIGluIHRoZSBjb25maWd1cmF0aW9u
IHJlZ2lzdGVyIENPTkZJR1JFRyBAQA0KU2VlbXMgd2UgZG9uJ3QgbmVlZCB0aGlzIGNvbW1pdCBh
bnltb3JlLCB5b3VyIHBhdGNoIGZpeCBpdCBieSB0aGUgd2F5Pw0KDQpjb21taXQgNmZkOGI4NTAz
YTBkY2Y2NjUxMDMxNGRjMDU0NzQ1MDg3YWU4OWY5NA0KQXV0aG9yOiBNYXJlayBWYXN1dCA8bWFy
ZXhAZGVueC5kZT4NCkRhdGU6ICAgV2VkIERlYyAxOCAxODozMTo0NyAyMDEzICswMTAwDQoNCiAg
ICBzcGk6IHNwaS1pbXg6IEZpeCBvdXQtb2Ytb3JkZXIgQ1MvU0NMSyBvcGVyYXRpb24gYXQgbG93
IHNwZWVkcw0KDQo+IC01OTQsNyArNjA4LDYgQEAgc3RhdGljIHZvaWQgbXg1MV9zZXR1cF93bWwo
c3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCkNCj4gIAkgKiBDb25maWd1cmUgdGhlIERNQSBy
ZWdpc3Rlcjogc2V0dXAgdGhlIHdhdGVybWFyaw0KPiAgCSAqIGFuZCBlbmFibGUgRE1BIHJlcXVl
c3QuDQo+ICAJICovDQo+IC0NCj4gIAl3cml0ZWwoTVg1MV9FQ1NQSV9ETUFfUlhfV01MKHNwaV9p
bXgtPndtbCAtIDEpIHwNCj4gIAkJTVg1MV9FQ1NQSV9ETUFfVFhfV01MKHNwaV9pbXgtPndtbCkg
fA0KPiAgCQlNWDUxX0VDU1BJX0RNQV9SWFRfV01MKHNwaV9pbXgtPndtbCkgfA0KPiAtLQ0KPiAy
LjE5LjINCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
