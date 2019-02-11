Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CB2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:13:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB092075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PIAptc44";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SEoYiKwf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HpdJD7+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB092075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0vc9qPDlh7hJ9/THOTnckM8mpsHval4I0gqsX/0eRD0=; b=PIAptc445BFG2x
	RjD1/Lg/BPxC78veze4sEmQRfD8Wc5wuPRe5oe8R48D2tjxleXH7uF6ffrSo4c9vuj+USCt2hWhod
	TPDlay73HzUkIyJbathiYiaSUUIN25N4g4dlsbSpzdHUJBZb3pjcXLPjaN2Dzxnfu+JxBP+vkATIC
	LffeHBl5c9RmthCdy/0QcKdxOIOBoyMUs83rmkOTWKHWQsVk/aZQNSZ3Mfvix2NRpM3K6T1rwCJri
	rZNtjL/XM9DFWGuocovgI9RaVJ9doaiMU3hrWLqHEjDj6mg5jHXCk77G3YtB+yIZkQFyTwI9aSjOu
	ch7pgc4i6RdKV8MG00Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtHxZ-0004W9-DW; Mon, 11 Feb 2019 20:13:45 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtHxV-0004Vd-Mp
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 20:13:43 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1BKBicj004111;
 Mon, 11 Feb 2019 12:13:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Qz+71zK4S8O3ulPwvIWUAtdOJf83HKjdiQm2enhhDUM=;
 b=SEoYiKwf35woYtPnRnfysgUcH5hFRMxNJfEzTxEmNnkXRFqkRNQMYKx8ZyzJIeNI4DE3
 9BTV1tEYVzlvwiHJNNveZI3WHfWacWizyBOVlZfv2xn0FimBQ5wdrVnlesBm1Gvlm702
 N1w+x8S3ZtAnmNgjA/2hvM1o9Xz8jGx1tfQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
 by m0089730.ppops.net with ESMTP id 2qkdqc0hbr-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 11 Feb 2019 12:13:31 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 11 Feb 2019 12:13:17 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 11 Feb 2019 12:13:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz+71zK4S8O3ulPwvIWUAtdOJf83HKjdiQm2enhhDUM=;
 b=HpdJD7+p1YDos6U5g5n6MdDEKcdDjZSA1We+fWtkz3sBJsbqkA4PNfiDfXOcy7uwtkctvin/rzxmtzqqzcvUBZypwWsQm5VvGAbblNiKPm/JcDb2yRUFF1/PSfaJ7/BhzQfOWWd8SIqYmwtpeC85/tcyhV5Jls/7nJ/yOfoT8PQ=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1560.namprd15.prod.outlook.com (10.172.162.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Mon, 11 Feb 2019 20:13:16 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b9cb:6dd8:d8bf:45c6]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b9cb:6dd8:d8bf:45c6%2]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 20:13:16 +0000
From: Vijay Khemka <vijaykhemka@fb.com>
To: Andrew Jeffery <andrew@aj.id.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Thread-Topic: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Thread-Index: AQHUs3BeMI31TwUu10WDx7+uo1I7z6W+EyAAgAA2EYCAG+OTgIAAcpsA
Date: Mon, 11 Feb 2019 20:13:15 +0000
Message-ID: <F4D4C25B-5E76-4E50-97E7-5A3548BBA1C4@fb.com>
References: <20190123230634.1815021-1-vijaykhemka@fb.com>
 <20190124081544.GA1649@kroah.com>
 <13C13AE8-63A4-4002-9E0D-70276C529448@fb.com>
 <1549862567.1175306.1655243744.11AFF30D@webmail.messagingengine.com>
In-Reply-To: <1549862567.1175306.1655243744.11AFF30D@webmail.messagingengine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::6:6ae9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR15MB1560;
 20:Wql2j3IidcbXcAwx+D/tNGEN6DTRbV2P2qviYLYjkTbvDUt+68JN028+7C6R8mV46BxFE+GeGJdu++kg6mW8/8t9MQPWe7jLlEpTM7wDG8C5SPyyxJaSCDnkCsQk8fz7Tf35URLU8Ab1Tv5qsDcBbil+Q6eTxLIZYG1C4Qak4bw=
x-ms-office365-filtering-correlation-id: 8866b2e7-bf5d-4a4f-f8f5-08d6905d5b83
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR15MB1560; 
x-ms-traffictypediagnostic: CY4PR15MB1560:
x-microsoft-antispam-prvs: <CY4PR15MB1560497164FE02210C3DA9DDDD640@CY4PR15MB1560.namprd15.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(106356001)(476003)(86362001)(53936002)(6436002)(229853002)(2616005)(102836004)(14444005)(256004)(53546011)(6506007)(68736007)(11346002)(46003)(82746002)(93886005)(446003)(110136005)(4326008)(316002)(486006)(105586002)(81156014)(97736004)(8676002)(6116002)(36756003)(7736002)(14454004)(6486002)(6246003)(81166006)(8936002)(76176011)(33656002)(71200400001)(99286004)(305945005)(2906002)(54906003)(83716004)(71190400001)(186003)(25786009)(6512007)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR15MB1560;
 H:CY4PR15MB1269.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l4Q3YgebybB1nvVGl8s4ruueHKDi8pOlCiZuhSrgcwL08zVWW9Z7skUZWNKBYlxx7zQU7eQ7U2dYrfosmZXCzO+5SMf8UzzVrUSStnMvIJy2bcjkAQ0DNxBNGiP3OlvsfHAW9TSH3N2zBjzOSP0pNgQJYaZMNhM/9l1/eAOyRSZg/OeGJ6urrxuUgrrX9/AaATUYMQwHD8HFv0D9l4v1qJ/3KMor26LLxEV0bN86sb2q9bvqJb97Z/3GObl9M8FAFHKBfB0hrx9j9ckkXynkE/+BcEpfenTgZsx4MwQQXPkjQIzfMQqwM783uKFFVLcr0soLxQRuPq3gbWEkO5onuGWj6mT1XeC2TfCVkaOXAe2M947VebUcbf0ikggwcD/+jyPyPmR7aUULWIVDjODCg5ok1c7RwJq3aCsuyMOX2uU=
Content-ID: <63618F2410F7204090F466D259C31D32@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8866b2e7-bf5d-4a4f-f8f5-08d6905d5b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 20:13:16.0106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1560
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-11_14:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_121341_877756_154195F1 
X-CRM114-Status: GOOD (  19.48  )
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Joel Stanley <joel@jms.id.au>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DQoNCu+7v09uIDIvMTAvMTksIDk6MjIgUE0sICJBbmRyZXcgSmVmZmVyeSIgPGFuZHJld0Bhai5p
ZC5hdT4gd3JvdGU6DQoNCiAgICBPbiBGcmksIDI1IEphbiAyMDE5LCBhdCAwNTo1OSwgVmlqYXkg
S2hlbWthIHdyb3RlOg0KICAgID4gDQogICAgPiANCiAgICA+IE9uIDEvMjQvMTksIDEyOjE2IEFN
LCAiR3JlZyBLcm9haC1IYXJ0bWFuIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3Rl
Og0KICAgID4gDQogICAgPiAgICAgT24gV2VkLCBKYW4gMjMsIDIwMTkgYXQgMDM6MDY6MzRQTSAt
MDgwMCwgVmlqYXkgS2hlbWthIHdyb3RlOg0KICAgID4gICAgID4gQ29ycmVjdGVkIHNvbWUgb2Yg
cmV0dXJuIHZhbHVlcyB3aXRoIGFwcHJvcHJpYXRlIG1lYW5pbmdzLg0KICAgID4gICAgID4gDQog
ICAgPiAgICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNv
bT4NCiAgICA+ICAgICA+IC0tLQ0KICAgID4gICAgID4gIGRyaXZlcnMvbWlzYy9hc3BlZWQtbHBj
LWN0cmwuYyB8IDE1ICsrKysrKystLS0tLS0tLQ0KICAgID4gICAgID4gIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQogICAgPiAgICAgPiANCiAgICA+ICAg
ICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvYXNwZWVkLWxwYy1jdHJsLmMgYi9kcml2ZXJz
L21pc2MvYXNwZWVkLQ0KICAgID4gbHBjLWN0cmwuYw0KICAgID4gICAgID4gaW5kZXggMzMyMjEw
ZTA2ZTk4Li45N2FlMzQxMTA5ZDUgMTAwNjQ0DQogICAgPiAgICAgPiAtLS0gYS9kcml2ZXJzL21p
c2MvYXNwZWVkLWxwYy1jdHJsLmMNCiAgICA+ICAgICA+ICsrKyBiL2RyaXZlcnMvbWlzYy9hc3Bl
ZWQtbHBjLWN0cmwuYw0KICAgID4gICAgID4gQEAgLTY4LDcgKzY4LDYgQEAgc3RhdGljIGxvbmcg
YXNwZWVkX2xwY19jdHJsX2lvY3RsKHN0cnVjdCBmaWxlIA0KICAgID4gKmZpbGUsIHVuc2lnbmVk
IGludCBjbWQsDQogICAgPiAgICAgPiAgCQl1bnNpZ25lZCBsb25nIHBhcmFtKQ0KICAgID4gICAg
ID4gIHsNCiAgICA+ICAgICA+ICAJc3RydWN0IGFzcGVlZF9scGNfY3RybCAqbHBjX2N0cmwgPSBm
aWxlX2FzcGVlZF9scGNfY3RybChmaWxlKTsNCiAgICA+ICAgICA+IC0Jc3RydWN0IGRldmljZSAq
ZGV2ID0gZmlsZS0+cHJpdmF0ZV9kYXRhOw0KICAgID4gICAgID4gIAl2b2lkIF9fdXNlciAqcCA9
ICh2b2lkIF9fdXNlciAqKXBhcmFtOw0KICAgID4gICAgID4gIAlzdHJ1Y3QgYXNwZWVkX2xwY19j
dHJsX21hcHBpbmcgbWFwOw0KICAgID4gICAgID4gIAl1MzIgYWRkcjsNCiAgICA+ICAgICA+IEBA
IC05Myw4ICs5Miw4IEBAIHN0YXRpYyBsb25nIGFzcGVlZF9scGNfY3RybF9pb2N0bChzdHJ1Y3Qg
ZmlsZSANCiAgICA+ICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLA0KICAgID4gICAgID4gIA0KICAg
ID4gICAgID4gIAkJLyogSWYgbWVtb3J5LXJlZ2lvbiBpcyBub3QgZGVzY3JpYmVkIGluIGRldmlj
ZSB0cmVlICovDQogICAgPiAgICAgPiAgCQlpZiAoIWxwY19jdHJsLT5tZW1fc2l6ZSkgew0KICAg
ID4gICAgID4gLQkJCWRldl9lcnIoZGV2LCAiRGlkbid0IGZpbmQgcmVzZXJ2ZWQgbWVtb3J5XG4i
KTsNCiAgICA+ICAgICA+IC0JCQlyZXR1cm4gLUVJTlZBTDsNCiAgICA+ICAgICA+ICsJCQlwcl9l
cnIoImFzcGVlZF9scGNfY3RybDogaW9jdGw6IERpZG4ndCBmaW5kIHJlc2VydmVkIG1lbW9yeVxu
Iik7DQogICAgPiAgICAgDQogICAgPiAgICAgV2h5IGRpZCB5b3UgY2hhbmdlIGZyb20gZGV2X2Vy
cigpIHRvIHByX2VycigpPyAgWW91IGp1c3QgbG9zdCBhIGxvdCBvZg0KICAgID4gICAgIGluZm9y
bWF0aW9uIHRoYXQgdGhlIHVzZXIgcHJldmlvdXNseSB3YXMgZ2V0dGluZyBmcm9tIGRldl9lcnIo
KSA6KA0KICAgID4gDQogICAgPiBJIGRpZCB0aGlzIGFzIHBlciByZXZpZXcgY29tbWVudCBmcm9t
IEFuZHJldyBKZWZmZXJ5LCBhcyB3ZSBkb24ndCB3YW50IA0KICAgID4gdG8gcHV0IHRoaXMgZXJy
b3IgZm9yIGRyaXZlci4gSXQgaGFzIHRvIGJlIGhhbmRsZWQgYnkgdXNlcnNwYWNlLiBCdXQgSSAN
CiAgICA+IGFtIHN0aWxsIHJlcG9ydGluZyBzb21lIGVycm9yIGhlcmUuDQogICAgDQogICAgU29y
cnk/IFdoYXQgSSB3YXMgdHJ5aW5nIHRvIHN1Z2dlc3Qgd2FzIHJlbW92aW5nIHRoZSBsb2dnaW5n
IGFsdG9nZXRoZXIgYW5kDQogICAganVzdCByZXR1cm5pbmcgdGhlIGVycm9yIGNvZGUuIE5vdCBz
aW1wbHkgY2hhbmdpbmcgaG93IHRoZSBsb2dnaW5nIGlzIGRvbmUuDQpObyBpc3N1ZSwgSSBjYW4g
cmVtb3ZlIGxvZ2dpbmcsIHdpbGwganVzdCByZXR1cm4gZXJyb3IgY29kZS4gV2lsbCBzZW5kIG5l
dyBwYXRjaCB3aXRoIHVwZGF0ZS4NCiAgICANCiAgICBBbmRyZXcNCiAgICANCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
