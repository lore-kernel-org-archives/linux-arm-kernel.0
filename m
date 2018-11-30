Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4DDC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:10:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610AA20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C+zkY9/k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="DvRSvE2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610AA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jaKDe3A9B0lN83iXotKxsp70pNMxVQXmhmWdVzL67dM=; b=C+zkY9/kUXgEiF
	p/BXnN0Ey7J1asHuubzwQgV47V7Az5ZoujSRPH6VkdK8ixn6+Xm+wIU/GzfdX/ZBfxzAYCCJJsDv4
	zoENApl2Od3zlcobcfes5EPs0zr/HcN5LclwliblwMBXxZbrGQk4Pnlp0FMe35hj9PP8f6wP9F2eR
	XiwL2h2y0vcIZ4WGsRHeCWJUkIBQDomBCzJ0xr9yBA84Gb8VwcQeXJdZEqjvor2PGpKu568sn7iKi
	uZeTweIIWq4NLU2pUhDI+tWW8G0GcERPGkt/ULswDg0kXmcg/M4w7QOWmSAYVVmn0VzlplFFhV+6M
	MHTuJBhidNknllM4KKWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnFU-0004P2-NI; Fri, 30 Nov 2018 18:10:44 +0000
Received: from mail-eopbgr780093.outbound.protection.outlook.com
 ([40.107.78.93] helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnFP-0004E7-Mc
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoxysAVF8SYBSmBqlm9LT0H+l1UilkltJquqBQ309F0=;
 b=DvRSvE2eKHUijqZXzMcruXVTeIKWtjPzEVMKLRqACWaB/qHxJwrACWmOZdvPya1arhDzVTesV9TnIMOWyQDymPwHnglYgyygvVH+/zqaALwlNErsLNrFP7vBSITixpMEOe7ZyAlaPcYzyqy3YNgdumjAYGSjXTmf9VAHOVU7TYw=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3626.namprd06.prod.outlook.com (10.167.236.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Fri, 30 Nov 2018 18:10:26 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%4]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 18:10:26 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 5/5] spi: imx: drop useless member speed_hz from driver
 data struct
Thread-Topic: [PATCH v3 5/5] spi: imx: drop useless member speed_hz from
 driver data struct
Thread-Index: AQHUiHie8XJQdvANZEudWVICQLazS6VokVkAgAAH9ACAAAWwgA==
Date: Fri, 30 Nov 2018 18:10:26 +0000
Message-ID: <1543601425.18519.108.camel@impinj.com>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-6-u.kleine-koenig@pengutronix.de>
 <1543598496.18519.101.camel@impinj.com>
 <20181130175004.iiduvgzwwij3fvof@pengutronix.de>
In-Reply-To: <20181130175004.iiduvgzwwij3fvof@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3626;
 6:8YQqHbawAyw+rrWtusnK8o0HsGsVy95xXXeSBF1ksSjv9qe+Zf2yNnERPhJwAkqLLrgbMUUN6eYbp1+8K+SzqYcMT1orUlIeCp61RvwjpQv+kVfmB/7YlRaCdUSS9EX45uro061nP5x/4pe9zivU37zqvJXkSGmYyv88FS/sUCBnm7fkDbvTANBeOPgCQoP0EHUEa+7rUwjIe5zF8y1QzCdZfDVo/IYbNDS6Oi5WHRi0DrWBG5IpmGqU/jEk6DBJhYqggvpKbOdAD0MLWgd3QoMV062LHQoqY87bjctZfX5yhM78u/7i9KHzdG68CG9XGGcKgVJS1v9TCYvSXdczyeUrJSK13g2LnX3ZVWjXU+WO+0xEFmaDj48qf2KSj9TmK4hWM6vdxXNUJtxH7xx7Pv5rwhbbTj8oe5Lzbee6mKTOdAiMT1M/Rn4x2nFLAo1bO0JW463Vt2IhHFiWRofibw==;
 5:hDhak3z8ulQ5PHZVWEnbdExOLb2lgOXX+jo/Fb0j9fMoZaNB33Ns+9TVfDMIhdb5Tb5Tf0BQYyaTCK6rBWtXv8O+l6E0nhK7onT6YbTAzryM5JUVGzxLloAN3U0K85QeK8JxUeHr8xD5tMgvclxzF6Vud8+dBXoX8AmBLb6+DNU=;
 7:05jWTO5kXq9Y1V6VLxqPe/qjOn2HVciGZn0eUPRXCW+yqZH6LPCS/btA2lk2it4iYUI53guUhKylo8X1DGsU9zKg92/MWfvh9G40BwXaRgS/HWdkmaslPEev9AOdcIpYRtVBHWc1BgJpKsWLW61mLA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0b3ad9c6-f461-4380-39c2-08d656ef1aad
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3626; 
x-ms-traffictypediagnostic: MWHPR0601MB3626:
x-microsoft-antispam-prvs: <MWHPR0601MB3626A89FD92BBE1553EB51FCD3D30@MWHPR0601MB3626.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR0601MB3626; BCL:0; PCL:0; RULEID:; SRVR:MWHPR0601MB3626; 
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39840400004)(199004)(189003)(8676002)(102836004)(6512007)(86362001)(53936002)(81156014)(81166006)(4326008)(25786009)(5660300001)(6506007)(186003)(6116002)(3846002)(6436002)(68736007)(103116003)(105586002)(476003)(6486002)(486006)(2616005)(106356001)(14454004)(11346002)(93886005)(26005)(446003)(2351001)(71200400001)(71190400001)(6916009)(256004)(14444005)(66066001)(2906002)(8936002)(99286004)(316002)(54906003)(2501003)(36756003)(305945005)(6246003)(4001150100001)(5640700003)(76176011)(66574009)(97736004)(7736002)(229853002)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3626;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m3CMauQUig7M+ctFn4mJiSOQXh6lPKAcITwMagUfwkXJap5vbnio0xsBoXbGrp5519SSQgHJM3kvLtLRloxEjvnTqwkk9e8Pedikf+BFfPdmHeYAzTWliCdC4NUMSCjdV3oVwPGqc8wLumehjvAMaZ4pYE+4rn9zqgduegE3sUGKSmW9D3YI67nG1ftR/4e8bZqBDhSMhGfENfwCRxcrx8nMFDIoiR5aOo73P8WqD8xclEkGcGmQCkqelGPkGo8sGIjpCZDijolmLa/vgpfg8g1N4B3KR3NwDZplpozGwLRmqv6y7EEpHRJcvW6evfeObk9IJSB1yJmSClzGDHFs4lEXRTHqPVQJwCXoHgZNCpw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <20F18A88CE1A2740B8C43971C6C5FCB8@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3ad9c6-f461-4380-39c2-08d656ef1aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 18:10:26.3298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3626
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_101039_876405_91DA57A1 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: "marex@denx.de" <marex@denx.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMDE4LTExLTMwIGF0IDE4OjUwICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gSGVsbG8gVHJlbnQsDQo+IA0KPiBPbiBGcmksIE5vdiAzMCwgMjAxOCBhdCAwNToyMTo0
MFBNICswMDAwLCBUcmVudCBQaWVwaG8gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDE4LTExLTMwIGF0
IDA3OjQ3ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gPiA+IFRoZSBkcml2ZXIg
ZGF0YSdzIG1lbWJlciB2YXJpYWJsZSBqdXN0IGNhY2hlcyB0aGUgdHJhbnNmZXIncyBzcGVlZF9o
eg0KPiA+ID4gbWVtYmVyLiBBbGwgdXNlcnMgb2YgdGhlIGZvcm1lciBub3cgaGF2ZSBhY2Nlc3Mg
ZGlyZWN0bHkgdG8gdGhlIGxhdHRlci4NCj4gPiA+IFNvIGZpeCB0aGVtIHRvIHVzZSB0aGUgdW5j
YWNoZWQgdmFsdWUgYW5kIHJlbW92ZSB0aGUgY2FjaGUuDQo+ID4gDQo+ID4gV2hhdCBzaG91bGQg
aGF2ZSBiZWVuIGRvbmUgd2l0aCB0aGlzIGlzIHRvIGNvbXBhcmUgdGhlIG5leHQgdHJhbnNmZXIn
cw0KPiA+IHNwZWVkX2h6IHRvIHRoaXMgY2FjaGVkIHZhbHVlLCBhbmQgbm90IHByZXByb2dyYW0g
dGhlIGNsb2NrIGlmIGl0IGhhcw0KPiA+IG5vdCBjaGFuZ2VkLiAgU2luY2UgdXN1YWxseSBpdCBk
b2Vzbid0IGNoYW5nZSBiZXR3ZWVuIHRyYW5zZmVycy4NCj4gDQo+IEhtbSwgeWVzLCB0aGlzIGNv
dWxkIGJlIGRvbmUsIGJ1dCBJJ20gbm90IHN1cmUgdGhlIGFkZGl0aW9uYWwgZWZmb3J0DQo+IGJy
aW5ncyBhIHBlcmZvcm1hbmNlIGFkdmFudGFnZS4gSWYgeW91IGhhdmUgdGhlIGVuZXJneSB0byBk
byB0ZXN0IHRoYXQsDQo+IGZlZWwgZnJlZSB0byBpbXBsZW1lbnQgaXQsIHByZWZlcmFibHkgb24g
dG9wIG9mIG15IGNsZWFudXAgY29tbWl0Lg0KDQpJIGRpZCB0aGlzIGZvciB0aGUgaW14MjMgc3Bp
IGRyaXZlclsxXSwgY29tbWl0IGE1NjA5NDNlYWQsIGFuZCBpdCBtb3JlDQp0aGFuIGRvdWJsZSB0
aGUgdHJhbnNmZXIgc3BlZWQuICBUaGF0J3MgYSBtdWNoIHNsb3dlciBDUFUgdGhhbg0KaW14Ni83
LzgsIGJ1dCBpdCBjb3VsZCBzdGlsbCBiZSBhIHByZXR0eSBnb29kIGltcHJvdmVtZW50IG9uIHNv
bWV0aGluZw0Kc2xvdyBsaWtlIGlteDI3Lg0KDQpbMV0gQ29uZnVzaW5nbHksIGlteDIzIGFuZCBp
bXgyOCBhcmUgdG90YWxseSBkaWZmZXJlbnQgY2hpcHMgdGhhdCBvdGhlcg0KaW14IGNoaXBzLCBs
aWtlIGlteDIxIGFuZCBpbXgyNy4gIFRoZSBmb3JtZXIgYXJlICJteHMiIGRlc2lnbnMgdGhhdA0K
RnJlZXNjYWxlIGJvdWdodCBmcm9tIHNvbWVvbmUgZWxzZSAoSSB0aGluayBTVC1NaWNybz8pLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
