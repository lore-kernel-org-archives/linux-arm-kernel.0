Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06C4C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:56:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989A520869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A8CzHN2c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kC6jPXH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989A520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pt/dPrNeHdQThHNBfpPtWNjfM4QpKZOSuIwogg4z4YE=; b=A8CzHN2cf9n4xc
	w5SOU0sEi0x7mT6malgxHpqTygWHqhQbGLfoGWxs3GtEEV2/ecWAJUgVQRLvvb8J7syF7vUT8G5kz
	TA9H5OL1hw1c1lW62SAaYRS0jjDmd+fGOarfP4AZpLBUUR1LqMpgD752ipVryXPWx1bZQwHGZh4t2
	2C1fDEVWBEIs9TCXsHQASMnSH7z8e5kSxprtvxgoYdj6ELeI1qKjyxL3alTYErv4AFUhTK/VSEF+B
	xMnDP3T4fEUFEZjtbp9rRDNKMP4vyHz8V7c6Ven79lArOWuO9NHRYZ2mnJY/hEAgGeCg+TfO02FKw
	V/rG1ufof80ZEg1TLqqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpr5s-0004Mq-3S; Sat, 02 Feb 2019 08:56:08 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpqx6-0000Ku-5v; Sat, 02 Feb 2019 08:47:18 +0000
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; d="scan'208";a="25780655"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 02 Feb 2019 01:47:03 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sat, 2 Feb 2019 01:47:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pn1N7N3j6fKiCmRQVk6neSq0EoKARTIsuHv8vx7QEM=;
 b=kC6jPXH6Q6Xvkn058Zw5dzOavPL10UEHYqTO/Gx8KQxJX223iG1gCHfMB3WRzoxB6qjj6K9l9wc6pqOLl07O5NWAXNgqIsyVWrGWXp55HwWcnIjgDBSkYMO28tlTT6zDc1MLNa61EkySySi3gQqtNzO++jrKeaOBOKWuKT1N0YA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1683.namprd11.prod.outlook.com (10.173.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 08:47:00 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 08:47:00 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Topic: [PATCH v3 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Index: AQHUuqzWMMnmbraYeUy6BKjmB0h60qXMGK0AgAAZp4A=
Date: Sat, 2 Feb 2019 08:47:00 +0000
Message-ID: <25ed6e19-4fe6-7b8c-4eeb-5bd5be1075fe@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-11-tudor.ambarus@microchip.com>
 <20190202081502.47ca404d@bbrezillon>
In-Reply-To: <20190202081502.47ca404d@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0060.eurprd03.prod.outlook.com
 (2603:10a6:803:50::31) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1683;
 6:kaUc/EWRjl8y/D8tPFNrNXvrB8Oa1suMbyHuq/sefz/txCa7Mh5LhmJ6TGybvwFuyLFMePJOqMXFOPNl6GMgLxZUEwDOVaIPKA+xHviS0iIxLX2f8fGofF4WdBXssfQmcwhwJ+7JfRvo6EQ/3fZH5835M0lS4BsJqUm8CsUN8qJPey3VjIISC6BM29cgDEh0Y+8Y8YkgRdKEEQY61ob4R3VU4Vu2Lqj+UiQtgsIbJKF5+GXm8N6ckivM/2ZFbYw9M2+7JieV8rJeV+pasgpzzPPLgUoqVXjvPSoEoXIDnwCeBt7elurTMdki+umWkKDHu+jkH2F2d3QpaaqwmtZ6vCnbUFccmlR3vAbFE059iQ1TXYEbHOnZlA55XwZ16440qv2NnaBeAcEVawtMjxarqWjhq1sLCddAB2xyAqkWuLZLLnIlEHATkbQePxi2IhO9YvzLVVknxJgxof2r6jAcFA==;
 5:p0G8Mb2puCNYSK7LInJPf/tOKfrR8unhNLskTvld5apWM7OsAjNXasMSmkjHQAEeCKi/tlG1z64xjmeFuxDoklQCiH8Gg5ugKTTsZxVlST+E78p0F7KGhU/BON6tW2in5Ti9j39GB8TqZFoc+3oiTen+d9ZUjO8rezTyAMoZCu1sLWVVl4ft0vv3GPu+zHVt/WAHEyWbjB2DkxWFrBcM8w==;
 7:3pT+J/t6O5bLg4d8jZFKd/FScMIRlQVOlmPho90YF9faTGZWygcNq25DpSfPcGux387MNorA91fEqxzZIqX71GB77zNhvrRB4XcLJRMyPIh6ioEth24kyfeScg/ylvP53pYYpQjY/gVcTCjfvshmSw==
x-ms-office365-filtering-correlation-id: 4689e1b7-f483-44e5-4077-08d688eafece
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1683; 
x-ms-traffictypediagnostic: BN6PR11MB1683:
x-microsoft-antispam-prvs: <BN6PR11MB1683DC372F7C7D349B58F846F0930@BN6PR11MB1683.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(14454004)(25786009)(66066001)(486006)(97736004)(256004)(446003)(6116002)(3846002)(106356001)(476003)(105586002)(11346002)(39060400002)(53936002)(36756003)(6246003)(6486002)(4326008)(316002)(229853002)(386003)(6506007)(186003)(102836004)(6436002)(6916009)(53546011)(478600001)(72206003)(7416002)(6512007)(31686004)(6306002)(2616005)(966005)(26005)(7736002)(76176011)(8936002)(71190400001)(31696002)(8676002)(81156014)(99286004)(71200400001)(81166006)(2906002)(52116002)(86362001)(54906003)(305945005)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1683;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BolOYz4tT3eBpCuri+4GNNa835yvmjmiQGQNg2l16mmVMPw9TT995PrqwGyNE/kD5BP6yZrGS038YdwLBK2Kny0iJpJMb11WrdynR/uLkhvZzbOPk127wYd1eXRz+6LoYxWcZsM/phZw4KA2ZJYxeBrcka4y9me3tXzoYrKR8YfRhOGr0kERIEDT6wAdRvBKSi1RVs7mBDfFAJgO8nwyhvcZiGCfdTIAwwqqaAOKxSk+lGDoSoR8R38EcoZWZC3I//++mhth0Er/dd6/sbjow0NfjoCgP+ILPRBic5/PZP2dhz50Uu8foqoa5iAyEvikrNEH2TEc60QvhDaYIx/BWbZZrN9ozPpv8qK32oYeFY2tGq4FX3ZJP/MlfB65Bf9y/+8gwvr3aSRcazgEMw2KXkQfTzAi/sSClZXkbFbS4NI=
Content-ID: <99E80F55C8520C429E271364A66E5D0E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4689e1b7-f483-44e5-4077-08d688eafece
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 08:46:57.3317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1683
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_004705_131563_C3F0933D 
X-CRM114-Status: GOOD (  12.81  )
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



On 02/02/2019 09:15 AM, Boris Brezillon wrote:
> On Sat, 2 Feb 2019 04:07:39 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Naming clocks is a good practice. Make "pclk" madatory even if
>> we support unnamed clock in the driver, to be backward compatible
>> with old DTs.
>>
>> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v3: new patch
>>
>>  Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
>> index e9dae6264d89..1de54e87f5d6 100644
>> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
>> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
>> @@ -9,6 +9,7 @@ Required properties:
>>                    - qspi_mmap: memory mapped address space
>>  - interrupts:     Should contain the interrupt for the device.
>>  - clocks:         The phandle of the clock needed by the QSPI controller.
>> +- clock-names:    Should contain "pclk" for the peripheral clock.
>>  - #address-cells: Should be <1>.
>>  - #size-cells:    Should be <0>.
>>  
>> @@ -20,6 +21,7 @@ spi@f0020000 {
>>  	reg-names = "qspi_base", "qspi_mmap";
>>  	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
>>  	clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
>> +	clock-names = "pclk"
> 
> Missing semicolon. Once fixed you can add
> 
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

will do, thanks!

> 
>>  	#address-cells = <1>;
>>  	#size-cells = <0>;
>>  	pinctrl-names = "default";
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
