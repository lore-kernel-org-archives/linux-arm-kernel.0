Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC65C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:51:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D80220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M5W36Ck1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FYS4BgjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D80220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lWDBmU1mgg/qfP3nX8i9s+6k4xOrqCgiSHjiXXTFWIg=; b=M5W36Ck1oUMFRh
	BqQ0okqghGN2Z2F1qNGZ5UTd7YZfMZUl5QQ+ic0Cf/DSQLr3ib028FKoHRKCHiUcIHwGgg7Qp+IQ7
	qNJxwhpSp0CeGQ6gHx6fDsQZkjFKehg3dcx5AD8IHnXEenwnBvqNzJjt1ltOh+h6Ciaso4FYgcxxY
	OmkVZSX6iU2Zdu9hC4HVzSLUfYHyEDcN6UIXfasrXwHK3WJF2Ap79jmH+iUje65H8DIsu2K4LZpYR
	2rTbw6H+fxs465+M3Tk4nQWS3ETiHCLL8VQE/CiGZj6La/bzuggWuOFyUrPTrgE1LN01g4XARQQQ9
	EfurYxy+cub8EhAsyMVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOmJ-0002EA-FR; Mon, 10 Dec 2018 16:51:31 +0000
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOlQ-0001DI-9R
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uazf8naZk5aPwtlvmSe5ucZ8KOiXXDPWqm2M/iSonck=;
 b=FYS4BgjSEJgrxAwZfVAaB2tl5y8iXsAio/Huc5w/fWSDhXbgsonuGlyu8WvX0Bu/ApDZhKh+HxaPPY1aknM7ZaqKKU1DMvyIJmxJzeEfeGlIjWu7VeQT268MUloASAN/C1F6mwf2RZTenpe47wrd+0kA6FSwNLLdumg43P/1Qfs=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2750.eurprd04.prod.outlook.com (10.175.22.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 16:50:18 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%11]) with mapi id 15.20.1404.026; Mon, 10 Dec
 2018 16:50:18 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: [PATCH 2/5] soc: fsl: dpio: keep a per dpio device MC portal
Thread-Topic: [PATCH 2/5] soc: fsl: dpio: keep a per dpio device MC portal
Thread-Index: AQHUkKhuMhaQRRe3ZUGzxuFMu3rz6g==
Date: Mon, 10 Dec 2018 16:50:17 +0000
Message-ID: <1544460591-14888-3-git-send-email-ioana.ciornei@nxp.com>
References: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0145.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::23) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB2750;
 6:lgmrMLo2/fj4pnEwyE+EV2/oo5L6Lp/60xPpud2kFXlABuGoIXnHPvcu7Ulg2IY6onq2dO+9idFoq0vGUnvxzcohfy4huZru7gv33m6v0PtVrdB5LqV1YYzk+16XrwDP9O65PjnN7wxzT2PZIVQdo40IGAlDHtmcSFhif2Lzyt2ia2SFhmck4S4ycALoKFb3mIhARurVnxKjZpFOAGoJn6P9BkexGNrq5wsvre1V57oHIayoe+hiEwjz1q/JA90rH+u4XpxUyp49m5XzbOd+3qo1+1iN4IaZju9mFi8Um0vqPollo4ByHKouJsHWib6YvmAPC5QVVQYVpjq8/QpRPaPR0vpi3YzKNP5QLqEN7B4ha/3pepJAJmfJTbeR4+z2D8ReAF6nVNW4EfUOZ9gd67+BEYn85WEeMPb5a+z5rQuUwCluJB0xnaZMxroDQLmd/gtdGjsbiCLqGMmGUsYyJg==;
 5:sveKB59Vo9q0lagXDJedocv8TCaV/pBNiqmH79TiLvzPfRlT4ZmRwKDVhnDLkS3L4x5PIkHxFVatrdl6Tr56P9D1IgYG+JLeRxPyRYE2f/kDSV8Qr5xhSXDWWtQlzQY31CeKPrJJFnx2Pd/Wjc4ZbvuLnVOJ+L+n3abBlgWuMnM=;
 7:bRxOWLp2b6sktUr+32/fUhvY80fdRNuErn7ManTFfZDQvge6W/nH8PHibZNGulkeF28pDPyk5wxNQC0e6lcY6PS4gsxdD6xa0ZStXV/nzCxKFOSLAcfyPXibAmaXoVnbLFuPfWV82OdK5VItr8YYcg==
x-ms-office365-filtering-correlation-id: 9208904b-6254-4d63-cccc-08d65ebf909a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2750; 
x-ms-traffictypediagnostic: VI1PR0402MB2750:
x-microsoft-antispam-prvs: <VI1PR0402MB2750FAEBD40F9DE87E723622E0A50@VI1PR0402MB2750.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB2750; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB2750; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(186003)(2501003)(11346002)(44832011)(53936002)(2616005)(71190400001)(476003)(2201001)(3846002)(6116002)(71200400001)(66066001)(486006)(305945005)(7736002)(86362001)(68736007)(36756003)(6436002)(81156014)(14444005)(316002)(110136005)(8936002)(14454004)(81166006)(478600001)(446003)(256004)(54906003)(25786009)(8676002)(6486002)(99286004)(76176011)(102836004)(106356001)(26005)(105586002)(386003)(2906002)(97736004)(5660300001)(6506007)(52116002)(6512007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2750;
 H:VI1PR0402MB2800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DFfIfij0DMBdQFJSFIRKAW90F0wWM7KUelLGoNLVqO52OdcZtTR45NL9j/NM6T8kOYWiHD5cJdxQCCR2K/+mYPq9fVMRLAs1zYf0dQyzNq2aFQqPB55Zx5fjHccFBQ/SkxbF1Hw0THAhCtHlp52PG5BFcaQO4//mfvk0NbLr2N1alBWftIjnvyUeEnOZsfa5TTPTQ1HU+bnO3rhaWRFBggXIRTF4Y18Aq6lzpRwvK+oyCdrSVtVTzhmVdIcVj9Uaa6FZ/N/gRZyP/CfE/sZ5iubyeRLroX3WWcv7i1Y8w6NWNsSMTRzPssBZjXnl62q0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9208904b-6254-4d63-cccc-08d65ebf909a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:50:18.0014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2750
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_085036_754549_D9124452 
X-CRM114-Status: GOOD (  14.98  )
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
Cc: Roy Pledge <roy.pledge@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Horia Geanta <horia.geanta@nxp.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

At the moment, the dpio-driver allocates an MC portal at probe time and
frees it right after usage. The same thing happens on the remove path.
This behavior could lead to scenarios where an MC portal is available
for use at probing but not longer free on the remove path which could
lead to unproper unbind of resources.

Change the driver's behavior in such a way that an MC portal is
allocated at probe and kept until the DPIO device is removed. This will
ensure that at any time after a DPIO device was successfully probed, all
its dependencies will be met.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 38ee9db..5286723 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -187,7 +187,6 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	dev_dbg(dev, "   receives_notifications = %d\n",
 		desc.receives_notifications);
 	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-	fsl_mc_portal_free(dpio_dev->mc_io);
 
 	return 0;
 
@@ -229,12 +228,6 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 	cpu = dpaa2_io_get_cpu(priv->io);
 	cpumask_set_cpu(cpu, cpus_unused_mask);
 
-	err = fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
-	if (err) {
-		dev_err(dev, "MC portal allocation failed\n");
-		goto err_mcportal;
-	}
-
 	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
 			&dpio_dev->mc_handle);
 	if (err) {
@@ -252,7 +245,7 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 
 err_open:
 	fsl_mc_portal_free(dpio_dev->mc_io);
-err_mcportal:
+
 	return err;
 }
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
