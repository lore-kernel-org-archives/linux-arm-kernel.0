Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F28EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:44:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C0E218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Js7cAvY1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="d2J/hc8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C0E218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mZiKfNYm7RO02b+rE9w2CIr122iCOUzGv9xGxVhCy5E=; b=Js7cAvY1VIFWDt
	iHbu2XBXDCs11ParxMs0WUVmR6wSQ7uVxUgPo2ajpYxUseRK6WDrOs8pUKBkfR+4rbwvkWeZyip9n
	6HFri6z0eb8EfrSDwKmhS4oH8qGAn6CcxtkQ8HWjItdqS6el4YzcEjuyLqQ2Muoj9mO0Mp7gV4OA1
	wlOKPTP3LUmMUKXhJpkfWthTab2HSzvQstQeVrzcmR3bXdY6NPKGJ/xX/9LLT0zs1jZ5n/ZdOims9
	DZFhq1Xwg41nb8upt1NSX4nd/Pj6uHeqGc3R3GH1kF9z2qIbcT40+PJSfqK6wKApTP9xfC76/MHF4
	dFXujroo78Kz9nKk4f1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp9p3-0000E3-QB; Thu, 31 Jan 2019 10:43:53 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp9oa-0008Pl-NM; Thu, 31 Jan 2019 10:43:36 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="23247804"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 03:43:23 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 03:43:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzriarA1q0+UUc9G+o/XOMNDQJyPM0VPYVIY9JFpVlc=;
 b=d2J/hc8c97Yjez9bZNXkPnr/b31FBlT+zvySdUnAxJEKNS2b9tStg29BClxld5fVvWMVEEVp0ZPZCoDM16Mis5m9PWgWNAQD763XN0O8mkTZ6aRlNiG6KejdaNh7Afn9Wn2Mxl7l7irWsTFDD9ARLciNZ7m4gNvbwAQ1J/mB7Zo=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1556.namprd11.prod.outlook.com (10.172.22.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 10:43:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 10:43:21 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH 3/9] spi: atmel-quadspi: fix naming scheme
Thread-Topic: [PATCH 3/9] spi: atmel-quadspi: fix naming scheme
Thread-Index: AQHUuK2rht/7ZFEtQkGJmNLPHPLPUaXIDnwAgAEjrwA=
Date: Thu, 31 Jan 2019 10:43:21 +0000
Message-ID: <4a18feb1-2665-37c4-79e7-3cb7b6df8665@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-4-tudor.ambarus@microchip.com>
 <20190130181904.14094418@bbrezillon>
In-Reply-To: <20190130181904.14094418@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:802:2::41) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1556;
 6:aLXgcRYrWgasF6umhkGIMDMPQvtpplMxRYJ9CaRX0Im+RZXdhrgM5DxXozg9WTab2q0HLgxZzgfr4J2+n1BmBNnNC3E39MtQmZGyqI/VRa+WYd8sXCnqppnKZ1rqCw62e9QgmHnBkofbXE04Ak3YmAXy6b8TLunYPRXnTlj0pCQ/uM1/Ka+u4ZgkBmUVLqucQ2YH+SPeuZDxdR/WM6t8VrnsxEsMHW8tsPLvie+zlleuRrJ091MkEyp9lUy92kAT08z2mF1XN5whYSzN1TnYIly+tJtWmPLBkjWuhUJJUtvEJLpAFsrEit2WJeXGn9WlpSxw0RRLaDB+++a2sOZeufFLbA8mZFTBHAZTRed4C/dd+T822Ph9wGxT4NRZFQX1Mwj1lJrZyO2UEFoKjeKv5BlTtjBpBd2Q2mNzdpbnbnZlCn5IXO8fM94fG+UUhStPtUHanw7PDH2HNw4kg5NT+A==;
 5:rWQFITQiUhPvTf0/Otc0zjHrISo3P5PnoPblCXmpAB1iR/t30dV6xugjWZIPsH4DKGQnA0b6V4EuL1t499vJ3snqnL8xSxcu3aIE+WOGImdg25mFJvKVPOUSOxwIq57QDCdl6Hs/fJpHeoA8TsGr96UBrKL7lK8lUN8lfZJDpwiWZ+KqZqby9jbmEez2mqhoN4dbs3zfzDXE6Tm9aLecIw==;
 7:nkyuMM324G8JL7ShGFFlm6LMxkQmKmr7MZZJ817G2SK52lkt7pf+OYlAQgSBD5Ui7IO9h7J9rAmEb26EgfBbfx02XrQo3ggDCVjsUVQ2nbLhMMB8nImjkByNU94007/WlYUKzZw6O+WEdrTCTL/H6g==
x-ms-office365-filtering-correlation-id: 00e6ea2d-e229-4998-12df-08d68768eaf9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1556; 
x-ms-traffictypediagnostic: BN6PR11MB1556:
x-microsoft-antispam-prvs: <BN6PR11MB15561252AB199F05E52916BCF0910@BN6PR11MB1556.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(86362001)(105586002)(31696002)(6486002)(102836004)(316002)(66066001)(52116002)(229853002)(99286004)(53546011)(72206003)(6436002)(2906002)(14454004)(6116002)(478600001)(3846002)(106356001)(4326008)(76176011)(25786009)(53936002)(6246003)(36756003)(386003)(6512007)(6506007)(8936002)(81156014)(7736002)(8676002)(476003)(446003)(305945005)(11346002)(2616005)(14444005)(68736007)(71200400001)(26005)(256004)(31686004)(486006)(71190400001)(6916009)(186003)(97736004)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1556;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 86FQQhwjT1TlBTM2ZzZsXx/wW4KTw5CmjzWYwAD727vafydyDkb8StRXBhc2vJn/PyuXJIqrzjU0s7mxvRWg3DX4ThyRshLNVaroG3DK1yf2GNjw8zZQtHX3/t4tZPoHT2UFAui2JJMBm3iw61P0P1E3/RbNG2a7PrGOXsEE73XVrwQQ+ePLCTFgC/V8WBCjK/8RbB352/J3cvWZtlZgRUCcE6wj6E4niBXv1je+ryUiXDhACWKiBYIfMdbMkWePxQ47v0bmQnhFlrcY5lh47stvE+RvGRNNyb/+VTNEJYUDjwnBE+/a83cyy/D46tjPoU7pAe3fiD/lfInCt7hhYzS7LqkFbeDlx5OpJpjFVZLwDbJuGJVpR2grcMC0EHriSNC07Ty7b7nyUOTrN5SMGO9lOStmtebkKdDhexayYuI=
Content-ID: <1FF3B4672228C341A97267F2FFE0A5AB@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e6ea2d-e229-4998-12df-08d68768eaf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 10:43:19.2521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1556
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_024325_309280_E8C77181 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/30/2019 07:19 PM, Boris Brezillon wrote:
> On Wed, 30 Jan 2019 15:08:33 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Let general names to core drivers.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>  drivers/spi/atmel-quadspi.c | 52 ++++++++++++++++++++++-----------------------
>>  1 file changed, 26 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index 64475ad16c83..e156c345705b 100644
>> --- a/drivers/spi/atmel-quadspi.c
>> +++ b/drivers/spi/atmel-quadspi.c
>> @@ -157,14 +157,14 @@ struct atmel_qspi {
>>  	struct completion	cmd_completion;
>>  };
>>  
>> -struct qspi_mode {
>> +struct atmel_qspi_mode {
>>  	u8 cmd_buswidth;
>>  	u8 addr_buswidth;
>>  	u8 data_buswidth;
>>  	u32 config;
>>  };
>>  
>> -static const struct qspi_mode sama5d2_qspi_modes[] = {
>> +static const struct atmel_qspi_mode sama5d2_qspi_modes[] = {
>>  	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
>>  	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
>>  	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
>> @@ -175,18 +175,18 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
>>  };
>>  
>>  /* Register access functions */
>> -static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
>> +static inline u32 atmel_qspi_readl(struct atmel_qspi *aq, u32 reg)
>>  {
>>  	return readl_relaxed(aq->regs + reg);
>>  }
>>  
>> -static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
>> +static inline void atmel_qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
>>  {
>>  	writel_relaxed(value, aq->regs + reg);
>>  }
> Can we get rid of these wrappers? I'm not a big fan of wrappers that
> hide the fact that accesses are relaxed.
> 

Will do, thanks!

ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
