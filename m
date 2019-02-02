Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0B6C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:44:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBA720869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EnYgjbd4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="keB1vkCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBA720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AI8UcCUoJpcaZIAvCPS2cw6QZLPUb5TInr5NQjJ89Ik=; b=EnYgjbd4uZ/z0W
	KTkahbWD0RNxbUl9eNEuoTR4FhXXYwfeue3RYnZT+sXJrWxMr3ZKnSBXtYVR+q2TUTAa0mOfwJjkf
	E6Yfq/xCUg0vOEL/fbNEUdwgY9gtw999vHlr+5Nl2F3IzA52rjPXs7WF4cX+JQRFu16rSBfcD7QYJ
	aOM68h5n8Uhy/aX+Iz7Qngjg0Lm0HyRoCb27H+RPq7FqX95jXS/n/4V1oyBoCGDUhgSjlGwa0ZhQL
	gpanooxP6cdrfA+/O02GuTJnUrBR3QdTAPInyzZlv7p+BQV/X0CyFLuWO0sPbNJPQ2/DNrRj1/sBI
	/qqTjVtbSoA+3BwpIB8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpqug-0006Ek-19; Sat, 02 Feb 2019 08:44:34 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpquc-0006DU-SD; Sat, 02 Feb 2019 08:44:32 +0000
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; d="scan'208";a="26065106"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 02 Feb 2019 01:44:29 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Sat, 2 Feb 2019 01:44:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06Xm15afEM4Px9j8FoRyu/eKLb0Rq9lUUS60Q0iqmp4=;
 b=keB1vkCZU6nF1nTtr+M//joGfgXKFaI2HHTRn4V2M44J1L8RfdXQW3D+aWNKNtN+qkm6abfQ3W4KY4D4q33KIvbx1+//lbTN00yLD9BJCerF+26r0Zni7jUJjtTI+haZDwCdKHQQuv30nUD4LFlBY49FqLecgMI9ucq4VUyyrY4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB2035.namprd11.prod.outlook.com (10.173.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 08:44:27 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 08:44:27 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Thread-Topic: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Thread-Index: AQHUuqzK70j+j/B0dE+wG5hbzKgwl6XMF5mAgAAaBoA=
Date: Sat, 2 Feb 2019 08:44:27 +0000
Message-ID: <53c9f4b2-7022-e13d-65a4-2e1bed4d76b1@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-4-tudor.ambarus@microchip.com>
 <20190202081111.0bbc4443@bbrezillon>
In-Reply-To: <20190202081111.0bbc4443@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0113.eurprd09.prod.outlook.com
 (2603:10a6:803:78::36) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB2035;
 6:6VtBruGU6zll4SCefrbHyRwD31wVQyoqTnT/cH4o1fClD0Z9AfKR26QDjs2erakjKi23xw/7MNWT8+hYmOizuQKiZgtXV1+RelIcMUITQBhsxJd1127vmT0vNhKb/pWTBJz1myx+Cg06vt9XXFgnEKKlQT+9AF5CseakMrqYlMuhEfccrD96M+Q+4m/4mkqH1JSbBgrXGTsJrgzyjKuslgHQwjEszv6iZEOhrokwXlxYrP1OoGivx3Q94MSp48MdppZDGVz/hJeMjv8ZmWx4O+PvPBaehB7d7AZvoa9JH/dSPMDNGjrwuSw3C/sHgSLfKvpPS+TdUDYbgooxEWI1HuWFE8AXsbvtgvTnU/cQedd78j0yoCuFvtlo3wHs9+nkn1ckkqZqqEmBSztbGvMShMqPPDHlnPn8pSF1PGjMjh1rnT4TtnYHWeSykXpPPiKnTKtxyudkC67Med3ECDT4WA==;
 5:CYGHxXh4gaw1bOQaBBL8f6QxMYeoJRhOMBJMPjy01x7wvDilouYYxcq+vbR0z9AoDi2Tgvpy/qePN2ZdIOD2Wl+jRrFw+zTdGcCqSkNl2++D0nq16uytSg5pqEQH8KPwTgssAosKGsMEJX48Kv/J2DbKSuMk1I3332+3gZV7DvekuwTS4X/IIv0byQ7SbDmMvI5JUEfdwTH9qktCZulW8A==;
 7:OsHFUmGewgAryL6ehU6LSA5O8lumv50t4BJ+KFE2mvU1eZvE2oA7zyhpcl6xraddDIv2kKg75BlrvB2SWVOj6MaRAkdA/CvZ94KAB9e5tILFOKf0rHAIsaibnNkVB5yV1Z13z0TC1RCrCGgAdZAHRA==
x-ms-office365-filtering-correlation-id: 348ff2a2-f321-4f3e-1248-08d688eaa3a7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB2035; 
x-ms-traffictypediagnostic: BN6PR11MB2035:
x-microsoft-antispam-prvs: <BN6PR11MB2035EFFD5018A810B55C8DC9F0930@BN6PR11MB2035.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(2616005)(8936002)(7416002)(11346002)(31686004)(105586002)(71190400001)(14454004)(71200400001)(81156014)(36756003)(8676002)(81166006)(486006)(97736004)(446003)(2906002)(3846002)(476003)(68736007)(6116002)(102836004)(39060400002)(106356001)(6246003)(229853002)(25786009)(6512007)(4326008)(99286004)(52116002)(72206003)(6506007)(53936002)(6436002)(54906003)(186003)(256004)(31696002)(66066001)(26005)(14444005)(86362001)(53546011)(478600001)(6486002)(386003)(305945005)(7736002)(316002)(76176011)(6916009)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB2035;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /dyDInrd8l2U7fwofZMFJUt0iUermzeba3imOEu3r4xd0wk9Y3kDpDHKbkbdvYWMr2vFuYbs1ZGxgtmR7aT+EvgPaKMYSFozWdYjrWahVRnPYAd1uaqZQgFocxjn5svofftSwI4LquT7hqGtg6i6EOZsng3tZEF6E/X1RCTt2oyabaN5Z+1LXpFFCKx9SiMBn2i5+o1JothGHoVe4OjWPrmmONVq0MciQ5y8f+fIhmr9voGT155gXi5mrt27cJMFnM4PUs74fLV/E+LEZr5C6quz2XUcnnXmejP8KBpaTblZ17W8sF724Nmg7TD/RmseeVotca1dPa8WUoda09wJpyaZlyFnewQ1yvbqx+Oe7VyyoFLQpL+2Achy5dLCiO60PoDk2fUspUVIwe2fSXYIpV8To9sjFCoAyiR+fwhjI0c=
Content-ID: <DCD794DE2C183345BDE83BB586E8540E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 348ff2a2-f321-4f3e-1248-08d688eaa3a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 08:44:24.7535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2035
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_004430_948589_12DA3E1E 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Ludovic.Desroches@microchip.com, Cyrille.Pitchen@microchip.com,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/02/2019 09:11 AM, Boris Brezillon wrote:
> On Sat, 2 Feb 2019 04:07:19 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> The wrappers hid that the accesses are relaxed. Drop them.
>>
>> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v3: no change
>> v2: new patch
>>
>>  drivers/spi/atmel-quadspi.c | 47 +++++++++++++++++++--------------------------
>>  1 file changed, 20 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index feeddcb25e1f..131374db0db4 100644
>> --- a/drivers/spi/atmel-quadspi.c
>> +++ b/drivers/spi/atmel-quadspi.c
>> @@ -175,17 +175,6 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
>>  	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
>>  };
>>  
>> -/* Register access functions */
>> -static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
>> -{
>> -	return readl_relaxed(aq->regs + reg);
>> -}
>> -
>> -static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
>> -{
>> -	writel_relaxed(value, aq->regs + reg);
>> -}
>> -
>>  static inline bool is_compatible(const struct spi_mem_op *op,
>>  				 const struct qspi_mode *mode)
>>  {
>> @@ -229,6 +218,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
>>  static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>  {
>>  	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
>> +	void __iomem *base = aq->regs;
> 
> Can we name this variable regs instead of base or even get rid of it
> and dereference aq->regs in the xxx_relaxed() calls (doesn't look like
> the lines would be over 80 chars even when doing that). With this
> addressed, you can add:
> 
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

I chose to introduce the "base" variable when I have at least 2 dereferences in
a function, as an optimization. In exec_op() for example, there are 6
dereferences of aq->reqs. Why do you prefer keeping aq->regs?
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
