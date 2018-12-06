Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21BEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:07:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7108B20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZA4aIG6M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="dFBUGQji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7108B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=McQ3DVpNvKf9aMYwP7Hh0k4GCb5ZZQNGuIEbt4u9h8g=; b=ZA4aIG6MmKFFEF
	OfT+0T+2X4HGl5EIjU3GM13Naulbb+PtIMO5sCnFe+mOV4L4slp+J1S3zKHXxTud5GeoCYzt12HxB
	Fee/orlABtviyYY4YGQlc8197IdFmtisI+5mYolj00clDMkGs+dd7Ekqp+n4Oh01phCQ/HLi0GYb5
	x22ArHFawGFzo6UtpnfK3WpwHHiJdqEzCBEQuYXJAND+L1bHHNyxp9uQjDJx8eidBG4dvgzZlF+BO
	hfDQ3cl8Fp1fQx+FC2S34UhOdTScZb6rP/fC5JRpzwV7zV98ZBu3SMEKlgTR1L+ztH6IDpwHRRYG0
	sYknBvBbbbu5VO5g3i9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsRK-0005Xw-EH; Thu, 06 Dec 2018 12:07:34 +0000
Received: from mail-eopbgr810085.outbound.protection.outlook.com
 ([40.107.81.85] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsRG-0005XR-FP
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:07:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vn72x9QaKH7thCn7Fik87OMXNZqWUAlVUFajR263ykw=;
 b=dFBUGQjihskBaqFNxayYlAaZljkHEnBNYye5tD9h+P63aGHa0jC29u8H5saMd1pksr06oC5UKHmzvu1+G5ggsuWP5hioibQvJlMC8e8+rYh+CdKw/yDW1g13Kqu3k1vhx9wVb5FQR7S2YyXoMMA0CBGhlcpJ24UQrYRHkOeU9UI=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB5315.namprd07.prod.outlook.com (20.176.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 11:51:24 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::f892:12f:1622:393c]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::f892:12f:1622:393c%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 11:51:24 +0000
From: "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v11 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Thread-Topic: [PATCH v11 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
Thread-Index: AQHUjVoDVKOOAvuMrk+MXZ/HfMWH/A==
Date: Thu, 6 Dec 2018 11:51:24 +0000
Message-ID: <20181206115053.7665-1-ganapatrao.kulkarni@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::30)
 To BN7PR07MB5298.namprd07.prod.outlook.com
 (2603:10b6:408:2d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN7PR07MB5315;
 6:Y2HJiZO4Yl0EclUhCuwTxhBTkV13WCTVJOPadWNf91mkeYTCk5IErgBMjtOqjJJg1kY9ijA8PySVovL+my++fAGCNT409xKTKmiMW5ft7Eg1t5tpd6vO5+u1EcYcRL/9mDp5TJPk3DT0GG7EkciwAFj+614DQg7vmRtfXM1vv4SJKV4A+T18M6dA2iBf5Ma/VjrN4hutYgQ7rlVHoAZ7DZKsxZYEQL3oRbYNXH3W0qX6JiN+p+cPTsBoGLzoQCKCkv9STHA5syZhrpDUA1ScUklk4fXY9dXuXiEyveJxXB6oh2W3rwdQdWpXJy+W0Yfp+h/tf2s04qj4m9GAeaG9Zsns2ewiLabY+dOgLKKQFcFO4Ho/vaDeHKWh2McXhNZy3tCVH44JgE8S9LAlLdcwUCBdI8xYHHNmEqnXlhVkiSTMUxMehe1/0SlWxHxUa0J850C0jW93mu/rFkpXiMMpww==;
 5:js/O5bdq04VSLv4hDn431qVec+CsvAX47j5gFvbB73uf2u3eosIfSl88RyApCqzuspBvKcAH8LQITXz+v6YcayXsK+9rFF5kFUgaVUfuffmqnQDssbkZPQYmMqvZEXozDI7Orfv4Z6LepEfpg7m3WLGKcUPndPoZbfuVFiSn/5I=;
 7:jt87Et57+PlEHqTQEScodUiFKSUKbUlAuSUYo5e6HI2uId+e08JjdYFcWGSD5gjXlCrcn1GhVOQLUokyrMtTpMGXN/9r9UxZz9iX4qpVFl4u/UDx2zlB2IkJkZvbsY6Az49oLyrztO3VCRnBtXjxSg==
x-ms-office365-filtering-correlation-id: 6cc64019-91e5-43ee-2b4b-08d65b712582
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN7PR07MB5315; 
x-ms-traffictypediagnostic: BN7PR07MB5315:
x-microsoft-antispam-prvs: <BN7PR07MB5315A6AB2CBD819863AE0A7C83A90@BN7PR07MB5315.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BN7PR07MB5315; BCL:0; PCL:0; RULEID:; SRVR:BN7PR07MB5315; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(1076002)(5660300001)(2906002)(53936002)(6306002)(2501003)(6486002)(6436002)(316002)(26005)(54906003)(110136005)(186003)(102836004)(6512007)(6116002)(3846002)(36756003)(99286004)(66066001)(8936002)(71190400001)(78486014)(2616005)(71200400001)(81166006)(81156014)(25786009)(97736004)(8676002)(14444005)(6506007)(52116002)(386003)(256004)(476003)(486006)(105586002)(7736002)(86362001)(68736007)(966005)(4326008)(305945005)(2201001)(72206003)(14454004)(508600001)(106356001)(39060400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR07MB5315;
 H:BN7PR07MB5298.namprd07.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iXjGQKDCsKKBecBe3hqIZBARCL0/iOGR5WtY3sm5YxuiwJ4CfaPu0wQAvIza7GLxn/PFaQ8rHDMpRXxVY8o13ODMrGsLhaCfNA20RtSbXZDdpSs1kmV5yfKck8ylzQvNGZQ5ZwOupzkfjK3YcUp2tFecuTi1Hk/MZ+RG919Yfrr6YVjI9ZlWXrL6nS/SpoF2XVtG+dbCLs61gRfbrnGBzquzYiDDvSp3ntw2KahLN3N1nAtbmrsYr+tKs61UMSq0M0cHuhZSdhln/4hWxrA6QQzUq8VXdqV+fid1U9YXAIr4XD94nQecojt5R0L9ZqjccwkknLwDBgtKo33u5RmpGyOU/Ly3B4Ey/TBQ/ktsFsU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc64019-91e5-43ee-2b4b-08d65b712582
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 11:51:24.2356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5315
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_040730_516885_B8E2F4BF 
X-CRM114-Status: UNSURE (   9.39  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "Nair,
 Jayachandran" <Jayachandran.Nair@cavium.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "gklkml16@gmail.com" <gklkml16@gmail.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "Will.Deacon@arm.com" <Will.Deacon@arm.com>, "Lomovtsev,
 Vadim" <Vadim.Lomovtsev@cavium.com>, "Richter,
 Robert" <Robert.Richter@cavium.com>, Jan Glauber <Jan.Glauber@cavium.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).


v11:
	Updated Patch 2 with minor comments.

v10:
	Updated Documentation patch with comments [6].

[6] https://lkml.org/lkml/2018/12/5/649

v9:
	Updated with comments [5].

[5] https://lkml.org/lkml/2018/11/22/517

v8:
	Updated with comments [4].

[4] https://lkml.org/lkml/2018/10/25/215

v7:
	Incorporated review comments [3].
	Modified driver as loadable module.
	Updated Documentation with Event description.
	Removed per-channel(no SMC calls) sampling implementation(
	Since DMC and L3C channels are interleave, we have decided to
	sample channel zero and prorate it to account for a Device).

[3] https://patchwork.kernel.org/patch/10479203/

v6:
	Rebased to 4.18-rc1
	Updated with comments from John Garry[3]

[3] https://lkml.org/lkml/2018/5/17/408

v5:
	Incorporated review comments from Mark Rutland[2]
v4:
	Incorporated review comments from Mark Rutland[1]

[1] https://www.spinics.net/lists/arm-kernel/msg588563.html
[2] https://lkml.org/lkml/2018/4/26/376

v3:
	Fixed warning reported by kbuild robot

v2:
	Rebased to 4.12-rc1
	Removed Arch VULCAN dependency.
	Update SMC call parameters as per latest firmware.

v1:
	Initial patch

Ganapatrao Kulkarni (2):
  perf, uncore: Adding documentation for ThunderX2 pmu uncore driver
  ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE PMU driver

 Documentation/perf/thunderx2-pmu.txt |  93 +++
 drivers/perf/Kconfig                 |   9 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/thunderx2_pmu.c         | 861 +++++++++++++++++++++++++++
 include/linux/cpuhotplug.h           |   1 +
 5 files changed, 965 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
