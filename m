Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838E6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:24:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52695208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RCpzgsv1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VGnZtj9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52695208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tcWN4/S02SvBaxOTTmhzGtPH8zmLUcQQ9OnVGZO0s0o=; b=RCpzgsv1EOmpzO
	Ug5rvFelR8hBtKEM18MuCrlyhoxJDtEEfPYx2Ul1MhENtIigqBErES31lnUJkbLZXvRzA9x3tv5O5
	u2EFZhYggXPIcz25dkch2X0/LU0+OEE2o5ZMXGYmBZgJ3R0TUYG3vgFrLFf8Yb18Y0RhKDZKitMe7
	x/hTn0p5KS+3A0sI9Sixrbc1fg/HjLUWJJvqFUUfv9/A+22wt7nwtyLuIzQ8jK9Csf3/FSpCmnYmC
	tQ3Lbf5RKbc6toxss/nfDUBtlEtfcNX8G8uKhTy2KAx291fG3FLLsBPos1dqylDZ7/3unsX0m1bF3
	1pBiwWTEp9uGIr1fy3eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUrlx-0001xe-E0; Thu, 06 Dec 2018 11:24:49 +0000
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUrlt-0001wY-3f
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:24:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSbc3EPVQcfPE6wllBqtt6mSKHUk8l6iwlxba45eNm4=;
 b=VGnZtj9JfO5z9tM34hf4W/QDiCfblqGsCVSpK4mY/GBPJXfZ9EXcDRulQP6/44NlOwNfzegMq6dudrO4w1/Ct54ySWHlkj7bfXjYM9TeCG+DOCJbJTZk7nA+EqNbYOxghKvLfjgZezfOdlIRJoXcMKdi5uX7rqjMKqqwzTwb4I8=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5856.eurprd04.prod.outlook.com (20.178.204.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 11:24:30 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::70d0:cc68:4c85:9bc2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::70d0:cc68:4c85:9bc2%5]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 11:24:30 +0000
From: Peng Ma <peng.ma@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Subject: RE: [v11 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by FSL_DMA_IN/OUT
Thread-Topic: [v11 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by FSL_DMA_IN/OUT
Thread-Index: AQHUb/nkHnTheD6ZH0+9U5VjtKPEZqVwpcKAgAEmanA=
Date: Thu, 6 Dec 2018 11:24:29 +0000
Message-ID: <VI1PR04MB44316BBB8821ACD7F9A348EEEDA90@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20181030023604.34027-1-peng.ma@nxp.com>
 <20181205174923.GU2847@vkoul-mobl>
In-Reply-To: <20181205174923.GU2847@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5856;
 6:QTJgukB4n7dR+uaifdt348Sfkuj5Bs3pLAXylaH1ZA/IzPs4NL/PmsXfWwaVOznCTz7fpMZmQPgOReyXMJGSJrwbdUXICHw7wnaTIX6zf6+tfNguvhN4pWcv5yRaxDIpdxJolTUWzp1+jYVeIWo9c7DFLNaxVZstzJZnmATtwyzhSzpshiZbZ/JcVvxl28lqe0wawG8bmfzxDCkYhdHi0oaTHvWYVyb0qCvQtEzoO0S13vfnTd7DVRjlasRwSz5AW5Yp6Z/DwPJsAy7h/x+ufKQW+OwyFIcu9IXqYuP6vx7OVYMG2ZXMcDKsq6DK+nIIMERH7kiWSMPpQqBV7jN4paPlUIhIx12GhmmPoADmevBFvJ6k2CoZBxgfCFgFwBW7NTONjY/9Xjtn/J5MbxtrUHDplU5GHnNN/NdnHhoHOoSBeBxACKZeq/nq6AzwZJtej0fn0b7nBE+xTQwwv2ZU2A==;
 5:1BoD6TtMajAQwEjZmsGmJu3ymftYtTU1octcrGQcpqLlLoL6EIAYgtbzkeGhtFjDguVnNqtZ3bzNtVgsam/IQdM2oNzhe5XtdBgOnJ5o2NYb1toQIauZ3PNlJ88RDmXXvF2kas1g7Gsk2e94hW937ChiGBJ9Z7Dm5n0hEf/x4zI=;
 7:LU9k/DNF2qSl+RM0ipz55+J0lArjHrYjP+7tDhGArIOVuBhqatdkL92e+RkVPqThGHdQXLM7Xd7eL2tyHLDGZQljBifF+TMQVTS8wOmpgqzbH9juZ1HYiLhLlescYPaKju1B8oxIk2E15CNovJqTBw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 600c6ac0-d579-4e8b-ca47-08d65b6d6399
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5856; 
x-ms-traffictypediagnostic: VI1PR04MB5856:
x-microsoft-antispam-prvs: <VI1PR04MB5856A4214E99E4B0968EE7E3EDA90@VI1PR04MB5856.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5856; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5856; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(136003)(346002)(366004)(396003)(189003)(199004)(13464003)(106356001)(105586002)(53936002)(44832011)(33656002)(74316002)(6436002)(256004)(4326008)(14444005)(3846002)(6116002)(6246003)(99286004)(5660300001)(97736004)(68736007)(54906003)(476003)(102836004)(316002)(478600001)(6916009)(76176011)(6506007)(486006)(7696005)(26005)(9686003)(186003)(55016002)(2906002)(229853002)(446003)(11346002)(7416002)(71200400001)(71190400001)(305945005)(14454004)(7736002)(25786009)(86362001)(8676002)(8936002)(81156014)(81166006)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5856;
 H:VI1PR04MB4431.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g+rySMn1dc7baHB0+aGrKt5i0EsriqDh2GpVP1+L1F63rRtwV+VADWfiz3yg0n9T1qAxoTs1Ut5JbiPUizapGR7S2sR48pVive5bpPnabF59DW7mq2F0uTeL7odt93yDZ9Gah5N3tGtgOk8F93Jgw9lVQ9WMYRTZ3E4/eqTJr8rlsD/xRSeiLYRoy8MHw7n9ihOuq+CTkGP0eZqWRZTVUCnU4pFNKkRcnhNtz2jcMEGqzwHULIB1TX5oWS8O4RO8tsQdzsi1dLt0oNDoW9yjh8VoftSaYYvdwZbmHux7bp3vQlbwFRGQS95w+jNjPsph9ed+xUq9IUwMB2Lhpxcx04p3c8dE9Y9E4/zvzmGZb4c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600c6ac0-d579-4e8b-ca47-08d65b6d6399
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 11:24:29.8849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5856
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_032445_146909_67F4279E 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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
 Wen He <wen.he_1@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "zw@zh-kernel.org" <zw@zh-kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVmlub2QsDQoJDQoJVGhhbmtzIGZvciB5b3VyIGFwcGx5LCBJIGhhdmUgZmluaXNoZWQgdXBk
YXRlIERUUyBwYXRjaCwgcGxlYXNlIHJldmlldy4NCg0KQmVzdCBSZWdhcmRzLA0KCVBlbmcNCg0K
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogVmlub2QgS291bCA8dmtvdWxAa2Vy
bmVsLm9yZz4NCj5TZW50OiAyMDE4xOoxMtTCNsjVIDE6NDkNCj5UbzogUGVuZyBNYSA8cGVuZy5t
YUBueHAuY29tPg0KPkNjOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8NCj5MaSA8bGVveWFuZy5saUBueHAuY29tPjsgZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tOyB6d0B6aC1rZXJuZWwub3JnOw0KPmRtYWVuZ2luZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj5s
aW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0K
PlN1YmplY3Q6IFJlOiBbdjExIDEvN10gZG1hZW5naW5lOiBmc2xkbWE6IFJlcGxhY2UgRE1BX0lO
L09VVCBieQ0KPkZTTF9ETUFfSU4vT1VUDQo+DQo+T24gMzAtMTAtMTgsIDEwOjM1LCBQZW5nIE1h
IHdyb3RlOg0KPj4gRnJvbTogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPj4NCj4+IFRoaXMg
cGF0Y2ggaW1wbGVtZW50IGEgc3RhbmRhcmQgbWFjcm8gY2FsbCBmdW5jdGlvbnMgaXMgdXNlZCB0
byBOWFANCj4+IGRtYSBkcml2ZXJzLg0KPg0KPkFwcGxpZWQgYWxsIGV4Y2VwdCBEVFMgcGF0Y2hl
cywgdGhhbmtzDQo+LS0NCj5+Vmlub2QNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
