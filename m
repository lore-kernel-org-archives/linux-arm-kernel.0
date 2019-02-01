Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CF3C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:08:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF5520869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MqCh7UuR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="a9qnJdDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF5520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W2kVfGLgFY0qMhpt9BhOvGgsgYz//YvXBbo2dTjTYS8=; b=MqCh7UuRQa3ssy
	ZBK0noO+Qhy9jknGdHeIeC6QYaudoMJyAxgZgbrXLbEtTM5gh5vObFHVtf/OKgeInF+8nmpaxShmx
	2u57M1vNGdDTeDJpYvSTMt957RXKcsRC46D6h1iMKU++VUmTRS5zQLOOex19a8w75QJEcplr3gtnX
	OGzQ3wVR5EAGxpZP+DzmWLeETzv8uHjWVMs1RmClHE91BHSoOlbOtdiVrlLiei9ibEu2D7ChjXLKg
	4w7f9Zk0KM8Oi9RoR+gSVfvMLqtNsd3dLRw+EsFECXv9Fvsvwxa2i5q191kuqtV7b8yaVuyZ5OP+f
	T9EzbiXMX1frQw8BfKJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpSvf-00035u-HQ; Fri, 01 Feb 2019 07:07:59 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpSvR-0002vK-Pw; Fri, 01 Feb 2019 07:07:47 +0000
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; d="scan'208";a="26178735"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 01 Feb 2019 00:07:43 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 00:07:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JBaRi8LU1Z3gmlyIZ5YXMpT0chDW7YkYJmC9oyAqYM=;
 b=a9qnJdDyt7KwYFJG/dpIMKMcjc2qENiHnzGBs3cRCrbVcypu/13d13K0ol9kUlWSglb/vFoBVKxBtaRhNnEs9o9QgJzXZqrM224md7mI2WdjsRaTojFuDLqgq/NxUc0gryctIdgwoIdNieLBOAtymp+Zms8ypyixG9gdWaddRLA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1970.namprd11.prod.outlook.com (10.175.95.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 07:07:40 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Fri, 1 Feb 2019
 07:07:40 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Thread-Index: AQHUuYA85AgiqORGIUCz49OB4RqXzKXJkgKAgAD0mIA=
Date: Fri, 1 Feb 2019 07:07:40 +0000
Message-ID: <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
 <20190131161515.21605-11-tudor.ambarus@microchip.com>
 <20190131173207.56481a42@bbrezillon>
In-Reply-To: <20190131173207.56481a42@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0024.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::34) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.46]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1970;
 6:qIdJaipCHZEI3uxriKSAwaojpkLG6gv34hDZSE/l8fES2U0ssFTl7To9Qpl8hJ0nCKHW6JsSJ6FoH1X+iPsHvhlKjvGaVkMHOwNuLIOwctGAd93mKrHNMTctae37cCKMrip6RK+IGlW7a8CEbZaDXxtJYgMcRq8vwN4D1zY8XCFhL+exS6N51bL5Wj8hOHOgTvpuOUePH70nNjRui5qsmIFak/rS2Pd7H6raSG7s4Hgf1JMYcMBeSCFAO7SdNdjNb7WdZ5W8o25/p3HWlM8Hp5jKZQb5yaf2XFJNfMh5P9qtoeaLUP6mOocZECbjRkidPaVylqIJb1/lF9kOTkqn+erwGnPDwuOcU/e5SQk1oVgXJHXEAU4R0R40UyVH4AV7o/q8VMIA0VQ4KdZHwem9ZFvfxaleejw2VJcevqEBKYysCn9EPftLi6EumE7HAqS1M041F5tI5aNsS60xZg+vaQ==;
 5:W+FSPbARazi9fIEvRfyotxVBcqnZafi4Sx8nZ4pBCPzm7JzIJYIttEQ+wyFbm5YLcmDwgm832WfGnCrTvBFdpZb1991qGA3Zr3j4aCivFCVQnjtHrcv0wANajd1VjRc+GnqL1OLcql6nqBg+GR7jAljj3qVLhUL/qw2MO+8Q3tGNpeW+w2Rm/0p6sspFyvn4qQOpQm8W66Zd+uBojwvdsw==;
 7:8OfFZIM7+n+lbQKrhORpm02zUSKfDjolP9ddLd4WxD54KTCyHuekaCNJIkT4h8EQuZ7NLWBPpmWckkx9UQm4qtDxClLhFVUZGSH3RKym6s3QyLz+5WVdemTVsdMWxvSl4iJN+pH13l/U5/vAePJLAA==
x-ms-office365-filtering-correlation-id: 7c91381c-9ed8-4c13-c746-08d68813f3d5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1970; 
x-ms-traffictypediagnostic: BN6PR11MB1970:
x-microsoft-antispam-prvs: <BN6PR11MB197007F2FD27B8C880DB360EF0920@BN6PR11MB1970.namprd11.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(68736007)(25786009)(476003)(186003)(66066001)(97736004)(6116002)(2906002)(3846002)(102836004)(229853002)(53546011)(6506007)(6916009)(6346003)(11346002)(4326008)(386003)(31696002)(105586002)(36756003)(86362001)(14444005)(26005)(256004)(486006)(31686004)(2616005)(446003)(106356001)(6246003)(76176011)(7416002)(305945005)(71190400001)(71200400001)(54906003)(81166006)(81156014)(8936002)(99286004)(8676002)(53936002)(72206003)(316002)(7736002)(6512007)(14454004)(6436002)(6486002)(478600001)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1970;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 44fsTJUl5oZroB2jSQLzjYMPkuzBoN1RJvIxspc8O6YZ8SglQmlhg3HIAjehWujvMcuDXUxhTnsyX/L0ddQVNH5FyIfEweoMe0Jr/ffXh+xEfxE+Uf4DtIt3cmptYeBiylGyrb9+s7IUwVfHZBhex0xSUmQWECO2mBapuMEsLlufYJZifxngus2Z450HrSL3o4Vyi5Y/XheLVkNelhl1eYJQfkpzjImuuook1Fw4W1qBEjGZYRS09tChwU5XNJTzj9UMg1Xq5B6wCnGgy3iOLBSsjGbndaOSCWkAe6y6PpfILBiizkd9qvWUGN4sx18XWOHjJF8vUWN2q5ksqs3IRhqwg97s44h/orO48Zwa61v5dUCA89qKjhXAPFKPOACLfLuKhVjfAqN+fQCvD+cD9nP6zD1hoLFRr18ckV5gqkI=
Content-ID: <FDE3A9ADDF16244C80058B0BF4938DDC@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c91381c-9ed8-4c13-c746-08d68813f3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 07:07:37.7908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1970
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_230746_009343_7921C9EA 
X-CRM114-Status: GOOD (  21.89  )
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
 robh+dt@kernel.org, linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com,
 broonie@kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/31/2019 06:32 PM, Boris Brezillon wrote:
> On Thu, 31 Jan 2019 16:15:51 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
>> access, the other for the qspi core and phy. Both are mandatory. It uses
>> dedicated register for Read Instruction Code Register (RICR) and
>> Write Instruction Code Register (WICR). ICR/RICR/WICR have identical
>> fields.
>>
>> Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
>> done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v2:
>> - rework clock handling
>> - reorder setting of register values in set_cfg() calls -> move functions
>>   that can fail in the upper part of the function body.
>>
>>  drivers/spi/atmel-quadspi.c | 296 +++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 239 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index d3e76acf8517..80c934f3e479 100644
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
>> @@ -113,6 +116,8 @@
>>  #define QSPI_IFR_OPTL_4BIT              (2 << 8)
>>  #define QSPI_IFR_OPTL_8BIT              (3 << 8)
>>  #define QSPI_IFR_ADDRL                  BIT(10)
>> +#define QSPI_IFR_TFRTYP_TRSFR_MEM	BIT(12)
>> +#define QSPI_IFR_TFRTYP_TRSFR_REG	(0 << 12)
> 
> You don't need to define TRSFR_REG, just set QSPI_IFR_TFRTYP_TRSFR_MEM
> when you do a mem transfer and do nothing when this is a regular
> transfer.


I chose to introduce macros with zero value for better code readability. I would
expect that the NOP operations to be optimized at compile time. I will remove them
if you prefer, it will result in fewer lines of code.

> 
>>  #define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
>>  #define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
>>  #define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
> 
> Looks like the read/write flag is on bit 13. Can we just add

for sama5d2 only

> 
> #define QSPI_IFR_TFRTYP_TRSFR_WRITE	BIT(13)
> 
> and drop all others def? This way the implementation is consistent
> between sam9x60 and sama5d2.

BIT(13) has no meaning for sam9x60. I can drop the macros with zero value for
sama5d2 in a separate patch.

> 
>> @@ -121,6 +126,8 @@
>>  #define QSPI_IFR_CRM                    BIT(14)
>>  #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
>>  #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
>> +#define QSPI_IFR_APBTFRTYP_WRITE	(0 << 24)
> 
> As for the other defs, I don't think you need to define _WRITE.

understood

> 
>> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)
>>  
>>  /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
>>  #define QSPI_SMR_SCREN                  BIT(0)
>> @@ -137,16 +144,37 @@
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
>>  	struct clk		*clk;
> 
> Can we rename that on pclk?

will rename it, together with the support for unnamed clock of sama5d2 in a separate
patch. The dt-bindings patch that imposes "pclk" for sama5d2 should be separated too.

> 
>> +	struct clk		*qspick;
>>  	struct platform_device	*pdev;
>> +	const struct atmel_qspi_caps *caps;
>>  	u32			pending;
>>  	u32			mr;
>>  	struct completion	cmd_completion;
>>  };
>>  
> 
> ...
> 
>> +
>> +static int atmel_sam9x60_qspi_set_cfg(void __iomem *base,
>> +				      const struct spi_mem_op *op,
>> +				      struct atmel_qspi_cfg *cfg)
>> +{
>> +	int ret = atmel_qspi_set_mode(cfg, op);
>> +
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
>> +	if (!op->addr.nbytes) {
>> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
>> +		if (op->data.dir == SPI_MEM_DATA_OUT)
>> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
>> +		else
>> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
>> +	} else {
>> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;
> 
> Can you try doing only regular transfers and let me know if it still
> works. Support for mem transfers can then be added along with dirmap
> support.

should work. Will try and let you know.

> 
>> +	}
>>  
>>  	/* Clear pending interrupts */
>>  	(void)readl_relaxed(base + QSPI_SR);
>>  
>>  	/* Set QSPI Instruction Frame registers */
>> -	writel_relaxed(iar, base + QSPI_IAR);
>> -	writel_relaxed(icr, base + QSPI_ICR);
>> -	writel_relaxed(ifr, base + QSPI_IFR);
>> +	writel_relaxed(cfg->iar, base + QSPI_IAR);
>> +	if (op->data.dir == SPI_MEM_DATA_OUT)
>> +		writel_relaxed(cfg->icr, base + QSPI_ICR);
>> +	else
>> +		writel_relaxed(cfg->icr, base + QSPI_RICR);
>> +	writel_relaxed(cfg->ifr, base + QSPI_IFR);
>> +
>> +	return 0;
>> +}
>> +
> 
> ...
> 
>> @@ -443,32 +578,52 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>>  	/* Enable the peripheral clock */
>>  	err = clk_prepare_enable(aq->clk);
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
>> +			goto disable_clk;
>> +		}
>> +
>> +		/* Enable the QSPI system clock */
>> +		err = clk_prepare_enable(aq->qspick);
>> +		if (err) {
>> +			dev_err(dev,
>> +				"failed to enable the QSPI system clock\n");
>> +			goto disable_clk;
>> +		}
>> +	}
>> +
>>  	/* Request the IRQ */
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (irq < 0) {
>> -		dev_err(&pdev->dev, "missing IRQ\n");
>> +		dev_err(dev, "missing IRQ\n");
>>  		err = irq;
>> -		goto disable_clk;
>> +		goto disable_qspick;
>>  	}
>> -	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
>> -			       0, dev_name(&pdev->dev), aq);
>> +	err = devm_request_irq(dev, irq, atmel_qspi_interrupt, 0,
>> +			       dev_name(dev), aq);
>>  	if (err)
>> -		goto disable_clk;
>> +		goto disable_qspick;
>>  
>>  	err = atmel_qspi_init(aq);
>>  	if (err)
>> -		goto disable_clk;
>> +		goto disable_qspick;
>>  
>>  	err = spi_register_controller(ctrl);
>>  	if (err)
>> -		goto disable_clk;
>> +		goto disable_qspick;
>>  
>>  	return 0;
>>  
>> +disable_qspick:
>> +	clk_disable_unprepare(aq->qspick);
>>  disable_clk:
> 
> We should probably rename this label disable_pclk.

sure. Thanks, Boris!

> 
>>  	clk_disable_unprepare(aq->clk);
>>  exit:
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
