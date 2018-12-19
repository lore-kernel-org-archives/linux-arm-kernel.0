Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A45C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:28:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D522C20643
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CXfoulNq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fTHEl9fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D522C20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DT2lCNrh+L6ucYnyT96HBmOg85vAJ99hiBAJmV5+MCY=; b=CXfoulNqgIPnvJ
	QZ4CiBKTYkSah9xm7bqAqN5ixSL6D91bDlVFCRBYsx4qnC8TU2AEom3iYF+W3u3vFQ/rUJ4H8J2mb
	uFYVYT3MmKMNYnc9pjLJfsNGOfbhWek0QJ6ngmVAqOglldBrAgLJPRYW3VjOBGSs4SUR9nK2UU+/V
	iZhpFABJKyCZMOVju6Nq1kWj/DwW+KRkK327IOQNbG9I/qBAhXbs6P9yX21FhoV1k0+6k74lposNz
	GLsZldhBPqylXsM/85E7BQfc5E0tbWz+23Rdcu0yC6JRjsxgVJylvudDkKQ9PoSyUnD6pWg5NJqpE
	lXwqMCzmCrqEgRUIXO/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdlv-0008Vr-BF; Wed, 19 Dec 2018 15:28:31 +0000
Received: from mail-eopbgr140052.outbound.protection.outlook.com
 ([40.107.14.52] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdkz-0007bL-4N
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:27:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAzfjeanNZNQKre5CFJXY7psJ+67/ip5z3GmQA0sWkU=;
 b=fTHEl9fNwIphniNGvlmYMa2RvVbGEQf9YwSkzzIorBxJ8TwLOmOKGENZkNtGqh49PxPmG73KQTtwjnozZ0Wd8q0tnNNr+FVa5iJX2Eb+Nt0KjqgI2szkXLLSYxwI0G/TEWUiJE2ynNnToavoiNX2sOXY0FPIP1zQmipJcdLDTIU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5444.eurprd04.prod.outlook.com (20.178.113.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Wed, 19 Dec 2018 15:27:20 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 15:27:20 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 5/5] dt-bindings: imx8-clock: add a53 and a72 clock id
Thread-Topic: [PATCH 5/5] dt-bindings: imx8-clock: add a53 and a72 clock id
Thread-Index: AQHUl69U1JQsty7wE0GJgtjEk9ghJA==
Date: Wed, 19 Dec 2018 15:27:20 +0000
Message-ID: <1545232888-9302-6-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5444;
 6:n2ICwI/49+C+HgF3C2e/a+j5VpmuFdIAZowYvlnXzJ2R4s0meYqmY3ywjCq+VuSC7LmsjVH+rvzAJY4QF3gniRCOwOGAloSA4NSEWdwHgDOdWIP939jI8w5YE2Wfh9eehWKPJ+d6hB1oFlV4t/aS43AMzPC8lpoRU1ifcJJ7D732Y59/I1s4B9CTXFSG6uw8/Jw25b9G26ACPgbaa2s2RurLOIF2m6mNxgxX2GRIrx4t+trhrejNP8+vgEmMlqBGXVeL47qYYex6YDtqW5GhsbopOwHtxhOijzU/2SNidTQ+Kl+iMtT7muwWz2Oxj96oVGLd4BBH/ptBeBPhlU19E0Jk32EhQKsXRGrf+sq4xluOamF2VscomyebU6k1LqCm7FrAlmlA8RS6z15yAOUkiibF+pBesh9Y/94G9yZbMxetFKRSWDcDyLlNrJD27jUuApRUYBCPWaaM0mv9qJvb5Q==;
 5:WtA7A+LVF0hUz5EMNaOmzCPFcocIiz5Dp+4GwmtmibDH0bY4O4IZwE8lElyzFGQH0MKiMzjvyAg8tXN0oPFGh4AMEE1HTYvQ/K4Sb0Pso5CweOHNvjkgKkg8E2HwWJ8aeiPC5px6ZuMDcVXna5XQfa1tCtcttdVlHOPTYlwFNyg=;
 7:zOrIkHRIuzn0OUHbL4BFLTFz+fypnKDFvQmjRfdlRDQEMamrYacR1g3+2DXF7bu4QTgqgCy+220RmavrKFM51Y/DZlpJ0Gky9t5Js5mhS7XPzxk2TiS/+EOJaRemyfCI+ZwOk07MnNSMrgyKEkr+Yw==
x-ms-office365-filtering-correlation-id: e8728280-0032-4643-25de-08d665c6773b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5444; 
x-ms-traffictypediagnostic: AM0PR04MB5444:
x-microsoft-antispam-prvs: <AM0PR04MB5444FBB10AFB144D3F98B50F80BE0@AM0PR04MB5444.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5444; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5444; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(256004)(52116002)(97736004)(11346002)(14444005)(50226002)(2616005)(2906002)(6436002)(2501003)(6486002)(5660300001)(6512007)(186003)(102836004)(6506007)(386003)(53936002)(26005)(76176011)(7736002)(305945005)(4326008)(6116002)(3846002)(25786009)(6916009)(14454004)(99286004)(68736007)(81166006)(81156014)(8676002)(66066001)(8936002)(476003)(316002)(446003)(36756003)(105586002)(106356001)(2351001)(86362001)(44832011)(71200400001)(71190400001)(486006)(478600001)(5640700003)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5444;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: abVjq3BvPa2J64zh69h9z6o/xB9nPlt1z+VDnCuWvKJrp5qJIO9ydAnDq9CotV0Hi/j3zLDSLw3uPXu2/EBF/+cr/MsRaan7sWu8P8pmnRzmO+3rQJn3dMQG7Uag6DA72gsaQOeswoIjZQzOz1u6WWGtQb2ekNPz3K6R4Mw5cyqbRaGgWB9IYhE8/5UbWn++B1/Mgz5g1pzRFVWSP89wzMNMkTN4ImSa0cojboJu71MJ+MIbn90mNkU6UqFL/ubEtcTkpcF/gm7AnwZAwg73VSQIe5YhX65fv8mMCLgYjLhesSUzPH33nSkxrUq+9LEo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8728280-0032-4643-25de-08d665c6773b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:27:20.1861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5444
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_072733_752311_EC6A0BE5 
X-CRM114-Status: GOOD (  12.94  )
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

Add a53 and a72 clock id, as there's still no users, we update
IMX_LSIO_MEM_CLK base to start from 6 to allow a53 and a72 clock
id to be continued with a35 clk.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/clock/imx8-clock.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 4236818..2f1aa2f 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -13,10 +13,12 @@
 
 /* CPU */
 #define IMX_A35_CLK					1
+#define IMX_A53_CLK					2
+#define IMX_A72_CLK					3
 
 /* LSIO SS */
-#define IMX_LSIO_MEM_CLK				2
-#define IMX_LSIO_BUS_CLK				3
+#define IMX_LSIO_MEM_CLK				6
+#define IMX_LSIO_BUS_CLK				7
 #define IMX_LSIO_PWM0_CLK				10
 #define IMX_LSIO_PWM1_CLK				11
 #define IMX_LSIO_PWM2_CLK				12
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
