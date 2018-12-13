Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E10BC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:08:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4527020811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YHjPDgG1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jTxBItfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4527020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ixxTSX3KAKPXeKfWiHmDkl4JYzIyVf+vsbkzsSH0mGc=; b=YHjPDgG1kT/SAi
	niaIurG5VQq3fc17lLoMDDDm43IklKv0To6ebUTg5Of1dLuZEBDdzP2tXfx0v9nQZU1kiExUF2S+f
	n7uUay7Oi86/5ienJqfBgNhtciA74DmGLL2qX8reOJTRZs612nEaKU4V6GIZkwdx2re/VmQM76wbQ
	J2LWg76syTIGrqg9dgBT3MaWDHtitDzVmohN4xbRKXL3FNupQwzOIaQ+2YrmrjjGE8LcpBSQG6OlA
	WaYVomGy5Ys+L+IEX8rSxwC1zEH0uF56eD2C6qrvSIW25BOW4KSuNMhANS6hgPRqSYrJco8QjxFNz
	0zJLCIo6MPn4vK/JP1Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFUP-0004eL-Oa; Thu, 13 Dec 2018 01:08:33 +0000
Received: from mail-eopbgr150055.outbound.protection.outlook.com
 ([40.107.15.55] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFTz-0004Dx-Rc
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:08:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pePnafb9pkbfaxR9+8Pf6oGtuiFDoupA0N6YIq+TGZw=;
 b=jTxBItfGSSPK4e8kQgSz+mFpWo7bzOkuYuD9ZqmjylI4h6Y3dt/WC0WEwr3pDg10qyWfP3HZGk0utF30JjBVgm3Yw2SmsibChNhNcjpBOe6WJPvwljzxPbqGIfoT1d/cww7qX2+/ymAiOjsLZ5ubHmDuIViEox43YkVSpERvX8s=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4308.eurprd04.prod.outlook.com (52.134.126.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 01:07:55 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 01:07:55 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V11 2/7] clk: imx: add scu clock common part
Thread-Topic: [PATCH V11 2/7] clk: imx: add scu clock common part
Thread-Index: AQHUkoBHoRLNmKbTG0W2ArFlHoWixg==
Date: Thu, 13 Dec 2018 01:07:55 +0000
Message-ID: <1544662938-5020-3-git-send-email-aisheng.dong@nxp.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4308;
 6:+ezkFSLp/0CEB6UMPkcLjgLSvZauNbVxJXlFUb96uUFTkcTLAU/hPBDg+MF3yZF34sJSWhqMejd4s6ESu+7Z2KG08CSWY1LiOYUZzumtsW/yLtrFJymKdis8RgkFJEZJCRXTX4/kvdN52NSwajBFr6jAEWNKGNth4rsb6iN3dM7aq/u3EEosBm2XCEEaqG9Ua6RFkRO1kuGbUNO4nVqRDe1ODOoJWIuYWbZKnk4uM7HHjltZ29SQZOQX87zdWJeG16byJIi19MEFs+e93Nv0G/0Jux9zuly70m0E6QY/40kLBaWMyR5QYP3R4riTI9vKhS2e2cRsInfB+2qzhclQSstbweeBWGB26RUpBEsmsJ8YHw7XnQrQ7/b+RlgwXbvbMVPC3H7gkpWkIBQ9KbPS3MUeNo0Qfkf0xHgCgfw6H6jYenCSANZasS2XOq3JGU8IBJHGIKyBEbiJXB3abl0OUQ==;
 5:eRXRmqkR9FxFm4apF0x9rwnFHhq7qz2st68eD/fnA4NHTkGRWGhua0mF79bYvJx3HMwfhBPj2IRO6IQxFEQGLFWtWJgHMfEyL5k8vTA5157WY/Qipj1CcQeiB6894r16CBWVC6Vp5GbKjAtdw6wwiz9ri3fTCeMGGgtGEDB28YU=;
 7:hxGHUPI/lgJgpLWfbAdOOHfw2u48OGGRvQ8lRbve/f/uAoATH6JSQ2GTwumZUzkogW4J4VluYLng97iJnqCqr/K0yS3gXuDYsOiL9LBsqcvkRro0rTfRIyHoPrM1cyNfwudc9Gh0tKjV8Svf5BCbLQ==
x-ms-office365-filtering-correlation-id: 8a297dd0-d04a-480e-fe60-08d6609769f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4308; 
x-ms-traffictypediagnostic: AM0PR04MB4308:
x-microsoft-antispam-prvs: <AM0PR04MB43084718C681746E8339694180A00@AM0PR04MB4308.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4308; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4308; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(105586002)(106356001)(97736004)(76176011)(102836004)(6506007)(386003)(26005)(52116002)(2351001)(186003)(4326008)(2501003)(66066001)(6512007)(5660300001)(53936002)(7736002)(305945005)(316002)(54906003)(6916009)(478600001)(99286004)(44832011)(25786009)(36756003)(6436002)(6486002)(5640700003)(68736007)(14444005)(256004)(476003)(486006)(71190400001)(71200400001)(3846002)(6116002)(2906002)(14454004)(81166006)(8676002)(50226002)(8936002)(86362001)(11346002)(446003)(81156014)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4308;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ClyrF6cuW0e86pJ6jaKs8Y8W0sa34Ea1zaX/O8She+p3HucguRcNfqwS8wEgcodJHyG77w534yDzFjIcamAkANsBYwMPZ4S5/ZmK8tQabAvs+FQE/hVjvZcP2TIxsf1UMfBE2NWX3TTHEsikSTHhyjQG0d9S2dAnJEyDvRC6zuSzcTnUwD+Vv9ocJyYDQcJOizADJ8MuwKoKcl5OzADKz6TA4Dn2yegmNtHVJFXTfLLlzGkseoWm2Blo6FKX5WVTaHYeLgtpTryUTBUPyToM8qN7cJwt/wsAMw2dGIZiVHLgC6eajnZSJRUf18l2J4t0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a297dd0-d04a-480e-fe60-08d6609769f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 01:07:55.8234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4308
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_170808_474890_5199147C 
X-CRM114-Status: GOOD (  23.09  )
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

Add SCU clock common part which will be used by client clock drivers.
SCU clocks are totally different from the legacy clocks (No much
legacy things can be reused), it's using a firmware interface now based
on SCU protocol. So a new configuration option CONFIG_MXC_CLK_SCU is added.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v10->v11:
 * break dependency on the arch Kconfig
v9->v10:
 * remove ccm_ipc_handle from headfile as no other users need it now
   and move imx_clk_scu_init() implementation into driver accordingly.
v8->v9:
 * improve commit message to detail the SCU clock difference from legecy clock
 * add __le32 and __le16 for SCU message structure members as it's little endian
v7->v8:
 * add kernel doc for scu protocol structures
v7:
 * no changes
v5->v6:
 * simply the whole clock driver a lot by re-orgnizing the driver into a
   few clock types:: scu clock (merge scu divider/gate/mux) and scu gpr lock
   which accessing is through SCU protocol and LPCG clock which is directly
   accessible by CPU.
 * LPCG clock support will be added in next patch, gpr clock is still not used
   and will be added later.
 * remove old year license as the code is totally rewritten
 * scu mux support will be added later as it's also still not used.
v4->v5:
 * add more explanation in commit message on why put scu clocks
in a deeper folder.
 * move scu clk files into the top directory of imx folder
v3->v4:
 * scu headfile path change
v2->v3:
 * no changes
v1->v2:
 * update function call name
---
 drivers/clk/imx/Kconfig   |   6 ++
 drivers/clk/imx/Makefile  |   3 +
 drivers/clk/imx/clk-scu.c | 270 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-scu.h |  15 +++
 4 files changed, 294 insertions(+)
 create mode 100644 drivers/clk/imx/clk-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.h

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 37478ba..5c26f4e 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -3,3 +3,9 @@
 config MXC_CLK
 	bool
 	def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)
+
+config MXC_CLK_SCU
+	bool "IMX SCU Clock"
+	depends on ARCH_MXC && ARM64
+	help
+	  Build the driver for IMX SCU based clocks.
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index f850424..4abed37 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -20,6 +20,9 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-pllv4.o \
 	clk-sccg-pll.o
 
+obj-$(CONFIG_MXC_CLK_SCU) += \
+	clk-scu.o
+
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
 obj-$(CONFIG_SOC_IMX25)  += clk-imx25.o
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
new file mode 100644
index 0000000..2987deb
--- /dev/null
+++ b/drivers/clk/imx/clk-scu.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *   Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include "clk-scu.h"
+
+struct imx_sc_ipc *ccm_ipc_handle;
+
+/*
+ * struct clk_scu - Description of one SCU clock
+ * @hw: the common clk_hw
+ * @rsrc_id: resource ID of this SCU clock
+ * @clk_type: type of this clock resource
+ */
+struct clk_scu {
+	struct clk_hw hw;
+	u16 rsrc_id;
+	u8 clk_type;
+};
+
+/*
+ * struct imx_sc_msg_req_set_clock_rate - clock set rate protocol
+ * @hdr: SCU protocol header
+ * @rate: rate to set
+ * @resource: clock resource to set rate
+ * @clk: clk type of this resource
+ *
+ * This structure describes the SCU protocol of clock rate set
+ */
+struct imx_sc_msg_req_set_clock_rate {
+	struct imx_sc_rpc_msg hdr;
+	__le32 rate;
+	__le16 resource;
+	u8 clk;
+} __packed;
+
+struct req_get_clock_rate {
+	__le16 resource;
+	u8 clk;
+} __packed;
+
+struct resp_get_clock_rate {
+	__le32 rate;
+};
+
+/*
+ * struct imx_sc_msg_get_clock_rate - clock get rate protocol
+ * @hdr: SCU protocol header
+ * @req: get rate request protocol
+ * @resp: get rate response protocol
+ *
+ * This structure describes the SCU protocol of clock rate get
+ */
+struct imx_sc_msg_get_clock_rate {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_get_clock_rate req;
+		struct resp_get_clock_rate resp;
+	} data;
+};
+
+/*
+ * struct imx_sc_msg_req_clock_enable - clock gate protocol
+ * @hdr: SCU protocol header
+ * @resource: clock resource to gate
+ * @clk: clk type of this resource
+ * @enable: whether gate off the clock
+ * @autog: HW auto gate enable
+ *
+ * This structure describes the SCU protocol of clock gate
+ */
+struct imx_sc_msg_req_clock_enable {
+	struct imx_sc_rpc_msg hdr;
+	__le16 resource;
+	u8 clk;
+	u8 enable;
+	u8 autog;
+} __packed;
+
+static inline struct clk_scu *to_clk_scu(struct clk_hw *hw)
+{
+	return container_of(hw, struct clk_scu, hw);
+}
+
+int imx_clk_scu_init(void)
+{
+	return imx_scu_get_handle(&ccm_ipc_handle);
+}
+
+/*
+ * clk_scu_recalc_rate - Get clock rate for a SCU clock
+ * @hw: clock to get rate for
+ * @parent_rate: parent rate provided by common clock framework, not used
+ *
+ * Gets the current clock rate of a SCU clock. Returns the current
+ * clock rate, or zero in failure.
+ */
+static unsigned long clk_scu_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_scu *clk = to_clk_scu(hw);
+	struct imx_sc_msg_get_clock_rate msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_GET_CLOCK_RATE;
+	hdr->size = 2;
+
+	msg.data.req.resource = cpu_to_le16(clk->rsrc_id);
+	msg.data.req.clk = clk->clk_type;
+
+	ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("%s: failed to get clock rate %d\n",
+		       clk_hw_get_name(hw), ret);
+		return 0;
+	}
+
+	return le32_to_cpu(msg.data.resp.rate);
+}
+
+/*
+ * clk_scu_round_rate - Round clock rate for a SCU clock
+ * @hw: clock to round rate for
+ * @rate: rate to round
+ * @parent_rate: parent rate provided by common clock framework, not used
+ *
+ * Returns the current clock rate, or zero in failure.
+ */
+static long clk_scu_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *parent_rate)
+{
+	/*
+	 * Assume we support all the requested rate and let the SCU firmware
+	 * to handle the left work
+	 */
+	return rate;
+}
+
+/*
+ * clk_scu_set_rate - Set rate for a SCU clock
+ * @hw: clock to change rate for
+ * @rate: target rate for the clock
+ * @parent_rate: rate of the clock parent, not used for SCU clocks
+ *
+ * Sets a clock frequency for a SCU clock. Returns the SCU
+ * protocol status.
+ */
+static int clk_scu_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_scu *clk = to_clk_scu(hw);
+	struct imx_sc_msg_req_set_clock_rate msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_SET_CLOCK_RATE;
+	hdr->size = 3;
+
+	msg.rate = cpu_to_le32(rate);
+	msg.resource = cpu_to_le16(clk->rsrc_id);
+	msg.clk = clk->clk_type;
+
+	return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+}
+
+static int sc_pm_clock_enable(struct imx_sc_ipc *ipc, u16 resource,
+			      u8 clk, bool enable, bool autog)
+{
+	struct imx_sc_msg_req_clock_enable msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_CLOCK_ENABLE;
+	hdr->size = 3;
+
+	msg.resource = cpu_to_le16(resource);
+	msg.clk = clk;
+	msg.enable = enable;
+	msg.autog = autog;
+
+	return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+}
+
+/*
+ * clk_scu_prepare - Enable a SCU clock
+ * @hw: clock to enable
+ *
+ * Enable the clock at the DSC slice level
+ */
+static int clk_scu_prepare(struct clk_hw *hw)
+{
+	struct clk_scu *clk = to_clk_scu(hw);
+
+	return sc_pm_clock_enable(ccm_ipc_handle, clk->rsrc_id,
+				  clk->clk_type, true, false);
+}
+
+/*
+ * clk_scu_unprepare - Disable a SCU clock
+ * @hw: clock to enable
+ *
+ * Disable the clock at the DSC slice level
+ */
+static void clk_scu_unprepare(struct clk_hw *hw)
+{
+	struct clk_scu *clk = to_clk_scu(hw);
+	int ret;
+
+	ret = sc_pm_clock_enable(ccm_ipc_handle, clk->rsrc_id,
+				 clk->clk_type, false, false);
+	if (ret)
+		pr_warn("%s: clk unprepare failed %d\n", clk_hw_get_name(hw),
+			ret);
+}
+
+static const struct clk_ops clk_scu_ops = {
+	.recalc_rate = clk_scu_recalc_rate,
+	.round_rate = clk_scu_round_rate,
+	.set_rate = clk_scu_set_rate,
+	.prepare = clk_scu_prepare,
+	.unprepare = clk_scu_unprepare,
+};
+
+struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type)
+{
+	struct clk_init_data init;
+	struct clk_scu *clk;
+	struct clk_hw *hw;
+	int ret;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	clk->rsrc_id = rsrc_id;
+	clk->clk_type = clk_type;
+
+	init.name = name;
+	init.ops = &clk_scu_ops;
+	init.num_parents = 0;
+	/*
+	 * Note on MX8, the clocks are tightly coupled with power domain
+	 * that once the power domain is off, the clock status may be
+	 * lost. So we make it NOCACHE to let user to retrieve the real
+	 * clock status from HW instead of using the possible invalid
+	 * cached rate.
+	 */
+	init.flags = CLK_GET_RATE_NOCACHE;
+	clk->hw.init = &init;
+
+	hw = &clk->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(clk);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
new file mode 100644
index 0000000..309b4de
--- /dev/null
+++ b/drivers/clk/imx/clk-scu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018 NXP
+ *   Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#ifndef __IMX_CLK_SCU_H
+#define __IMX_CLK_SCU_H
+
+#include <linux/firmware/imx/sci.h>
+
+int imx_clk_scu_init(void);
+struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type);
+
+#endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
