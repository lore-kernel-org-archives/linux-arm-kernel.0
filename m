Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:04:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314DF2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i9yceCBd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BNmKIrHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314DF2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B7rX01O/rpbWvyR6ni1a319MEi2IOSQKLiVCjnc/dGw=; b=i9yceCBd1NkMZ8
	V4bYu2UdOAOHU+yVm+Oio0OWu934aS7Z4Bo9ITD/o6CjCQtB2gemGs07mjAnvI72xsYMCR9g+wLOz
	abNzcH4GQj6iRPshgi7MV+G48rimcdNLVrlHSDM9WMouyMP6g+rz7IoW/tJzHJK5Wvj+pLj3iFwHx
	clwHHMuK0PLtU8O8+LLjs2u7cXKg+0PMX54s4pcaTO9PqlnsAXQZtj5KE0oQwLoILtrygF8Da77Wn
	NfrJ9VNYAL9V1rpFX/pxlKQwbDhFTqKIFm10d0+r97h2TUG4N4VISfmOGN5SaJzQx523Mc/xlhabr
	fvc//mpJ0s2e6PqKQAQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtVM-00020a-44; Mon, 17 Dec 2018 14:04:20 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtUc-0001CH-AJ
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:03:42 +0000
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; d="scan'208";a="24461888"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 17 Dec 2018 07:03:21 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 17 Dec 2018 07:03:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq2ha2Zp/A7gCczGWZsdnelFEYRsJlhMhMg3kS8FWDM=;
 b=BNmKIrHsIJH/k55mRvxZOdnRP0a8uQ8VKYwZ7pRNq+JoRjC7bzzkh+P+/B2MARQNcea9p4b+1QIDLGbpn57LN4cZbUb5YNAMbXKUs7p/Px1lu1BsqSVkKpEKqnZ+h9+LNSxvHWF/ATKV51Y876Qc3Yo82NQlHHYQ3ZYJ2R+R/Xo=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0504.namprd11.prod.outlook.com (10.163.158.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:03:19 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:03:19 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <corbet@lwn.net>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <robh@kernel.org>
Subject: [PATCH v6 2/6] pwm: add PWM modes
Thread-Topic: [PATCH v6 2/6] pwm: add PWM modes
Thread-Index: AQHUlhFDh5ZEGoOjWEKwF+46Bd4N3Q==
Date: Mon, 17 Dec 2018 14:03:18 +0000
Message-ID: <1545055368-23338-3-git-send-email-claudiu.beznea@microchip.com>
References: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::34) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0504;
 6:VQEXbrKAkgO4K3S3/+Yud+zAmjFjRR52ptxsWRl4VpL/TdP1Kh6oIfOCTROnIFBBC7AhOPSBvB7nb1Q6Ty3SoKV4uie+tS0NppzAOzsVWk9POuZRIV/u+OT+2v9OttA2lTlRa0pqOsYmeq/Lg0Oy58uuofBa52j7Tn6zKhvgKRGys4JRsTJCOfqqDnmG+saTG3NSpMMxYd6SwjdGU1Gwm9+wDo3MgBT7VDy6IvAJFwJu1i3NUawjM4Ol/UucOG854fpnNJQHJtbHWFD6FSsi8QqstF80azSGtj+Kg6tNhwwSL1hyjdoz6UGER6fyagYJkQB+jLN5SOr6Mu5aLGrJUFds8Jy/w7RLFoSUShLHgj2Fuv+9hXXWCjrrfNrCav0Y9NQsSpQbN5axLBDyGbDpY75gdAQCSaxWTo93Xn30kUOzheE+IkG+mBjvoKRILfV7hWcohJ+pqU1vRNcWdzSNBw==;
 5:o/hbWnxBNDluWT0e0VPa6HdfjS/6KVbKl3nFpBC8Xu4iNFNqZ/U27jl+0NIb+yOMQaKJICvwPhxV12RqZsbkZ+YE3uQhUJnp2MFP/Erh2GspyNNVcX/o+g5sf/txge1xAzoHGwP0QG+xDH9SK7rsnYe5tV3nuvnW1nuyiH63unI=;
 7:Tsn6e2l+rcbtdGq5uIE10U1fqFZHUsfsjYyVv7celVtZujpZp5Kw3MBYS2PwlaAbczZCjZ57S6x3NeKj8QZklpVswgSq9F1NKISYSB2zbjk0Nr8lHVeQ8ozSH+Ch98ri9sObiMmP7XXOSHFebs+27A==
x-ms-office365-filtering-correlation-id: a9461861-e2e8-43c8-406e-08d6642862a9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0504; 
x-ms-traffictypediagnostic: BY2PR11MB0504:
x-microsoft-antispam-prvs: <BY2PR11MB05041B4CF7A45D42D038DF3D87BC0@BY2PR11MB0504.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0504; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0504; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(52116002)(476003)(186003)(106356001)(14454004)(5660300001)(2906002)(97736004)(99286004)(25786009)(86362001)(11346002)(2616005)(71200400001)(71190400001)(6436002)(6486002)(3846002)(6116002)(316002)(110136005)(54906003)(66066001)(575784001)(486006)(26005)(6512007)(8936002)(81166006)(8676002)(446003)(36756003)(105586002)(102836004)(53936002)(72206003)(81156014)(305945005)(6506007)(76176011)(386003)(68736007)(39060400002)(478600001)(107886003)(7736002)(14444005)(256004)(4326008)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0504;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sjke3QPU0SVmI3EaNAkKo2EFL+PD1SPoRd2MmspSszV1EgvIsjhF8dGpkFJ4LIx1oZO9vWkE5H3phCG/IGTdpFr66Hxy3lzVmVSr5hnxZe3iDJRq4IAoeVMkUGLaYRXzgzRl/WCtktko2mpS5S4ef/u9wPCr2KEZjloUCj5ANyYMW7f8KMb3FmJBQ7kIiioYufstZxI6KvFZhHJg+EHyEE3uOTT2G23QiV7pVSHTKv55w6LkNclBJsVGyOn5BV8FKxcxxYTHDn+C0rSkUEbFAw2k0u66YBKE2KMhoKE+pE1tZ34N0YmD2reV55YVLtPJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a9461861-e2e8-43c8-406e-08d6642862a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:03:18.9103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0504
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_060334_729154_579168C6 
X-CRM114-Status: GOOD (  13.49  )
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

Add PWM normal and complementary modes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Rob,

In prevous version I had your Acked-by tag on this patch but I removed it
in this version since there are some changes b/w the previous one and this
one. Please see bellow and let me know if you are ok with this.

Thank you,
Claudiu Beznea

Changes in v6:
- remove DT bindings since they were also removed from code
- use 1/3 duty factor ratio
- use '^' symbols to emphasize the beginning of a new period
- use PWMx_y to refrer to output y of PWM x

 Documentation/pwm.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa3ba2d..669fd4c9cc8e 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -110,6 +110,28 @@ channel that was exported. The following properties will then be available:
 	- 0 - disabled
 	- 1 - enabled
 
+  mode
+    Get/set PWM channel working mode.
+
+    In the following description PWMx_y refers to output y of PWM with ID x.
+
+    Normal mode - for PWM channels with one output; this should be the
+        default working mode for every PWM channel; output waveforms looks
+        like this:
+              __      __      __      __
+    PWMx   __|  |____|  |____|  |____|  |__
+             ^       ^       ^       ^
+
+    Complementary mode - for PWM channels with two outputs; output waveforms
+        looks line this:
+              __      __      __      __
+    PWMx_0 __|  |____|  |____|  |____|  |__
+           __    ____    ____    ____    __
+    PWMx_1   |__|    |__|    |__|    |__|
+             ^       ^       ^       ^
+
+    Where '^' specifies the beginning of a period.
+
 Implementing a PWM driver
 -------------------------
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
