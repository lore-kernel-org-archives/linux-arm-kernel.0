Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92CBC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A9620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QbcA3i18";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="U8CeTGJE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="menORvpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A9620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=08xC2JP+shS5O+3h0T2/Yt5NWKyUXRQuw4vHbsLZFeA=; b=QbcA3i18oL8iVi
	oY6RDTIHvCoIldx4LGqoGb49zt0YF7hslwTn/Npt8oS16UGx9vIGknmT85qwe40j5Qcdm+pGZVd+i
	huyER1L7Pdob2cxOsP+xVAY9627Qvct8rHUX8UMwNz9dPn9atrHMwcMFhbN3YdfLy3NRiKTQXlfS9
	dnx1CRi+L0YcMxCuorg2Uwdf2+NPkiZsXSHrTzTXN3gcuzSNJAaMS5x8W9IMc8C4dneRvvtMkc8lL
	nDyi1CPvN8RjOE8hCTY1MGkLcxymT/xtQvy+98G/ZsqEggVsmN3AXE3cFyicuzBg2fryO6iSRYnfI
	josiSGYye8cFLVHMbp2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKDV-0007Fq-Dw; Wed, 06 Feb 2019 10:14:05 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKDQ-0007Dw-Ub
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:14:02 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16AA3lr016808; Wed, 6 Feb 2019 02:13:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=EASPNoBKi6Ks4AV8MelgOXLZSCDsc3PeCFHJjtcArk4=;
 b=U8CeTGJEa8F75jheb8pwNQf9nQwsTxEuYXbjUPCc1ZxRvqvI82jLu2dx/90m4d8lFl4/
 Oxd90Iu0QiK80HYE3cDs6EEktrbKUExSBOrCO0cIG8hndq1N0Lj4wGCKPCmTNz1a5PL8
 zo443dooPMTFfQ3d8w3G624ai79tcRx4pRXvsFn2y4kWKPMTcha1ZAL/58RQPHXk3J8n
 dH1W/HfQv3DWwrPLrWiqFO+dD+glUvfOScNsD3iTDwWS995mbbhui4Kb6WL6j4kPXMWr
 sxXvxddecXpbibETu9T7m17WTD4myVHw1iAIUd6k7ACqnwf0qZCiwIZ70KtTKQDRuJc2 HQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0a-0016f401.pphosted.com with ESMTP id 2qfc2augup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 06 Feb 2019 02:13:56 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:13:55 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:13:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EASPNoBKi6Ks4AV8MelgOXLZSCDsc3PeCFHJjtcArk4=;
 b=menORvpOgIsBopWvBjTRwdHmZoVwpWPLHCl/enBrgk5AjxeTWdFxJGAFd0chI4IzzBlQ/fhNCQwbcbXDnB+BiPEdaAXdaQzAR4SwYye4a+EqhTmJ4g9Zw2h+6fTLb5xXWJ/l7H5qN88RsJRQkS9lwh0hGgyeJYLAe7tC3+5/J40=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:13:55 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:13:54 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "rric@kernel.org"
 <rric@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] net: thunderx: correct typo in macro name
Thread-Topic: [PATCH 1/8] net: thunderx: correct typo in macro name
Thread-Index: AQHUvgSqiKjPfbT/M0WmGY9yFP8lkQ==
Date: Wed, 6 Feb 2019 10:13:54 +0000
Message-ID: <20190206101351.16744-2-vlomovtsev@marvell.com>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1238;
 20:zv8blagg+9P4z8LcxljxThDa14otrVmx5m4vE57agQloqtIimLeUmNwIk2PmHASxIekuEY3cRV6FuO1DDfLcQJzjTODQYibPCVVo8K/J3ERYukey1w36ZRkQ1Ie8l1MBj3n+o8AX6OQNJJaGCYBqTIngFVtZHDV234cnIwvzsT0=
x-ms-office365-filtering-correlation-id: ef8f4260-1cdf-463f-044a-08d68c1bccf0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1238; 
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB12386941E30C42EFED9731F8CD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(11346002)(107886003)(54906003)(110136005)(76176011)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(6486002)(2906002)(476003)(25786009)(2616005)(446003)(53936002)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1238;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vhc9SPg/tl2N0wK9jYjXVRfIgCoCdWOk0NwMCfUeO/Wb9Qkh8N9gGIg+0Hu7M2EJYqbl914wIoaLgFRdSGhR3PC+ZVgjLjN1UiWVkUkLuNkKxr63Ekzm2Ubi5NGJos6k1uPpO4/WkuHv52haI7WAAcEam0WVg3NfFvuqJj8e1w3PoN7c4RoxxY7lm+xXtBmb1qBxiGkyB3ptbYDPp94p9mZWvrjC0Hz/k7we09xhFhqILeVole1X1wjsdqEA9J2yH6zSI13DHrVZyCDwUsVR2d6QQ7r5N4LAqWlah2j9St/tEu74/rMGuAmKGHtV1BSy7R7Qt+yAUJ8RQ4amfLNIdzWVo4nTIBTD8lPTSq4Zm6vMNKKhXuFjKsdJRJ739CwFY+wOcqIuj9pCKvYC5U0H4r8pnw6wepzD/STj45p7+z8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8f4260-1cdf-463f-044a-08d68c1bccf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:54.7309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1238
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_06:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=768 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_021401_111221_8236A629 
X-CRM114-Status: GOOD (  12.77  )
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
Cc: "dnelson@redhat.com" <dnelson@redhat.com>,
 Vadim Lomovtsev <vlomovtsev@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Correct STREERING to STEERING at macro name for BGX steering register.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index e337da6ba2a4..673c57b8023f 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1217,7 +1217,7 @@ static void bgx_init_hw(struct bgx *bgx)
 
 	/* Disable MAC steering (NCSI traffic) */
 	for (i = 0; i < RX_TRAFFIC_STEER_RULE_COUNT; i++)
-		bgx_reg_write(bgx, 0, BGX_CMR_RX_STREERING + (i * 8), 0x00);
+		bgx_reg_write(bgx, 0, BGX_CMR_RX_STEERING + (i * 8), 0x00);
 }
 
 static u8 bgx_get_lane2sds_cfg(struct bgx *bgx, struct lmac *lmac)
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
index cbdd20b9ee6f..5cbc54e9eb19 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -60,7 +60,7 @@
 #define  RX_DMACX_CAM_EN			BIT_ULL(48)
 #define  RX_DMACX_CAM_LMACID(x)			(((u64)x) << 49)
 #define  RX_DMAC_COUNT				32
-#define BGX_CMR_RX_STREERING		0x300
+#define BGX_CMR_RX_STEERING		0x300
 #define  RX_TRAFFIC_STEER_RULE_COUNT		8
 #define BGX_CMR_CHAN_MSK_AND		0x450
 #define BGX_CMR_BIST_STATUS		0x460
-- 
2.17.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
