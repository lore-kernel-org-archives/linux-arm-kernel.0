Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7886C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B1E222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nhske3wn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UynpPyWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B1E222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M64HIIr5heSuAXKzSxHRRXXP8iRL99J6M1JAZx+cWo4=; b=nhske3wneWQEPZ
	n6PrhFYoQUo0l/vsRApgEq9kA6mUjopoQPXyF9l+Z7XsJAJs9yUZ0bq74wVAoMSQjzpJmPa398x1k
	q76zygGa+tSKxPl9PYIjO+TdMKC3QOCey01inEVccYrwZ0004DkFiIRq9WXy17xQdCPBS1u5CSvRt
	dXsvALKGZ1CQJ0VYC4fAsbx5Tt/4m/B6422BNJVfK3ySaBDsW0Ev2l/0tIsQHDybPeqDoFhB7Lruj
	o7y7AS9W7mzt05UYRJ/yy8bwRuJ0rPZlQsLFgvrG1maGhQ2FMW2Q3xsrBXfeFMZCFsE/U4bnG7g1W
	Y4a0HN/A/NPGo0nkuKsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJNL-0000Ic-Sa; Thu, 14 Feb 2019 15:56:35 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJM1-0006YR-3j
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:55:27 +0000
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; d="scan'208";a="26282421"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 14 Feb 2019 08:55:06 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 14 Feb 2019 08:55:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIZdKQ2EzTzxbQhcuVuQ7U2CsVi9pOiHu0nvpIQ4lWE=;
 b=UynpPyWV6/1iGlJsWwugt1litOzVpdIgy8PU+qpKu+khZkjGUW2ai1Qr2MB1wJ5Kp8gCQzAmobfJgCTPz4Bj2snDCibiOQqtj3WbDY8iyLtAGMqiPrlpeMir48tmrapdrIbR+7L5sEAD8Lw8Jioa74hhlLH7qy/lylDKLGP2Aj0=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1472.namprd11.prod.outlook.com (10.172.53.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 15:55:02 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:55:02 +0000
From: <Claudiu.Beznea@microchip.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
 <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: [PATCH 7/8] ARM: at91: pm: disable RC oscillator in ULP0
Thread-Topic: [PATCH 7/8] ARM: at91: pm: disable RC oscillator in ULP0
Thread-Index: AQHUxH2lts6UkE7B20KVlk1mwuX6kw==
Date: Thu, 14 Feb 2019 15:55:01 +0000
Message-ID: <1550159642-26878-8-git-send-email-claudiu.beznea@microchip.com>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0098.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::24) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dba91b8a-da64-4c4d-6f9b-08d69294c74c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1472; 
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1472;
 23:ntkH42UepusqBcJ0xY7Z1znfz7Wvw2SvlRK7Gdr?=
 =?iso-8859-1?Q?AvJkZeLBsGaNjVE0iJUm7mDfcNFNmSQkciGpgyh3/wOnOhGjRBc1K40v+u?=
 =?iso-8859-1?Q?MBUrTlvJnQN70u/3uCRHeXxd1vObO3USpvkBJnKNazEBHOvynXO5BEs8Ea?=
 =?iso-8859-1?Q?Y73oG9C8HygzGY1AoMc/7VmzCoRRGKP98G94oo5PfqHqASWrPdrmXRSDL+?=
 =?iso-8859-1?Q?ffMgOMuiJln8YEwT4BSEenzFc6q/LPOOSgKhzm90UKvm1zdiiVY0iHyAmP?=
 =?iso-8859-1?Q?9NVHJKKQYkXsLWR7XmlYVv2+zHN1+U+g/ONphgnV5N8u2lz6AhIbxuESbW?=
 =?iso-8859-1?Q?xmRLAMLDXuVGfJecErZYY7+yPGHVaSJIsczssjzD+U8+0tzsOMf6pxtMuR?=
 =?iso-8859-1?Q?6Yce4LdnMHW3QAcnKZueqDWCvJByvHBzYPVdKfj/Ruc+XJUEOrEXcnZ/QY?=
 =?iso-8859-1?Q?5aWDwbqWmSIKL4q3YcS3dJFmhDLbWOlVWfPntfkXujmsggtWBkaiVCaTYO?=
 =?iso-8859-1?Q?nKy7r4spRTd6flVR3xM/EBVSPKZZmQLhV9viK1+tEKRhi8y0+KBpHxY4xc?=
 =?iso-8859-1?Q?WAZx0+/h6j2/8P/hOOj7DnsS0YHxFfGUPt19I5oJnN+K1dy1TLcPKkL8W6?=
 =?iso-8859-1?Q?MckcAvBj49driW5o9VoNyuHTx17g8sG+qz52j0XlfVJNgb+4SIx76Whk0o?=
 =?iso-8859-1?Q?gTdQrmMr+2Oli+hd70uTFGpu0zEuqdjXJNoiHcsZQkYw8HXdz4ZSW89TLs?=
 =?iso-8859-1?Q?WtJV1sqhvGRizpBXqMZuzmQO7195O6JJMxMhF4uG8Japc0U3ZoqOZ6GVu/?=
 =?iso-8859-1?Q?MuGmjoPVZjrG/7kp5RTqoGNREqTMsoUKnBuCEmHuqakUSTWv2kviYJqChs?=
 =?iso-8859-1?Q?yh5zRgVUFyig2HTFFiZTcBNt11UvjS97H+7OnsvnkLIlyPbezR0EnZdRJ9?=
 =?iso-8859-1?Q?njp7bDZKeCjRBZQYO2N6ScAnuKwGlSE/BMbtO+W6TxHYYtOvJP85B9E1bh?=
 =?iso-8859-1?Q?LyfRZOyb80U7DohSR/HYzOzYA+Q/rlww/xltGrMIz2k7f6yuWrvzj7ZArf?=
 =?iso-8859-1?Q?h5EDMCnAQ3RSGKPge/0w+alGFFsFpJC0Cj6b3OCobGnf/6Smk0nkAst0OF?=
 =?iso-8859-1?Q?MQqGqLMRj8cG5FYW6ZSqjp8LM3imFDSRlBT+vxERmuV5c4MZpNoEwlVeis?=
 =?iso-8859-1?Q?8AWY93Dh5nCecdXhDZeDGYZw2/tLhcz6XAHIDKu7zKtTlA3Pay6dKT9X63?=
 =?iso-8859-1?Q?Ig/HO17SsPsus/Xrt+FE/5548vDKvJM7f/af/5LoHVY//auqVAZzCw9ulL?=
 =?iso-8859-1?Q?mpLtETfxiIaHgQmr0/8mCaIwNgwhUK/6pwguvzklFdFYIZRz3kcZbaL/V5?=
 =?iso-8859-1?Q?9F+GaiL8j3D5WpAa00y20k2oJ9EGO2yHihP9fXWOmvptaTdw6i6S9cs54o?=
 =?iso-8859-1?Q?f9cOO9NzutKvh1Yadrd5RdJRPxI95CLuWF7?=
x-microsoft-antispam-prvs: <MWHPR11MB14726FF9C642A7D91E9B6DC587670@MWHPR11MB1472.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(50226002)(478600001)(52116002)(2501003)(110136005)(25786009)(316002)(66066001)(8936002)(2906002)(8676002)(72206003)(68736007)(4326008)(54906003)(76176011)(81166006)(99286004)(6512007)(256004)(14444005)(81156014)(305945005)(7736002)(6486002)(6436002)(26005)(186003)(6506007)(476003)(106356001)(105586002)(7416002)(14454004)(446003)(6116002)(102836004)(386003)(11346002)(97736004)(2201001)(71190400001)(107886003)(71200400001)(3846002)(86362001)(53936002)(2616005)(36756003)(486006)(357404004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1472;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eYdlKDsmIAyVWdD0I/Oicxxvu0nx8j6XLpUg/zu6sIuggieIrzM5VaSHm7y8MFispXR52oaS8jYaLumGB/XgCePGIOoilwTNwoeqiw+eYICX4FILveKE/543ucFG21r/EyzcJhsPQLmOptumGBGgstEh8TD5uztWUlZrKf3rI7Mc6zbHIB1+fbsM/aUee0e0nwyC3isXwYhbwpJldOHZLaAgQ2AZmweBUhVlCkRqOyiZODCijG50vSPnqvDzyzrgHGcljp0+6eDS+4jXJk8D2b2S126Ug/cw9zIT/8kHEI5hxJGNAqZZNX3mUHSVPFGhxS9d+KxvTQM6CMFLI9JA0DEShrsr5Nc2Gb6CiaPpFONFgTYeliT7726Syltnmzs6qg08FWFZ/ucOrSf3kNuT4adSrweP2NqtSGKN1G3RCHk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dba91b8a-da64-4c4d-6f9b-08d69294c74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:54:57.4531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075514_130952_65A17BB4 
X-CRM114-Status: UNSURE (   9.16  )
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
Cc: devicetree@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Disable RC oscillator in ULP0 as datasheet specifies.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 8b18cad1dcf5..5c33023f9129 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -178,11 +178,46 @@ ENDPROC(at91_backup_mode)
 	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
+	/* Save RC oscillator state */
+	ldr	tmp1, [pmc, #AT91_PMC_SR]
+	str	tmp1, .saved_osc_status
+	tst	tmp1, #AT91_PMC_MOSCRCS
+	bne	1f
+
+	/* Turn off RC oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCRCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	/* Wait main RC disabled done */
+2:	ldr	tmp1, [pmc, #AT91_PMC_SR]
+	tst	tmp1, #AT91_PMC_MOSCRCS
+	bne	2b
+
 	/* Wait for interrupt */
-	at91_cpu_idle
+1:	at91_cpu_idle
 
-	/* Turn on the crystal oscillator */
+	/* Restore RC oscillator state */
+	ldr	tmp1, .saved_osc_status
+	tst	tmp1, #AT91_PMC_MOSCRCS
+	beq	4f
+
+	/* Turn on RC oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCRCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	/* Wait main RC stabilization */
+3:	ldr	tmp1, [pmc, #AT91_PMC_SR]
+	tst	tmp1, #AT91_PMC_MOSCRCS
+	beq	3b
+
+	/* Turn on the crystal oscillator */
+4:	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
 	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
