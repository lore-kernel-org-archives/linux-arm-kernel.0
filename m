Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38728C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C0D2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dE+SnroZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fe6qeE79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C0D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BvY3SQK4M0l9RUraS2fpqhyj2OZlhXzVqSUgwwnSQlM=; b=dE+SnroZEgRcFa
	EkAzdC1j/jO+h61tKeHfxUi0LiCCv/whasgj5rkkZEJ9VQcq4ado6r7jEpSKXQ3Iq95bd2EzsGQzs
	byABAVuEofNxp4OQ+K10/tlIGDe8l7b7CupMgbDDTOb6lA+5asskKiMFftT2z/xhvgauvDTNCiiag
	UnePyp97kQoI5ViQB4Y+xBAlzEAMsXmmAyLO8UypOgTfN73InAvKBk7GKrEPbJSeZXiQ8D8ZoXSFm
	nQz1O+R/B/IUoEEN5ce+al7F+e1PJokHP6ktkNgISfeVhfobbVk0RbBHSGjlL/i9zpei/1D4claZg
	qQuJwHKeUXyrp8nkeLZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8kp-0001rL-NG; Tue, 04 Dec 2018 11:20:39 +0000
Received: from mail-eopbgr130042.outbound.protection.outlook.com
 ([40.107.13.42] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8km-0001hi-NX
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoE841FJnowX73LZS5XIVWkxzjgp64jXGbxf1NpRBow=;
 b=Fe6qeE79Yrpn9yRmAkpQPT6y4EEwoeCxorQdDG5UxwBsZLfn58FfrwpCRByVyoP0oDx975yYLbzjyBDO9Zwh9ZpGHDxtlvZCGZHmHTbQpVglXCIFPFGq88H7tIiJpEGwTsLzukZa/qT8GzaCwtSdEJWCexpdbrLsk3cZKFkMWQ4=
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) by
 AM5PR0402MB2721.eurprd04.prod.outlook.com (10.175.40.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 11:20:22 +0000
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa]) by AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa%4]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 11:20:22 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Roy Pledge <roy.pledge@nxp.com>, Youri Querry <youri.querry_1@nxp.com>,
 Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v2 0/2] soc: fsl: dpio: cleanup on the remove path
Thread-Topic: [PATCH v2 0/2] soc: fsl: dpio: cleanup on the remove path
Thread-Index: AQHUi8NY/qVDx0R3HU+wg/jBhhsemQ==
Date: Tue, 4 Dec 2018 11:20:21 +0000
Message-ID: <1543922408-22950-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0135.eurprd07.prod.outlook.com
 (2603:10a6:802:16::22) To AM5PR0402MB2785.eurprd04.prod.outlook.com
 (2603:10a6:203:98::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM5PR0402MB2721;
 6:JrdlqMRvRQRzTxH7/d8UmU8bI2jqv0LqUDoVYSXtw2Hbplxou8W75zJINuEzUVdTiBmAmqZP2UkmY4CLvI+KPimq5S0Rhtu+8jalL8xN1Xq0g38BDce6zAqLo/tHctXB5XaNtfjbZ0PswLcmkGTbrLFkWMbxdk07ds7UYx1qHbkDB/0R2MDG6T+T8puCM4YM+YTmr88mOf4lO5+dN7LKgpyKb6TR4WqxtDPAK4GUnWX0TSuJAdH5SC1mZ784y/x172y1kPYP/XoSi4KPOTDPc0JJRrWPlLuEV9hyen0vwAmt87tIqi6DC7nLi6NFt1aMRDfc/brPdpQ0voYIVd3bDp+OnHKZbCi8WIklDB1aBKjeCD0TNchFp+ubcPQSQUkV7nsldeWXyiZ5JXj8A7s07EhYPzq4W3gFdupw42tCPRR/kDSG0Ik9CkenDlTcYsfBHvtR08/ykkF+z7NrL+CvPg==;
 5:7LsGJm0JyQH8ban1d7Y+lIPUcypTpxEoJqAp/FbnDmta7JwFSq//mARul7bwX00yaO0GqI2JmCJFCoFeh0YJM8ecPSezi/4ozCbT++YtnNyGgoI3gtI9sORIw1KM6WMfS0NUNzrshbNBf+87ztUfYKHr1Dg1VX4Q4XYwmtOxptM=;
 7:J+2Btbwj91EW6BsTTrn1Zu0B/EIcMDPN9gN4D1duxXXIFYIbMH/69iHiryIYNpPg5BP7dwJQCBChJaXecZIYrcdAaY3toxYGj5SmF2XnpmQdMQHxwhFLwhFS/CD5+p6Bbaon3AI85HrlSRZL0m1o+Q==
x-ms-office365-filtering-correlation-id: 7985a4b1-bf80-46f2-9b29-08d659da7aba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2721; 
x-ms-traffictypediagnostic: AM5PR0402MB2721:
x-microsoft-antispam-prvs: <AM5PR0402MB2721E1326F5B8185FBBBAE70E0AF0@AM5PR0402MB2721.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM5PR0402MB2721; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2721; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(476003)(5660300001)(71190400001)(102836004)(25786009)(6436002)(52116002)(71200400001)(66066001)(386003)(26005)(7736002)(186003)(68736007)(256004)(6636002)(6486002)(305945005)(99286004)(14454004)(6506007)(110136005)(54906003)(106356001)(105586002)(97736004)(486006)(53936002)(478600001)(44832011)(6512007)(6116002)(2616005)(36756003)(4326008)(8676002)(81156014)(3846002)(8936002)(316002)(81166006)(86362001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2721;
 H:AM5PR0402MB2785.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MtlD0TNeaj4BaMtmFxCl/DSeFuuMGpB0uSuxq9dyGQIB6LXUbiyzUqkE/J00dVwsrTo+tdii/GU0D6Q29tBw/hn3L5CAE2EVDTPNIjGNzNEiLIl5fQZOpWPAnD6YT8cB/Q47eavuU5djpNSKUDVUR9kDcQYmA6WEDBrqM+bH5+F4zbIVqlcoaxJ8V4iDBGcbDwVeqh1lrw+zobYsHWbISo8gkyZ+MDqW32vsCoDDrZ8650dsDJw1L114wk7nTEoImUhqeJllDvkSnJW0KKin3QQasWeYEApULIfa4zb/DwX+BkkFWXy9tjc+sFUmIe6fOplvYZp/yaBxknKATwShfhN05F1nIwd8QJ7huQVYnAU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7985a4b1-bf80-46f2-9b29-08d659da7aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 11:20:22.0499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2721
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_032036_819393_956B5B49 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Horia Geanta <horia.geanta@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series cleans up the remove path in the dpio driver so that
successive bind/unbind commands behave properly.

Changes in v2:
  - added kernel-doc comment to the dpaa2_io_get_cpu function

Ioana Ciornei (2):
  soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
  soc: fsl: dpio: use a cpumask to identify which cpus are unused

 drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c | 18 ++++++++++++++++++
 include/soc/fsl/dpaa2-io.h          |  2 ++
 3 files changed, 36 insertions(+), 9 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
