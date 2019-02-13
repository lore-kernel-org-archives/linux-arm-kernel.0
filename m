Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBCAC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:54:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF01F2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qmgjt4+i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mAvQ11jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF01F2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OnBTD3hPJVQgpBdoXG5T06JWNqAJHlzbnQ0c6c9u+Oo=; b=Qmgjt4+iseAH1R
	bNMnzj6KmXbidf/DyhIb5wBd9W1B9jUpZ7T6ptrYY0GYExzQjRZAZpRYGfozgrAdhHqrns3ecRHjD
	9Dx8hjUGv3QQUPigOqxFs+MZdo+CfJxrah9/GOyRS5c3QOpHAEAwsteznP97nv9Z+RoVimU4yKRGX
	cM05Iyj43hd5OCNPCjYsMGuWAHx2IytdUdW1NIkdyAVitaw7gMzA2linu17/Yz2//JEgWI/eSiDab
	8odrwr4hBE0321s4rzbxLxS5zwUPILHdybMuitBNNnS5FApm1+ptVQL5YWQcnCyI5lHPcZpY0201R
	HbrsAJ3GoaolYM4KotTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsBM-0005SO-Bv; Wed, 13 Feb 2019 10:54:24 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsBF-0005QQ-1b; Wed, 13 Feb 2019 10:54:22 +0000
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; d="scan'208";a="26479425"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Feb 2019 03:54:15 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 13 Feb 2019 03:54:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA4HnqQDbFK950Qg7S21tclg2h/SCM3s9wrg+fD9XBQ=;
 b=mAvQ11jdmY5Gd5KNfttiC6BxdYI5GdQq14xNjKW0+jADCVxjPI/CZil4rNepQNyUBfGDQJWHz4GWrwIXauAazYKvbVvS1Qg8a4sNNgLQh6g6W5VuhvD5YSmPDgVf+OhdPLvvZdkofMnYkSNVJrO8KBapQHlDfHhROaOlUvUUWQ8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1699.namprd11.prod.outlook.com (10.173.26.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 10:54:12 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 10:54:12 +0000
From: <Tudor.Ambarus@microchip.com>
To: <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 07/11] mtd: rawnand: atmel: add sam9x60 nand controller
 support
Thread-Topic: [PATCH 07/11] mtd: rawnand: atmel: add sam9x60 nand controller
 support
Thread-Index: AQHUw3qCWFNDodb6ZkCALjA5DxGPkaXdibmAgAAEMAA=
Date: Wed, 13 Feb 2019 10:54:12 +0000
Message-ID: <f8d77918-0bb8-d211-d139-4f8722136c8a@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-8-tudor.ambarus@microchip.com>
 <20190213103905.GH10129@piout.net>
In-Reply-To: <20190213103905.GH10129@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0100.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::26) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f8f8a0b-7980-4026-732f-08d691a1965f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1699; 
x-ms-traffictypediagnostic: BN6PR11MB1699:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTjZQUjExTUIxNjk5OzIzOjMwSVpONWc2V3Y0WnNiMExZVGNiRmJ6SWZG?=
 =?utf-8?B?RlpQOGFQQmk2bnlab0I5bkFVL0FmOGFCaTErN25WazhOOUM4eHJ4THBJNUVL?=
 =?utf-8?B?MzZlSTZDaXNaUVBkU3VjdlpDdVdoOWNBcXJaa2JtMEduTXZpVEl4a2xpSXB6?=
 =?utf-8?B?SW43Wkh5Ri8yanZpeG1LZGF2OHB3ZVQxVFVjbE9NNk9semtxVEpFbEk4YVZI?=
 =?utf-8?B?VnRwNm5ia0dnNWNtc0V2L2N1MU44QXJFaWNCelFJbUg0NVdOUUNmWFhFdWlz?=
 =?utf-8?B?cUhNT3RESFJ3NW5OYkpZdk9BOE5XQUxLOXg3Si9XU0l3Y2VRS0IrUzNBL2FB?=
 =?utf-8?B?T05TRlBuV3F2SGZYN0pVcHlCNHEyS2NqWjNNdGpkTWFrem1qZWdCVjZ6bU9B?=
 =?utf-8?B?WEFQUHBIeVU3RHFLVFVOUlYvaTRTbGpOYzN2YXUxVFZVMXpPTUdXSExiazZo?=
 =?utf-8?B?YWJoMkFBMjI0cGdZb2U1UDJHQmVKYkJUZEdBSGJ3YVRGVHNYWmVZRVFLbWRI?=
 =?utf-8?B?YldaclBtam53aW0wTVQ2eWoyUTFSSXNXMUZWUGRmd1dsdVhtaXE3Wkpra0lF?=
 =?utf-8?B?Q3p1NlBEQ29SeENjR21ETm1aN0JGMzVzUEd2N0t2SElPQVNYb2xHRmQwZVFZ?=
 =?utf-8?B?TFFZaXJaMXB1UkthSUhBUXFSME1YdTBTVWJoM2Q1bFBPdHVtd2J0VExQR05Y?=
 =?utf-8?B?VmpCaTdpWlFpaXN4UmhvVk9FaWQwb1ptTlBPaHZ3anJac0tocG1sbFF5SUIv?=
 =?utf-8?B?ZlVhUXNiekhSU3gvZHNqQ082YmZsSTFjbmprWnZ2T1VQdWtSYWVtdlFLNk5z?=
 =?utf-8?B?YUFEZTlPbEluOTRIRzZZYlZXTUc0RHZnbC9sYUVQVTM2cjVOL1krNW9qOXNF?=
 =?utf-8?B?dGV0TGwzdkFpUUlSMFYyemZYNEQrUWVmTGtVM01udlVXQVBXZzhZUUFtdklM?=
 =?utf-8?B?Y3E2TmlmanMzam9BTmR5K1NUbHp2cncvOEF2UTR6ZWpLbFF6MndpeFdFY0JF?=
 =?utf-8?B?KzQvdHRIMDFwaWh2WFJzWDJoMWV5a1ltUnh3WWg5MVFwZExTWkxHUmJUejZm?=
 =?utf-8?B?a3Z3amM4N09uUzRKTlZhaG9ycFNwVGVtR0pLSXdkVFViYUhhcFF1eFVXUkxH?=
 =?utf-8?B?OFFjeU12TzdkU05IQ2tGNzd2UDJQVVhVN0VkcWRtUmhWVC80cVYxZlNtSjUy?=
 =?utf-8?B?Wm1xOTNWUURkcExtQWl6Z3RHN1NJRnJlT0JDdHhpYjdaQk5zRHArb000a09T?=
 =?utf-8?B?dC95UTEyaGJ6eE9zeUFrbWxiRElhbndXVXQvN2MvT2R6UlpsbkhxR0c2ZUdr?=
 =?utf-8?B?N0xtL0hpVWpkYnZHUXJjN255d291VzN1enNyaDFPKytZcUpCL29zUHhJMGVG?=
 =?utf-8?B?TnlJKzN1TjhqcjZYcUt0Q1d3N2F2TFM3MW41RzVMS09raTkwclVnU2NPOWtO?=
 =?utf-8?B?c1FaeU95MGk0VmRENVh5bjJqU2kyWUhoK1FXV1pVaEw1bE1nM2hqQS9zSUVQ?=
 =?utf-8?B?SGduSHZZbjdqNDhsWHh2SUtnb3o1aVBYeGJSZktKU0x6ZGR2bFJRMDFiS1Ra?=
 =?utf-8?B?S3N5aWptdXBCOFh4N0JDSXpaNE9SQzYrcUV4WlgwVlVGdU00RmZpbDhEN3dW?=
 =?utf-8?B?ZEYwbmlzL2dmc0JFOTBKVUlKN0ZtT3M0UVUraWt1QXVUc2p6SHp1U1JJVkdz?=
 =?utf-8?B?UElMbHEzZTlrNjh0OVlCbnVMc2RxUzA1ZFMxalhSVU45VlBUcnJRUHNhcWIv?=
 =?utf-8?B?TzFOTk5NNllMMjlsMmdzdz09?=
x-microsoft-antispam-prvs: <BN6PR11MB16998029FC9F48D7DC5D8FD6F0660@BN6PR11MB1699.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(186003)(6246003)(478600001)(476003)(446003)(53936002)(6512007)(11346002)(53546011)(6506007)(97736004)(66066001)(229853002)(386003)(486006)(72206003)(68736007)(2616005)(26005)(106356001)(31686004)(25786009)(31696002)(4326008)(105586002)(102836004)(86362001)(36756003)(305945005)(76176011)(99286004)(256004)(316002)(7416002)(6916009)(52116002)(81166006)(6116002)(6486002)(14454004)(3846002)(6436002)(81156014)(71200400001)(71190400001)(4744005)(2906002)(54906003)(8676002)(7736002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1699;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mBztm7UCR+0dYMic4XfCyt1V3Ju8pt2MtKCNMDiysq6OreFGgY3JDO8psS6TS37N5DhJvzqzstkZBGyx9AoSFA9dOe4eOkD2H/2BvjkpMxnFEYS1SNPnec+CCzUZP77i/Tg7JaiuMGRwos8lTX05b7xj1EncygQqNfaHqyVSCjFxixah1fv8Fo8I8zacMX8Di6Ah1Mu9xHeiR5Yw+hjp8KMIVg2n5BSZV3ElcrZS3/naPiBn4WhPYhp9QXVGuIN1d9tJu1lswZTHhCEoEAQniyiCwYbOtLPdz6MonbRRnBXfN+yXsXOBIdFZfwvLxWqqtyyUUww9iZaVNdVoTfFyr4YDYFdyaf9MNUZr4xOaCcDr4B8FgFI46rgDDSQ9XfIJMSpGJqEoY9q2r7CBkRK/em5rW8u476UMtYXjr6yY4uQ=
Content-ID: <EABFF74BBE5E954CB73CA2C7BAA5210B@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8f8a0b-7980-4026-732f-08d691a1965f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 10:54:09.4113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1699
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_025417_172677_0F13F120 
X-CRM114-Status: UNSURE (   9.91  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bbrezillon@kernel.org,
 richard@nod.at, linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, lee.jones@linaro.org,
 computersforpeace@gmail.com, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/13/2019 12:39 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 13/02/2019 09:00:05+0000, Tudor.Ambarus@microchip.com wrote:
>> -	nc->ebi_csa_offs = (uintptr_t)match->data;
>> +	nc->ebi_csa = (struct atmel_smc_nand_ebi_csa_cfg *)match->data;
>>  
> 
> This cast is probably not necessary anymore as this cast a pointer to a
> pointer.
> 

it's done to discard the const qualifier from pointer target type. data is of
type const void *. nc->ebi_csa was not declared as const because below in the
same function we are modifying one of its members:

nc->ebi_csa->offs += 4;

I'll add a comment, thanks!

Cheers,
ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
