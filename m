Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4C6C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:27:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3148B20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="REeuD1Ip";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iNQKwuPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3148B20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KP8GkJCJrY3eLCd21Htmml2ZGwVO08r1SDKkHyc9Vds=; b=REeuD1Ipo/yirP
	r8cqZXgQ4b34oh+HWrRQmYZu9JyI9TE2oxeG7OkIRvnJ8OX6vqtKNRos0PsUD8zBt5Px37PQRYnRr
	LwRaTkOQzImGULbVq1RKfP9L8z58L6YcHFZe9QnBiqf7aCYm7W4Nlr9EWvF7kTSQZXBzHlXJn7Jnh
	0jAO9ofuDyL5sLrBqTLBrY1jCvsoMiCIt0pXKSeK+0bk8Q+TwaIQ941L3loaXD+MNLUYv2MSoc+T1
	YqfTogkPH/qTem7vTjymrem/6sAB4l4Jmct06hBqGlB/jhJWnEYFMlFZWj6SGyFAbR5C0EG/ja1ST
	lW1SNgUESAv03mbLfE4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfxW-0004QX-9K; Thu, 07 Feb 2019 09:27:02 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfvl-0001oG-Es
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:25:29 +0000
X-IronPort-AV: E=Sophos;i="5.58,342,1544511600"; d="scan'208";a="26242029"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 07 Feb 2019 02:25:10 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 7 Feb 2019 02:25:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLggGKG5wq3yZ79elzkDDE5+DGZEY2x72uCaCn1nlac=;
 b=iNQKwuPzTOS+fopPGy6KmlR+XGpTUYZBgsz2udjFDFh2pslWRzbNRK6aV4T3Nkiv7o1+u29CeLD+zso3RNkf+UrBiybOOxXGL0X+ZH2dsvgzz5CRr8HiX+QLus+YZdJgwmOv0CUcu5fYeaHd9FcykcIJs4+K4Lm4pal7JBnE1Bs=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1952.namprd11.prod.outlook.com (10.175.54.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:25:08 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:25:08 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v3 7/7] dt-bindings: add documentation for slew rate
Thread-Topic: [PATCH v3 7/7] dt-bindings: add documentation for slew rate
Thread-Index: AQHUvscEJdupxwuMJki/fNlPXGz4SA==
Date: Thu, 7 Feb 2019 09:25:08 +0000
Message-ID: <1549531468-1676-8-git-send-email-claudiu.beznea@microchip.com>
References: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0350.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5a::26) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1952;
 6:apkW9nbLJ0HV68/L9jGnI8FnNFc+rYNRSA7hduUpn5eV1uxg/WL2YfspMF6laOOMs0Axxvdhz/SVMUw0SWFV0fsAEdQ0GMg+1VPwpyamYKk9Gqnmhe3a7gYzvwY0tthYyIC67g/4DRC/fptsyHNlUcla3dWwtiZYyINJeIebrMVVIszRD+EBct/PGHQtxpOgzYCmylciiji7k8cYuG+B87g6/x8ghN8sSxoqZx46oHvqqHga+u74RukGUSGyhhY/ie/H5Kfi66Sswt7DuiwMsuOj+/GeTrv0ax+FH9Xp+vFv5KaBgA9yX2xx+NYSqa6tDVfwS+nQu1Xlv6oyft9OKwyIccK9v4WfCjfpK1Jz6nI5rwSASA+B7lsPzGj9q0o8jMPjJY6MXbBlKNBFPRJ5ukExB1NcRBzYvsvh4AJkRrgrUKt4gICaHwRpbn9DFh5lxWA8X3chCjHUGhtZIPhf7g==;
 5:cimSB6IGYQPCCV458MxTQFzRuW2Ysivi3f+63QoE0injPTFlDqdjLlFHhOuz6pFWzL9Nu9yJE4DMo4mEQvN039XUipIN7G79k/AP1g/Bn5l9VUgEjyjTtXSONQe5aFZo0HNBaI68gnq+PNC3q2E0ItSn4lCTdlB+sIeYOuayoyz/AEtB3wrvyNQGMVRumbEUWCNs/vJGec28R6LUE4XdMQ==;
 7:d+YvIue1PpJrlT6wcl83sPX2TodpELSn67qx01yOFhWLGCF8F0c7Ak1QftByBfjNlpkGvTDJ/wdoyjP/VgS0n3nejsopd8ZMt4V2hOMmQVFhLCpp4k/VmBh0Q/xCkQ6pvbIFXKCtSiAvPJPkjgeUlA==
x-ms-office365-filtering-correlation-id: 42ffa1ba-1e39-4a4b-bc8a-08d68cde26c7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1952; 
x-ms-traffictypediagnostic: MWHPR11MB1952:
x-microsoft-antispam-prvs: <MWHPR11MB19529DF782C15DA5983C589187680@MWHPR11MB1952.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(6512007)(66066001)(486006)(2616005)(476003)(97736004)(25786009)(106356001)(6436002)(305945005)(105586002)(2501003)(53936002)(26005)(50226002)(186003)(3846002)(76176011)(6116002)(110136005)(6506007)(102836004)(2906002)(52116002)(386003)(11346002)(107886003)(4326008)(7736002)(316002)(446003)(36756003)(8936002)(81166006)(81156014)(54906003)(99286004)(6486002)(71190400001)(71200400001)(256004)(4744005)(72206003)(6636002)(478600001)(14454004)(86362001)(68736007)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1952;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BB0ZWZeVpfFVkCOnQpCx31ZmHaXbbrN0WH4ktnZ9iFfjIMcae0q1ckrwD1RAIHSFARcBC/Fk6a9i1WLz1Rhbg/+1lbrPenB82FAE5udzUQBJHd4RNgOS/DjuEpFKhfttHuwm7wIgTgSXZDEh1RbExPyEIirVRoIw8F0+M2NCgXCVYoCy3Yo+HR3iNwL4nJdSvKzwcSmxfLJsRdGb+iLXfxEYIxh8P9Dx4VzSQLMvn4EXDZUSG/lv3pMjG68RZTYEOQ8VCUcLLaKWdzXuVDs0P007p5HD/LCPNY9YtrF78bpRBodVGbTPP+TpPao8TKaFHaqAWfkLuzmiTIcvc7zygVsTVh11UT9j0k95qYTCZ2A3xdAuOOU+dEES7I47plGNHeJ/un76R2Llkm0Uf5LJpfNScSR9jJI3h7l5cxScpBg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ffa1ba-1e39-4a4b-bc8a-08d68cde26c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:25:05.4214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1952
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_012514_593382_41B17484 
X-CRM114-Status: UNSURE (   8.50  )
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
Cc: linux-gpio@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for slew rate.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index c2d51ed86d47..19c255346a49 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -100,6 +100,7 @@ DRIVE_STRENGTH (3 << 5): indicate the drive strength of the pin using the
 				11 - High
 OUTPUT		(1 << 7): indicate this pin need to be configured as an output.
 OUTPUT_VAL	(1 << 8): output val (1 = high, 0 = low)
+SLEWRATE	(1 << 9): slew rate of the pin: 0 = disable, 1 = enable
 DEBOUNCE	(1 << 16): indicate this pin needs debounce.
 DEBOUNCE_VAL	(0x3fff << 17): debounce value.
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
