Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B655BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:03:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74766222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oRU1QdHD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TWi0fImp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74766222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GJJuqoULHUuHFPMrrOSQv2ShjSEPk5KrjIDvN/XwfSo=; b=oRU1QdHDZZkY5C
	jjMSvPEU7frz5/pcp9UNgTWsxoKJ+Msh/0Gd820yW6vyA6+O09MfzAuZDjL/V9i2zLX98UYy6kaIx
	PdAZSU8SwwpcoqgI+mWRheYm3ZTuTp9gSV3retklrSfuxvXI5SbRsaJSgj5Ht/RKLfF7ZWEkR4Gty
	u/btOQKzgDFJ6Fkslw6mdSH6e4fVbn3nHcMDW5tY1UmU1I5qK3HBT8Z1iJc9KmllE0IALMOvX72Fr
	E0hN6w/Ggjmito4AsuqJO5LrGp31qJXwkEvwHHD15Ae9paAUMYmR9nMKhzNjTjuxAOSt77+xk2zUb
	jQLIHBkiHNws2Tt9xg2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guBzJ-0007V9-Lk; Thu, 14 Feb 2019 08:03:17 +0000
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guBz4-00075I-8R
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byquPuMEapQAVW1q30e0468Wm1iVDpaV5+775Gf8eeY=;
 b=TWi0fImpRCU4Si95qvmIYH/g3d0So55MFGsGzENpFRgSluRBXkbTtW2UPTdukNFmhJs6iUae/vcLy49JcVyZ60Foe199CYiexL7/VsYu4IPkx2rmuUv9qlDh1tUMRs/arttmfmHSeKmQrk610hTgS5u1231r9ZsETOehNzppy/k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3881.eurprd04.prod.outlook.com (52.134.73.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 08:02:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 08:02:56 +0000
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
Subject: [PATCH V5 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V5 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUxDux5f/s1cajP0OvNkXWzkj5Ow==
Date: Thu, 14 Feb 2019 08:02:56 +0000
Message-ID: <1550131046-2069-2-git-send-email-Anson.Huang@nxp.com>
References: <1550131046-2069-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550131046-2069-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0202.apcprd02.prod.outlook.com
 (2603:1096:201:20::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f534ec4-9aa3-4c83-3f8b-08d69252d422
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3881; 
x-ms-traffictypediagnostic: DB3PR0402MB3881:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3881;
 23:k4588Nj5dy0EHX9hyIG78zxFGfhFG9vAoDP7T?=
 =?iso-8859-1?Q?iDpSvocXOjHs8yJCbyodw10ewywJ6CD3pT5HsIFrv+OnxzdFAwH5qaHGxG?=
 =?iso-8859-1?Q?PXr12+8ox890s5kCH+t+tIrt7/xdJ6nSApGp1i23nRTJ3GfLtV4ojZUPT5?=
 =?iso-8859-1?Q?usMx5cjJmDXjOjSN7Ha6g6B5veZnwMyimYVZ29hwD6bktmYbEyl7LgZBi3?=
 =?iso-8859-1?Q?6aJ58S2GYKQ2mlHxbhz8SsrjmEOfTcZyI6vYv88AX/0VEC8l06KfXoMUyO?=
 =?iso-8859-1?Q?/Of6xshdM8KLc0ZJrHrHN8uR17Dd+W6iVC3ZGqqEfF9qn39yVHmk11xZTy?=
 =?iso-8859-1?Q?DFjXkw02yByEkomYyqlDHr3hqKCt0kaXAFqUTqorMd0cyRhew+RUddogX6?=
 =?iso-8859-1?Q?/QARfxTn4UmvXQvaQj8jcqNVwViXeANVUsvCKNQA2zTokgdT+WDanouiZ+?=
 =?iso-8859-1?Q?P4pEr/yKcRfGEkHT6fBqTmRJg44jD1I//ngrg1EuJENb/uLFMANhpRYFRz?=
 =?iso-8859-1?Q?gyPcRJfYocV+74eXoTsdahx1p9RUTDZEAlY+YfOZ2tYxFSKg/cpuyMDlWT?=
 =?iso-8859-1?Q?Jq8i35Ivtw+5DYnD2+UfI60snBPM1nKz7BuncA6dNCAIqy2KIrZsSr+BWM?=
 =?iso-8859-1?Q?E9Q/lgikWQDdeqGCr+vcKyKjsfBPxhtNuc2i02RyHEQIxfD6wmF8ZEEVzS?=
 =?iso-8859-1?Q?ZbfQhjkKQWjqIZNiD/sp2cucxi1c3qzZ40sSmCMkroDOTWz+3jABE26zCi?=
 =?iso-8859-1?Q?lzFLM1vPsnOzW0fmboGEFqnDICPOKLKqIJId8ISm3Mq+Y1SOGpeUR5necA?=
 =?iso-8859-1?Q?Dlg50dJtW9aGG8hKQ/tKiuY1vvtdmk8BBOq06gg/6GxhZo2F6u7BLRrZR3?=
 =?iso-8859-1?Q?2VYqG9glPfFUvCbRGa0d7WtimvnaSAPNXcFbKZNYPOldCWTv4igNivpkdp?=
 =?iso-8859-1?Q?E4QtJtRjFUe9hvIYC8VQEV+FDr0ch9SFWISmhDgJT/uepnO1gYprulxDTC?=
 =?iso-8859-1?Q?WiaYLd0uYGk5Ur+UIjxYEx2HptttSbqF2RpFERxvh8w5gxq9rR5iakoOsD?=
 =?iso-8859-1?Q?9xHCK/svoazSpjoW/b9fPjTEVjwzUzmS9LXSlp5GekXZHdAS3ZWEBk4D6T?=
 =?iso-8859-1?Q?kugloNqhias2hvX8VudYooXLP1NYleARzkbbo5iGKW4bx5b6IYvSAZOJYY?=
 =?iso-8859-1?Q?KHs4MNpur1wYIcxE3JHnwnuAFOiigP4iS+o1zvZaGjerauylVS8qsGEu2C?=
 =?iso-8859-1?Q?a13Vv828utyMso3GC8odK/Nf+5x0ee240LjifAQYU4LLmMCilPbL/cFauV?=
 =?iso-8859-1?Q?fZpc=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB388164147CE34D79B4BF9732F5670@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(25786009)(2201001)(50226002)(11346002)(71200400001)(446003)(71190400001)(81166006)(3846002)(305945005)(97736004)(68736007)(105586002)(106356001)(6116002)(86362001)(8936002)(486006)(4326008)(81156014)(2616005)(7416002)(8676002)(476003)(36756003)(6512007)(99286004)(2501003)(52116002)(14444005)(256004)(53936002)(2906002)(478600001)(186003)(7736002)(386003)(76176011)(6506007)(26005)(102836004)(6486002)(14454004)(6436002)(110136005)(316002)(66066001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3881;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lcc6BRFyejV8UqT4woGHf/gSJKkStaNhe2ge7jrYZNB2zTzCcOLp+xbwQRYJ8N3fY2RBK0AkQb+Sta0T82uRf+Jlo/bpMVlghD5KYFl/MSXscE+dPbJMuiA2c7YMNC3c9/3LygUH6ehWFQtO4XR44mLAttQ6Yd60R3BqzqwYBZr1zTW2nCu1B7u8scxClZJKZA+5jrmUyDZU1nawctYgvBOk761kfKb+Vqi1xy5qBqOsJ6juTJ5312ytI67VBfxi6mlkH6ezLl3jhH/Tnf2U0C/Ip6jTDWwErx+uH9EEFPsEeMDdfVLtK8fMDPgLR39hY82WcS48NiY6fFbONfoHmcrtPp1stQzAv5Wbsvmi4MdVOFhrFBqivUO9CdIfho2EvA0QPblaHr5urS341ui4MQOoNAn/XK/UAd3ae5jY8U8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f534ec4-9aa3-4c83-3f8b-08d69252d422
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 08:02:51.4466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_000302_378599_ACDC2FE0 
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
No changes since V4.
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
