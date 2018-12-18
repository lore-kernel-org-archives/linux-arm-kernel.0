Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC516C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:13:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDA4217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cFzYzlLP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xYg1RW3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDA4217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lAURvL3YlMwluZadt7HxjgUBJ8wzLdi4B0JdSk9hS9E=; b=cFzYzlLPmik6uB
	+ymszBUC+kJsFp7YjzEppf5nh1xCSFpLc1XK2inJHvhUarGTJnbF6UNFpbuMfHoXnbWigz6Z3eFQu
	S3sq+yFvAe6VaalGF9vMCiUddlBlMmj67m5dfKlK5BUNEnIGgQuRjIvzv5EljpACdWBz0QXlyYt0i
	pUoJ9m0F+J5PCg34p2tTkyaisGx/0pQtUuTeao0UU8q3SApF/Ok3FWr6Pb8w1VFqsFo2Hefb+LM2n
	AnmTto0EKzUazcGkoj7VglUqS5d8+nucoSN1FzN64ycNkifUNuw1c5BicNFyL/Q3fQFwOmRdIhMKV
	cQU9kEBM1T0DtiOxrZ6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZG7U-0007bh-II; Tue, 18 Dec 2018 14:13:12 +0000
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZG7Q-0007XJ-M6
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:13:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uMHaISyJyQYoKzswZvADjPRk6Xqh8YN/2eVo1/Vs+8=;
 b=xYg1RW3uI3reK+zWbs6TI8jvjFF5YUo6RXtN53bpGXoTnmCn+La/XTDT+rfWnrE9bI0myh3Y0U1UhenhvOjsezOd5W6JQ9lq2KzE+o89vn8NWvT2cXbgQsjFIsEjS8RX6g1foLjTljpe01C9s8gxV5q/m3SFJRJrx3LdCW69Fis=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4977.eurprd04.prod.outlook.com (20.177.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 14:12:51 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 14:12:51 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Wei Yongjun <weiyongjun1@huawei.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx
 <linux-imx@nxp.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>
Subject: RE: [PATCH -next] clk: imx: fix potential NULL dereference in
 imx8qxp_lpcg_clk_probe()
Thread-Topic: [PATCH -next] clk: imx: fix potential NULL dereference in
 imx8qxp_lpcg_clk_probe()
Thread-Index: AQHUlpvry2qgkPP2Wk6112vrMZV9TqWEidog
Date: Tue, 18 Dec 2018 14:12:51 +0000
Message-ID: <AM0PR04MB421133F1BA37512DC60057D680BD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545115389-173136-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1545115389-173136-1-git-send-email-weiyongjun1@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4977;
 6:efnwWYT4bRPs6ip0/hilV+7ChXidQIGi1vPGeloRSpNL16I1cPMA+BzgZrBq23PSynIYx4eWO518HVBe1eLQ/D2NdM8KIgOiMEqHVJdrC9fsWB0MK9oeYjyS/8V71IPzKcvMVxwv89pt28dEKwo3Zx5qpL3XtPHrjdPh1Rb21RQK0wigsrprPJ86aUXtPu785M8W9C+rYQ9ywDxasKnxfl9s+rwu1nNwnGyXa8gjwz0qQH2g2m8ifjCN1/feBb4ZWRPwfKWVMJ/RVWVtpf1zK/EZGdYsXt7LSvbSegBoo0bXsjLGa66EtSjmpGTBJgCvIELkycMycHJ0IOOtmQ6p1YkgdAVGMdbkELmKqpDZmAqxDAr+ZWgMBtCcUsbu3FJ0qPViZcYS9iDAbR45bsdBRDt5g7PzHebU9Gd0giQpVfQH3XRfU4RnGaUHWdz+tp8zCRJoFa2OeuC97QxJqpRUvg==;
 5:GjE5FEdUgeMaHKvjAnOJgMyryTs7/bu7CH4sti57fF6jW0EMssPW+aiptxX97wWD+kqd/gz8WeKcxXuufSmBm/Kan2erPfXsWgT1FYRyXl4C7Y+1D20XkleR69kJR+FardaTsUAjKI+JeTU7eQInj8RqiVHtUaYUbkPt7sBvEYo=;
 7:PHQqA0ibOt5o2fFbLTPgsOFSKHupDnYNB22wdtxgn1H6V9IxZTyfq6YhiDPlfox5v+apo4q0xad0QvI2ZPP9w+2oBO5+6yLQiO+iWLoAa+gECIqlpQJg1qEma07QIALhmhEUlPTxGeGwGEyv6aDYBQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d2d95847-9b97-4ac0-9e85-08d664f2e59d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4977; 
x-ms-traffictypediagnostic: AM0PR04MB4977:
x-microsoft-antispam-prvs: <AM0PR04MB4977EB1848B01698D5BCB10580BD0@AM0PR04MB4977.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4977; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4977; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(13464003)(6246003)(81156014)(8676002)(5660300001)(86362001)(81166006)(6436002)(66066001)(55016002)(6116002)(71200400001)(71190400001)(7736002)(53936002)(9686003)(3846002)(97736004)(33656002)(229853002)(256004)(110136005)(54906003)(68736007)(74316002)(106356001)(105586002)(478600001)(99286004)(4326008)(2906002)(25786009)(26005)(316002)(7696005)(186003)(14454004)(486006)(305945005)(11346002)(76176011)(476003)(446003)(8936002)(44832011)(102836004)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4977;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tgwfx+d/VZTYqa0eHiIMwHsWPQQkYuNUZFd6sLanTDxvnccrkRiXk0+qx/ms0PbdXG0ei1PxoEcJR8KqFmT2ruq+uYUmofoCWZtwHkwf0zBEsQN0ky1yrgrChU7hhcOibvx8+SEVUqfQwPYjyCc+KgTLHRs/Y2oRblD7Yygv3n+OLX6ff3Y2EdK4zz2sHi0tia8aAzKs9h8n3cWH5tBDiet1k1txDYB609niFIm+JlQPRe/v0qqQRyTqGM2m4c0aCYE5z+YBKvxqOD09xqRon1QDPplprpsZUcMptBKLckNHbqSxi6R5jGqTBRPt8qwU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d95847-9b97-4ac0-9e85-08d664f2e59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 14:12:51.5116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4977
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_061308_736795_F42FEAEB 
X-CRM114-Status: GOOD (  16.48  )
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Wei Yongjun [mailto:weiyongjun1@huawei.com]
> Sent: Tuesday, December 18, 2018 2:43 PM
[...]
> platform_get_resource() may fail and return NULL, so we should better check
> it's return value to avoid a NULL pointer dereference a bit later in the code.
> 
> This is detected by Coccinelle semantic patch.
> 
> @@
> expression pdev, res, n, t, e, e1, e2;
> @@
> 
> res = platform_get_resource(pdev, t, n);
> + if (!res)
> +   return -EINVAL;
> ... when != res == NULL
> e = devm_ioremap(e1, res->start, e2);
> 
> Fixes: 1e3121bfe51a ("clk: imx: add imx8qxp lpcg driver")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks for reporting this.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index dcae1dd..8f241a4 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -169,6 +169,8 @@ static int imx8qxp_lpcg_clk_probe(struct
> platform_device *pdev)
>  		return -ENODEV;
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
>  	base = devm_ioremap(dev, res->start, resource_size(res));
>  	if (!base)
>  		return -ENOMEM;
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
