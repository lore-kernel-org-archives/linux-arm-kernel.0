Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046B3C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C757B222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EBNT6BZN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="YWZVTdtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C757B222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UwRdGndy8p4COUjIHTAlrNfAZ9K25umIF2jz/Mkdzys=; b=EBNT6BZN3LTtrv
	cfJj0hKZx/fqO82X1Jt4DTAPHcWyqL/IFR9w++mqNC6p7ue85JZwqU89EOvs57FveRdbQBOFCn8d+
	fQVn4VxUcTbpHR1TG9nzCXi1I3aDn5xCgC56sDwEVXSf0j8+woXGYl8T/o6NWUFUw/J8afKwQ4MfZ
	Rkv1XKKh0uzndx3fsSGyM9pgMtcgQKyJvMcKeiDbr0zKIzn6JQHDtDxYIQ6VwI15E9xOudgT7kT8q
	mubKoBIIyhyp1X5HR1yHQWFopTbQyqojUHpehhDGQ6KM0MDLZWvJqZZGocp0AHl1wc56F6jiKR/Gx
	0oOufkYDFUet6LWLn91w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJNU-0000XD-MO; Thu, 14 Feb 2019 15:56:44 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJM3-0006kX-8D
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:55:31 +0000
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; d="scan'208";a="26740823"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 14 Feb 2019 08:55:10 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 14 Feb 2019 08:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRa/h1zYdTZeiJ05Ejj5rqzRvyQdmKUHvESAzkGGIds=;
 b=YWZVTdtjDne2vGUyGiPm5A+DXVjlO68WIktMY+o1PV0HCzWeU8pHmNik3m+U3jK506GxJBrGt2/wxvL/iwnIk7cAx7WYBgrcnQfmDe081vtUWku4JkutAv0lsncu/U6SJjZMXezzFRhXOUvjWVwrbMvpF/ugB/cohq8lrU59ucw=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1472.namprd11.prod.outlook.com (10.172.53.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 15:55:06 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:55:06 +0000
From: <Claudiu.Beznea@microchip.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
 <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: [PATCH 8/8] ARM: at91: pm: do not disable/enable PLLA for ULP modes
Thread-Topic: [PATCH 8/8] ARM: at91: pm: do not disable/enable PLLA for ULP
 modes
Thread-Index: AQHUxH2nRJoXfPACgkOWEfGtZU7tFQ==
Date: Thu, 14 Feb 2019 15:55:06 +0000
Message-ID: <1550159642-26878-9-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 83a06ccd-b288-4d9a-18e7-08d69294ca05
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1472; 
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1472;
 23:PbdwCgU7WpEgnqpxZW4PqoFell2pZ43Fag0VF5z?=
 =?iso-8859-1?Q?ql5nBND69hkvSbZBrZwP6u6esRnANbdY38ILzELbDFg9gb0XmxbYDDp01X?=
 =?iso-8859-1?Q?vuMq7BCT2fkc/xH+CAOCGn8Qozy3B37Y1ByPJWI+f/n495KUL4gYAZ2VRo?=
 =?iso-8859-1?Q?bAe81oq1KDTWz78KXNzI3a7xuzEY7/2111axO454oc6053vjL3JPy9kCL/?=
 =?iso-8859-1?Q?hWisb0zR6IbSmaJBHNK/gVStmrBAjCetETDjp9vgiJmJh2Xpi2Sl2Q3JVe?=
 =?iso-8859-1?Q?9OgWKPqrIt0Gunyt0nJWlm1vUwtqk31zhWoIoEPGQAtyTHEPiOo2tHDLKU?=
 =?iso-8859-1?Q?v33Zkhr4kObmcsW1qCUcY0/JeIuUszD+IF4EBqHpe8z/M+ZRyJOwpX5j9V?=
 =?iso-8859-1?Q?NSQczo+NtYt9w5CTN6EbgTOTYclxSEqGGzVLbSmuPezJNt28TS7ZC9NPSq?=
 =?iso-8859-1?Q?YTCVqJ5M/8ettqg8UOgxEA1s3klqkcundec5OTNQ+pgPTgJ7gEs0o5vwb+?=
 =?iso-8859-1?Q?mLOcBbXGnnMzY5uFOmlJ6fo+GMWb+8Hf0tDfC2KVHd/zWkfXmTHnubpdrB?=
 =?iso-8859-1?Q?+eGF6RQKfqsQJcCKFobKMaNihEqzWmeehpx2yiODE2WgO9Pl7iKTiT/uMI?=
 =?iso-8859-1?Q?ny1E5J6qRD4ZhsUqWI6oMNlhehM9o9Vr9cSI+yqPOmUO+Y6rKAg+3Ki+fk?=
 =?iso-8859-1?Q?KME9IdcFBCwKEevlm3X1Y6A+hLLfnv5m1nSkPXecAur5h6aj7CZdpD4hWY?=
 =?iso-8859-1?Q?saDdZEvNtVA9NRE02Pxh0LKubEzDyQ7Bibhildd3JhXekO9K9HHnBW5WGd?=
 =?iso-8859-1?Q?nqmId131TqXJfGomBgr7TFTxrsGuQMveweuApU03se9Xix0A5qqXnLbBdq?=
 =?iso-8859-1?Q?WN/nlMhyL1b/EkdmEmDcFv0jTJNWm0xz3DCvSCfVGrNzz2KrAicYhzygpI?=
 =?iso-8859-1?Q?J51uOdi0Csrl5B+sezgTvdAIwwOw0JnshdTWoJ37g6yA0pWaPsRYd4o1ZA?=
 =?iso-8859-1?Q?KY3ks3xQVbJfPrP8xxd41lQ4iEcd6jwFMggYZ2vJEhR1j0JK9iLnY/DPgD?=
 =?iso-8859-1?Q?A5GhanH1dDysTaitheF2uM0NVPXLV+iBHxEIrHAo3bRib0hCANNoCRThvZ?=
 =?iso-8859-1?Q?baZhywV3OrRETDZsb3hLyUicHp84EN78ktOthI2x86Qtl7jNCAhsBrYusD?=
 =?iso-8859-1?Q?CaKPdDJKFKDHwdijXcAlE+5y2E5T3tMslu34QKWZbulflG0UiLdqhfR1dM?=
 =?iso-8859-1?Q?rh1pnuU7C8nkyPXVcUyogWpdDF03ahJH6J4pyYfxy6UQC6QXNJnTL0QBMG?=
 =?iso-8859-1?Q?tFUtOo89/uvifF4I2HmYMC64XE5CZPBDLrTRhKBJWqiHZHBdQUIZCDG66K?=
 =?iso-8859-1?Q?HGfYvq5I5fsDkMZK2xXQvlybhl1FA?=
x-microsoft-antispam-prvs: <MWHPR11MB1472EF597F4FCC534F8DF0D887670@MWHPR11MB1472.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(43544003)(189003)(199004)(50226002)(478600001)(52116002)(2501003)(110136005)(25786009)(316002)(66066001)(8936002)(2906002)(8676002)(72206003)(68736007)(4326008)(54906003)(76176011)(81166006)(99286004)(6512007)(256004)(14444005)(81156014)(305945005)(7736002)(6486002)(6436002)(26005)(186003)(6506007)(476003)(106356001)(105586002)(7416002)(14454004)(446003)(6116002)(102836004)(386003)(11346002)(97736004)(2201001)(71190400001)(107886003)(71200400001)(3846002)(86362001)(53936002)(2616005)(36756003)(486006)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1472;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Csapf3tNHVgnLXfF4uobOhlOg7qTnSl56wgEvdPwsmQXF9xXQretvosl2YMoj2jTdosH5mndVJbYiVRteDxIdNV57Jhb3ouJGP/S5cfniyppJ3Wu+cIiT2m+1yhmrQ6uwwSeJkJvWSvycHE8diVB73BOX44bOtcHhIZ5lcAXwY4UJ8oTvW1lXWBmgNiwD7b7JBQsrNDK9fPawsjJzn92HuriaXWp8/qp98BaWk8/1tVvCo6SmUFYy+FPmralpozJeRgYYy2AjgdUBKcAwDlgTwb8HaIPlSZwNgu0N8ds8uxCTjmIFgmmcb2cIibam/mpW++hODIhfqPg3JiRjLV/FAq3KO8XRcFNEYfHNJE8/Nbpw/Qe69i8JxOId+VpVTQMvGkOUMk3TrXguCyrs3M78Ssfnd9yHPUHTeQ4304bZvo=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a06ccd-b288-4d9a-18e7-08d69294ca05
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:55:02.3410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075515_985744_68785F10 
X-CRM114-Status: UNSURE (   7.21  )
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

There is no need to disable/enable PLLA when switching to one of the
ULP modes. The PLLA consumers should take care of this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 5c33023f9129..77e29309cc6e 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -51,15 +51,6 @@ tmp2	.req	r5
 	.endm
 
 /*
- * Wait until PLLA has locked.
- */
-	.macro wait_pllalock
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_LOCKA
-	beq	1b
-	.endm
-
-/*
  * Put the processor to enter the idle state
  */
 	.macro at91_cpu_idle
@@ -351,14 +342,6 @@ ENTRY(at91_ulp_mode)
 
 	wait_mckrdy
 
-	/* Save PLLA setting and disable it */
-	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
-	str	tmp1, .saved_pllar
-
-	mov	tmp1, #AT91_PMC_PLLCOUNT
-	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
-	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
-
 	ldr	r0, .pm_mode
 	cmp	r0, #AT91_PM_ULP1
 	beq	ulp1_mode
@@ -373,18 +356,6 @@ ulp1_mode:
 ulp_exit:
 	ldr	pmc, .pmc_base
 
-	/* Restore PLLA setting */
-	ldr	tmp1, .saved_pllar
-	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
-
-	tst	tmp1, #(AT91_PMC_MUL &  0xff0000)
-	bne	3f
-	tst	tmp1, #(AT91_PMC_MUL & ~0xff0000)
-	beq	4f
-3:
-	wait_pllalock
-4:
-
 	/*
 	 * Restore master clock setting
 	 */
@@ -537,8 +508,6 @@ ENDPROC(at91_sramc_self_refresh)
 	.word 0
 .saved_mckr:
 	.word 0
-.saved_pllar:
-	.word 0
 .saved_sam9_lpr:
 	.word 0
 .saved_sam9_lpr1:
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
