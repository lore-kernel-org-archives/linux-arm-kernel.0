Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C7EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:46:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3116F218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F/hkPgy/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="uUfGEeAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3116F218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/KXsFotIZbDnHp3QYvGYHyk109SC7ziBdw0EG83ALFM=; b=F/hkPgy/RbXKYo
	6v8mJD0cDZuqvwRauHJzy+f12lzQv801w/l6HQDSG2n658iARnR5FfU2GKq/mzGNMSPMUiOkZf3yT
	v5yyyEz21S4vORhLxLvLPxVH/PqavSN652Gh0mewDa360afhmZPadxOIZQItcC744BMxGUHjNOKh+
	HPYSv2Wlt05c+bwgOCP8CVsNLQWmgPjS2vTqmJYwLLRfpD2FSaM6qdpwbHiZTcdYxdVyBgzhttskg
	OZbU+NbfVtCUbBGC7IxzvKMWjxIbVkEzIKsbhsNPOt07zfEeSGR5QRR34QfG3rEJZ1vrvSabl2BOM
	Lh6tMbPSZHPnqMd0hnmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp9rc-0002lC-UU; Thu, 31 Jan 2019 10:46:32 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp9rJ-0002aQ-Ch; Thu, 31 Jan 2019 10:46:20 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="27102509"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 03:46:12 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 03:46:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDg5tVAg1/O0XoLIO7pAw6KUkeOMB3aAepKRXTvm8/E=;
 b=uUfGEeAxu59z438ek70aEuS2vhVo+L559NIo9JOJlbTfu2a5qpDe8tslx1ijkfl4Op4owrE3Kklm2kTFwQAkOBdZUBhR4M/xWP+OvJSrK8QRtaAprlICvxEpHYgOILNinSYZnzJ6DtytRxGRmF/j3J/97CoV4TJKwxEbH4ssVns=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1556.namprd11.prod.outlook.com (10.172.22.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 10:46:10 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 10:46:10 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Index: AQHUuK2zcy+YTju2sU2WL87l1ywXpaXIFTCAgAEdyAA=
Date: Thu, 31 Jan 2019 10:46:10 +0000
Message-ID: <ae6235b9-be0c-525d-660e-66fb28577376@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-10-tudor.ambarus@microchip.com>
 <20190130184313.281f5374@bbrezillon>
In-Reply-To: <20190130184313.281f5374@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0064.eurprd09.prod.outlook.com
 (2603:10a6:802:28::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1556;
 6:J6O4BeaLz7ctg2vpSWnAL+AJ+Ajya7IylJTwf0Nwgkza4OAAt8o72nEbL6T3VdJ5SPp8UKjXPIq7g85eqmIa7CIWpjoMAwtCdNXOblsn9mB4tPvV/swK7oXLib1/2DG4Keio4MVJkilkLAl/SJYk3JImqkGQfqGmo/weo1yjL5xdu4Zoao5V9ne3jP4YYv+rSKQ2EBCEC3c7IJmjbeo1WHRTh2e0YtWXD3GBukM+RiHFLdvnO97LR8WjaximHXqHYxUc6dOCNnQ+aNM/S84zN7v0aHtN317SqWm+an+A6+vNa6H//PZHfjMVecOI4zCFkJdtX/lgYcitNt+RPSqa4hDboHcIpklLYH4Juje9rk08QmJfMDQK5AMD+twXxmD0KXC6HagSM5BLqmAygA1vmm7DMoc3o41mic2ZybSPtQ9mP/V4vnY+n+x1GwP1BCnzw9rOl1DnTx1wKtwhMSCg/w==;
 5:nj9BJwJQmjxwcvCYoU/vDarctqCZHQcfOY050bSSBWXwDX/iVDmbXovvUMP/dpaScQkI3m36Pa/sODCRRqEsLQ9eRbsg6NS+xtZw6Dv41a26QnrSxgexc/phXEfz6d7AK+XJtEZ8eSnbXBfpGo9DE8Z32mrzNgtLE4pDqTuik1miH2YVqc4ocgDoJkOxbVkkRyLD+JYE2fppWnfs4qb3/Q==;
 7:y0B5uIm6sb5lyOanzgaDHrGJIFVsJ1PEw8o5NzJzQkNvShp4bzZVNj9n7bMnsGGbKO9lEY3LQ51aq5pxIHQuLQnhUDn+3pmT01jzFrYT7RzUUrkWveNi6mp+ekKWjMURwPfRem35rbr1FtW69jRVcQ==
x-ms-office365-filtering-correlation-id: 8a5c73b9-d59a-4bdb-7eb0-08d687694ff1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1556; 
x-ms-traffictypediagnostic: BN6PR11MB1556:
x-microsoft-antispam-prvs: <BN6PR11MB1556695640486AD270F25CE2F0910@BN6PR11MB1556.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(86362001)(105586002)(31696002)(6486002)(102836004)(316002)(66066001)(52116002)(229853002)(99286004)(53546011)(72206003)(6436002)(2906002)(14454004)(6116002)(478600001)(3846002)(106356001)(4326008)(76176011)(25786009)(53936002)(6246003)(36756003)(386003)(6512007)(6506007)(8936002)(81156014)(7736002)(8676002)(476003)(446003)(305945005)(11346002)(2616005)(68736007)(71200400001)(26005)(256004)(31686004)(486006)(71190400001)(6916009)(186003)(97736004)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1556;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uYiCtAdbHC0wl6EsP0HQQepecOSuTy3dnGpeypx5fDz5x3+IVOgnfPtAeVFSt53HU9yRYlCj3K8BZda+0a5GAPIwZy0dsMO9rWk4H1Qb0ip5lZ59F1wbAC26EBj//72BxKjOR2UrGERYFqqukxrtQSNt3071rz/rwZvMBfmzCzevgb2UF5f+x1Nf9rPrQ0BiEfuenx//i8kForh80Len31Z/xYEHfG4NTRycWWX4YN8HiRkQC7INAQsFXiO4lWafWSDco9nkUrWtju8hiPizMfFjvGP8Ltfcju3dXD3J/JJ8a8YqGPjrZaUn9mwaa06FSCIErlwnEUzT9f9wbN51zWcMdSOcKfiNApgthy8aBEOnP5z9Sfr6KMje75cQ5EiPfEN/H1Xprex31A97b1oJFM3TdoP11xWHXnjqqTfK+/M=
Content-ID: <01C4465519B27043A274F08B2739A5FB@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5c73b9-d59a-4bdb-7eb0-08d687694ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 10:46:08.7534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1556
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_024613_654020_C1D9C54A 
X-CRM114-Status: GOOD (  11.42  )
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



On 01/30/2019 07:43 PM, Boris Brezillon wrote:
> On Wed, 30 Jan 2019 15:08:47 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> +static int atmel_sam9x60_qspi_clk_prepare_enable(struct atmel_qspi *aq)
>> +{
>> +	struct device *dev = &aq->pdev->dev;
>> +	int ret;
>> +
>> +	if (!aq->clk) {
>> +		/* Get the peripheral clock */
>> +		aq->clk = devm_clk_get(dev, "pclk");
>> +		if (IS_ERR(aq->clk)) {
>> +			dev_err(dev, "missing peripheral clock\n");
>> +			return PTR_ERR(aq->clk);
>> +		}
>> +	}
>> +
>> +	if (!aq->qspick) {
>> +		/* Get the QSPI system clock */
>> +		aq->qspick = devm_clk_get(dev, "qspick");
>> +		if (IS_ERR(aq->qspick)) {
>> +			dev_err(dev, "missing system clock\n");
>> +			return PTR_ERR(aq->qspick);
>> +		}
>> +	}
> 
> Move the devm_clk_get() calls to the probe path instead of doing it at
> prepare time, and you can make it generic for both compats with
> something like:
> 
> 	aq->clk = devm_clk_get(dev, "pclk");
> 	if (IS_ERR(aq->clk))
> 		aq->clk = devm_clk_get(dev, NULL);
> 
> 	if (IS_ERR(aq->clk))
> 		return PTR_ERR(aq->clk);
> 
> 	if (aq->caps->qspick_required) {
> 		aq->qspick = devm_clk_get(dev, "qspick");
> 		if (IS_ERR(aq->qspick)) {
> 			return PTR_ERR(aq->qspick);
> 	}

good tip, will do, thanks!

ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
