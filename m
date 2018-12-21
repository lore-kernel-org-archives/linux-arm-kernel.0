Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:52:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938F5218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JMoQCVZJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sou4RENQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938F5218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MraLLxJdMg2m8wdNCmu2vTQIbATzeULYgMyA9sDCg0M=; b=JMoQCVZJPMv1qc
	Xd6Q44Zkr5v/yEeeopoAm+D2P9SmltNc3q5S3EU3qkd7CS6YyI0uN/sfyMx9I0I5kKQS2odtBHJ2Z
	8BhtIyxLFpqmWNQqifAM/nQCkqM3vgHR48OfSjzecWRFaCJpto74VcIMBrzgX1qIVZRcd8wr6jRR8
	UblpI/ildlV+xxCbyY0U7FPW1/cxVaOe1ayLjarHc5auVHTqSauZoT68w/TJYhscP9ZpGN5xNmOuj
	c4Vhbyt5Glsc/LzpXRk4AaU1NvGBBaitwRFHciH/MRPacXwxrRUlx0bSlwZBbL/v0NVb3UD5Mx2EK
	C3VaC8gQKCDlq74SI9oQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga9ys-0005fe-J1; Fri, 21 Dec 2018 01:52:02 +0000
Received: from mail-eopbgr00051.outbound.protection.outlook.com ([40.107.0.51]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga9yo-0005eq-Ha
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 01:51:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPqeyUDPPbmOINtFte4KtIM9RU3aGRN4g+GmvxnGB8I=;
 b=sou4RENQUmmx31XD8IyAqOFpGLTP2aH1j4uj9VW7G+kOcgMM7zQlF7FBCy7wIDnKO0wSQz16gwElOyUtlpeIESkgWXL231T0wjI9tfKvRxsNzWrxM+i7b+fuAwFKZFjPTolV7MmQGlvf6lXqGGjnMmGPceHwT/myoDncQivd9aA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5796.eurprd04.prod.outlook.com (20.178.202.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Fri, 21 Dec 2018 01:51:44 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 01:51:44 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH 0/5] clk: imx8qm: prepare for imx8qm clock support
Thread-Topic: [PATCH 0/5] clk: imx8qm: prepare for imx8qm clock support
Thread-Index: AQHUl69KP5rFoD0FDkqjgax/qBib7qWIb1rg
Date: Fri, 21 Dec 2018 01:51:44 +0000
Message-ID: <AM0PR04MB421151E86936A1FAB5CD34D380B80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5796;
 6:j4hmZz7Ok/0KJRPxhJTcoHUrhpKFYEs8ZrKWeezM1vLTo4QH+bNUs7uxvWex9AUlLlEHJt8vQ+sUEPPugqVaVewGD+f3O8PKPntvJSqqiZpk7g8I2W8Gfk9kXF5eilgD4As7Gi8rDLTfq6ewrSGdAP3LIbngzMfeHaQEWdtyAM5GfKCOsHaScmWtZiFDTyUdBjBa5R1qGyV3KJcFrVhfSG0eeEXZk2Ec8T333WJg4IlWu01fUlH8kz4OybAHNifMqc+QnWYTsH68Qfi7yaHdT0VT5T3IHmK+7Us9pVI/jpMuvgeIp3nNFv2hKLVR9SH+bLOIMx+gEdtvkstTx3Whwkpwx7LH0lwE+LdK8sEe+Fm8bPM/tNNDGjLAINiUJRQyne7ig2QPe0Tkhbv+Oi/e7oshgzFUKRXsm3VAlLBkhfxSOn0cH7AvvEWSZ9o02Y5J5oogGEqu7/azUq3XnNr4MQ==;
 5:l5OTzNeREkgCorZHSc3sohXHawckY3VVwcnEYm+L6w1u+3z+HcGPSV4xr+am+LB9GNvfbIlkAMnFh9R7Q8K+Fn2sJqNFWC0tA8wq+GMGgo1yOWq0nwkHyDmsmCHiiE62k2qklCwtJgbjFJf5mUeEJRvvleCmnsl+yce/n9NgaBs=;
 7:T/fs2NLkXVdZKQ01n47WCGAJRumbfa8b5iibNv93m3r6l+LBplNXsSvH1suBps5M22LEvfV+4m9kczXFIxOieWQ7YcqkpywF4A1L57tbdwRL1yWpsOgRsZ5MclCmMaBTWSxRNFZDhNC8hrFvmbly9Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 084a62f6-3629-4c55-d26d-08d666e6dc4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5796; 
x-ms-traffictypediagnostic: AM0PR04MB5796:
x-microsoft-antispam-prvs: <AM0PR04MB57961EBF805E9F314C67BB9380B80@AM0PR04MB5796.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5796; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5796; 
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(199004)(13464003)(5660300001)(71200400001)(71190400001)(4326008)(316002)(97736004)(3846002)(6116002)(66066001)(9686003)(54906003)(2501003)(53936002)(6246003)(55016002)(74316002)(305945005)(110136005)(86362001)(105586002)(44832011)(76176011)(476003)(7696005)(6506007)(53546011)(446003)(11346002)(8936002)(14454004)(256004)(186003)(102836004)(106356001)(8676002)(14444005)(81166006)(26005)(81156014)(33656002)(486006)(6436002)(7736002)(229853002)(2906002)(99286004)(478600001)(25786009)(68736007)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5796;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iV66UnbepzMeqbdpRj+xDK4L8AS8ldG26UIJNedcUsZZ/uHZCfiaXXaMTkj3noim1z7Y72I9z/rOhcNo2UT+8vvLjLcHJhj1N+wckJIrfo7MdZccIioUq9vxgnohm1pnUJH3By1bOp/va7/97nkDyU6fy5v4fCUMLaWOQcSiqraORxSLI311mwHuOxHwvLG8iTN8VOlB1hCrUew12uEcPn9sBqaQky8HGPFntLZ7LHCGs/uyAyuYSrNlDDs+dkUmPEfgA6SA63BoHrL9o2Let7s/HS0CVZ3F9HETPrCpjeME+LxSLARQSB2IqVX9cLmK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084a62f6-3629-4c55-d26d-08d666e6dc4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 01:51:44.3717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5796
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_175158_580537_0440693C 
X-CRM114-Status: GOOD (  15.74  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch set is missed to CC Devicetree maintainers.
Copy Rob and Devicetree maillist.

Regards
Dong Aisheng

> -----Original Message-----
> From: Aisheng Dong
> Sent: Wednesday, December 19, 2018 11:27 PM
> To: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; sboyd@kernel.org;
> mturquette@baylibre.com; shawnguo@kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; Aisheng Dong <aisheng.dong@nxp.com>
> Subject: [PATCH 0/5] clk: imx8qm: prepare for imx8qm clock support
> 
> After a bit more investigation on IMX8QM, it seemed SCU clock can be used in
> a similar way as IMX8QXP. So update the binding and driver to be a bit generic
> for easily extension of IMX8QM support later.
> 
> Dong Aisheng (5):
>   dt-bindings: fsl: scu: add fallback compatible string for clock
>   dt-bindings: fsl: scu: add imx8qm scu clock support
>   clk: imx: scu: add fallback compatible string support
>   clk: imx8qxp: make the name of clock ID generic
>   dt-bindings: imx8-clock: add a53 and a72 clock id
> 
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   7 +-
>  drivers/clk/imx/clk-imx8qxp-lpcg.c                 | 146 +++++------
>  drivers/clk/imx/clk-imx8qxp.c                      | 153 +++++------
>  include/dt-bindings/clock/imx8-clock.h             | 291
> +++++++++++++++++++++
>  include/dt-bindings/clock/imx8qxp-clock.h          | 289 --------------------
>  5 files changed, 446 insertions(+), 440 deletions(-)  create mode 100644
> include/dt-bindings/clock/imx8-clock.h
>  delete mode 100644 include/dt-bindings/clock/imx8qxp-clock.h
> 
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
