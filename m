Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADA5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:43:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A946120840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l3ircZf9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fH8uIebi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A946120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cAwuRHEIuSux3lb8NxLTw46vWdfbUryF6YSlvQfQpAs=; b=l3ircZf9TPwtZh
	qd/9Y2g1jRlEV3aVJVKeeiV8eYCX+ixcrSSpyTOuwdAnsVOJJbaKpi9OMc0EAT1uBHQpIWZPeuZ2c
	ajddhu7ogGT4MZBlek6vCR83HxkTmuSRaaJa24lWhKnVnVRm58+eUy7CnV3xd1QSUDrWQKZgN/o8h
	a2wvl8xYDLhX8nozNanbuvzCbIz+xqJFf6RUkOdiGWdqM5ddlBoGNt4bKHQ0274jxLKvk/+g/uexI
	xX2H26F6ykjIrJ9PzroblInP3LjDAUBR+GRSjuipZig964bY0cI2rz3q8NAej3aRxp0YtWGe5ZRFL
	SwCBoWhu3MBT9d3utobg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjgms-00078l-E8; Wed, 16 Jan 2019 08:43:02 +0000
Received: from mail-eopbgr150085.outbound.protection.outlook.com
 ([40.107.15.85] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjgmp-00078E-Fg
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 08:43:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8W/JtJ4Q5rfO2T4ddkOBdOcbaoOZ18UOe9Enjaw1Uw=;
 b=fH8uIebieQ2HKnYYE6QQ8CGqezyUe/8l815LOt6kM4MiW4LE5cmB89jf1xxYFPvyoRewUNwAAPtD9ZYj+QsYBOcED8UrM3GBfLl4ur8pQpGNtlCFEc+SmLiuRcPPTRBH8BIdPElYGdmUQdiGhpTJlsTc5NfuB9BoklDy4+b/CxE=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3863.eurprd04.prod.outlook.com (52.133.29.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 08:42:55 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 08:42:55 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Shawn Guo
 <shawnguo@kernel.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann
 <arnd@arndb.de>
Subject: [PATCH v2] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Topic: [PATCH v2] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Index: AQHUrXd5gLECNJi8BkujguT4zpB5Dw==
Date: Wed, 16 Jan 2019 08:42:54 +0000
Message-ID: <1547628161-20461-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0072.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::49) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3863;
 6:kBo1eRBiQ2uWtVc4zbknj598/YIpqUdB1UAbdiTXBLeGflFk9DJ8OsF/BUnJ7bAkyQvetSa3VnSWgNJaAvwnCRUWiVFtLN3BVqfgrjy17zFgkqWP9C1yjidGoVZGiNgy2GlhHzgxfQMVBmwJWR+6L4cJNlC6V2gudHK9oZ/7itYvgvLrH0jcOc2s40q7GEyqzMZeyrbzrKr4LMD2bAfZXNqBxIwjvyu7YBW0jHLTN6lhPwmTwqvDEXe4DTF2V+Kuxh4jn63G4bUHQGRWDWj19gjYmrLFp7gDbi0FmbTDt4KO5Ixh6v4cdvw6YSfMV1JkQutpJqVFzcwVn63A5UKZ2BSggysDeEq4v3h5eiK1bwZGEYmeaBCIwlNZZ/JTCTHmdL8gyd97ftD/xsfbjCFJfd58ATj5Dn/5WnjBA2VhFzJddlLis/APKvYIwn3g4XjERbOFWJXGWnaL2pAikVPL+w==;
 5:eXZKucCKtIkGik7IiyYuMg0sM5aq3qc9tt2q9IX9FOIfSev7w8Z5P/YZqQGK7gSyJ0gD4T6g4/BBgFiSd3iJnBi2q6JQ91Vmv96bqpOJjqw0Mc45G2OaiXII5QHkjPzP2BWNtxyKTbGUV4hMP4LihQ5fUeYKjVCjuZ0mq7g7l96MpQxSI8WNLTCjdzOzUban2MyU/MHNRE6c6vJcLqazgw==;
 7:/ef4QiP5o+rwKwHYTRhH8zsZfos5TvWf/DUhrxpA3qqZzk+PqpegSCEL1jQOBTq2s+R4wT9mNuRUfBbNwZnyq4uTsZi9xABHyfGZejxGVmvNEVLn/uFCZHzKBNg1cN3ek/9JsrE8uo5yg2VzUGwvkg==
x-ms-office365-filtering-correlation-id: 77db1e1e-8edb-4776-240f-08d67b8e9ba3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3863; 
x-ms-traffictypediagnostic: AM6PR0402MB3863:
x-microsoft-antispam-prvs: <AM6PR0402MB3863F011824E65BCAEAB6CF2F6820@AM6PR0402MB3863.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39860400002)(199004)(189003)(4326008)(102836004)(186003)(256004)(2501003)(6512007)(6506007)(305945005)(53936002)(7736002)(52116002)(26005)(14454004)(486006)(44832011)(5660300001)(2616005)(476003)(386003)(25786009)(478600001)(106356001)(105586002)(68736007)(97736004)(66066001)(2906002)(36756003)(6436002)(6486002)(86362001)(99286004)(316002)(110136005)(54906003)(50226002)(81166006)(3846002)(71190400001)(71200400001)(81156014)(8936002)(8676002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3863;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zwsGdYNSMZmUUR4hGH+lD1ww+7oEooJISMgIrLHHPHP7YcgP6VD7c9+g4eaDuFW8z4o1YtyRmIL12CkeZrf46AeTV357XnHIer+QXO1cr7VNUq0CARK0mNiPbrm5bNx/Uv2Ftw0kRmbWlQDTjgc0+5RhYL+sRmuzNjL+yktdXYqjor3m90ATNf6sdEx85PJPV8WX2LXfOxg/ikPxGM02wjRafxb3kINUqaqezkEfWKp9uOaCMth+88WLMHK9HNTDogIGRe4CF8PCFvmqwbyhbFBmm/OC8HJKXFVForjVdvfX4vIA16jkdQQUiF+GBQkHskXyWQt7yTh52tNXGM30HOUzmxMRAoCqTyZVCe2G2eaDrF/WplVQKPWLTTW29oLqrdzXxN2R2WC4Pi5TCAOjcZw7voAhNzjHWkESAlyx1Pc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77db1e1e-8edb-4776-240f-08d67b8e9ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 08:42:54.0972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3863
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_004259_527207_62D70657 
X-CRM114-Status: GOOD (  11.14  )
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable all the i.MX8MQ configs necessary to boot.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
[aisheng.dong@nxp.com: add CONFIG_IMX_GPCV2_PM_DOMAINS]
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---

Changes since v1:
 * added the CONFIG_IMX_GPCV2_PM_DOMAINS config

 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 032912e..7633fa4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -323,6 +323,8 @@ CONFIG_SERIAL_MESON_CONSOLE=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_SERIAL_TEGRA=y
+CONFIG_SERIAL_IMX=y
+CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
@@ -371,6 +373,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
+CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MSM8916=y
@@ -626,6 +629,7 @@ CONFIG_COMMON_CLK_RK808=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
+CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_CLK_IMX8QXP=y
@@ -665,6 +669,7 @@ CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GENI_SE=y
 CONFIG_QCOM_GLINK_SSR=m
 CONFIG_QCOM_RPMH=y
+CONFIG_IMX_GPCV2_PM_DOMAINS=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
