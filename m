Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E3EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:46:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150C620842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nLMrXgAo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LSAm4N+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150C620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g5isyOASRHQcUWDHJyIuwbumO121H/sEHPLkzheJbfo=; b=nLMrXgAoXxrdMH
	XlRh1SU7ntejm03sxPexTwPekHcnW39JGw4hvpbMzLwqBaMFWSwon4y/hroaR+AgMeLtvkMcPwK7l
	wRoXh+LS7YJ4XzWMoPy0is93sN+7fvgyjb5uWEZ6CHLsq8Hecyfr8rRjbSl4r5xrsdBRRZcTEJPUZ
	R9bvWkG4iHunhRYeUXZY9QiHaEi33euL/iKyNJQWJuI8yjpbrpI2z3Si3IKMkPpIfT0VgjlXs75Y3
	vL74IxUdvIF1n+EWXWo/0yvrcH/n/CMIo9hMQQZ0aEXpPo5x3+wUVXx+SEG5YyZCz1Qy/8cY0q5G7
	5aZfqdybjSoGdD4aT6bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJOJ-00018L-AY; Mon, 25 Feb 2019 16:46:07 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJNu-0000Se-3m
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:45:44 +0000
X-IronPort-AV: E=Sophos;i="5.58,411,1544511600"; d="scan'208";a="24421572"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 25 Feb 2019 09:45:29 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Feb 2019 09:45:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZGOSR1g9LFEuJOO+7Wvt6dIrM6mmIVE57s3Da67Kso=;
 b=LSAm4N+lQW8pIjBlRkd30IaRyeg08WxtPhIjQoc2oKUCfZJ/wPJJ1/1tuLWJ9CTnijDFVshPrrgN5mW0pIXYLo9LwnyxoGGq+dB1tGpYMCyz4lsPWQc5OKmGlToEboD0FF59qi/aFmXmfVuUqMNbX12T+KXTOBODeR+d4YXIf4s=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 16:44:49 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:44:49 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v3 5/5] pwm: atmel: add PWM binding for SAM9X60
Thread-Topic: [PATCH v3 5/5] pwm: atmel: add PWM binding for SAM9X60
Thread-Index: AQHUzSlrzzDAx+7tqU6t3+zL6g2t9A==
Date: Mon, 25 Feb 2019 16:44:48 +0000
Message-ID: <1551113039-937-6-git-send-email-claudiu.beznea@microchip.com>
References: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfe0a0e9-002d-4a69-42e8-08d69b408e10
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1662; 
x-ms-traffictypediagnostic: MWHPR11MB1662:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1662;
 23:5pnyKKdln87VdsSGsKTW8tJsidKJ9ba1KGWEPKs?=
 =?iso-8859-1?Q?m6Zd7iaZWFVuXmFGNnRozB2Vv6ZB2AoI1DYqOQ1lL0OTOdPcVUSARMJyuB?=
 =?iso-8859-1?Q?48hLWVsYAPVguEjtKF14c6WShhoeIuo+aptsyADMKLi7cijToL3WJ2z13D?=
 =?iso-8859-1?Q?SITgDg1VW45Ubb+LzVqY6cxyIVCkFznTcjplSjrvc/YP0MHgHJhrg7Dnnk?=
 =?iso-8859-1?Q?D13bSBM5pQFq9eypN2iq/apqfNtRJnQNyRlbee5axcgjgiGD119majNXPV?=
 =?iso-8859-1?Q?i1lvWHLiG/VDeySb8+wy1TVvNabV9BYdXzQTpTWthi+S1SyWsv3rb+RBxq?=
 =?iso-8859-1?Q?/cu20S0167Ru8siWrhFt/ukN/Tskt1sCJahFkCYhbbSs9b0x7v/O6ds9di?=
 =?iso-8859-1?Q?labtmrfe7DqjQWRnm84H1rYJ0stPPEal1TKWMDpqhhDZPWs9aJzVjaclkv?=
 =?iso-8859-1?Q?t88UbQRU6dO5aeTZQRTQg8N8P9hvL6QBMXtltTEuA+fMPsZqFEjoIDzzNY?=
 =?iso-8859-1?Q?ed1PKbMX8dXxsrm+rX6fSGTRdg1EOJJV5aSRXU5MyVcdNcIxR1UFuhNBAc?=
 =?iso-8859-1?Q?v+74GphdvecHHPW3FwKpUJw+I8fJUeulQYlgwtZwU3ZqjSl2PPYtfwJ4Qx?=
 =?iso-8859-1?Q?IkfvEv40lnNCpeL9KGEj089ZBCKHYByKzzUViIlKM+uGmMWJsyQ6VFa8r+?=
 =?iso-8859-1?Q?P4um6fmk7qU47Tgi09Dj2gL8MRBR8GrnxqxQTv5j6Gr1i/yVYb6o0wCQo6?=
 =?iso-8859-1?Q?Fw/EgPN5RNDF5Fo4rXSEsUoiA/e/Yi4LYMj/0Gu2QhtZKaSyr6qOtKWl50?=
 =?iso-8859-1?Q?9Pjezz9TJF52SBieiX6WqeZ50hatJ2wHI0VOaUPr2uWThJAa/hDmqdDISL?=
 =?iso-8859-1?Q?bMiAqF2Al7wRjp02lZAFKusTcnynidEAe8xJauRglthLDpa9LiYzKUA9uk?=
 =?iso-8859-1?Q?LSc+Z0BW4Uv6bhHsqEmtH3ldjc40zddJPf4KrbvFaM+K9PuUokva5FD0WY?=
 =?iso-8859-1?Q?xlhRlgejJJ7meD0KGoPQkHQFzTRQEeYtqqTMts1vFNOLYWOiTtJ5B6e30V?=
 =?iso-8859-1?Q?QKOVnxiaM4NKAvmqNIRW94QkXLxEa4AGOd3z71LbqjHegzAWPRsPkRFdD7?=
 =?iso-8859-1?Q?L+jhKB+5yU6dbECEDAyJKy0l7Sd82OEyIie7jd8h6F7sSIHRVaPAbxp+qb?=
 =?iso-8859-1?Q?3DTjp/cCGeZpKTX5miCpg+jDjcsokKRdUiGjIiA+YCaZyLnUMdd00E9hJx?=
 =?iso-8859-1?Q?tEL1gX/3UJg/mXdgfzodb48nvnSAK69Erj4IVRGGxwpZTQsBPLG2r9cP0M?=
 =?iso-8859-1?Q?7EnYXIaW77zsExGhS7igcZ96w8YbAM+9zGZz+mOFs2J9g=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB166291427154647D65033CC5877A0@MWHPR11MB1662.namprd11.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(68736007)(2501003)(97736004)(5660300002)(105586002)(106356001)(36756003)(256004)(110136005)(54906003)(4744005)(316002)(86362001)(99286004)(6636002)(52116002)(76176011)(66066001)(446003)(2616005)(476003)(72206003)(6512007)(6506007)(11346002)(386003)(6116002)(3846002)(50226002)(14454004)(478600001)(8676002)(81166006)(81156014)(486006)(8936002)(53936002)(6486002)(107886003)(305945005)(71190400001)(71200400001)(6436002)(102836004)(186003)(4326008)(25786009)(26005)(7736002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1662;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MOPjJwlzcywMBX/j9Oncftm206k/Y/6P6IXnixxjenfP035XUCoLkv8mhzu4RgeL8ouFwfrSpPWnn2sbNPJ+0F2TebkPH0TsFRK2ESlPafKKl9tYpD6cP1aTnPuSgwoiPu47mGFfJAQEFPGjjdJxJZlNmlNeK8c1S0mnzIOeqaf4n+rd+V5bP/mXQsJ8VYOzQS5BpytiNNEZtrDrCGAab12y0IUYh4zOy/QKjlHDCb8m8Pz/+S234BBDC1mAYXa7hMYw+XwgnsLiVl2+D3ObdWRFGDuEFZ+79TCoYnXZQyBwIQIRwoTrYCxnW4T5xEoY1bxMKVcWhpUDkPuQ9vGWOYQwJ/8ZqqZD4gj68oNbq9GyLagoV30crDZ6tFRAnYoNm5SZROuZJZScVGLck9uaLZQUsDgDSR1zDQBmX3SRqKw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe0a0e9-002d-4a69-42e8-08d69b408e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:44:45.7785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1662
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_084542_471130_2ABE8E42 
X-CRM114-Status: UNSURE (   8.97  )
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
Cc: linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add PWM binding for SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
index c8c831d7b0d1..591ecdd39c7b 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
@@ -5,6 +5,7 @@ Required properties:
     - "atmel,at91sam9rl-pwm"
     - "atmel,sama5d3-pwm"
     - "atmel,sama5d2-pwm"
+    - "microchip,sam9x60-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: Should be 3. See pwm.txt in this directory for a
     description of the cells format.
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
