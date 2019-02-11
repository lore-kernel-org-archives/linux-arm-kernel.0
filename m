Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492D9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:03:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1921620818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qr55xTsc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Y1z4qdav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1921620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bWb9ta9LHxP1Z6lFTIxX2GtIVuWnbF8Ycle2vKKJuTE=; b=Qr55xTscTwJBC6
	+6xuxCJswi+I9LMkL3SPgT6w7l6/YfqqkjtoRrISmmEWl17smS74o0wHOi5f+mDBWAlCmJMtV/dRb
	zPPZYPhVXEBx8KKAwilzObp+9cHg3CTDi7+ufWsU5FxvUyAOD1LfX7p1gGu9fbOWTcM/7u8vTv4Uu
	NnicFlV18tFADZzjaCEL90/waLK3fTnxpN3oIgacA06L7w+ws5qffcQMpsOU1gH+XYgllgDEusLts
	e0uxVWNqgKpDuL3Dd22drjldBsch0/iSa5WliENrYvmGeYWqTjXClCUEg5v//NyK91UztS7/TGKfG
	KYAXD9WTdfUwtW0rBlSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7V8-0000pp-SD; Mon, 11 Feb 2019 09:03:42 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7V5-0000p1-13
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:03:40 +0000
X-IronPort-AV: E=Sophos;i="5.58,358,1544511600"; d="scan'208";a="26369480"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Feb 2019 02:03:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 11 Feb 2019 02:03:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEdMuHPQybC3whZISou8bW5bawXGlUaEXTQImhlYfYM=;
 b=Y1z4qdavoExP4mnOwkfJ5deu2BKvvGnjUIGaAOfdj8lzqDUafdF+wcwve2EBUyxBGRtGWbfg9V7UQePXRQfvn1B0jqsB3TL4W5PL5bH8JgJBFIOpIoo9+SPw++LYC9qeSp9OD9AC1MBk7kqpFMEEhMjjzAwI/OVvhOzqxUUN4kQ=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1456.namprd11.prod.outlook.com (10.172.53.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 09:03:13 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 09:03:13 +0000
From: <Nicolas.Ferre@microchip.com>
To: <gustavo@embeddedor.com>, <wg@grandegger.com>, <mkl@pengutronix.de>,
 <davem@davemloft.net>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH][next] can: at91_can: mark expected switch fall-throughs
Thread-Topic: [PATCH][next] can: at91_can: mark expected switch fall-throughs
Thread-Index: AQHUv96tjOVfcaEDgkW1qPEWyqPSIaXaUXYA
Date: Mon, 11 Feb 2019 09:03:13 +0000
Message-ID: <8119fbe8-5f4b-e45c-6687-ec42aceb3428@microchip.com>
References: <20190208184444.GA28484@embeddedor>
In-Reply-To: <20190208184444.GA28484@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::13) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1456;
 6:79gga67oVy0cF8WADNFwaRkhgP8XBh+xEmA4kaaU3aqEfk78lZSjdzrn12d5ZtVcN9oBCR3mY8O05+J0KvAVTM/+72H2zgAsADsypdykEz4jc1jcwmVjhojFEOtNt1KXaOCJecuwXtFNF7DcexpJfu7CYPLoZRVO3XReTtByMz/+7R+JVzEeNVuQnVXlib3PThzIzioyLrHqzGWzfi+L0U9/PZ8MtDuiHPWRhlSwjUO7OQMYfG797ZJylA0DB6uv+oh57WD9uRH4GnLr7AP6oDZ2DW0XnzCYTtIFvbTQlF5nBvvj4Wb1uAfxMb4naNyqT46vMmm9nDZnShIiJNd8JxAWMocRg1WTY1NkicQJ0dzDlJlMm8sJL3R0f53gpwe3d/HLAK6EskeQKgn6QnpU4KaylxWVVjUDsT9Z9R0kKx1Sc9r6AY2dOk3udam/IYgldXUi32lGnOcs5e3oIh/kdQ==;
 5:ZF5quZa6RiUVN9QsQlHiXNq/QVPiGbGTgl+27/5CYkTZsofv74YtrFKL/ln/n+DG3VIKkFhi67wSUEP0TUbzSBjExpf92+PxzUqJXJbj4XbzHcfcC6bwhp6O88YuC3Bmkq5xxEZpCuQaQRx+baMRK12Pzu0OxHs0nfupmzRndeRN3GHAnXaswedaPI0+0lCAe3Nl7KNmJXSBlkXziE4+Vw==;
 7:R+1bFvVNieBOD9FxYTnGmJKBFvMrH5CeWpMzOYDLnh8efDrV4aPDP7mAol1+D4v0J9vgUm7qGBtPIjS+JQ6A2UeLUEEZJJ0kEhddGwrl4wkrWK+AkmGQqhZgJl84FI+1hZg2qg3TnqinFyDP5W0HSw==
x-ms-office365-filtering-correlation-id: 59c2fbae-64ac-4ba9-2b80-08d68fffc084
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1456; 
x-ms-traffictypediagnostic: MWHPR11MB1456:
x-microsoft-antispam-prvs: <MWHPR11MB145636EE1D0F39AC0C22B6AAE0640@MWHPR11MB1456.namprd11.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(102836004)(71200400001)(71190400001)(53546011)(6486002)(6436002)(14444005)(256004)(229853002)(26005)(25786009)(4326008)(31686004)(106356001)(86362001)(186003)(68736007)(36756003)(6636002)(31696002)(316002)(110136005)(54906003)(66066001)(14454004)(6512007)(6246003)(446003)(8936002)(11346002)(2906002)(105586002)(8676002)(72206003)(81156014)(81166006)(99286004)(97736004)(2616005)(478600001)(476003)(7736002)(305945005)(3846002)(386003)(6506007)(76176011)(53936002)(6116002)(52116002)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1456;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pVqqIOEDeiYtPHr8KZVgZ9riUoCtbGBu6+75YdJwap0kTWDdbKQ11Mfl/cLpcYptXQuorzBqe58j2NjIsSx17h6LRsayihwmro/YG5tMLh8KI8L/66OUheXROeFVP3ISNvcxsLiJbjQoI8JvQMs7+wr55jSZDtNMtiRfKF1xYhfG6sn3ppGLxOntqTxWVMwdvmxyVaCdmdM/27sYKemBeeUr8dKiYDEzKsmJnLlPa7XiBDzTkJ/K7JoUKsenJQ/8OczRND362F2kgvY6Kp6B6oZYtJmw+Z1GCEFRLaXcmv9DFxa5H9znJ1mVI7i4WHCijBDGx+ABpzwOLHQINn9nwEM0T3tOdhXEBjYvU0myhKb2fvFGlQRv9/70R+hixLMxxv20P8PZISfLGIJdcmNGMJr8CMopuhjX8GtDDzPxyjg=
Content-ID: <20C0511DD1579446A467767CDC4922FE@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c2fbae-64ac-4ba9-2b80-08d68fffc084
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 09:03:10.8476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1456
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_010339_118463_4BA32A05 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08/02/2019 at 19:44, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> Notice that, in this particular case, the /* fall through */
> comments are placed at the bottom of the case statement, which
> is what GCC is expecting to find.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/can/at91_can.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index d98c69045b17..1718c20f9c99 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>   				CAN_ERR_CRTL_TX_WARNING :
>   				CAN_ERR_CRTL_RX_WARNING;
>   		}
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */
> +	case CAN_STATE_ERROR_WARNING:
>   		/*
>   		 * from: ERROR_ACTIVE, ERROR_WARNING
>   		 * to  : ERROR_PASSIVE, BUS_OFF
> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>   		netdev_dbg(dev, "Error Active\n");
>   		cf->can_id |= CAN_ERR_PROT;
>   		cf->data[2] = CAN_ERR_PROT_ACTIVE;
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */
> +	case CAN_STATE_ERROR_WARNING:
>   		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>   		reg_ier = AT91_IRQ_ERRP;
>   		break;
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
