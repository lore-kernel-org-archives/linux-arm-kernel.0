Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E047C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B8920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lpwRD1Br";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fzkNiXHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B8920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/PTbIme1//Do1ZoF1GIS3baQnPwKZBRwlrZSjQ2gscs=; b=lpwRD1Brq4G0Eb
	sNZVQqBxm1+kDdGiwUxpnsJqI3wOlkk5e3akOtaTdrM8opvLaOAOzLF/8UEPO2tczwF41p9A5nTWa
	LEzOi1oIHfXRp/96ezHDlQFAZL2dnTd321Zfe0B9YL1rwxzA78NJlohDWI4/zyukuxBG0KuxqJZO4
	EpX7PVddxOsfSkaZNTaRqTGBZIV9cisHtztF5On1B5bY04qYZkcfBy8d1LqtXzvfoboDrHqWR4Whf
	iFgvGsj+MAI52WxuigsGgvE9uM8yiJtQr3aC6tLdVu6zqYEnftLIMhONuyAZIZqb4jlDloBX5Jqfi
	+zkx30phEwgN710GUvqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi9kd-0005tN-GK; Sat, 12 Jan 2019 03:14:23 +0000
Received: from mail-ve1eur03on0607.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::607]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi9kZ-0005sU-KF
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 03:14:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPxBiMNGT/yzEAEMJG+36RA7SJcbq1x7tU959VL+Y8w=;
 b=fzkNiXHslfV0a25aN2Zsx9IlobyrIk2f4nLxd6ThNXFYZ3cRWvY63J+TyrvIQsmKfTEJukIo/XJ/dqzEUfc27QQY0b35/rOreR8dJoCeyf/8Z2jwllhS/Sp+YEnPQyj2mHbCNe6cU4D3CLCjbx2YI7ryaJip1GZKgdMRNHZehDo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5746.eurprd04.prod.outlook.com (20.178.119.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Sat, 12 Jan 2019 03:14:14 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Sat, 12 Jan 2019
 03:14:14 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v2] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Topic: [PATCH v2] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Index: AQHUmsJJoCj9FDFtKkuyM9TG7go6u6WrEsmAgAAA/yA=
Date: Sat, 12 Jan 2019 03:14:14 +0000
Message-ID: <AM0PR04MB4211C5626B91ACC4F5F2431B80860@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545571216-655-1-git-send-email-abel.vesa@nxp.com>
 <20190112030854.GS32649@dragon>
In-Reply-To: <20190112030854.GS32649@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5746;
 6:VOJWAabIZjf7ebLrImN1Kp+LqO39kr6bgVQzXAcvtNefDqqq+SZNWYtzYzwqQ+bfgYONt9jaZC0P4wxzddnXesnkOB5Mcqzxauiv+uMNndSLVjnlCRFUP409ZUpTgZwtabanzAG6wEm+swShYj3i4vaNitkWTZ89+v74EsvHdXYcf4qGxFYfnLNiTEqJf4ulIynvMx48UIURPJUWZ/rmkH/ogWHKyr6/SSEZt+3YiHi466al9Umm/7wYiNbXQ91ptpDZ5+auIoXp5/JhoV5z1SY1okQ2Bd/c2+uVD0aOWNlZ+e9Km3s4WnxK67qYpRguvg3WVMezDgYbojduZfo6Td+xDgI298YMopFbx3CUbV15gpu1eTum6My7jcCYMEeHlp1xrfPzXLACnEp8DWL4JvzDdrdrNM64cbwLv3k9SQPxxwZosU60ODwlRs+vyYryl7RthPTC8M1lfv49930QEA==;
 5:4UoF+uwCnWPYGxeGBhjgrjupSI+HCec0WIW/eM2j0dTht7JDOHuorgARV7nUAKDG2fd0ONotnUYP5iwcpfihJ1Mp2zTiPhOcv2x/9reOWDhHhWFra696wkMMI0ornvfhpW5gbpe3V/GQE569dBs8/461DnINwrkjAXUmexZ2uB+5j06Q+FfSw3tsr9r3tWRNiFTMCJWGs8QwMGH2lOyiqA==;
 7:aNbL6lVdcRSRhybH4+BTW1UR6NLb1gpL49poG7CN6XejU3SE4+xnfzp9AdhEJEBDGoFkFrx+rM9Bufw823T2mnPcpPwZ7o1xTmVTmhd2LDzPoCc7wEiUIVL72MGt/Upi8kwXgfesXVcJt500C7rlpw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 901ef54f-a893-4ce3-411c-08d6783c0825
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5746; 
x-ms-traffictypediagnostic: AM0PR04MB5746:
x-microsoft-antispam-prvs: <AM0PR04MB5746324922A3356F65BA1A7780860@AM0PR04MB5746.eurprd04.prod.outlook.com>
x-forefront-prvs: 0915875B28
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(189003)(199004)(33656002)(5660300001)(6436002)(53936002)(6636002)(2906002)(9686003)(305945005)(8676002)(7736002)(8936002)(81156014)(81166006)(66066001)(74316002)(229853002)(105586002)(106356001)(55016002)(97736004)(54906003)(71190400001)(316002)(11346002)(14444005)(71200400001)(256004)(6506007)(76176011)(7696005)(110136005)(99286004)(44832011)(86362001)(4326008)(25786009)(6116002)(6246003)(478600001)(3846002)(14454004)(26005)(68736007)(186003)(476003)(102836004)(486006)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5746;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fRVBPWTLFxTDG8OjNL8PurACH8ifrnOsAx0XNCaRazEJurjv1Gw8nKFJxmNGhW1ZiRmOwiXdZQ8oahapF+tdZrPz3U1sC5hFZNLx468dZxJRFhPLvFy52t512jlZthF+ocMs7rTb8J6fLZhF63+za5iE0wJ9ZXjkt71eNg6SP3sHHCtBAFabqrEPWuFICxBgF7q36PPvz5wBabti1S7fsrbyRN1hdgcrmXwaIA78119gL9QEcDqpZ/cQ4MxZNVkTTXk9eyJpU3IKqt8YWxhjsLxj9S1ELfcj1gLBnDZikGPOYs2ULVzxiNoPuiQ9cu+g9omH3rW2z4SrYkOvtu5Zhevk+RSzWvjhYPokNHm3s6i1e/3G4tjJqFp98XSAd2n3wXAfZAdN/WJ8Iq2Y6I8gvgxzPc2t7MvFjzPWJQSjClg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901ef54f-a893-4ce3-411c-08d6783c0825
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2019 03:14:14.8753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5746
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_191419_741593_50489DD7 
X-CRM114-Status: GOOD (  19.97  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Saturday, January 12, 2019 11:09 AM
> On Sun, Dec 23, 2018 at 01:20:34PM +0000, Abel Vesa wrote:
> > Since this is going to be used on more SoCs than just i.MX8MQ, make
> > the dependency here more generic.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > Changes since v1:
> >  * removed the SOC_IMX7D since it's included by ARCH_MXC
> 
> This should really be mentioned in the commit log.
> 

Yes, you're right. We should put it in commit log.

Abel,
Would you resend with this updated?

Regards
Dong Aisheng

> Shawn
> 
> >    as suggested by Dong Aisheng.
> >
> >  drivers/soc/imx/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index
> > 2112d18..d80f899 100644
> > --- a/drivers/soc/imx/Kconfig
> > +++ b/drivers/soc/imx/Kconfig
> > @@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
> >
> >  config IMX_GPCV2_PM_DOMAINS
> >  	bool "i.MX GPCv2 PM domains"
> > -	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
> > +	depends on ARCH_MXC || (COMPILE_TEST && OF)
> >  	depends on PM
> >  	select PM_GENERIC_DOMAINS
> >  	default y if SOC_IMX7D
> > --
> > 2.7.4
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
