Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB69AC7113B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998682084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hTjXjC/9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oBzlO40Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998682084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=d0e1c8bstmcnI9NY/kyOCoLx/tDZ8apeFlujbAo8+ps=; b=hTjXjC/9v6+jUH
	eaun5J2nKtEyVVis8pVUsLnkWkMBvR0YsuiQzpf+abqcZArsoKm9tB3YHaYgK2dlddLzyYj/Gi6m0
	DadI2WO3IXYlnoVD4yRdJ851czHtkDr2UPVk2DwHAhwZg+N2KYTDoXIV70DCiOi00bNrtODI6u8vm
	gyNJ6A2OmcC0PDci3BUkLVGOBnoWI5m67427XpQSqSsTP6FLDKo9i3BAISxU24Ewwqz0B5pVCoUpo
	lYkSJ5jXGDEdP+gfm9xkeuC0+osSPqhKOfpWoWB+JQPhStBWukLGlbkzXEEDBuZ6c42CaVMYuSnUO
	fc+5hE0ZstXCXEQpT+pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYj9-00016J-Si; Mon, 21 Jan 2019 12:30:55 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYj5-00014y-BV
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:30:53 +0000
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; d="scan'208";a="25752683"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Jan 2019 05:30:48 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 21 Jan 2019 05:30:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhfqjAKLj/VGpeNeDwnAwZwp1akzvIfSxWmUAhy4g5s=;
 b=oBzlO40YbwkuwD0Ey9RsbHdAuov1bvIBJr70Fga+/nFrFW4NdcWx5I0VQaayenP2ebX/foQv435g4J1ERAcev3eVMhEd1sBZShMQok2P+DrQVD973iVVXy/yHgWDcV84ljGrRSo6lPlAikv7qwd9Hke4MN5iZzNkdpsEay7Wov0=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2064.namprd11.prod.outlook.com (10.169.236.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Mon, 21 Jan 2019 12:30:46 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%8]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 12:30:45 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH 0/4] add support for the new SAM9X60's PWM controller
Thread-Topic: [PATCH 0/4] add support for the new SAM9X60's PWM controller
Thread-Index: AQHUsYUhBAj3SDaXMU2G5JKDX4YKbw==
Date: Mon, 21 Jan 2019 12:30:45 +0000
Message-ID: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB2064;
 6:hwdSvAifUZnWp3+KCYOIMC3jsjarWwj8wwixmrNUKb83XhtaKbWCH5kXUqjlICQJJRYdcGQu+OL+V0elFBrrdv8poDGaR+bcZhowWtaQBTj6faJ+oZm/MfqTJMdBYwzp8CmSgODS/CUxIuhzT5UdqUjzf+Y9i86a1ORVS65/f+3pP9+TNf74OOyeRZIw8yYgtqBSH5scJGrYkffKu6iXDBelarHOUq0T+su8bsj45WuIjm5nKznlbsvF7Jn6xbLLP3F4uUr4v2vPQoZ2+pHGzGeQBccBE2ta+7kc2WrOPYKl9z0PTgq9mexEdzgxlxal5FLKTvGzatO35tc3mxvXkBu5bl3sK7FTspuEhJeKJD3xcJqEoaDx5YlE+JdfCc7z7TlT6VkaYCGYQqR2hiQrOlIFEbyqy7GfCa0MzGRgAqlUq1g+s6A2v/WmbqyX157PJdoDW8qCa/tmFw608nQoUQ==;
 5:Hb82E2s0hmLAV1i06Uo+igk+FYbW6q7BnBmM4WQoTUlaZXgs2hH9WSUXsRD2RG+W1HwzJXTOVPbAlVMTcqzUXmQ4yspepc8Imyo/Uo5H6VZoT8aIoiPuQSAKQ77AHS5szuCGvM6eLP+cTEqAXCOnuO71mjoI/K5cgrfDZ7sAA31pmPjJL7ocCjC6pemkKebx7xWFLCdvqj0x+nTMmU2/Cg==;
 7:pbJtQ3onMFzb0YARLpA7jxfbNHczp8AWK7vOxIXoBG+fepvInlw9Hv1jgrhWjL37C9f4OQNeF4G1NqtnCCTBluWEy7D2fKNd7K10kEWd1RYzFd2IgeEquWZLMR8MI0J8/eH2cbV9/qlGMI0qFGNUgQ==
x-ms-office365-filtering-correlation-id: ab0c8179-f24f-4f5b-8cb3-08d67f9c43ff
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB2064; 
x-ms-traffictypediagnostic: MWHPR11MB2064:
x-microsoft-antispam-prvs: <MWHPR11MB20641C98801178C936F6CB46879F0@MWHPR11MB2064.namprd11.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(186003)(6436002)(6636002)(53936002)(4326008)(50226002)(6116002)(105586002)(52116002)(106356001)(97736004)(3846002)(36756003)(7736002)(305945005)(6486002)(39060400002)(316002)(26005)(6512007)(99286004)(71200400001)(107886003)(71190400001)(86362001)(25786009)(68736007)(256004)(14444005)(14454004)(8936002)(8676002)(2906002)(81156014)(386003)(6506007)(81166006)(476003)(2616005)(2501003)(54906003)(102836004)(66066001)(72206003)(478600001)(110136005)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB2064;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PsY1Us0T0qTPKxz+nwDdaT2vZ1mbTzfPO3Vefzzrc+BJMgRheFbeY8RTWRfX71Ui/6yyMGLLSS97fvZ090QC3gRgm/nDk2Ajw5A2/2g82xN1NWLVN9eSSa+ZJHOmsQ/i2SYfvKogE9gZ+R43zz5vNAwi1cGoaaRzGbSbjCX7/9fYNZSTIxxqmjCd0XbdJwFPE8wGMIp3Og3iRrjHaXcLkGG/+xyU+IXi5e52g9T4AV8FslcN5eYXziW+0wZK7wMklzPTYnn9f9/CBrC7wDLXvEikam0MCv22EQ4+iRJCTEs2sqp+/fXwbQaX4h+G3B0A+HXqsvnk3GjdQ3H7PEbxaHdtrxJzrE+7l4WZLRpVvETxKnCwkYSlt757Pfz0rLWTG8AJ/7LaJsO+HLaqyIx1ENe74wgFUIFxZb8jJGSZYEE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0c8179-f24f-4f5b-8cb3-08d67f9c43ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 12:30:41.5232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_043051_655282_448F33B0 
X-CRM114-Status: UNSURE (   9.01  )
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

This series adds support for PWM controller of the new SAM9X60. The difference
b/w this one and the provious AT91SAM9X5 is the counter size (32 bits compared
with 16 bits on the previous version) thus, allowing to generate signals with
bigger periods and duty cycles. This series, modifies the driver to take into
account per IP counter size by embedding this information into driver's data.

Claudiu Beznea (4):
  pwm: atmel: add struct atmel_pwm_data
  pwm: atmel: add support for controllers with 32 bit counters
  pwm: atmel: add support for SAM9X60's PWM controller
  pwm: atmel: add PWM binding for SAM9X60

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 119 ++++++++++++++-------
 2 files changed, 81 insertions(+), 39 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
