Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDF3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:02:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E02421873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZOEADfB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eDpNnHTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E02421873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IlkLKlHXfXt9v6oJ/wD6tWr0ZVEG0khvjZjSHYt655E=; b=aZOEADfBD4qwpG
	6VFMl45Ffr57ph+A5OK/Wi9f/2nNw+QzxcyP82quuAtRV0Pe35W/RTaErOMkkFFaVHhY0WOW7Gkh1
	A3Lye3peJ+hpsnmXRYc6nz/pwKt+fqlE30FxhtZ/26vewoN+60rZRIOU/hhGYz0vxMXco/62SJ8jE
	q+8sTNmGbOp8Pmls9nsj7Mg1e0S/IdF3xpuAdSfpfpXbnoGpYyuz/PA9oXWVtt84eE6/+KHGaHLHT
	6w1BFVWi/Z8MUHI/84C2mJqywKcCL5HJT5NWkSpPjYMY/Pd9H01lX1fYCQdRZ07y2K0Jt6xJr/U8b
	U/1jfr0aIUG2RBT8oo7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHpK-0007C6-OG; Tue, 18 Dec 2018 16:02:34 +0000
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHoV-0006Ol-W0
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 16:01:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n23TKsxdiAFAs1kKf5Joj8a3REbJVBEYGfj4t3yYS7U=;
 b=eDpNnHTJlOnjL+jMArTqwSs4+xLGjetG20I+umLz9V+K6pJ1jrcEQb6Hu8VD0y87YrxEFyARndXYlV2VxEsaBsAI6PnsGc0GOJA2dPZV4cr+C0WCutHGW2DtkpXnCuGbnqYeGkUE9nbJkIYal2tXsZy1uY+vZsZMitPaKOQTqkw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5987.eurprd04.prod.outlook.com (20.178.114.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 16:01:29 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 16:01:29 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] firmware: imx: scu-pd: add fallback compatible string
 support
Thread-Topic: [PATCH 3/3] firmware: imx: scu-pd: add fallback compatible
 string support
Thread-Index: AQHUlurwA0NDQnzmX0qXNHEGsWcFOQ==
Date: Tue, 18 Dec 2018 16:01:29 +0000
Message-ID: <1545148524-658-4-git-send-email-aisheng.dong@nxp.com>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:36::28) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5987;
 6:SlrRk2vUCeJQI7zq2GQ0carQZX7x9uML/XdrO5hwuQnQ9RzeQIRE+frupJ0o4dk/Q61yZjyJ8XAKlbvgJQVGqeY08X2cUu5BnU8r0t1yeeWzAcD0MdVgsAkW74d/VTsM7Mv5ZMOLGS2cc2hG4R+s3QxkJQqLFKjHgqTYDvoEsSsA5MQZp19xaO+650is1/vwcwhFLbZrzudZ7XBWww5bRBwwJdPXTZHjFMP9EKJ2mBbUQEdKWZfvii9AUUCJOGqrpVnztt9eNBwUy6IFb2aMICfJgY6J6F/Txctlg5gw9tTpjelPig6I6on44k0YsPob3J8EapiwmbtQ6BXS1MCufwSBb74i3mw46ASr7Bjp0O8yuW802JvSENwh4iTDue1TYk3N9wUIpMPb16oc03rf43B+yI2n3FArpVwI7NUITpcEbwpi3qHJuDTFkKDuakMK9eE4+J5WzOHApavQhX2UKA==;
 5:D62hEASvyYJzx2FirrEm02wpwp0ig5dTv8fg4EWsx69ptNgzA5ILRM/xHLCNezR4X4troHcQpfEsY7HXqHaeV7NjkRyDylsLfmXneAxw25vdrQy1K3XnF7Bjk5x64BcvxAPPLv7DCvV310SpRo0YJn8edpkzM0tpvY2GiK4pID8=;
 7:+n0YgopbuLtl9FNBYRaTfL3+AyInzg5QB6FJ5uK7HTofNh5f2wd6n3RVvUk7miYsW/CebGGdCfT+qDa+8IzwZ8bK7dytrgLTATxX4Vcq/KBPq2yEbkqJ/yTZUJGlPB0CJJIoUwK6zzb8J07vX1FsvQ==
x-ms-office365-filtering-correlation-id: 3d6bcdb8-5f70-427a-8b11-08d66502125e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5987; 
x-ms-traffictypediagnostic: AM0PR04MB5987:
x-microsoft-antispam-prvs: <AM0PR04MB59871725C2A9A491575EC21E80BD0@AM0PR04MB5987.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5987; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5987; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(6116002)(39060400002)(4326008)(3846002)(44832011)(476003)(486006)(2616005)(6506007)(386003)(76176011)(102836004)(25786009)(52116002)(2501003)(5640700003)(68736007)(6512007)(36756003)(99286004)(6436002)(54906003)(316002)(53936002)(14454004)(6486002)(6916009)(186003)(26005)(446003)(256004)(11346002)(2906002)(305945005)(478600001)(71190400001)(71200400001)(7736002)(8936002)(8676002)(81156014)(81166006)(86362001)(66066001)(50226002)(97736004)(2351001)(106356001)(5660300001)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5987;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lmu0rzvXuFYQIba2BgdeL/kEheXseYVFdUdoags79wltscGG+W/UEazVnP8D0tbsRQgJHID0z0Y6YNAlBiSyPEarYc8nIDLQvD3F9LBDMmbsAkIqGLTZbLhpj2IeGttKypMfBDSE2IVIqEwHSHBI+6byfRSunOC5odZnigQwQo9Jn90wbdR/snHa6pQ6NvzB6sBlvtlzQ4yym96MGUVqRFYXnlV6hBkopXlJ0d7lFcoGMiZyIJIJl1bbdmCvaOYuOafd+mWajZo2w8JPtw9SQIPpnzrOKh3kOIVTgpaWoKK2EcyWA6ULaFNdVXIj8pv8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6bcdb8-5f70-427a-8b11-08d66502125e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 16:01:29.7498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5987
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_080144_619593_6E37FF81 
X-CRM114-Status: GOOD (  14.55  )
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
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SCU power domain can be used in the same way by IMX8QXP and IMX8QM SoCs.
Make the driver support the fallback compatible string "fsl,scu-pd" to
allow other SoCs to reuse the common part.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 407245f..1aaae98 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -321,6 +321,7 @@ static int imx_sc_pd_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_sc_pd_match[] = {
+	{ .compatible = "fsl,scu-pd", &imx8qxp_scu_pd},
 	{ .compatible = "fsl,imx8qxp-scu-pd", &imx8qxp_scu_pd},
 	{ /* sentinel */ }
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
