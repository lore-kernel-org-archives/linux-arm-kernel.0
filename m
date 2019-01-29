Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B43AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:28:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9E120989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WPk2EDr3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qE8Cja9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9E120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U24EH0+GNarjAHpf8ejKLfqlqM+1i1ZtZ47KFQUbiO4=; b=WPk2EDr3oSe1Wp
	zHQpe6pOZhz4iLBos9wbxa+KyEYDOwZbc5pNFs+DTrJjCJCvHoWPDhgJgcViyOTjRlXVofbtsyf/4
	PCU3HXwHJVOVuYl6ZEQ0M1mu01D5Leggf/BquwzYHclHGO+l3MJrGd4a3+0FJ+jkrZ4RdLyKG0Dnx
	30OwjA/v4XDldcX11Koai08kBH/rkBYjHPs4o0ssrKzg0Jl7CXiGDFkI5mgswaGGOn1NsoVNp8hr7
	8uwvORCVqlurcsy3fZs8/Z4NpS5V1ZOBxddAL1bJ8EheX2SzYvogCYZTxkc8W6gayUXUd/+6+rsq3
	B+oreaoL96mbaWHJYISw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUMp-0003hZ-DU; Tue, 29 Jan 2019 14:27:59 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUMl-0003gl-3D
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:27:57 +0000
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; d="scan'208";a="25895027"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 29 Jan 2019 07:27:52 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 29 Jan 2019 07:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXLTfSCgOxTz49TvZec9yUEqMqoI2GobRAnzLlalWMA=;
 b=qE8Cja9LQG+SlkRysDe3guGmbaiMiTwxMCFa25E6/wT1tkR8dloaUDPSMaNhbh6aFdCqCWpoq/CKlLIjIXxgm3IkKoR/OWr53Zl2wwN6A7CfzVQC7lbBpCr2tuXRkbzD292JNfPubqzjxam3w1+i0AFtXGdOmiQWTRQDrmBhzko=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1693.namprd11.prod.outlook.com (10.169.231.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 14:27:50 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 14:27:50 +0000
From: <Nicolas.Ferre@microchip.com>
To: <jonas@norrbonn.se>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] spi-atmel: support inter-word delay
Thread-Topic: [PATCH v4 2/2] spi-atmel: support inter-word delay
Thread-Index: AQHUt97QlH7O0YtX50uZ4B6TyEb/dg==
Date: Tue, 29 Jan 2019 14:27:50 +0000
Message-ID: <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
References: <20190129083844.20572-1-jonas@norrbonn.se>
 <20190129083844.20572-3-jonas@norrbonn.se>
In-Reply-To: <20190129083844.20572-3-jonas@norrbonn.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0113.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::29) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1693;
 6:C+PlLJxqVxrNu5q9yz9A/JSaBnHh0ykdsuQwHaipWsn7tOxl5iNCUd33uNSAROqrjgClZnj6CZuaXlyAw8KQNN/PL1N5070ZMJd7M8AXXvBWjVCa5gF0/NJh21W/XMDe1A8mh3LA54rb1gBab8OnC0mTPa2rCstdndFNaqRJmEnsEtfKozTQy+/KWxi0WS8MQxE1noVrp/dHN4vXhPvZJjU4EYzh7v8jVDXdI9ZPaL/GKSvsQgSXEJwqXWOW+G/+ZbbEKKDKJyBgQ2B7prxz5azX4n964TMtg/ytFk9vwZ3Yg3sYIzNuDiHtiojEjS67Ur75ep7uWlpu0bl7T+47Y69wDrIBaNY5AuzQvMgXg9siP3yp/jDd5quC6UXtndblVzGzID7qvTUOqPWuu0W7gRU248hSweqz7MRXUOnHpuvE2LTdhGKvHdZtMU4L4F0dLy240l1cLNdoR/EPrd2kiw==;
 5:WdZEX0drYahv1HV8bY5rPlnJCwZl4E1THPJefwCtPzbeGE8erE24fwsoDcuNB6xknxu/UdUhBTXa0igoRB5OlfhUZ56DKn7xoTnKvjbv/3+Hn6aluU6B3Q6JyGbEVMFL1TlN7wTq1NwQY4GmqyhDQcv7mf48jjW3Z2CcvKHB/aplSkFdVEzAYctG8+Dw5Zwxv9TRN4aCJO1VgCALpAS5IQ==;
 7:6+6fwpHbPOPQa9R9QEpre+PYwLYv7mbaQRcHI1rVO8YMInHjyXHeSQgyuGlVZo1BZZivZrHx2wN1jxEAK2vvzDWyTBWYXDWORQnQyWndHsFacfZFluu/I9ffaxx6h4isvsQRaOffq3WdZ/HGSI72zA==
x-ms-office365-filtering-correlation-id: 6ce775d6-45ab-4d89-0086-08d685f5f299
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1693; 
x-ms-traffictypediagnostic: MWHPR11MB1693:
x-microsoft-antispam-prvs: <MWHPR11MB169316417E72DD7609B917A0E0970@MWHPR11MB1693.namprd11.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(53936002)(476003)(486006)(97736004)(446003)(31686004)(2616005)(11346002)(105586002)(31696002)(71200400001)(26005)(186003)(4326008)(86362001)(6486002)(81156014)(71190400001)(6246003)(107886003)(81166006)(106356001)(8676002)(6436002)(8936002)(36756003)(66066001)(25786009)(256004)(52116002)(2501003)(76176011)(386003)(6506007)(68736007)(6512007)(99286004)(14454004)(316002)(7736002)(53546011)(6116002)(478600001)(305945005)(110136005)(54906003)(229853002)(3846002)(102836004)(2906002)(72206003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1693;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZkbNVIYS1tG4nK3Vm8t2Tk/b0aBbq9rG7y65cB+oyGim2zcp36pijDVzWW3lpohviAkUBO42f35DyDpltQ0YPeycD/V2rWcCPaaaV+Xg+9zgt02Lz8hx+aRh4KWlbGbFg4MyZZKeuir0DUo00YpwMlfXo7PqnWN3osPpaes97rihi+HjKyQoRCo6tSyTVG+xYjSUFBI3UOXi52UzLyEYDWm9K8uqG+kvV8Zd9wGUzhNMK9h3w3tDDjOBb8bB91ZCjEaePhZYu0QFmkhHhWc5b7apCFOQbZvYSwzo8fUh8I233CNQByk8J3sJ+ix/36FQzE/+P8CBqMdDtgaoR4MbtK3QgZ5+L4D5MIzJZtBexCOLqP0WK8Y0uziv9JR/fZ2hX1VbvR9QMX9QdKqwMW+dspUquGra00cJzQme0WcSRqg=
Content-ID: <3F49B008FA53E043A2C06EAF1D5FC410@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce775d6-45ab-4d89-0086-08d685f5f299
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 14:27:47.7161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1693
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_062755_487077_DC5B6EFF 
X-CRM114-Status: GOOD (  16.68  )
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
 linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 29/01/2019 at 09:38, Jonas Bonn wrote:
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
>   drivers/spi/spi-atmel.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 74fddcd3282b..6389a228d2f5 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1209,13 +1209,21 @@ static int atmel_spi_setup(struct spi_device *spi)
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
> +	if (spi->word_delay_us) {

Well...

> +		csr |= SPI_BF(DLYBCT,
> +			clamp_t(u8,
> +				(as->spi_clk/1000000*spi->word_delay_us)>>5,
> +				1, 255));

... why not simplifying to:
+				0, 255));
and remove the test altogether, after all?

> +	} else {
> +		csr |= SPI_BF(DLYBCT, 0);
> +	}
> +
>   
>   	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
>   	npcs_pin = (unsigned long)spi->controller_data;
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
