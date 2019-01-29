Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F77C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:31:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA872177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ATzko7Qo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jOj+48KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA872177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pRXiJlJNHzAlLUAknAki1No13tmvfDbNpcEa0JFLVRQ=; b=ATzko7Qor+Sg5d
	ZpNEuA+SSMuOWcqMAqE8S7NvFFeM489scke9I0F2Ak7j25EJkYRPN3xUS97EtbonuiRVgg9QAFdJR
	8ZMXYSxy8skH58LeETGCewjBilGqor+ngnnukgy/diHP8c/g8GQpmCBUiiRie3UhHyIS57LZywbqW
	DG89mUlv0zm4eshKKYvpHYvnBwQuWTMpkOz7BpZZkUUoBgdONNSgNPTxmp2BiWP5lxyYcYXzWSynN
	ITjojFwImG89SaEE10xIm6emJSgCic3VRHV1ohVg8VIfLlupWYMn33BEVQSxPPojHYEimloDaEJFT
	KSlFXsJMpV4ozZfxmJ7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPjs-00017B-A9; Tue, 29 Jan 2019 09:31:28 +0000
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPih-0007pU-87
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQfMd2j02+uLdh1/xGMojDHPJ5kG753J0u3IpWVGb2w=;
 b=jOj+48KNeQSQj57Hx1YeoqT0mB/zb/mQmYPu+q2qTeANqyTLdNHSnrXsRd8Mk7SAYkC4axa7GZZpYHXyRrktp7ZkZss8i9RKoEIuaDpWW/90TOfs/E7NFsm1eOXSJmDcLgMwTCQbrgyxHBy3dm+3bhzKh8UtK6D3TvRGaVlgsbE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3598.eurprd04.prod.outlook.com (52.134.5.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Tue, 29 Jan 2019 09:30:08 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 09:30:08 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH] firmware: imx: Add support to start/stop a CPU
Thread-Topic: [PATCH] firmware: imx: Add support to start/stop a CPU
Thread-Index: AQHUt7U5Nbu/8bMgXkm1UbFq84pghg==
Date: Tue, 29 Jan 2019 09:30:08 +0000
Message-ID: <20190129092955.24352-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0150.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::28) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3598;
 6:Eq8b4lFOViavS3MIcIxJ0QpuaFZySXYJ3bD+r9KFtOXwVObYl6YFnZUk10l0wkq/58Pk2QXL5uoeS/XFQC8Y3av+Wo2b1BS7WIbugTMTp+EYEAQ9RjQY9uCcjbKJ8r+d+qxbd4iWvHNgFUxqRpsEP7wYyzlhRLXeHytjWhDkTWBVZNRzm4464M0Vd+6mubfGXJr4lxA4CofMWV/8+eFlMlEhgsy/DNz6xO/kCK5Mi6u/iZgsmwAgZg7YjGY0bnUMQv5lc0X+1TyMNAzT3MEFR0/mNWrZ582ec1jo5A0441UpsczaDYRsQYTS5r2FtWJOHCnf3U2NS6QtTw2af62cqGNEpHDgRLX32ZL/2l5+sw++pYMG1BitOJVDfCy2NZYTtqF2Rf9IM//UFZeyF3RzN542XRLYbkXyedmbg5CaHIHoNQc3axE1G55jC8ZqN8lnQAVs75kNXPiFtDuEQrzNGw==;
 5:knhrU7s4Ty5g5du88apslOdSrPycd8ZUsRYFbshmGW+Vc7NVzGlxNgnAjYPgFLvdLf/FPcpsLx3yz88jWWs0gTrBosnj6A1DR6GK3KXRq7WjPaknQRkXyBOpfZnLJmJt6z21eLmYA01LRAk1MNBNtvHd3kkMzQD6zblmyEv+Ylnkf2UTnvAxRd1tQROAFMoxGNetuKFq/4MHWua7qZXVag==;
 7:rv9oDHzVThf1XSvlvRWV1dTimBkDgHsiGCBkjK6ECqFnRXcLnjXmr3oiXZP15txKIeSP1qTjMFNc1LUNXaq0dxC79imquRIP4SI78iAB2a7HbVMSn/q9GyITBIs6lXPCTuoYMPKlTA0d3xeT4W6GzA==
x-ms-office365-filtering-correlation-id: 38f1f0c4-5a35-4570-ec2b-08d685cc5be2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3598; 
x-ms-traffictypediagnostic: VI1PR0402MB3598:
x-microsoft-antispam-prvs: <VI1PR0402MB3598DDA15DD40A61B8253825F9970@VI1PR0402MB3598.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(6506007)(2906002)(44832011)(39060400002)(4326008)(478600001)(52116002)(106356001)(1076003)(2351001)(316002)(53936002)(105586002)(66066001)(486006)(68736007)(386003)(102836004)(186003)(54906003)(26005)(6512007)(7736002)(8676002)(3846002)(6116002)(71190400001)(71200400001)(86362001)(2616005)(25786009)(14454004)(99286004)(2501003)(81166006)(50226002)(256004)(36756003)(5640700003)(6486002)(6436002)(81156014)(6916009)(8936002)(1730700003)(97736004)(476003)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3598;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IECexbmfyUDBpGWUCq7zcUeVouXh4zJStDUaGrPIf9GaUgZkgJjzezISNr3SbOdWNOIZM5rS2J0vrFTMOZqSddfL5e3U4DE7pKUNvnxowylq4oHiDFTTlpu9SwE07C9tGjaAqQcOlTi9e3PYkNYd1HkYwEjKjbeEKe8fhkxzc6fBUPHmDJKk6P9yiiYbJijt1fVWyCFHXarkc4E8/i7ctD4LnaG11o048bW31FbRA8jmn0JawD7ivnPPubfS46I64Kv7szTmv5nnWvByVNov1ihpDsWy/iptvGJol0XWtFCNTy/NSukq3Bev3QL2AOStkTbOaKk0CF9up0jtn+sEZm5VHlj+INIxpbKXleSJ8F1CMSEwZB4qYMt7rzD0husxbHtSr1sJUZLtoTOvzOVZaogtsADaMUGW5C36XvhGQQw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f1f0c4-5a35-4570-ec2b-08d685cc5be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 09:30:07.6241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3598
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_013015_644040_BF457A51 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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
 "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is done via RPC call to SCU.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/misc.c           | 29 +++++++++++++++++++++++++++
 include/linux/firmware/imx/svc/misc.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
index 97f5424dbac9..9fc99a758f59 100644
--- a/drivers/firmware/imx/misc.c
+++ b/drivers/firmware/imx/misc.c
@@ -18,6 +18,14 @@ struct imx_sc_msg_req_misc_set_ctrl {
 	u16 resource;
 } __packed;
 
+struct imx_sc_msg_req_cpu_start {
+	struct imx_sc_rpc_msg hdr;
+	u32 address_hi;
+	u32 address_lo;
+	u16 resource;
+	u8 enable;
+} __packed;
+
 struct imx_sc_msg_req_misc_get_ctrl {
 	struct imx_sc_rpc_msg hdr;
 	u32 ctrl;
@@ -97,3 +105,24 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
 	return 0;
 }
 EXPORT_SYMBOL(imx_sc_misc_get_control);
+
+int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+			bool enable, u64 address)
+{
+	struct imx_sc_msg_req_cpu_start msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)IMX_SC_PM_FUNC_CPU_START;
+	hdr->size = 4;
+
+	msg.address_hi = address >> 32;
+	msg.address_lo = address;
+	msg.resource = resource;
+	msg.enable = enable;
+
+	return imx_scu_call_rpc(ipc, &msg, false);
+}
+EXPORT_SYMBOL(imx_sc_pm_cpu_start);
diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
index e21c49aba92f..c03bf2a23add 100644
--- a/include/linux/firmware/imx/svc/misc.h
+++ b/include/linux/firmware/imx/svc/misc.h
@@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
 int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
 			    u8 ctrl, u32 *val);
 
+int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+			bool enable, u64 address);
+
 #endif /* _SC_MISC_API_H */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
