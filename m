Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A671C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:19:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F692082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ARgf1IM1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jr1Tyq4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F692082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OziOGXQHEr5cS150/iRaAQT3JnNvSB8oAXp92IDcSDc=; b=ARgf1IM153n/9T
	SE1rco9+/zhxH20MgZy0nvxC9ykfq6tyMgWWPxXku/hWW1caR30LBkZ4vPl4v6xGtbMhewXJxJQh0
	aKUG2IxaJsxpLK5+d4EepQgelhnLzFx5zk77vbpb7Ap4gLigQx8P31YxdC206mbPpYeLD+bYnhlJP
	loGKHk9dXGbLfrFAgxV16aeaxDfH+9vpZOou5Zfu+fPZU3cZsuPfhXBriNWY1G/FIotIiLlkWO4Ug
	Ryrmhee0jpFdII9oeOjNmGEni5ELixBtrp6qR/lq0NPo880Q4BxbPtaMt4wSyNNT3Bbn/eBsBUs6V
	DjJ/dIudliufD5Dot/KQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjeY9-0005bU-DJ; Wed, 16 Jan 2019 06:19:41 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjeXw-0005QX-83; Wed, 16 Jan 2019 06:19:29 +0000
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; d="scan'208";a="26477945"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 15 Jan 2019 23:19:24 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 15 Jan 2019 23:19:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NByypZFWjagvW5Y2AcMKZgxN1lXdnRFEOiYR+yCP/Gs=;
 b=jr1Tyq4KyHcONZIuyO03Rt4B/QAtrg61+IQipci3pYjUFp68dEAKRFNCZekd7llGM8Tgd8MqQP4F6g0Xrx2l4NGzyFGA5ZCYDwbaLEYZgmlCJYSmDS1eoUPU77zTm/cPzi/yiHLqQ7ngSVec7y80J4eN9UihgkuD99IXJsuteSE=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1684.namprd11.prod.outlook.com (10.173.28.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 06:19:20 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 06:19:20 +0000
From: <Tudor.Ambarus@microchip.com>
To: <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
 <boris.brezillon@bootlin.com>, <broonie@kernel.org>, <marek.vasut@gmail.com>, 
 <vigneshr@ti.com>, <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 2/5] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v7 2/5] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Index: AQHUrLnyGdnur+dY+UC8ZO94XGejjaWxbVaA
Date: Wed, 16 Jan 2019 06:19:20 +0000
Message-ID: <cb800292-a732-f6f4-650e-00bffe760e5a@microchip.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:803:64::44) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1684;
 6:VV0nXFtkUbxdq+5rOiocPF0mc0bHLZOqszbzgcr23ZixFT/Xls4yzDEWDGNkU5P062gCZJKQLe2MvoAyPnHVWYY+1tQthcZQHi7qshtE/iC/D6G6f4E5NHS5jINLc7Z0iGTwjQdTdtP1/3hvEz1DDUHeX5q6d/6HVPKm3yCeDlotA6do9DDLQYf+naGldudMgCRVP8npLe9fvrS874VsObH0bWTJ8CmQswcngZyhiFYgSmR+B7UdasQkTuWX2AyN4vawlplH7lUQR86JIlJsieHvq2l6q7nydVNl/NUqsslELPkIzr9P/hOb15iXvd1W9k1jj+8xELqMyjb7TIuGVBfnJtA2duCSVG2cdbMKSfuBhh9ovsd7PH1oLzMR3LhxFw0tk4d0pnLPv3KlnFeczDPUeFVJzln5vSo3ezCVjzGeIaUWDIfWEMMZ+Wpf+FdEB7CDmrK97P3TORgLSIEp4w==;
 5:kT5HcADGRBFVxGCTos4gILUBKRDs5kblL/DSEP57f07DIbsLlxYkfRzLghc/dqHVunONhagIteTaIqQHAWgIXaScJ70R5KiH7gi/pgJoJJQTikjFmbzbgBRENGJHHbiTmxWXO15pA+k+xSc6kc7fC/Ep5Oqlm315LgnDqkndSyLf9zTNhnAt7Ru5QxQdtmTSM1fL1JUtGQNvBHOPx4vOgA==;
 7:DKNWsSrkOoc5XbguE5ppXszpJnK1vzONnE4i3nbsdETPt1Wlvdwzn9PqzkaiEE+/zNKtVawl7RMx5GhEs/EAhfLKrF/w01w9w2xSy+5gni9QkzxJjhNMbccCyFcKAsu3+7jjT3AJCrUI0lUCg61ASQ==
x-ms-office365-filtering-correlation-id: 4f85e8c4-14e4-4c6f-5064-08d67b7a8cc5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1684; 
x-ms-traffictypediagnostic: BN6PR11MB1684:
x-microsoft-antispam-prvs: <BN6PR11MB1684CE75096A18BCBDA2F42CF0820@BN6PR11MB1684.namprd11.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(14454004)(66066001)(3846002)(86362001)(53936002)(6506007)(6116002)(386003)(31696002)(4326008)(14444005)(256004)(53546011)(97736004)(72206003)(71190400001)(71200400001)(39060400002)(6512007)(7736002)(305945005)(316002)(81156014)(81166006)(102836004)(36756003)(8936002)(8676002)(2201001)(6246003)(76176011)(54906003)(229853002)(105586002)(106356001)(52116002)(7416002)(25786009)(26005)(5660300001)(110136005)(11346002)(6436002)(68736007)(476003)(2616005)(486006)(186003)(31686004)(446003)(99286004)(6486002)(2501003)(478600001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1684;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 56DyFUFyEiivMs9sUknZhhkqJ3HyL11rRmxFIIdjpAFo3Ptm6gQtRNLl384NVy4D8oUJ7AxRRDVNBPDNUiUFsVl9e7mJcRkReL72gFkB7Pyjmee/3pyWBpkcBMfeNPWr409qvnU0sn308Q6pp/NpD+6QlqpehzaK6Op9Q2vyNoCmh0zbueebyk9olMaO6v5FetgS21/qO0rPv/ra3TYjsI0HBhc7Py01VFANwNBhN2Pqd0AMzcFj745xjhAByYNEPeoegwOnK0ZlXmTfYolW+EuyzpZ+gCRECR6HHnyfBvAtQzCpDcCrKhxB09KkU7Aaha5Awnwzpe54wPftqMxo9ar1H3nKGmqpG4tpV+JcQ1FZJuPS1fcSyoEpbNgyKIGccsUoLwpEXqLATMwLZzeLYOe9otJm6lhwfy3FCEymn3E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <94D5D15A0F9C1B4FA92B2F87B7A562AA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f85e8c4-14e4-4c6f-5064-08d67b7a8cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:19:17.3601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1684
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_221928_401856_7E52637F 
X-CRM114-Status: GOOD (  15.39  )
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



On 01/15/2019 12:05 PM, Yogesh Narayan Gaur wrote:
> Add octal read flag for flash mt35xu512aba.
> This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
> not seem to support newer JESD216C standard that provides auto
> detection of Octal mode capabilities and opcodes. Therefore, this
> capability is manually added using new SPI_NOR_OCTAL_READ flag.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 872d70722672..53a3bcc6a55b 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1877,7 +1877,8 @@ static const struct flash_info spi_nor_ids[] = {
>  	/* Micron */
>  	{
>  		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
> -			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES)
> +			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
> +			SPI_NOR_4B_OPCODES)
>  	},
>  
>  	/* PMC */
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
