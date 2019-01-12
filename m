Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FB3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:56:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC67E2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F3NP3wIp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UHyk3p7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC67E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cudFVTxA+EqlrQxjLLGLPIVLJ7bM1be0NUr9m0IZh1c=; b=F3NP3wIpE2sWGk
	lrRBRtQXRbMZF1ZazDAxrn0jkKuKWMnAFWzvdROVEsjeBeHrTuVI9GIDmv6WvOj+9DuG9IRHnhvB5
	duotLq7tsvmTG5edTMzxx0Pdu2RDd4rZ0yJZrA7qdjXfKtaqJCbQFopvsjBVkGlZrpuEibu320yYg
	XkoomwbuUKPyXGhVI/cJdtNZbEt5iUtNPOp60CuOMpX3N+C+2EWauMij5yhTn3YtYASckDl8U7lCT
	FoSBqE1rKyqGQQ/a5rHtSA+cMMUZvM76eJiYszA2SCT8OHCHDF8CAjopgF9c0cLBrQmLqlLAdxd/1
	z6Itwzzhb4vDlAb5Ddkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giF5w-0003bd-3M; Sat, 12 Jan 2019 08:56:44 +0000
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giF5r-0003bB-QK
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 08:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLgZGH5NR6OYCg2MPPE1vEeZsvGGhWroQ3SkYE2XOiY=;
 b=UHyk3p7Aj7tgEJ7PtPaTNI+8u27+znw/wVVQOnAfaykY7VTlNF0rnKjShFbIPpR6q7flEgeAuMxIvYG5w9dRxXi4sIK3doyZ242/A5h8xQdP2MlX7KB6yYpa/5B0rcresSHm8Wo5uvQk5Nbo+1J9MYt0B0bFLZkhDw4ZeK6uXdc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3928.eurprd04.prod.outlook.com (52.133.29.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Sat, 12 Jan 2019 08:56:31 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1516.019; Sat, 12 Jan 2019
 08:56:31 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v3] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Topic: [PATCH v3] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Thread-Index: AQHUqlS2K5Efx9sZqEO6drzmPmyC+A==
Date: Sat, 12 Jan 2019 08:56:31 +0000
Message-ID: <1547283362-13266-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0026.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::39) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3928;
 6:EUAPwZQKPQQi6nYpJ3jPNIp1Jp/WCFn1v1R4fDYnoZdJ4+QWmYiUEftBJeZJP55dO8ZxwprOak+4SEm3V1HfGnTpTIBcUld68mk8TjBSVba8brhifqPRaAGgREyJgZs+bQC1EQiumt7TuBrnz2ATT0mrcZtQPZmpxfrMsI9m6K4GTQ6xkvOV76y9XtnG+gITzFQQkUm1xQ4VN4lZ/k4OW2+I/rSYcCfgsqqGjCb7CK58hYAvkVJgRiw/G8MvRoglvOkPUz60HpqD27IaW+3dtLnOT+HsPdL0mPOcZx1UoXVwt+KnOmyBj074ITy1fkLW/z2uMOCJ8D+cEej5uzQhTNtlpEoGgy+97DI6Dz0UOCEaZqO/3t/gsK5a+WkXwxSeWGpFtjxZaqi3TgdK/40d7Pv5vaiOs1rDO97X6DhY4TZmTP+k3lA0o9XUrPxrNoYQ81kWey1jUMzds9972tW1zQ==;
 5:fLHlZga2Wt6wB1X/avUMc05p/57moZ2b55YfsIUSBtvTwEgp4n2DdB/Zo+ByHbep2RTM6x3/5vuBx/sa2CzUNMlgsYL8gKZddYIPTMVFtve8V/mfMDFssJvJkh7tB23D2tGwidGnmLUN7TNB5p8+aw1axwCWzBm2uUiR+hTh79V5xgc8QSM76i+ucInQye8cqxIynH8ByKsn176ofqBroA==;
 7:d7TvR+dHkIPZzAxpn481nTi8uaOURQ4SvslYW0ExIVpVOMc4PvAJSUrh+gos7BgLq+9pJEaSOle2ABw2qxz4UhsWWWZIioKqs0feWzxg2oDf5ASUUJerAh0IUDHwGMhPgVjieYzAgSfs9XdY6VvsIQ==
x-ms-office365-filtering-correlation-id: b66ad425-94d7-45e0-7fa9-08d6786bd87c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3928; 
x-ms-traffictypediagnostic: AM6PR0402MB3928:
x-microsoft-antispam-prvs: <AM6PR0402MB3928153DC3106A53ECC2DC11F6860@AM6PR0402MB3928.eurprd04.prod.outlook.com>
x-forefront-prvs: 0915875B28
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(366004)(199004)(189003)(486006)(50226002)(8676002)(81166006)(6506007)(386003)(97736004)(8936002)(52116002)(14454004)(102836004)(81156014)(6636002)(44832011)(6436002)(498600001)(256004)(14444005)(110136005)(6486002)(36756003)(54906003)(186003)(26005)(99286004)(66066001)(6512007)(68736007)(106356001)(105586002)(2906002)(476003)(2616005)(4326008)(5660300001)(7736002)(25786009)(71190400001)(6116002)(71200400001)(3846002)(305945005)(53936002)(4744005)(86362001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3928;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vp1CPIUwo00vVZSMHrJrg8u7vGpyPrO53BBWGi2V9Snzn2+gvtZQewVOjYNeNPaUxlcbdXJQpzPwMDKf3QylD6Sa5RiL/sOf+oFrCmZwZi2ubZKzSZOQDQK3y4riuBAKUHVPBCaAR7YdmDEM2ohNPK3lx85Gv+dW1xfBxxx4pHvI5BpCUNZ/rbJP9V6TnqK7LfyMbLPpFxDB/rt79HUie8CFEs7fRBNkyUNsvLywRNFbcSP72/53jWdcy9ZwbIiYhWbXxA6hMDa/AJaqM00AYUnZAaAbaUji+PZPjd0KSXor/sme9UG1pPg0hCfeunio6aZjftXSM65ShKC91Z7OkiZfqknS2cCVhRaOFMjWOokHa/juYnK1/t/M7HUCNlvtXlmDIr9fvAoNdOGDagmPX5jenaI6Uz4e2e2nIbm1faM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66ad425-94d7-45e0-7fa9-08d6786bd87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2019 08:56:30.4422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3928
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_005639_916700_EF59C2FE 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since this is going to be used on more SoCs than just i.MX8MQ, make
the dependency here more generic by using ARCH_MXC instead.
Also remove the SOC_IMX7D since it is also included by the ARCH_MXC.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Changes since v2:
 * fixed the commit message to include the SOC_IMX7D removal
   as suggested by Shawn.

 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 2112d18..d80f899 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
 
 config IMX_GPCV2_PM_DOMAINS
 	bool "i.MX GPCv2 PM domains"
-	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
+	depends on ARCH_MXC || (COMPILE_TEST && OF)
 	depends on PM
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
