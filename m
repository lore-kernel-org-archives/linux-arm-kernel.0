Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9872FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:42:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3EA20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K23rVcyb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wt1PS3/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3EA20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sbrHHYbKzBQjR+zucxjky7w+qxgz/TeUPXxfv7w79SA=; b=K23rVcybTug2Gw
	eUE+pjBdJfzNtIgHZe3AxsYRhfwqYBCgIkh+K9ySZtE42wcieRohDpfLA+jWG+zqpuAGxT5BzQts/
	nBPWtAdVafidyozooJJScIQ+jWBnjBTtumImWy8MZ61gKV0eroeZ8EOLDWTqsS7jSyCXI+IZzgnDd
	LUMz7uXjc5QM95fTdqQ7LbqfuYVw8WY+XWdhfmtFSfCoql2MKpiAUt8dI6r7xXv9moD+/1LLYnsx7
	iTi4vswVN11PwKxluTLFoU4Iuf2dmukdk2CmWOd0WVi40iYV/cnBEIWc+0cQTS4XBR+agLZN+JaIS
	1zKVFfnS/sT5XAO0E22Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjhi4-0007Gx-5c; Wed, 16 Jan 2019 09:42:08 +0000
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjhhz-0007GN-J2
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 09:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUuTw/hmMqQHInaxM6L2I4dPTpCnagDU9oYvb76DIA8=;
 b=wt1PS3/bFXQDUYVez4SvLPFDpbhaRVfXhUV3Tohqw2URs7jWNrK4ZqM6CZnpDK93elHlqDJdKS5MnLlXjtlEj1o54Zaw3000Xds05dvuFdFmuj52fVSuClR+jLo8z1gaqn5Ypci0Geyv9Pr9rqQ5RcgP4riir3coN0TmoqZZw/k=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3704.eurprd04.prod.outlook.com (52.133.28.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 09:41:59 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 09:41:59 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Shawn Guo
 <shawnguo@kernel.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann
 <arnd@arndb.de>
Subject: [PATCH v3] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Topic: [PATCH v3] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Index: AQHUrX+6iNHNEsNwY0OPyE6azmOANw==
Date: Wed, 16 Jan 2019 09:41:59 +0000
Message-ID: <1547631712-24544-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0114.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::19) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3704;
 6:q78+IsSCHEYhPr98OooEvyKwicNkmlL3VSDsS2/zM6LbU7oPtf5OpfvKWA+mdRsaMibN2rYfmy+DdaRt/kEDaEn8QuwJskv4Y/PHwOUDKx2nf6xiXuZm+c0u9ze1m+xwftzZlMDUJA+HKm83bcX7/4cHj4dWBtWFBZ3/PdBLK5P88Ljrbp/pwvkZdKZZaTpvqYm6c859C3lTdv0NsdfUE7WbkctYQlAMm00wp/zHvmR132k9bZkkVqKDeun2neRro996/FGSL23ftLJDJ8yln97oMwG/kWrfyavhToUL9mMpIeZkr68X0SUj3ytZsIeJB3EtccgTVkXIiskkdrnV1VCTTuIC/rviyklyx/7TiV/sM5qRroltio8NBIrO12PrCUhHRwiRUB2NloJw+mTuc61spHIo/MDu5+mrUACvskRoUDPKzlfHyk7X5RVbUWQGRe+ECjI2IspMHzfKrjQyMA==;
 5:YbB4jEyCaTmAvowdunyw+I79cp9BOeY0YxdkdnjZTRb4UcmHEjb7YC8SlPx2ZfWBvo4dhswMiFRbd0eDWP59vVcPxnC4tuskTi13FQEZcLEKLqKXg60Bn3nwCmeONsx5fYjYgozeRNrTFNFn9h9IVZLumNhORJ4YH20a32QTzuDMwSs7uugzvUtlqyiXh31wgdNClW2yDXd/OpSglJnpIA==;
 7:fC3I55PBHn+37UpGE8sEXuuMQh5Qe9UctvQVh7PRcYbuzZ3DMIB8uACtBR5nANWi6V6/ThocayQRIRH2rUqPWVS/qWPFVFblE6NkMdPdIDM5IB3yEEsLfQ5NuDYo6u5G2mlCbDyBSthCdqWlllKzHw==
x-ms-office365-filtering-correlation-id: a5f131bc-937d-4a4a-c0c3-08d67b96dc9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3704; 
x-ms-traffictypediagnostic: AM6PR0402MB3704:
x-microsoft-antispam-prvs: <AM6PR0402MB37049D8974ED8C6F84C6C810F6820@AM6PR0402MB3704.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(189003)(26005)(6486002)(50226002)(186003)(14454004)(6436002)(316002)(81166006)(5660300001)(52116002)(99286004)(54906003)(110136005)(2501003)(8676002)(6116002)(3846002)(71200400001)(68736007)(44832011)(2906002)(36756003)(71190400001)(81156014)(14444005)(256004)(102836004)(386003)(478600001)(6506007)(105586002)(106356001)(7736002)(486006)(305945005)(97736004)(86362001)(8936002)(66066001)(53936002)(6512007)(476003)(2616005)(4326008)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3704;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fsGJD2GYXWKdzN6lFR6bVTnrAuIvVV9EqC5eyYz5khGWZvkBUrTfS0VeP54OXJ98EGJfxRG3+Xwzq2gCxNZThOAu0YobIEt+1tjWuw1Bokoi4vOB8kprFStsIOowCcGe2s8/4b/Ifrtm+rpaSTZJe77q7EJD4fIqJKQ32jo1IgH6Y9oA43qz2G6Kts3n01L9bOKEfNLdYMlyPqwwAB4qp1Gc4cJNGExyGxplKUBHZiII7qP01ttfJvePTK8KNePiQOspNotaCtNyfcN42/ASqbXgaR+YOgMmf1qti9btmo5I1nWofiQ490Kd27XdJfJPjHrD8WALIJ0piiHLoZqvOMwt49fA3mk88bazh1T/t4cdjOjm/OhcBDvMAXFy5LQ7urkPIaPR3XtMH0/hdKK7X+3yv22sWpx68U9zd588prw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f131bc-937d-4a4a-c0c3-08d67b96dc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 09:41:59.0690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3704
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_014203_790204_9E841FA5 
X-CRM114-Status: GOOD (  10.98  )
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
---

Changes since v2:
 * run savedefconfig to order the newly added configs

 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 032912e..6e5af25 100644
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
@@ -628,6 +631,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
@@ -661,6 +665,7 @@ CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=m
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_IMX_GPCV2_PM_DOMAINS=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GENI_SE=y
 CONFIG_QCOM_GLINK_SSR=m
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
