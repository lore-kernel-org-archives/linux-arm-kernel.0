Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB91C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:56:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3A82081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VO9YhV3R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oRQCThf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3A82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M2wXs+UUrRp9neBIxxti77zYiLL+3PIptqvOl7ON79U=; b=VO9YhV3RKsI58Y
	JZ2yLVHY27DrYC+7ZVzkUzTk9LEvxjHz25Jst9faL5uPLuBmLrS7d4wcu+rQdaxip1dOTx+ZJAXrB
	8mZds5/jSiIcIBDoyP3tReCSuS5Hg97+G5D4p+0bKzlLeXqtriEheLI8Hrf2cePWKZmEvgBtN34MV
	BKFc16dNeWUMKyFfGUAWoG7mbAWGqymPl9ts656MhDnvkeKyiSCnXGj9rx3hSgOAdrUHw3Tsd1gfX
	KyyznkYkwxhXfbktypUicebMnCnMFJjoBRsveiRqNSlgY3CYoxddoRAEm8z3gnuqjhhnNagkcCJan
	14WPc9dFvB04jv/i95eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWa5R-00015m-4I; Tue, 11 Dec 2018 04:56:01 +0000
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWa5D-0000ag-4T; Tue, 11 Dec 2018 04:55:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BfMAx6PXpB0A5xNDBv86W1+XdSzobCcMn4CBiRg7pc=;
 b=oRQCThf1lhpYMvuJJDJ4U33WwYPog+ZXF045k1DZaABWr8mSxhN9VuXcjZQoL2Xzr3nAzLmv6R2gmVXgbspT9N1R2g2E9MKuhK1V+1IRenarnkTsdG58ZycTqAMK7UdI/3e1QmcanfwzuhGENcFvpRPx9pNSFAD9xT2jUn9m508=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4525.eurprd04.prod.outlook.com (20.177.54.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 04:55:29 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 04:55:29 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUiuOuxIvwGhR/Ik2nR/UOeUIxtaV31PEAgAEp0pA=
Date: Tue, 11 Dec 2018 04:55:29 +0000
Message-ID: <VI1PR04MB57264CBB25E2984DF221ED2E99A60@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
In-Reply-To: <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4525;
 6:jX4K3DIl7i+ryFAiUJ7yrbmbSryTlI5HhPZTI9mcFRrrsBXTqFH5PoovShQc3tS4qcdl6EZW/0ntpQ6AJJ3xRMJXBPj4ZnjPQ2PUyXJIP23//1c7JNwdnAskJv393Gg9W1buPjbDkwAu3MRlxlmnRFHnh8XSgIHNpUFUibyFQw9zkSKNnF01VAt3IfNx4GTLNriPJp7W6fGAyBzBumMSciwsD7vlvpeQMUeJ1Rm8oiXic9wsxq0ksubx/iLvaI4IZ016E9BbSQlc68cPWZM05XA+YijGFd9QbubauzcOxKo2P156zvO+U3+vSK2MDpQZbyXciOMxy+pL3z7OEpz5kTk7PgxvHJtowwBMTI2PcK85J2s3IuGNy5VelZjZlO4c1ZCJRiwjNXuPj3h3hqJbqWX5Q/yrdEXdp205E00g9pRvm5gm6V3+cS8rU6mVvMAwZNC39wTLULxheGDS56R9jg==;
 5:WC2sBNevdCKjeyxX5sm+8kljExc0wXtr9pTfhiK/w8YaA/ZT07qGefVXfxaNKczesoBQ02XaopNBt4tp5pNpgvYSYS5+vhpxyqQEGlakle9k5ZqdrbhDM0i8/FVV/EazISnws98RTu2B2ofjCk0Q77zcun3Nd35SIsXx/+//mps=;
 7:e9lik8B49/T5mgFphSabN6RYKDlfKFuY4UfG5ZwsgRGJ9lOhN4nTcBZUmIZ1ZDfl0FeX3MxnIX+XmozsRTvAjWJKntMrspoJ6E7rBrlfZ1Y8/dlOq0Ty66V0Vmy0OpdXw5K4r66jcgMbhg9mL5OUKg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b355acb3-f00f-4970-9310-08d65f24dfba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4525; 
x-ms-traffictypediagnostic: VI1PR04MB4525:
x-microsoft-antispam-prvs: <VI1PR04MB452519F15B045214F179DF9199A60@VI1PR04MB4525.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4525; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4525; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(199004)(189003)(13464003)(2501003)(3846002)(486006)(2906002)(7736002)(53936002)(7696005)(229853002)(6116002)(66066001)(5660300001)(81156014)(97736004)(33656002)(8936002)(6246003)(6436002)(78486014)(8676002)(102836004)(71200400001)(71190400001)(76176011)(55236004)(256004)(6506007)(74316002)(99286004)(53546011)(316002)(55016002)(26005)(105586002)(9686003)(305945005)(81166006)(106356001)(7416002)(68736007)(54906003)(39060400002)(11346002)(4326008)(478600001)(476003)(446003)(110136005)(2201001)(14454004)(25786009)(186003)(86362001)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4525;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F4FB3+0v0VRN5xxO8/mZkmJjjoSA4wykLF9QIgUgFdfR6k1fGWkrjLxmLQngYa6CsPSmVMrdHApkD0GNyZCLb+7sd0fWqhos149H3iEoUmjdtztl8EpivF9pyC7yPXnzEHvUKGKr1ukS9n5g1OgogBLBdrGRSPet7GSptY1hEKpExTOnn/qhYz3RVitcEHA60pdX35zaGVH1Sbyo3hxr3qp7HH3DRN+3A1v5rRiglumKG/mQICB8y7B9brBcUf+5A/wDFt36ozd3lBpns6i423r3Zq+TlptmpEULglxcrVJqPMRmr5dMFUC2kB1XeXZD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b355acb3-f00f-4970-9310-08d65f24dfba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 04:55:29.4890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4525
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_205547_232702_81CD3E4B 
X-CRM114-Status: GOOD (  25.71  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tudor,

> -----Original Message-----
> From: Tudor.Ambarus@microchip.com [mailto:Tudor.Ambarus@microchip.com]
> Sent: Monday, December 10, 2018 4:15 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; boris.brezillon@bootlin.com; broonie@kernel.org;
> marek.vasut@gmail.com; vigneshr@ti.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
> commands
> 
> Hi, Yogesh,
> 
> On 12/03/2018 10:39 AM, Yogesh Narayan Gaur wrote:
> > - Add opcodes for octal I/O commands
> >   * Read  : 1-1-8 and 1-8-8 protocol
> >   * Write : 1-1-8 and 1-8-8 protocol
> >   * opcodes for 4-byte address mode command
> >
> > - Entry of macros in _convert_3to4_xxx function
> >
> > - Add flag specifying flash support octal read commands.
> >
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> > Changes for v5:
> > - Modified string 'octo' with 'octal'.
> > Changes for v4:
> > - None
> > Changes for v3:
> > - Modified string 'octal' with 'octo'.
> > Changes for v2:
> > - Incorporated review comments of Boris and Vignesh
> >
> >  drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++++++++--
> >  include/linux/mtd/spi-nor.h   |  8 ++++++++
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > b/drivers/mtd/spi-nor/spi-nor.c index 398d273..7a2176d 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -90,6 +90,7 @@ struct flash_info {
> >  #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip
> erase */
> >  #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
> >  #define USE_CLSR		BIT(14)	/* use CLSR command */
> > +#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
> >
> >  	int	(*quad_enable)(struct spi_nor *nor);
> >  };
> > @@ -209,6 +210,8 @@ static inline u8 spi_nor_convert_3to4_read(u8 opcode)
> >  		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
> >  		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
> >  		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
> > +		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
> > +		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
> >
> >  		{ SPINOR_OP_READ_1_1_1_DTR,
> 	SPINOR_OP_READ_1_1_1_DTR_4B },
> >  		{ SPINOR_OP_READ_1_2_2_DTR,
> 	SPINOR_OP_READ_1_2_2_DTR_4B },
> > @@ -225,6 +228,8 @@ static inline u8 spi_nor_convert_3to4_program(u8
> opcode)
> >  		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
> >  		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
> >  		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
> > +		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
> > +		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
> >  	};
> >
> >  	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program, @@
> > -2093,7 +2098,7 @@ enum spi_nor_read_command_index {
> >  	SNOR_CMD_READ_4_4_4,
> >  	SNOR_CMD_READ_1_4_4_DTR,
> >
> > -	/* Octo SPI */
> > +	/* Octal SPI */
> >  	SNOR_CMD_READ_1_1_8,
> >  	SNOR_CMD_READ_1_8_8,
> >  	SNOR_CMD_READ_8_8_8,
> > @@ -2110,7 +2115,7 @@ enum spi_nor_pp_command_index {
> >  	SNOR_CMD_PP_1_4_4,
> >  	SNOR_CMD_PP_4_4_4,
> >
> > -	/* Octo SPI */
> > +	/* Octal SPI */
> >  	SNOR_CMD_PP_1_1_8,
> >  	SNOR_CMD_PP_1_8_8,
> >  	SNOR_CMD_PP_8_8_8,
> > @@ -3195,6 +3200,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
> >  					  SNOR_PROTO_1_1_4);
> >  	}
> >
> > +	if (info->flags & SPI_NOR_OCTAL_READ) {
> > +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
> > +		spi_nor_set_read_settings(&params-
> >reads[SNOR_CMD_READ_1_1_8],
> > +					  0, 8, SPINOR_OP_READ_1_1_8,
> > +					  SNOR_PROTO_1_1_8);
> > +	}
> > +>  	/* Page Program settings. */
> >  	params->hwcaps.mask |= SNOR_HWCAPS_PP;
> >  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
> 
> At the end of spi_nor_init_params we check the conditions for parsing the sfdp.
> Shouldn't SPI_NOR_OCTAL_READ trigger the sfdp parsing when
> SPI_NOR_SKIP_SFDP is not set?

I guess for now setting only SPI_NOR_OCTAL_READ didn't trigger SFDP parsing as SFDP parsing would start only when we have both of the below condition are true
        if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
            !(info->flags & SPI_NOR_SKIP_SFDP)) {
But for case when we have only set SPI_NOR_OCTAL_READ then first condition check would be false and hence SFDP parsing won't occur.

I guess, we needn't to have SFDP parsing only when SPI_NOR_SKIP_SFDP is set.
Thus would going to modify the condition check as below, so that SFDP parsing would also be performed when SPI_NOR_OCTAL_READ is set. Correct?

        if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
             SPI_NOR_OCTAL_READ)) && !(info->flags & SPI_NOR_SKIP_SFDP)) {

--
Regards
Yogesh Gaur

> 
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index 8b1acf6..019f534 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -50,9 +50,13 @@
> 
> Can you please s/octo/octal on these as well:
> $  grep -ni octo include/linux/mtd/spi-nor.h
> 471: * As a matter of performances, it is relevant to use Octo SPI protocols first,
> 492:#define SNOR_HWCPAS_READ_OCTO		GENMASK(14, 11)
> 501: * Like (Fast) Read capabilities, Octo/Quad SPI protocols are preferred to
> the
> 515:#define SNOR_HWCAPS_PP_OCTO	GENMASK(22, 20)
> 
> thanks,
> ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
