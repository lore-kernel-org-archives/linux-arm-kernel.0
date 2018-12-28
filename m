Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4091C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:38:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAEE2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sv3cix6k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GOtwHjME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAEE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JlI4LM2XENP7FM84/sHqSDRQDnAnjBnriYJs7c9+DS8=; b=Sv3cix6kcySgy8
	j8iylJgtY6S02zxO4oHrOatCOCStdBjvVvVrp2rJm8ZDTz65LrC5IRaf1dE6BQaOS3LhODACWXlq0
	wbk+/dH8ISYPWcTHY5pvpY+oT2xeNAcgYTRff7l8ijCaQk8/wNHwt7rAEeQTGSFCzzm6y0jBxJs2p
	mnEFYpgsCM0voTIGN4DQO6ayAt/YyNP6a3+K0KMnMJFZ2gI1apGIIYOc/kmTYYUdayviK/C0bC730
	1DFxedmBaE6Bfg8bd2OUm38nXui2r11de+WP20orhppuEjSsL0sFxJPpQ1D6UfB2tAjNo0CXiUvaE
	STGYdnJpVMiY5znT7zbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gci2o-00013m-Qm; Fri, 28 Dec 2018 02:38:38 +0000
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gci2k-00013E-AG
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 02:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seQcLPtZz6FhSLn7FqTXGndcPgsJ3QrCoVUJ9vJVgFo=;
 b=GOtwHjMEchn8iPXWd+O+lWdqmftNpzAOB0b2V5aWIineGi1krxtXyAWNaFSJ8bvBIOQgDACo5u2Hm09JvvHUqOgivr1sFQnS2NfOANR4RcIu1WGxO9cCbWsqFzHzMliMjzNhwy/v7Q5BcuvadcSg3KFKpSTjfI1u/mmjEF/znYg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4644.eurprd04.prod.outlook.com (52.135.149.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Fri, 28 Dec 2018 02:38:19 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.027; Fri, 28 Dec 2018
 02:38:19 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 0/3] firmware: imx: scu-pd: add fallback compatible string
 support
Thread-Topic: [PATCH 0/3] firmware: imx: scu-pd: add fallback compatible
 string support
Thread-Index: AQHUlurnkkOpfd8XR0GtHCPkVJ9KYaWTfjpA
Date: Fri, 28 Dec 2018 02:38:19 +0000
Message-ID: <AM0PR04MB4211FB9C3BA2CBBDB58F03FC80B70@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4644;
 6:jB7X4E+eMcna/Dxay9zBWeKbvx999mH9dM2YLc51idBSaJUBWirPyvYvPDfiFXkgT6qDLXXyPkI8vPlufGp4YihrsWC3P/llbsXFSE+OxXgptWo1V7q7zzjg4sad9DBC1VLYCs9FuhIkzLbA624x3crv1muASh/MFt4llZHYlOMVBX4bua0ATn2a8DOMLFalElTX8sTfPqUlfEdmJaDys4Yjj/U/iGvNBd2YQ5nOvQ3l8VA/att8IlzA1c2OJ9nm6nBmTIk4R+s2lN+M/yrX7SQoz5D+M6opiJsI9YjVFcB1mUJz1epOok7RkC0kABe/+LChPSzIuR/Xa2sBr5CR3Sx3IE3acuGB27EdC+m1XWsBZHvJkKpNWE9JcfqGh0zbJySgNjmturHG8dTIME14g1Nrt42hj8XFys/LYzeA1uj2WAJS7OabLe95hRSHefD58Lqjs35cumQvBaogpLvj7Q==;
 5:VGOK6e5XpfRdFeKtHJpgy8BQToNmjzcl8UM4lxEWaqVi81ZnoTesIwLNj0v2S0yq3vj2Duclm5e8IxfGzBx2dKIBiHf0ssjpuNJsZ/O24JHgUmS/6ze/YDC5N9wwi2wcd2GwScrdG/eQGXPvrVW+cKC2pfOPqLeNJk9QdFI/cxw=;
 7:EaZj+60VbpnHKMNF1Gj6k75OiDAMUjdAIfYoXLFz7g2718CcO8MqqZ6LAOP40HQXKT843rcSBC+2ICcDk8I2WOsv99PfDkmG+7aS2S85nQuumMBD2dqpyyRWmXOy2S70VG+F7CuamBUh84hLu1EXvQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9833e4b4-3c56-4c19-77ee-08d66c6d8710
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4644; 
x-ms-traffictypediagnostic: AM0PR04MB4644:
x-microsoft-antispam-prvs: <AM0PR04MB464472B051D535AF6FEA281F80B70@AM0PR04MB4644.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220051)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4644; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4644; 
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(189003)(13464003)(199004)(76176011)(99286004)(7696005)(26005)(186003)(102836004)(14454004)(6506007)(446003)(256004)(44832011)(11346002)(71190400001)(6436002)(106356001)(66066001)(6116002)(105586002)(476003)(486006)(71200400001)(3846002)(229853002)(25786009)(4326008)(39060400002)(6246003)(305945005)(33656002)(5660300001)(74316002)(54906003)(2906002)(55016002)(53936002)(9686003)(7416002)(316002)(110136005)(2501003)(478600001)(68736007)(8676002)(8936002)(86362001)(7736002)(81166006)(81156014)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4644;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5vy1u3Il5AkIg+BhBwn9ifDHCK4/XoM/J/ZOeeoZcUy+x37RpKmDH1Hgbz0MFHf1luXThYtUajZH/TNQXR6iP1qXLhz2AsOm8XOX+NSntYvPu3N6zIbAQcJDA3qWSpyWPR7Y/H/YIvVw1LodDHI8UF4ExcLaV3Xhb+nSm+n/XvqMbgsXBoRgPSfloDKAHrArL9ZCnFe9/eWiZpURTLG/ft6P4VkFthbH3ohWP7I4YQiJXgLnyO3A6WJNsszzOMX8lH0BZYMZVhtysUbzmk7s4yoxCS1SC/JPgSQFM25ceD/ek8P/0o0misefFtra0JAA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9833e4b4-3c56-4c19-77ee-08d66c6d8710
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 02:38:19.1471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4644
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_183834_358255_5EF9DCF0 
X-CRM114-Status: GOOD (  14.00  )
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sorry, missed DT guys.

Hi Rob & Ulf,

Would you help review this patch series?

Regards
Dong Aisheng

> -----Original Message-----
> From: Aisheng Dong
> Sent: Wednesday, December 19, 2018 12:01 AM
> 
> SCU power domain can be used in the same way by IMX8QXP and IMX8QM
> SoCs.
> Let's add a "fsl,scu-pd" fallback compatible string to allow other SoCs to reuse
> the common part.
> 
> Dong Aisheng (3):
>   dt-bindings: fsl: scu: add fallback compatible string for power domain
>   dt-bindings: fsl: scu: add imx8qm scu power domain support
>   firmware: imx: scu-pd: add fallback compatible string support
> 
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 8 ++++++--
>  drivers/firmware/imx/scu-pd.c                               | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
