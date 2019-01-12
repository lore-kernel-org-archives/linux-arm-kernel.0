Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C084C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:04:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60ED20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T61uEAfu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hl3fAdFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60ED20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ONqkvT+k6Lt33ITfr/VhxIKO+oWhKr2sd5Cb0v6oAeM=; b=T61uEAfuPNvE0N
	oOqkOHJuabN9wKtAJZ1uTAK5clK1MH3hlfIEoCWtTBHfNDNppgKXvrK2drUywawoWj0BFx+ZG4qQE
	vvp2r5HVjwGvRKMip2YvQZGaj4X+Hih7EZaEybsGv24HKf1Lam8NliXzz4IpBTBTPCRLRzSr+WUX+
	dvmQZ9miJF83Gsyq5dD6p+zrhKOm31CQJIOyIbYI0004btZabAGO/fFjS/c6nDrXPwKhcjrcxI9im
	KZriwfaB4sNyO42IzhM7TJHZP10V2fOfIoFmYf60nfEzJBHKPla3pzbv5wA8BNKBIEKOJtvV+41b4
	kGwPr8GfmtyfGNtRU0vA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giG9g-0006aM-Ut; Sat, 12 Jan 2019 10:04:40 +0000
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giG9b-0006Zt-J6
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 10:04:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En88h0rMTn4jcliVURUscA7CVfGIa//LPC4X2h86YxA=;
 b=hl3fAdFtDb6u4ZxsGPis4+zk6sO1Ztbdr1xPcEMlP+QzAS8Wplf7CtWfdFADtfLPxkVOyaRrW8x+84WeBVKTLmthXZketJ6Nhh+KWknqvi3wbypUFinV6cFBx/nYqyzCCHQX5BeeiTiVouJ9WZppVwK5MPT07lhOA78baY3iTKc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3318.eurprd04.prod.outlook.com (52.133.18.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Sat, 12 Jan 2019 10:04:30 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1516.019; Sat, 12 Jan 2019
 10:04:30 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Topic: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Index: AQHUql41bLWLh57rrUukHyLcrmJCyQ==
Date: Sat, 12 Jan 2019 10:04:30 +0000
Message-ID: <1547287458-12693-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::32) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3318;
 6:AnvsMpQfAdo1ha7P845IFUEyjlpxLE3k9Nshj6uY9uTbbXMSZPYQN143Mj7jaBKVvDbVsElEOsS3ikJwPHNR9bDUqmFzDpiIuuF24grtXLupn6IGYghQ8zy6MmZ4+1emHSQHyiQ7jXbHyGFjqE3AmWiFp8JpH+Yr+ayfxMTXMhPJLElmdXtGZY43BSsOKWPtSAEpPKZndAiWqbD/iRuUUL7Pedk0bd5PqOpECU8G/H0iJh75N15h/EBm3AgQ9PdOFkwDGXkO5ReGte9N//dYcnJyQ1K2HTB+4YQRQtSKU+UR7u7j/p13Gp4aElFwealSwcB8oZDBxLJU4+nycIcyQJiVvHU9yxvuQsPg2iU/sG4uMOiLYLl7ryplJl7XU2H63D712Y4y5pmBHjdh0Vy5ayxayGdmYLna23M5Kl4nY4rGSEyFVylpN8JG8jeScc5eExhbveJrka4NDYbXtnLESw==;
 5:OoKV0ZLyJdz4PAs9aMuH3ILhbDy2YG3oUCG+nDwhOThlHXWw8g2lr5v1SejM7Z3CIHMZPRK68PBhjVMvAvI8Z5iR48NlpigbPq5qehjILBXmb4NbVbkmcC218SlQWIZfs/WE4raoe0QPAchPrRJ6MYBRAGCBr3j3F1GYkw1czvVvQmhfnyzR53cvywf5GUlgLbQ7qQmbVMPdQdkP+ptkcQ==;
 7:HOaFo8R3zO7CQPRRbaSKGZGs1L8Rp0kO5hdeEJN1LJS4YzThrlxm3iKRLyQ4Yw+6qm6dC9++k/puoXUuN0nJpmUjHiiO1CL/LEYa0uY0YPfkWwH2PJyd/gOVQv8ADpwHStIRw8rNvMYnvDlA0mRtvQ==
x-ms-office365-filtering-correlation-id: e7cf86d4-ddf7-4fa0-1638-08d6787557e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3318; 
x-ms-traffictypediagnostic: AM6PR0402MB3318:
x-microsoft-antispam-prvs: <AM6PR0402MB3318323CEC38306F8A836905F6860@AM6PR0402MB3318.eurprd04.prod.outlook.com>
x-forefront-prvs: 0915875B28
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(396003)(39850400004)(366004)(346002)(199004)(189003)(81166006)(26005)(105586002)(102836004)(2906002)(7736002)(478600001)(6506007)(386003)(97736004)(305945005)(6436002)(3846002)(25786009)(6486002)(110136005)(54906003)(486006)(6116002)(4326008)(6512007)(316002)(99286004)(256004)(106356001)(53936002)(52116002)(36756003)(186003)(68736007)(71190400001)(71200400001)(2501003)(5660300001)(66066001)(2616005)(50226002)(14454004)(8676002)(44832011)(8936002)(476003)(86362001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3318;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hWIgl05vbFhFnWR4mlQddWclJKVxTF4xqwCeu8rX017W3As13Gz+VOdy09pC3U69TYFcULY9tCZfPERCGtYSP3NkjGCIOaSfVBJCFVbEAJCD9sJN40UbE9ee9rQ6J1KKvTqIaRM1emCQ92Vj5ylsliN+dt4KJ2DOgBRSqrTXAs3aEp85bN2AbFGAisO0v7B7c/qTlDPX+EM9McrdYkOqHuHdVtQ/UuflP4k0p69/lKgEBByHCpROGpqiZJXM3/urRyIJKCJ1ygLjv/ho0As/NTnR6aCI+GdQRmeeL8dqz412BdVuUHyMgxFqijni4oAYanCyiRoKO1BkPET+BtaR1qKInJDw51LhMAI1W+2rqurfsvv9uL3VEcYgOFnRiLKSuKBPmM79dnyQg7eOrywQbV/sKOI1yxu7wxK8cbFyvZk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cf86d4-ddf7-4fa0-1638-08d6787557e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2019 10:04:29.6623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3318
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_020435_738055_C77CEB98 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable all the i.MX8MQ configs necessary to boot.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0478ef9..e1d875a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -43,6 +43,7 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MVEBU=y
+CONFIG_ARCH_MXC=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A774A1=y
@@ -245,6 +246,7 @@ CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
+CONFIG_FEC=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
@@ -319,6 +321,8 @@ CONFIG_SERIAL_MESON_CONSOLE=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_SERIAL_TEGRA=y
+CONFIG_SERIAL_IMX=y
+CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
@@ -365,6 +369,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
+CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
@@ -617,6 +622,7 @@ CONFIG_COMMON_CLK_RK808=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
+CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_TI_SCI_CLK=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
