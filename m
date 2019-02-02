Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82365C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:47:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5005C20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="shDY8VyK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oIPXAUb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5005C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7EAc3JcUYxFtybjQoySKJ0ZtkweS07p/B/FF9sIGrT8=; b=shDY8VyKzFKtM/
	HPK7D+LIj3RzYZeq5wog4Fe2n/Zb2eNEPhxJZKRfgOWWcSwEwKICdctEtb1TnV185oA2qyHYcYGxx
	Mucn7Uxti2aFl/exf4tgK8jReY0dxLZ0rwjL8ic4/6TTKxgiFIWoSyPvknyvYRT7e9fzvX3qwvTh9
	4DZYrKzI9SbMhD8xkspbGFiri/gf5YTL+u+b90ceL1Fvu/PEM4tJ0ItMcyb0TLNVa4yknfRT+QK3e
	w1VQGCD9YBtE8jlfcLuNJ527G0Akz37UcDAOG8t7NJLDUMa5lyPWEECxOKC8UzcYzX+iqF/EXlv/4
	2bQzlmEy7MhSlYX67o8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpqwz-0000BB-As; Sat, 02 Feb 2019 08:46:57 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpqwm-0008QI-2J; Sat, 02 Feb 2019 08:46:45 +0000
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; d="scan'208";a="25780653"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 02 Feb 2019 01:46:40 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Sat, 2 Feb 2019 01:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDGHFS1uVXJIKnEJKMVD8DcQoOs8BhcJT3dctybOudo=;
 b=oIPXAUb8phw4oP8hNs2XPGjn845lxH0pGPhLslTWwdjaif2JJtmJQKB3tzsxIIfQO/A/sbSfG/5ccivQgqnCPoD+9IK7GT6XK7x8wd4A6OSwgQED+XOxwgGi0+Hwv1QQnqYMyQyUmWRD+NoOJlczceWUEXz/oBc11FZYMFOtpCA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1683.namprd11.prod.outlook.com (10.173.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 08:46:38 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 08:46:38 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 08/13] spi: atmel-quadspi: drop unused and NOP transfer
 macros
Thread-Topic: [PATCH v3 08/13] spi: atmel-quadspi: drop unused and NOP
 transfer macros
Thread-Index: AQHUuqzSq101Byua1EaKHaxmofM37qXMGEkAgAAZ6wA=
Date: Sat, 2 Feb 2019 08:46:38 +0000
Message-ID: <0e266a16-2f84-e1c3-440f-55105dd0c0be@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-9-tudor.ambarus@microchip.com>
 <20190202081338.01056dce@bbrezillon>
In-Reply-To: <20190202081338.01056dce@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0064.eurprd03.prod.outlook.com
 (2603:10a6:803:50::35) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1683;
 6:R3V7PUVlR98SqezQUoDAgkBf/1hR4LMYMw7E7vl1/OpnB0cAC0Zn6llJb+huBQsZ9rjOo3+7YG5os5Ju8MLgnDTeUEFwptGFNXF21qyUhjIxgILyDsN9eYc/HsFsqWhXHlbHQYiIQyVTTe0PA0Yn3+VKLNEAFgLzT9QRdcLjgclcIHcqEkfnbXKUiq1TAkaBjvHLK6k/FqKsrsn/2FvT0WU8MoDvmMWBiA8nkl0xIPuavswf8jQz+/WLbUPJA8kiqOuSDF/qi206ZE9PuI8IFaSeOWPKLp0JGbfgfmj7lGU9+pIBYUwdq9Mj56B+2uUmp/BP+85W+bPxaMGz4G57TDJe7F+z2k4XzyJuVukQkI/eWCbgw/VV3D6SILewF6kbF25lDsIRPwYwNYOwOP1Pu/G+M26sn9vndMqWOqNEmwhZHOp1eLLei4LLtb7qzMn6eB/AMKBBhWoUyXjjHwe1cQ==;
 5:AYDlayROVZPbm+EEfP/HA+NPzx4L8rCkg/zBPbNpairsPxC7zh6j/Q0/LC8QlBSC1spns63ICljkgkkmqYRnsWIXht1zIrn9ifHrEdTgR2tVlamJ/YOZQGQBPZ+0uXy3tJOY8mclEbhBisi65gTuv1Qp/On0OKe4u7QVOa17HL1z6sB62o9y35LSLF0W62PjVH6l3MSyJ0dbHHQBp8rdLg==;
 7:lmLgyEq9YZzGFKPOYFs0g+hDsp/NTtjTXEm2jxJPn2mE06l1ZM4MovZxzlsw0yfPc7BjJXU6ZAUW4g5zqJxktBdHSDQy8/iX6bJ9178fu4cVDSTUqzmLM+t4HAKmV+AaeP5QAjQOv+EFcG0dqBBGXA==
x-ms-office365-filtering-correlation-id: 3952398d-cb4c-4641-0cdc-08d688eaf1b5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1683; 
x-ms-traffictypediagnostic: BN6PR11MB1683:
x-microsoft-antispam-prvs: <BN6PR11MB1683929844D42B989CFDB4D9F0930@BN6PR11MB1683.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(14454004)(25786009)(66066001)(486006)(97736004)(256004)(446003)(6116002)(3846002)(106356001)(476003)(105586002)(11346002)(39060400002)(53936002)(36756003)(6246003)(6486002)(4326008)(316002)(229853002)(386003)(6506007)(186003)(102836004)(6436002)(6916009)(53546011)(478600001)(72206003)(7416002)(6512007)(31686004)(2616005)(26005)(7736002)(76176011)(8936002)(71190400001)(31696002)(8676002)(81156014)(99286004)(71200400001)(81166006)(2906002)(52116002)(86362001)(54906003)(305945005)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1683;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IP1vCuGM1ae1GTsw6AYSvDEsyVHwtEyS25emTnF+fKIy1XxMjPOT0QPtReVr+QlpLTeAyhh9vUf7HP5uqllTzsGQ4U/U+i2RM828IyouKzz7VaSoYfWJg7BhEjA8FnWpu57khJHwa6WZMCIIW62jV5k3oqUgFMzpI2DkOUohcARY8nm90neCgsRcLAMrfNUiAut++ZqiEeS2Ufdw1AhNONdwU7mVbUAe5EpEJMJ068BgoDkuEbXp9+sMIadFV2lZhuWMSuZm09lXjlySqNr3t5K48nEmTUdfUPVqT3Ybze4p1enUeRjqwDmh7myJnS6iZ3EkLnyxMQa30sqZVu8J511rb8J8Pz7pwxwVdTfa7uycys+1ZH0FQUt26Z7afdyG+zbnZWZyWIN4L3H30mTqAlT0IpPPOrEcObQnY+3WCEU=
Content-ID: <5B6E79892AFBFB4DAE576B1B50674CEB@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3952398d-cb4c-4641-0cdc-08d688eaf1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 08:46:35.7055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1683
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_004644_149378_BA37AC99 
X-CRM114-Status: GOOD (  12.24  )
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
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Cyrille.Pitchen@microchip.com, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/02/2019 09:13 AM, Boris Brezillon wrote:
> On Sat, 2 Feb 2019 04:07:33 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Remove NOP when setting read transfer type. Remove useless
>> setting of write transfer type when
>> op->data.dir == SPI_MEM_DATA_IN && !op->data.nbytes.
>>
>> QSPI_IFR_TFRTYP_TRSFR_WRITE is specific just to sama5d2 qspi,
>> rename it to QSPI_IFR_SAMA5D2_WRITE_TRSFR.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v3: new patch
>>
>>  drivers/spi/atmel-quadspi.c | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index d26d4cd0e36b..bfa5f5e92d96 100644
>> --- a/drivers/spi/atmel-quadspi.c
>> +++ b/drivers/spi/atmel-quadspi.c
>> @@ -113,11 +113,7 @@
>>  #define QSPI_IFR_OPTL_4BIT              (2 << 8)
>>  #define QSPI_IFR_OPTL_8BIT              (3 << 8)
>>  #define QSPI_IFR_ADDRL                  BIT(10)
>> -#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
>> -#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
>> -#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
>> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
>> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
>> +#define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)
> 
> Can you define QSPI_IFR_TFRTYP_MEM (bit 12) even if it's not used yet?

Shouldn't be introduced with the dir map support?
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
