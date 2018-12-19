Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62828C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:22:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3184921850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cCcG/3Cp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="h5UErUtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3184921850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9H4r1f8QbRHyXuAu4uJ8zRLx/WD2ElexYiakNfvbRiU=; b=cCcG/3CpEf5yC9
	gJfQ678k6n/TDyw40lcznI1NI4dn0tQQH8uHTfgCQirq5JY9mGNsG4R9jk14n7uAFa2iKOVugrLT9
	vdWpPAGyE1qI+dCweTJqK5O5bT2zLceDZJZXnb+eOm5yRHG5eUuvTjebcUeSOPPUXRm9f8tS4rdEB
	zzo8ogG3MIfmtIKx1aAGe2GgZTHi1Yn7DT25qS0L98l8VRb4S3twXQHouyTY1u5DQFQkYla6N/jmF
	npZmYmPkriTjh5XYWYhfan63pq09Y6po/R6FByDFbB77mxrPKzCrMwMrGh7XbSVq+Ax0/7WBX0fCA
	6cKawP6Gnq1vMMQwRowQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYzK-0007m8-SB; Wed, 19 Dec 2018 10:22:02 +0000
Received: from mail-eopbgr690077.outbound.protection.outlook.com
 ([40.107.69.77] helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYzH-0007lG-Cj
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:22:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF5dPZKpNUVh3Jco0iGJa8TdIDE2c+Zy+zDVg7E+IYM=;
 b=h5UErUtTJNCiMbo18HIMEAWidh/t9dcUAvvZkspaSjYVA6BeBuDc0A7gSM8Ts7vZyU8sHJ6op+AlpxG/wDlXgkAKE5neevWtW0NNe+n4hBSuW73Od+OoyzdIBnYaXyaId+sqjiZWM4sBve6nOZYxtxcijHHHRSnUh0lD7NrglsA=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB4335.namprd03.prod.outlook.com (20.177.254.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 10:21:44 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc%3]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 10:21:44 +0000
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Thread-Topic: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Thread-Index: AQHUkVET6MmkkP0I6kWJw6RDslXtBqWB3MQAgAAt/wCAAIlbgIADXtQA///jvoCAAA45AA==
Date: Wed, 19 Dec 2018 10:21:44 +0000
Message-ID: <20181219181532.64558a46@xhacker.debian>
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
 <20181216.124120.731491122771817496.davem@davemloft.net>
 <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
 <20181217083735.4c6599b3@windsurf>	<20181219110546.63f68f4b@xhacker.debian>
 <CAPv3WKctKtFVbb8Ltyj9gaB8bJEaTG4pxMeMFJbZKGYeo2_n+w@mail.gmail.com>
In-Reply-To: <CAPv3WKctKtFVbb8Ltyj9gaB8bJEaTG4pxMeMFJbZKGYeo2_n+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::32) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN6PR03MB4335;
 6:MGlW3b8amBZF4T+amb9EzpYMSYWuKtHQVetCuid4Cw8mi1FLSd0PT6g99KfUoOoNNMGj4Y/LOXtsChgXW5Gci5fKMkWEuOG9U3AbIchbBjFp2eu2PhaXOSc1bD3m4m/pmYiNYXrgD0ILu64GtjstJLAObFyBOH0bmCaL/oQKGe+1ki+soSIh02EiZT8OeL8zTgKeI7Qiq4Wmk7/X0vh8iP9qA03iK+DfYmTScp5odmlJRY2PATrwqiaiY5RvwqT+EgnD3icsMTcj95QhqaNm0Sx3OCk7bRD5NhtSRq2nlagFF33w4akXEg3tKPIHmf1HfsdmApsAIYkzh4gQKyxzfkW3jci85+F67jzl2NuFvt6eTlxiOPYmAzzpwf3v3FUH9vyL1FaKPVSgVozBdEv0RsKw8q+rVT4RpN62GD1fpa5hUqz6KoCjm6FkolDT01vCNV48KYS6x9BV2U8Cl+1VDA==;
 5:6/gQ1EVbTgip1eOkIt5cV0wKEv/HMbbauxkPierkPbP46ad/yDkf+6ggqrz44senQp5pTOzUdF6gqQMFsF3uvunfCm3a5quGIq44rcivkgCcgJveNGz2NytYQP0Xll6jJa0B2c/4sSMQWTes5eECCAWTelYgA6+hu4nqCh2jd7s=;
 7:VwwLaoirg/Ey36Z9wQ6OoBdnTaRoutO0O5bogCIpuUGLS0UitK4DCp4JKz9H0/hF94XnhO4Re/HKbO6k3UWkv9U3t0pZJF3lCBupp1QPSedGrpniyeD2B77Nrsv8bN/dkf/VBAtXjhnIKxWAwn5FCg==
x-ms-office365-filtering-correlation-id: a056fe33-8d2e-46b5-aa4e-08d6659bc644
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:SN6PR03MB4335; 
x-ms-traffictypediagnostic: SN6PR03MB4335:
x-microsoft-antispam-prvs: <SN6PR03MB4335F1E422B263A335F81083EDBE0@SN6PR03MB4335.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:SN6PR03MB4335; BCL:0; PCL:0; RULEID:; SRVR:SN6PR03MB4335; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(199004)(189003)(76176011)(5660300001)(81156014)(229853002)(99286004)(105586002)(106356001)(8676002)(8936002)(3846002)(256004)(7736002)(52116002)(6116002)(486006)(6916009)(476003)(14444005)(446003)(93886005)(305945005)(33896004)(11346002)(81166006)(68736007)(7416002)(316002)(478600001)(66066001)(6246003)(6512007)(72206003)(6486002)(54906003)(102836004)(9686003)(53936002)(2906002)(71200400001)(6506007)(25786009)(186003)(386003)(71190400001)(1076003)(86362001)(97736004)(26005)(4326008)(14454004)(6436002)(39210200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR03MB4335;
 H:SN6PR03MB4398.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lqqwCJRuL6ws+DxMFW/RfmtsDPYx0B4wdPuAa54SP5RHgy/qUOL/jP6V3ZXVcj7cn5FqGMq5fKjhIyIGdvuLI3ZJ843sSxO1CF4UGEqrWICatSRKZllPIg6cUBdmmTNyNq6IA8d3h77CtN0rUygzFt+riuH3WbzF3pREUP7WVVaLyZKsssJYopmxFMiOIJAJ2oWAdCB+yBeiumeEbn0lt7ONQlDuiYkRzRL1hDtVscTt53Rmd0a0CppZglhFSCFuhZIYSKzrU5Z9xCLPrhqs9UVhCP7MqA2WtMvOXIjifwQgMcwaL1o3fPs7UZnyKx4C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <2BC4555DEDFE944D8383F48A6F685077@namprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a056fe33-8d2e-46b5-aa4e-08d6659bc644
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:21:44.4441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4335
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_022159_436571_BAF30977 
X-CRM114-Status: GOOD (  19.94  )
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 netdev <netdev@vger.kernel.org>,
 =?utf-8?B?R3LDqWdvcnkgQ2xlbWVudA==?= <gregory.clement@bootlin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "nadavh@marvell.com" <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, Stefan Chulski <stefanc@marvell.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 David Miller <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAxOSBEZWMgMjAxOCAxMDoyNDozNyArMDEwMCBNYXJjaW4gV29qdGFzIHdyb3RlOg0K
DQo+IEhpIEppc2hlbmcsDQo+IA0KPiDFm3IuLCAxOSBncnUgMjAxOCBvIDA0OjExIEppc2hlbmcg
WmhhbmcgPEppc2hlbmcuWmhhbmdAc3luYXB0aWNzLmNvbT4gbmFwaXNhxYIoYSk6DQo+ID4NCj4g
Pg0KPiA+IE9uIE1vbiwgMTcgRGVjIDIwMTggMDg6Mzc6MzUgKzAxMDAgVGhvbWFzIFBldGF6em9u
aSB3cm90ZToNCj4gPiAgDQo+ID4gPiBIZWxsbyBNYXJjaW4sDQo+ID4gPg0KPiA+ID4gT24gTW9u
LCAxNyBEZWMgMjAxOCAwMDoyNTo1OCArMDEwMCwgTWFyY2luIFdvanRhcyB3cm90ZToNCj4gPiA+
ICANCj4gPiA+ID4gVGhhbmtzLiBJbmRlZWQsIHRoZSBwYXRjaCBpcyB2YWxpZCBhcyBhIGZpeCBm
b3IgY3VycmVudCB2ZXJzaW9uIG9mIFNXDQo+ID4gPiA+IEJNLiBIb3dldmVyLCBiZWNhdXNlIHRo
aXMgY29uY2VwdCBpcyBicm9rZW4sIEkgd2lsbCByZXdvcmsgaXQgYW5kDQo+ID4gPiA+IHN1Ym1p
dCBwYXRjaC9wYXRjaGVzIHNvbWUgdGltZSBlYXJseSAyMDE5LiAgDQo+ID4gPg0KPiA+ID4gSSBr
bm93IHNvbWUgcGVvcGxlIGFyZSB3b3JraW5nIG9uIFhEUCBzdXBwb3J0IGluIG12bmV0YSwgYW5k
IHRoaXMgd29yaw0KPiA+ID4gYWxzbyBuZWVkcyB0byBjaGFuZ2UgcGFydHMgb2YgdGhlIG1lbW9y
eSBhbGxvY2F0aW9uIHN0cmF0ZWd5IGluIHRoaXMNCj4gPiA+IGRyaXZlci4gSSdkIHN1Z2dlc3Qg
dG8gZ2V0IGluIHRvdWNoIHdpdGggdGhvc2UgZm9sa3MuIEFudG9pbmUgY2FuIGdpdmUNCj4gPiA+
IHlvdSB0aGUgY29udGFjdCBkZXRhaWxzLCBJIGRvbid0IGhhdmUgdGhlbSBvZmYtaGFuZC4gT3Ig
cGVyaGFwcyB0aGV5DQo+ID4gPiB3aWxsIHNlZSB0aGlzIGUtbWFpbCA6LSkgIA0KPiA+DQo+ID4g
R3JlYXQuIFNvIHRoZSBwcm9ibGVtIG9mIGN1cnJlbnQgbWVtb3J5IGFsbG9jYXRpb24gaXMgc2Vl
biwgZ2xhZCB0bw0KPiA+IGtub3cgcmV3b3JraW5nIGlzIGdvaW5nIG9uLg0KPiA+DQo+ID4gQmVz
aWRlcyB0aGUgbWVtb3J5IHdhc3RlLCB0aGVyZSdzIGFub3RoZXIgaXNzdWUgd2l0aCBjb21taXQg
N2U0N2ZkODRiNTZiDQo+ID4gaXQgYWx3YXlzIGFsbG9jYXRlcyBwYWdlLCBzbyB0aGUgcnggaXMg
bWFwcGVkIHdpdGggZG1hcF9tYXBfcGFnZSgpLCBidXQNCj4gPiB0aGUgdW5tYXAgcm91dGluZSBp
c24ndCB1cGRhdGVkLCB0aGVyZSdzIG1pc21hdGNoIGhlcmUuDQo+ID4gIA0KPiANCj4gSW5kZWVk
LCBkZXNwaXRlIHRoZSB1cGNvbWluZyByZXdvcmssIHdoaWNoIHdpbGwgYmUgbW9yZSBjb21wbGV4
LCBob3cNCj4gYWJvdXQgSSBzdWJtaXQgYSBxdWljayBwYXRjaCBmb3IgdGhpcz8NCg0KVGhhdCdz
IGJldHRlci4gVGhhbmsgeW91DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
