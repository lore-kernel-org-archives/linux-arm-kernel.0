Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7367C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:19:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CD5217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JzGPJEQd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XhkFyKKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CD5217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i6mNzkAMuFH7kfskou3Lz4P4UmP8jkaqhaCwKul3csU=; b=JzGPJEQd/nCFOD
	/Dl8RzgSK3paXJ6wWteDWKJidAeukwKpipFvcUvkIrbdIlqkGLtIPWZgLMF4YzUXJp57rqGFI3nt6
	ANZhpg2BpbT+bFwl88lfWtJiMML43iyIbBWFRfOboBv7vpNzccPDAI1KcymXCptbVQqKfWOfuHtpw
	WHT8QKE5BoL5WMW8x2fPXHetWLvLFzyIBTqx9eeE2XDDip8kVXzmIhsoYQ/7t02YBQobhF03aOr1P
	50nt0nyrJxw40R+uE73pqu+tDClifx1h70cntxysdImwTFxn8Axq65F6Af7dnUxSPL6kTBCQOiyff
	nCWaQs8+uH1df9bOrRew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDku-0006SG-Qo; Wed, 23 Jan 2019 08:19:28 +0000
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDkr-0006Rn-QO
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6L/gqiRqpDsvYgqkfWzUGpkyNu/NgB6Hq2WTB5qyqQ=;
 b=XhkFyKKjRnMY9gPBT2/lzfVkLAHYx77YZhntX2vmwJy0Fvmi7tY3akRLUq+B9j9l+G7+Yni5WJNdNgnZM+XupV5O+tLWu5vZt4+zkcWR+mwKBjpqYwwHAwHf0YnlWoV42PnaRMrVqIr4CICTMIFm9NRrLkP8kyZmCvcz4hjhaR4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5459.eurprd04.prod.outlook.com (20.178.115.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 08:19:22 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 08:19:22 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Stephen Boyd
 <sboyd@codeaurora.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH V2 0/5] dt-binding: clk: prepare for imx8qm clock support
Thread-Topic: [PATCH V2 0/5] dt-binding: clk: prepare for imx8qm clock support
Thread-Index: AQHUsvP3nb0OibsUXkSix73UA+4SKqW8giZQ
Date: Wed, 23 Jan 2019 08:19:22 +0000
Message-ID: <AM0PR04MB421169B58FFD6FD5B17D015080990@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1548231044-4344-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548231044-4344-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5459;
 6:raSkNpNIzgzaBCUHmzndqZNVZn6giORObBsuXJKnG2RuBFbNYfUt3vV+kRK7NCC4w9ohQ3O4GHzfNTjZWqoSf7roTGIWi2kZaGrMgi+iEu0hIvxEc0/9UrZRUV6uRxeAv5/kelCndxYFiGt06zHhhbfVXiYOZQytJ2mjOkXAXYQwmiaYKfwMzHv4/fuudatCGN5MPpYwbdPk2iYBjSJISGsGqhW3/Eu4+7VrxOm56iMy8/bky0YD/9iA6I5VcnF6jr+BCKB+msCl5l0dh3O2A2atNOcqT6YVRz4zS8T85X+CmjkeT7ASSZRxTttAwV8m7y/tN89RHKxfXZsTJiVKCSk79urAA5BscFS7KtSSBMAU1gbVXWq6qLjLyP3KJiWja9qknDQQBUxFGNNwxEGL/5q7L8klugV5RL47RAPGnmky0C5h5UGjCQpwIFm9mJAn2JjGy39bxj3++HEX4HJTUA==;
 5:73qBvBfF8Vstn3kiq4cQzLtLC5A/go7/r9oXe+VKCarUfNsKBDXlm/fLCosnguvSLzkhRpE61fj9Ra+suvpx2SLN//i7Y4x+LhMiof6DLuzKvFSUGLUZZSkVbaAeJqPHsgd7Dgyr+H1lEUiUrLd6nzeaX1Jsle7I4irHrMZMvCo/6hE9d03dpErsEHu+rURjZJnyuKTJ8h91k3UbmYUqEw==;
 7:uhB+QMb3GJFNdbjpzBiCTia0/xe/uSJioymjC/E8wxMzMozZhJ5DMMmMruORH68ZFY0L0LeTqN+whtOn48prXHibwfvvOVtbO2j/nPtZbyYWd0dq+z3lq2uiyJIBsaeaOd5wMVaeRE8USZyaQETxPA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 55858641-82d3-47f8-6b90-08d6810b7abe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5459; 
x-ms-traffictypediagnostic: AM0PR04MB5459:
x-microsoft-antispam-prvs: <AM0PR04MB5459BE737D661D5B0C37BC7880990@AM0PR04MB5459.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(8936002)(2906002)(66066001)(81156014)(55016002)(6246003)(25786009)(97736004)(33656002)(14454004)(316002)(74316002)(54906003)(44832011)(81166006)(478600001)(4326008)(110136005)(68736007)(99286004)(229853002)(76176011)(26005)(6436002)(86362001)(7736002)(2501003)(6506007)(7696005)(102836004)(53546011)(305945005)(106356001)(486006)(186003)(6116002)(256004)(14444005)(53936002)(9686003)(3846002)(11346002)(476003)(71200400001)(71190400001)(446003)(8676002)(105586002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5459;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lVgopSs8aoE8lqfjaB0JylnbLXv6Eh7onUFnAZm+hYMjKotV676zSvlbpNF6tOlY5dbiJf7G5SVgD/2FHg8Ds88U6Hlix1cPVD1L8AXxaLSCA2awmfcvAIM57rGVeXw8Jtcs2TD0J9dBctUaTPk4p7vr4gfWSYjglSJA6meYFriZ35CDeKMavCJhXQZ0d3gtk1gsWbqapDgHKpLGbdz+88YKwsWj+Zl9RT64X5i2a368wChv6eS8I3/bdJidColCgCrQs4ep8fxf7m5pkEGy+91BI2xcwYnSdBzyjPi1onaUcESqHI6omN0rGbrB7ITqAceE3Qi5kFKgF+x9ZXKQ4kuZ3Qtx/gmiGZV/G49uvH3wX2SBvNgDTolJDKIzN+Xi6sSR63r2HUZf2Ztp7LJNXzHghuGurIp44xPNc/fRuPE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55858641-82d3-47f8-6b90-08d6810b7abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:19:22.2206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5459
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_001925_854461_81EF29D0 
X-CRM114-Status: GOOD (  14.52  )
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
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Aisheng Dong
> Sent: Wednesday, January 23, 2019 4:17 PM
> Subject: [PATCH V2 0/5] dt-binding: clk: prepare for imx8qm clock support
> 
> After a bit more investigation on IMX8QM, it seemed SCU clock can be used in
> a similar way as IMX8QXP. So update the binding and driver to be a bit generic
> for easily extension of IMX8QM support later.
> 
> Dong Aisheng (5):
>   dt-bindings: fsl: scu: add fallback compatible string for clock
>   dt-bindings: fsl: scu: add imx8qm scu clock support

Hi Shawn,
Would you pick the first two patches for scu binding doc?

Rob & Stephen,
Please help review the left ones.

Regards
Dong Aisheng

>   dt-bindings: clock: update CPU clock ID name
>   dt-bindings: imx8-clock: add a53 and a72 clock id
>   clk: imx: scu: add fallback compatible string support
> 
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 7 +++++--
>  drivers/clk/imx/clk-imx8qxp.c                               | 1 +
>  include/dt-bindings/clock/imx8-clock.h                      | 8 +++++---
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
