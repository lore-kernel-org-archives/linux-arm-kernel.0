Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4256C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A8B222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FyOkxCog";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WI9Y79CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A8B222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PocYVR0xS7JJQgv+Od3Qq1W3ieTAkpfi/9v1drYaX9o=; b=FyOkxCogLL90Gp
	jhpCFyEYWOWAlrD6LwMxhr8xHr2ldFk6bYKEhghE0xQzdF7Jz/srdRYEhX/dIQa9a4RQIuu5v6Kba
	LMGlWyUkgaOo3xsf6KBBWPVeFr9bQ5uGqJk66LkKOU/IX3bVNe8LdAz8FBR8yuh/bKl3UaztnxFLz
	ABVaDDVusojMfk2o2VI6dO9vfwrsEpRDYRsdVHbJ9kQFcrzf4Lql5ztJCzb3BWANrmSTpoKREcnpr
	22euNtlPMocpKcGYc01Nngg56+gbZEXq8MXbDIRGzeWoAJgUmfRoBwKsvr7jVUtQu2J3QLnKbfZAX
	tx6edJ2crC38ASLV3nLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDkd-00076I-SH; Thu, 14 Feb 2019 09:56:16 +0000
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDkN-0006Xs-S4
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:56:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir8c7bEmvNOEkAxrBjP91mWewB0ga0geIwcT1dvGfUQ=;
 b=WI9Y79CDUwcGNiNwUeknb/7Gr3koKEDuUysebsQkF8gr6zBHQ1HpQPAsUg5eLBtDZuiEb9rep4cg2UV9DCX5N8YTiowBD6pNAuhqkiId3JYBp3n4uJGKa7EngmR4NCUEAQFpSH42bBc+X3gyJ5EtbzH2MvdUYEtgwIzrwkf00a8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 09:55:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 09:55:57 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>
Subject: [PATCH V6 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V6 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUxEt78gy90OZt+UeqROcOSrZGKg==
Date: Thu, 14 Feb 2019 09:55:57 +0000
Message-ID: <1550137826-18531-2-git-send-email-Anson.Huang@nxp.com>
References: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cefc315c-15e2-4ac6-4aea-08d692629dbb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3818; 
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3818;
 23:jBJsX+WXu0fMTBUrwlHU6N74UqJ+1AMR6CWhp?=
 =?iso-8859-1?Q?m+JaqDDiwgNcYlgNxCmx22PmKV0vlbbBq7uk0cFvwg7Ym5cZCgRDTe3WSe?=
 =?iso-8859-1?Q?vjIZlsklH8OfbaPr/R995XpgNBAxuC3TNOSh3MzFXcUG8wf6OLNoEsATrd?=
 =?iso-8859-1?Q?r/KXuwyBf8rx1h7SSCnhhjJruVKgp8mwEBeMSoioEAXdU/XLJja1IQ49iS?=
 =?iso-8859-1?Q?EsxS51kfjGJd/6gtYE7CQo5ib1i01Zm+Z/S4YRPhEADun3Rxc+WUzILxN/?=
 =?iso-8859-1?Q?18miOFzuOoksfEcfeJEMV9n6koJhRgfud02adFkxm/OXDUcgveHhe4xFVt?=
 =?iso-8859-1?Q?PtK7qE1DVuuasZ8XJsOdf2xaMcnNLbdNmSFC/MVrE135v7eVDEml9zmLeS?=
 =?iso-8859-1?Q?68EFzlqb5hDTTAh62fdCzPGQHirGjOqv0zuI99lloWnwtgVrPokPZH8QsR?=
 =?iso-8859-1?Q?Hh4orqBAqwx3x9hDLiJz4gcQu4Vee7quAmDjcKOsi51MSSO/Tz4ukcbvsQ?=
 =?iso-8859-1?Q?m8YLfi/DEbotAxpO3pU9TdctzqNfvmSvlVEyA5v2eUDCgs5cmX/4QNCrA5?=
 =?iso-8859-1?Q?WklEehLTds/4NbLOcWGYWVsYiTEg8sKhpLsbMr4bJ/NNRaumh62MPb/cyK?=
 =?iso-8859-1?Q?oxzOV7qveC4YUNgLUGsenq600cqH5RxZuCEkpXoDncqAvhfAEaJkv0Y1/p?=
 =?iso-8859-1?Q?B3gvociIgGS6fQwJruuSblDDOE2nzh8ytk3HtdNm+72MlnAwcoPJW4OpCj?=
 =?iso-8859-1?Q?r5/tOwTPjWbpQCGrLjyIYbv6rcWcRn8vROeVytJV5xIEoLswSR+1mvJEXS?=
 =?iso-8859-1?Q?l6Zt2GVZqytk8gWTVFYqTesDHen+ZOw4/OPXMZPEOqhocj6zMCz0+iBEME?=
 =?iso-8859-1?Q?QmGnQG/CHzZ3P8mDDKpffR3QyvrnR0qHV8kF37xj/cZIsc2WH6i4qek2pR?=
 =?iso-8859-1?Q?bdLmdqnpODPgz/mPIZpz1x3xNxfRN8gGQTK/lost3fUDtvytKaLbOp8GFk?=
 =?iso-8859-1?Q?qdsLJnXkb1W1PcDmzda7CS+D8DBNEI/hQ6EbcRcrJ5zRIe95FHmcOu7Rz9?=
 =?iso-8859-1?Q?4A93ooEzF0Trg6MtY6xU9Y3FBX+hWb4vrlIc6ZC46wrwRoTI5Xa6X68TOA?=
 =?iso-8859-1?Q?S7xyZQFA1GQuwwXv40gzhRkpqa/lhRzw0k6iTaQDSbojp0mSJQpLcscI87?=
 =?iso-8859-1?Q?pq85H/y3j8T0oXH6BlSya7Y5tOUUhi5aoPdVaKzNZdymWaZwoDLkLAr933?=
 =?iso-8859-1?Q?U5TVx1ESn6P78E2YfqdsFGlpYn5IvaS+Bv+rpL7YudbiOYTAGNhtSwRCJp?=
 =?iso-8859-1?Q?w908=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB38186F1BACD07783895A2ECFF5670@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(97736004)(71200400001)(8676002)(71190400001)(256004)(8936002)(7736002)(2501003)(81166006)(2906002)(81156014)(14454004)(52116002)(110136005)(305945005)(14444005)(53936002)(76176011)(50226002)(6486002)(316002)(6512007)(68736007)(478600001)(2201001)(6436002)(486006)(476003)(186003)(2616005)(36756003)(6506007)(86362001)(386003)(26005)(106356001)(3846002)(4326008)(102836004)(6116002)(99286004)(7416002)(105586002)(25786009)(446003)(11346002)(66066001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3818;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /4xjAN95aOsJFIV8mX1Bop+ydkLeGx5QcaJDb22cLAzsh/R1pIr3WHJW/eFjdvuyzmwbBenAH/TEfpyb7+anaCf/FL/1DoHDu02HUIy/BvptIzXpIEqyv/UmMDmrbisjU7Pd+D2v8mcbZY48wkd4+uxwQnK7nqWJVg6wHYle7dHje46hvxTVNivGBBCXLh5oX7k4mQE9LJi3WBqu7mN5VWiOUuo9qfp5wwQp/GfQOUZ3V+TE0hAVAy+T2SbLnXKZYhXGVd4U/ohAxvQ4Dkc9nfYfHPUHzGrJCuk0MignKKuYrSqDT1bfNT3v0EdONp8TMrHjmwisvgZ7xLYs27R4MixipufZpPrbGV+CQ76pGBw80qhJbuVXvazF8NsM92iCCRGGr6WPnKcS4tF/r8sSH1ngKpK9wr+3q9DZawXKPtg=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefc315c-15e2-4ac6-4aea-08d692629dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:55:51.4662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_015600_006055_F2E51B66 
X-CRM114-Status: GOOD (  15.12  )
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

On NXP's i.MX SoCs with system controller inside, CPU frequency
scaling can ONLY be done by system controller firmware, and it
can ONLY be requested from secure mode, so Linux kernel has to
call ARM SMC to trap to ARM-Trusted-Firmware to request system
controller firmware to do CPU frequency scaling.

This patch adds i.MX system controller CPU frequency scaling support,
it reuses cpufreq-dt driver and implement the CPU frequency scaling
inside SCU clock driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V5.
---
 drivers/clk/imx/clk-scu.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 7ccf7ed..c234a6e 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -4,12 +4,17 @@
  *   Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/arm-smccc.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 
 #include "clk-scu.h"
 
+#define IMX_SIP_CPUFREQ			0xC2000001
+#define IMX_SIP_SET_CPUFREQ		0x00
+
 static struct imx_sc_ipc *ccm_ipc_handle;
 
 /*
@@ -145,6 +150,23 @@ static long clk_scu_round_rate(struct clk_hw *hw, unsigned long rate,
 	return rate;
 }
 
+static int clk_scu_atf_set_cpu_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_scu *clk = to_clk_scu(hw);
+	struct arm_smccc_res res;
+	unsigned long cluster_id;
+
+	if (clk->rsrc_id == IMX_SC_R_A35)
+		cluster_id = 0;
+
+	/* CPU frequency scaling can ONLY be done by ARM-Trusted-Firmware */
+	arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
+		      cluster_id, rate, 0, 0, 0, 0, &res);
+
+	return 0;
+}
+
 /*
  * clk_scu_set_rate - Set rate for a SCU clock
  * @hw: clock to change rate for
@@ -232,6 +254,14 @@ static const struct clk_ops clk_scu_ops = {
 	.unprepare = clk_scu_unprepare,
 };
 
+static const struct clk_ops clk_scu_cpu_ops = {
+	.recalc_rate = clk_scu_recalc_rate,
+	.round_rate = clk_scu_round_rate,
+	.set_rate = clk_scu_atf_set_cpu_rate,
+	.prepare = clk_scu_prepare,
+	.unprepare = clk_scu_unprepare,
+};
+
 struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type)
 {
 	struct clk_init_data init;
@@ -247,7 +277,10 @@ struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type)
 	clk->clk_type = clk_type;
 
 	init.name = name;
-	init.ops = &clk_scu_ops;
+	if (rsrc_id == IMX_SC_R_A35)
+		init.ops = &clk_scu_cpu_ops;
+	else
+		init.ops = &clk_scu_ops;
 	init.num_parents = 0;
 	/*
 	 * Note on MX8, the clocks are tightly coupled with power domain
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
