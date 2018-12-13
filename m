Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B496EC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:51:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DE62086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TVN9QDF8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vzydl2eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DE62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EzuD4671ew8bzfFF6neFvhl6ZpITg+2nuy1WU860fQY=; b=TVN9QDF8lu8FwO
	RJUSLVTgEcjGyJsNDjf9+/7N2U8iMI67Wig7T2+CFVHhB/54kTtnr93pBkWSwQYpcA8DEkcAeNwiX
	OJoHu7muOym45FEbKFuVhMRhQT7Fb1EYOj4uvRNZKR28pTZh3523M0ZdOVSCV8wyuwVYnqj8MVmU0
	6YuDa4qde5P2ePKoj3h6kHdxx7hQOV967Fg/3gLurNLxBRVvtqY4w4ImcvGD8sHh43sOsf0LD/mPt
	e0j/JV0eFDpOqnk10U7cTb455vh6d6mw06Qc7++/YOuNtvOsllWuw+2atsuVXcum0vJUpOOfOLsSp
	1athI8SuC0tbtujb3+cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUD1-00050Q-Tw; Thu, 13 Dec 2018 16:51:35 +0000
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUCx-0004vX-VN
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:51:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4T7eatUFSR14mBcKey4DbkBntTsT4T7+k6Jp6eJyYA=;
 b=vzydl2euznx90LqwzBQfCU4/p21wpLCseGXLQ/fxY92mvKjRKUjNtCxufRZu+vHPB56yvD5iRXYieaCy6Duk5ADYxSs9X5q5Fv8CP8eXLCXHla++OYDKGjU7l6i22tEgsImjfxSPmdLP2QRqa8t94J9A3/meTw/1JHW2DxY8zEE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 13 Dec 2018 16:51:18 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 16:51:18 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Daniel Baluta <daniel.baluta@gmail.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
Thread-Topic: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
Thread-Index: AQHUkv9IB3KEsUBSeEGaC3/cu+N6C6V82jQAgAAGgnA=
Date: Thu, 13 Dec 2018 16:51:18 +0000
Message-ID: <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
 <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com>
In-Reply-To: <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4211;
 6:YMvk2NqV85Gh3HRWXY6hYrB2azIiUwWsII77DQec2RaAAEu1XXtExitUn5hThmoeERA8i8+KqaGOzNf36N7GkjrzUkta2LjutV5ckzexye9A6smWJYIxvVhk7yS1+UD0vimM9Ci4KUhy6DGtLIZKevNrZhRRSQ/kvfoUVxT9mqRKaitwPaViRpogRTsPoA44xWJqljs7PbVrKJo0vxepvFvv5Gee+M+YdKwAS1pMchZnsq2Sooz+dWNQTq4iQZ53AYqQp+NttOp4uWXLC+0F9pLlBUaPQVBBn5q0+82oVX58s57qkh9GwAAL6j/lchReI7TwqXxHEJzmPXjL0ALhJKON8Kw6dXknu+/2sLfTy/nDDSd1WvjDggwr563DMiOpfKOpYc1t+joi2uGHJyMP7A2JtMiSd7i+MsfHa/PUIElBjq7ZO3bxs8taQbtUGHw4vQzo+z/WSiL+5a/eeTtRKA==;
 5:ued2tpnYr/OvZZ2z5r0PYg42ngJOP2iPToT1dDZKTWSQmfTC5ekuBtu1frGfPH0ymd9Ca4xkuzZ5reKjOJ8nN5Rn6WIibTsNI+vsbvQ95OIVL7gBK5ts2czaTUGjkk+zr4ETdSCcmu5HDu88xHnO/Bvvgni3I8Wfrut0GoMTdJI=;
 7:1YQ0Z3SCvm/wbgd4C1c7kE85h2vFyw7VRfkebAmBWf2E9jObQ35xfrlkrpwCPKTk7wVpB1yJxYLongjYm3kj2NtrOjMnO2tarj35D4UiZzAt50E+cjtEaMBTQaswdoutgPyWguHsDEMjUbsbzFYLAA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6dba0fd2-cf4f-4d83-f0ad-08d6611b33ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4211; 
x-ms-traffictypediagnostic: AM0PR04MB4211:
x-microsoft-antispam-prvs: <AM0PR04MB421121CD6AA64D877318E4A180A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4211; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4211; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(52314003)(189003)(199004)(7736002)(476003)(11346002)(25786009)(71190400001)(486006)(44832011)(229853002)(68736007)(305945005)(446003)(33656002)(5660300001)(81166006)(2906002)(6636002)(6506007)(66066001)(71200400001)(8676002)(478600001)(6436002)(14454004)(81156014)(186003)(4326008)(26005)(102836004)(6116002)(3846002)(105586002)(97736004)(106356001)(8936002)(53936002)(7696005)(9686003)(74316002)(256004)(54906003)(76176011)(86362001)(99286004)(39060400002)(55016002)(110136005)(6246003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4211;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L1zSdBE1ymq2nbX6BHtmQXiQtyPA+8aNoo0J0AMTJtShuCixre1ZCpMz5B0cubawr159hRXpcWpQ8fatVl96o3P+4WqPsXojSw8pTfa5MWJHP7j84eL5tYK9yCMyjDzRIz2gsdd9LD+GZWHd9th9Hu4W6nTsBd0Wrkaqv1UiyPiuwNLfodobLKRFzGGvv9uzYrQIdezZJ52UaFgveCynAHyJQfh6WoR1O79o6sMn39E5IXq4VAIlxt7PZ9OqG6p7xtyO0xn4H+6LJD4PVHzTd5bVohJF5l0BLyJhIEB34HkTmsCdr3xBSXDFlTDRgXQB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dba0fd2-cf4f-4d83-f0ad-08d6611b33ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 16:51:18.2395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_085132_015856_465EDE47 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "olof@lixom.net" <olof@lixom.net>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[...]

> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
> >  obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
> >  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
> >  obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> > -obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
> >  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> > +
> > +obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
> 
> Nit: Do we want to keep CONFIG_ sorted?

IMHO It might be okay to make MX8 (ARM64) a new group to start
To get a clear separation. (Slightly not sorted due to VF610)
Anyway, it leaves to Stephen to make the judge.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
