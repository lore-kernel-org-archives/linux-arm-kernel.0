Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:45:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0504820818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kbsLnkmM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AQcovUQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0504820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C0dj/ctRGUNCJkP+T5gzWp1Sia2ovBB5DjTYHmPFfyY=; b=kbsLnkmMztjs+9
	fWHKaNQxlLS8qQxRIy/R4Pj7RXuIDL4ICi3ZXUfeibReOMVmMGNQaeKNw2pQ9g01jM/Nwujx9p/nk
	YT+pnmDqnlVbc3Y8z/vJiswFwkHrZnR54KYJQl5KaISdfq34pflawVRNtvY+XBWhKT6R15DadaoUe
	daYQZ9wHqxazRsFpipdkAgaImZ6U08x/aP6/tzf4PGr7LXFMmD3sG/p35GgRXBAeTRavKJ/Aq67i6
	AIdnPttOYthBjHbZrh2itgjRMWcdz3kAcvFPhWymIqBfRqbJZTb8yYjE9sFCrMbjlw/2b24t9mh+p
	kkUarMlEi86bDbrJ28YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwMZT-0004hY-4b; Wed, 20 Feb 2019 07:45:35 +0000
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMZO-0004hD-Lu
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 07:45:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhp6BC4kWL75DCzXSYr1EsmYZsAfyq4F9PrXVO8yY7U=;
 b=AQcovUQ1BqrGOHcrPdxH3WQthebglMJnz5Lj8IsLkpbT9Nw2rNbuXxdUh5AKiCptSZO8jQSnoCMGqJKtPLLhb4kzA7dEEoVrS3MZdoRE0tJ8fwvEXkqmzz+CUO3vDhKZFTMyBjnnf34AwRgzxhpua3EKeBs0LzoZhyrrrhCamSk=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB4070.eurprd04.prod.outlook.com (52.135.163.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 07:45:27 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 07:45:27 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Anson Huang <anson.huang@nxp.com>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org"
 <daniel.lezcano@linaro.org>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, Andy Gross
 <andy.gross@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "arnd@arndb.de"
 <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V7 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V7 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUyOj9eEW+Gy1rWUqASm4hcJoqZKXoTK+Q
Date: Wed, 20 Feb 2019 07:45:27 +0000
Message-ID: <AM6PR04MB42152F3A2F9C6E6D8CF3D0DA807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d9cf3da-cb81-45f2-25b5-08d69707614e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4070; 
x-ms-traffictypediagnostic: AM6PR04MB4070:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM6PR04MB4070;
 23:pWT/8VZaEDCJME+bl29EXhf1uOLI9evKvAvgcGEBi?=
 =?us-ascii?Q?Ct+wQRsQ77hACG2v3yiwFZqAdkd4QynTWn4XhWxQW/0TbkZpntd9+0Q/B2cd?=
 =?us-ascii?Q?jQf1UahO5s0Wtw/Hkdc7BCCkhTd2LNm+vYxGwA8Y60KjpdXuwXOoBDmkk4oy?=
 =?us-ascii?Q?Wg24JAcxMcmiK4Q6/YUOlZJsNNvipD+qD/LLU3DXI0PNSguSla1ojTuem4Ig?=
 =?us-ascii?Q?5cbzxyw6QLsmAK2fiu3VpuFiCmJlFpbPSeJTnIa+QtkqSiiPw3C4k2pMsnBU?=
 =?us-ascii?Q?qLWLqofL+QrPGzTfmffpf6pg7XVS8q4SruToJV3P6WNpu7NjBxJNkrW1duiL?=
 =?us-ascii?Q?tVRMWhFJDmo8uwL+PFM8ESWj7v23RDHGvjb3aXyCrlPm4RwbE1wIfXZEZHT/?=
 =?us-ascii?Q?Z7fxduCCtLoiUbYCqlAc/eFjw4J9x1x0Yo17eIbOnB3LZjHtq+gdJh4aOBj9?=
 =?us-ascii?Q?7Xj5pLIw1lLnQJfLOy52mQPrnD7AIO9SwpOSJ92eMJa/0KXXHH6xVo4Y1x4i?=
 =?us-ascii?Q?bkdnlUG9HMWvyn2CrS19Ax2ZZg9TtrPJI5HDCGVMK7G2yTzgTVKGSBhT5inu?=
 =?us-ascii?Q?WOQ9zdKGepRy49hgECO6LZlwmeHSQ8Au5jpgQQOjxGInSdfHVq4GSz5Xsrd5?=
 =?us-ascii?Q?S/T76p8xqHUbX+xTxOGnSv5w3yuu1sFqupN/TgcE+eoUQAAKR8IYqM0Hj2Mw?=
 =?us-ascii?Q?x3XMVrv3FQEp2rm+YFwXnvRseK3tO7TbFiK4ZU8Rfn535l6PTuBdarHnZCqR?=
 =?us-ascii?Q?D1XM3vuJIfRQFT1TBbfAnmtNzwNR3tdr11aN8/tPP3N9wBcQGJvoLc9D+guu?=
 =?us-ascii?Q?vrPX+b1ZFpUjhK8zU57nUDrkhZ/W8y9qHp2IZPR97O62JpSSFSfyK5+zOb9v?=
 =?us-ascii?Q?u1WFD5GnheWmo7fdY3PPtfDTx0zOlvQ8YnPnUrfOke0U1Y/qHyyWM186Os+u?=
 =?us-ascii?Q?Np4TWXSifvDiapXyvi5ZWwNCcSEqjZuArTgKddV+rXVXzSnLDsiI0SpX70hl?=
 =?us-ascii?Q?suftys59pViVDsfAVSaeST1NGDEFfHNOTvF5ygoOffyieHcwsQakco9qAKRL?=
 =?us-ascii?Q?zmtWZzzF31nXAWsz6vM3B+quKA1VYbkOqG3MHGx9XOEsKSnBXEdO7lRJvbc2?=
 =?us-ascii?Q?HlcwlrRjdwcVQFTb6PTE2Pd9AHG+6UdLW0zmFtSJ3mMghrYFwWOKjgBjSv/y?=
 =?us-ascii?Q?rYRk6ydjIkG32C8pABE3jDWjFPlSsp0XyU2bcZWHe1odVzoSo+X0oR5XLIi2?=
 =?us-ascii?Q?EEWhaUfoqUOVvb5qb6+My0aKrFoN8shj07duoCjd6hWScQqsFJkWh7wAUTEF?=
 =?us-ascii?B?QT09?=
x-microsoft-antispam-prvs: <AM6PR04MB407044857EACCD368527AF4E807D0@AM6PR04MB4070.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(6116002)(71190400001)(26005)(3846002)(71200400001)(97736004)(486006)(4326008)(33656002)(8936002)(7696005)(68736007)(81156014)(81166006)(316002)(6246003)(76176011)(44832011)(8676002)(110136005)(66066001)(102836004)(14454004)(2501003)(186003)(478600001)(99286004)(53936002)(25786009)(6436002)(7416002)(229853002)(446003)(2906002)(256004)(11346002)(5660300002)(105586002)(2201001)(9686003)(476003)(74316002)(55016002)(6506007)(86362001)(106356001)(7736002)(305945005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4070;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: foGDJdS4kSuT9/2JK09k7x5B0NeAfBvO9Xdq/MQXB3rpXlNEBKQoenWcjGtg89FnmAdIyj+PNU8IEh4Y5Qf5Q/LGfRbGA2YipvnUwcFvod2mIUjn2NU3C2pyRnh363oIOBGZ3fMQCG5/BcQl9bovwoEHd58fkx6ELkCfVJuGuAmS9XlZ+O9bPBwwlohNf8GEKPlOGPhbZAOYKN4MNQXZIvVIhh0V0ESBpT0GZLd2KFq/DAmXrjzNK+jCa3TBNR1zSwbtqU2EjmHRI8nQa+6HGa11AN60yBuMcRmyYoO0iTjKotb24Zo7SLxCGqiYfgFB++Y0vUwOGwuhl6pY7N1hW95QhhPciP6r7l686PJ2LVyVpQlsf+8d0AAx180POmynrldHTwouuKbQ+ATnO3xWUCBU4oBC+IlYuMPN8Dh6RGo=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9cf3da-cb81-45f2-25b5-08d69707614e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 07:45:27.1279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_234530_781961_E37700D8 
X-CRM114-Status: GOOD (  17.76  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Anson Huang
> Sent: Wednesday, February 20, 2019 2:54 PM
> 
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as system
> controller, the system controller is in charge of system power, clock and
> thermal sensors etc. management, Linux kernel has to communicate with
> system controller via MU (message unit) IPC to get temperature from thermal
> sensors, this patch adds binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since V6:
> 	- put "imx,sensor-resource-id" property in thermal zone nodes.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 27
> ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 72d481c..ad96881 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -122,6 +122,27 @@ RTC bindings based on SCU Message Protocol
> Required properties:
>  - compatible: should be "fsl,imx8qxp-sc-rtc";
> 
> +Thermal bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible : Must be "fsl,imx-sc-thermal";
> +- tsens-num : Total number of thermal sensors supported;

We properly don't need this property if the number of sensor
is fixed on a specific SoC.

> +- #thermal-sensor-cells : Should be 1. See
> +			  Documentation/devicetree/bindings/thermal/thermal.txt
> +			  for a description.
> +
> +Required properties for thermal zone nodes:
> +- imx,sensor-resource-id : This property should be defined in each thermal

After a further looking at it, I wonder this property may not needed either.

> zone
> +			   of thermal-zones node, it passes each thermal zone's
> +			   resource id for thermal driver to get temperature via
> +			   SCU IPC.
> +
> +			   For thermal zone nodes, please refer to below binding
> +			   doc for details:
> +
> +[1] Documentation/devicetree/bindings/thermal/thermal.txt
> +
>  Example (imx8qxp):
>  -------------
>  lsio_mu1: mailbox@5d1c0000 {
> @@ -168,6 +189,12 @@ firmware {
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal";
> +			tsens-num = <1>;
> +			#thermal-sensor-cells = <1>;

This looks may not correct if sensor cells is 1 but the sensor number
Is also 1.
So we probably better remove tsens-num property.

Regards
Dong Aisheng

> +		};
>  	};
>  };
> 
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
