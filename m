Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C9DC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:57:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9702F214D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cPicaXkQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MJBuBL3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9702F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vFSO6EXnvGllHeF0B6/oQRTDnzsQdrCf9R5GXcM1/k8=; b=cPicaXkQ5KhpH/
	Yf4gqjQNqOWOukFJf0pqqNzL3bHcCufbfOXUk4AHWWaMZlILqBSuV3nimG08O/YLg4dkhliHevpwR
	1nPxKOSXZzeF6DagrEPkm31kPqftH3Z09ID7XMMCnRMgcacXqnoA17RfxiPSV9fJ1/R3jloIrTHf2
	T4GcAQ/SCQILowUKqyVZJXczK+iGCmpRhx5LVEfZ5GRv2UQQYwNycAInMOhOZaJY/8EiG+qVKv7l0
	TLZtoX28/V4gfR4hdRwG0r9PP5YLyJI3Xqs8EBo5i7KAJ4D0uCy2y8WVQzAMytNiz79SvMzsN6nB1
	P7jqgBeBebaIlnUjKVEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvQr-00060J-IO; Fri, 11 Jan 2019 11:57:02 +0000
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvQ2-00056h-Vw
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:56:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx0sjWW7vfvMa2anGrtbd22/ZIAO9GvHUrm6VsEsgJs=;
 b=MJBuBL3FpzwgP0/nSGlMWu4P7zHHaETrmAPUvqI++b3I/AkQ2VnISmYvyA8D7LhrdLnnlG2Fi44vbxCqXAN2QgRVTKkTXR/aS5XIvosEGX4BP/wdzk87UqQYogMvyVXJ7+SoL77xaCMEsTCG2ZDZY/YFcOgWQhPviawufFoHgEM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5281.eurprd04.prod.outlook.com (20.177.42.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 11:56:05 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 11:56:05 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH RESEND v1 3/4] clk: imx: scu: add fallback compatible string
 support
Thread-Topic: [PATCH RESEND v1 3/4] clk: imx: scu: add fallback compatible
 string support
Thread-Index: AQHUqaShCArI6C0FpUmUaDgoQmCTVA==
Date: Fri, 11 Jan 2019 11:56:05 +0000
Message-ID: <1547207400-28307-4-git-send-email-aisheng.dong@nxp.com>
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:203:52::27) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5281;
 6:1Nf0tpjljCXchLal4uq+rVvo/1cmcL6nIEQXVQQ35zjSv1C4dQ8gmdKiNqIxtHkdzI0cGtRHSllOH4d8D1PSe3hKaXrFtQW+iaKsfZgWXAxsV3YBxambVwKYdkUo7c12we2mw69cpyrDvSWjhbIPkB6VeUW4wn9nU6Mqve+eOxqnYa2faX1S3tO3nswqETuLMoselTkG8xoU/RjnjalG4PEU9hQrw/EYzvip9DtB5Mx2FFuDGfqS26Gx6hYkmIBGo9O+HUqJm5WixjIB0J2kqva7JTaOTcouXB442N4j/ejc7ha3xKOTB3XRRNWusq0Sg8XQNYROkE2XX7jUuKCxUsujEaZXEu3z8YM7iWNRrJyIm3P9YOPotRfDXOyarCaFFlZaQer5puAfPQCOPNidsaWDjh31W/MBnlwTvbtE/nDwSfTN8V8ITDxmvMMietSH4QhLQonywl7b3byHpGHqCQ==;
 5:jVk1eL1iWCjgIjABKSn7Zy6ggMqimMQZzx2pSy/0qxYPQp28mC8ORAICW4Wg1AgsBJR7TYTS6uS5B6l/XR/o6NtLiS7wlw9d6xISVu9x2pM1agPbbOXA/PEJ1bZ2UTzq0v/wwdKSXEOa+HFXRmgmICkv6CIgtTNEhZWir6gqeE5wcUEmvOVjb+3L7MeY9J/843h2rJqG32xk5x4ZYXu2VQ==;
 7:FTzheH7VpWoPwGN/YxUEHa+Isk3KAVxTX5OP+s4tMRjo8VjNQGK48BeR+foUOel/rLezZovvce79iBaoqVAgVIRzRp4LOxPBdYc/TIpQQVVkgzCVGgU8NsL2hBoLbDrxr68I+d7gBw5E18YCfpCIdg==
x-ms-office365-filtering-correlation-id: 23afaf8c-57f4-4e74-73e9-08d677bbc3d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5281; 
x-ms-traffictypediagnostic: AM0PR04MB5281:
x-microsoft-antispam-prvs: <AM0PR04MB528164603F9BD1659064F47480850@AM0PR04MB5281.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(105586002)(106356001)(7736002)(2501003)(305945005)(71190400001)(71200400001)(4326008)(5640700003)(25786009)(50226002)(8936002)(81166006)(81156014)(8676002)(54906003)(6506007)(6346003)(97736004)(186003)(52116002)(316002)(76176011)(68736007)(217873002)(11346002)(36756003)(2906002)(4744005)(476003)(486006)(3846002)(2616005)(446003)(26005)(6116002)(44832011)(386003)(102836004)(53936002)(478600001)(86362001)(6486002)(66066001)(256004)(99286004)(6512007)(2351001)(14454004)(5660300001)(6916009)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5281;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qP91LMt3wYV0sX6SiZDYJy7gIRGf3d7jHrGxWPQy7A/sq3/5THD99TPvkY2Nmx0Pty4oRZIHcQNn8NDN3Rh9adCKDUGIG8kAMnbDiK+pfxS+208pimMWCJQ1bHm3aE8CuJE4sN+sfpbzHR3qZXeAddyFzmiP+ziHkg2JclJKcDmT5gKEPuHOXGWf4ihzplyo4JdsH/Zpc9Jo5nT9+qN8niQJ5HMuo3QJ0ejIbs45av3X/E/NLZ+nGIiEyIL5wRtjkriSO/t5XiSRsqf1ZgmWa33c3i9ZonxWBZH5KUzEt8d/RYQtWMFS0wbaB57FrU3+Eiw3OExqhGLG5lfeIvL1I0WvvNn0im4bt+/JlWDIVlGlrZX+6oYckJEZeFE0dHFrDl+wxDm866JiF+6lTfffZSpTQPKaKrmLH2z/j+eBtdk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23afaf8c-57f4-4e74-73e9-08d677bbc3d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 11:56:01.2450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_035611_705515_12703507 
X-CRM114-Status: GOOD (  14.02  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
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

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 83e2ef9..5e2903e 100644
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
