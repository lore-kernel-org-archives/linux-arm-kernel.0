Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2486AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50D020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A7tNhGsK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xOG4rOJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50D020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d5up6CW8nDvO11GA0hUJ2aGmX/Q2PB9Jyjlv0inqcLQ=; b=A7tNhGsKlkes7E
	jA/gC1Hs63ZE7OMQsb4jAiX35lBohrGYFWd5T8WJOtyOzhr5BkK/LK3HjdUumTCVP8q04Nw3l+cC3
	G2NFW7XdySlGOgqAsjNLVvrRTAFdDwa3nNDAoxNu1M8+ABHWa1s0TEJJIGI1Qk9KobWasxLXBkxXp
	GzZQcTVDm/XUKxUmfEfvB9mlDnbRvz5rHcYK8us8tu4kmVIME9e1khY5KYi/zKPEN2/h32SsGldVU
	ZPjngW94TIrAZMv9tBKWwZjVm77+85bLydNtBzNHWzZp1stI9klsubBY32UrQw6Q4ufSgi0tuzh29
	qmgqb2UynZDDExTNjYnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8kz-00020h-Mv; Tue, 04 Dec 2018 11:20:49 +0000
Received: from mail-eopbgr130042.outbound.protection.outlook.com
 ([40.107.13.42] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8kp-0001hi-3C
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:20:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C//f1D3o1dL+LfUWYDxHCTE0zlBtF8PdB8CzLA+OZmw=;
 b=xOG4rOJjscLJAuqaxfPMw+c+shcxgIE1T0GDrsl78vIAteCfZRFbp+iZXy7PqGN6T6fBAmViVNjg5oDeg6aC1MFk5sGlvds56D56N5zG/nX1iommy8AOYFOQD6fN8T3tCuoyB7w72RJNCE21n/l79FD+RLOrH/BrLevMvLmFKqc=
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) by
 AM5PR0402MB2721.eurprd04.prod.outlook.com (10.175.40.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 11:20:27 +0000
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa]) by AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa%4]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 11:20:27 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Roy Pledge <roy.pledge@nxp.com>, Youri Querry <youri.querry_1@nxp.com>,
 Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v2 1/2] soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
Thread-Topic: [PATCH v2 1/2] soc: fsl: dpio: cleanup the cpu array on
 dpaa2_io_down
Thread-Index: AQHUi8Nbn0LN8JlywkCvWZZgd9z2gQ==
Date: Tue, 4 Dec 2018 11:20:27 +0000
Message-ID: <1543922408-22950-2-git-send-email-ioana.ciornei@nxp.com>
References: <1543922408-22950-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1543922408-22950-1-git-send-email-ioana.ciornei@nxp.com>
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
 6:gQnFlwlR1ZD5lAxGzS/4GL/aTe+7I/xxrCICCaS006gfE20xwykow8lwJwO0fhCONfvRNnNXPgwFZMw1YfnDbxVyGSmUpsrJzvZQVY0RP8weyBWP55gNjQRXR1Enr2ohbULQFZY3nBTa9LqoKlEiMpio8AekqhcCVSxr0khKIoVyfq+YyMUd7qEsKc+Z2aS2efD0MdJu5u8DVYv2kZ48hWYqEyocZJNgAO118qYI60GNAAS0j+aAT5sKVTlUkxcFtABLoB86oWnOe7quPkIfjKQCvuQy5F4No32KETr6QLFyZFRRkvarsCjiIDgjWt5MkeVoSTmut8PocdaYeLs/CTlsmfYOYp7h08R3LZyXZvQy1A937z0O/05FMjeHpg3elfrYj+j8S1b5TBJqfTs5KmeP8XD5neIGrB8sVUX7lCGTTmBGZimg8fLh1aojS5HDwTGQe2Y4oqBHGn2ll3WxnA==;
 5:TpKAIff/X4idRNKGGhDkYCtTk505FRSRRulA0wT+wUIAySKmD8szaOIatpQ57Mo7QN4HPcn3wLhBF3DxNGLHFszskw3Al4TXBUl35fnOIrOve3UkotZlQc4KHaFhOveRft9P9ncPGzR+TeSruNqVfqoD09vcLCXBMIwm6fdEG5I=;
 7:0nvkvoGiXa8jZh4Oa3o8WuBy3nwNnC2seyLrT/p1OvBelvaA7leakmgkqk46N+ygmS7FaYqxVL4Wp/frgtJeA4d5muXiExnG3qd3PAOB5yTRZXuKm51oI+MSL4tVjLGLazY22yaGWEg7sSO59s8kdQ==
x-ms-office365-filtering-correlation-id: 68e73f5d-6b57-4906-7fc7-08d659da7e3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2721; 
x-ms-traffictypediagnostic: AM5PR0402MB2721:
x-microsoft-antispam-prvs: <AM5PR0402MB27213CC4DF159C6343650783E0AF0@AM5PR0402MB2721.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM5PR0402MB2721; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2721; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(476003)(5660300001)(71190400001)(14444005)(102836004)(25786009)(6436002)(52116002)(71200400001)(66066001)(76176011)(386003)(26005)(7736002)(186003)(68736007)(256004)(6636002)(6486002)(305945005)(99286004)(14454004)(6506007)(110136005)(54906003)(106356001)(105586002)(97736004)(11346002)(486006)(53936002)(478600001)(44832011)(6512007)(6116002)(2616005)(36756003)(4326008)(8676002)(81156014)(3846002)(8936002)(316002)(81166006)(86362001)(446003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2721;
 H:AM5PR0402MB2785.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kXbcibHjLCee59VhUtd6CZPzm82Fn+sDuGti5iAPc3GgXu2KgyhDxvN/XRB5+hjayyqIyhlq1ctK+Aaq+kvnZfgckroNgvk3atqFFci4yfc59X+3ZmzgEVhT9RxY+n47Cj5xddiKQwEwKocigfjZPiW1Z92DZ2wAGX6hOI2eYe9kcYL+Kr5GB8BEUjvC8RHX+j52LDv5Uuf3Kdk+HhRzNxkz8WY9oTd0BnwM5ipKzBdy9pn0HCPo6DaZp3IxyCTxXNo6pSg2nMBPcFxb9b1dSWNIsImb0G5z7i1QLLOjVrZrsPmOxbIPoAJaEnFyxW7Xj03PaAkAh+JTAd4GxUuopC2iGQyE5nn1xHuCRw+Iee8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e73f5d-6b57-4906-7fc7-08d659da7e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 11:20:27.8258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2721
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_032039_131960_BC51438C 
X-CRM114-Status: GOOD (  13.07  )
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

The dpio_by_cpu array should not contain a reference to a freed dpaa2_io
object. This patch adds the necessary cleanup in dpaa2_io_down.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - none

 drivers/soc/fsl/dpio/dpio-service.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 9b17f72..21c3e32 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -160,6 +160,11 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
  */
 void dpaa2_io_down(struct dpaa2_io *d)
 {
+	spin_lock(&dpio_list_lock);
+	dpio_by_cpu[d->dpio_desc.cpu] = NULL;
+	list_del(&d->node);
+	spin_unlock(&dpio_list_lock);
+
 	kfree(d);
 }
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
