Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA111C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:51:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3BD20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GetFGLFL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P3FMbxrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3BD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lPH1wSW6Dct4w61wwHB7hGXDjhq8rRCXwpOSOlxft7Q=; b=GetFGLFLNXbOSD
	329xqUJjaEKawuGvQmxaPadYpMa0AmmbVfMmGwjoOh2nEGK/ppvM98VyV5fvOBtQJS1tK46Znw3ci
	5GzffaN25PaJy2++zs2qLVY3Yl8WeARyMeS4lmURWgR2MJDtoN48UPJtAEa/6Gz87pO/RiKn+Q3uc
	Py+IqiKQmpdJqe/RN9ibsvS0Bm7BWICnlyLDkesCjMcUqqGinTDc/pywF1JwW+udlZsRkL/8b5tVE
	cVl5Bvgv0wmyGfZrFBQmv6ZqvlTNlAvlFPgDgHJRoKf+8KrNPhRlQ0TC9Sd2JKhBu3UyMcSGnMiJD
	VH3hV0INdaHvxdK2kecw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjcEC-0007KL-Ok; Wed, 16 Jan 2019 03:50:56 +0000
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjcE8-0007Jh-5T
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 03:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cOQzKhNfmgqmTA6jsCoRIhXkNvxfm895Heiz2O4TuQ=;
 b=P3FMbxrhCVWbSWr2xnNeIlhA/QzjutbjSadeln5SuQ3wAxnoQbvay6x5Tu7CxAZKsdrV/xkZTZfwrqVYVnaPmwzQWJf/Y3iJugChiV06KaYWvUTEQylhSmEUH5aHnPn+UJuznkHBmRJ8erjJ1JvlBZb9C2RQY66uKDMSpDeaGpo=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB2945.eurprd04.prod.outlook.com (10.173.254.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 16 Jan 2019 03:50:45 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::e96c:f353:8099:c2a3]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::e96c:f353:8099:c2a3%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 03:50:45 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Rob Herring <robh@kernel.org>
Subject: RE: [PATCHv4 1/4] dt-bindings: add DT binding for the layerscape PCIe
 controller with EP mode
Thread-Topic: [PATCHv4 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Thread-Index: AQHUpwBaZZB7USYgk0+FGeuMpQ+mBqWqJqaAgAcnwJA=
Date: Wed, 16 Jan 2019 03:50:44 +0000
Message-ID: <AM5PR04MB32998AF3C7BA8EB9AF659646F5820@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20190108030922.24031-1-xiaowei.bao@nxp.com>
 <20190111143123.GA6960@bogus>
In-Reply-To: <20190111143123.GA6960@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM5PR04MB2945;
 6:amHWAzFa3LJG0XWr6U9v0KL5UzK4fjggczYCLwrtUE4JUr339bfhz/tTMIWCwYtwdEr8xyJmQFkH0neTBlLP1KvtNKfW5rQdw2+vC1itTMNCLBebw/6Kz2ziMh0MTf8N5Z5/quX02Lwz811vldWgciGnIGpTXkjy1Vl0HYRcDBUpnvknqvOODZdqt73sucrAskjrFFz1o652eTPXW9FtDt7YIBkQHGoOaDRXLIG3daGnNNGP/NrdLxzkJ/xLQ3+EByyW5apsKi9o9+GFVtDEX3XcT08oSQb2BvtPGpH1hppuc5Pqd0ckDeRFOXyI3B/CcWR84Toj99ppEcJN/Ay+xj7L+cNEb7zQvj0FGjg1kECa9fopbv+TC9IoLVrVm/s/QW5DTTX+DJJjmb5yguichXfo3bEzKy7nCiXIRSrQqH9qtcsL2BPu0dg4PgBarcHlq6nUUF++22GDbLYj3iaEDA==;
 5:AgDRfU3/SYJwjptA6Zmc0vpkvDSuHB23y2U1pb1rUd/fey2JgWvSBbw4AGGubzkRrQMz8NAJSwocxycagjVFXygFJRBl39DUfhiAoxw9xdZYn3zMCndU5+WnqIutve+wxfGH+4L8wi14DmuqngpZUolJFYUFyN1vTJkUOGTpDVggEOdGwOXeso4VjDtAC8puZJcUSFzpmei9vHyo9FqENw==;
 7:nPN9V31qPaaC9oH2jg0bmfQkQtuwWlQU/tY9Qt1aNWMApP9EE1VQWjV4ejKOFx3NrFjhQoRWHiBOeB1I2YEfo+Yf1QswwGfcqcRYiRxtQh4RWwJTmdWrOBEB/LEJhRh8MurnO5AgrGxEGJKyWTBPjw==
x-ms-office365-filtering-correlation-id: a5407ca8-dda5-4ff0-687d-08d67b65cb42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB2945; 
x-ms-traffictypediagnostic: AM5PR04MB2945:
x-microsoft-antispam-prvs: <AM5PR04MB2945A32729848A4FE7A7B56FF5820@AM5PR04MB2945.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(13464003)(68736007)(33656002)(99286004)(486006)(54906003)(44832011)(7416002)(5660300001)(6246003)(74316002)(8936002)(229853002)(53936002)(14454004)(4326008)(6436002)(66066001)(478600001)(81156014)(316002)(81166006)(6916009)(8676002)(9686003)(25786009)(7736002)(305945005)(86362001)(55016002)(102836004)(105586002)(106356001)(14444005)(53546011)(6506007)(256004)(26005)(7696005)(76176011)(6116002)(71200400001)(476003)(3846002)(446003)(11346002)(2906002)(186003)(71190400001)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB2945;
 H:AM5PR04MB3299.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bfCCtXHwJUiLK1rlULMdiVZDbuep4HdBsN57Sby15W99c6NDyXuOV1v6xphOyqxAA6a6tpjX7UdPOUCQBiqQ8z7hUrK3WBxGlAF67ZfnTrtT4wXWkGL4Ta2gOMCtP9+1d+o3IXZS1QM4NF6TNYzA2Kp4yGMj8si/sv18FWwgN8hWY+Z2SjCbEsnebIOWrb0Qp32f9z6pbNSr5Qk4Q/F9kNzhe0vNR8dg+hNloIjcT9Oh1VQl5QcVXEOamIcgwXQsSL37ZBngdBlnmpf6PzuB8CqDbUpYlMSsHLULXUJbt951zBIeKLiNIASm2XURrMDN7vnX9Nc0Sdcwp0JU5ilGYNtSaOVhB2T4ZA64yenB2qqoGc1D/604J/hMI7Es02aoEVazsEmeKyGDY48LxDxQN52qcIfh9yjpeMLYK9T99ec=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5407ca8-dda5-4ff0-687d-08d67b65cb42
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 03:50:45.0833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2945
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_195052_211570_356398E1 
X-CRM114-Status: GOOD (  14.87  )
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
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 "M.h. Lian" <minghuan.lian@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "kishon@ti.com" <kishon@ti.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Roy Zang <roy.zang@nxp.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPiANClNlbnQ6IDIwMTnE6jHUwjExyNUgMjI6MzENClRvOiBYaWFvd2VpIEJhbyA8
eGlhb3dlaS5iYW9AbnhwLmNvbT4NCkNjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtl
cm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8g
TGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IGtpc2hvbkB0aS5jb207IGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb207IGFybmRAYXJuZGIuZGU7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBNLmgu
IExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhw
LmNvbT47IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPjsga3N0ZXdhcnRAbGludXhmb3VuZGF0
aW9uLm9yZzsgY3lyaWxsZS5waXRjaGVuQGZyZWUtZWxlY3Ryb25zLmNvbTsgcG9tYnJlZGFubmVA
bmV4Yi5jb207IHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbTsgbmlrbGFzLmNhc3NlbEBheGlzLmNv
bTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IFhpYW93ZWkgQmFvIDx4
aWFvd2VpLmJhb0BueHAuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSHY0IDEvNF0gZHQtYmluZGlu
Z3M6IGFkZCBEVCBiaW5kaW5nIGZvciB0aGUgbGF5ZXJzY2FwZSBQQ0llIGNvbnRyb2xsZXIgd2l0
aCBFUCBtb2RlDQoNCk9uIFR1ZSwgIDggSmFuIDIwMTkgMTE6MDk6MTkgKzA4MDAsIFhpYW93ZWkg
QmFvIHdyb3RlOg0KPiBBZGQgdGhlIGRvY3VtZW50YXRpb24gZm9yIHRoZSBEZXZpY2UgVHJlZSBi
aW5kaW5nIGZvciB0aGUgbGF5ZXJzY2FwZSANCj4gUENJZSBjb250cm9sbGVyIHdpdGggRVAgbW9k
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29t
Pg0KPiAtLS0NCj4gdjI6DQo+ICAtIEFkZCB0aGUgU29DIHNwZWNpZmljIGNvbXBhdGlibGVzLg0K
PiB2MzoNCj4gIC0gbW9kaWZ5IHRoZSBjb21taXQgbWVzc2FnZS4NCj4gdjQ6DQo+ICAtIG5vIGNo
YW5nZS4NCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2ku
dHh0ICAgICB8ICAgIDMgKysrDQo+ICAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkNCj4gDQoNClBsZWFzZSBhZGQgQWNrZWQtYnkvUmV2aWV3ZWQtYnkgdGFn
cyB3aGVuIHBvc3RpbmcgbmV3IHZlcnNpb25zLiBIb3dldmVyLCB0aGVyZSdzIG5vIG5lZWQgdG8g
cmVwb3N0IHBhdGNoZXMgKm9ubHkqIHRvIGFkZCB0aGUgdGFncy4gVGhlIHVwc3RyZWFtIG1haW50
YWluZXIgd2lsbCBkbyB0aGF0IGZvciBhY2tzIHJlY2VpdmVkIG9uIHRoZSB2ZXJzaW9uIHRoZXkg
YXBwbHkuDQoNCklmIGEgdGFnIHdhcyBub3QgYWRkZWQgb24gcHVycG9zZSwgcGxlYXNlIHN0YXRl
IHdoeSBhbmQgd2hhdCBjaGFuZ2VkLg0KW1hpYW93ZWkgQmFvXSBIaSBSb2IsIHRoYW5rcyBhIGxv
dCBmb3IgeW91ciBjb21tZW50cywgaWYgdGhlIHBhdGNoZXMgaGF2ZSBuZXcgdXBkYXRlLCBJIHdp
bGwgYWRkIHRoZSBBY2tlZC1ieS9SZXZpZXdlZC1ieSwgdGhhbmtzLg0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
