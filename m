Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70831C2F3A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:32:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324572084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hR0NV8fh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3qsQDvHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324572084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E1PyM7M44y43Wer0h81s98iyiROJxJTRA5d1HidCyWk=; b=hR0NV8fh2uiVkP
	sDdrWlXg/4NO/ymkBMrHHuYQ+zQQ7Bj+2K1CrqG3aFFkm71OqFwxp4Db9salIT/iLyVcNo1M4Qfjv
	ggo+HTA6626MAHW6LO5QL9dVAESMJHNBC4Xg+y4dJq4xWrYfdiGzGhB3n0H6u0B2UVqI0ie/hBn8e
	x5oKQ3SiovpsjXU3nAIWcdzpyY5HNhcvAw+iMADEGeEASkNrDL+9UxY4ewbU2vZ1gKjzh1Ztr0dRb
	bk9KqfUOWUJvwbyJwFkaKWTEmzgd1JcUd1mVFNiYSJj9LSxGrP+N0Q92vn3G0DFQ2+C/ZxpZjFodx
	thwft7V+xy25rxsSA5Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYkF-0002Eo-Gl; Mon, 21 Jan 2019 12:32:03 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYjJ-0001FJ-Ba
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:31:10 +0000
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; d="scan'208";a="25752692"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Jan 2019 05:31:04 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 21 Jan 2019 05:31:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDLebRTrUkdR4ORz2bDRBjjn3SloDzw8C/rBTjydWIU=;
 b=3qsQDvHxOFAJm0WUy0yu/FuF6UO7suuEFLsRx5zO0LShbbRVANA5BGCInkNLIFeteq/L40eiQYVOZLSaaTRxFq1WObwHSPEfJcyUh7oEMaNQwr5DFfuippnPhQWjAjR4j4IKGG43IQB5RGG6k9uOn+JQ/rB+GxXqOy5KUwhCULg=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2064.namprd11.prod.outlook.com (10.169.236.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Mon, 21 Jan 2019 12:31:01 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%8]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 12:31:01 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH 4/4] pwm: atmel: add PWM binding for SAM9X60
Thread-Topic: [PATCH 4/4] pwm: atmel: add PWM binding for SAM9X60
Thread-Index: AQHUsYUrhYh5eDYo5EuY5XQSxj5S7w==
Date: Mon, 21 Jan 2019 12:31:01 +0000
Message-ID: <1548073783-22640-5-git-send-email-claudiu.beznea@microchip.com>
References: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
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
 6:P3EcW7lvSI1U0xAxHWMdijWnAw3TxNHmV9Y8ZiXGtsADr390ZOBU8gyY1NrVhA2DQuaKnZGYXnOpN7k3vMT4PvacUdoTBwVi2sYgH16xOfc5ZcWOSJDeRVHeINsyv3C8XGf+foT/Wo8MDk2qoYF2GCFMPk6f05jYEbxYjVaIEu7pmpe8HPQ1s8c0PSc/pmimLqNvhB95yqg1K5vgWzIozOKLXR7l6t72upOqD7I4DL05OZ4NjwK4IJIf3Idobhud+nb7dly4WCe6KM+ebFA+PZAmEKfHU/W3dyCKCmz3UfY9mcCE5K6ezFxww7l3aGMXPWA9Qos/fJZWGf7rr3PcfkcS88POORr5NLuRYBesVi8hAG2z0S6nRJ7435z+9oCXgZ37VcSHVjPJKmOyZ26T83p4wMexnq0LLvaNAO+b53tSKfS/fZawWQMqzMQzjyUo/bxGivlbrxi5iSmLK/FIyg==;
 5:z5hm+gBeUUEV0OB6I+nmtW7z24Zfz+IlSRpCJkVw/ZysBzlN3BZMrkbAQERWjq7/T4zaZ3psSlLKgVUTo2BbPSLstnR45c7iT9FU7Z8SBywxGAPFjOjfbohI6TauDIO74yUu3DGSJRDT8Vu0rxQ7antmqKGpoceRz8F/TMzwPd8sSXDmEj9hTXYsf7ZhhBUper8EixGcHDgMM2LfUW5DwA==;
 7:OrixNwm1hzy+WidQg57d8/zMadt6JdtDSwNnWPusWRNOhy1+1dJKXBeWQgrCQNNl9P7PlAQHbegTUrU5/eXKPdjMIuEMNA3RNJ/b0UsV1IhvyRxfyebf6EFxbsElLY90pMl+rh0wC1QMT1n4lyZ1hw==
x-ms-office365-filtering-correlation-id: c245cc01-bff6-4d08-4a01-08d67f9c4d6c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB2064; 
x-ms-traffictypediagnostic: MWHPR11MB2064:
x-microsoft-antispam-prvs: <MWHPR11MB2064EA045F7AF7EBEEB166EB879F0@MWHPR11MB2064.namprd11.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(186003)(6436002)(6636002)(53936002)(4326008)(50226002)(6116002)(105586002)(52116002)(446003)(106356001)(97736004)(3846002)(36756003)(7736002)(305945005)(6486002)(39060400002)(316002)(26005)(6512007)(99286004)(71200400001)(107886003)(71190400001)(86362001)(25786009)(68736007)(256004)(14454004)(8936002)(8676002)(2906002)(81156014)(386003)(6506007)(81166006)(476003)(2616005)(2501003)(76176011)(54906003)(11346002)(102836004)(66066001)(72206003)(478600001)(110136005)(486006)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB2064;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ANkjIqjULXzUfWjeM9VoR67RCtfBGLm9wYRMwl0+K9vHXISZPiWa2H+k8V1Mxr5w/GNeMsZVTx3qlBvpq4b3iDXsqtvNREmd8aN3H6uKAgC02gISBlj1Fusn8zhHuIuwzKrf3dzt/dvuDvgVgFScoPUaAqFGOvIKCaCjAk1hKCzAsMuQGyRjgnluDbJ0mmg4AUkB8IZ4OFPHLb9iI+0p7tpNuVYdd4QUyd8wRc/ZTnNJodNgdRjsmiF1HqIqqcYviDuCpWR5aTJW1nRw70cnfk5neWK2BhikfeQ19UyBVzroXKLZTB8nLCrCXcQqb1sOjiOsUTNJ+4ReUlHh/QvzRYovIyKSaCyhCbx9r/RGk96QUk46jq6T1ULt7z9LJu5tfTrSSLqrS/HOwOP2UWbyn08PfLl4M1JuF1+6uVhcmvE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c245cc01-bff6-4d08-4a01-08d67f9c4d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 12:30:57.6010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_043106_095691_01916E41 
X-CRM114-Status: GOOD (  10.16  )
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
