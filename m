Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484E1C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:58:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082412146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RLnBh3En";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ou+tHGok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082412146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kX9AhWHhlwyUjOciQFvlUbnugKCKeNj0m13F4AdHGPI=; b=RLnBh3EnSenbl4
	P07ULItkJt6sQGEtmHYEbDbemdJniYvub7AwEBG6IlPr0PCW4cMkzN8i4bc49owJQOSYyuBaHLGWT
	u6IpSK/ptXoywDuMK+9ZR6CqlPLN0EQFZdbo50sEHQ2WzSeMXbZVXu+9dUFGejCqyPeBZZP1EpoDZ
	SWn8548lmB+rbF7+Nnr4NqJOAlzO8ZRZxU0z9z0zW/icZIBicsbk2Uh21PbkDN25q6mSBOleOCpEB
	j87kF7miJJNGH4242jFULMygZ02rPqA8xsH1YJaDyFxzLlALsUBc+Q1WDSQb1aZuOeBYE9d3NDPgL
	80CWGiRncw6LyFQX4X9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpr8G-0004QW-7a; Sat, 02 Feb 2019 08:58:36 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpr8B-0004Q6-Q3; Sat, 02 Feb 2019 08:58:34 +0000
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; d="scan'208";a="25780733"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 02 Feb 2019 01:58:30 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Sat, 2 Feb 2019 01:58:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/vJCv+CtlYwTCsseWAZxKudqJqpb1Cb5VNMkWAzrLI=;
 b=ou+tHGoky+Ll2zFrQw5W03k93qSKrblmCkBfX2GjVooN7RZV+XfpyOV1n/FEkj52D7wWalVXwcjmYZbTenoUYdSBxkOZBzrN8EkfVnCByA9OKXW4SjVPa/JrpbJaXHXYzfj9FyPi2KdouiBQR3RrfGgmWUruveCmDxCWVabgurU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1233.namprd11.prod.outlook.com (10.173.30.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Sat, 2 Feb 2019 08:58:25 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 08:58:25 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 13/13] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH v3 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Thread-Index: AQHUuqzaAg1hhqTy/0qkkFhSooruSKXMHKAAgAAY5oA=
Date: Sat, 2 Feb 2019 08:58:25 +0000
Message-ID: <57d4d4b2-e765-1255-0b89-a4fd61f6c1e0@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-14-tudor.ambarus@microchip.com>
 <20190202082910.0e60a757@bbrezillon>
In-Reply-To: <20190202082910.0e60a757@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:803:1::16) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1233;
 6:kPJhwBiBcyi904CxNOvyrQKOL9PWkJv92t1beUUymkExT1lwZLphjAuMot+XnVvSgQtzeYUoOjkcSiDmG1JJgfhss6wXaKpoSdZvQx4ahWd5HLde9keK9Xywn9ya/fLRP7A2foSK4f7861yqLOApEDYa1xmeGBOYkCRcOBORHNBjx+avsY9Ce+dqVXWvDVyYFpz7ModVY7Wo1a8RrEOj9CAAVAeFxz4ai/nc/i3k4fkO/oXEqijDXfneunuDAMmky4VDB29iBgFSV5gFMXWTM+lcUqo73wr0yoW+Uz9suJKgDCt2CG/eZLuS5p8WFUuUYSg0cNheNOJksrc9YTYB4xq3gdvNDyNMfFdVkh72CsHoyXhWLdDwpWRUtlMLGAWj6xvJLppYBJAxhn40S7yrFBJXxPckhiOoi8hjoHfjYCUZON2E1m6MpeVLsbXnhw8lIZuhCmHZcH0xAmRE2CKnWw==;
 5:zgfvtreT3Ril2A5jjz1oPsQtbzgndN7W3JzKfCfjouTD3lOr6EDfdPDD21UbfSohFr9TnfjlITaheO3mSyEvXyO4WViIXn2ZM6oINhSIRwLzUped8HhltA4ncxN6w6tfX6YpCyuw4wXU2FLZTEIjwoc6Biu1669/+QU8uU2q4656sojYkux5kDVZ8IZg0D7jTst625k1gBPwVfbYYRRKRg==;
 7:sLInfghauzebslXPXOcb0wZX/6ESdvDuFnkknyZXOIMEofD918ElC6w+OXKLJkVNPj866wLNB8j9etHEdR3iHslr0Xp2NjrmKDNjgngyUW9XuLcsVxB86KkIV8druIoT0+WEavC/napwAjUaSNVyag==
x-ms-office365-filtering-correlation-id: d7781f3a-e308-4a2e-9432-08d688ec976c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1233; 
x-ms-traffictypediagnostic: BN6PR11MB1233:
x-microsoft-antispam-prvs: <BN6PR11MB123352A621AE03F9FF22C8D4F0930@BN6PR11MB1233.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(6512007)(54906003)(25786009)(102836004)(71200400001)(76176011)(31686004)(6916009)(6306002)(6246003)(6506007)(386003)(105586002)(72206003)(53936002)(14444005)(316002)(256004)(36756003)(53546011)(52116002)(97736004)(7416002)(478600001)(71190400001)(6486002)(39060400002)(6116002)(476003)(68736007)(53946003)(2906002)(3846002)(31696002)(66066001)(26005)(11346002)(229853002)(7736002)(186003)(966005)(446003)(486006)(99286004)(2616005)(81166006)(14454004)(305945005)(106356001)(6436002)(30864003)(4326008)(8676002)(86362001)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1233;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QASVNvT/noUTCqDS4/mLAlrDpkQWOBibO83TdGO6SBVgxLFqGN3EQGk3hE59OWm2KnAdw+8gSH4DVKgo+4iGbCJmzE3ei4kdXCOoyBFc60YhzyQ83vqzROTdGQwzxU1xyFMchFoaMxth35iHX2bDYlqBpTE3BwPuZ64PiGiO61PEU/kH3Ko/8ZC/DuSw5HY0lWoEo0hKUpAwbLEJnKe95ezRymzXx5M4IBL5fYSTY5iDsA+kSO6INgDcf50svjDZ3LVwPKPkMYMOypxQNvAgdpKq3C1WpklKa/kfBaWU9VpqA6rIQ/Y2vWDv9lw6VF9qcJgcP16AQsFirJAonhzMtQKNz4p+1eE/N6qD4Eb0rFtYPOz6jLn+/HQkRFTuTWhNqSSAPXH/s7ibLCy7KPyetoKJNsiEOYH+gRTKJxgjHgM=
Content-ID: <CD61049DA973C14B8A67EA3FE99967AE@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d7781f3a-e308-4a2e-9432-08d688ec976c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 08:58:23.1891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1233
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_005831_906713_94711303 
X-CRM114-Status: GOOD (  22.70  )
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



On 02/02/2019 09:29 AM, Boris Brezillon wrote:
> On Sat, 2 Feb 2019 04:07:46 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
>> access, the other for the qspi core and phy. Both are mandatory. It uses
>> different transfer type bits in IFR register. It has dedicated registers
>> to specify a read or a write instruction: Read Instruction Code Register
>> (RICR) and Write Instruction Code Register (WICR). ICR/RICR/WICR have
>> identical fields.
>>
>> Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
>> done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v3:
>> - reorganize the code and change ops functions pointers to avoid code
>>   duplication. From the IP perspective, the transfer type bits are
>>   different, and what registers are written: ricr/wicr instead of icr.
>> - treat just regular spi transfers. Mem transfers will be added together
>>   with dirmap support.
>> v2:
>> - rework clock handling
>> - reorder setting of register values in set_cfg() calls -> move functions
>>   that can fail in the upper part of the function body.
>>
>>  drivers/spi/atmel-quadspi.c | 295 +++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 234 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index c9548942535a..af1e4e25097a 100644
>> --- a/drivers/spi/atmel-quadspi.c
>> +++ b/drivers/spi/atmel-quadspi.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/of_platform.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/spi/spi-mem.h>
>>  
>> @@ -35,7 +36,9 @@
>>  
>>  #define QSPI_IAR     0x0030  /* Instruction Address Register */
>>  #define QSPI_ICR     0x0034  /* Instruction Code Register */
>> +#define QSPI_WICR    0x0034  /* Write Instruction Code Register */
>>  #define QSPI_IFR     0x0038  /* Instruction Frame Register */
>> +#define QSPI_RICR    0x003C  /* Read Instruction Code Register */
>>  
>>  #define QSPI_SMR     0x0040  /* Scrambling Mode Register */
>>  #define QSPI_SKR     0x0044  /* Scrambling Key Register */
>> @@ -88,7 +91,7 @@
>>  #define QSPI_SCR_DLYBS_MASK             GENMASK(23, 16)
>>  #define QSPI_SCR_DLYBS(n)               (((n) << 16) & QSPI_SCR_DLYBS_MASK)
>>  
>> -/* Bitfields in QSPI_ICR (Instruction Code Register) */
>> +/* Bitfields in QSPI_ICR (Read/Write Instruction Code Register) */
>>  #define QSPI_ICR_INST_MASK              GENMASK(7, 0)
>>  #define QSPI_ICR_INST(inst)             (((inst) << 0) & QSPI_ICR_INST_MASK)
>>  #define QSPI_ICR_OPT_MASK               GENMASK(23, 16)
>> @@ -117,6 +120,7 @@
>>  #define QSPI_IFR_CRM                    BIT(14)
>>  #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
>>  #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
>> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)
> 
> Maybe add a comment saying it's only available on SAM9X60 or prefix it
> with SAM9X60.

I'll add a comment. The macro name is more generic how it is now and can be used
by future versions of the IP. Hypothetically speaking, if we rename it to
QSPI_IFR_SAM9x60_TFSFR_READ and other sam9x will come out, then I'll have to
rename this macro again, to make it more generic.	

> 
>>  
>>  /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
>>  #define QSPI_SMR_SCREN                  BIT(0)
>> @@ -133,16 +137,39 @@
>>  #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
>>  
>>  
>> +/* Describes register values. */
>> +struct atmel_qspi_cfg {
>> +	u32 icr;
>> +	u32 iar;
>> +	u32 ifr;
>> +};
>> +
>> +struct atmel_qspi_caps;
>> +
>>  struct atmel_qspi {
>>  	void __iomem		*regs;
>>  	void __iomem		*mem;
>>  	struct clk		*pclk;
>> +	struct clk		*qspick;
>>  	struct platform_device	*pdev;
>> +	const struct atmel_qspi_caps *caps;
>>  	u32			pending;
>>  	u32			smm;
>>  	struct completion	cmd_completion;
>>  };
>>  
>> +struct atmel_qspi_ops {
>> +	void (*set_tfrtyp)(const struct spi_mem_op *op,
>> +			   struct atmel_qspi_cfg *cfg);
>> +	void (*write_regs)(void __iomem *base, const struct spi_mem_op *op,
>> +			   const struct atmel_qspi_cfg *cfg);
>> +};
>> +
>> +struct atmel_qspi_caps {
>> +	const struct atmel_qspi_ops *ops;
>> +	bool has_qspick;
>> +};
>> +
>>  struct atmel_qspi_mode {
>>  	u8 cmd_buswidth;
>>  	u8 addr_buswidth;
>> @@ -200,30 +227,36 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
>>  	return true;
>>  }
>>  
>> -static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +static int atmel_qspi_set_mode(struct atmel_qspi_cfg *cfg,
>> +			       const struct spi_mem_op *op)
>>  {
>> -	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
>> -	void __iomem *base = aq->regs;
>> -	int mode;
>> -	u32 dummy_cycles = 0;
>> -	u32 iar, icr, ifr, sr;
>> -	int err = 0;
>> -
>> -	iar = 0;
>> -	icr = QSPI_ICR_INST(op->cmd.opcode);
>> -	ifr = QSPI_IFR_INSTEN;
>> +	int mode = atmel_qspi_find_mode(op);
>>  
>> -	/* Set the QSPI controller in Serial Memory Mode */
>> -	if (aq->smm != QSPI_MR_SMM) {
>> -		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
>> -		aq->smm = QSPI_MR_SMM;
>> -	}
>> -
>> -	mode = atmel_qspi_find_mode(op);
>>  	if (mode < 0)
>>  		return mode;
>> +	cfg->ifr = sama5d2_qspi_modes[mode].config;
> 
> Looks like modes are the same for sama5d2 and sam9x60, so maybe you
> should rename the sama5d2_qspi_modes variable into something more
> generic.

will do

> 
>> +	return 0;
>> +}
>>  
>> -	ifr |= sama5d2_qspi_modes[mode].config;
>> +/*
> 
> Kernel doc headers should starts with /**, but maybe you did that on
> purpose to avoid having this header parsed in case someone decides to
> add this file to the list of files parsed for doc creation.

I'll add /**

> 
>> + * atmel_qspi_set_address_mode() - set address mode.
>> + * @cfg:	contains register values
>> + * @op:		describes a SPI memory operation
>> + *
>> + * The controller allows 24 and 32-bit addressing while NAND-flash requires
>> + * 16-bit long. Handling 8-bit long addresses is done using the option field.
>> + * For the 16-bit addresses, the workaround depends of the number of requested
>> + * dummy bits. If there are 8 or more dummy cycles, the address is shifted and
>> + * sent with the first dummy byte. Otherwise opcode is disabled and the first
>> + * byte of the address contains the command opcode (works only if the opcode and
>> + * address use the same buswidth). The limitation is when the 16-bit address is
>> + * used without enough dummy cycles and the opcode is using a different buswidth
>> + * than the address.
> 
> This comment would better be placed directly in the function just
> before the switch() statement.

ok

> 
>> + */
>> +static int atmel_qspi_set_address_mode(struct atmel_qspi_cfg *cfg,
>> +				       const struct spi_mem_op *op)
>> +{
>> +	u32 dummy_cycles = 0;
>>  
>>  	if (op->dummy.buswidth && op->dummy.nbytes)
>>  		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
>> @@ -233,28 +266,28 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>  		case 0:
>>  			break;
>>  		case 1:
>> -			ifr |= QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
>> -			icr |= QSPI_ICR_OPT(op->addr.val & 0xff);
>> +			cfg->ifr |= QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
>> +			cfg->icr = QSPI_ICR_OPT(op->addr.val & 0xff);
>>  			break;
>>  		case 2:
>>  			if (dummy_cycles < 8 / op->addr.buswidth) {
>> -				ifr &= ~QSPI_IFR_INSTEN;
>> -				ifr |= QSPI_IFR_ADDREN;
>> -				iar = (op->cmd.opcode << 16) |
>> -					(op->addr.val & 0xffff);
>> +				cfg->ifr &= ~QSPI_IFR_INSTEN;
>> +				cfg->ifr |= QSPI_IFR_ADDREN;
>> +				cfg->iar = (op->cmd.opcode << 16) |
>> +					   (op->addr.val & 0xffff);
>>  			} else {
>> -				ifr |= QSPI_IFR_ADDREN;
>> -				iar = (op->addr.val << 8) & 0xffffff;
>> +				cfg->ifr |= QSPI_IFR_ADDREN;
>> +				cfg->iar = (op->addr.val << 8) & 0xffffff;
>>  				dummy_cycles -= 8 / op->addr.buswidth;
>>  			}
>>  			break;
>>  		case 3:
>> -			ifr |= QSPI_IFR_ADDREN;
>> -			iar = op->addr.val & 0xffffff;
>> +			cfg->ifr |= QSPI_IFR_ADDREN;
>> +			cfg->iar = op->addr.val & 0xffffff;
>>  			break;
>>  		case 4:
>> -			ifr |= QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
>> -			iar = op->addr.val & 0x7ffffff;
>> +			cfg->ifr |= QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
>> +			cfg->iar = op->addr.val & 0x7ffffff;
>>  			break;
>>  		default:
>>  			return -ENOTSUPP;
>> @@ -263,22 +296,99 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>  
>>  	/* Set number of dummy cycles */
>>  	if (dummy_cycles)
>> -		ifr |= QSPI_IFR_NBDUM(dummy_cycles);
>> +		cfg->ifr |= QSPI_IFR_NBDUM(dummy_cycles);
>>  
>> -	/* Set data enable */
>> -	if (op->data.nbytes)
>> -		ifr |= QSPI_IFR_DATAEN;
>> +	return 0;
>> +}
>>  
>> +static void atmel_qspi_sama5d2_set_tfrtyp(const struct spi_mem_op *op,
>> +					  struct atmel_qspi_cfg *cfg)
>> +{
>>  	if (op->data.dir == SPI_MEM_DATA_OUT)
>> -		ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
>> +		cfg->ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
>> +}
>>  
>> +static void atmel_qspi_sama5d2_write_regs(void __iomem *base,
>> +					  const struct spi_mem_op *op,
>> +					  const struct atmel_qspi_cfg *cfg)
>> +{
>>  	/* Clear pending interrupts */
>>  	(void)readl_relaxed(base + QSPI_SR);
>>  
>>  	/* Set QSPI Instruction Frame registers */
>> -	writel_relaxed(iar, base + QSPI_IAR);
>> -	writel_relaxed(icr, base + QSPI_ICR);
>> -	writel_relaxed(ifr, base + QSPI_IFR);
>> +	writel_relaxed(cfg->iar, base + QSPI_IAR);
>> +	writel_relaxed(cfg->icr, base + QSPI_ICR);
>> +	writel_relaxed(cfg->ifr, base + QSPI_IFR);
>> +}
>> +
>> +static void atmel_qspi_sam9x60_set_tfrtyp(const struct spi_mem_op *op,
>> +					  struct atmel_qspi_cfg *cfg)
>> +{
>> +	if (!op->addr.nbytes && op->data.dir == SPI_MEM_DATA_IN)
>> +		cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
>> +}
>> +
>> +static void atmel_qspi_sam9x60_write_regs(void __iomem *base,
>> +					  const struct spi_mem_op *op,
>> +					  const struct atmel_qspi_cfg *cfg)
>> +{
>> +	/* Clear pending interrupts */
>> +	(void)readl_relaxed(base + QSPI_SR);
>> +
>> +	/* Set QSPI Instruction Frame registers */
>> +	writel_relaxed(cfg->iar, base + QSPI_IAR);
>> +	if (op->data.dir == SPI_MEM_DATA_IN)
>> +		writel_relaxed(cfg->icr, base + QSPI_RICR);
>> +	else
>> +		writel_relaxed(cfg->icr, base + QSPI_ICR);
>> +	writel_relaxed(cfg->ifr, base + QSPI_IFR);
>> +}
>> +
>> +static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
>> +			      const struct spi_mem_op *op,
>> +			      struct atmel_qspi_cfg *cfg)
>> +{
>> +	void __iomem *base = aq->regs;
>> +	int ret;
>> +
>> +	/* Set the QSPI controller in Serial Memory Mode */
>> +	if (aq->smm != QSPI_MR_SMM) {
>> +		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
> 
> 					    aq->reqs +
> 
> and you can get rid of base.

I will wait your reasons on this, see 3/13

> 
>> +		aq->smm = QSPI_MR_SMM;
>> +	}
>> +
>> +	ret = atmel_qspi_set_mode(cfg, op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = atmel_qspi_set_address_mode(cfg, op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	cfg->ifr |= QSPI_IFR_INSTEN;
>> +	cfg->icr |= QSPI_ICR_INST(op->cmd.opcode);
>> +
>> +	/* Set data enable */
>> +	if (op->data.nbytes)
>> +		cfg->ifr |= QSPI_IFR_DATAEN;
>> +
>> +	aq->caps->ops->set_tfrtyp(op, cfg);
>> +	aq->caps->ops->write_regs(base, op, cfg);
>> +
>> +	return 0;
>> +}
>> +
>> +static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
>> +	void __iomem *base = aq->regs;
>> +	struct atmel_qspi_cfg cfg = {0};
>> +	u32 sr;
>> +	int err;
>> +
>> +	err = atmel_qspi_set_cfg(aq, op, &cfg);
>> +	if (err)
>> +		return err;
>>  
>>  	/* Skip to the final steps if there is no data */
>>  	if (op->data.nbytes) {
>> @@ -287,11 +397,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>  
>>  		/* Send/Receive data */
>>  		if (op->data.dir == SPI_MEM_DATA_IN)
>> -			_memcpy_fromio(op->data.buf.in,
>> -				aq->mem + iar, op->data.nbytes);
>> +			_memcpy_fromio(op->data.buf.in, aq->mem + cfg.iar,
>> +				       op->data.nbytes);
>>  		else
>> -			_memcpy_toio(aq->mem + iar,
>> -				op->data.buf.out, op->data.nbytes);
>> +			_memcpy_toio(aq->mem + cfg.iar, op->data.buf.out,
>> +				     op->data.nbytes);
>>  
>>  		/* Release the chip-select */
>>  		writel_relaxed(QSPI_CR_LASTXFER, base + QSPI_CR);
>> @@ -391,9 +501,22 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>>  	struct spi_controller *ctrl;
>>  	struct atmel_qspi *aq;
>>  	struct resource *res;
>> +	const struct atmel_qspi_caps *caps;
>> +	struct device *dev = &pdev->dev;
> 
> If you really want to do this &pdev->dev -> dev conversion (which I
> don't think is necessary given that we don't have over 80 chars lines),
> please do it in separate patch.

ditto. Thanks again!
ta

> 
>>  	int irq, err = 0;
>>  
>> -	ctrl = spi_alloc_master(&pdev->dev, sizeof(*aq));
>> +	caps = of_device_get_match_data(dev);
>> +	if (!caps) {
>> +		dev_err(dev, "Could not retrieve QSPI caps\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!caps->ops->set_tfrtyp || !caps->ops->write_regs) {
>> +		dev_err(dev, "Could not retrieve QSPI ops\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ctrl = spi_alloc_master(dev, sizeof(*aq));
>>  	if (!ctrl)
>>  		return -ENOMEM;
>>  
>> @@ -409,32 +532,33 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>>  
>>  	init_completion(&aq->cmd_completion);
>>  	aq->pdev = pdev;
>> +	aq->caps = caps;
>>  
>>  	/* Map the registers */
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
>> -	aq->regs = devm_ioremap_resource(&pdev->dev, res);
>> +	aq->regs = devm_ioremap_resource(dev, res);
>>  	if (IS_ERR(aq->regs)) {
>> -		dev_err(&pdev->dev, "missing registers\n");
>> +		dev_err(dev, "missing registers\n");
>>  		err = PTR_ERR(aq->regs);
>>  		goto exit;
>>  	}
>>  
>>  	/* Map the AHB memory */
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
>> -	aq->mem = devm_ioremap_resource(&pdev->dev, res);
>> +	aq->mem = devm_ioremap_resource(dev, res);
>>  	if (IS_ERR(aq->mem)) {
>> -		dev_err(&pdev->dev, "missing AHB memory\n");
>> +		dev_err(dev, "missing AHB memory\n");
>>  		err = PTR_ERR(aq->mem);
>>  		goto exit;
>>  	}
>>  
>>  	/* Get the peripheral clock */
>> -	aq->pclk = devm_clk_get(&pdev->dev, "pclk");
>> +	aq->pclk = devm_clk_get(dev, "pclk");
>>  	if (IS_ERR(aq->pclk))
>> -		aq->pclk = devm_clk_get(&pdev->dev, NULL);
>> +		aq->pclk = devm_clk_get(dev, NULL);
>>  
>>  	if (IS_ERR(aq->pclk)) {
>> -		dev_err(&pdev->dev, "missing peripheral clock\n");
>> +		dev_err(dev, "missing peripheral clock\n");
>>  		err = PTR_ERR(aq->pclk);
>>  		goto exit;
>>  	}
>> @@ -442,32 +566,52 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>>  	/* Enable the peripheral clock */
>>  	err = clk_prepare_enable(aq->pclk);
>>  	if (err) {
>> -		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
>> +		dev_err(dev, "failed to enable the peripheral clock\n");
>>  		goto exit;
>>  	}
>>  
>> +	if (caps->has_qspick) {
>> +		/* Get the QSPI system clock */
>> +		aq->qspick = devm_clk_get(dev, "qspick");
>> +		if (IS_ERR(aq->qspick)) {
>> +			dev_err(dev, "missing system clock\n");
>> +			err = PTR_ERR(aq->qspick);
>> +			goto disable_pclk;
>> +		}
>> +
>> +		/* Enable the QSPI system clock */
>> +		err = clk_prepare_enable(aq->qspick);
>> +		if (err) {
>> +			dev_err(dev,
>> +				"failed to enable the QSPI system clock\n");
>> +			goto disable_pclk;
>> +		}
>> +	}
>> +
>>  	/* Request the IRQ */
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (irq < 0) {
>> -		dev_err(&pdev->dev, "missing IRQ\n");
>> +		dev_err(dev, "missing IRQ\n");
>>  		err = irq;
>> -		goto disable_pclk;
>> +		goto disable_qspick;
>>  	}
>> -	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
>> -			       0, dev_name(&pdev->dev), aq);
>> +	err = devm_request_irq(dev, irq, atmel_qspi_interrupt, 0,
>> +			       dev_name(dev), aq);
>>  	if (err)
>> -		goto disable_pclk;
>> +		goto disable_qspick;
>>  
>>  	err = atmel_qspi_init(aq);
>>  	if (err)
>> -		goto disable_pclk;
>> +		goto disable_qspick;
>>  
>>  	err = spi_register_controller(ctrl);
>>  	if (err)
>> -		goto disable_pclk;
>> +		goto disable_qspick;
>>  
>>  	return 0;
>>  
>> +disable_qspick:
>> +	clk_disable_unprepare(aq->qspick);
>>  disable_pclk:
>>  	clk_disable_unprepare(aq->pclk);
>>  exit:
>> @@ -483,6 +627,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>>  
>>  	spi_unregister_controller(ctrl);
>>  	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
>> +	clk_disable_unprepare(aq->qspick);
>>  	clk_disable_unprepare(aq->pclk);
>>  	return 0;
>>  }
>> @@ -491,6 +636,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
>>  {
>>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>>  
>> +	clk_disable_unprepare(aq->qspick);
>>  	clk_disable_unprepare(aq->pclk);
>>  
>>  	return 0;
>> @@ -501,6 +647,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
>>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>>  
>>  	clk_prepare_enable(aq->pclk);
>> +	clk_prepare_enable(aq->qspick);
>>  
>>  	return atmel_qspi_init(aq);
>>  }
>> @@ -508,8 +655,34 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
>>  static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
>>  			 atmel_qspi_resume);
>>  
>> +static const struct atmel_qspi_ops atmel_sama5d2_qspi_ops = {
>> +	.set_tfrtyp = atmel_qspi_sama5d2_set_tfrtyp,
>> +	.write_regs = atmel_qspi_sama5d2_write_regs,
>> +};
>> +
>> +static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps = {
>> +	.ops = &atmel_sama5d2_qspi_ops,
>> +};
>> +
>> +static const struct atmel_qspi_ops atmel_sam9x60_qspi_ops = {
>> +	.set_tfrtyp = atmel_qspi_sam9x60_set_tfrtyp,
>> +	.write_regs = atmel_qspi_sam9x60_write_regs,
>> +};
>> +
>> +static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps = {
>> +	.ops = &atmel_sam9x60_qspi_ops,
>> +	.has_qspick = true,
>> +};
>> +
>>  static const struct of_device_id atmel_qspi_dt_ids[] = {
>> -	{ .compatible = "atmel,sama5d2-qspi" },
>> +	{
>> +		.compatible = "atmel,sama5d2-qspi",
>> +		.data = &atmel_sama5d2_qspi_caps,
>> +	},
>> +	{
>> +		.compatible = "microchip,sam9x60-qspi",
>> +		.data = &atmel_sam9x60_qspi_caps,
>> +	},
>>  	{ /* sentinel */ }
>>  };
>>  
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
