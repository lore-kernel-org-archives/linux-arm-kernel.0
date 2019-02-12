Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780D3C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:42:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A79821773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qhnqqgr5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IR1ydwrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A79821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sr8IGjd2v1EHv9JuyFZE7MjoeWvC19VAE2FxvPBROk8=; b=Qhnqqgr5N9Iz4B
	G8MH5YXRwO7mGX63HC00C5hTQ2AXHr0fr9+pyq9e2xeEYJPeAQLX32N9QPjorCflfIL2w5iDhHyST
	aXXatFQ/38epABrYk3eHAQR+h0vbX08hl/AgGpdhvsGLklOSAU13b3M2f/+EYwpbmCcUXKJ0Ehxyj
	7s/P763qlzwiqPIgk7BCuOJi5iruVwBBep9gdV03QHbS5wtwKjWQYkEMqOAHr6EQixbFMlKWfM9LO
	fCaGDB1xog3pFH4hFWZU31rydaNAi8Yvw/CfRcjdkeH2kllczBihoAUJRuN2vZxass5wkr5/NeBRg
	6bmN7iduepWiM5p+g7pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtOxl-0005BS-9K; Tue, 12 Feb 2019 03:42:25 +0000
Received: from mail-ve1eur01on0628.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::628]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtOxh-0005Av-Fa
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 03:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31Fem1fZhD+MVEhZMEPYAjsBBW1ykM4wJ+nI8/LrZ2A=;
 b=IR1ydwrY+tta6+1Ngyw7zdWE4OUwkA7RtNRXNtlhMZqLsbI7i33Ny8uV4EsJxbo4HpoWhZwMAjK382qfpZmZUgaM0oMoTHY61f9UcoBfHEI7gXdvOpletnhyu5R+FsdoWlwMRQBlWdCyAP44IWYy9Ex33heraFhugebeoNR/g4M=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5071.eurprd04.prod.outlook.com (20.177.50.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Tue, 12 Feb 2019 03:42:15 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::958f:1823:dcd4:4f49]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::958f:1823:dcd4:4f49%2]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 03:42:15 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: =?utf-8?B?UGV0ciDFoHRldGlhcg==?= <ynezz@true.cz>, Vinod Koul
 <vkoul@kernel.org>
Subject: RE: imx-uart DMA transaction error leading to OOPS on 4.14.95
Thread-Topic: imx-uart DMA transaction error leading to OOPS on 4.14.95
Thread-Index: AQHUwgI4Iq4P2RBHr0ywDNm8KpGj2aXaVDwAgAExGGA=
Date: Tue, 12 Feb 2019 03:42:15 +0000
Message-ID: <VI1PR04MB454392326A1394AA678090F289650@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <20190206081310.GP26426@meh.true.cz>
 <20190211120616.GT4296@vkoul-mobl> <20190211092820.GS26426@meh.true.cz>
In-Reply-To: <20190211092820.GS26426@meh.true.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5071;
 6:OYiRRZrR0raJfkiaV+dS4aTVOb5k1GzUQpsTzmFWey3LJDXldCecvGXQ78fcS/fuNgLnKDCyXTjeY3W/Hf3fe+uU0/rsRLPIvi98sXVZG+CV6ZnBuMMLYqD75+uNucuAzMAp+Th8DI9x8Dy6Ztq/abugGrBg042dy3v0bQ4rGuq5xBLXSBYAag3+YpitA2l7yLaLhiKfREPi+khGCSb9FdJ0bVcQsT8Kih988WH05RWrLEcBm5nLpov/mU65QnbaIszZg7U8p/W6fKdBOEGt42b23EY1RvyPnD9B1DFz/jXol0gBFDJbRhrWWFvLYvYm4U9FQ/F4k3/XG3QVjD9OWHkbsiwATP2YrAKKLgCPZIR0BZsOYuIbf2AJCy5ud/sKfijzWYKlnEA5zzkAGd7SkLSt/5n1s5JgVO1/aLfr72JwngaUQfKn/pyDlgiTW79OX1F4nWRt4Y/BE89sSAqe1Q==;
 5:BRirv23Ij8ZkGVXaIwU18bbHY3EglZyJmZRdT+e3SFao1p+03NmvkFQLtJIL4W2Nd7EzJ/Hew/n4lcBVpMDIdkE5wfQv8k1zl2m6gNATZ6msWHqQDDLv3z7I3xPIByzUP5QK+1qtHfbYAxuGpfYoZV4e+gbtUaMjgOOg3cO8Px0jhh/K8WdzgG/JvlvhF84/JosdEOZoxnE2T5qq82hMzw==;
 7:ZHHhNNpnRfxm3ZwYmAIZfulvjZ6x8r6KAULwnr0UkwU5LfouGpp6H0fXyjcJ/B527IzixaHvdxbIgtPhLW7ESbt/MiXUnQT0FDg7OO2FAfz2GuSk9v4xI0Ra0EtKYzq78OiiMOinNIDqHN46gCHTpQ==
x-ms-office365-filtering-correlation-id: 6af0cf59-3491-491c-4d57-08d6909c1483
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5071; 
x-ms-traffictypediagnostic: VI1PR04MB5071:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB5071A5053192203943C24E6889650@VI1PR04MB5071.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(13464003)(14444005)(478600001)(256004)(8676002)(81156014)(74316002)(8936002)(81166006)(186003)(316002)(66066001)(106356001)(97736004)(110136005)(3846002)(6116002)(6436002)(54906003)(966005)(2906002)(68736007)(71190400001)(71200400001)(305945005)(7736002)(33656002)(55016002)(66574012)(6246003)(229853002)(6506007)(76176011)(7696005)(25786009)(53546011)(99286004)(105586002)(86362001)(446003)(102836004)(14454004)(4326008)(26005)(53936002)(9686003)(486006)(476003)(6306002)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5071;
 H:VI1PR04MB4543.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zX4FuHZkL3RzlNoSOKUcjIfwDnr8eQDUquuZQIlnfWCQGxZn9gQtDUz2TEPK2PHnSM3CMaxvVbY+pvpRxo5I1umIqjYI6JP1oyyuF3qB/8aZZE5n1SNFrhWZu+ai3ESInmrDmaO3omHyPK86Tv+5q35w/jYpYqRqhhR9Lz6aGaUQxdZzkW9CuLnMCQcWDSsUrlG98SkKHi1+BW2sbFf6z8UcEiAVLgMzJAeaKJvvLxbAfM+JFQafvCxJfgPQtDqvDUkTYLPJ9hsb7xd0QrQPKwzBwoWL+5qZsoEkTHU34qF+4roDM/7xcWNPVOc7OhDigazezAMlA1V8ibPj2TciniaUel7HHt85YpqhXpee12m750Mtgqb/NhVZO5ECvorkVb1PYbJ2v950snp2hgu6PJ2U4PXPI9E6ygZOzQI5bVM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af0cf59-3491-491c-4d57-08d6909c1483
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 03:42:15.1790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_194221_524414_FA9F2DF2 
X-CRM114-Status: GOOD (  20.77  )
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
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUGV0ciwNCglDb3VsZCB5b3UgY2hlY2sgdGhlIGJlbG93IHBhdGNoIHNldCB3aGljaCBpcyBu
b3QgaW4gdjQuMTQuOTg/DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwMDU3
NzkxLw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBldHIgxaB0ZXRp
YXIgPHluZXp6QHRydWUuY3o+DQo+IFNlbnQ6IDIwMTnlubQy5pyIMTHml6UgMTc6MjgNCj4gVG86
IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+OyBMdWNhcyBTdGFjaA0KPiA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT47
IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47DQo+IGRtYWVuZ2luZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBS
ZTogaW14LXVhcnQgRE1BIHRyYW5zYWN0aW9uIGVycm9yIGxlYWRpbmcgdG8gT09QUyBvbiA0LjE0
Ljk1DQo+IA0KPiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPiBbMjAxOS0wMi0xMSAxNzoz
NjoxNl06DQo+IA0KPiBIaSwNCj4gDQo+ID4gPiBJJ3ZlIGp1c3QgZW5jb3VudGVyZWQgZm9sbG93
aW5nIE9PUFMgb24gNC4xNC45NToNCj4gPiA+DQo+ID4gPiAgIGlteC11YXJ0IDIxZjAwMDAuc2Vy
aWFsOiBETUEgdHJhbnNhY3Rpb24gZXJyb3IuDQo+ID4NCj4gPiBEbyB5b3Ugc2VlIHRoaXMgb24g
bWFpbmxpbmUgYXMgd2VsbCwgYml0IG9mIGZpeGVzIHdlbnQgaW50byB0aGlzDQo+ID4gZHJpdmVy
IHJlY2VudGx5Li4uDQo+IA0KPiBJJ3ZlIGhpdCBpdCBvbmx5IG9uY2Ugb24gNC4xNCBzbyBmYXIs
IGl0J3MgcXVpdGUgaGFyZCB0byByZXByb2R1Y2UgaXQsIHNvIG5vIGJpZyBkZWFsLA0KPiBidXQg
SSd2ZSBqdXN0IHRob3VnaHQsIHRoYXQgc29tZW9uZSBtaWdodCBiZSBpbnRlcmVzdGVkLiBPbmNl
IEkgZmluZCBzb21lIHdheQ0KPiB0byByZXByb2R1Y2UgaXQsIEknbGwgdHJ5IHRvIHRlc3QgaXQg
b24gc29tZSByZWNlbnQga2VybmVsLg0KPiANCj4gQlRXLCBhbnkgaWRlYSB3aGljaCBvZiB0aG9z
ZSBmaXhlcyBtaWdodCBiZSByZWxhdGVkIHRvIHRoaXMgT29wcyBhbmQgbWlnaHQgYmUNCj4gd29y
dGggYmFja3BvcnRpbmcgdG8gNC4xND8NCj4gDQo+ID4gPiAgIFVuYWJsZSB0byBoYW5kbGUga2Vy
bmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyBhMGVlNTAxYQ0KPiA+ID4gICBw
Z2QgPSA5ZDdkNDAwMA0KPiA+ID4gICBbYTBlZTUwMWFdICpwZ2Q9MmQ4ZDE4MTEsICpwdGU9MDAw
MDAwMDAsICpwcHRlPTAwMDAwMDAwDQo+ID4gPiAgIEludGVybmFsIGVycm9yOiBPb3BzOiA3IFsj
MV0gU01QIEFSTQ0KPiAuLi4NCj4gPiA+ICAgQ1BVOiAwIFBJRDogMjUzNiBDb21tOiBzaCBOb3Qg
dGFpbnRlZCA0LjE0Ljk1ICMwDQo+ID4gPiAgIEhhcmR3YXJlIG5hbWU6IEZyZWVzY2FsZSBpLk1Y
NiBRdWFkL0R1YWxMaXRlIChEZXZpY2UgVHJlZSkNCj4gPiA+ICAgdGFzazogOWY2N2NhMDAgdGFz
ay5zdGFjazogOWI2NDIwMDANCj4gPiA+ICAgUEMgaXMgYXQgc2RtYV9pbnRfaGFuZGxlcisweDdj
LzB4MTdjDQo+ID4NCj4gPiBTbyB3ZSBnZXQgYW4gaW50ZXJydXB0IHdoaWxlIGRvaW5nIHNodXRk
b3duLi4gVGhhdCBpcyBpbnRlcmVzdGluZy4uDQo+IA0KPiBJJ20gdXNpbmcgc2VyaWFsIGNvbnNv
bGUgb24gdHR5bXhjMCAoMTE1MjAwLDhuMSkgYW5kIFVIRiBSRklEIHJlYWRlciBvbg0KPiB0dHlt
eGMzKDkyMTYwMCw4bjEpIHdoaWNoIGlzIHNlbmRpbmcgcmVwb3J0cyBhc3luY2hyb25vdXNseSBh
bmQgaXQgd2FzIGFjdGl2ZQ0KPiBkdXJpbmcgdGhlIHNodXRkb3duIGFzIEkgd2FzIHRlc3Rpbmcg
bmV3IGhhcmR3YXJlIHJldmlzaW9uIGR1cmluZyB0aGF0IHRpbWUuDQo+IA0KPiA+ID4gICBQQyBp
cyBhdCBzZG1hX2ludF9oYW5kbGVyKzB4N2MvMHgxN2MNCj4gPiA+ICAgTFIgaXMgYXQgY29uc29s
ZV91bmxvY2srMHg0ODAvMHg0ZWMNCj4gDQo+IEknbSBub3Qgc3VyZSBob3cgdG8gaW50ZXJwcmV0
IHRoaXMsIGJ1dCBpcyBpdCBwb3NzaWJsZSwgdGhhdCB0aGVyZSBtaWdodCBiZSBzb21lDQo+IHJh
Y2Ugd2hpbGUgc2RtYV9pbnRfaGFuZGxlciBjb3VsZCBiZSBwcm9jZXNzaW5nIGludGVycnVwdCBv
biB0dHlteGMzIHdoaWxlDQo+IHRoZSBzeXN0ZW0gaXMgZG9pbmcgc29tZSBjb25zb2xlIG91dHB1
dCBvbiB0dHlteGMwPyBJIGp1c3QgdXNlIHRoZSBjb25zb2xlIGZvcg0KPiBvYnNlcnZhdGlvbiwg
c28gSSB3YXNuJ3QgdHlwaW5nIG9yIG90aGVyd2lzZSB1dGlsaXppbmcgaXQsIHNvIHByb2JhYmx5
IG5vIHJlYXNvbg0KPiBmb3IgaW50ZXJydXB0IGZyb20gdHR5bXhjMC4NCj4gDQo+IC0tIHluZXp6
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
