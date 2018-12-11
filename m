Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE660C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:05:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689DC20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qZ/jRoZH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vvyAcbHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689DC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4LXTxoj++GyhPL1GWKEh7TZzyMfZkIQlHoLN8wYM9NE=; b=qZ/jRoZH/W4dnx
	it9leqZs/+WmCwZnZq+tYTrFlQXocSYi9aLO96ioSMUjvb4yn+TX6v124GIopWSqW5yyqgvnW3aVs
	V89rlXLrjqjzTBaepFiVvxYwBg67chjfAYgu7Hn96a8lXcYSPesm4+aBkzLTmCxKVHdH7GTvEDvFh
	J2zAAEE98gvPOtcuo1a+hGssl1hqzlYSYfsO4+u964g4pH3lZ3i+Eh+vzb3V0dFRbiyuGAEptDvIL
	Ipn7mQ5Q4xVnctDUKuLFktsxqUnlFr+ZTNZTrvzVnYmBwaKbEqq1dqCEEWsDjkc9AtTWcqp9OE0jw
	h73v2rJL+envfbYt5KPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWXQ2-0006bC-D6; Tue, 11 Dec 2018 02:05:06 +0000
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWXPz-0005v0-00
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 02:05:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NP/ig3z3V7G8T649dnwUQik3nUaCGn+1C4sVlZD0z8=;
 b=vvyAcbHtYtmagPbdhJQz5Y/ksQOBiJX+7z2IScUEKB81qckejPa+1BF7HYFyVuI7XkWWZzwpWJyaPrZniuOMcnSGB2YBIBg8f0BKmXoVEPmBgYTPvNCpp4auaUklyancphkTV5cPAuqz797Hiiu3Gi5+18X8cdARn2crtGjUSpE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4372.eurprd04.prod.outlook.com (52.135.148.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Tue, 11 Dec 2018 02:04:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 02:04:48 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V9 0/7] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V9 0/7] clk: imx: add imx8qxp clock support
Thread-Index: AQHUi98jvykrnvKQL0Kg33biwal6j6V4eymAgABSdPA=
Date: Tue, 11 Dec 2018 02:04:48 +0000
Message-ID: <AM0PR04MB42115172881537E930C3D22180A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <154447480107.17204.18337865638259063687@swboyd.mtv.corp.google.com>
In-Reply-To: <154447480107.17204.18337865638259063687@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4372;
 6:BRGOh39Apofx2B6hf4quyAfFWJQGFxJigrToAcQGXRiTVJCIGyyQyp/amlDddejTCTM/8rc8C1mC3//+Jr6kCtiEPm1SVTF5A1sCMAfTgcUqy9DMy4Dk54IrnxD1i9FriY4YCRz7n1xRbVn0lCiaY4Zh1Nsrv5m4ctQyw6OC/UGXIGOjFiJaIQ247x9yKBZ9tKfmQdJRWamMxWDi0D12+1FhKtO6I53jWZXO3qUB0gYU6nK/u4fg0eq+CakzArK5yfhiZDByNYi+pgi5ovYCjIpJRP8Axxw5bStF6nak2bgjrAnNR1HaoUUxEhTz3fgFwsF8El/lXsHJpviCdguzG2Naz8avAS3jso31caehKmrf6Ede8DsBUSQE6G1rL5s/Kx1infnUJgtbRXtOf3GgSUsJeRowKcrAopBAjYBK7/qF28TNQvM4HK0gGR9S3Ew1DJRty/gtOi9r+Ms3vTFmOA==;
 5:UGmoGamqadSATn5i3DKpNOE7r57252Izo7rfDR2WSvqrNxSf2xqzLblSG65MiyZoDzem6P97tRum8x4N3DoGH2/naQxdh5l1RWUydDvmEzr9NxlFFgHNIZy5a/ugh1UltSBgnXk894/yH7YvV4ytRLAkwzjbnxHg3/TT1trv9Fk=;
 7:SEdMKvp5bnoy2btGjNAyN7ZxXKzuxhhdv/VwHDOM71zdN2ZVoXmWKOjuaRUlabO1fRrfmHGuM7Tyv09zNhkTINnvX35wkNF3OIAkFcyTiZL91loNymGsk4T80iExbzEmNbzB6RWk6pFR3iZv1+yXRQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 85ef7c1b-2336-4587-0903-08d65f0d0768
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4372; 
x-ms-traffictypediagnostic: AM0PR04MB4372:
x-microsoft-antispam-prvs: <AM0PR04MB43722B89C737929CB533F63680A60@AM0PR04MB4372.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4372; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4372; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(376002)(396003)(346002)(39860400002)(13464003)(189003)(199004)(68736007)(186003)(55016002)(25786009)(106356001)(9686003)(66066001)(478600001)(53936002)(97736004)(102836004)(6506007)(26005)(2501003)(53546011)(105586002)(76176011)(7696005)(99286004)(305945005)(6246003)(54906003)(74316002)(4326008)(5660300001)(256004)(86362001)(81156014)(81166006)(316002)(8936002)(8676002)(3846002)(110136005)(7736002)(14454004)(6436002)(6116002)(71190400001)(71200400001)(33656002)(229853002)(476003)(446003)(486006)(44832011)(2906002)(11346002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4372;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 75A5Hr5jgZn0w8V6sCfc9VI7UEiLPNCfHSCcLURfqu2lSNw7BhFpZgkXolkAmkoNSARQ29n0ViEjfFzYi4TRLzGBMKzONwVIJApAByv8Grmq1yboUC8zPYweOteyjbMrCQNlaszdvFdtu6OsME8SChZtyPxEqALLhx6bKo045prYPi3UI8D4aOeiGPPVwc1nI0ACuB0mD81mqruAgaSbHQpC0i9JO/BlKI5pJSTVKUi4BYkSIvbQqGd+bMKF74ZNQzaFfNl79YuqCdeYsjQ/j4dQzVNGwqQnSiXGCO+rn2s2JG36BEnAS4oYXUWuqK11
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ef7c1b-2336-4587-0903-08d65f0d0768
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 02:04:48.2355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4372
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_180503_050041_13A22CBB 
X-CRM114-Status: GOOD (  17.08  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Tuesday, December 11, 2018 4:47 AM
> To: linux-clk@vger.kernel.org; Aisheng Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> shawnguo@kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de; Aisheng Dong
> <aisheng.dong@nxp.com>
> Subject: Re: [PATCH V9 0/7] clk: imx: add imx8qxp clock support
> 
> Quoting Aisheng DONG (2018-12-04 06:39:18)
> > This patch series adds i.MX8QXP clock support which is based on the
> > clock service provided by SCU firmware.
> >
> > Note: It depends on SCU driver which has already been merged by Shawn.
> > So this patch series could go through Shawn's tree as well.
> 
> Which patch series?
> 
> I'm having trouble applying the first patch, so I suspect something is wrong.

Which branch would you like me to make the patch against?
I made the patch against clk-next branch and just re-tested it was ok.

BTW, it depends on the following SCU firmware patch which already in 4.20-RC
In your tree. So it's safe to apply.

commit edbee095fafb4b727b51032bdc41e345f95bbc20
Author: Dong Aisheng <aisheng.dong@nxp.com>
Date:   Sun Oct 7 21:04:42 2018 +0800

    firmware: imx: add SCU firmware driver support

    The System Controller Firmware (SCFW) is a low-level system function
    which runs on a dedicated Cortex-M core to provide power, clock, and
    resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
    (QM, QP), and i.MX8QX (QXP, DX).

    This patch implements the SCU firmware IPC function and the common
    message sending API sc_call_rpc.

    Cc: Shawn Guo <shawnguo@kernel.org>
    Cc: Fabio Estevam <fabio.estevam@nxp.com>
    Cc: Jassi Brar <jassisinghbrar@gmail.com>
    Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
    Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
