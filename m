Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63598C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3305921848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="txmU5HMB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mybhHW2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3305921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9jDFfbIsne2ABG+QZtUJVw2f3+zEPB02+dAtTNY5Y94=; b=txmU5HMBWUnKFL
	JAw1MZZgw0390hYYECj6Zole5ZCDn2nGB1SaT3hf/ZdpG0YpsvJmQQ/nEMjWfXO6IyZ4xBcxgIvL7
	vZz8CMsDBUhKVa3Hno71B3h5N+ttmHfvFRuvVAqk6zRSoiuJ4ke60YcFxf7XY9SuLjeH6Wu3iOjZs
	5ZS8ldNYOYTH9orSdchIHCbCUPw5Ogehfmj1d3X4KGmcv1kf4A3nn6FbABuHKpvXhNIohSGDbz6A5
	floVT3PZ6N3xiwYH6yKaKUAHKkeQA37LNBLNF2tPtUWn5BX+0H0+ekNGRnm+jcgdQAVPSuD3HlAKh
	CrsQhe1mp5+Kj3d7h0Qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ5YT-0000Jp-Uc; Tue, 18 Dec 2018 02:56:21 +0000
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ5YQ-0000Hs-Pl
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 02:56:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX0mSS/8Gw/k0Xla90uKTQDwj1VRJl/Yw2mclDihot0=;
 b=mybhHW2RZhorhRNQrLiETctGabYZfeyxSg7aw6ASaEnZEY3PyL6CL80XoF4Se3FIvCA6R1CVHW8iHw5j53rAQtdy7OuFZcid6DsZZo7RjZvWq/Prub+9bjVVJy/AMBZo4WcxzJfxvmL1+IUtjXZfwtxTmANcbvSuSEurFRBXRMQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3866.eurprd04.prod.outlook.com (52.134.71.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 18 Dec 2018 02:56:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 02:56:03 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M composite
 clock
Thread-Topic: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
Thread-Index: AQHUln02eAG5Z54Wc0mB2eSSS/znhw==
Date: Tue, 18 Dec 2018 02:56:03 +0000
Message-ID: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:203:2e::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3866;
 6:4WL4G1THcXFLVo4ozpfqI8sp3UY/y5dj+M853qDTaV3Ljmzm+qD+BL4UhN7SYspyYhNUn7pTxbGWuaVWs7eZzhs74t3MVeCnsX/zVw5LMssj4TDQMJDT5SDzuj6FsIMFlxMPTeGZHtPJDBaYBQ0nYnzK9hzHndaR0SDfVu96Hjq6fVskSV/urPmEe1HCPmsqf39BaPou5yK09g5DQ1wD6s0NunyPVrirbHvR4NGacE9WvfhrUdb2hki8TLZoADufPNK3k8zWiVFHooIahMGZ8d2QSEeZLh/K/7dzSGWyt9m7wmuPmv29G9/gtN7de16c+un075gWaMMeD/XCm1QJ+OyausXnQfsKjiPsF8/719kIgSy/4H88Tz8bY4Jtq27ZUbtHFLfoWExr3ixbuarGqH5MJhthM4dp6YE9fPQrWxUv3J6HesQcUldSXxssBOZousMf1A9t2GWqVmBKYxN4Rg==;
 5:ymcoTfcM5NxM3klNIt5EeM0UciaNypmDoWAmaYIIt9ook2BUzhXSikxF3SfIFHkOq7hZVLfEtSBJQbE9Q1wxAhlX+J1hNl6OhXe6jA/xUSMv63ICksweWsmStXaoYFVju3Wv2ZmJbOIVyk/0kTG7rzdcT/lBvcyJPWy4mBs7btE=;
 7:e9z1NYYI6l7OQY18sCYyjMu3073T1o7NTAVHNDoVkpsufBpU2PfIUK/Dwmpr2Y6hQikmt8fNIwwdHtdKXot1gDVn/WvIxx7KvExeFBRIJH/x+QzQKjR3qUuWmecV8TXj1q+Oehn+43h0mtwloytRqQ==
x-ms-office365-filtering-correlation-id: 964c3c64-6804-4506-9437-08d6649458cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3866; 
x-ms-traffictypediagnostic: DB3PR0402MB3866:
x-microsoft-antispam-prvs: <DB3PR0402MB38660B2A3380CAD493FA2F1FF5BD0@DB3PR0402MB3866.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3866; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3866; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(53936002)(6436002)(102836004)(2201001)(66066001)(6506007)(86362001)(2501003)(2906002)(386003)(6512007)(71200400001)(68736007)(71190400001)(256004)(97736004)(6486002)(14454004)(316002)(52116002)(8936002)(99286004)(50226002)(81166006)(110136005)(26005)(8676002)(25786009)(6116002)(476003)(486006)(4326008)(3846002)(186003)(305945005)(106356001)(2616005)(478600001)(7736002)(105586002)(36756003)(81156014)(5660300001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3866;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sf93K+F3Hna5r0gI0Y0XcQhGHo/VLRQbyxhiMBBD1R37G29fT3iTCjCgaQB6ho6k0vz72ORBGrH7skclwPyyO2FwgtUIihuwsVn0fZP3SeY75RnwkfVJw2JYC6z5zJ9552wLVKrWd9ZtLoq/8KTZgAvhnOwH0gzrrS3la1hZoyPcXvUn2wAmdY+aV9o9ZGzpXQ98Zs3PQ0Ve4EcCepr/DlslSi5ViQvGFYEzhv0oYkiesUE/r0yVRIvTTWZe3ZdQ1hGXluNOcMyz5cv6NzCP85QPtAgCKmJzD0hzagGnAe+9S0Rs4C7QT6thW3lZi9qF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964c3c64-6804-4506-9437-08d6649458cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 02:56:03.2212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3866
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_185618_840296_3B80132B 
X-CRM114-Status: GOOD (  11.46  )
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

On i.MX8M, some of the bus clocks' rate could be changed in TF-A,
so Linux clock framework does NOT know it at all, need to add
CLK_GET_RATE_NOCACHE flag for composite clock to make sure the
clk rate from Linux clock tree always matches the HW settings.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 527ade1..d9147ec 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -161,6 +161,8 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 	gate->reg = reg;
 	gate->bit_idx = PCG_CGC_SHIFT;
 
+	flags |= CLK_GET_RATE_NOCACHE;
+
 	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, &clk_mux_ops, div_hw,
 			&imx8m_clk_composite_divider_ops,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
