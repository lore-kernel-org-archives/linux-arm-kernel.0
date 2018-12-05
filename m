Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B981C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:41:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054F42082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AaMoZj1z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmxFCvrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054F42082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L+8yYjDBp/KupFX7j0j2ossRiHmQkLGsF8euDHnH7tA=; b=AaMoZj1z145I97
	g1VntSWSLj4K4yYSPkOGjsarPzlTeY53m33YFaMWQ283cP2wkwsM2hgXStlDXr7KlbpY/bOw+88NE
	gDS7gyYX1ZGf8O5ZG5TrbDeyNJdCke4nJwdr7lw/R1LpsH3TGVSSLBOijp0otJlWt2ynq4lirldjz
	49RC8TezEb4jk9+YbI4TkP2vE6PuI3OLpqXVoZixqTncV8WOcuhALC7RJhZ2tSFYZ0M7FYSYgHFQv
	VODXYIgjdC+/sgCWThDpJpAJYdY8JK4Q7Fv32jGPBNimJHqd/ac+v6zOPH0hwspC/8/hRfigLm7DH
	ze0C+6MEXDTXl5f8Nosw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQsA-0002Fv-7x; Wed, 05 Dec 2018 06:41:26 +0000
Received: from mail-am5eur03on0605.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::605]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQs6-0002Ex-Kj
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppc/6Zgqa3q4+cUzdvKtUPxQraqgrlYO+W9SE4rxJro=;
 b=AmxFCvrvAZfPDsZuLP7Ycl/mKTzM15Z1heC9i6nWf1rttNj3nCNuYXelZQGJKGYfDcuabS/yJX7vbUbWAf1fx05p2GqzqHQcQmfxqLj3Dl7jQl0FBxVtdiO5eF/VRwGWrTIxJ0NHsCo+0cNeTdLVpj2D0j/2pY9kh1npuYAdZyY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4946.eurprd04.prod.outlook.com (20.176.215.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 06:41:06 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 06:41:06 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH V5 0/6] ARM: imx: add imx7ulp support
Thread-Topic: [PATCH V5 0/6] ARM: imx: add imx7ulp support
Thread-Index: AQHUeQfZ6inxnq6YuEenk48EdQ2noqVv2CUQ
Date: Wed, 5 Dec 2018 06:41:06 +0000
Message-ID: <AM0PR04MB4211FD3E8C3135D432F4694F80A80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4946;
 6:VSr11Xr8jQCruAy17WjwiAYW6KVLlpwj04+isczCCnBPSwX3ZMx4sSg5aPBOQwlenNSaQpQIFL5HIfI9yGo/8KWfcPEn1ExS6/yCTTwJOGTJHT6K8rVhtvsfMjZ6oN9mCvCwUfGxlcene20Hfd/jrkw0t7pTh+MuigHvaLrd/PlqFDypkrG4xik9EtGVy6A51W0JGpVIG86qZjCHz4/uRh93Br0h6HjuINdZGd5MOjO7is/sgOMXeP+ak9GNo2U0FCIoB6pLtBBhU6Jr3HH8wl1iMYUPXL9FOqlHaisPtafL2glSQRIa4YvvNpQxmkkDDABf+4RVN38RT83UJMGWzivUwOOC879k+Ij8kwwtAp0nQL+5Zx1KECf+rXPg98RtyNvLIFQgvcqgiJObLZjxws7zURap4qZks5o/Q8J4pG+0IiAIhRsfkyIIlXeKXAns8adCdXXu4uhK2gWFn4wxxw==;
 5:wRBYxRLyUx8GJhVDUaS6fCTFsakURI4BTx+OddLZ9zOpUOigCs7WuT4qVDfT4YIHo/Oun38/c+PF1iHWMdqQlDD0JusBdO66XhxkMhpy3BcTtXS2CnR6eSXYP/iACIjjF6xETv4pCyMpOgOjgiUY3OAE18EaruDBv+mU6U6f6Mg=;
 7:E0oeP5jY57HSUtpnXtcK7DLzeBX0jd1tvWMtwF0lWI+Vn6bVXoPmUWJs3yJI7NUDPLHbBpnYauhF8WeggB5FioWtWpkoax1phKtAwcQiHC051QTgTXXPFN5B/DW7muykId2OLpLfAiA+ccdgjIQYSg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5af2a7bd-abf0-4082-48da-08d65a7ca285
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4946; 
x-ms-traffictypediagnostic: AM0PR04MB4946:
x-microsoft-antispam-prvs: <AM0PR04MB494655A67358A2823E5D703280A80@AM0PR04MB4946.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4946; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4946; 
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(13464003)(199004)(189003)(486006)(39060400002)(186003)(6246003)(6506007)(76176011)(7696005)(102836004)(53546011)(26005)(6436002)(229853002)(105586002)(11346002)(446003)(476003)(4326008)(5640700003)(68736007)(2906002)(6306002)(55016002)(9686003)(14444005)(256004)(71200400001)(71190400001)(74316002)(305945005)(5660300001)(7736002)(53936002)(6116002)(8936002)(14454004)(81156014)(66066001)(2501003)(966005)(1730700003)(81166006)(8676002)(316002)(3846002)(54906003)(25786009)(97736004)(86362001)(2351001)(33656002)(99286004)(478600001)(106356001)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4946;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P2D5BUxQhj9wEl0xAEZqcwBHJ8gwsgLaPqF2Qr7K1pj0Ry8YkLJkKn25EIju0QJCpeppuDBZQMZjF0FpXY+CozSPzWmyqPcdHGT0ncGleQ0Sg1FvEcHJP4EoJWr6HTh7kinTrnGrYJG+nAq2+JhgTYrZ65R36vuVh3kq6O0ItHJJ4z0EaxeSR34lA1pmzt1HXeW1eJmWzJRTwZS00Q0jgT62dUTuH7VEDzAuEt6eJAFPQsrT2ZqOD0JWmtD+N153LeQm0XlzT9MUjamfVyFyOpbKwjNQFqAJ1oE2fq3R7jGqBHBqo94PzBv02LDy2Xo6b3oisBbsOdyfrN/XYUtvLHy9RX6mYkhR8ehizQANcgc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af2a7bd-abf0-4082-48da-08d65a7ca285
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 06:41:06.8112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4946
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_224122_769668_9EE40782 
X-CRM114-Status: GOOD (  21.52  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU2hhd24sDQoNCkNhbiB5b3UgaGVscCBwaWNrIHVwIGlteDd1bHAgc3VwcG9ydCBzZXJpZXM/
DQpUaGUgY2xrIHBhdGNoIHNldCBpcyBhbHJlYWR5IGluIGNsayB0cmVlIG5vdy4NCmh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Nsay9saW51eC5naXQvbG9n
Lz9oPWNsay1pbXg3dWxwDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBtZSB0byBy
ZXNlbmQuDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEEucy4gRG9uZw0KPiBTZW50OiBTYXR1cmRheSwgTm92ZW1iZXIgMTAs
IDIwMTggMTE6MTMgUE0NCj4gVG86IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPiBDYzogZG9uZ2FzODZAZ21haWwuY29tOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IEZhYmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47
IHJvYmgrZHRAa2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgQS5zLiBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIIFY1IDAvNl0gQVJNOiBpbXg6IGFkZCBpbXg3dWxwIHN1cHBv
cnQNCj4gDQo+IFRoZSBpLk1YIDdVTFAgZmFtaWx5IG9mIHByb2Nlc3NvcnMgcmVwcmVzZW50cyBO
WFDigJlzIGxhdGVzdCBhY2hpZXZlbWVudCBpbg0KPiB1bHRyYS1sb3ctcG93ZXIgcHJvY2Vzc2lu
ZyBmb3IgdXNlIGNhc2VzIGRlbWFuZGluZyBsb25nIGJhdHRlcnkgbGlmZS4NCj4gVGFyZ2V0ZWQg
dG93YXJkcyB0aGUgZ3Jvd2luZyBtYXJrZXQgb2YgcG9ydGFibGUgZGV2aWNlcywgdGhlIGkuTVgg
N1VMUA0KPiBmYW1pbHkgb2YgcHJvY2Vzc29ycyBmZWF0dXJlcyBOWFAncyBhZHZhbmNlZCBpbXBs
ZW1lbnRhdGlvbiBvZiB0aGUgQXJtwq4NCj4gQ29ydGV4LUE3IGNvcmUsIHRoZSBBcm0gQ29ydGV4
LU00IGNvcmUsIGFzIHdlbGwgYXMgYSAzRCBhbmQgMkQgR3JhcGhpY3MNCj4gUHJvY2Vzc2luZyBV
bml0cyAoR1BVcykuIFRoZSBpLk1YIDdVTFAgZmFtaWx5IHByb3ZpZGVzIHVwIHRvIDMyLWJpdA0K
PiBMUEREUjIvTFBERFIzIG1lbW9yeSBpbnRlcmZhY2UgYW5kIGEgbnVtYmVyIG9mIG90aGVyIGlu
dGVyZmFjZXMgZm9yDQo+IGNvbm5lY3RpbmcgcGVyaXBoZXJhbHMsIHN1Y2ggYXMgV0xBTiwgQmx1
ZXRvb3RoLCBHUFMsIGRpc3BsYXlzLCBhbmQgY2FtZXJhDQo+IHNlbnNvcnMuDQo+IA0KPiBUaGlz
IHBhdGNoIHNlcmllcyBhZGRzIHRoZSBiYXNpYyBzdXBwb3J0IGZvciBpbXg3dWxwLiBJdCBpbmNs
dWRlcyBtYWNoaW5lIGxldmVsDQo+IHN1cHBvcnQgY29kZSBhbmQgZGV2aWNlIHRyZWUuDQo+IE5v
dGU6IGl0IGRlcGVuZHMgb24gY2xrIGRyaXZlciB3aGljaCBpcyBzdGlsbCB1bmRlciByZXZpZXcu
DQo+IA0KPiB2NC0+djU6DQo+ICAqIGR0cyBhZGQgaW5wdXQgY2xvY2tzIGZvciBQQ0MgbW9kdWxl
DQo+ICAqIHVwZGF0ZSBwYWQgc2V0dGluZyBkdWUgdG8gbWlzc2luZyBwdWxsIHVwIGVuYWJsZWQN
Cj4gICAgKGZvcm1lcmx5IGF1dG8gZG9uZSBieSBkcml2ZXIgZ2VuZXJpYyBwaW5jb25mZykNCj4g
ICogZ3BpbyBhbmQgcGluY3RybCBwYXRjaGVzIHdlcmUgbWVyZ2VkIGJ5IExpbnVzIFcsIHNvIGRy
b3BwZWQgaW4gdGhpcyBzZXJpZXMNCj4gICBkdC1iaW5kaW5nczogZ3BpbzogdmY2MTA6IGFkZCBv
cHRpb25hbCBjbG9ja3MgcHJvcGVydHkNCj4gICBncGlvOiB2ZjYxMDogYWRkIG9wdGlvbmFsIGNs
b2NrIHN1cHBvcnQNCj4gICBkdC1iaW5kaW5nczogcGluY3RybDogaW14N3VscDogYmFjayB0byBp
bXggbGVnYWN5IGJpbmRpbmcgZm9yDQo+ICAgICBjb25zaXN0ZW5jeQ0KPiAgIHBpbmN0cmw6IGZz
bDogaW14N3VscDogY2hhbmdlIHRvIHVzZSBpbXggbGVnYWN5IGJpbmRpbmcNCj4gDQo+IHYzLT52
NDoNCj4gICogYWRkIGNvbW1lbnRzIGFib3V0IGZpeGVkIHNvYyB2ZXJzaW9uDQo+ICAqIGFkZCBp
b3VubWFwDQo+IHYyLT52MzoNCj4gICogYmFjayB0byBvbGQgcGluY3RybCBiaW5kaW5nIGFjY29y
ZGluZyB0byBTb0MgbWFpbnRhaW5lcidzIHN1Z2dlc3Rpb25zDQo+ICAqIHVzZSBnZW5lcmljIG5v
ZGUgbmFtZQ0KPiAgKiBlcnJvciBjaGVja2luZyB1cGRhdGVkIGFjY29yZGluZyB0byBSdXNzZWxs
J3Mgc3VnZ2VzdGlvbjoNCj4gICAgcHRyID09IEVSUl9QVFIoLUVQUk9CRV9ERUZFUikNCj4gDQo+
IHYxLT52MjoNCj4gICogc3dpdGNoIHRvIFNQRFggbGljZW5zZQ0KPiAgKiByZWJhc2UgdG8gbGF0
ZXN0IHRyZWUNCj4gICogcGFkIG5hbWUgdXBkYXRlDQo+ICAqIGFkZCBncGlvIGNsayBzdXBwb3J0
DQo+ICAqIG1pbm9yIGZpeA0KPiANCj4gDQo+IA0KPiBEb25nIEFpc2hlbmcgKDYpOg0KPiAgIGR0
LWJpbmRpbmdzOiBmc2w6IGFkZCBjb21wYXRpYmxlIGZvciBpbXg3dWxwIGV2aw0KPiAgIGR0LWJp
bmRpbmdzOiBmc2w6IGFkZCBpbXg3dWxwIHBtIHJlbGF0ZWQgY29tcG9uZW50cyBiaW5kaW5ncw0K
PiAgIEFSTTogaW14OiBhZGQgaW5pdGlhbCBzdXBwb3J0IGZvciBpbXg3dWxwDQo+ICAgZHRzOiBp
bXg6IGFkZCBjb21tb24gaW14N3VscCBkdHNpIHN1cHBvcnQNCj4gICBkdHM6IGZzbDogYWRkIGlt
eDd1bHAgZXZrIHN1cHBvcnQNCj4gICBBUk06IGlteF92Nl92N19kZWZjb25maWc6IGFkZCBpbXg3
dWxwIHN1cHBvcnQNCj4gDQo+ICAuLi4vYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsaW14N3Vs
cC1wbS50eHQgICAgICB8ICAyMyArKw0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9mc2wudHh0ICAgICAgfCAgIDggKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMv
aW14N3VscC1ldmsuZHRzICAgICAgICAgICAgICAgICAgfCAgNzcgKysrKysNCj4gIGFyY2gvYXJt
L2Jvb3QvZHRzL2lteDd1bHAuZHRzaSAgICAgICAgICAgICAgICAgICAgIHwgMzQ2DQo+ICsrKysr
KysrKysrKysrKysrKysrKw0KPiAgYXJjaC9hcm0vY29uZmlncy9pbXhfdjZfdjdfZGVmY29uZmln
ICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZyAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KPiAgYXJjaC9hcm0vbWFjaC1pbXgvTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgYXJjaC9hcm0vbWFjaC1pbXgv
Y29tbW9uLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgYXJjaC9hcm0vbWFj
aC1pbXgvY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKw0KPiAgYXJjaC9h
cm0vbWFjaC1pbXgvbWFjaC1pbXg3dWxwLmMgICAgICAgICAgICAgICAgICAgfCAgMzMgKysNCj4g
IGFyY2gvYXJtL21hY2gtaW14L214Yy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAx
ICsNCj4gIGFyY2gvYXJtL21hY2gtaW14L3BtLWlteDd1bHAuYyAgICAgICAgICAgICAgICAgICAg
IHwgIDI5ICsrDQo+ICAxMyBmaWxlcyBjaGFuZ2VkLCA1MzQgaW5zZXJ0aW9ucygrKQ0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
ZnJlZXNjYWxlL2ZzbCxpbXg3dWxwLXBtLnR4dA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cyAgY3JlYXRlIG1vZGUNCj4gMTAwNjQ0IGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IGFyY2gvYXJt
L21hY2gtaW14L21hY2gtaW14N3VscC5jICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gYXJjaC9hcm0v
bWFjaC1pbXgvcG0taW14N3VscC5jDQo+IA0KPiAtLQ0KPiAyLjcuNA0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
