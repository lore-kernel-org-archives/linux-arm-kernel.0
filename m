Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DBDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:45:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC2F21920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qeLgF8jx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="n5HAChRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC2F21920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=skAori6utT4lYV4nGuXo8ZRu9MR/PFBjsrpPj6Xexnk=; b=qeLgF8jxgC3t4e
	fg0d2D6phO8Ax07OQfVSC+YQw+H8zqKNoKZ1JegHkkpPNfVeispkg8pfzt12NHH70hZgZYKtrwWc1
	yxsW8aJG/XX39cy4I2EtWi9XC2ytfw+94IFVUt1lDvERdHJOBcUc3XeQkBiLsa8ekygjmOWUQCi9f
	g+rLbJIakagaEF5YOyU6V6Wuv5yr1r1HbKjcT8LGAVxE1bNJySvRvJ+PcWXS2hE2Rp2oMGJG5NnrT
	DfLD/n//nf3DETZiiNp2XInaHAoOd/d5bBGqYjTuOopwIL+5fUVfkcQR8CYlrzP2mf1+cUy94NHMX
	SZ9IPV04oJHWU8qNG6FA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaM36-0001tY-Kk; Fri, 21 Dec 2018 14:45:12 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaM2p-0001FW-6Z; Fri, 21 Dec 2018 14:44:58 +0000
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; d="scan'208";a="24515848"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Dec 2018 07:44:41 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Fri, 21 Dec 2018 07:44:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZDzpv7vpSwKp+OMK0sp9QuHTJ2LanipXHEcDS5dk64=;
 b=n5HAChRs9k7Su8x65sGics+l0IpTdALyqFBajfE3RtfoDC56HOsBgDrsJP16iJVe39Xn7xJ6ngHa2VR4d/VyWekY9Nn9PrXpxK932CLbXZWZuw9ntXiwit/brghiLnDKw3LK8GUn9Z81T3UrLtU6g+CoWKC1EfmndBU7jUkyX58=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB2018.namprd11.prod.outlook.com (10.173.26.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Fri, 21 Dec 2018 14:44:37 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239%10]) with mapi id 15.20.1446.022; Fri, 21 Dec
 2018 14:44:37 +0000
From: <Tudor.Ambarus@microchip.com>
To: <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
 <boris.brezillon@bootlin.com>, <broonie@kernel.org>, <marek.vasut@gmail.com>, 
 <vigneshr@ti.com>, <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v6 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUl4NIuN4Xv5agnkiSp4/lDdT57aWJSFSA
Date: Fri, 21 Dec 2018 14:44:37 +0000
Message-ID: <fca942b2-7958-7ee5-e76f-3f232236c313@microchip.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1545214186-16987-4-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1545214186-16987-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0054.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::31) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB2018;
 6:1Vd9mI4aQicvKKV9f4wMY5sYQ/tT/JT/D0BPJFqK2pj8jcL3tKKpLAIP0FdyAZ6fKrbrCL9dPJg+AwMYtFcADf6OQKbNJ5sR+7fBeXxgwi0wOjFPeWXLdf5ehmoRzUei0g2YmNGreh7X0fNtqaTwJrT9Ar04liCvP1PB06hRCC0DD9nSbI33Y7Ai75K8pE9J8nEBvkLniwX//rFKTXmEZCsCAe/4/kiGL+6LL4Jzr2M2Vpkdz9UHum6hdY06JkvR8wTBSHq4HRc8QN8XKAU7UJH2exmXfZKZEUKiM5k9lqSyicFmKcatziFdsz6kG2sdkEx1gLazzO24tt3ZrBhmEMhB7ByxFqzZTKST0PT3KKn1l7ZR43j7iL6HcDu9f98ok8OW+PCQCOzJKAlNnrdf67aP0Md83otdYqbSZSRr1R/2AIu10QMeQcBh6PIZDvr1J5TCl2NIYuuRB1woDjFP4Q==;
 5:9UGQbAylqfTe7B1E9JXR4A/iXCHqOuQU2/uMnHtYitPtsz/5qPTa9Leaiai9phcGfL/OLqfXQYScYhXkedP555K9+JepRUUSj9oE6DXsSI5N6EbdnGzKx05pusmDrXForVAGmiyxjJsar4XFzlXHzcHMccFYkVSR94X9/TkuMDw=;
 7:JB5uGaEmYn78eMfo+OH3j+jW0ShpAWwu1gkw+qsW5AWC35BMeod8a/dpVud8wgfaQu9bPQgTnIUk15wCXtOXXV/blGQRAV9xw1n34Sl2pn6naWLZ06LxX5SyLYoQSk2xS0DT2ojsIhXKOZinqHeIVw==
x-ms-office365-filtering-correlation-id: bbbd383a-82b8-4408-7f1a-08d66752d460
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB2018; 
x-ms-traffictypediagnostic: BN6PR11MB2018:
x-microsoft-antispam-prvs: <BN6PR11MB20183A087942892145CA32E1F0B80@BN6PR11MB2018.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR11MB2018; BCL:0; PCL:0; RULEID:; SRVR:BN6PR11MB2018; 
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(366004)(39860400002)(346002)(396003)(199004)(189003)(53546011)(6506007)(6116002)(26005)(72206003)(8676002)(3846002)(102836004)(66066001)(81156014)(81166006)(52116002)(31686004)(2201001)(5660300001)(7416002)(36756003)(31696002)(8936002)(386003)(25786009)(106356001)(105586002)(76176011)(575784001)(86362001)(446003)(486006)(11346002)(2501003)(2616005)(6486002)(14454004)(478600001)(54906003)(110136005)(6436002)(256004)(53936002)(71190400001)(71200400001)(6246003)(39060400002)(476003)(6512007)(4326008)(7736002)(2906002)(186003)(305945005)(68736007)(229853002)(99286004)(316002)(97736004)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB2018;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x+y0naHfyKY4l1GY2vFWjXh4oP+TFNRgr8Mvm71ZyI5Rsbb7Yn/iJH0ad4BUef98Od+16qscs7+WMW5RFi1tL0ip6R8Gpqhfkn+WReenC/g4QX+KkbZ1np+vI66ptK1iDIkXwkWKWYWrZpaappYUCeoF268Ps0r+iCiIuQhdlaiSCpXKa+tRYUBWRw6uw9uzydsERF/aUkEFIPTjnwMJuBocWsRhBhot+oklUBiuUXwqFtyiREjQPtu7skoH4BMM9Lnx7iGh3uGqfsPW/3bJux7xneQsvEE9AEHEmX5J/gnUMP4AeP9QgxQtiHYuLUhc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <97695721420F56438CA10E80C4A05CF8@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbd383a-82b8-4408-7f1a-08d66752d460
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 14:44:37.3651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2018
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_064455_294652_F2EF90EA 
X-CRM114-Status: GOOD (  19.22  )
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
Cc: mark.rutland@arm.com, robh@kernel.org, linux-kernel@vger.kernel.org,
 frieder.schrempf@exceet.de, computersforpeace@gmail.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/19/2018 12:12 PM, Yogesh Narayan Gaur wrote:
> - Add opcodes for octal I/O commands
>   * Read  : 1-1-8 and 1-8-8 protocol
>   * Write : 1-1-8 and 1-8-8 protocol

I verified that the above opcodes are compliant with the MT35X Public datasheet.

>   * opcodes for 4-byte address mode command

opcodes compliant with jesd216c.

> 
> - Entry of macros in _convert_3to4_xxx function
> 
> - Add flag specifying flash support octal read commands.

It would be nicer to explain the need of this flag, similar to what you did in
patch's 4/7 commit message.

> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>

Looks good:

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> ---
> Changes for v6:
> - Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
> Changes for v5:
> - Modified string 'octo' with 'octal'.
> Changes for v4:
> - None
> Changes for v3:
> - Modified string 'octal' with 'octo'.
> Changes for v2:
> - Incorporated review comments of Boris and Vignesh
> 
>  drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++++++++--
>  include/linux/mtd/spi-nor.h   | 16 ++++++++++++----
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 6e13bbd..872d707 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -68,7 +68,7 @@ enum spi_nor_read_command_index {
>  	SNOR_CMD_READ_4_4_4,
>  	SNOR_CMD_READ_1_4_4_DTR,
>  
> -	/* Octo SPI */
> +	/* Octal SPI */
>  	SNOR_CMD_READ_1_1_8,
>  	SNOR_CMD_READ_1_8_8,
>  	SNOR_CMD_READ_8_8_8,
> @@ -85,7 +85,7 @@ enum spi_nor_pp_command_index {
>  	SNOR_CMD_PP_1_4_4,
>  	SNOR_CMD_PP_4_4_4,
>  
> -	/* Octo SPI */
> +	/* Octal SPI */
>  	SNOR_CMD_PP_1_1_8,
>  	SNOR_CMD_PP_1_8_8,
>  	SNOR_CMD_PP_8_8_8,
> @@ -278,6 +278,7 @@ struct flash_info {
>  #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
>  #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
>  #define USE_CLSR		BIT(14)	/* use CLSR command */
> +#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
>  
>  	/* Part specific fixup hooks. */
>  	const struct spi_nor_fixups *fixups;
> @@ -398,6 +399,8 @@ static u8 spi_nor_convert_3to4_read(u8 opcode)
>  		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
>  		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
>  		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
> +		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
> +		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
>  
>  		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
>  		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
> @@ -414,6 +417,8 @@ static u8 spi_nor_convert_3to4_program(u8 opcode)
>  		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
>  		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
>  		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
> +		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
> +		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
>  	};
>  
>  	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program,
> @@ -3591,6 +3596,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  					  SNOR_PROTO_1_1_4);
>  	}
>  
> +	if (info->flags & SPI_NOR_OCTAL_READ) {
> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
> +					  0, 8, SPINOR_OP_READ_1_1_8,
> +					  SNOR_PROTO_1_1_8);
> +	}
> +
>  	/* Page Program settings. */
>  	params->hwcaps.mask |= SNOR_HWCAPS_PP;
>  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index fa2d89e..2353af8 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -46,9 +46,13 @@
>  #define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O SPI) */
>  #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad Output SPI) */
>  #define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O SPI) */
> +#define SPINOR_OP_READ_1_1_8	0x8b	/* Read data bytes (Octal Output SPI) */
> +#define SPINOR_OP_READ_1_8_8	0xcb	/* Read data bytes (Octal I/O SPI) */
>  #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
>  #define SPINOR_OP_PP_1_1_4	0x32	/* Quad page program */
>  #define SPINOR_OP_PP_1_4_4	0x38	/* Quad page program */
> +#define SPINOR_OP_PP_1_1_8	0x82	/* Octal page program */
> +#define SPINOR_OP_PP_1_8_8	0xc2	/* Octal page program */
>  #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
>  #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
>  #define SPINOR_OP_BE_32K	0x52	/* Erase 32KiB block */
> @@ -69,9 +73,13 @@
>  #define SPINOR_OP_READ_1_2_2_4B	0xbc	/* Read data bytes (Dual I/O SPI) */
>  #define SPINOR_OP_READ_1_1_4_4B	0x6c	/* Read data bytes (Quad Output SPI) */
>  #define SPINOR_OP_READ_1_4_4_4B	0xec	/* Read data bytes (Quad I/O SPI) */
> +#define SPINOR_OP_READ_1_1_8_4B	0x7c	/* Read data bytes (Octal Output SPI) */
> +#define SPINOR_OP_READ_1_8_8_4B	0xcc	/* Read data bytes (Octal I/O SPI) */
>  #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
>  #define SPINOR_OP_PP_1_1_4_4B	0x34	/* Quad page program */
>  #define SPINOR_OP_PP_1_4_4_4B	0x3e	/* Quad page program */
> +#define SPINOR_OP_PP_1_1_8_4B	0x84	/* Octal page program */
> +#define SPINOR_OP_PP_1_8_8_4B	0x8e	/* Octal page program */
>  #define SPINOR_OP_BE_4K_4B	0x21	/* Erase 4KiB block */
>  #define SPINOR_OP_BE_32K_4B	0x5c	/* Erase 32KiB block */
>  #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
> @@ -458,7 +466,7 @@ struct spi_nor_hwcaps {
>  /*
>   *(Fast) Read capabilities.
>   * MUST be ordered by priority: the higher bit position, the higher priority.
> - * As a matter of performances, it is relevant to use Octo SPI protocols first,
> + * As a matter of performances, it is relevant to use Octal SPI protocols first,
>   * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
>   * (Slow) Read.
>   */
> @@ -479,7 +487,7 @@ struct spi_nor_hwcaps {
>  #define SNOR_HWCAPS_READ_4_4_4		BIT(9)
>  #define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
>  
> -#define SNOR_HWCPAS_READ_OCTO		GENMASK(14, 11)
> +#define SNOR_HWCPAS_READ_OCTAL		GENMASK(14, 11)
>  #define SNOR_HWCAPS_READ_1_1_8		BIT(11)
>  #define SNOR_HWCAPS_READ_1_8_8		BIT(12)
>  #define SNOR_HWCAPS_READ_8_8_8		BIT(13)
> @@ -488,7 +496,7 @@ struct spi_nor_hwcaps {
>  /*
>   * Page Program capabilities.
>   * MUST be ordered by priority: the higher bit position, the higher priority.
> - * Like (Fast) Read capabilities, Octo/Quad SPI protocols are preferred to the
> + * Like (Fast) Read capabilities, Octal/Quad SPI protocols are preferred to the
>   * legacy SPI 1-1-1 protocol.
>   * Note that Dual Page Programs are not supported because there is no existing
>   * JEDEC/SFDP standard to define them. Also at this moment no SPI flash memory
> @@ -502,7 +510,7 @@ struct spi_nor_hwcaps {
>  #define SNOR_HWCAPS_PP_1_4_4	BIT(18)
>  #define SNOR_HWCAPS_PP_4_4_4	BIT(19)
>  
> -#define SNOR_HWCAPS_PP_OCTO	GENMASK(22, 20)
> +#define SNOR_HWCAPS_PP_OCTAL	GENMASK(22, 20)
>  #define SNOR_HWCAPS_PP_1_1_8	BIT(20)
>  #define SNOR_HWCAPS_PP_1_8_8	BIT(21)
>  #define SNOR_HWCAPS_PP_8_8_8	BIT(22)
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
