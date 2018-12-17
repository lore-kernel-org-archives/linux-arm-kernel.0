Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2815C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:31:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8B82133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JZDScEaW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I0uuBY2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8B82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kq7UOvc1OwCnL6PCK9iNccBOqFHaVVU6S8N5kMJVSjY=; b=JZDScEaW2kZ424
	YabHJg3wlMBhIXgrgJtOSMuUsJQEE95KsiJoF3Fu50oHy2GW5ww5TR+gZDlKmV02Dm4eqEYo/79py
	m01xmiSSGPmOHTBIx8Xfg+YiyaBwkibhz8Eh0M4Zcrb1xnSWa5DMaUcSwmIkedwNiixkSfdDehky+
	Emx4ogbgvdpiH/vw9ySIE+ycvE2+ZOStlp2TIZRcom+A+Tf0rZSUcN1JYJV+yIWav3gRM07itH0c/
	mdiGbyyQmiqgsGAtOlU3e7bgpyF1fAA3xVmImV3ezhzHp8IB4c1YfdZzPvzOGJZC9Z8CiwoIIKohn
	ppX82sUwIwNmqwM+lZOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYqB1-0000bR-SJ; Mon, 17 Dec 2018 10:31:07 +0000
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYqAy-0000Zw-UO
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 10:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WedQ8U4Yqd+/+fMzsdW8wDZY0HYmpxqVmGqlmoyULJQ=;
 b=I0uuBY2TlA9YgqWo1BDE2v2gOufUJIHfnJkrDrDG6wAFJsvJNGbxIGKNKv6tkjdwnjJg60voUjrZkVTwOKzwTBbIYxNzb17FATgmv83YDOkr/z/WPkTgo/iov0sNK5VUKDrEfFBUxHyvq4A8KJpAOt2vsxhM4po9u0Js4WwdAQE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4161.eurprd04.prod.outlook.com (52.134.125.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Mon, 17 Dec 2018 10:30:50 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 10:30:49 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Subject: RE: [PATCH V9 2/7] clk: imx: add scu clock common part
Thread-Topic: [PATCH V9 2/7] clk: imx: add scu clock common part
Thread-Index: AQHUi98nS3QbsFuE9k65NTuug/+jZaV4jpEAgABYpPCACedhAIAAAEww
Date: Mon, 17 Dec 2018 10:30:49 +0000
Message-ID: <AM0PR04MB4211990EC26C327AA2649C1080BC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-3-git-send-email-aisheng.dong@nxp.com>
 <154447896872.17204.13777399275077720705@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211E44C3B64033C3795BDB380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181217112752.07e43d05@karo-electronics.de>
In-Reply-To: <20181217112752.07e43d05@karo-electronics.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4161;
 6:v1lDytCby0jFov/8Vv2DglmBZYoiM8jdDwvow2RqrM+faXHAbE/G/RJtQsh7GBUlfa/cW43azjLLwMHLbGrdZdxCJaEZ3jHdeTktil8X8pTSOJDPElvVKX36SIuD0MwFlnfqP7kvi8uTZhFl5YYh1sn6KVhw5V0ftk7+0wzm3dtJoMCz5yovKV5PwJWFLUB3AqikFp2rFBHZ3vnf2HfEYDj4CHf2PgfwT0kn2pw+gc9AjwSJEQFq+dJHRDQcOmlqYehoV7lY/g0iKDEGMTISLfF52uHT/xvdT6/L1qEzDg7iOofvTNWWzobrooAbTVel34CPTvBRkWIC15+HonfAe0b1v1XWu9+B18xtoJN2gsDwZK+IST904JSmJQgnPRunSA8e8HkFZpGbnBJ7glAjkTX77RDe9/TKaSV9a/NwNA6YZeTzA++OTrAFj3wRmZJDXto+GTc/cv/pgGAqxaSGng==;
 5:oguVbF8gA8rQI1lK6IAmFWWtV2d/2jjxDjYwfhzxqAoyIGahrwHxzIOlKCJ0sqzLOrkJCrmPe9SINK7qNHICW6BemF8brdaxZgi6MaGCvPG6vml9Th10a7bRExeNB5beejotWS2POft8KbxSAYtAUoH0kZLmzykXEL17oZ6z3yo=;
 7:ZXDWepJMj7pSy5qhEwqRI9jZLoKImPrazR6/TL8PSDcipcKOUrATBNmeLzJJSQRBQYNHDdxQI0KB8iObm5hpBLylv8JoeglvTuNIxJD1TAiAcIXS9+m8WmNQWJlnyW274qFWvxLHJ1LwspIUt7UVYw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: be4c1c42-1733-41bd-12c9-08d6640ab6d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4161; 
x-ms-traffictypediagnostic: AM0PR04MB4161:
x-microsoft-antispam-prvs: <AM0PR04MB4161A71881384213342FBED780BC0@AM0PR04MB4161.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4161; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4161; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(446003)(11346002)(55016002)(486006)(25786009)(6116002)(99286004)(6916009)(105586002)(256004)(6246003)(229853002)(53936002)(478600001)(106356001)(74316002)(305945005)(86362001)(2906002)(68736007)(8936002)(76176011)(6436002)(71200400001)(8676002)(7736002)(186003)(71190400001)(66066001)(9686003)(3846002)(14454004)(33656002)(44832011)(97736004)(26005)(316002)(54906003)(7696005)(81166006)(81156014)(93886005)(6506007)(102836004)(476003)(4326008)(5660300001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4161;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L+f5nXwoxX6ClMfXATfj4NMICb1hM0xkAQWGfwTv9b6p+OGPMZBfL0J/yORJ29V8Bnk1xTd+WW6AmMF88AyBA+sJ8Eb8m3BYUdWmnTufM+L3Dj9JiSR2qqGsUWdDDn7wBuvJiqLsS6c7uou2IGjYQBnd6odwrwxvU0GBO6g0HDz9IKFeB6YPH1K3dAkM/cmeRFQyVlweU7CHpOxWAe1pb60A2aWJTRlso+nYLhZBIL/VvxxTZL8W05poWf445DXU+ivH2w3mbIB65MWZyGeFv83lusAOFtk04udzTJn8uQbFiQEnXuCo1NUU44qJVlr4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4c1c42-1733-41bd-12c9-08d6640ab6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 10:30:49.8524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4161
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_023104_982430_5C929791 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Wy4uLl0NCj4gPiA+ID4gKyNpbmNsdWRlICJjbGstc2N1LmgiDQo+ID4gPiA+ICsNCj4gPiA+ID4g
K3N0cnVjdCBpbXhfc2NfaXBjICpjY21faXBjX2hhbmRsZTsNCj4gPiA+DQo+ID4gPiBXaHkgZG9l
cyB0aGlzIG5lZWQgdG8gYmUgYSBnbG9iYWw/IENhbiBpdCBiZSBpbiBlYWNoIGNsa19zY3UgaW5z
dGFuY2UNCj4gaW5zdGVhZD8NCj4gPiA+DQo+ID4NCj4gPiBObywgbm8gbmVlZCB0byBiZSBpbiBl
YWNoIGNsa19zY3UgaW5zdGFuY2UuDQo+ID4gVGhlcmUncyBvbmx5IG9uZSBoYW5kbGVyLg0KPiA+
DQo+IFNob3VsZG4ndCBpdCBiZSAnc3RhdGljJz8NCj4gDQoNClRoaXMgaGFzIGJlZW4gZml4ZWQg
aW4gQ0xLIHRyZWUuDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IA0KPiBMb3RoYXIgV2HD
n21hbm4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
