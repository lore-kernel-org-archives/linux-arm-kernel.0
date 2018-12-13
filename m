Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C360C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:59:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD5A20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lOAs6rza";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="1sf4IzzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD5A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k/K2BZReccSB40AVQghbMy5P0DJtnsSoVJnbLLR1BWo=; b=lOAs6rzaCd8ZGZ
	SxFTPCyjaS5i5PFWXjms/hvb3YS11Exu7qIEELkAYnLIBmbLGvSmJVMbAHhXalPekg6xW+/kxWXjq
	qXuOONisYyuPKlQb0e6LWSC0l+3YhziOEfPZ6cRSfrlwLZ62yRXipgeN6V36HoivvLuXyugNvgw1L
	5/YscZoUIHO3wvaA4231oS6LjkDdE4H5FXEPzE0TdJRbi2212tQ1EVC6MXzPRYwT0jLz8WzUXsKZQ
	8BEARUytC9gKEzfu0mRu8rEbnPQMxK1xwZT/ooy8MgQxkM/bFuMqJ5SCGHzsZ8nsKTxyDkeAHHajl
	kcP5+1J/AieS2uKqT8qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQaD-0003F4-2U; Thu, 13 Dec 2018 12:59:17 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQa9-0003E0-Sm
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:59:15 +0000
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; d="scan'208";a="24166953"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 13 Dec 2018 05:59:03 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 13 Dec 2018 05:59:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmFWb1ptoxv6agxuvhy+mw0EdN1NdImH9+CRh+UhbiM=;
 b=1sf4IzzJAjwDEINYi+MsCT5XeNraB/N6THmU6jlMIrxMKmNNwQ0sx+6gy8xnb24CSdoqoOtQNy3B5ysOd070dvR0BP2djVW3aTZE5/tiVfuyw6ytAewQcruiJg8kYOwWaCoouEFTKb0sD1g/N0DrlXc9AiCeunhqXg7FIaD/kmU=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0728.namprd11.prod.outlook.com (10.163.112.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.25; Thu, 13 Dec 2018 12:59:00 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:59:00 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH v4 0/5] add PM functionality for act8945a PMIC
Thread-Topic: [PATCH v4 0/5] add PM functionality for act8945a PMIC
Thread-Index: AQHUkuJSt817GApqBkOd8F4AATMFUKV8oWoA
Date: Thu, 13 Dec 2018 12:59:00 +0000
Message-ID: <0291f79e-b8df-f7ae-1ded-cacd404bc5fc@microchip.com>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0049.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::11) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0728;
 6:CbT/jFJV+rn/oyT7jhcb1krtLgUBuAIKNTYR4lISrAHZqFSjJLewphHUEWYMig5hjfCQ30epEpeXbO1myd267tSqsmgsbLZFqL7E8SoIUnGvJ07TIT1spLANb86vWERqaO8RkNmJTmjSwMg71VzK+TjDbj9dq2vT1l6106F7eftCYbMN4t4FAXWm7adDRDqs9B10wuINS96NMIpLcgVpfpcogP0aP/LA41Y8h3huY64/5RTs+yIJVjLi3Qtbl56YNIN/Ya3fxpNsUFpflQELrdxQ49SCXL+ZqBSWvj6G8ihX9moDZTzHJiEhGuubsP7A7YU/DSaWT20iY6GM69TGGFNbToMnio8tuWlHom/qrsg/on2v2PT5cHfL8i3pRbajurvJArb47chXgDBHaIOpzWPdVxHd0XUF2oOjxtpP5EQU4JammaNXu6GqWzVuVtIty73eREF59yu7vn1Wr1Ms4p8zZ/5AyjYHWLQh2oxnb+U=;
 5:BAtwXFapqhcx8j75CPAd4FO2e08gVQ6nxwOYwnmg5b77j2HvsBO81GrHSIcsnOJHf5AGdxUPYcDR2uSpJiFGXtssdckTM541xbhXQba7DyCUogpfqbTfMyxDubKJFWv/sYMA3/v/0SbhhYfaZ0+TuqzPnySBixTswdxH17+E0LU=;
 7:5frqvicclKFfH2lm8d+Mlz+3uOPnlUX4b4Wnx9biMzqRRtNS0AHO7z+pcgejzv5yjHAl1lgtqaLs0NnqHoAQqsQXJDBZkrAILpx8rt3bIP0OZLYm+1qHa+i3C5EojUkCwJRSscg/ey/ZsMficw87VA==
x-ms-office365-filtering-correlation-id: 60adcae5-a101-4af5-5a89-08d660fabfe1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0728; 
x-ms-traffictypediagnostic: BY2PR11MB0728:
x-microsoft-antispam-prvs: <BY2PR11MB0728DE6757532A5DCB73AD9987A00@BY2PR11MB0728.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0728; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0728; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(106356001)(81156014)(71200400001)(386003)(71190400001)(105586002)(14444005)(76176011)(66066001)(6506007)(6116002)(53546011)(256004)(2906002)(446003)(11346002)(6436002)(2616005)(316002)(110136005)(2501003)(478600001)(476003)(53936002)(6512007)(72206003)(99286004)(14454004)(52116002)(97736004)(229853002)(6636002)(68736007)(7736002)(3846002)(54906003)(186003)(5660300001)(26005)(31686004)(39060400002)(6486002)(81166006)(36756003)(4326008)(86362001)(6246003)(31696002)(102836004)(8936002)(486006)(25786009)(8676002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0728;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WVAnPWTvWWxLYGJEu0vwk5gg4CneNb4Lhs9RC1m/pWgL6AzzfktUU+ebExnWDmPs/nczoC99pesNTeLjMDjoJbd8YDACurW4hTjmSM3JRNS1CvelmFtPbRGQKu5p7uCI5H5xAY+PaaykpYnXU+21vxDNb5Ko615qznflAkP25qlbTbu3NZ6hxGvsCUE64SZYlZWvBU0fsJbLQIuc6bJa9+z1unUB1ZD1eO+8hrUFm+93LN2iHk++WrCmz+sLM6ZXxCWD+xjONRdLW3yWfHgYtaEXCUxeSk/s7gjaO7c+iQOdc0FKWPuBez0FF/D6MTm9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <C412264179B89043BB78573E38543AB7@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 60adcae5-a101-4af5-5a89-08d660fabfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:59:00.0524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0728
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_045913_960686_F85F7D9B 
X-CRM114-Status: GOOD (  21.70  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mark,

I saw that previous version of this series was applied to your tree just
after I've send this new one. The only difference b/w them is in the
documentation patch where I moved the new header. No functionality change.

Sorry for the noise,
Claudiu Beznea

On 13.12.2018 14:49, Claudiu Beznea - M18063 wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> This series implements PM functionality for act8945a PMIC and use that support
> on SAMA5D2 Xplained board.
> 
> Changes in v4:
> - move dt-bindings/regulator/active-semi,8945a-regulator.h in documentation
>   patch; driver uses macros included in this file; due to this documentation
>   patch and drivers patches should go through the same tree
> - make documentation patch, patch 2 of this series
> 
> Changes in v3:
> - add patch "unlock expert registers"; it was wrongly missed in previous version
> 
> Changes in v2:
> - split patch 1/1 from previous series in 3 patches: one adding regmap,
>   one adding pm functionality, one adding shutdown functionality
> - use dev_pm_ops suspend function to set register specific to PWRHLD line: this
>   is specific to PMIC itself and not to regulators
> - add mode support for LDOs
> - add constants for mode in dt-bindings/regulator/active-semi,8945a-regulator.h
> - document modes and regulator suspend states
> - remove rdevs from struct act8945a_pmic since were not used anywhere
> - add op_mode field in struct act8945a_pmic, update it when setting mode and
>   return it when reading mode (avoiding one extra register read while
>   reading mode)
> - add a patch to fix a checkpatch.pl warning
> - in shutdown function use directly act8945a->regmap instead of an intermediary
>   struct regmap variable
> 
> Boris Brezillon (2):
>   regulator: act8945a-regulator: Implement PM functionalities
>   ARM: dts: at91: sama5d2_xplained: Add proper regulator states for
>     suspend-to-mem
> 
> Claudiu Beznea (3):
>   regulator: act8945a-regulator: fix line over 80 chars warning
>   regulator: act8945a-regulator: add shutdown function
>   regulator: add documentation for regulator modes and suspend states
> 
>  .../bindings/regulator/act8945a-regulator.txt      |  34 ++++
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  54 ++++++
>  drivers/regulator/act8945a-regulator.c             | 200 ++++++++++++++++++++-
>  .../regulator/active-semi,8945a-regulator.h        |  30 ++++
>  4 files changed, 312 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/regulator/active-semi,8945a-regulator.h
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
