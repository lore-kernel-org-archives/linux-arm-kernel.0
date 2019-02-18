Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF266C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC09217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ny/+5L+E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="pfxVzIVr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="k69YK/we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC09217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=08xC2JP+shS5O+3h0T2/Yt5NWKyUXRQuw4vHbsLZFeA=; b=ny/+5L+EUEp5fE
	MVBl4GoGqIrYVZSpio2zcVeoLIyVyIAmU39jjp2JrH/ACPEejPUERmXtBDJBscIhFgEA1EUi921gp
	Sp2G8RMLHtOZGVyYUeu+6V+Axc4lP7aZP7gCfKH6rssLo/4gChuDuIhi8OCAcgUpUS29J8k/A3kbQ
	6ywEZmGxxlsy3HkcBsxP10zeLAVwuTa+4i53ycjQlRMlGrMKHdW7OGEzbme6TU4QVRdZvasiZtW+s
	WLygj3vqFknuSzCVDb+q3WIsCBwt3m1oJN4qdy2ST1n2ME/bYzlD0YNWDSr1WzTiE0JYRl0+Im30Z
	AR1Ds9sf8A4DWVVUw8wA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfcH-0003RJ-Ge; Mon, 18 Feb 2019 09:53:37 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfbB-00028I-9x
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:52:32 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1I9qEYJ025113; Mon, 18 Feb 2019 01:52:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=EASPNoBKi6Ks4AV8MelgOXLZSCDsc3PeCFHJjtcArk4=;
 b=pfxVzIVr2AfssBvxgU8L1R/Be1l9Mo64MqQ3Wk9LXAhlLSad3I/Q3rAnwupdVo5T5BIj
 2arOYYj+Rg+XxkfkuAou3+NB8CzMsyaHnH/pAhBitubO80gYifxBh+RpWeylYrvG7E8S
 Tr1j6kGtU02UMEE85ilCIiZXdl3mCiXetqFf332sHssp/7nJ3DFoNBPMePOl045UAFzO
 R+okSkF38XBxnK49VLXH7n3dU4eqaGwNHVVPqjiLm0vQsyXut1lWN0RdKYEvkHioo1rY
 v6Iwak6sZwmU90h2hU6viaNVLH/kZpPAdNMxTn4XbnrAq4gif8Z3aEwTq6y8l4OBSAvq HA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 2qpjwpw13t-12
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 18 Feb 2019 01:52:26 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Feb
 2019 01:52:16 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Feb 2019 01:52:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EASPNoBKi6Ks4AV8MelgOXLZSCDsc3PeCFHJjtcArk4=;
 b=k69YK/wen6YmMmc/V0cfza+z1xVwrdMBO0ubVstXX/tWDFn14Z0kDqx+oYToogn2CpTvZ7xKF8W7hzZk3Z4QAnGZ5BJD4Y3haeAnerLJb8ISpULSEUIcLlwtdv7B5C5+GCqTvcEFoXf1I5sNuGK55I/8zPeZTkujfh7JHWF6Q6A=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB0968.namprd18.prod.outlook.com (10.173.182.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Mon, 18 Feb 2019 09:52:15 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 09:52:15 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "rric@kernel.org"
 <rric@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/8] net: thunderx: correct typo in macro name
Thread-Topic: [PATCH v2 1/8] net: thunderx: correct typo in macro name
Thread-Index: AQHUx2+gpcA4cC/cZESWBcKxy3GxWw==
Date: Mon, 18 Feb 2019 09:52:14 +0000
Message-ID: <20190218095159.3847-2-vlomovtsev@marvell.com>
References: <20190218095159.3847-1-vlomovtsev@marvell.com>
In-Reply-To: <20190218095159.3847-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8744a2c0-a27c-40a5-7e15-08d69586c31c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB0968; 
x-ms-traffictypediagnostic: CY4PR18MB0968:
x-microsoft-exchange-diagnostics: 1; CY4PR18MB0968;
 20:fjd/weMKp3UJAGi2iT60TY41UlRzTWgdXlMsScS7p/SqXLJ+vvq9ZUfdWx826/6pSFWTzKJhYaPgeuzyx9Oe9ezPdjsEfMMyhnu+KqRh2fIAFWZ3Dkhhc/Y9IXEJrPnP4WdoRgXLOii5EU7N5ttQrtL2EJ25adUtxCcUvRADoMk=
x-microsoft-antispam-prvs: <CY4PR18MB09685F07EEFDFF78740FC850CD630@CY4PR18MB0968.namprd18.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39850400004)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(486006)(7736002)(305945005)(316002)(4326008)(110136005)(54906003)(25786009)(99286004)(8936002)(476003)(5660300002)(186003)(2616005)(76176011)(81166006)(81156014)(6436002)(446003)(11346002)(14454004)(2906002)(8676002)(71190400001)(71200400001)(6506007)(256004)(68736007)(1076003)(2501003)(2201001)(36756003)(6486002)(53936002)(86362001)(106356001)(102836004)(26005)(97736004)(3846002)(105586002)(66066001)(6116002)(478600001)(6512007)(107886003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB0968;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aX5RMRXF0zTdxeYNupeLaBVQKDWeiPzF36cJhIzALcT6peSJHPh8RXzqZKwxEV85OiN0XitwyvWJWmc4jIe7LpbhuWKU56a9HMBGXNNpdlxn0+nIOhr78Ino5MFTs0yRL6chG4aOZkWmh58ircE2SyXEFRzE1+TyTvctudBDGVytIiYFoxKbqEH/3JdZnzCyUasW1x1GvH+N7DGPXnkWTz1QgPSTfu7AoPn3Uo9EPD8xZTAqqXfWodtJCesgLQxeeHQZBfqooLk83CF1QmdrtQDOZIkwWhjlvIKLRbBYfri4L5uiXFlmwxON3eZo6zJ5T4aS6laztgjOtQyU8GmdOQJ/Apo0aXksSyzswqWl5nN3ROsRCYOFowRMx4u0+kl6blPDmpoaDuXRbMj4tYchqLpB5ut3oKcAhmkqIN7bO1o=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8744a2c0-a27c-40a5-7e15-08d69586c31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 09:52:14.3448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB0968
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-18_07:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=762 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_015229_468637_845F2DAF 
X-CRM114-Status: GOOD (  13.23  )
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
