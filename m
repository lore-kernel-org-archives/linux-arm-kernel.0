Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA858C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:28:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A51520643
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ild2MGYs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WB29Z6z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A51520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x9jK1Pb+W9tXkX/tLTvgtUisCeAcjWtATi+1J/gtQxc=; b=Ild2MGYsTVFFTv
	YUHNhRYJVeKIoqUeq7tcp+un/0hcgqmULyz/cWzlXmxRU0Xcg1DhTJMUEyHiVwIB8pd4DEWvjP8x7
	D75n3IdBNNBgt5o7DTPy4JjzNucX4bz9NwyGMxO25dbU5cnDwNaUDJ6vqlhxHgi00FQgusX0FVb1p
	534kAvikJirIO9ntuUwRpr+cuwsgiMhDQckslpdGQ4hWIROxxdKMA2F/zjNRn7NvRvwsjtcdAMON+
	wYxjii2jtBlDQ2nruZ7qIbWQv+5OJFStKJcnCr+qoL1rpZWYy3amYGlhMcQn/CHdeWv7107eUGATh
	a5eHEXv0v6cCclWihbQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdli-0008Hj-B8; Wed, 19 Dec 2018 15:28:18 +0000
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdkq-0007MJ-64
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOcYU43y4yiCnTPvTqme5zkia/wE9q6HOeb86VIpIwo=;
 b=WB29Z6z9hNmypPYzO2iIMrF16I/jZz6pBC9mnbQ1N/iZ9a1KsWFDQU/z+HVdCyhIHj7DJEmPMD2ci6wjy7btb8Ed0qPNBrI3ahe6RZEp2CqnURXryJtnIf/wVeVnoZ7GxpnAq1B8jMGzhslk1+GcJR+QZSadcY+j5VvRFJTi1y0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4081.eurprd04.prod.outlook.com (52.134.125.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 15:27:13 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 15:27:12 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 3/5] clk: imx: scu: add fallback compatible string support
Thread-Topic: [PATCH 3/5] clk: imx: scu: add fallback compatible string support
Thread-Index: AQHUl69Q9oJiMRFpnkyTXJHbjI3ptQ==
Date: Wed, 19 Dec 2018 15:27:12 +0000
Message-ID: <1545232888-9302-4-git-send-email-aisheng.dong@nxp.com>
References: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0070.apcprd03.prod.outlook.com
 (2603:1096:203:52::34) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4081;
 6:H8mZCKJZonpAcR1mB6OyfzDFYIHqvD7q9R6By/wETCM+cZYLf9vIVVgfo/HhIufpR80UdgL7qgfom/KDxa9mQdZFL9mU/hyJiAzq/wYbjFDO5x0mYrnLCvVBQyHFX1lUFFR2Am0ySI35S95IIQ7KkRz7uOW9xtvu6wmNf+3feec6Q+zFraDowZZ8Iej/EzcBqQR1XncpdDBSmSEzGwrJNJfyl0jtmacKNEeQiYWrI6EGrVcBYOE5x9TjOylF148bXaW3idE3yJpCnxetBWCgg20xNVlzs4g7rLK8FUwyreOjvwkYt9NFIlKOwYKb2r3LXFVhb0ssZ+RjPQYjTzgUT0qQRnUXPJ0jwtkTRI5AMNh0YGBpzYY/SdJS8Ap2IW5nKSBAUee1C1By+bn5VLwKMZTmEjnuBZe+wO/xVeeax+K2/28iVYIPGRu+WS3Io8fjx33nBCoUchDHEpNWK4Nxrg==;
 5:XwCAGOvRs6KAy/zZHFFJR6E4X2dl4l2RK2ncjOv6OhJeFWwvGRy9Rp0TFHE3r5YKLaNqDICBOx3/AtNsk/jhcwWJhGloIqE86PXvWNK2nyAWw1b/OlDdl44uEzELfDQzm8lfIg7wUP+IGO5eyjwNegLupdBsmfz1fYzjuAx49mY=;
 7:lfC9Hqxma20cme7RJmTHEQiAVrjbsMWMpAiXjpng/rmlmilQulQbLtXdb97xgJtKKLOHE9d7xbZmWhr9DbtMs3lJz5JCmGIm7imgxM+4+tb+aoUzbSDVPf0IxWHOUAOLsfTbM6O7yVDI2H8VUyCZtA==
x-ms-office365-filtering-correlation-id: 901f96fd-ad2c-4bcc-8026-08d665c672e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4081; 
x-ms-traffictypediagnostic: AM0PR04MB4081:
x-microsoft-antispam-prvs: <AM0PR04MB408139E071791A25D8A35BE580BE0@AM0PR04MB4081.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4081; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4081; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(106356001)(3846002)(53936002)(4326008)(105586002)(2906002)(2351001)(66066001)(6116002)(6512007)(97736004)(2501003)(81156014)(81166006)(14454004)(8936002)(50226002)(86362001)(478600001)(26005)(71190400001)(8676002)(71200400001)(25786009)(6486002)(6436002)(186003)(305945005)(68736007)(7736002)(5640700003)(54906003)(76176011)(102836004)(5660300001)(6916009)(99286004)(316002)(52116002)(446003)(256004)(2616005)(6506007)(486006)(386003)(11346002)(44832011)(36756003)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4081;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uU/rOYGSOJIK1qawp1WX59qCw1uwiQ6WJaB6iCv2m/xlIQNM1QdOONiUSRAH+T8KVrkWxZQ2x79JboTDSXq+mzvjaZI2EamcDPiuBkAcY8aHBBIDLp0rWz+Y4x7x3KX19wMoGHxeS7NL+j2Xb5q5H2CBi++9RiHCgCd2daD43aH4uH16IJ0tc9PO7BrLHDUkAxAiseh9WRHcQiJU6AHDQbqCF/HekR5Pg6J4zS2c8Z7eeJQEkVJ16bGQVqJqCYM/PJVv7euGcNwdkS4OEdNyoWCU07Bajn1JD6+v43edBvwyE4dki5hox/N5vGUZPDZe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901f96fd-ad2c-4bcc-8026-08d665c672e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:27:12.9048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_072724_232001_ECBEA400 
X-CRM114-Status: GOOD (  14.04  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
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

SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
Make the driver support "fsl,scu-clk" fallback compatible string
to allow other SoCs to reuse the common part.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 33c9396..41f3a64 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -138,6 +138,7 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx8qxp_match[] = {
+	{ .compatible = "fsl,scu-clk", },
 	{ .compatible = "fsl,imx8qxp-clk", },
 	{ /* sentinel */ }
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
