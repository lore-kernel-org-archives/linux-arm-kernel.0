Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F75BC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:14:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AFE2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t916vwdj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v/+j3rwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AFE2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ogNScQWZPJZxN0faiPfZC0fNUQ8xaXoGq4gWuNtGxAo=; b=t916vwdjSXjlQ7
	YPQnv0WwkQYauaLDUKDOdhVnxVTyJ+HGd2vU5Km95s7ygXuMkXxrY/SAYwBT6YnN5mE/j6Mu2WLWv
	uU5O5M1zo3keJANEV8d7mPx8eHHpNAO3n/kOsHKwtZv+OD0rzbaPTNO0efKgVREsCFmUBRf0uG6F9
	s8+WF7f8BeWPju41Rs/cOiG5x/ro2est9nd973n0+IbgcuyONy67wj8GSYrFWtY88YUdwmRkwzizB
	7hZjxxx20NcvSX2be94+Qxx9VzUmEWHQBLOl5bBPvlrpN67eoJZCyIzszIKHGR7DNfujdAmQQGEXo
	8iy4KZm4jkR6ogCC1Ygg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxkf-00012D-13; Tue, 05 Feb 2019 10:14:49 +0000
Received: from mail-eopbgr140040.outbound.protection.outlook.com
 ([40.107.14.40] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxkb-0000zW-1z
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:14:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH50gOLcom9OSQehZJpibvFWh4GYxhU1Iti8qPrl+zg=;
 b=v/+j3rwg2hH4Y9GUiAkiRm4kQxGWVYV0m66JmCYeSqd15fs6/dIlD9GSxeqaRHAuYT7yoULGScogi0at5n+e3hT7+qFaalSnGdhqSe9PqlgLwAKX7hJA3Ku3KL+2Xl5npgs54WuyRrzpANAgRzGCU2mJA9GhCGzlTY2fRnv9XbA=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2030.eurprd04.prod.outlook.com (10.166.141.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 10:14:39 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 10:14:39 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/2] add qixis driver
Thread-Topic: [PATCH v4 0/2] add qixis driver
Thread-Index: AQHUvTuasEwNjg2eckWnM8rIkKU7jQ==
Date: Tue, 5 Feb 2019 10:14:39 +0000
Message-ID: <20190205153924.7204-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::29) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2030;
 6:9L9CElNPsNVa5U/uFOj2F3SPSN66UfOyiEAzx4iIkEwASo9nlGeywQtUp9zVGT3UYsB2fxTljfOLqNuVszJTCULuYLO8oq5hNgQPGxDc80P68qZNv08KkV2NvmN7fXxRfM/xEP+btxBuyw4ZEz0Wd+RVvh4TDnWGsohKDvTnw32sj+bzsoKKEK5alWeZaarrhl0EYWyVp7q9u5um2C5Y6u5Nzyp5DcVg9Xhj/t+pOfm8JLGznLafWZOc6DHUMyApTrBtsJTILuKgOPD/jQxU5CjBuLbQmBtVb2KPdo2zPMRtg5iXMkSEkzcA55wlLWhMC38ogQh1dBOsx0lOhEed1CJo1LZAjtv1kjM5ie9dMrURxdbEsxlQkEIhzWLH1tw/Mxdr+t3kF9RIsMxNGmckTbauImb3Sg1M0qUAyi79l3u37CKdegIr/gP3XT/FFnElVZknI/qr7GHj25eD1mWeoA==;
 5:swFhlZ+9bmpw0LE2AbyYNoYveZkxkneiwZSjqh5XcHacXQgk6gHNyd1vyE9b46QxTAdQ7637yiktOsP0/CwTf/11acDnvLj0At2VqWJvnNORwbuHJDolCBQB14pgO8U50RXv4pixnL28zK0BpMCMtPzKFV98q3t+xRRuG2qat8BnLtpzMbCpDZJM2enAu5xzawr50rlC6e/IDTSOE9KeEw==;
 7:NY40+LZ/lS7pTARxQhHob6Oft3Gb4Of0Wn1bLd2GoS6LijN7iqV6KYTt9tOghSH5G6GlQvWFplDhp9UIHCM9fcvUZlRbsRv4HqB5MO0K29A/pqZrkTxINt0/DkMfBjhIqUIuHw4fVihx1qTTqckGbQ==
x-ms-office365-filtering-correlation-id: 0e573c03-a6d1-4240-2b5a-08d68b52bc92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2030; 
x-ms-traffictypediagnostic: VI1PR0401MB2030:
x-microsoft-antispam-prvs: <VI1PR0401MB20305522A0B4E70F3936F315F16E0@VI1PR0401MB2030.eurprd04.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(25786009)(8676002)(2906002)(26005)(14454004)(102836004)(386003)(6506007)(99286004)(6436002)(6486002)(6512007)(4326008)(8936002)(71190400001)(81166006)(81156014)(71200400001)(256004)(6306002)(105586002)(36756003)(106356001)(52116002)(486006)(6116002)(3846002)(44832011)(7736002)(110136005)(476003)(2616005)(966005)(68736007)(316002)(86362001)(53936002)(186003)(1076003)(50226002)(305945005)(478600001)(97736004)(54906003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2030;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HPeNI84WXTTpUsGRACzywTWJnAGTm65bxzb4zILBH7Tp1XoAryHZ6VYuSNvQVzDzTazRzSGeiUfEZ6IysRmt816nnX7w5Ls13xaqomBpnJeAu5HB6D0aE/syrAy85FlcRPod0yvbMSBgUvjCpSjrtTIjqU1FqsAjotDMxDlb7NgVLrRfkphU0m+w8FGT6VDKNvuI2owJHjq0Fb1mxqxPnJIvJ58cbwCL/fR9imIaaW/IQoFD8+BwsMuaBlUq1nFxJ6lVBXr9Wgm1t4g8Gyp2Ev/Sk5f6d+1loanj2O9g6+rAoBlYbHttJI02GPLAfUAJDvRz9upMflad0PmEI191x+M7Y7Q2NzIGHJqcUt4O0lmt3qOwgeKCi+y3qXX9H3NVPhXIJVJrPzPlu1pqjfiB2DQOG2jz+aCy0/BhTsobOyM=
Content-ID: <7F4E9F77F385CF47BE8D769A11A9B993@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e573c03-a6d1-4240-2b5a-08d68b52bc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 10:14:37.1656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_021445_102474_201350C6 
X-CRM114-Status: GOOD (  10.08  )
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
Cc: "open list : OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Varun Sethi <V.Sethi@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

FPGA on LX2160AQDS/LX2160ARDB connected on I2C bus, so add qixis driver which is basically an i2c client driver to control FPGA.

Also added platform driver for MMIO based FPGA, like the one available on LS2088ARDB/LS2088AQDS.

This driver is essential to control MDIO mux multiplexing.

This driver is dependent on below patches:
https://www.mail-archive.com/netdev@vger.kernel.org/msg281274.html

Cc: Varun Sethi <V.Sethi@nxp.com>

---
Notes:
	V3:
	- https://patchwork.kernel.org/cover/10795195/
	V2:
	- https://patchwork.kernel.org/cover/10788341/
	V1:
	- https://patchwork.kernel.org/cover/10627297/

Pankaj Bansal (2):
  dt-bindings: soc: fsl: Document Qixis FPGA usage
  drivers: soc: fsl: add qixis driver

 .../bindings/soc/fsl/qixis_ctrl.txt           |  53 +++++
 drivers/soc/fsl/Kconfig                       |  11 +
 drivers/soc/fsl/Makefile                      |   1 +
 drivers/soc/fsl/qixis_ctrl.c                  | 222 ++++++++++++++++++
 4 files changed, 287 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
 create mode 100644 drivers/soc/fsl/qixis_ctrl.c

-- 
2.17.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
