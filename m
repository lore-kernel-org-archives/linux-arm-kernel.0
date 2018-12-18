Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3CEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:01:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182B921873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kssQgN8k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BZmePiYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182B921873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4mf5V/qEmL/lj0iz7SRQiQSs5DCo8hfoQZa5GrNQApY=; b=kssQgN8kEY769F
	QPGbs/Ey8AORKxEEKV09i557yhwLbY9QHH6cN7I44an8HFXhSf+zbjKxAG5AkFNXVsdSKwcVugRu8
	YL09OPyMnrKsDNjwsZRiJ3otR2Wym9x0mtZR37uQRT8mO7G1T81RoM+xI3+rZr5oZEfjV9/8mm6u/
	ykuMbzIk1ATPC+3VMApjv6HGwaU5FAvk82Vt3pFQbaM2jtBiIn/ZmwwSuHOp11ujF/p09Q/0ad5Jq
	BtLfZPRVlX48Pi+DiSZQKrX4sSyaScxBIZy9cG+/B5DVJ6JoASn7o67PT6pNDcYqD14DKbkOqNFOz
	kytEqMaGV3T4Yie4rynw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHoQ-0006Pt-SY; Tue, 18 Dec 2018 16:01:38 +0000
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHoO-0006NQ-6u
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 16:01:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUFZD/k3MPHARrBrVtcICcwmDwzFo02zo/i6+6iHEUY=;
 b=BZmePiYLxgPNLfmj5bcvV7I8NXVo+8MgZEg58fmVg+kC/vB8AGCw4SoLZSDFb37GzeRgQT4yMhrdqDZp1Z4tHmZ8hrnY9orEuSDnwkGwocrqIEJlc2m33A6HWvupDTO1nK+9p5Hubv0ANzUKaqVgRlfFtQIBCO2a4EGVmVxSIC4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5202.eurprd04.prod.outlook.com (20.177.42.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 18 Dec 2018 16:01:15 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 16:01:15 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] firmware: imx: scu-pd: add fallback compatible string
 support
Thread-Topic: [PATCH 0/3] firmware: imx: scu-pd: add fallback compatible
 string support
Thread-Index: AQHUlurnkkOpfd8XR0GtHCPkVJ9KYQ==
Date: Tue, 18 Dec 2018 16:01:14 +0000
Message-ID: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:36::28) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5202;
 6:pWPaXdBgnXnyg/SUB/rakQ9RyqRW9MhZLUh6qUqq0US77jup6+1kgAZ0SrWKsn49Bi3fPlzfDzS7pzHIt903AXKIzjoWUqRua3vHptyI2yGFhqafYWApUW+bt3RbKU+MTd7pLIKNNLdVgGlBPeqBBiGwj22TBqS99cL4pIqNjgctbYomwvXc6r8qCCqlxFoXXNZ6Gvbzj7HXnQOcKHN+hgiSMxAZc+rbkRXP5HR1AW3wcNO0LdjZKEhBUij5lhO6+5hMum2BlnZcUiT7TCzL4WTVxbDIk1clURWcGZ+M43R8Lah3scXOq+vNbnbNkojAWZ4HJSRFlNFPVJ/XfZMRiH5zUZdijRRB0k/Lui85mvrEFmakH9GUV4/K1g84eOkfRHZ3/spJEtpaXbDNQj4LKo8OB96YLY2AOEOuQ6YJVyeNmv7HaqC9PLkZy0V0Ui7zHnLzf0mcwPhduopSXqGWcA==;
 5:t2S7tblG+cTG//LWaR5PRmeqvOIu5swTN1lROsk1uw3Pjqa0t+BCP5qtJyJbqsqb1S+eyUg5FnHogM5hYIuiKflVdGNI0J5mSwerOb3kSv7MsEEnIijcBwDccALTNkzkpRc+iwk5cxBq3pmVzyPa7JUlxag09Z0WVKCWxQ6UGfw=;
 7:QqhxUgYhNT37F1rMVnshuZUdr+7+nvpT0M0nh8IkmKR3qLc2kwNFzSZowkf7BdMQPIjXNvOaFM8fqTmQmDowcBB/bEYmNWFfu+0KT2kJOQpviOXbxG9tSZ3LEvzAknb1sBbtV0VwDHHVbJt6ARcP2w==
x-ms-office365-filtering-correlation-id: a90e53a4-587c-403f-960d-08d66502091c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5202; 
x-ms-traffictypediagnostic: AM0PR04MB5202:
x-microsoft-antispam-prvs: <AM0PR04MB52027C284B7ADF7AC76EDCD880BD0@AM0PR04MB5202.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5202; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5202; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(2616005)(7736002)(476003)(486006)(106356001)(68736007)(39060400002)(105586002)(53936002)(6512007)(97736004)(6916009)(4326008)(66066001)(256004)(14454004)(44832011)(3846002)(6116002)(6436002)(25786009)(5640700003)(8936002)(6486002)(71190400001)(71200400001)(2906002)(478600001)(305945005)(5660300001)(50226002)(2351001)(81166006)(8676002)(81156014)(2501003)(52116002)(386003)(186003)(36756003)(102836004)(6506007)(26005)(99286004)(54906003)(316002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5202;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3IuzS9r006CsC/01cGR77XNs1Io6JIsV5odmIwUsz3FUlKYp3nGpJPk0Soq7RmVt1uPbSlh5d71WCNL5a1IdQ+7aP3dyRyTrB2gl6ID9/W9dsZDqalRWSa+n9ccPGEWFfiUlpKQUqs64uCjpJmBg6IMa1Ueujra3MKUYwZWO638jl8acG1bHkh8V7xDvMAp7ogmFalN7FyD6XNu+AsuE/t5Ks9kYnJI6j/FZk6GPtpypJ40BoBfGaHTiZKwKYu+FTiv+S8aGKlKn+2chZAs/MuFk8dgYKcSDI4rVFlTklqB4Qo9/drrKO8M47Aa9kjQT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90e53a4-587c-403f-960d-08d66502091c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 16:01:15.4994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5202
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_080136_249894_D41A7609 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SCU power domain can be used in the same way by IMX8QXP and IMX8QM SoCs.
Let's add a "fsl,scu-pd" fallback compatible string to allow other SoCs
to reuse the common part.

Dong Aisheng (3):
  dt-bindings: fsl: scu: add fallback compatible string for power domain
  dt-bindings: fsl: scu: add imx8qm scu power domain support
  firmware: imx: scu-pd: add fallback compatible string support

 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 8 ++++++--
 drivers/firmware/imx/scu-pd.c                               | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
