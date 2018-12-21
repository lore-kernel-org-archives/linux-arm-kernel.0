Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE333C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:55:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FA421927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JgFzUgNv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="aZoDlWPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FA421927
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l5wfmhXfGTOez/ofI9JyD9FVox6JfilVdDCL75L3uik=; b=JgFzUgNv3o1ZfQ
	vTqjf3C3Z8/fMs6Ta9WDkgBBS/E+kXDnKH9eHCIp0Scw+2PMplaIsEZM96MqDTMa0jFwqGx9vypny
	MzuuvGmFMSly39u8DCZ2pJmAKrrrCaxRLSMGW6GkwXwxhSlbXRQd7NY2U6pcbBAw4q5oV3b0DNkj+
	wbeL9EN6N3XXY1pA1pizcJaasJGNkBwnTjPESLC2hEmc3vk3BH1+ienbzJux7RcJc/7xDUgU8g3Pb
	8it3V4AVHo2EdjiCxKbnyTnaQLH6ziV0PAKGY7cJO6v4wqVb2FmkGfOaCcyCbxMk7t1RteA155Z2U
	ThqSSRPROx6xjMTv4fEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaPxT-0003mK-TX; Fri, 21 Dec 2018 18:55:39 +0000
Received: from mail-eopbgr820107.outbound.protection.outlook.com
 ([40.107.82.107] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaPxR-0002x8-1w
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 18:55:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxBrD12U554td+V8VY5muoceZvmxzGHekiIQXDQ9UW4=;
 b=aZoDlWPNtaYF0CIJUqr7Ys/oA0tszfXquhaxeImCeqqpnvPpfD7JxIeS5UnJ6QHsVqQAOo+8gCGvbjcvbe+js2BaA53fV/7qBPxnpxLYqcSA1pvl6q+fYRAOLl+LEzp9no/4mkeMET1dvEpvWdsjTzb01M5CHnnqK0YjtbvRQCU=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 18:55:21 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd%6]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 18:55:21 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 09/21] PCI: imx6: Drop imx6_pcie_link_up()
Thread-Topic: [PATCH 09/21] PCI: imx6: Drop imx6_pcie_link_up()
Thread-Index: AQHUmP7/jDHJh57tPEeBrh7TyaTulKWJi3IA
Date: Fri, 21 Dec 2018 18:55:21 +0000
Message-ID: <1545418520.22930.82.camel@impinj.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-10-andrew.smirnov@gmail.com>
In-Reply-To: <20181221072716.29017-10-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3708;
 6:n2psTfFqnZw2aBb6nBVCDP7sWyMBoPwGZpctToDqt2FYYJH1zpsdjYGULxvzN1ZoFgQ+uZK+U4WvlOmgzGCAulMuWuPT8J19NiPahqgV0ZMELhPZDL2zS5Ka+31yzIhQgJylZufoBXIPUWpgoKvbLVnedAC0gv/RfExsdSZr9Dr2LIVw/GueVivi0P1kW4vlgO+DmG6yqCKciI5fYpf9tI7Yo3IORtRtCyvBBAU5tKcdLj0meMYsVMbuuYoUuYgylUBRB6oqD+fEad/nhFhJEcJwPTiNyrlz22wS3i47TX0wQp0dN0zH4ZQf1BveKjGupoA2OBm2bReHxcNiskExppQneWJI1SzaBw9s4lsQXZoVm8YyX7e1ETiG/VwzL+ENHrxiAJEG4XVLRnGTEaloDLJxnFstsoeFzC43ZvtZCtz8shKFkGN3LJXCkC8mLT6aqVkTT3fFerGzg9VMcKAnMg==;
 5:J6tB6SEfSCjTc3m/CZaSEfeeHyxepbEERGQSFgXhBAnQYz/FYiLeCUJwq+rJ458wjMDoEMPswWOWjqKveOhyltU/ENb6AssXcm0X7XO2Yrk75Fbnfs7dtMNM2tzDA6bvszAKwHLIl+5l+mzOdQOc5l6L5YTDXRhOuQ90Q+821xw=;
 7:5jPA4GRrWPtLwqQOhErcBN8Fp2RVlAmMIElPUS0kQN8Kh1RwvqmEdZiVH5LMwYDd9y3bFmbSXJ5ACy9G1cV0qNpJl/pPbsb9pCz3MDOUppIo4dfsFUgOfEA0wdI8c07VJWMeUtCBQQiWosb0bK8PmQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 43e915ba-c6e3-4d82-6680-08d66775dbd3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3708; 
x-ms-traffictypediagnostic: MWHPR0601MB3708:
x-microsoft-antispam-prvs: <MWHPR0601MB3708585E480FFC8A7DC5CE0DD3B80@MWHPR0601MB3708.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR0601MB3708; BCL:0; PCL:0; RULEID:; SRVR:MWHPR0601MB3708; 
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(3846002)(476003)(54906003)(110136005)(6116002)(7736002)(229853002)(2616005)(26005)(99286004)(11346002)(446003)(4326008)(256004)(305945005)(6512007)(8936002)(8676002)(76176011)(53936002)(186003)(6506007)(36756003)(5660300001)(81156014)(81166006)(39060400002)(478600001)(2906002)(97736004)(14454004)(7416002)(71190400001)(106356001)(103116003)(86362001)(4001150100001)(25786009)(68736007)(102836004)(2501003)(105586002)(6246003)(66066001)(71200400001)(316002)(6436002)(486006)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3708;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1Q8KNRJTTf3xGb2ul0oBiqpeLwAreMCJqYAPqQhyqYni9kCC/m29w59D7m4kxWJMXmejvlhWfx400EkuUbYs8IAV/pVtEDhMbkpQAQSmDv/CBmCYiFslXd7LCX+AFX9iiskCscgkxcCa2vTCeKVgduwH0/i7iZfjq5SMJiEqbncflp5cGEVPJn68toiECzeKAcpIGJxNX5RKOJ8sFo3nD+Ynq3en6gDnSX34LxyKSSpvX5M0ehR8ljcUuuXY2cSRNF5HarAsua4UFUiixf9kKSD8LaonWNexBaziL+MnFv7hxDvGKSLimNkH8KKg3MtT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <CF6B630FB853014DBFAE6E38AA55AD80@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e915ba-c6e3-4d82-6680-08d66775dbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 18:55:21.4912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3708
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_105537_105646_8F616BCA 
X-CRM114-Status: UNSURE (   9.80  )
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
Cc: "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
 "cphealy@gmail.com" <cphealy@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2018-12-20 at 23:27 -0800, Andrey Smirnov wrote:
> Until commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
> imx6_pcie_wait_for_link()") the driver relied on both LINK_UP and
> LINK_IN_TRAINING to determine if PCIE link was up.

I've already got a patch in that fixed this issue.  Queued for 4.19 and
4.14 stable.

The problem was created by 886bc5ceb5cc in one branch and by
4d107d3b5a68 on another branch, that when merged in 562df5c8521e, the
merge kept some pieces from each commit and dropped other pieces, which
resulted in this check getting dropped.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
