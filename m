Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD37C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:22:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6C62146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gtGPDBon";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="Di52SGaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6C62146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y5Rs5y736A1i8OMos3V+5bFa3Rqm5nNk2jyvRwKopB0=; b=gtGPDBonI5LPJ+
	4hGimoN5bsAFCv2YjedUBaD3OFsyvBr44hXk8M8AsSaJT1Pbbu3u7lN9Jg993kK/6loBqQGw7WknO
	Tv0G3wAWtQBvMrFWKSzP08xA68T0wCzuHqL+6Ok/w2/kaodteNc/Hi21rlHxcvtkTJejI0X836awj
	fzkQYsJx1CZie28qC2yeqHf+msI7DEMuUzd03JDEv5IjxW+ij3St5iSYn6nyNuMFkv6fgWAAIjLts
	MRKYCUQv/R2M4fVd+lXIUMs9VYVcHxN/Hk6Pi/PLe5LPao3UgxxMuIt25gU1U4x84Ve30cJXCwYQg
	pB/yhgY6GPkz82VGkW6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmUw-0003zB-Ji; Fri, 30 Nov 2018 17:22:38 +0000
Received: from mail-by2nam03on0728.outbound.protection.outlook.com
 ([2a01:111:f400:fe4a::728]
 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmUG-0003Ih-0p
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:22:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWw9bm4zAUA7uzTSn1beDYsgK6y7rKt5JFfEP0yuuRA=;
 b=Di52SGaE8z+f528MMawrZhSGJOATJ57cYQII0nF9lNKoVL2nyvA22OkwLg/JgBNWSrVJih+V/q9tcoXNBUlebzj3i8Y3djysVutfYISeeFw+dgK50h1858tcqBCotqW2wM7kgeBkmxL9RqJxf0Dp07PGgxE4o2D1mv+dmdvNhEE=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3705.namprd06.prod.outlook.com (10.167.236.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 17:21:40 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%4]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 17:21:40 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v3 5/5] spi: imx: drop useless member speed_hz from driver
 data struct
Thread-Topic: [PATCH v3 5/5] spi: imx: drop useless member speed_hz from
 driver data struct
Thread-Index: AQHUiHie8XJQdvANZEudWVICQLazS6VokVkA
Date: Fri, 30 Nov 2018 17:21:40 +0000
Message-ID: <1543598496.18519.101.camel@impinj.com>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20181130064709.6998-6-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3705;
 6:zKDesffML+NAlqHx+ERRgUt6EilA30Ji5tf6apedMfv07L/GbQ6txsrVtjigTmz60sDMRiR8q7TmcK/ZGBaIjpJrOunu69EAluDg/4DZQhf9gRWEgwdf102xIrt0jBmVpOhrO7Cytjt9N/IcvV0LpZrrViWT02ijV1rhDjRURy7CSRdJ2gtwZgY6b+ab9/U1FvV3V2Iz8CqAm6bwfJhq6qracNNWRxIV5KaTMTBCa4vWKvTzLe1A15gucIMIKq9P/sLj7oB58OEvBIICLIIcqByuwQE+oJyK92Dc62qgBLP3y9oAsXlPaGGzaEWxaKWBMEEI8mxL7kyqL/MyAMFKQyxCFxkUlszL6UGqOrBNhR4A3U109MdX8ybyAcDJNSXRm0yHrXVPR4D+gRt8tKbuIyzX8+ntTp5ucSdDMe38Lglk+AQmL2cfgnePgTou6dY3db/+1NlOJqrH5+jzeYiZug==;
 5:gBob3NnfZpbXTfIvmoHCh4Aax3yUt7gHAGWNICJ85nqdROle8Z7NDAAp/y8o6o3UDKbB1d6Ii7yp/VWhn3J7YcaEgh6yLmhD6u57f6M9NsdvaT9B9xwJRTtT8nYLg2q75qzdTaifakHAZuY/2pIOrM6gxUrkH6LWSTrUoZqiPEQ=;
 7:sGuiQuSKbLpGV2RDhkUSCPwV5mpstUgp9hTgoc1kUNHLK6rvHzLvTKeU/gjF9cfmH/EhOEIYh2T9JaMEUzWhtOHiKXaAoCLYsG1/wtnyOmh3bzu9WopwSEDspx7TMflOdRJF0wj/JMyjONKy/XZx6A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf46820b-1ba9-4cc3-6359-08d656e84ad6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3705; 
x-ms-traffictypediagnostic: MWHPR0601MB3705:
x-microsoft-antispam-prvs: <MWHPR0601MB37053E726AC918FF0B6817BDD3D30@MWHPR0601MB3705.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR0601MB3705; BCL:0; PCL:0; RULEID:; SRVR:MWHPR0601MB3705; 
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(476003)(4326008)(2616005)(5660300001)(6506007)(446003)(11346002)(486006)(66066001)(186003)(26005)(103116003)(478600001)(102836004)(14444005)(256004)(76176011)(7736002)(6436002)(36756003)(6512007)(106356001)(105586002)(305945005)(99286004)(54906003)(8936002)(6486002)(4001150100001)(8676002)(229853002)(316002)(53936002)(25786009)(66574009)(68736007)(6116002)(71190400001)(71200400001)(97736004)(3846002)(2501003)(2201001)(14454004)(86362001)(81166006)(6246003)(81156014)(110136005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3705;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zkBdIB8s7/Bxr65THCGURxNt9flZP6C9PIOtVqRBfIAwJ4s+cyLq75nlKC+RHDRh9VJSWwcesjVTxHVh82ftmOosiZ5SArJI2/2M1Z16asaSJVdsDei1bt9RhovOh7BH1bsrn6IVuN2FAW3Mdo6DgUpjnA0QA01+UCkFit4NantLU+B/T5SfaOKrbAWM5iVAPuCYCalh+ldJKgIORqr1waYOw1SEpJyzZ6cW61k7CLFfueqgsTbLDRGDcr+ZEoZSrWAdTcjXpMh5RhGF6A2MofWzm6giqT3oWBjDUu/0lVDe8C7kuZZwp1laB+2Ppu6krlxzKnZouDU4k/qUpyCu1TyzHchH0XyKLCsWaHPWyFw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <00CA1E85BCA1F3498BCB55D8E03FC353@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf46820b-1ba9-4cc3-6359-08d656e84ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 17:21:40.6531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3705
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_092156_856232_C827DC1D 
X-CRM114-Status: GOOD (  12.39  )
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
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMDE4LTExLTMwIGF0IDA3OjQ3ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gVGhlIGRyaXZlciBkYXRhJ3MgbWVtYmVyIHZhcmlhYmxlIGp1c3QgY2FjaGVzIHRoZSB0
cmFuc2ZlcidzIHNwZWVkX2h6DQo+IG1lbWJlci4gQWxsIHVzZXJzIG9mIHRoZSBmb3JtZXIgbm93
IGhhdmUgYWNjZXNzIGRpcmVjdGx5IHRvIHRoZSBsYXR0ZXIuDQo+IFNvIGZpeCB0aGVtIHRvIHVz
ZSB0aGUgdW5jYWNoZWQgdmFsdWUgYW5kIHJlbW92ZSB0aGUgY2FjaGUuDQoNCldoYXQgc2hvdWxk
IGhhdmUgYmVlbiBkb25lIHdpdGggdGhpcyBpcyB0byBjb21wYXJlIHRoZSBuZXh0IHRyYW5zZmVy
J3MNCnNwZWVkX2h6IHRvIHRoaXMgY2FjaGVkIHZhbHVlLCBhbmQgbm90IHByZXByb2dyYW0gdGhl
IGNsb2NrIGlmIGl0IGhhcw0Kbm90IGNoYW5nZWQuICBTaW5jZSB1c3VhbGx5IGl0IGRvZXNuJ3Qg
Y2hhbmdlIGJldHdlZW4gdHJhbnNmZXJzLg0KDQpzcGlfYnVzX2NsayBjYWNoZXMgdGhlIGFjdHVh
bCBzcGkgYnVzIGNsb2NrLCB3aGljaCBpcyBvZnRlbiBub3QgZXhhY3RseQ0KdGhlIHNhbWUgYXMg
dGhlIHRyYW5zZmVyIHNwZWVkLCBzbyB1c2luZyBpdCBjb21wYXJlIGFnYWluc3QgdGhlIG5leHQN
CnRyYW5zZmVyIGRvZXNuJ3Qgd29yayBhcyB3ZWxsLg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
