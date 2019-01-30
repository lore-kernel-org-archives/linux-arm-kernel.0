Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5F7C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:10:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D98020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TrM7YVfe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="c99bKrwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D98020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DVxID6YWJT3hbEoWGWJmbZPGfq6oEhyv32bZ+v7SHWw=; b=TrM7YVfeWikMR0
	BagmNSnaaeFpYuguK3tv2cJ1XpD0QFyMBe4DRAj1vcYCCeEcNnYwCVtks2dhkBI6bzzoZQ05UMn3P
	s3jKAVZCx2Oi6luUG4w90ucSCu9HELGmReJAyVB5s+5CoQyMoNVZ5D7JbkEhFtELhwpzdye4jBOP2
	R2B6+VkVgflsVhnFjfgRGwdNXUxYt3vP4yER4eMPE5k/8CP8XuAr55jbwBojHlGOnRApR6+f7VStc
	JfnE3tif1YxeO2vkou2gyd65tctv6D0Q7za6+z0JnVal7R62j0CYA1IBvjhONdyRXUPSO0Qc+YodK
	BquLDH1AOVDvIp41QpdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorVr-0001VH-R1; Wed, 30 Jan 2019 15:10:51 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorTj-0006aQ-48; Wed, 30 Jan 2019 15:08:43 +0000
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="26094017"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 30 Jan 2019 08:08:38 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 30 Jan 2019 08:08:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Os2tdyNKEPCMm909MpCewpd6kQGkzIfTJFtLpLZTIg=;
 b=c99bKrwX2t3OT3sQXWZCTIz2QmhFtt0T0ZzV6r8rYMckldJC2Wp9HnI19jQgYSfL/KPj1Ve3Jtf8H1+naW+TDEdzd/2PvMgLjLq0luCMBsNshY/MhNNUmYcxvxlDPq+jCCvdEsCfx0ENijwFEJIww4oTDWHJPya0i60qUx15qyI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 15:08:36 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:36 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 4/9] spi: atmel-quadspi: remove unnecessary cast
Thread-Topic: [PATCH 4/9] spi: atmel-quadspi: remove unnecessary cast
Thread-Index: AQHUuK2spztuTCidrUSdAFF1gcbY/A==
Date: Wed, 30 Jan 2019 15:08:35 +0000
Message-ID: <20190130150818.24902-5-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1796;
 6:DWDxTCNNSbvD9hb6OiinnTm2+ZqmPpDVzYwoiBNnkJ5DsOoi1j1SwzLzOTyaPBCgjYCeFJkaRmcbuiRtncdMzrZu8zv92sxrfRCZiPXtkSNoAdZ0NiLpKvqaIQXJuglsK/zdFn1EC9p9qqpsCZxt22KbanLwOx6D/OAyeyrElVKBf4nTlMTh3OIXF+xF4JinFEEW7gbxSxKM9wTKR+FJ9FhV9eqhpwQ8t1AWIveb1UkUHbJtrI1IXEUwXmNocsjx8jIPzaOwJQv48Wy+HXC3u41sUdVBCAuKQ+pv71UPeyiFWzE3f8dOFcSTqt5VNwlPVE96kdE/6EqDtVVvWi/RjKZEHZgvLsav5HLyVXg4yoyUvqoKyBs9AnRfp5zyLM84Rx2tXPjHNqYv86o/mybhDyM8OhMGlSqH3yuWmpa9+bLHSAl30BhFBzuld3KMHYVcapIhT3ggdIGJSLNqLvSjkA==;
 5:Xu7BNE8kbf1KnfTQaDmCZ1V4WaMnx/nbrInZjKrzx6H/T8jwqL70Uj7b/jd87kUhfXra2ViVnit8m0Hy+tAbCu8r+yRcjXK4Kd/OTNsW7m5rPq0xaVCQVpshanLNJo8zLQ65cKZcm14FBEpRAICdgIeicYKSrml1Wnb3VwAuJ1JHtCuISRg9y7NBXoR4QQgpnsRzyJCc+HoDr0VXNUPqRQ==;
 7:JUnXVEC2kKZ4zt0F65kjNNR+ec/3xxW6ELlwsCOd2eadt8+/pwgesXA34S9xjn1Wm4dqvpdGLuSaLbMbqeKgtIMT967fX1wN3QvhAylt66ET4NvaJ6kOGJYXEOboHpR4MZNE+f3y3OZETN76iwlx0Q==
x-ms-office365-filtering-correlation-id: 10591938-85c4-4e38-759a-08d686c4ce78
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1796; 
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB179693A52F7631284E83A75FF0900@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(386003)(316002)(81156014)(2501003)(72206003)(81166006)(4744005)(486006)(14454004)(476003)(110136005)(1076003)(8936002)(6116002)(4326008)(11346002)(50226002)(52116002)(6506007)(2616005)(36756003)(3846002)(68736007)(6486002)(6436002)(53936002)(8676002)(54906003)(66066001)(6512007)(478600001)(99286004)(186003)(71200400001)(97736004)(86362001)(2906002)(256004)(71190400001)(14444005)(305945005)(446003)(6636002)(102836004)(105586002)(25786009)(7736002)(26005)(106356001)(107886003)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1796;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ybFcjN+xHv7DMSoStm530K1Gewm9yKcYEA9s+K1W4uWLic88/EejA3J73V6NrPgf7xwfR2tm8D2vRvYtDmgKEFjEBZQHv+A2ODYs73QwCL+sQFb0ImGizRD3ER0TaxGn4IQLWQd/PGacFoU7EGY2BtXjXqiNl2UKpSV8C+vkE5MeA071qFq3h4HzPVugFhBwI6/KyqMk13k5Ml9izbmutt3fh6DEAlRZVfKEXeSddxBRj/p27XN+00as+rjigUwsJX4UVQ7Tof+28lgq2D7inj1n++xmdzWn5nzDNYAckeo1CWFRgX4JSB0mz8ULZ6XUoiDolkE12vkiqxtc2f9F9zvmrhhR7xdMQonjisjm1izRO+npQmI54913h4aFKAcUw1LGrfohpeWx586XvQGOV5F1eGMNQdOaBmeQhSdPTrA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10591938-85c4-4e38-759a-08d686c4ce78
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:34.1095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_070840_116364_88BB119F 
X-CRM114-Status: UNSURE (   8.91  )
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
Cc: Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The cast is done implicitly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index e156c345705b..3643f0c851b0 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -389,7 +389,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 {
-	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
+	struct atmel_qspi *aq = dev_id;
 	u32 status, mask, pending;
 
 	status = atmel_qspi_readl(aq, QSPI_SR);
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
