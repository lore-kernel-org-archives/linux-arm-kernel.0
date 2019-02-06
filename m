Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9A1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:15:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D0C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i964jt7y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KcCpK+PH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="tWGDaTPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D0C20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Th//Gop2oWj43IFxqgNrShyd9/kytqO+mO2NRosc00=; b=i964jt7ykOmETw
	ZB2S4J+knBm4mW1PvBa+jzdZ4/rgCHJjNuzNeprsNoNequcQwBzh1xLzOIAG8taqizLBQWmjfA23V
	nk51aPXAnh+JU9vkLOba8X+qZAQaKvqwmkYFPebMvsn7u37pKXCJzSA9n71lWZjwAemure74/ZQuR
	7JjjHmpcZ3x8tJAN3348X5PrULv1OvJPyNPuG5lKyjPAgh42+bMhBSXZas4WO45gNuRTl/eWPnD4l
	DNeD04fuPKuwollY2PxAHNGenlDkl3htSGfXuUFkZ3A9ZsHbYqX55wqgmnMCuJY+jopGMogm8bPTi
	4Ka0FPIYWFSJ/iJVGh9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKF5-0001dD-R4; Wed, 06 Feb 2019 10:15:43 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKDU-0007F1-5N
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:14:09 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16AAHKq019413; Wed, 6 Feb 2019 02:13:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=lQHzIhOtOTzf4ATNxmUuUFKuTu61+ra8LZuUsaY+jDs=;
 b=KcCpK+PHx4cmYUBNxYM68PWAWl7v/EDieH8JATUCvOa6LUcLfS7E6mamOlhYlLbLXJoA
 GV/SMUevwrHJ0mCs0ytXPmleOYdQyz7Cxgj4box8pvWJt2ktbNkRsHolHFFnfBIXlSmv
 Fw5YFtX5OGxmgIpG+bSpv6mI0rRPupmjxr/ZSTxHrW5tH0wP1dwePS59r7l2RAeh2lut
 Xdr/raEk8nu6trYH9Ca/jVg8xkZt/1EMBi5ZeNdukEfw7bA8ol4NGvIYsoXH7EcxpdU8
 EoIgLxpkOH2P9xejvGtOYBGvi1vlXFnGthwDAPPgy9iayRrD2nwueyiHBlV/IwdOY8e6 rg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 2qfc17k9k4-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 06 Feb 2019 02:13:59 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:13:58 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:13:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQHzIhOtOTzf4ATNxmUuUFKuTu61+ra8LZuUsaY+jDs=;
 b=tWGDaTPtNknoebSpI2HG8zX74N4RYS93p5gueYbU3I1eh5P5rqfPapQO2Q1JHHvOD825Az7RYbBXuGuRRObfA9e2jlaHcPek9pRckejiiefg+zgItD1r46LFl4HekdgFqExU3Sx0tSC44OB6tG4xOhDh36lD1Nl8mqNk3P9hKNk=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:13:56 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:13:56 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "rric@kernel.org"
 <rric@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] net: thunderx: make CFG_DONE message to run through
 generic send-ack sequence
Thread-Topic: [PATCH 3/8] net: thunderx: make CFG_DONE message to run through
 generic send-ack sequence
Thread-Index: AQHUvgSqM1V8xsK6TEiqR1ob1UmYjw==
Date: Wed, 6 Feb 2019 10:13:55 +0000
Message-ID: <20190206101351.16744-4-vlomovtsev@marvell.com>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1238;
 20:kAghwz0n03USdmdhlejjbXbYnpBw6X3Kjvd0sg2gv568LnfjL4XA6nhpFDjaM6BchtCWz0QY+eEkZe2RiUuKuqvDXY0nwguzjDIjQuLFWeu3T50ZcAlsDC5rLGxmRXKkqX7uRPanBpdfxE5pGQS5R6hXN4b7mnm7GNs/Vo4/9Fk=
x-ms-office365-filtering-correlation-id: 2ba50d09-dd08-4676-1c28-08d68c1bcdf2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1238; 
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB1238F1B8C91AD51F76DF1B98CD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(11346002)(107886003)(54906003)(110136005)(76176011)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(15650500001)(6486002)(2906002)(476003)(25786009)(2616005)(446003)(53936002)(3846002)(6116002)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1238;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0A1FOqDXdMT41JB0uSKAXczsIZ/r1sTxT2FgZD8DAmqeceMusDbnHFMfpWkZ9nnJmXHB1600PIAyjd2JgOxVttMR9tfFkfRopty3DhDXQew0HnPe84itM5lU5AJlm7aCgO6MI5eR5/mFw6t4zAIbbnynoBp7E6LTjt7Lj5StnLw6+Qqs0gXprqPlgr9cBQm+qHBfLUAeeLlHdhjJKmaWwSQrGnNBGNy/2zUZVjHCFuA/GCwIZAlorlq8Q9Tc24eZg+ta0uOtsXIDswMTr2DhRetNju+XxdiqjL8QyaO4dTeifa+viRTxCQxD9+iJeRCItVEwkWLRa3a5UyXJ6KtEfMDlztsvTrRyhxrVPkWrYZVX76MeG9u4LchoZz9niBHgA1ZtUN6zmVW3tJEm11jAvQBjnU46CdnkMHPL7g5JxCA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba50d09-dd08-4676-1c28-08d68c1bcdf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:55.4525 (UTC)
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
 mlxlogscore=834 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_021404_557739_3E8B5893 
X-CRM114-Status: GOOD (  15.29  )
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

At the end of NIC VF initialization it send CFG_DONE message to PF without
using nicvf_msg_send_to_pf routine. This potentially could re-write data in
mailbox. This commit is to implement common way of sending CFG_DONE message
by the same way with other configuration messages by using
nicvf_send_msg_to_pf() routine.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c |  2 +-
 .../net/ethernet/cavium/thunder/nicvf_main.c   | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 6c8dcb65ff03..90497a27df18 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -1039,7 +1039,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 	case NIC_MBOX_MSG_CFG_DONE:
 		/* Last message of VF config msg sequence */
 		nic_enable_vf(nic, vf, true);
-		goto unlock;
+		break;
 	case NIC_MBOX_MSG_SHUTDOWN:
 		/* First msg in VF teardown sequence */
 		if (vf >= nic->num_vf_en)
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index abf24e7dff2d..b0e8a04e0f1e 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -169,6 +169,20 @@ static int nicvf_check_pf_ready(struct nicvf *nic)
 	return 1;
 }
 
+static int nicvf_send_cfg_done(struct nicvf *nic)
+{
+	union nic_mbx mbx = {};
+
+	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
+	if (nicvf_send_msg_to_pf(nic, &mbx)) {
+		netdev_err(nic->netdev,
+			   "PF didn't respond to CFG DONE msg\n");
+		return 0;
+	}
+
+	return 1;
+}
+
 static void nicvf_read_bgx_stats(struct nicvf *nic, struct bgx_stats_msg *bgx)
 {
 	if (bgx->rx)
@@ -1416,7 +1430,6 @@ int nicvf_open(struct net_device *netdev)
 	struct nicvf *nic = netdev_priv(netdev);
 	struct queue_set *qs = nic->qs;
 	struct nicvf_cq_poll *cq_poll = NULL;
-	union nic_mbx mbx = {};
 
 	/* wait till all queued set_rx_mode tasks completes if any */
 	drain_workqueue(nic->nicvf_rx_mode_wq);
@@ -1515,8 +1528,7 @@ int nicvf_open(struct net_device *netdev)
 		nicvf_enable_intr(nic, NICVF_INTR_RBDR, qidx);
 
 	/* Send VF config done msg to PF */
-	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
-	nicvf_write_to_mbx(nic, &mbx);
+	nicvf_send_cfg_done(nic);
 
 	return 0;
 cleanup:
-- 
2.17.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
