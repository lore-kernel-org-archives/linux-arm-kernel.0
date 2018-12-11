Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D9DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:22:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217B4204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F0Mre114";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wwe06DGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217B4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nLDVnfHjk9CV16w5+T7tREhUqm9VgK5TpSVjeUiNA3w=; b=F0Mre114nBnsgx
	VI8ct2QHrWPCmAIvC1JJDC61GqKVZk3iRbcDj/WjlIEWHybVj7vVagWXPAQZBnrriLBAzaSSkJw3I
	LRGrumckYIlnI3ucK1MH2icfZ5SKv0E4HBG0Vyh5z+GgzjDankcjtHjycwUopQbeDTA7moiMXZm6V
	f9nQJrakFp98bTdGCJa2l+cpb7hlwWyBMRQNKHcEHOPlEhtyEPR+hzvh+oBAlqawdJ0rRX5G0ZCsd
	gSFuZMHNhCDVvC1+O7Gm2XEiHsSWDCuj26a4WEiUNSE+uZYAYBap3l6sWEVOBBCN5w2qngpm5zchb
	CRw6WPQDK8dQTIjPHJ4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjrM-00075x-Tn; Tue, 11 Dec 2018 15:22:08 +0000
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjrH-00073S-Rp
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo2kYiEAhgEfYgKT0zpYtzOhj7UQnLL7jE9cpYZa0YY=;
 b=wwe06DGdCxzVlXhflZAVyz/MLn4QkBbRdfQxfd5L3ZE+H4lUArkAOT4X2UGb3mZeOypZNqnezdxioP96ULMbLRetC5aTvwJuRJUgmXARN1NMwGmCk1z9Spw03MMFWoB4MfMfTlRsoAG6j/N4SlRrTSACyQZXpUczCV8+795Oml8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5234.eurprd04.prod.outlook.com (20.177.42.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 15:21:49 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:21:48 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "sboyd@kernel.org" <sboyd@kernel.org>
Subject: RE: [PATCH V10 0/7] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V10 0/7] clk: imx: add imx8qxp clock support
Thread-Index: AQHUkWQIbRNxBwjK40+nBfx8zhf5nKV5psHw
Date: Tue, 11 Dec 2018 15:21:48 +0000
Message-ID: <AM0PR04MB42118633A444FE26E32DF1B980A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544540867-6342-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1544540867-6342-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5234;
 6:k5gTe+3A6J2+vAUJHjgOo1ZlhcCStsMHUaBWP3lekKh+rZY3+nQQsRG6Zs5awk2bv2c2I/bbGB4CL6r5mcuwG9M2b2mGUvsRbJYdUeIUotnOzEznUuXwdo9pEqpwZCzkA4VAI3J/jvvUJ6IZ6YE2Aq8zEshviOPD4BBa/WXyRg+OYCTcmSlBwpUjWhvpvpYF/P/bCQ1xKipXraAvoRxztVwLW7nyGjDOyQpJsuQgxTHpP97d0LIZF0l0Yz+aA0j6G5ACoiEXY4SFMLDo7mgSCyyweGmpura8XNeQCmBGri+LbBCIqJYz5bzzs7b+sk9jaAYJr0D2/LJGVprpq7+gUchEywgV38mATBrqyPE1HnsgJoBxGLgPXlkLxLGaxib7h/6z7YpBy2AwhGrXBfmmuUcSSjoBLcukAAeGf+3ARm6fdoPr+U74/P+vdaAZzTOx7B+LvuYizqe6UsW1q+h1zQ==;
 5:6S7FYqdbrZSDdpMcAs9BCKPvRIozgQ9Wc++thrQIlBkiR610ReSKqCbzMXjZbdEl8yTCTz9pldWRS0n6pt9/UJ+1dyN4Q3OCwr5xtbJAU+dx9bVvBTQlnNbZ7W819U8M6QhhX0gcu+b2l5X5pPVBzZDZlMA8IPEw68UDIDbjp4Y=;
 7:pSLmSr9pr4DHmuK6zWh/5NlKkYsywuGkT+r4impllOYYkFXGmynYEV2RK+VjER4xc4DPJBIPVi4MKBvDizlR80Z6can4L6gpD69MgkoMbmLy9sAHtIKFtkw0cQ36v6I5dfhd6s/7/TvJRUgtn7w+AA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 367ec721-a246-412b-f2f8-08d65f7c5ebd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5234; 
x-ms-traffictypediagnostic: AM0PR04MB5234:
x-microsoft-antispam-prvs: <AM0PR04MB5234753E319141A2706A814380A60@AM0PR04MB5234.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201703061421075)(201703161042150)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6042181)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5234; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5234; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(189003)(199004)(13464003)(54534003)(26005)(74316002)(105586002)(4326008)(68736007)(5660300001)(66066001)(33656002)(305945005)(186003)(71200400001)(102836004)(71190400001)(7736002)(76176011)(2501003)(53546011)(6506007)(256004)(229853002)(14444005)(7696005)(6436002)(3846002)(11346002)(6116002)(54906003)(486006)(5640700003)(8676002)(55016002)(476003)(498600001)(446003)(9686003)(2351001)(81166006)(81156014)(2906002)(53936002)(1730700003)(106356001)(6916009)(99286004)(44832011)(6246003)(86362001)(8936002)(97736004)(14454004)(25786009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5234;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CUBdLxlBwRfR0fdKPpTBXeaaMV2aesb1dfrpb3i09eTYJkB7rTHLWDdeIU9fIuJ3q6zTmoFfrO+iErsp4HMBXBtCutDrYzwYzUDWP+UxiVAtdgO3kOMzzpymPUdu4rpxQztWxn8BmJWqmkCHrAnQ9z0g7W/M6xIhvjk8WcuiNSt9Q/62y3nphsQWWwQtWLDuKrVfdpXX8UQYjpX1LY3ffm20wg1kyHNWPIV8RQXhTbFPVD7OS9gv8+6ZNNTTo4H83eSToDNwYiSM9p5LNWoi9Axnq3qpFO+ibVUrggxzNrqaOu3vXUr0vo40hvn3D8Va
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367ec721-a246-412b-f2f8-08d65f7c5ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:21:48.8493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5234
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_072204_016155_294F6DD3 
X-CRM114-Status: GOOD (  23.84  )
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
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

This series is made against clk-next.
Due to newly added clk-imx7ulp and clk-imx8mq in clk-next,
you may meet apply failure if apply against clk-master branch.

So If you need me to re-generate a patch series against clk-master,
Please let me know. But that may still get an error when merger the
Series Into clk-next, I guess.

Regards
Dong Aisheng

> -----Original Message-----
> From: Aisheng Dong
> Sent: Tuesday, December 11, 2018 11:13 PM
> To: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; sboyd@kernel.org;
> mturquette@baylibre.com; shawnguo@kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; Aisheng Dong <aisheng.dong@nxp.com>
> Subject: [PATCH V10 0/7] clk: imx: add imx8qxp clock support
> 
> This patch series adds i.MX8QXP clock support which is based on the clock
> service provided by SCU firmware.
> 
> Note: It depends on SCU driver which has already been merged by Shawn.
> So this patch series could go through Shawn's tree as well.
> 
> ChangeLog:
> v9->v10:
>  * a small clean up of PATCH 2
>    remove ccm_ipc_handle from headfile as no other users need it now
>    and move imx_clk_scu_init() implementation into driver accordingly.
>  * a typo fix of Patch 10
> v8->v9:
>  * add __le32 and __le16 for SCU message structure members as it's little
> endian
>  * use readl_relaxed() as it does not need insert barrier
>  * a small code logic improvement suggested by Stephen
> v7->v8:
>  * add more kernel doc for lpcg and scu clock structures
>  * remove one unneccessry reg checking
> v6->v7:
>  * use struct_size()
>  * remove MODULE_ macros
>  * add more kernel docs/code comments
>  * other small improvements
>  * update reviewed-by tags
>  * add the missing PATCH 1 in V6
> v5->v6:
>  * simply the driver a lot by re-orgnizing the driver into a few clock types:
>    scu clock (merge scu divider/gate/mux) and scu gpr lock which accessing is
>    through SCU protocol and LPCG clock which is directly accessible by CPU.
>  * LPCG clock is separate from SCU clock, gpr clock is still not used
>    and will be added later.
>  * remove old year license as the code is totally rewritten
>  * scu mux support will be added later as it's also still not used.
> v4->v5:
>  Address all Stephen and Sascha's review comments, see details in each patch
> v3->v4:
>  * scu headfile path update
>  * no functionality change
> v2->v3:
>  * structures/enums name update with imx_sc prefix
>  * no functionality change
> v1->v2:
>  * structure and enums name update
>  * api usage update due to api change
>  * no functionality change
> 
> Dong Aisheng (7):
>   clk: imx: add configuration option for mmio clks
>   clk: imx: add scu clock common part
>   dt-bindings: clock: imx8qxp: add SCU clock IDs
>   clk: imx: add imx8qxp clk driver
>   dt-bindings: clock: add imx8qxp lpcg clock binding
>   clk: imx: add lpcg clock support
>   clk: imx: add imx8qxp lpcg driver
> 
>  .../devicetree/bindings/clock/imx8qxp-lpcg.txt     |  51 ++++
>  arch/arm/mach-imx/Kconfig                          |  11 +
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/imx/Kconfig                            |   9 +
>  drivers/clk/imx/Makefile                           |   8 +-
>  drivers/clk/imx/clk-imx8qxp-lpcg.c                 | 216
> +++++++++++++++
>  drivers/clk/imx/clk-imx8qxp-lpcg.h                 | 102 ++++++++
>  drivers/clk/imx/clk-imx8qxp.c                      | 153 +++++++++++
>  drivers/clk/imx/clk-lpcg-scu.c                     | 114 ++++++++
>  drivers/clk/imx/clk-scu.c                          | 270
> +++++++++++++++++++
>  drivers/clk/imx/clk-scu.h                          |  18 ++
>  include/dt-bindings/clock/imx8qxp-clock.h          | 289
> +++++++++++++++++++++
>  12 files changed, 1241 insertions(+), 1 deletion(-)  create mode 100644
> Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
>  create mode 100644 drivers/clk/imx/Kconfig  create mode 100644
> drivers/clk/imx/clk-imx8qxp-lpcg.c
>  create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.h
>  create mode 100644 drivers/clk/imx/clk-imx8qxp.c  create mode 100644
> drivers/clk/imx/clk-lpcg-scu.c  create mode 100644 drivers/clk/imx/clk-scu.c
> create mode 100644 drivers/clk/imx/clk-scu.h  create mode 100644
> include/dt-bindings/clock/imx8qxp-clock.h
> 
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
