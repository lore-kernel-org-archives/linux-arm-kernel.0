Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6814C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:45:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B612084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LsImdHNp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0BjRMxYw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WBxT9pkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B612084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YO35y9zeY6sFzRy3+156xbemJhZ/NTnZtxC2UzD0DO0=; b=LsImdHNpo35wMT
	+po2kGGG+CrrEbzsq1P7dvtfUVvFoGhx/Zf2jkEaxYHHni9Jdp9hrASlQj50oEOKk6nG0J3POaXF1
	iEuuGE20e85ra5LV/fCbjlLCkf/3k20bVh5H1wS4vjqMgYQw3/0NhVG1qpY+yfk0VKwGCEEqOJu17
	2E2lRAnL4X/Xree8nvj+iRyJqgSgP1gsWHlAtpg4RV9FyjLQ05nLocWVQDdJoQ59vFH59QElvyYcf
	+gBqaXUlhSdT6Hn5U92neCrmU0lj+NsycK4IRFXCw00rxT9LnuRFRZf/+fJDzA1utRFNeTMVUNN/M
	UNzXl5yb2t4/y6xaDY3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJ45-0007nF-Tu; Mon, 10 Dec 2018 10:45:29 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJ3p-0006uM-Nz; Mon, 10 Dec 2018 10:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
 From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KJVmNWj1gHvsDasV8hK39O64J3GwDNTK1uCO/dVry24=; b=0BjRMxYwujfmIYVgLzByxvx6hA
 JsirkPAfuqgpJsZxJcCQFd3upI60HvINtny/04lKpRUk32j6dTPGhipqYUzXJZrDLCxemo/A5CYWk
 C5aNdMBdlLFLtkeq3hsh0IVdM8v43ohBmPJodn13tOOIcORk/GOQMTP1O/cREqi+wR9k5araAlCe1
 gEQWM4V3Vj2xJxC95u+SnBpOEP7tVbN/v2OPCsYRpUXGajwgSXknEd8vdEVW7JfiJJLP+FvCxfQ6m
 IeoL6V0mh282NGBfyrZdGw1ylUkBs1/R9Dv9YuYW4XLAfiEwJShCa854Jq0Mb5pFUSzmDiuaVGb7T
 XWLOrkGw==;
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJ3m-0003Lf-Mm; Mon, 10 Dec 2018 10:45:11 +0000
X-IronPort-AV: E=Sophos;i="5.56,338,1539673200"; d="scan'208";a="23739026"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 10 Dec 2018 03:44:49 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 10 Dec 2018 03:44:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJVmNWj1gHvsDasV8hK39O64J3GwDNTK1uCO/dVry24=;
 b=WBxT9pkxBjNhD2hNT5Ccw1+BA57+nqyBDUk4mgHyHPWoCBi3G2txfPStpW44TiEcW4fpPNVQJgS8WYUYQRyKOtQPeYlBsaI8HZD6eWk9QbkzH/zvk1/OuCvrmnqi9IkUNyRIzvGK3BBTGc8fJSV3nVNX+tXF4q65XzwwJplTqTM=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1489.namprd11.prod.outlook.com (10.172.21.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Mon, 10 Dec 2018 10:44:44 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 10:44:44 +0000
From: <Tudor.Ambarus@microchip.com>
To: <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
 <boris.brezillon@bootlin.com>, <broonie@kernel.org>, <marek.vasut@gmail.com>, 
 <vigneshr@ti.com>, <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUiuPgL6l2VShjyka5vhSTd0gdZqV31OaA
Date: Mon, 10 Dec 2018 10:44:44 +0000
Message-ID: <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0281.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::48) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1489;
 6:A66wLpBGVj3xVW1UoLboeH+Fb/fuE+cw7dp4bwpGnWwTjmIg6gjJ2CKlnqZClDCbpOMrDZgl9ypql/eM9iuFtUnA2/NoRwekivqwEZ3CHAAwGzUmfTpej00NOCZDBp64XvHrL5oySgdN2q+ijAM77W6zjF4SeKB9wrCv1oo4SBL6HqGR5cVbk8uM0MqvogBh6/mFbLa8TvshgiiqJnh7IBrOY+yGPs1yO7UXlqYJjUm9Ge5CjP/0P2hOi+5AXoF2Z7VxhrPopTQpEWu8RH3rNcEvt+fuQrP6i0I5TKh80uDHOp+ql+5S75MwFErcQcK3mLZ3j/Tfh9e3GehhBcK1BT7ieOEUwWw2Vzto9ylNXPYBdn64YcraXt2ET+sDMF0/ZoXaUPiunh5e0QXsBu0+IMUmi1B8zrfGykKZ7p4vXABc6ArXZ6wl1a0edPY2mvUucDDRTxIV7/1ju/g02hl90A==;
 5:RHB+fV19eyk/Kbv4U75XMM028QtQE4Cmx1WsuNVLMeUrJlJ1Zr1E32hSnm7GYON7RL7NLrAVsn+J8UMdOqG3Lu6I7hYClEEt6S3hM30lsZF2GvlwHzlUJRxYOiqvmONct3YhHtcqM4Hei/dDfMM2gLdYd1wN75vHUsnAd5/Woak=;
 7:wozVjq6ZNVa4IS/dz/KFqbobiRopCsAYL3DmQ1itnVZ8uGLlA+8bFngWkr3rmwDul/pLm3kiZDHSZKWss+OVFotcNzibF0CqQdevUxqqCw/+813YAViPpT98izV6T/6yOm1U/rde4jTnbT8S1cKMvA==
x-ms-office365-filtering-correlation-id: 87412d2c-0764-4511-5721-08d65e8c7f38
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1489; 
x-ms-traffictypediagnostic: BN6PR11MB1489:
x-microsoft-antispam-prvs: <BN6PR11MB1489D62C790FCE15515C1204F0A50@BN6PR11MB1489.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR11MB1489; BCL:0; PCL:0; RULEID:; SRVR:BN6PR11MB1489; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(39850400004)(396003)(376002)(136003)(189003)(199004)(66066001)(6116002)(36756003)(8936002)(31696002)(6486002)(316002)(5660300001)(54906003)(110136005)(76176011)(106356001)(53546011)(6506007)(386003)(31686004)(99286004)(52116002)(102836004)(2501003)(53936002)(6512007)(186003)(68736007)(26005)(229853002)(11346002)(446003)(476003)(2616005)(4326008)(7736002)(6246003)(25786009)(105586002)(305945005)(39060400002)(97736004)(71190400001)(71200400001)(486006)(6436002)(2906002)(81156014)(86362001)(8676002)(81166006)(3846002)(14454004)(2201001)(478600001)(7416002)(256004)(72206003)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1489;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CstYAvK22vnaSStIzOsvp06Vs7JUHgjGnbU1Nu5+pRadCmp8QNCaUzSOX/SxW12ClDpEYP6rGNC5MOo5Hh/aV+KO8UqmmC8+t9Sh8bL0cOU5DJA1FZjd2KW2Wc+Av0ftH6Kz1qNvo6YmdumR08ZU9AtHpzgw15rHO5EJvXOAXANwGNtetSS3SJCGlrJiNvS2wDLHqDrDO6scJKMcR8YNVVj5CnrqlMOegtniLVrAPZi8sycgWZ3odH3ChLvehKXJ4YOZjwIqrTDgHbmGbWFRVzS1uc2szkqTZ8Wf/U7bV2KFogQw8YTOz+pFeEeoypp9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <3677578BA72704419DF709B3AB20C86D@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87412d2c-0764-4511-5721-08d65e8c7f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 10:44:44.5187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1489
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_054510_909251_3ABD65B4 
X-CRM114-Status: GOOD (  20.77  )
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

Hi, Yogesh,

On 12/03/2018 10:39 AM, Yogesh Narayan Gaur wrote:
> - Add opcodes for octal I/O commands
>   * Read  : 1-1-8 and 1-8-8 protocol
>   * Write : 1-1-8 and 1-8-8 protocol
>   * opcodes for 4-byte address mode command
> 
> - Entry of macros in _convert_3to4_xxx function
> 
> - Add flag specifying flash support octal read commands.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
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
>  include/linux/mtd/spi-nor.h   |  8 ++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 398d273..7a2176d 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -90,6 +90,7 @@ struct flash_info {
>  #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
>  #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
>  #define USE_CLSR		BIT(14)	/* use CLSR command */
> +#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
>  
>  	int	(*quad_enable)(struct spi_nor *nor);
>  };
> @@ -209,6 +210,8 @@ static inline u8 spi_nor_convert_3to4_read(u8 opcode)
>  		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
>  		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
>  		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
> +		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
> +		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
>  
>  		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
>  		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
> @@ -225,6 +228,8 @@ static inline u8 spi_nor_convert_3to4_program(u8 opcode)
>  		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
>  		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
>  		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
> +		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
> +		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
>  	};
>  
>  	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program,
> @@ -2093,7 +2098,7 @@ enum spi_nor_read_command_index {
>  	SNOR_CMD_READ_4_4_4,
>  	SNOR_CMD_READ_1_4_4_DTR,
>  
> -	/* Octo SPI */
> +	/* Octal SPI */
>  	SNOR_CMD_READ_1_1_8,
>  	SNOR_CMD_READ_1_8_8,
>  	SNOR_CMD_READ_8_8_8,
> @@ -2110,7 +2115,7 @@ enum spi_nor_pp_command_index {
>  	SNOR_CMD_PP_1_4_4,
>  	SNOR_CMD_PP_4_4_4,
>  
> -	/* Octo SPI */
> +	/* Octal SPI */
>  	SNOR_CMD_PP_1_1_8,
>  	SNOR_CMD_PP_1_8_8,
>  	SNOR_CMD_PP_8_8_8,
> @@ -3195,6 +3200,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  					  SNOR_PROTO_1_1_4);
>  	}
>  
> +	if (info->flags & SPI_NOR_OCTAL_READ) {
> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
> +					  0, 8, SPINOR_OP_READ_1_1_8,
> +					  SNOR_PROTO_1_1_8);
> +	}
> +>  	/* Page Program settings. */
>  	params->hwcaps.mask |= SNOR_HWCAPS_PP;
>  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],

At the end of spi_nor_init_params we check the conditions for parsing the sfdp.
Shouldn't SPI_NOR_OCTAL_READ trigger the sfdp parsing when SPI_NOR_SKIP_SFDP is
not set?

> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 8b1acf6..019f534 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -50,9 +50,13 @@

Can you please s/octo/octal on these as well:
$  grep -ni octo include/linux/mtd/spi-nor.h
471: * As a matter of performances, it is relevant to use Octo SPI protocols first,
492:#define SNOR_HWCPAS_READ_OCTO		GENMASK(14, 11)
501: * Like (Fast) Read capabilities, Octo/Quad SPI protocols are preferred to the
515:#define SNOR_HWCAPS_PP_OCTO	GENMASK(22, 20)

thanks,
ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
