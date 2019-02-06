Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A29C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:26:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337AE218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ULUpbbbJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TFhBhkr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337AE218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SRED/st/MT1ZsncnXtxqV4tkbupqq6Ltf3FgPiP+kq4=; b=ULUpbbbJ22Mkpj
	4g5akCDRlE0jnaJYnG8wsFGCX/usgbIiHK6kFat4DxV61ewLQ6vSW3SL05IZwRIo58+NMoSfmbRY+
	0Fk2MarFMvQE/8H1Zhyv1ZvO/lPMisPP1JjQLTdsMs+8vn9V0F8/ZPe+TDaK4uYremGk5rW10AlLV
	fvBFY894I7wml+ts37KKHovnijkxfbWBlivT5YJZdtgxxj4/g8df2TQeFsi8GN2p4W2+ymAl1RzD5
	ozxoz9Bj3lSgulVzanYcsxrhhZ+6blyTgI6lPFIfbmOzxds17qGx7bJpno6vy+w9kfsL+yLBi2wjb
	Q4V7cOEXBihvu4UaHqow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grVeb-0003i3-Jd; Wed, 06 Feb 2019 22:26:49 +0000
Received: from mail-db5eur03on0610.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::610]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grVeX-0003hW-Pm
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 22:26:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDWhHuIytJeH0rtxQYHGe5xLAJ0ORLc6v5yI6Qjk6oY=;
 b=TFhBhkr6MzGiZwu46WIV6EXmk2E0EW1mrpZoSvuk4qYaYMPLTI6Pvl0wtWXsjJVGl+fB6m1WV8dSqs997Bv100PcUkxneB3kF5UIGVP1+nXHcjEvzUaw4zVjNnPQ4vAKt3nrE193r1G9ys843EYwukcJlYDZ5u3lFZP+atyh4TE=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB4984.eurprd04.prod.outlook.com (20.177.33.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Wed, 6 Feb 2019 22:26:39 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 22:26:39 +0000
From: Leo Li <leoyang.li@nxp.com>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Thread-Topic: [PATCH v4 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Thread-Index: AQHUvTubh4bC8JQ7jEC50paUIPX1DKXTWE+Q
Date: Wed, 6 Feb 2019 22:26:39 +0000
Message-ID: <AM6PR04MB5863F3BE0D7C560F3DFECD618F6F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190205153924.7204-1-pankaj.bansal@nxp.com>
 <20190205153924.7204-2-pankaj.bansal@nxp.com>
In-Reply-To: <20190205153924.7204-2-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [136.62.168.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB4984;
 6:Y01MUPa6Y2igeJ0XEgBqiOGv4mFu0s+fTK1v3Q0hL7s1nZSlnjeLx9PQJ3kCR2IOpvGJvEF9FswFdOV56IneuRy2NoXYlyhNDiTPNcf661B6lWWtMvOGd9pnOz2Xdn8hyqFRmwfS2ffYTnpIZKqAMjYtvd+/HTKNlqIRsr82Xei8VfOWlTXMQ4UFj6eWcOzQFWHbFGLCmywXy0GXCmd9WpgP1unLAmatDkjEy+g+2C8z5YkkY/gFqsu9ONCdccQIgcFi0qEves54I8r2PZupvCGv2o5XT4lhmKSa5Q17Ai892RWt2Wx315syor4OnFKPJoFgc7ko33xq+MzR6/Q6D8nwAFZt3Afta42BhkaegX1tarjWfUoZp0rxx8dEWlZKKjzB0tVurx7PgPaCwosAtF1miR7BjMUK/I1ZxRSEFbMvWsn6w393NjhGR/NUAlq9bkezLbllGFywNxqhUs1Lkw==;
 5:w8RJJctIJy/oEfvUmSQpjZrODqP+T5WYQvp5z2az9miMy1YKmgKe8pV99GRxoIGHNlEa+e4YU/Oq6HNg5RMHSST9MS9WmdS22bpjzRnRcPKbFw2QX7ooXg21kD5j2CZVBqIGP6YiR2b1ahF2lkgLt6ZwftXtg2V/lPZrvmZbFiQJSj83nr9F/VUQzTtVIQk1cM1aibRFfutCxGN50SzUWQ==;
 7:57plv/WE+zz56ZYaT/XObX00hWXBm0mIFlRCFJvBDSE/GRtVDpQRFnMnFBgh4+l5wr3JUiWNIrOwH9OVnxy6lFqfHolmyGa5RhGpPOm5Ctk7gCfomLYD7ZIMpXA3mQqUoIJGyORwESDKikWUqmOqfw==
x-ms-office365-filtering-correlation-id: 13441a9e-f750-4ac5-58eb-08d68c8229ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4984; 
x-ms-traffictypediagnostic: AM6PR04MB4984:
x-microsoft-antispam-prvs: <AM6PR04MB49848143C2D9F1ED1A82A3488F6F0@AM6PR04MB4984.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(13464003)(189003)(199004)(256004)(6436002)(99286004)(14444005)(55016002)(486006)(66066001)(478600001)(7696005)(11346002)(9686003)(446003)(14454004)(8676002)(476003)(54906003)(316002)(305945005)(7736002)(74316002)(81166006)(110136005)(8936002)(86362001)(229853002)(106356001)(6116002)(3846002)(76176011)(81156014)(105586002)(71190400001)(71200400001)(25786009)(26005)(97736004)(33656002)(186003)(102836004)(2906002)(6506007)(53546011)(53936002)(6246003)(68736007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4984;
 H:AM6PR04MB5863.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EzofSGqlbKftbPN0G6fepoiZHp5cj5h6FAqoPPZswjQ4ESg3z0Wl6gkRbk8kLsr2Jgqw/8mFbbvG09fHkteuGMAxAEAZys+JC36HnrcGw+jC9BoZClQnThMFUlH1/HSyJtctp/s5ZRV9F86y6DiPlrEHdYU+0QJ0Lceg4dvzg7VovtngjDPker7YikEG2IH3s1zcelYStaxd3GgDgWquHCc8PGD8dzzq5QulF1x7cdgENb4tllLhsFREA+CVIQzGYmVDUDo8frRoD+dg1SqJhLiatp+owHeHhSauVeXwLlzXYH0qmoEQcK6cS6ZFu/5DzwBFjiXvVvxP9ryYkpgbaKzZdGqghyrfhSSRPanOEyhMdCDHwSMVGi1DlQivTTsnsrmMjZAtNL2rBQvG9FszjEC/q7sIvSSSz+vTqYNwzgI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13441a9e-f750-4ac5-58eb-08d68c8229ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 22:26:39.5862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4984
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_142645_862062_CA2F7569 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: "open list : OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFua2FqIEJhbnNhbA0K
PiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSA1LCAyMDE5IDQ6MTUgQU0NCj4gVG86IExlbyBMaSA8
bGVveWFuZy5saUBueHAuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1h
cmsNCj4gUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+DQo+IENjOiBsaW51eHBwYy1kZXZA
bGlzdHMub3psYWJzLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiBvcGVuIGxpc3QgOiBPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQgREVWSUNFIFRSRUUgQklO
RElOR1MNCj4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgUGFua2FqIEJhbnNhbCA8cGFu
a2FqLmJhbnNhbEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQgMS8yXSBkdC1iaW5kaW5n
czogc29jOiBmc2w6IERvY3VtZW50IFFpeGlzIEZQR0EgdXNhZ2UNCj4gDQo+IGFuIEZQR0EtYmFz
ZWQgc3lzdGVtIGNvbnRyb2xsZXIsIGNhbGxlZCDigJxRaXhpc+KAnSwgd2hpY2gNCj4gbWFuYWdl
cyBzZXZlcmFsIGNyaXRpY2FsIHN5c3RlbSBmZWF0dXJlcywgaW5jbHVkaW5nOg0KPiDigKIgUmVz
ZXQgc2VxdWVuY2luZw0KPiDigKIgUG93ZXIgc3VwcGx5IGNvbmZpZ3VyYXRpb24NCj4g4oCiIEJv
YXJkIGNvbmZpZ3VyYXRpb24NCj4g4oCiIGhhcmR3YXJlIGNvbmZpZ3VyYXRpb24NCj4gDQo+IFRo
ZSBxaXhpcyByZWdpc3RlcnMgYXJlIGFjY2Vzc2libGUgb3ZlciBvbmUgb3IgbW9yZSBzeXN0ZW0t
c3BlY2lmaWMNCj4gaW50ZXJmYWNlcywgdHlwaWNhbGx5IEkyQywgSlRBRyBvciBhbiBlbWJlZGRl
ZCBwcm9jZXNzb3IuDQoNCkluIHRoZW9yeSB0aGUgb24tYm9hcmQgRlBHQSBpcyBub3QgcGFydCBv
ZiB0aGUgU29DLiAgVGhlIFFpeGlzIGRldmljZSBoYXMgYmVlbiBkZWZpbmVkIHByZXZpb3VzbHkg
aW4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2JvYXJkL2ZzbC1ib2FyZC50eHQg
ZmlsZS4gIEFsdGhvdWdoIG5vcm1hbGx5IGJvYXJkIGJpbmRpbmdzIGFyZSBkZWZpbmVkIGluIGFy
Y2hpdGVjdHVyZSBzcGVjaWZpYyBiaW5kaW5nIGZvbGRlcnMsIHRoaXMgaXMgYSBnb29kIHBsYWNl
IGZvciBib2FyZCByZWxhdGVkIHN0dWZmIHVzZWQgYWNyb3NzIG11bHRpcGxlIGFyY2hpdGVjdHVy
ZXMuICBZb3UgY2FuIHVwZGF0ZSB0aGUgZXhpc3RpbmcgYmluZGluZyBpZiBuZWVkZWQuDQoNCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFBhbmthaiBCYW5zYWwgPHBhbmthai5iYW5zYWxAbnhwLmNvbT4N
Cj4gLS0tDQo+IA0KPiBOb3RlczoNCj4gICAgIFY0Og0KPiAgICAgLSBObyBDaGFuZ2UNCj4gICAg
IFYzOg0KPiAgICAgLSBBZGRlZCBib2FyZG5hbWUgYmFzZWQgY29tcGF0aWJsZSBmaWVsZCBpbiBi
aW5kaW5ncw0KPiAgICAgLSBBZGRlZCBiaW5kaW5ncyBmb3IgTU1JTyBiYXNlZCBGUEdBDQo+ICAg
ICBWMjoNCj4gICAgIC0gTm8gY2hhbmdlDQo+IA0KPiAgLi4uL2JpbmRpbmdzL3NvYy9mc2wvcWl4
aXNfY3RybC50eHQgICAgICAgICAgfCA1MyArKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9mc2wvcWl4aXNfY3RybC50eHQNCj4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2ZzbC9xaXhpc19jdHJsLnR4dA0KPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjVkNTEwZGYxNGJlOA0KPiAt
LS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvZnNsL3FpeGlzX2N0cmwudHh0DQo+IEBAIC0wLDAgKzEsNTMgQEANCj4gKyogUUlYSVMgRlBH
QSBibG9jaw0KPiArDQo+ICthbiBGUEdBLWJhc2VkIHN5c3RlbSBjb250cm9sbGVyLCBjYWxsZWQg
4oCcUWl4aXPigJ0sIHdoaWNoDQo+ICttYW5hZ2VzIHNldmVyYWwgY3JpdGljYWwgc3lzdGVtIGZl
YXR1cmVzLCBpbmNsdWRpbmc6DQo+ICvigKIgQ29uZmlndXJhdGlvbiBzd2l0Y2ggbW9uaXRvcmlu
Zw0KPiAr4oCiIFBvd2VyIG9uL29mZiBzZXF1ZW5jaW5nDQo+ICvigKIgUmVzZXQgc2VxdWVuY2lu
Zw0KPiAr4oCiIFBvd2VyIHN1cHBseSBjb25maWd1cmF0aW9uDQo+ICvigKIgQm9hcmQgY29uZmln
dXJhdGlvbg0KPiAr4oCiIGhhcmR3YXJlIGNvbmZpZ3VyYXRpb24NCj4gK+KAoiBCYWNrZ3JvdW5k
IHBvd2VyIGRhdGEgY29sbGVjdGlvbiAoRENNKQ0KPiAr4oCiIEZhdWx0IG1vbml0b3JpbmcNCj4g
K+KAoiBSQ1cgYnlwYXNzIFNSQU0gKHJlcGxhY2UgZmxhc2ggUkNXIHdpdGggaW50ZXJuYWwgUkNX
KSAoTk9SIG9ubHkpDQo+ICvigKIgRGVkaWNhdGVkIGZ1bmN0aW9uYWwgdmFsaWRhdGlvbiBibG9j
a3MgKFBPU3QvSVJTLCB0cmlnZ2VyZWQgZXZlbnQsIGFuZCBzbw0KPiBvbikNCj4gK+KAoiBJMkMg
bWFzdGVyIGZvciByZW1vdGUgYm9hcmQgY29udHJvbCBldmVuIHdpdGggbm8gRFVUIGF2YWlsYWJs
ZQ0KPiArDQo+ICtUaGUgcWl4aXMgcmVnaXN0ZXJzIGFyZSBhY2Nlc3NpYmxlIG92ZXIgb25lIG9y
IG1vcmUgc3lzdGVtLXNwZWNpZmljDQo+IGludGVyZmFjZXMsDQo+ICt0eXBpY2FsbHkgSTJDLCBK
VEFHIG9yIGFuIGVtYmVkZGVkIHByb2Nlc3Nvci4NCj4gKw0KPiArRlBHQSBjb25uZWN0ZWQgdG8g
STJDOg0KPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gKw0KPiArIC0gY29tcGF0aWJsZTogc2hv
dWxkIGJlIGEgYm9hcmQtc3BlY2lmaWMgc3RyaW5nIGZvbGxvd2VkIGJ5IGEgc3RyaW5nDQo+ICsg
ICBpbmRpY2F0aW5nIHRoZSB0eXBlIG9mIEZQR0EuICBFeGFtcGxlOg0KPiArCSJmc2wsPGJvYXJk
Pi1mcGdhIiwgImZzbCxmcGdhLXFpeGlzLWkyYyINCj4gKyAtIHJlZyA6IGkyYyBhZGRyZXNzIG9m
IHRoZSBxaXhpcyBkZXZpY2UuDQo+ICsNCj4gK0V4YW1wbGUgKExYMjE2MEEtUURTKToNCj4gKwkv
KiBUaGUgRlBHQSBub2RlICovDQo+ICsgICAgICAgIGZwZ2FANjYgew0KPiArCQljb21wYXRpYmxl
ID0gImZzbCxseDIxNjBhcWRzLWZwZ2EiLCAiZnNsLGZwZ2EtcWl4aXMtaTJjIjsNCj4gKwkJcmVn
ID0gPDB4NjY+Ow0KPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJI3NpemUtY2VsbHMg
PSA8MD47DQo+ICsJfQ0KPiArDQo+ICsqIEZyZWVzY2FsZSBvbi1ib2FyZCBGUEdBDQo+ICsNCj4g
K1RoaXMgaXMgdGhlIG1lbW9yeS1tYXBwZWQgcmVnaXN0ZXJzIGZvciBvbiBib2FyZCBGUEdBLg0K
PiArDQo+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiArLSBjb21wYXRpYmxlOiBzaG91bGQgYmUg
YSBib2FyZC1zcGVjaWZpYyBzdHJpbmcgZm9sbG93ZWQgYnkgYSBzdHJpbmcNCj4gKyAgaW5kaWNh
dGluZyB0aGUgdHlwZSBvZiBGUEdBLiAgRXhhbXBsZToNCj4gKwkiZnNsLDxib2FyZD4tZnBnYSIs
ICJmc2wsZnBnYS1xaXhpcyINCj4gKy0gcmVnOiBzaG91bGQgY29udGFpbiB0aGUgYWRkcmVzcyBh
bmQgdGhlIGxlbmd0aCBvZiB0aGUgRlBHQSByZWdpc3RlciBzZXQuDQo+ICsNCj4gK0V4YW1wbGUg
KExTMjA4MEEtUkRCKToNCj4gKw0KPiArICAgICAgICBjcGxkQDMsMCB7DQo+ICsgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHMyMDgwYXJkYi1mcGdhIiwgImZzbCxmcGdhLXFpeGlz
IjsNCj4gKyAgICAgICAgICAgICAgICByZWcgPSA8MHgzIDAgMHgxMDAwMD47DQo+ICsgICAgICAg
IH07DQo+ICsNCj4gLS0NCj4gMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
