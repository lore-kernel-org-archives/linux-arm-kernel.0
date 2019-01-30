Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3797FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:04:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093F920869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FTXHWQ27";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3loeU6k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bu1jbjdH";
	dkim=neutral (0-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NxUcCoGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093F920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BBhb4wSpVYSzKkd3LE1H2zWoLTL94BOoGBSA7o+IaD0=; b=FTXHWQ27VlE8Zz
	RwPkiGrtxHp6mNOJ5/ttSAHsgufo8UmHkUu4q+sqrAIiahEEPXaEGAixbIVK2YNaapNeI/uOuj16E
	GJlXtt82JbmYInacm7AFYpbiL2lILbHLHqjA6hOKo+J2kGXqKSreiTbVaOyDmMo0BMNpxXnudExuj
	lZa58GNVueY1I/LpmIVi04ZajYpQZStukgl4f1lSxp2PKlW8+M08nIKNVxqHyj5Z3ilMKP21lfzS1
	GVsoUY1j9vrwUPAQ7S9TRTus6mhaWJoxRY1VbCebnSmK49ACdoKFLit9xTImiO92znffA44ceXb4L
	/Fyowt7JHEcS9ebn0j6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouDK-00015W-BP; Wed, 30 Jan 2019 18:03:54 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouDB-00011H-9g
 for linux-arm-kernel@bombadil.infradead.org; Wed, 30 Jan 2019 18:03:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
 From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n9pGXSwzli54Ey+ugud3KlzFjKYSE+5ROFPNzsoBn3s=; b=W3loeU6kSjDJT+sE216ueqLDyU
 bN4l3UvT5YqNSWwCDTDUFxa+GXqsmNks1RYCSV8+S1bjY3dqcD4yBJdqO07ivP/EpXDmrU5SIk0VR
 svDI/+3tBPBDQwykl9IieW2MuO8DaPhRwePkScfcpvseQ77VUhd5zVUbr5T5WWFQpnDzvWztip23c
 o0Q5EYZnrFIl9+O89lChBEByrHqXWe4r2awrv4EIJ4crRkVccXr+bDuwzMKMZoZ6Miqsay1vxUOHQ
 B6uS0lcNgATvi4eReC6Oyk9pLGfhMVxR7sFPwtPYma5re9ZVvCT0WXIB3Ps19LmPw7V5fRGlSPLgX
 jubDnJGw==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouD7-00067o-HJ
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:03:43 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0UHu4D5008075; Wed, 30 Jan 2019 10:01:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=n9pGXSwzli54Ey+ugud3KlzFjKYSE+5ROFPNzsoBn3s=;
 b=bu1jbjdHE0iNkgSqGccTOuGDVu+UNt/D5xQ7r4Q2JJLQd/rbWsx3wJ1stBQnjCOTmjfu
 Sbztk1ibsVAj9Z4ZrzbRyI/hBcFLA/cXK8XK615oebqHyM5AO0fl6FGKTQiqGEcp19iI
 M4QarfZMO5JMnvin1EV0SeL1feM+nClKGY0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
 by mx0a-00082601.pphosted.com with ESMTP id 2qbev9gfbw-11
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 30 Jan 2019 10:01:25 -0800
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 30 Jan 2019 10:01:25 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 30 Jan 2019 10:01:24 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 30 Jan 2019 10:01:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9pGXSwzli54Ey+ugud3KlzFjKYSE+5ROFPNzsoBn3s=;
 b=NxUcCoGXJScuNNrL5uj2Y8s7zXN8bJcyaK+Ro/qy8jQwhlo3QnpfnVgvo3Ewa6edS2SU5uoOITbQz89V4YwWr+GiEVVJHAUhUjrpAVHedNDpqZic6bFVglzgaZmIJ5PumrTUgaao+1OhAOX9YF3RmO/K/U5H2kF4RYwJOQqShLI=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1158.namprd15.prod.outlook.com (10.172.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 18:01:23 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b9cb:6dd8:d8bf:45c6]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::b9cb:6dd8:d8bf:45c6%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 18:01:23 +0000
From: Vijay Khemka <vijaykhemka@fb.com>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
Thread-Topic: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
Thread-Index: AQHUs3B0EbHO5x+TOEGVuHnYyNp6D6XHMHEAgABuKgA=
Date: Wed, 30 Jan 2019 18:01:22 +0000
Message-ID: <B6DFDA82-F72C-4979-B988-05C292E61228@fb.com>
References: <20190123230733.1821501-1-vijaykhemka@fb.com>
 <CACPK8Xc91m9TWoRSgDCT7bVJC=C=w7mse8xbdCgw5vMVgMXM=Q@mail.gmail.com>
In-Reply-To: <CACPK8Xc91m9TWoRSgDCT7bVJC=C=w7mse8xbdCgw5vMVgMXM=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:b38d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR15MB1158;
 20:G58b57xKUg4uLO7z5wuz7nRQcVhgPUHjE8X6hVPjgNfWav4/D1ZC99DytfC1YFqYW8DRwnYWugkZmWHubv+lq3MzxnYBn6bZCYb1z1glkV4wFD3zRxiIrnYLvSi3y7+h/ED3fFRnPQ455/hWCTPx63AGgC3R/c9PufaKchFMMKE=
x-ms-office365-filtering-correlation-id: db3f4cac-2581-43e0-325d-08d686dcf219
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR15MB1158; 
x-ms-traffictypediagnostic: CY4PR15MB1158:
x-microsoft-antispam-prvs: <CY4PR15MB1158DD2D9DCAB0C81C8FEA39DD900@CY4PR15MB1158.namprd15.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(47680400002)(189003)(199004)(8936002)(54906003)(33656002)(11346002)(8676002)(486006)(186003)(2616005)(99286004)(446003)(82746002)(46003)(476003)(97736004)(36756003)(83716004)(71200400001)(68736007)(6486002)(71190400001)(81166006)(316002)(81156014)(6116002)(478600001)(2906002)(7736002)(4326008)(6246003)(305945005)(4744005)(25786009)(6512007)(86362001)(76176011)(6506007)(256004)(105586002)(229853002)(106356001)(6436002)(53936002)(102836004)(6916009)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR15MB1158;
 H:CY4PR15MB1269.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lgLMxTA9pktZ8NSV5+T2ZXrWNtABVMW12DD5oyb4T0w7NQKdhgDwY8qmDkif6i+mRMuL50LGRzR3W/lDqMGblS4fQ2s7ZgfSwh900+lK4GdX+JUH5+AGL/Hc4Z+IUKYxeIRl0HvKX0B/k8vCXw4MrS3oqfkf+NL2JlYEZkT96ld1AYevF2wUn9y26qH3pw81169/04NeZ8TZbQwWWqWnUHlzLMi4H9Ck4aHB+6B6ZEoUU7SCxWM4l3Xxcq1wjpQ2Z6CVENmTVThma9u1GarN8DsRKCQmGaZlG3ziQJt3OG2xA6WTlk38SIwCBPIEssz8D7meDp+5/iIXk18MDiTbYtbEI1nFnousKiP5lWGCcMWbLNdqARu585n3eLdBehVeZG0y1W0izncM19R5TRntrrUz4SwCDOZsYKWreyGYGdo=
Content-ID: <B81C1623D3FD0743B3F483C07522169D@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db3f4cac-2581-43e0-325d-08d686dcf219
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 18:01:23.0367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1158
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-30_13:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_130341_945262_56A1E0FE 
X-CRM114-Status: GOOD (  15.64  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 Andrew Jeffery <andrew@aj.id.au>, "openbmc @ lists .
 ozlabs . org" <openbmc@lists.ozlabs.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DQoNCu+7v09uIDEvMjkvMTksIDc6MjcgUE0sICJKb2VsIFN0YW5sZXkiIDxqb2VsQGptcy5pZC5h
dT4gd3JvdGU6DQoNCiAgICBPbiBUaHUsIDI0IEphbiAyMDE5IGF0IDEwOjA3LCBWaWpheSBLaGVt
a2EgPHZpamF5a2hlbWthQGZiLmNvbT4gd3JvdGU6DQogICAgDQogICAgPiBpbmRleCA3M2U1OGE4
MjE2MTMuLmQ2MGRiYjAxOWY4MiAxMDA2NDQNCiAgICA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cw0KICAgID4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzDQogICAgDQogICAgPg0K
ICAgID4gKyZwZWNpMCB7DQogICAgPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCiAgICA+ICt9
Ow0KICAgIA0KICAgIEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSBhbiB1cHN0cmVhbSB0cmVlIHRoYXQg
Y29udGFpbnMgYSBub2RlIGNhbGxlZA0KICAgIHBlY2kwLiBUaGVyZWZvcmUgdGhpcyBkb2VzIG5v
dCBidWlsZC4NCiAgICANCiAgICBJIGhhdmUgZHJvcHBlZCB0aGlzIGh1bmsgZnJvbSB5b3VyIHBh
dGNoLiBQbGVhc2UgbWFrZSBzdXJlIHlvdSB0ZXN0DQogICAgYmVmb3JlIHNlbmRpbmcgcGF0Y2hl
cy4NClRoYW5rcyBKb2VsLCBJIHdpbGwgYmUgY2FyZWZ1bC4NCiAgICANCiAgICBDaGVlcnMsDQog
ICAgDQogICAgSm9lbA0KICAgIA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
