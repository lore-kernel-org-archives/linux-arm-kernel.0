Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:40:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732522173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pr4UWUlY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fpTujP7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732522173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ePk5vzU7n4M1w8XMjhbReNBqpHZR+ZL9KSWR398ikgc=; b=pr4UWUlYthgJk+
	L0f43jSYEYk6GnBW1CMmH7Kkp0Dc+JnI+a8fTi/xXvTv7WKQyUexGprH9dkHDEubmiPTl47dFZIhF
	519jHfeZb8WciqVB/UMBIabuuWfr6L3VPixkQFlP4p09EjQnbVdPAFbZ1Xi2NJnbWRqWyK9WixZPj
	prtNeO+MHk9Am3hY0YIQCs0kaO6S8tEZ+OAW2XDfrU2ofh/xMw3mT2ezOx4M3astmq/0rwJFmjR9w
	Z5e4gPp0j3QB/4++NHNoa1Y0VLnAdh0yfMsZCcdH2MCImf7lsj+pdk880vYEtDKIzEhKMoIduQQ1q
	1XQzl8enFbRFJ4VqfJug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyYHv-0006ZR-9v; Tue, 26 Feb 2019 08:40:31 +0000
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyYHr-0006Yb-7k
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 08:40:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J56u5zKa3o7W4BcRbT/zKdw5Yg0Tc2boP015dYkJvJ8=;
 b=fpTujP7HwMPuOWbai0Kz3Tb/I7xzEQfPvH8OVGqpQc/7+I/dU5ulfrD42pfpfgVc4rrCdlWDhW6UXjU3MgXh6D1MLzzpkUxAvnZMwMz/Xfuy8duYZMQfJPM6sxWv/ydDZLM8o/T1yWAYpA/Qfkkisls0aFygNPMzDSPTbJUtW/c=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB3118.eurprd04.prod.outlook.com (10.170.229.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 08:40:22 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::3d6a:1448:117f:5b06]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::3d6a:1448:117f:5b06%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:40:22 +0000
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, Rob Herring
 <robh+dt@kernel.org>
Subject: [PATCH v2] ls1021aqds: enable esdhc controller
Thread-Topic: [PATCH v2] ls1021aqds: enable esdhc controller
Thread-Index: AQHUza7pjKGN9TrYZE2CwoZXpABaxg==
Date: Tue, 26 Feb 2019 08:40:22 +0000
Message-ID: <20190226084121.41499-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f41f46ff-052d-410a-5d7d-08d69bc60b4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB3118; 
x-ms-traffictypediagnostic: VI1PR04MB3118:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB3118;
 23:tx3d5a5ueef2lGfXIpIJSwdpJl0kj59kPeqmVz3?=
 =?iso-8859-1?Q?P3YyrJkhKLFozQrwgAATZ7t0/evplJCt5OcC9aRT1IkMmqJ8HoJoi++6ZV?=
 =?iso-8859-1?Q?dbZn1sVatovDSSHGp5hnf18g2jZH5ot2Oh0Lnufrggjggnl5wBlzRa8fOs?=
 =?iso-8859-1?Q?f1Vbxykzw5U6K+xhsAfmoAthKJZwqtaXtI9qKX3bLKd5/7VCtgOVMIj23P?=
 =?iso-8859-1?Q?FlwtVsYgW98h29v1WGzu5JakdL4qeVwxl23rOEUqEo+vYe3qYWb2CH6K/a?=
 =?iso-8859-1?Q?WXQSbsujClPy/L7Kq+dthxOIzyY4O+4D484rfB8EGqp/fF882B4KIq9eW4?=
 =?iso-8859-1?Q?yYEFvsNoecd9wmTEBDwuy9N9L6DZ+7pxepF/vCpysTsSkhKsPT8ycb9KMf?=
 =?iso-8859-1?Q?ebpARu6iDKKZvU1QxcdSAYryGSBs9XCol4nyTZ4LeOs+y/fBuJGn9q0vlP?=
 =?iso-8859-1?Q?YY8xIi1xOnCf0DXo4yDjeNcpjQjVy3h0HYSOkn4S4XOcT2K3xJGbVTOFU+?=
 =?iso-8859-1?Q?JC8d1AbtzfYckpihaVLS+0IwoFi2llp6qnCXYIjRm1kVkj27Uq27WIlVMs?=
 =?iso-8859-1?Q?ih6Pqmjqgw/dstVk83M7o7zHSc8wxEvuTosbrER0FWI1GuKSAFINFcA+h9?=
 =?iso-8859-1?Q?eOyvljQB6mrlFZODI8nDJkUmprdAnX8wKMzVvtOBMvKvYuYe8oWv5Lij81?=
 =?iso-8859-1?Q?F8sOUAp0/3MBi+zEfzKwJjJZkIRA2Pd0qKTkBZuQVelUggAfYs3zsMu/cL?=
 =?iso-8859-1?Q?BTqf2ysu4abkHIj953urfOFd2V02lRCS2KJazKTVkUbLVY5VjFFNF2JAeS?=
 =?iso-8859-1?Q?//7V5sxl2ugk0LMaRodQghiuf1QTYVo9gEeIhe5LxHAJQkSdFoyIrdcJ2u?=
 =?iso-8859-1?Q?xXkdZzmjPN1Hl3bLxRdd/wpICIR8ouYib9H8jZzWlfhel/MFagZhcBRwq2?=
 =?iso-8859-1?Q?hv47akWUa4ymveR/8iqfywfmEbLL0X5mmgQGnjbbxR4+maJzlCt/ZJvotn?=
 =?iso-8859-1?Q?Wooy81vVw60jQJv4rkBdKB3psRb4XVt0EL8EaTe5/faMtmvp4pxu8yXH60?=
 =?iso-8859-1?Q?gf9uJNC02vvtV7PJbXCi8DVCxOx/XIXTZq+2u38ppiOku6lXe6HdtxVb83?=
 =?iso-8859-1?Q?r4OE/YoANe4By/RXLWqCygzrHLaq8IYivyO42USEz2vZmWxL9F1vUCbAld?=
 =?iso-8859-1?Q?IhHxtVTFQSW9cSJYpa9WJtgx82eXhw2CKazVUKwFX7lPtERS6uXwRE=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB3118EE783D4341D790F2B266E97B0@VI1PR04MB3118.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(366004)(376002)(39860400002)(136003)(199004)(189003)(66066001)(6512007)(186003)(53936002)(305945005)(7736002)(44832011)(478600001)(476003)(26005)(105586002)(486006)(2616005)(14454004)(106356001)(386003)(5660300002)(8676002)(86362001)(6506007)(1076003)(102836004)(54906003)(71200400001)(81166006)(4744005)(110136005)(81156014)(71190400001)(316002)(36756003)(25786009)(99286004)(97736004)(6116002)(2906002)(8936002)(50226002)(256004)(6486002)(4326008)(68736007)(6436002)(52116002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3118;
 H:VI1PR04MB4158.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FvDOhrqM3+RuBuQQo8hxEU4q3nJBhth7GOthAU2OTMQmkHM3aKNTOUPy0gfO/Ydc0JnV3PtcbaAhSD1AbyKjXOh9ggKB9EuEhNF5QAi6Mn3c4AXELl1voOm9fc3hQzwh879bOkHEKFv+C9e9zRUKskUYX+CdhJ5gy1BnsrCRXvS4sW5P+Xy36Ut4gvdZwxQAMKKr6EhZeXEBJ44LFfdXZW5aL4phIHEFGXxm2vDyoSPJTc6F9gnne/unOzeqvjLA6ift+kG+qpzGAqK4y6nSsxKGgfTI+0MPeYsBoakzHTZV5xE2vyWJiVp26h45kzmEKQyowNZmyn9Nguiqgy1d4vbQsoifW7dtLtC2p7/cH5aDH5q6lrwphldijySu2+FEb6tcmwnOx/hc2h94SllklSbat9NTvm2nSqIPTzEImxI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41f46ff-052d-410a-5d7d-08d69bc60b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:40:16.9735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_004027_274634_ED686195 
X-CRM114-Status: GOOD (  10.83  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Y.b. Lu" <yangbo.lu@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yinbo Zhu <yinbo.zhu@nxp.com>

This patch is to enable esdhc controller in ls1021aqds

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		Add patch code after &enet2 to keep them sort alphabetically.

 arch/arm/boot/dts/ls1021a-qds.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index dac61e7..ae26f8b 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -160,6 +160,10 @@
 	status = "okay";
 };
 
+&esdhc {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
