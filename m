Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EBEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:51:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAA420859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZlqJKzMj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ga4OWwBJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="zhwl852R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAA420859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zEivqJmXVrGLNb2xkKO8kStr+gbX+t6RbYDXfo2yTmM=; b=ZlqJKzMjRLAi5C
	xfT0u2U0H0NJJnJYS7zW4Cr1mdmeN90RKWkSEhHt2gQpb+Ec3O0ziamwXZTc7vKho0srXoetzbRZC
	yHX1XAU+8pQVDO0Zs7hxNqQZuK+BOdRdgQ55rP0jsZ+vvh6PQ1tIyMYDXWpAYJidGATqmkHjP1+PI
	cVjjKC0cjtEbNBGZ7julfH+b1oZzXN6htX9di6e/du5XWta/aN6QfwS6BDDhXqd+R/UH+qrkqQLrR
	XkBo0ONZyq3anSQB4UrP1wjUkyNi9usuZPHZNC+ThKt2CXJq9QMvJzCanvYSWOs9AKjPhb2EM+iYD
	DSDSW5Wmbq2EnkpYmVCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggRZ7-0008FT-9x; Mon, 07 Jan 2019 09:51:25 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggRZ5-0008FA-Vp
 for linux-arm-kernel@bombadil.infradead.org; Mon, 07 Jan 2019 09:51:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
 From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VuWxycnrM4OvrEIP0JP2bbqCNSS1ZgKwFw8o2KcqDAI=; b=Ga4OWwBJNYf2q+1HtFO1dS4T0M
 IeEnbannpx8gW1YvTlUcesg9WZpDTIn07XnWU/C2Gvi/DjsAsuoQcpsbt/0RhqLsktzTVdgYfRwqK
 Qax/fVWMJUyEImtKk2XAkVJGGgxSj0nhGIcncwijrL+UpqYLMskDKeoDWLtHntZO+jt57mEEE/LrK
 FOAgM4wFMZhis26Y8rr71Ze2t2qWaY0IJhVPi1Uepi/AoOr0UJ/nA2G5aGWGf3XQNsUUEAH8HJOuY
 ZHJeP5yMzCKnOqbSCidoMUBgzXpFp6sgVyAbWS66sbAhEHY3MmbBHeB0y4Po3oTBhOY4T7aNsrMUO
 RhWr3+Fw==;
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggRFS-0002tf-9p
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 09:31:08 +0000
X-IronPort-AV: E=Sophos;i="5.56,450,1539673200"; d="scan'208";a="25005031"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 07 Jan 2019 02:31:00 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 7 Jan 2019 02:31:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuWxycnrM4OvrEIP0JP2bbqCNSS1ZgKwFw8o2KcqDAI=;
 b=zhwl852RXfENWqosqtoqaPjAlquByrImOkO+MFTY/glYbuLQa4HRdbyzz9YESaS2LBVMtphbp2bTmXfT11quXsGSY9TRykEV6w1l0SNrdKdZDA71pisoprIJUr5gSWBcHzItadCnSvm0cWr6IQ+gI5bB5LKpIldbR6Ke3VAs/qE=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1726.namprd11.prod.outlook.com (10.169.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 09:30:57 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 09:30:57 +0000
From: <Claudiu.Beznea@microchip.com>
To: <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 2/6] pwm: add PWM modes
Thread-Topic: [PATCH v8 2/6] pwm: add PWM modes
Thread-Index: AQHUo2hlGTRebPui4EWivBrexXjs46WhJyiAgAJpXwA=
Date: Mon, 7 Jan 2019 09:30:57 +0000
Message-ID: <49535296-6b5a-ae66-c8c8-100ed435fce7@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-3-git-send-email-claudiu.beznea@microchip.com>
 <20190105204109.hejk2fkabkv3y5ik@pengutronix.de>
In-Reply-To: <20190105204109.hejk2fkabkv3y5ik@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0048.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::37) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1726;
 6:kdNSD/0FWpGD3/3FKi0/Slx9z29U3Q4sLzass37yM2zpGEOTjp5xFDSo+v+fBqSthecOFusI9F3dae4A4q0BJdBxNcJkIoqNV/W696WUXDtQxBaPYbkgEd0RD57Lb5XfN1QtLIEDFnrsjSrUmZd4O5GTvf51wMR8dCrkGGP0ZMy9p+RGjaWiznKGRaDknWGfdpf1+LWGDHNuk2w2Fto0zKSWCUwIDlC4jaI24Fk5nJUAxW0n3sV/knYcZoGkXtFnk/gYenj4dPI9S2/y6sv+82nZ+/yzOlUKsG0aYDkAqQhrb7JGVi/v0+qkk7oJmK0rrFZKZXizvBRk+IKEnsi5RXGOxTkf9MSXhlG3Vlff5pv2w5HINCdhUTOlKmRRhMELi3FBhnjTOBm25Kle/eBb7RT2rcUf1tYNvBcO83FIZ2PuEC9EScsHElzl77x9mZO5Aox5XTwqAYLgyoeGtrlLMA==;
 5:yWcvKRag80K1ZfIjefQTUGzo+jYu8nIKNU6ZcpQv9+Qy9S2AjA6Tn+dmjJNyDAVwmC/8wtWibdvkYXPiApiN5Efrt+Ad9EwP/DizunPTz6HowBioLNRlvtw/rPZA/n+qqYlOfdu3WP+bT4U2t9VpK/rkvsEVZDdGZEYdZK0PPL7jjX3JOTa3nCDTsp5fWVOJzFT6451LOPCMJNqbFLHblg==;
 7:8BK9+4/XExI4CQdBFXVMo5xNJFTHEvQ7EqVkiM5qcnZSL+ZrV0c9hC09HFJB5eMB4gnaDK6EsoKD/VRSqs4/+JwCySqxGYhwDhGm3l6bevst+wnxlb8c5KuQRY+sbWfyTSHqCE9Rwp7wWs819lqrhA==
x-ms-office365-filtering-correlation-id: 74c3f90c-6343-465e-5636-08d67482d42b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1726; 
x-ms-traffictypediagnostic: MWHPR11MB1726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-microsoft-antispam-prvs: <MWHPR11MB17260EAD4BC2CC8A0B47CEEB87890@MWHPR11MB1726.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR11MB1726; BCL:0; PCL:0; RULEID:; SRVR:MWHPR11MB1726; 
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(186003)(25786009)(53936002)(6246003)(229853002)(6512007)(97736004)(256004)(26005)(31686004)(52116002)(3846002)(305945005)(54906003)(76176011)(39060400002)(6436002)(7736002)(6116002)(14454004)(102836004)(71190400001)(316002)(99286004)(105586002)(446003)(72206003)(2906002)(106356001)(71200400001)(5660300001)(11346002)(6486002)(66066001)(478600001)(386003)(36756003)(53546011)(6506007)(6916009)(81166006)(31696002)(2616005)(86362001)(68736007)(4326008)(476003)(8936002)(81156014)(486006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1726;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nWF+HurbgGKYbFGsn+hog6Xkioi0OC9XEqarABmp+SUCHOD2+4VArG5VSAhKqIY7TZHAJmz8fk40J/iNXhEvX8MiZZISegGcTAX8oJO9cEteZZt2cRA2+TxTkInOuZ05tdywa+AC9GNgGBZ4QhDig2Nh2QCKkQVHwvTbZC7oL1AZ0p9LExjQZ2WZ/PtQeQHQXktFfZ52Scty6n5akIkEIde5cb/0/4r8gOP3DTpjQ9tQeufe1bQHt5jXTWofgALlVv2MWzceFzcQ4atefWY3x5YfFdRJYTqL9IINMueZtIzrgS3SjArJDIwbx5fAvTR8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <C4016C818D915A4A8CBAB5E24A8F2BE0@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c3f90c-6343-465e-5636-08d67482d42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 09:30:57.6816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1726
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_043106_480597_2983DC7A 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DQoNCk9uIDA1LjAxLjIwMTkgMjI6NDEsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBU
aHUsIEphbiAwMywgMjAxOSBhdCAwMToyOTo0N1BNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNy
b2NoaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVh
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gQWRkIFBXTSBub3JtYWwgYW5kIGNvbXBsZW1lbnRhcnkg
bW9kZXMuDQo+Pg0KPiANCj4gVGhlIFN1YmplY3QgbGluZSBhbmQgdGhlIGNvbW1pdCBsb2cgZG9u
J3QgcmVhbGx5IG1hdGNoIHRoZSBwYXRjaA0KPiBjb250ZW50IGFzIGl0IG9ubHkgYWRkcyBkb2N1
bWVudGF0aW9uLg0KDQpvaywgSSdsbCBjaGFuZ2UgaXQuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcw0K
PiBVd2UNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
