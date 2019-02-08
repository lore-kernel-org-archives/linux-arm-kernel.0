Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7470C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:54:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839E9206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="krRrZvwu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FgnxrpOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839E9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ts4s80l/Gt7pWibahZtx85MPffocI61Z0voqPY6fpOc=; b=krRrZvwu9aM7xN
	LEJCR8F7iKagQfNBK9sAGSnZZiokdqS33606uG64KO1masqbCUU2uBv1/EGedRjsd0gU+wOZ9Ar3B
	opDSdyzgQ6snUj2AmTfyA4pky8ZCCohsotAAL1m/XxfidEAsZeOYH7Kr74B+tkEK5gRnK8DgoiXV0
	yEAFsiBMIp2Cn8wgzVkdgdH7DVOhQrlofe3/JV9h1pGJstSONRaG+CvCsLrZNpL2W7aURAaQAGlra
	Qu/hCuo9LidAVESF5cHYy3dP1zc1vRsENQrEsam/590sI8quj+n9tiDz2NVNhfbOXtWSP0g1ZwrTX
	DWJSky9uw9Hafw0PiG7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs8TY-0005CJ-Ia; Fri, 08 Feb 2019 15:54:00 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs8TV-0005BS-No
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:53:59 +0000
X-IronPort-AV: E=Sophos;i="5.58,348,1544511600"; d="scan'208";a="26002642"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 08 Feb 2019 08:53:50 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Fri, 8 Feb 2019 08:53:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfUX/BKxKKp+KuUcrHEUdLhz45z2XCFya2ivk0Mtmfg=;
 b=FgnxrpOt1KG11OUJSoXOwspGPSBLJVdFRFdsUEe7fJNe6ETC8FtMVjJjXE8yhA/V5NygK58ZJzr1UfVv+bw0lGjGUcBpO6xKHg1wJaDf8ZFGz8uixlJPokO2Us6rDFOmcyXXGqqHVq+lmB4OYD0wpJ3ivW9dNppKviRZwI4qq+0=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1247.namprd11.prod.outlook.com (10.169.236.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 15:53:47 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1580.019; Fri, 8 Feb 2019
 15:53:47 +0000
From: <Nicolas.Ferre@microchip.com>
To: <alexandre.belloni@bootlin.com>, <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: fix masterck name
Thread-Topic: [PATCH] clk: at91: fix masterck name
Thread-Index: AQHUv7x/dAWxQXybc0i6K8XkGPakkqXWDXGA
Date: Fri, 8 Feb 2019 15:53:47 +0000
Message-ID: <db6b542f-add1-af4c-e3f1-ce293042f375@microchip.com>
References: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0442.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::22) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1247;
 6:NQXazG1vRiUS8YmPueohkpGlcyuLBrF/AqrpSPKeFO5XC/KSTgeHcPmnFvPBcouoAgpbzZXew7Oppzsev+dLnC4DflHodc5rOMLydO2QY5X6KG0svSHagLhRG5oClhz5vmJ/7q9HEDJf56d814bBLzrLoqsmEWDQ3jkCQAm+QVfk9xp9JkUENKfYNc4QMwRLlwjf3ZO8iAXEUd7jk295WyRBBIP4MoFB7ALZ/PtQl7AnnhLJcl2tblQzhlCq23OOf+F+TjpIJ+7tq/nEiaoLjl0PcE9RxsRNticNOk0yZVOMzegPbgn1Qdn23Ngj/Ld6v/ChLwyeUMtdyVMBYzwUPvMBmK8CLceUgw3bdsTKlbI2pcYVzWM/zckbbujkrXOOLeRdnaOCMbMjOoQy55EfULse26NmY9mjjLQ+nVrwzYAkNNz464m90VrBCv1LFgT/vaMZx3tH7I40312rzSD0zQ==;
 5:rmb0Nr1GDydrPp9pJ4qlTi7ngPatBnpGA31WYrn3djKJ3o+JTEGbBY6Fl3pMTvB+XwiLGH5yuyTsNeclgLAPMCkN6ed+GbzWv1SjArQQsUVtSDDE5dkoYZcvGZGxXk5Ow90w6BREKW2i7swiCS2kFXBOjrYGJJ5BSvjJUYJx7bdbd9CHBErFUVwYG/KnU1xzmZfAGacpE7XoY48aIa5I4g==;
 7:7APSFt6P+3smqd4AScxcPpO5s+NQOSWPeqdTYhr3xDc9uIngk5dRvpG0cNNQZN14sd/nEa9utn8OjWossEanvShbrAk2TOExDjKn3NARKAvntySF/E29COx3xXgYmTsPsAsT8bQ1k/iQrPgTXHD3Tg==
x-ms-office365-filtering-correlation-id: 605c7a5e-3450-48c2-a63d-08d68ddd9c2f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1247; 
x-ms-traffictypediagnostic: MWHPR11MB1247:
x-microsoft-antispam-prvs: <MWHPR11MB1247F6F244B925ED29DA8E18E0690@MWHPR11MB1247.namprd11.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(97736004)(106356001)(476003)(105586002)(486006)(53936002)(6512007)(6246003)(26005)(2616005)(86362001)(6486002)(4326008)(6436002)(11346002)(446003)(31686004)(14454004)(31696002)(25786009)(36756003)(14444005)(53546011)(66066001)(99286004)(229853002)(71200400001)(71190400001)(54906003)(316002)(102836004)(72206003)(76176011)(3846002)(110136005)(52116002)(6506007)(6116002)(256004)(8936002)(305945005)(478600001)(8676002)(81156014)(81166006)(186003)(68736007)(2906002)(7736002)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1247;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8NK2O1V2Hgax9CVlvZUIqN6HvvN923ZRz3cPit8N7qpi0X58kbDD1t2YIp8Xlhoybdq8qTqVVAcN/SQc1n8SbYnLBR93r2tkS0U5gSf8avTu2utVW5B/Rg99ee3mgo2Q9hRGVrsaAeUxD69iNL5wYGtbwwx6qdMNP0gIhIaYqvTT78K36B4da5w3K6e8jCdQ/TAildo6Q76Gc/dV/xmmevJ7NyM2hg1cxJFM7WG9KvjzxqobUY4RN4U/wKj+0R7EFEK24ARxgQleCowakNJphLUndxr/Yk27ZmZI82PDzfjp/9QR4BlHEbVYnUzx1ML8g7nEKD4WoDVs0wzL2c2RON0PjWaS5ENxBOqdVLJAkq2FpalPUetpaSORfVRGOPs3UCEPQVTzes/7CBirvoaRPZluoYzPV6A1G2PO1ye35xk=
Content-ID: <2E1277669F1FE342A03D64FA37C336CB@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 605c7a5e-3450-48c2-a63d-08d68ddd9c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:53:45.0607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1247
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_075357_813360_D15A4B51 
X-CRM114-Status: GOOD (  14.50  )
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
Cc: devicetree@vger.kernel.org, mturquette@baylibre.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08/02/2019 at 15:40, Alexandre Belloni wrote:
> The master clock is actually named masterck earlier in the driver. Having
> "mck" in the parent list means that it can never be selected.
> 
> Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")
> Fixes: 084b696bb509 ("clk: at91: add sama5d4 pmc driver")
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/at91sam9x5.c | 2 +-
>   drivers/clk/at91/sama5d2.c    | 4 ++--
>   drivers/clk/at91/sama5d4.c    | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index 2fe225a697df..d55a151cb7f5 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -210,7 +210,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>   	parent_names[1] = "mainck";
>   	parent_names[2] = "plladivck";
>   	parent_names[3] = "utmick";
> -	parent_names[4] = "mck";
> +	parent_names[4] = "masterck";
>   	for (i = 0; i < 2; i++) {
>   		char name[6];
>   
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index d69ad96fe988..cd0ef7274fdb 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -240,7 +240,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>   	parent_names[1] = "mainck";
>   	parent_names[2] = "plladivck";
>   	parent_names[3] = "utmick";
> -	parent_names[4] = "mck";
> +	parent_names[4] = "masterck";
>   	for (i = 0; i < 3; i++) {
>   		char name[6];
>   
> @@ -291,7 +291,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>   	parent_names[1] = "mainck";
>   	parent_names[2] = "plladivck";
>   	parent_names[3] = "utmick";
> -	parent_names[4] = "mck";
> +	parent_names[4] = "masterck";
>   	parent_names[5] = "audiopll_pmcck";
>   	for (i = 0; i < ARRAY_SIZE(sama5d2_gck); i++) {
>   		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
> index e358be7f6c8d..b645a9d59cdb 100644
> --- a/drivers/clk/at91/sama5d4.c
> +++ b/drivers/clk/at91/sama5d4.c
> @@ -207,7 +207,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>   	parent_names[1] = "mainck";
>   	parent_names[2] = "plladivck";
>   	parent_names[3] = "utmick";
> -	parent_names[4] = "mck";
> +	parent_names[4] = "masterck";
>   	for (i = 0; i < 3; i++) {
>   		char name[6];
>   
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
