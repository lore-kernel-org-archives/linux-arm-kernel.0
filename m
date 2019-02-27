Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97DF2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S0BI6JA9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kY/RDKk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97DF2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xUnHpF9tk53UntMvhbChR/owb44e7xByMRVPle8OwkU=; b=S0BI6JA9pK4pWg
	/5NtcsdUm/yTFNax1/s6w6mJSpukMbRa8WAlP7VQ+jpOvsZJGrvWnP93FCL9HZm4GKUD/XQEiQKE7
	I462Ag2Y+XbtvToVb9bciwi1Bs7PkGYMrvt4/0tx+nx9RefYu56PyCjrvevqWhZXqhNQ0YSzMDr9J
	quhCm///RrTbptnJLC1N8lf/Sw1zF8dMvZ9ItkAkkrUfzq9IHaibsty727641dc/vKxPxu23EQmec
	dwLQRkW/vtStT5ubxkMHWA1VIZFbk9notNAIxbkqQPLsJcb/03b7Aki8afIG4Wdeixq2nhdGNPYPh
	gDVJIRJl/+NFFiVKA8eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz23Q-000319-AL; Wed, 27 Feb 2019 16:27:32 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz20T-0007jC-0f
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:24:30 +0000
X-IronPort-AV: E=Sophos;i="5.58,420,1544511600"; d="scan'208";a="26973649"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 27 Feb 2019 09:24:28 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 27 Feb 2019 09:24:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DCYhMwJcYpP1s+mG1n8Bq9kKtKO49eT9uS2+vU2zuo=;
 b=kY/RDKk3SfkePGU1cuWFAZDKomV7I1zrDXplcvf5/sNbKT0/XqVicjAuQ2BDgVq2RHVi7s3IqvJj3KBIQsjgQ1B/RwS2BLFQzixlL6om1liC2QhbPWKBIFfw3AYj8DUoT2muzGSHPijhLmAzC8brpERhOOe0LXv9PQNWGSpRL08=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1806.namprd11.prod.outlook.com (10.175.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 16:24:25 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:24:25 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lee.jones@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <airlied@linux.ie>, <daniel@ffwll.ch>, <thierry.reding@gmail.com>
Subject: [PATCH 3/7] dt-bindings: mfd: add bindings for SAM9X60 HLCD controller
Thread-Topic: [PATCH 3/7] dt-bindings: mfd: add bindings for SAM9X60 HLCD
 controller
Thread-Index: AQHUzrjnqtB6JnKSKUOGyiIBgoF6SA==
Date: Wed, 27 Feb 2019 16:24:25 +0000
Message-ID: <1551284609-14594-4-git-send-email-claudiu.beznea@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0112.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::14) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 967fcb82-ed67-4437-290c-08d69cd009e4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1806; 
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1806;
 23:7MzyqcleuauvrXRtb00LcFIenbw7Cbdhg7dR4Nu?=
 =?iso-8859-1?Q?yRwnBSGlih73EowWQlcudGEY7esSdcuBpQQK1nJYj1Jg7TAXxw6PRjmnLc?=
 =?iso-8859-1?Q?3Zqm4aXTSlyLS16e69FByKUyX4ksD1HGH7AfaNwmTDxFSUhabZE2d2G6uc?=
 =?iso-8859-1?Q?SV71aIDYng39K3P5V9iA2wxJzBHOq5qpDQqH6Z8pi33GvjDtEiM4Apnx4S?=
 =?iso-8859-1?Q?8+FqvYFicEXxFWyW3d7eQint07swAfK7Cvhmjf/tULUPPRXrh9SVRVodu+?=
 =?iso-8859-1?Q?wG+6MWgHzEOFN9Y+ViIRgWQ3yUGhK6WyceqyrDiqhxUJmiCYByoqG4Ft6/?=
 =?iso-8859-1?Q?8nkccmOs7auGLVKXARK4ai0wNjMPWG12CFZc0yuo9LgbNoKtvtTW2dnmd9?=
 =?iso-8859-1?Q?QWNWZUJsXjfbsWtEHVqmI742ZJSEmIAJlf6u1o4FhKfJZNfvQtVKte0h4A?=
 =?iso-8859-1?Q?dhKVLWk/YfdTFRLP8sqQvGEpJKhBEBPrqvBnIwhVBB7NG3fecC2MhM6puw?=
 =?iso-8859-1?Q?YKwtt09i6Yq5twL6RCrISiTmwHgn1JjomT2cYMPGioPQ7iRfRqXk9p0gJl?=
 =?iso-8859-1?Q?IGnYb1dgoKeIS6RjZs3/YUH2aWR4oBtkF9Ms3p3LPVt2EiYGLERok7qIpz?=
 =?iso-8859-1?Q?WYC/ZIElXSSzGQYmkA/l0FTQ/MXazkt3bBcQioB11ABGY0HWmT3uqDNJQa?=
 =?iso-8859-1?Q?Yg9NCaF5WR6MlXkI4+UElTATbov0J31AYfPUKwqRi0T/vm8w+tQxD5E1QN?=
 =?iso-8859-1?Q?NZE2l7Bjlzge+VSrMZ69M8yBGjxT0VqG7+Q+ET+h3iK4CeFFoJCVZ5tyqU?=
 =?iso-8859-1?Q?qgWK6cwGHnMkELP+7/Wje2e/XMOMUx0joNMWEphzCtqhh5cWMHyy6Ilu4d?=
 =?iso-8859-1?Q?Up2XsfQsKQCL+aofxTNeSRM4WQ56d4UqQVQGQCGVK0MoUPpsEkgwk9J1q7?=
 =?iso-8859-1?Q?cOWvlUOcCypl6SepTiB6VWacbA3erJbhF1lwY5DKAUGx+FAUW7q5bnLgAK?=
 =?iso-8859-1?Q?Nq8qZoSUPO4S3C5MD6ZePBaBweUwZ4Ri0dwmnXBzFsfE5uyGBX1i3vXVPX?=
 =?iso-8859-1?Q?QwMHc4EAO1SM0Hsc3bYI5deBojtN7+JIbH73hYhgUCMNQjIhu/GNHZcbY3?=
 =?iso-8859-1?Q?8dKO4jVBM9gc4IqfsFcR5dk01Gw+nOK21MZJzIUnEVVJ+RaKnCB6i9Hm3f?=
 =?iso-8859-1?Q?6mWXbb+e2EoAAns/lXrJpy1UvWyADyT5knVkI5N/n0O1zOnezISr6+rI4g?=
 =?iso-8859-1?Q?sGohvA9pBjZOGB9YtPRhzZNiFS8+4iKgdPLmK+Qls93p+eE/cjhPFdlwmb?=
 =?iso-8859-1?Q?povLBs6xxvcBj0DVM4Vp6C+tTOzXeXWrMmvvZRyD+/g7vEVmjtiSn3PdW0?=
 =?iso-8859-1?Q?8HL/181y+hWyKeZkk9DUGM+hOkCBE?=
x-microsoft-antispam-prvs: <MWHPR11MB18060E3F277BAEDB904F50FA87740@MWHPR11MB1806.namprd11.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(11346002)(105586002)(4744005)(25786009)(6436002)(8936002)(36756003)(4326008)(66066001)(6486002)(486006)(476003)(76176011)(50226002)(52116002)(186003)(107886003)(72206003)(99286004)(478600001)(2616005)(7416002)(68736007)(110136005)(14454004)(2201001)(71190400001)(6116002)(6506007)(86362001)(446003)(71200400001)(386003)(97736004)(8676002)(3846002)(53936002)(81156014)(54906003)(81166006)(256004)(2501003)(316002)(305945005)(6512007)(7736002)(26005)(102836004)(2906002)(106356001)(5660300002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1806;
 H:MWHPR11MB1549.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kyFuUcEY5aDc1XzHFns9hVa8dVMQwPb18xdFB7rfNGdf6k494BRh0rgtuPzHC/lvbYIQFfuyiPcjsuul2qSD3+0jr06Lh1fzL9CVK11B2djib1YbzuxYO4CJmiNDxAkVICDnwEZP02J52YcYriGi4QQNC9dKDbx7gO2veJxzz85yHqMwTXUp8otfCNnqf1i4guNxQCfOH8/KoKHO9YV5/WWjW6XmAii0Z8VB2+JbyNUWoaTReG5LfVQyo+Hy7eXo6Xptbu/nNm/TED76yerm96bIO4w7wLWBZsxeKDci/Nk68zP/e1p64LHHULTFYGp4pWjXfDW7msLBPAVUx7fkQ8jDlTVm1xvpfskttScJ+ZEnGBzVTCdbPoEIueLPYo2C38j/RYshHVuWr2AiFErQGMS9NTXvxEn9ZihsF4Sg7oU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 967fcb82-ed67-4437-290c-08d69cd009e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:24:21.6271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_082429_550072_09A2D48F 
X-CRM114-Status: UNSURE (   9.13  )
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
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add new compatible string for the HLCD controller on SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
index 3f643ef121ff..5f8880cc757e 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
@@ -7,6 +7,7 @@ Required properties:
    "atmel,sama5d2-hlcdc"
    "atmel,sama5d3-hlcdc"
    "atmel,sama5d4-hlcdc"
+   "microchip,sam9x60-hlcdc"
  - reg: base address and size of the HLCDC device registers.
  - clock-names: the name of the 3 clocks requested by the HLCDC device.
    Should contain "periph_clk", "sys_clk" and "slow_clk".
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
