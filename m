Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD41C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:45:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E644218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HW/VRqpR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FMsZTVuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E644218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gy+GszUyV0BVfMmvO8BguaBHEny6KWhRAI7gZ1LPcDE=; b=HW/VRqpRTbjdXe
	tSu8RhMrMUWT53jnKBViEs4Hxpmn50iweNZEfSUxuIpfii4NY3KdzWgo7QhNenRpqxIWBoHgpU46M
	r796+GgAMG9jGm2NzDgLno/f5fZR4rcn71iKu4wHQjQt3WVHQGtcWPr0eS0Z5ZcP5GlH5cpWFxglv
	J8fYnCFkKhYy8fTKcLI4ggIpnI2+uN0lydCwocQZ6IX1fnPaGPnxXk6NAZ6KlLfYFnRKI5vDU6jNr
	Y7yw6XyTBS5I3J8GXXKwmSA6iYj88R3ziJCYUdYUUYjWirhDpqjkmxGlKWXutVonZzqYLsDzd1lVO
	7T9Fiw2a3CWi95Q4Jm7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp9ql-00027W-0F; Thu, 31 Jan 2019 10:45:39 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp9qg-000273-RB; Thu, 31 Jan 2019 10:45:36 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="25978570"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 03:45:33 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 03:45:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj0BgrA4fZ0HvSGLRKiGCOQm50KqFxVBsey0UHH5nsY=;
 b=FMsZTVuops8wa8kwgmCTNUtYSkDdR0nu4/7aJPEOyum8fUEHVpRkO1AOS9Y4D2Y/SZeg1ckLVHwA1Fd/PEXE4lgaO5q/T5bd9sMZ8YvP4pLa2YMqYUK7mTICvxEL7yNuwEsHN8nfKc7LyRZnQ3FXFY56uXh833Y9wCmDvH8Ay7w=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1556.namprd11.prod.outlook.com (10.172.22.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 10:45:31 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 10:45:31 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Index: AQHUuK2xf3u2KPfoDkGm5485KIOYJ6XIEYeAgAEhPwA=
Date: Thu, 31 Jan 2019 10:45:31 +0000
Message-ID: <8e2e61fe-e0a6-b84a-643a-a29c18b5861f@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-9-tudor.ambarus@microchip.com>
 <20190130182958.528e5ac0@bbrezillon>
In-Reply-To: <20190130182958.528e5ac0@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0043.eurprd09.prod.outlook.com
 (2603:10a6:802:28::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1556;
 6:+ALk6UGCwm6ovYBqTPZtN1XoRITadVmYoFPf+D0XnVmSyoqAfPf7MYNV2QU340zGfGOWuxe8Avhtgxfa7iMVUiQiXkRTwTxsoMtfYjB2CXLAHIYj8MWm+iCa56d2vTcatcKzznaloMoW29VpL44I9ZtkpxX8N5t0uLffxDtW2E6oJKBitMa7X9L7uceB/PX0lv4lembhfCL3MGZMbqwBOdQszn1Ng8ZtoMrxOx3d2W5oPgwxH0L8ALXe7h/3h45jdMycIOT1ipPXnDbbUjNYiz0JU7tqDaIB0fTU9jpD27uPtYDF0bwMo9FsFJg9nKVQjX+iauoXdY/9Bi8mnH/Aj3keFS+FcVYpuZWvRVxXLb63DK3kgYrgYwfoJUFy0cJZt03DkhCNNpU3p5N36P5a+ebv9Z1Ktigji87JMmyRUa5mjuMZzi2iFLWJG92jse0KDlYCbFWLQxmSycijzoU5Bw==;
 5:oR8X6f6Ks1rP0FLHpifTvOHS/a0coJ/6gCw2Ll0qnVkoIOTTa9YMc6u+GuFfn+GabrU/pBdC8rihjSafhZOvATScJPeMVVJzDwfoFiZaBvtlTWYRpD+umpUHohmeqWqw8xvunYq/GjxKqCpuO1W38V0VSg0adORwNLCQmC+ojF1w5w8ybYbx/znDIzMjpkowiUjHPH7MrEFQNzu2iIE99w==;
 7:CjGeu4e9N0qkzmAhPWSTS2EIyiS9FkI6JCg6IgCMi7104O+OHeQB+4xaTab1cAd0P3d9BMmBM/+nJwFQ13PgVfiJNjIjvA5IFYsaU95dbDK6OtXnikKLMoCAeVoNtv6ucFG0+8aAq1ocofKWga9eaw==
x-ms-office365-filtering-correlation-id: 70966c54-e7c3-4252-f4c6-08d6876938ac
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1556; 
x-ms-traffictypediagnostic: BN6PR11MB1556:
x-microsoft-antispam-prvs: <BN6PR11MB15568FC079D6BCD71C3C30B7F0910@BN6PR11MB1556.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(86362001)(105586002)(31696002)(6486002)(102836004)(316002)(66066001)(52116002)(229853002)(99286004)(53546011)(72206003)(6436002)(2906002)(14454004)(6116002)(478600001)(3846002)(106356001)(4326008)(76176011)(25786009)(53936002)(6246003)(36756003)(386003)(6512007)(6506007)(8936002)(81156014)(7736002)(8676002)(476003)(446003)(305945005)(11346002)(2616005)(14444005)(68736007)(71200400001)(26005)(256004)(31686004)(486006)(71190400001)(6916009)(186003)(97736004)(81166006)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1556;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vZ4xJidGxkHXY1qfnizA3xk0hMqDt3pQa3tQ77iYMoHQPewQ+JpnPNOzJM5jWg2JW9oJS+AV9u/zZO1hJF/mrnr20Kj9bIi1BEsRzwe2qnX6mcz5jR1QpvOMea+oADvcTiDU+eXubqRmAqQ+uJWDuTWIzafRK4gQRF5rLP8UjIEYScm6R0agu+iQOQVPUNtNnCVBGlfn/fEjKlnD6eG386iFf2fiKCOWuNormUMRaxHKKRHGN/IndCXMPsYIbHk6IJBg6BHV0nwhHhVjkwr1wE9i3aXM9Po6rgx9ghb/lMrME1a6tuv+b7cEKa+VgX+Kfg7X0pllqXrZBjNfyajqm+4PXg2piRgKWfLHKw2n6FPlBXO4lviWYZGzvn1BxD+lP1wT3vw9ZzsBlEqNCPdpfAcNIkHum7/yg7rnksGkTCw=
Content-ID: <00EF13784384DA45B49B0AA7E9E17990@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70966c54-e7c3-4252-f4c6-08d6876938ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 10:45:27.6088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1556
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_024534_951951_BBDFBFE2 
X-CRM114-Status: GOOD (  16.94  )
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



On 01/30/2019 07:30 PM, Boris Brezillon wrote:
> On Wed, 30 Jan 2019 15:08:45 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
>> access, the other for the qspi core and phy. Both are mandatory.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>  .../devicetree/bindings/spi/atmel-quadspi.txt      | 28 ++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
>> index e9dae6264d89..e7b7f297c5d7 100644
>> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
>> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
>> @@ -1,14 +1,22 @@
>>  * Atmel Quad Serial Peripheral Interface (QSPI)
>>  
>>  Required properties:
>> -- compatible:     Should be "atmel,sama5d2-qspi".
>> +- compatible:     Should be one of the following
>> +		  - "atmel,sama5d2-qspi"
>> +		  - "microchip,sam9x60-qspi"
>>  - reg:            Should contain the locations and lengths of the base registers
>>                    and the mapped memory.
>>  - reg-names:      Should contain the resource reg names:
>>                    - qspi_base: configuration register address space
>>                    - qspi_mmap: memory mapped address space
>>  - interrupts:     Should contain the interrupt for the device.
>> -- clocks:         The phandle of the clock needed by the QSPI controller.
>> +- clocks:	  - "atmel,sama5d2-qspi": the phandle of the clock needed by the
>> +		  QSPI controller.
>> +		  - "microchip,sam9x60-qspi": should reference the peripheral
>> +		  and system QSPI clocks.
>> +- clock-names:    Only for sam9x60 - should contain two strigs:
> 
> 							   ^strings
> 
> And I think naming clocks even for sama5d2 is a good practice, so I'd
> suggest making "pclk" mandatory even if you support unnamed clk in the
> driver to be backward compatible with old DTs.

agreed

> 
>> +		  - "pclk" for the peripheral clock
>> +		  - "qspick" for the system clock
>>  - #address-cells: Should be <1>.
>>  - #size-cells:    Should be <0>.
>>  
>> @@ -29,3 +37,19 @@ spi@f0020000 {
>>  		...
>>  	};
>>  };
>> +
>> +qspi@f0014000 {
>> +	compatible = "microchip,sam9x60-qspi";
>> +	reg = <0xf0014000 0x100>, <0x70000000 0x08000000>;
>> +	reg-names = "qspi_base", "qspi_mmap";
>> +	interrupts = <35 IRQ_TYPE_LEVEL_HIGH 7>;
>> +	clocks =  <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_SYSTEM 19>;
>> +	clock-names = "pclk", "qspick";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	pinctrl-names = "default";
>> +
>> +	flash@0 {
>> +		...
>> +	};
>> +};
> 
> No need to add one example per compat, especially when all that
> changes is the compat string and an extra clk. 

ok, thanks!
ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
