Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91708C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59A3206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rSlZaVav";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ehCjG0PZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59A3206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L1uGd75E+sZoQNz7vEAXcKg0WfY4wyccOy5VtCf2jjs=; b=rSlZaVavIjbAs9
	3ivXmiiHtUMk3bPg+7bKiGCs+19EKO0TfaFS5/xmhJ1N1p+vnliUADJLEAnX8BE4sEKaJWGLTlNO6
	d9Y30dmJtJ43t9bm6MG4XKkwxdTmhVklk0gcn3JBnAHIJwbGNCSLrrrD8tjLR+atKW7uV0xsmyWkL
	6UEuVXkFg/P6F3vT8L1lExtWlxpMzAcPeuyJYAISXNozqH5kQtgu0h0uiIPuLoewwnKhgftlg8FLk
	N38RelZl4pZV2c1rS4L4YP7iw/ZPz6EgZwuXqaCb2FvJ9XNKrcNzsEYL9JDItQWznxGmZNcCTUYrC
	TuBw8NCdncXwup9ZO5GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXpQG-0001kV-7P; Fri, 14 Dec 2018 15:30:40 +0000
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXpQ1-0001VZ-I8
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:30:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRZzsR2FlGrHfMBDL1Me5gsZfeY0YmePbPX0AOTbfdk=;
 b=ehCjG0PZYGXbGA6jQyyrv3G1xWKfzcuJGKaL4v8Mntk97P4WzFlWoImygdlLXh/0DLq2qyUp05RFh28teMQmJ1XZXLHAmrusHTvnE+6zlNifjfqmJbmkGOKNK2++ePVaIaj6bxFsXuRHL4Y/vwixyZ1DPJLMOpqJpWWFkDW0K6o=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 15:30:09 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Fri, 14 Dec 2018
 15:30:09 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <kernel@pengutronix.de>, Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 1/3] clk: imx: Make parent_names const pointer in composite-8m
Thread-Topic: [PATCH 1/3] clk: imx: Make parent_names const pointer in
 composite-8m
Thread-Index: AQHUk8HlMVhoSDEw90uEQbKPCADBdQ==
Date: Fri, 14 Dec 2018 15:30:09 +0000
Message-ID: <1544801400-18951-2-git-send-email-abel.vesa@nxp.com>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::33) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3754;
 6:IMEWIkfepxFZYQLJgr+BUnklrzkL9x3SgkWtC37DFIOVazzOpQrRqlgxLYLOLrXK5zgbSm5NSdxghPRh9f4CRY4N/Ru+1dyz5DvWWS1NLpFHkA5lalYxnDH3mlkzBnvhEWw9ySww0f41/pe9HKMgA84ilsaWMdmVE4KeRZpmzqr20F/Wfvyn8cAOnZS7J/q+CsA/1v4WY7LbpY3btgklA4XTgWTtJk55CnimzOxbQqtf0CaFUATvisgz2CWiSGAiJZaejx1AdGiqyUzWvu95vXmq36AoBHMB2yZWCqejxSKYIQ3qftEmLS1oheucfbH5FVbSyP/q122nkqa2aoTFboJ4yknVSn2U7CZAukQmBZgkic9WVhAqyZ616DiIlt/niWyOO6qSaysBCODknMKZkhT5AYgpIuuRzckzGpat9CD+HpJ+StOyRAICTWuLWtcA77CmpCVXo41bKI+dmGMWFA==;
 5:4sYNSKKgOHGxW6FmrBS3NSq+ugYJC/e4jEanMG5B5mZPxFvYXFKEFbouYNdVxORCq+K5yhVOsMLdH6J6vmVBZPHlECTu8Oj18lvyHkWLyBbxZlH98T9fJB/WxLdbqEv7cNbES6XHdG7cLq1DmFJPh7d3EQisxUEfuYrJ5j85Bl8=;
 7:Uu9bsKYpW2SvH1I0wzVOuMyxNBhUfMm3yNGaKp6LkOQEr/OOLpU+vyun7gpKu1u0vlZsUyICK3vKnpqW7d7YCOs6kG7NJw/fZg3+UMEz0JVaMobtRFu+ncG52K2vdX+XLVpEZXC2pOI+GZR5WnpyEw==
x-ms-office365-filtering-correlation-id: 0463b735-9aa0-494f-ae86-08d661d90810
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3754; 
x-ms-traffictypediagnostic: DB3PR0402MB3754:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3754C2421786162D2373E6FAF6A10@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3754; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3754; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(2616005)(53936002)(6636002)(8936002)(186003)(66066001)(97736004)(52116002)(68736007)(4326008)(305945005)(36756003)(25786009)(14454004)(2906002)(6512007)(478600001)(5660300001)(386003)(316002)(26005)(99286004)(6486002)(6506007)(71200400001)(105586002)(54906003)(110136005)(76176011)(81166006)(81156014)(8676002)(486006)(7736002)(3846002)(44832011)(6116002)(6436002)(86362001)(106356001)(71190400001)(102836004)(446003)(11346002)(476003)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3754;
 H:DB3PR0402MB3658.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xdz31EZzp5EsIiGeB1Af2cH2U8RGJAzlA37qpd8mc86XsXp3no1XCm91eq75c6zursY8QS9VHrN0KOIVpoZflwF8h/Ycdm9NFYd7Krc7mFr9BhUDekDnm5GrzvMBjCgoFsqD77UsWD6mFtoWJbIV8DU4HjZZ3igianveBfoUKeg08JPUOd0ENlboPC/PWx3Wh3qnfjwe+D9Q5bilmhpTe5bbRYSYhma9tUubnHg9PD5vfozBlH5Z9DQ6Ag4BAxQp9zvd4VgYp/RI912f92J57B53ajI+F93bz/AVUt+qlSFZWyHpQ8qhbvo9fBPleg46
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0463b735-9aa0-494f-ae86-08d661d90810
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 15:30:09.3904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_073025_598197_405AAFD3 
X-CRM114-Status: GOOD (  13.39  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The parent_names needs to be pointer to const pointer to const char.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 2 +-
 drivers/clk/imx/clk.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 527ade1..574fac1 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -123,7 +123,7 @@ static const struct clk_ops imx8m_clk_composite_divider_ops = {
 };
 
 struct clk *imx8m_clk_composite_flags(const char *name,
-					const char **parent_names,
+					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
 					unsigned long flags)
 {
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 028312d..1363dbe 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -354,7 +354,7 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *step);
 
 struct clk *imx8m_clk_composite_flags(const char *name,
-					const char **parent_names,
+					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
 					unsigned long flags);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
