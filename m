Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E96C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E012146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VtTxTw8D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=liverhulac.onmicrosoft.com header.i=@liverhulac.onmicrosoft.com header.b="Xe7yOw2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E012146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=live.rhul.ac.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jEiPb1jgsEhXfOEpBVrzBWYpOVr84qaJSSnV1tJ4Y/k=; b=VtTxTw8DO62XgX
	ns7rEe/FzdJdR4OrTBHoaVLHVGvvYuNzNpbEWmNdrLR1cLm+JtNufz4eVm2sCU20qkgmLsu6uhHeG
	FYJIqeEfd7MCvv5tDgdsACBSPBcaZgS64+tMI9bdUnbZfO9FXek1gc23UtCYBQBDqfzS62F6ESPWF
	gxS4wkYXtt/jvtkQVI7YHGzASCVJo4Zg4d/HuHlOf74NO01Q9lto9XYnwblXNBqWjlFjOas9f5V/I
	pe4cQr309MROZx+7Iw9ARSr9lj+VW8YM6KuZJdIjXk2w2S+KsjIEPUSQES95aLkRVbO/PVFTwImV+
	V6Y6bRPz+gQdFAnvbiZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwYMM-0001aS-Ld; Wed, 20 Feb 2019 20:20:50 +0000
Received: from mail-am5eur02on060e.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::60e]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwYMH-0001Y0-U6
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 20:20:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=liverhulac.onmicrosoft.com; s=selector1-live-rhul-ac-uk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4prP01VqtmM9qMhy70W+mQoO6wQSACajZYBajTvA5Xg=;
 b=Xe7yOw2HGCcTlo8ckWEXxVBESrOqaTQnwf9NUD30TA0e9/kzBHq/FAYly9FVPML/KysB0oBI0LE1oSBVoYSdANIjGjnly82bo8DA5y8YujYLU4G5lYTTQ+bJMq1Bi7JAu4hVPXiaBJAGEsazWtHJ2DuHRbEJppXCRVBvainAOUw=
Received: from DB6PR0101MB2295.eurprd01.prod.exchangelabs.com (10.168.52.134)
 by DB6PR0101MB2152.eurprd01.prod.exchangelabs.com (10.168.51.150)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.19; Wed, 20 Feb
 2019 20:20:36 +0000
Received: from DB6PR0101MB2295.eurprd01.prod.exchangelabs.com
 ([fe80::f17f:25cc:bfc8:e66f]) by
 DB6PR0101MB2295.eurprd01.prod.exchangelabs.com
 ([fe80::f17f:25cc:bfc8:e66f%8]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 20:20:36 +0000
From: nik_bin_nek_alwi <zrra188@live.rhul.ac.uk>
To: buildroot <buildroot@busybox.net>, linux arm kernel
 <linux-arm-kernel@lists.infradead.org>, Paul Chavent <paul.chavent@fnac.net>, 
 Arnd Bergmann <arnd@arndb.de>
Subject: =?utf-8?B?8J+RjSBIYWxsbyE=?=
Thread-Topic: =?utf-8?B?8J+RjSBIYWxsbyE=?=
Thread-Index: AQHUyVm99G531R+HFkWX+vLD58RX9Q==
Date: Wed, 20 Feb 2019 20:20:36 +0000
Message-ID: <ac1ab65b-5205-4821-b911-46f34ca41bc3@live.rhul.ac.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::31) To DB6PR0101MB2295.eurprd01.prod.exchangelabs.com
 (2603:10a6:4:45::6)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lottie.Kearney.2007@live.rhul.ac.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [157.119.105.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecdbbe73-6e89-480c-171f-08d69770df9a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0101MB2152; 
x-ms-traffictypediagnostic: DB6PR0101MB2152:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjZQUjAxMDFNQjIxNTI7MjM6Sy80aFVmRDF6ZkgyMS9uQkd2WVcwSFZQ?=
 =?utf-8?B?RzNJUkZCL3pvdjRwTHk4dS93d0xxdEJ6ci9QRWVCQ29yVmNMcWtRTFdUNTlw?=
 =?utf-8?B?ZFYxRW9CMXg0b0VOTTNHYkxxTDJNWXkwM016aERVTDdBZXllbi9rait6K24x?=
 =?utf-8?B?TDNPTTQvL2RjVzJIaVFSSzExZXVUYXZoZzdFRllpdHVQSEpoa0dWeWRVVTJZ?=
 =?utf-8?B?R2lacS9MdEd4NkR3Q0E4ZXdUQ2JwNWFzUFZUM0JlUDlHMDZLajBwa2pYZS95?=
 =?utf-8?B?SGxHaFFHU29rNnFoNm9wYkpUVVhKZ01VQmIrMHpLbGI5NXB0K0txeGw5L1I5?=
 =?utf-8?B?OVVEYjc4eGd0dmU0Q3JkM2R4WityUmZ6b28xZ042alZGbGNSeFVicDI0ZUtB?=
 =?utf-8?B?ZlAwT21mOTJVL21jTGNXOVZZWEhqbER1MldCZ0t0c1pJaHBaTGZPRTNUUDBS?=
 =?utf-8?B?UVlDYlh0aHlvMnZwNXd3U2x1aXpLcDBmS2syN0Y4bDBRWWxESVZoZUhmR1cz?=
 =?utf-8?B?TFMxNGw0blBOVmpFaGlNMmRmbVlNT2YvcU9HQ25oaS9GdnF2VW50VVpTaDFi?=
 =?utf-8?B?c21FTjQybG1majBCQ0MyL1pSMlR6eFBmeGdIZHE4TE91VzBHU1MvWEVUSnUz?=
 =?utf-8?B?Um41RTU5TGQzNXVxWEtXZUJUUFlQNnljSEZqTnVHTkdtSlJpeHJwZVgyWTlr?=
 =?utf-8?B?QU8wNjdGMHFWT3FXUWIxU29NY0NJMlJBZVVkcnEvQlJ0OE9ZQnU5V0JVN0c0?=
 =?utf-8?B?NDdEanZqVnB0ZkFqb2lwYUVRVVZVb3Y3UENpbWVVbE9CR3NtOE5kaXFnd0ho?=
 =?utf-8?B?aitHUGNhVFREbmRES1A5YlozVldmSWM4cW4zZUY4cE9NSDNNOEJFd1FUa1VJ?=
 =?utf-8?B?ZFVmZU5ZajFCN2NmOHVTN3VjTmhpWlNqenRrSXBzWm95aWg5b3hhc0FKMjFE?=
 =?utf-8?B?ZGpSWEZwN0lENWFSa0lKTEZzMitKYkdxZlpWcExreUdmUC8yZHlOU3dDdGF5?=
 =?utf-8?B?dGg0cTZEWEJMNE1aRlA3MWhLV1RLVkJKWkVXZ09yaTIyZGhUSUtHUGdqQjJ4?=
 =?utf-8?B?cjJhcVVPNXVSUzIwRDV1NE8wdXVWTmY2RzhndWNVK01TRjZLek5OYllrbjdy?=
 =?utf-8?B?NDRmdVlMemNOa0cxUlZOZnZmdFd0SXJMdTQvaWhBeXNVVmRibnpZUzlaWWdT?=
 =?utf-8?B?b1MrNHNmOHVDM0NxYVMrNlVxMVNhREZkd01KRCtvUDU4MHFHUUthRURWYk53?=
 =?utf-8?B?TzB0ZVBOQmNHdjJqQkQra2JCYkNzS3N3SkU3cm5sM3dYaXlEa2YyaVhxa05l?=
 =?utf-8?B?WXk5ZkJDR1p5SFpLQ1FVcTlWQTcrbk9memxyTm1qL09WVGFaWDd2Nk1GVVVr?=
 =?utf-8?B?Yml3NkhJZVFJWnE2NllIR1FOeURCYmRtL3BaL2RYUUU1dmtJbDVCTTY3Uzhn?=
 =?utf-8?B?azRjbWxpOFAybkZxVWFSbG1FMUhma3JrMnpxVVNWZmtick1yTWcrT3Roellj?=
 =?utf-8?B?SFZkT2drYW5tYzJKZi9SV2JUN1V6a2dJdE1DeCtlTXZ0WU9iWlQzbnhVUUZH?=
 =?utf-8?B?cFZxT2FzdXRHVFF4N1VpQWJWdzlmcjk5QnBUV3BSd2h5ZkRkeGhoQ3dlbVUx?=
 =?utf-8?Q?wz8bmGPXduaRlgUKPzHmOv?=
x-microsoft-antispam-prvs: <DB6PR0101MB2152DC3A5E647CDD572A00B9B87D0@DB6PR0101MB2152.eurprd01.prod.exchangelabs.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(316002)(6512007)(6306002)(8936002)(110136005)(71200400001)(786003)(97736004)(71190400001)(486006)(102836004)(476003)(53936002)(52116002)(2616005)(7736002)(99286004)(386003)(26005)(6506007)(6436002)(6486002)(256004)(305945005)(81156014)(5660300002)(81166006)(186003)(74482002)(966005)(14454004)(105586002)(3846002)(66066001)(2906002)(31696002)(106356001)(31686004)(68736007)(72206003)(558084003)(478600001)(25786009)(6116002)(60550400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0101MB2152;
 H:DB6PR0101MB2295.eurprd01.prod.exchangelabs.com; FPR:; SPF:None; LANG:de;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: live.rhul.ac.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +vgTC0EULYzp7YXJpDPewDKRtwztlvkeWXf4HgmK7MCXlpW5RBHBvBkBabrbWYqJGwRMAMFLtRfZgDwx43D/4d1+YQFEuaa0tIiwcKDGcFiKmG4ZAaWHwbv0kjWq3SkmzMQy7G0+gDXFnpVES54YMTw9J5j6Z4fXrmBT5POF9gRLfNmVeOmcVZJ7yhewrhwq48P200ZgTaK4jxOP9r4iTOxTfVgbvIlJL5R/8KHOV8Q7mhmqCMzH3AU2AeJXhKd0+/aOT39UHeJlC0UMmMNeiz+zYXNKz14DuHck2FZa0LC7y0SHch4sLjlSuFrzlmC3apLagsl7YfzNYZAWsKJ1DHaBjKorOBfKtXf1Pr6YWckyP4zOcuBZNDg7rDBki9zAdFuBDbI0r7jZNHRSMhsofMDmz0CGiSA8mAGmwOw+Ktw1Xfrzz5HZdkpmFrhtVNjrnDyQiRDdVSog/JJks92v9/9lxqK6r/W3bjCwLWRcvqFzL5KOy54ZXz3JEXXN5fIchGQyOUJRHb41BzSPgt1Q3YRfJe5IOk6gbyJqvFW6U8ssa39lWnsTyHG9zb+UV38o
Content-ID: <EA188B8BE8EC644B8015F36020E9AD64@eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
X-OriginatorOrg: live.rhul.ac.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdbbe73-6e89-480c-171f-08d69770df9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 20:20:32.3169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5ff2e1c6-3618-4281-ad87-08326d5a18c6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0101MB2152
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_122046_014672_2BF64235 
X-CRM114-Status: UNSURE (   4.64  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SW50ZXJlc3NhbnQhDQpEYXMgQW5nZWJvdCBpc3QgYmVncmVuenQsIERldGFpbHMgaGllciBodHRw
czovL3ByZWdpbm92c2ExOTg1LmJsb2dzcG90LmNvbS5lZS8NCg0KDQoNCg0KVmllbCBHbMO8Y2sh
DQoNCg0KDQpuaWtfYmluX25la19hbHdpQHlhaG9vLmNvbSANCg0KDQoyMC4wMi4yMDE5IDEyOjIy
OjE2DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
