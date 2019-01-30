Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E02C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:40:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE6420855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MN0wFNiD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w+PSYujK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE6420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nPUTNwqmHRpQHzX7mY1ZljWl0WQfg1kg5xLUS857YTs=; b=MN0wFNiDb+M7Z6
	hmlOjEwhG/3hPHLlh8grpPcVgoCt33Yq3ZDBMvgtdoT+3800fwfGAfJ1HByL04o5Sl+l3uMHIU1pG
	Djb+kmQgVeSFL2KuDA/u8a7F+OG3/MnVn6pTYDlzv0L5eNmYRWApw0Xu2qWiBS42/jAWLPpSwOa2w
	ric3gMMT4XW0w7g9BbDr6jcVn8vjbnPkSGzzuZqcxttx/cNGsgvkZ2R7WQXkN4xO2iaXClZ6xCnQ3
	VzlA8A7N4ulf/+8ZPJicumAHeRGWLFjYKZAmYet6aI831i2fMgbCBa7hm+k3l+S1Iswp9fcUpyD6k
	Jq3iOOWHHdFB+TN6Rjfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goq5l-0005Kg-13; Wed, 30 Jan 2019 13:39:49 +0000
Received: from mail-db5eur01on0616.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::616]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goq5I-0004tO-FE
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWnIF/proLAu2dNjVakTmoOs/RV62NbFopF2IgCw1I0=;
 b=w+PSYujK16/dAXDmTRvYdwA6hqHEIBbUg5tlLvc1I3KHgLWZ9kMWG6KBKVjebhh/jltcM5jS66by385DVxhVnQIOnaKWi3NxLjG53td0uqcjh9sA7mkjl6g9yGJMi5Lc1FSfGXveflmPIo5JAhZjH/l3bWZUQpuMakkqo3XWZjA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5844.eurprd04.prod.outlook.com (20.178.118.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 13:39:15 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:39:15 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 1/1] clk: imx: scu: add set parent support
Thread-Topic: [PATCH 1/1] clk: imx: scu: add set parent support
Thread-Index: AQHUuKEx5wW/zvLIHEGxAAYc3mdDGQ==
Date: Wed, 30 Jan 2019 13:39:15 +0000
Message-ID: <1548855205-12249-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0055.apcprd04.prod.outlook.com
 (2603:1096:202:14::23) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5844;
 6:jgx4P7yYLpgxZClNhGRPqlWSH6Lr/0oQV3E+lJ83ShMHRTYOh6XyS4AqaEklLJ9Q2ZHb62ABpxuNk59o0grccS4t11n3KwCLOFQxA+x7VgPtNNP0l7xXrRspTtz4astXE1RCyvuRv+IvcOu+OP0YdGiVLho01h4ZSW5/vbkYPgwedmWl9xSvtQjjN5liRXH4uEeOwaGPJ+oC2BEFILcP7i/TYW/9tLnAOiSAle3QPyqzTBmZJniqL2Msj8A8aMELk9FEHDl8nN7/zkWS0ByQ5++dKIIeTnEdKLNiwY0CZcjqKhVGpVEvT5u+kz/6j5ukWW/X28ISiKIpxGlD9dUZiC0KNrNmOc0wP+ESEy5RKBU4okiMGfxhTZ1j0lQ1R/Slj19SOXILqh2YI5euDwLqkSaTS1j+FeVlsCzNUL7/nS0iZ/VkiSuSkOdWURzpcPcddSXOi4Ik6mELnzuw+BJjig==;
 5:LBbHbazbaXkVC+kJoCX0ZQIEaiooc1U7A5rF0P+Nqi4bpMctlWu7aDIu78x66/E9jwYgI2nQb5P3N6SoHezCUSwcPv9uQApjP6XRYKYRjdB9y07NzeksloJ5sSCs2/1KsS72KvmuToOzX3qnDhf8ztU7TrtoDptm7VnVd8MajY4110rW0rj1kPuhoT6YXs4+QLmSXEIeLupvOefM5oApZg==;
 7:iP9tb3plb2G/LC2l7UvE4q35hjeqy/jU6/czaiaOFsjrSlmnO+ov99DtHEwYlOJzJbvW3879Es4ECvLW73AQYfdLoZTeYa4jKbyr9drKoy+9GoFsIlZMrFTv83eyFKxO+HREi+ehXiIUhZlUdixOVA==
x-ms-office365-filtering-correlation-id: 551cf0d0-cdbc-4503-696f-08d686b853b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5844; 
x-ms-traffictypediagnostic: AM0PR04MB5844:
x-microsoft-antispam-prvs: <AM0PR04MB584442762381F650B54E2B1C80900@AM0PR04MB5844.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(396003)(366004)(136003)(346002)(199004)(189003)(8676002)(6506007)(81166006)(8936002)(53936002)(6916009)(2351001)(305945005)(81156014)(4326008)(7736002)(44832011)(68736007)(26005)(2616005)(71200400001)(186003)(486006)(386003)(50226002)(478600001)(476003)(25786009)(71190400001)(6436002)(6512007)(52116002)(14454004)(102836004)(54906003)(99286004)(3846002)(316002)(6486002)(105586002)(5640700003)(106356001)(2501003)(36756003)(14444005)(97736004)(86362001)(256004)(2906002)(6116002)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5844;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +qjkxK9TGF/H8dNylvFvuWRYiWF72AM+VGvlJL2LKYVCkM2VDuX16/PVA8SQjzSmDcxL0EKLPUfR8FIPbHrC4uwvXNpCFr8cx6oEReJZs5cVFQ+H9/qsH8WFac1YHO1j3QD4MZlTOU/EhBUq93k9aCX2mNQTbKsj9XOmf1wRFJ/rq/eB7EIgGI6HOTT2b6AxvhYh5sCPmqhO28w+WQ85t/BG/vP0dcSNj9IxVZHFkLXLU5P7LQtDXAQL0Grxt3jllwVUU6hqwlGvblrAcJ4aFK++43zb8SFkWEczWhdExRWgdfTMd7isvLeGpGh4Z6B9pVB2MKd6ANktqdXxSNQ7IRiOr9JZRR77RIAM0JpfadNnjvIyvNAajY9gd+27U4jHxlC0hRQwMNuGwAt1hOmDdywcbUwrWV9e4/pqLlVnY6Q=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551cf0d0-cdbc-4503-696f-08d686b853b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:39:12.6327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5844
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_053920_512113_EB7CC70D 
X-CRM114-Status: GOOD (  13.14  )
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

Add clk scu set parents support.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-scu.c | 87 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/imx/clk-scu.h | 16 ++++++++-
 2 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 7ccf7ed..3c13c41 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -66,6 +66,41 @@ struct imx_sc_msg_get_clock_rate {
 };
 
 /*
+ * struct imx_sc_msg_get_clock_parent - clock get parent protocol
+ * @hdr: SCU protocol header
+ * @req: get parent request protocol
+ * @resp: get parent response protocol
+ *
+ * This structure describes the SCU protocol of clock get parent
+ */
+struct imx_sc_msg_get_clock_parent {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_get_clock_parent {
+			__le16 resource;
+			u8 clk;
+		} __packed req;
+		struct resp_get_clock_parent {
+			u8 parent;
+		} resp;
+	} data;
+};
+
+/*
+ * struct imx_sc_msg_set_clock_parent - clock set parent protocol
+ * @hdr: SCU protocol header
+ * @req: set parent request protocol
+ *
+ * This structure describes the SCU protocol of clock set parent
+ */
+struct imx_sc_msg_set_clock_parent {
+	struct imx_sc_rpc_msg hdr;
+	__le16 resource;
+	u8 clk;
+	u8 parent;
+} __packed;
+
+/*
  * struct imx_sc_msg_req_clock_enable - clock gate protocol
  * @hdr: SCU protocol header
  * @resource: clock resource to gate
@@ -173,6 +208,49 @@ static int clk_scu_set_rate(struct clk_hw *hw, unsigned long rate,
 	return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
 }
 
+static u8 clk_scu_get_parent(struct clk_hw *hw)
+{
+	struct clk_scu *clk = to_clk_scu(hw);
+	struct imx_sc_msg_get_clock_parent msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_GET_CLOCK_PARENT;
+	hdr->size = 2;
+
+	msg.data.req.resource = cpu_to_le16(clk->rsrc_id);
+	msg.data.req.clk = clk->clk_type;
+
+	ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("%s: failed to get clock parent %d\n",
+		       clk_hw_get_name(hw), ret);
+		return 0;
+	}
+
+	return le32_to_cpu(msg.data.resp.parent);
+}
+
+static int clk_scu_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_scu *clk = to_clk_scu(hw);
+	struct imx_sc_msg_set_clock_parent msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_SET_CLOCK_PARENT;
+	hdr->size = 2;
+
+	msg.resource = cpu_to_le16(clk->rsrc_id);
+	msg.clk = clk->clk_type;
+	msg.parent = index;
+
+	return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+}
+
 static int sc_pm_clock_enable(struct imx_sc_ipc *ipc, u16 resource,
 			      u8 clk, bool enable, bool autog)
 {
@@ -228,11 +306,14 @@ static const struct clk_ops clk_scu_ops = {
 	.recalc_rate = clk_scu_recalc_rate,
 	.round_rate = clk_scu_round_rate,
 	.set_rate = clk_scu_set_rate,
+	.get_parent = clk_scu_get_parent,
+	.set_parent = clk_scu_set_parent,
 	.prepare = clk_scu_prepare,
 	.unprepare = clk_scu_unprepare,
 };
 
-struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type)
+struct clk_hw *__imx_clk_scu(const char *name, const char * const *parents,
+			     int num_parents, u32 rsrc_id, u8 clk_type)
 {
 	struct clk_init_data init;
 	struct clk_scu *clk;
@@ -248,7 +329,9 @@ struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type)
 
 	init.name = name;
 	init.ops = &clk_scu_ops;
-	init.num_parents = 0;
+	init.parent_names = parents;
+	init.num_parents = num_parents;
+
 	/*
 	 * Note on MX8, the clocks are tightly coupled with power domain
 	 * that once the power domain is off, the clock status may be
diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
index 52c1746..2bcfaf0 100644
--- a/drivers/clk/imx/clk-scu.h
+++ b/drivers/clk/imx/clk-scu.h
@@ -10,7 +10,21 @@
 #include <linux/firmware/imx/sci.h>
 
 int imx_clk_scu_init(void);
-struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type);
+
+struct clk_hw *__imx_clk_scu(const char *name, const char * const *parents,
+			     int num_parents, u32 rsrc_id, u8 clk_type);
+
+static inline struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id,
+					 u8 clk_type)
+{
+	return __imx_clk_scu(name, NULL, 0, rsrc_id, clk_type);
+}
+
+static inline struct clk_hw *imx_clk_scu2(const char *name, const char * const *parents,
+					  int num_parents, u32 rsrc_id, u8 clk_type)
+{
+	return __imx_clk_scu(name, parents, num_parents, rsrc_id, clk_type);
+}
 
 struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
 				unsigned long flags, void __iomem *reg,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
