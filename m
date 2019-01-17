Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D942C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:10:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475B420855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ula8UruB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="abakgnfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475B420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=R+PBepp7yykM1MV19C31BC0c2PSD6N4nMCKuSA4EVUg=; b=ula8UruBFQ6pGb
	0HGL5qHU980vbTy0j0M1M+3lyAr4NieRhXw8Yi1hA5dUGwH4MmCNyM/KsoexCYhNm8mZExxwMlSaI
	ZZbWPqsFh9gqfP1kvPPuiioNgOOgzYeoUL92J+0hcYqGKk+v0N4D+OUf/CcTEqudr17weZpnwI50e
	EeSBYDZua2GA2yMRrhjP/si9ryOOnxRXDn5sF7F1ZBPw06xKlzz6fyIYSRz4LmW6NqsruanRB8m6z
	9Vlp3tkFlERbvy6L9GzYPCHctpFmfFKoYZ42cphCuVQGt+py+unrQeKbUSEg9a2m6SlJjo3KkP91B
	EULejVyc19SX/wqATowA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAFl-0003cd-Jq; Thu, 17 Jan 2019 16:10:49 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAFh-0003bb-0q
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:10:47 +0000
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; d="scan'208";a="26552031"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 17 Jan 2019 09:10:40 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 17 Jan 2019 09:10:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRQZUldwB/Q7JCOJuJ27Pe4Cmf4TlogfOL04TJC5pp8=;
 b=abakgnfHtO11oanMoadiMD5eEYE8rftRE3J3Kg4qhMo076yMrbeUU4+vslrWWvpGcSTpbMrMBNuyZvtfHSB1lOz17SSTcRHkLwR9G1cOKBirCTAe08NGRaOO5DPziSDC3KfMguGyI56Ogfm5n5Qt5QFxWSOtGKzA0QSnBi6gBa8=
Received: from SN6PR11MB3165.namprd11.prod.outlook.com (52.135.109.80) by
 SN6PR11MB3344.namprd11.prod.outlook.com (52.135.112.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Thu, 17 Jan 2019 16:10:38 +0000
Received: from SN6PR11MB3165.namprd11.prod.outlook.com
 ([fe80::409c:4f1:2e79:ceb2]) by SN6PR11MB3165.namprd11.prod.outlook.com
 ([fe80::409c:4f1:2e79:ceb2%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 16:10:38 +0000
From: <Codrin.Ciubotariu@microchip.com>
To: <Ludovic.Desroches@microchip.com>, <vkoul@kernel.org>
Subject: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel as in
 use
Thread-Topic: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Thread-Index: AQHUrn8vO/Ym+tRt40+WbUu3tf2aBQ==
Date: Thu, 17 Jan 2019 16:10:38 +0000
Message-ID: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0287.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::35) To SN6PR11MB3165.namprd11.prod.outlook.com
 (2603:10b6:805:c5::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN6PR11MB3344;
 6:8N29inMSCPnPlxkqvLO8WMVFuhzVoYEyesfZUsqsrZUgKoyMaJWoUOQ7yrs46Z4fvNTyQ8qHNgSB8hz+ZfTpjI5xXqK/TwBGSnZxhGfg+SZy0LfxSVXHfHgJHRabvUjj65fXZQOsbQCVTd2hNfL6O2n/5mIEP90C0jEaqSyT1qOq7M04/qUz0k90ufn3eN4GVg8zcIXPQYaNGRSkj6q/d45ffDD5pPT/LECZys4sl4McX2WpAmN5c7ZYEl7JadVvDaV2t4julhG/qXpB2QySeN1AK+oXn+oZZ1rd84yPki5NUIc2P1QSw3qmo/KH7/ucCxwyO4H0Bq8FEvIbGmfxzKkOLF6vAJFUhNdyZTRKkFiBUqfPCfPzVQgf8+lkZCjoz/ozuIFRWbZN2Rp2QDuSYt6BjDqgQagIok4R4XSzj7/4va8GIn4rD+tRhXEbXv3XY5yvM495g8mSbjz+byw4cg==;
 5:FBntyP9bZdr7+m7VVtT16ixWwpxNE8v2CghpIWJtlee//IClZliYUBAqsCPzBBESfHWBRdEgW8MZEyDG2oMHi+y+vuB8KHMBWRK7Pz/+zrxErrmRJxpTEBEmjaf7mojeno/emQQKNnEJXPyGHXrvrdUA3JhGZxI91uouIlv6vK06ugW9f3OTOSzKNPcD/AntF0/RcQvw/1Nj9ofx7Y8DBQ==;
 7:sAknE+xgejbOinoh9HMrflZjUEW778d70hvJv+45SpZpiZUVcxrpiVgJTXspiaY1dxJcNBzEW6NW1yypfJ7LcI1AhQhp4EFBIsDtDz5ZE/eNgo5vFux2vp9SinEtN642frd4srTNVNt+OSgLs5XCHA==
x-ms-office365-filtering-correlation-id: 8f9b8703-dd3d-4581-797e-08d67c9651a9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:SN6PR11MB3344; 
x-ms-traffictypediagnostic: SN6PR11MB3344:
x-microsoft-antispam-prvs: <SN6PR11MB3344DD9E987DEC2643775CD6E7830@SN6PR11MB3344.namprd11.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(102836004)(1076003)(478600001)(71200400001)(68736007)(6506007)(5660300001)(26005)(6486002)(3846002)(6116002)(2906002)(106356001)(52116002)(8676002)(186003)(386003)(4326008)(81166006)(476003)(2616005)(105586002)(81156014)(486006)(86362001)(7736002)(107886003)(97736004)(53936002)(14454004)(6512007)(14444005)(256004)(305945005)(99286004)(36756003)(110136005)(71190400001)(50226002)(54906003)(72206003)(316002)(6436002)(25786009)(8936002)(2501003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR11MB3344;
 H:SN6PR11MB3165.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1c5CdSyUEuXSKU9uXgX+Vr/9dbn2vXZI+wyR/vm9FtrWYMFCv6D7fXgFlDRYbDsp7d1lc9j/LMi2beKEgAhNM5JAi4Y46PobmBNDKs8pyPlCNEc9cPZn4XoKQs9D5UJPGiGdrRqllcPK+QgEdvz/2soyfTt5X84UbEtxAr7i6o/p0GDQVHuQMMMjjZd5RqhzylqqXPhZ9Ir9owdruQFjA5br8Tco8zGzSwOUM6bs1mchQ8uLr46nrtWATaePQr7Ecux2ZXba6zvEi3pOAOjHX3Gvgr6TXoh0lqojqfOdQPcIVja4gVdWkpSKxJ5smOd2y9tolcuOFFUnYxBQqFvPoyfeD7/pHeXVEVc10boHrSZHYZfd4qHAMTWIPRzeAzI5u3nOEL1jH6fAR+BfInFlyyXNIhIursNIwDl32YV6FBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9b8703-dd3d-4581-797e-08d67c9651a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 16:10:36.4444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3344
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_081045_239723_941124CD 
X-CRM114-Status: GOOD (  12.46  )
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
Cc: dmaengine@vger.kernel.org, Codrin.Ciubotariu@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

atchan->status is used for two things:
 - pass channel interrupts status from interrupt handler to tasklet;
 - channel information like whether it is cyclic or paused;

Since these operations have nothing in common, this patch adds a
different struct member to keep the interrupts status.

Fixes a bug in which a channel is wrongfully reported as in use when
trying to obtain a new descriptior for a previously used cyclic channel.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 drivers/dma/at_xdmac.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 4e557684f792..fe69dccfa0c0 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -203,6 +203,7 @@ struct at_xdmac_chan {
 	u32				save_cim;
 	u32				save_cnda;
 	u32				save_cndc;
+	u32				irq_status;
 	unsigned long			status;
 	struct tasklet_struct		tasklet;
 	struct dma_slave_config		sconfig;
@@ -1580,8 +1581,8 @@ static void at_xdmac_tasklet(unsigned long data)
 	struct at_xdmac_desc	*desc;
 	u32			error_mask;
 
-	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08lx\n",
-		 __func__, atchan->status);
+	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
+		__func__, atchan->irq_status);
 
 	error_mask = AT_XDMAC_CIS_RBEIS
 		     | AT_XDMAC_CIS_WBEIS
@@ -1589,15 +1590,15 @@ static void at_xdmac_tasklet(unsigned long data)
 
 	if (at_xdmac_chan_is_cyclic(atchan)) {
 		at_xdmac_handle_cyclic(atchan);
-	} else if ((atchan->status & AT_XDMAC_CIS_LIS)
-		   || (atchan->status & error_mask)) {
+	} else if ((atchan->irq_status & AT_XDMAC_CIS_LIS)
+		   || (atchan->irq_status & error_mask)) {
 		struct dma_async_tx_descriptor  *txd;
 
-		if (atchan->status & AT_XDMAC_CIS_RBEIS)
+		if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
 			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
-		if (atchan->status & AT_XDMAC_CIS_WBEIS)
+		if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
 			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
-		if (atchan->status & AT_XDMAC_CIS_ROIS)
+		if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
 			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
 
 		spin_lock(&atchan->lock);
@@ -1652,7 +1653,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
 			atchan = &atxdmac->chan[i];
 			chan_imr = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
 			chan_status = at_xdmac_chan_read(atchan, AT_XDMAC_CIS);
-			atchan->status = chan_status & chan_imr;
+			atchan->irq_status = chan_status & chan_imr;
 			dev_vdbg(atxdmac->dma.dev,
 				 "%s: chan%d: imr=0x%x, status=0x%x\n",
 				 __func__, i, chan_imr, chan_status);
@@ -1666,7 +1667,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
 				 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
 				 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
 
-			if (atchan->status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
+			if (atchan->irq_status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
 				at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
 
 			tasklet_schedule(&atchan->tasklet);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
