Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1E4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:19:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A432020874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z+JEm9TK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QESDq/r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A432020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eSXVZ0nQuPJ2NrEDjJEXNFVtroHBLciq90wwuxEDYKg=; b=Z+JEm9TKG11YjI
	O9h6bGZo7dlx4MXhcUjBqntyHIX4aTzLqMzHp8Hhr0UlsqxLcXmdlrRvQrEZFOl5Y4NflYYJpaSiG
	7rxSdcHdHqaYUobSRWqpqbVcfcINdwULtbuNMSfaxTaQ1NpBtUsdwA++/mHNJeiw8qrJ3mKIeoiyn
	7alkZvD5X12tsijoueAgGfoM6u0DcwkQ9nN3g9SrWDTGeojvEa7Kd5G0ssgfsTxwgeGoIlpWYkR6I
	KPpFTdcfwo2N1uGefel+1IQ3LvXch78fdU4j9G5uHdX+FQNqtGYxBXO9PIkYfXRkdBXzWiw1A5dEN
	xtmDTroPa1h71KmKwfWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtjs-0002Ar-PK; Mon, 17 Dec 2018 14:19:20 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtef-0007If-Vk
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:14:01 +0000
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; d="scan'208";a="24462328"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 17 Dec 2018 07:13:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:13:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/jkLcqWaHllnls9ZlExlDdmmrsn65dPM/sYdupYrjU=;
 b=QESDq/r2Mvx7XdZxmR1s7jFyQxTXKhiF9LF/7weKp1dKz79CdInGHc0k5KsE/BWbT8bGdDorAmYAbpf3+V8QMjdqzdMaOd/r1sNt4zWtwQ5IFDZZj443C4EBllW7qW+iHPxOYwu6B2nRSU37YS1k+O3vEEIntd+4COzGt6OCFCE=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0584.namprd11.prod.outlook.com (10.163.159.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:13:50 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:13:50 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <robh@kernel.org>, <corbet@lwn.net>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v7 4/6] pwm: add push-pull mode support
Thread-Topic: [PATCH v7 4/6] pwm: add push-pull mode support
Thread-Index: AQHUlhK7NNxUrpqG30KBDgyJqVCMRA==
Date: Mon, 17 Dec 2018 14:13:50 +0000
Message-ID: <1545055999-23950-5-git-send-email-claudiu.beznea@microchip.com>
References: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::25) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0584;
 6:3AdtupeoP6JlYANA/DXLBj9q+9rqt5eMmrYao9wwtZnMhbwWv5CjL8GWufZZJPvoYnZ1IfbyW61iy9etotqKHcRpTh5f0MpM5WwUdFoRqMzOn7hYxqVAe8SNUk0LBDH8qeJrKDs1c3BCM+FW1HjegfMkgGQ+feLs33cRrpUo+FuYJo0IqaJmN1jHvnw/ugsvOu42tu91MeCBHeSTaPUMdjVScOJVNuATNPqwlQsJpconk9Fr42fkg6J51/ijoYSMK0MPh610wQ/TCU7VqL7N3zRE/AuZ8ik7KUHEdGHPzR3m8h8TkdaoAHUk+DCgfh73kX2dXW5L77/9z4QGCf83PNGwL+0hjlNJADRgM9QIuM1pjdlvp0XGBjFWUl1FcbA+FlJuTozRIbhij5l9C3VVa7JYLB+Z/HK8rSsQWR8HhwJhF84sziyKlzWgfTgZcg23N7m/UYHZ6U8Xy1SPjeNxhA==;
 5:MPFL1DJLVaTDXmtlWnQQxbt18W7pUrWZ+zg41TmcmUaXZEUjPl80dzuwmTuPyvVkpj52+HsUoPdU+kflI2h/ggDH+7TdOS7i0Nxa5frAvxDIYqH9/kU0CKDh6pSrKerFMrFVl+jqpX0vjI7PyXn/0dHeTg2eJb6ONTuPHzgOVSU=;
 7:fezMoWv9DiMGNekMSl6FmoVvdHZ/ayltRpgbNlAIHrLeI7YPoRKyMoDSuYc1+W88Rx6BCqDaaknzRVcdk9wuSJV09rVVgSvkjR6d4TRwGsic7wXMQMGfGUTLuZ1nqpXnQvdCsmoc9IAiJOm/zdDgcg==
x-ms-office365-filtering-correlation-id: edf7b881-225e-41da-2a0f-08d66429ddef
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0584; 
x-ms-traffictypediagnostic: BY2PR11MB0584:
x-microsoft-antispam-prvs: <BY2PR11MB058486842F8AF419B239B10487BC0@BY2PR11MB0584.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0584; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0584; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(8676002)(25786009)(68736007)(6506007)(386003)(6116002)(102836004)(5660300001)(6436002)(66066001)(3846002)(39060400002)(478600001)(107886003)(71190400001)(2501003)(72206003)(256004)(305945005)(71200400001)(6486002)(7736002)(186003)(97736004)(26005)(52116002)(316002)(54906003)(476003)(4326008)(2201001)(99286004)(14454004)(11346002)(2616005)(446003)(2906002)(76176011)(6512007)(36756003)(53936002)(110136005)(86362001)(6636002)(8936002)(81156014)(486006)(81166006)(105586002)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0584;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HQN+ExOls/wfupbcwFtzp9Vx1nDKcT8j4l+4u27JluXsItZkayh/2oKCkQfPUCCDFaNM+EOIqL7UG9X0wJVEtDtf8sbL8f6FTCRqIuqG3AS6r3Ed33HBYrRDe5Cg0poJOVyMkl65Fu6sw+/mKk71onclpw9AZh0W4tSRUo9ektzJryMIAJbrVsql/EhmLUZRcgkNFJn2i4jL31aA0K3eMpgtzFZcZ14u/0PZfUE42nIXnk9APNZzqcXChYSUlw4oE6f7FPCEtAgN7Cbf8moa+5mAW6Y3CFxaZdp60eEtpW25MTwtj74cQW8bj6Xo/5/l
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: edf7b881-225e-41da-2a0f-08d66429ddef
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:13:50.3442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0584
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_061358_474404_19B82DE1 
X-CRM114-Status: GOOD (  10.22  )
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
 linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add push-pull mode support. In push-pull mode the channels' outputs have
same polarities and the edges are complementary delayed for one period.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/core.c  | 3 +++
 include/linux/pwm.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index eb444ee8d486..f182d1eb564e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -328,6 +328,9 @@ const char *pwm_get_mode_name(unsigned long modebit)
 	if (modebit == PWM_MODE_BIT(COMPLEMENTARY))
 		return "complementary";
 
+	if (modebit == PWM_MODE_BIT(PUSH_PULL))
+		return "push-pull";
+
 	return "normal";
 }
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index abe189d891af..cce29733d44e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -32,11 +32,14 @@ enum pwm_polarity {
  * PWM modes capabilities
  * @PWM_MODE_NORMAL: PWM has one output
  * @PWM_MODE_COMPLEMENTARY: PWM has 2 outputs with opposite polarities
+ * @PWM_MODE_PUSH_PULL: PWM has 2 outputs with same polarities and the edges
+ * are complementary delayed for one period
  * @PWM_MODE_CNT: PWM modes count
  */
 enum pwm_mode {
 	PWM_MODE_NORMAL,
 	PWM_MODE_COMPLEMENTARY,
+	PWM_MODE_PUSH_PULL,
 	PWM_MODE_CNT,
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
