Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF0C282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:16:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5489721473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SS8g+HW+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="YJAJpd5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5489721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HdOyWdyZBojLOVMzu2pJu2/jxllmq67tY1JRmSPvScs=; b=SS8g+HW+uCb3Lr
	JHvRA6jRcOsb2IeVkVFdv67SVbsFwcuVwDNw0ts5gGlbO5YkKPy2BHaHvPCp+7Aotc2IljPjTS135
	E8LwMwBhz+w0kCIdxNV/ygPrUdadzIXwdQ6za4VW0k/lexh2/cWRR9+7P7bIMVoggNDJNT9zZRc4N
	TztXVisSpn5UueUpGubSnPFlCxPtm8z7l9KotO+bot0NwV7d9SNjlp7+CJdq8Q7pESQZ4imJYRsA+
	Zp1A7fz6cKzqUNeBdx1A419u1zRWHEkXY8kYdN5ieL0nUVGaaGCGwgaZSu4noYez6kz0ncbgq4hUw
	ePGD+4t3PErXov8h5h/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gol2S-0000bx-2Y; Wed, 30 Jan 2019 08:16:04 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gol2O-0000bZ-Mb
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:16:02 +0000
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="23195961"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 30 Jan 2019 01:15:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 30 Jan 2019 01:15:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0MdGx6eE7i7EF33fMVlXo8bS05mUuzAD+ypGACfpR0=;
 b=YJAJpd5Wgs/W1aloOAvKBVlm0X3kHKb5vJ1O+ng9g6UPEYtjs8gytC0e9N0mVGqyCaGKXioGD841G+1Lc4W47q8pGeRS0CmApGHJ5OyYHGxWS1QOfhbXaOvmD/1dbsXqasRLwTtYyNOjj/iMnQ16UnfCwdI358IPibwmStZ8pwQ=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1710.namprd11.prod.outlook.com (10.169.235.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 08:15:56 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 08:15:56 +0000
From: <Nicolas.Ferre@microchip.com>
To: <jonas@norrbonn.se>, <linux-kernel@vger.kernel.org>, <broonie@kernel.org>
Subject: Re: [PATCH v5 2/2] spi-atmel: support inter-word delay
Thread-Topic: [PATCH v5 2/2] spi-atmel: support inter-word delay
Thread-Index: AQHUuHQGaWNnRm8n8EiXbk47TGR6ew==
Date: Wed, 30 Jan 2019 08:15:56 +0000
Message-ID: <78389342-af93-b233-e12e-5f6945bcb154@microchip.com>
References: <20190129205502.7741-1-jonas@norrbonn.se>
 <20190129205502.7741-3-jonas@norrbonn.se>
In-Reply-To: <20190129205502.7741-3-jonas@norrbonn.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:59::19) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1710;
 6:RDWu52H4xWWIhBZeyeSqduuRqwgmUqt58n4g9zDR1uF9a/7zPaGLi7OA/rvvPZ5oSSf5qE8o2uEgJV4UAv7gWC2CSqyjtvlBAKIgSTuwoyK0EXkqEDxExPDtA32IcO35ezUYq83Xx4HaOXeCggQJFjHa9di6+HI4MQRhhVyDcNUE0GcXsuXqABwJOdWjP+vtdrz90N+F9TlPbk5BiTkZukAjrKpzz3zm8K88yMWp4Wn6tZUyI+QznRcYZktS70ngy5MpYfIipv6wnmbPaboJh2fYO5c13Pfv+veT7WiHEKgMGzR2HBGnMrpLQz4qr4S0U9NdqeqH2dI+5SFiWRbEdfGPU9yetc8N6/7r+6jXagdvh7i3LmMtXEyS0Xx69Em1GSbEpgU3IsgvJlXH1/ITNftPk21lgqTJ68hV0sPVM1mdCh/LuPIHp/c7C3oOvBMlaQvCuYrGvTvsJPCUHlkNDQ==;
 5:DvBZcnUX6FASagpzZUB/GhSIxlaf0dEdH5muTpROBHZR4ydzY8/YtFVjvm2uWgcOLJMCRgnbweUMeAAJkDm1iQIqj+URknHK/JR8SO03cRCrTw4vksFidV59XyuuioupxoA1botrIfu/7VyTNduAp/fHGFb9x5RmDQ5cLKNQsjLl/M4TsBIFVdit+Q3s/Mui050C/6pTFFYdLzrKlhGXHA==;
 7:uB7s8SArN8xEg/Sjc6SFyx2N/jtA2wIeQ6epeJnvbw/79q+DI24mM9frhBD1nfhe2G4+1xj49BqSLZkbrriXazOK0P7W6/Ol9UudtxT1y2K6hOiXYaJUWeyGVjlihGVlNdKI8lv9PTkz8uSueKyEOA==
x-ms-office365-filtering-correlation-id: 95f7479f-a296-4d56-7919-08d6868b28b3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1710; 
x-ms-traffictypediagnostic: MWHPR11MB1710:
x-microsoft-antispam-prvs: <MWHPR11MB1710E3EB98FF425019D1395AE0900@MWHPR11MB1710.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8936002)(25786009)(81166006)(66066001)(53546011)(2616005)(86362001)(446003)(52116002)(76176011)(99286004)(476003)(26005)(11346002)(31696002)(186003)(486006)(8676002)(81156014)(256004)(97736004)(3846002)(6116002)(6486002)(316002)(4326008)(2906002)(6436002)(107886003)(6246003)(6506007)(386003)(6512007)(53936002)(305945005)(14454004)(229853002)(478600001)(68736007)(110136005)(7736002)(36756003)(102836004)(2501003)(72206003)(71200400001)(106356001)(71190400001)(105586002)(31686004)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1710;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h044vT8mpcomI5nsVndkQZ3NeYciulR0N5AHetp3qwcj+uyGZiH+6LkNBLd/RIXUxF+c4ATN5uDiRqotfPALQ3+jy2MYdglr+I27A0iywW3gK8e6GxpUo0tjhkBEx/NttlwHFHqorN0FQDlbLa8BBjaElNVUljTwJXbPofF1hCkDlbWg5NdIEIXH0Mr2rvdFjevG7FZEojqdLHos6L+HEb+ROA2bdeQf3/r2dt5fouN8tOJzoeoOlMeqqAzZ/fCTalsQ3cvKx8DxsZnvxE1WHBi3iWHJSstrTcziYTBnEqqtgIF74R7VR/b44hN6Sy+LGG2FwzXdPLACMHHathOz6L1x8tFbfZV1CgpbfTwupo60CfEzJHB3WrzO2JaIiIu2D+Bs6eMBVC17qxD+XZTUqH6U+NE5razWK032Rjerbnk=
Content-ID: <BC46FB6882A4F040AF9276E15F98AE91@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f7479f-a296-4d56-7919-08d6868b28b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 08:15:53.9055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1710
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_001600_773968_EBE3B7AB 
X-CRM114-Status: GOOD (  16.19  )
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
Cc: alexandre.belloni@bootlin.com, Tudor.Ambarus@microchip.com,
 Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 29/01/2019 at 21:55, Jonas Bonn wrote:
> If the SPI slave requires an inter-word delay, configure the DLYBCT
> register accordingly.
> 
> Tested on a SAMA5D2 board (derived from SAMA5D2-Xplained reference
> board).
> 
> Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
> CC: Nicolas Ferre <nicolas.ferre@microchip.com>
> CC: Mark Brown <broonie@kernel.org>
> CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
> CC: Ludovic Desroches <ludovic.desroches@microchip.com>
> CC: linux-spi@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/spi/spi-atmel.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index f53f0c5e63da..57cc7110f9e8 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1201,13 +1201,14 @@ static int atmel_spi_setup(struct spi_device *spi)
>   		csr |= SPI_BIT(CSAAT);
>   
>   	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
> -	 *
> -	 * DLYBCT would add delays between words, slowing down transfers.
> -	 * It could potentially be useful to cope with DMA bottlenecks, but
> -	 * in those cases it's probably best to just use a lower bitrate.
>   	 */
>   	csr |= SPI_BF(DLYBS, 0);
> -	csr |= SPI_BF(DLYBCT, 0);
> +
> +	/* DLYBCT adds delays between words.  This is useful for slow devices
> +	 * that need a bit of time to setup the next transfer.
> +	 */
> +	csr |= SPI_BF(DLYBCT,
> +			(as->spi_clk / 1000000 * spi->word_delay_us) >> 5);

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>


>   	asd = spi->controller_state;
>   	if (!asd) {
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
