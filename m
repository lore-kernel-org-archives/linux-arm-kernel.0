Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906E7C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614A320685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xl4v4kof";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XpuBepAn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="nqgPTjzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614A320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Io2QeTM29F3E7ufYhBKVNk9Ujdpc2nDhUuDzquXDs8=; b=Xl4v4kofy22+fk
	u8d7rB8rFV6c9yCvRqj2zyUt/J7POvjTwhswV6uBT1j/3SGT4vz0yvoSfMfi+Q7tJOTw3Bua7ArjQ
	My84wFmDtHIidQWqIEjv5H+YreTbc4WHicvQAgfi5Thov2WaFxGmc1Q2905Vl8kepnysqaX5Zj0CD
	YJ4c8I29NnyytjlLiKdiBE+o0WZw+7J++x9oN7NDvK+rniR0bkJUr4mc0IcCz2tVo2JQaWAYMX+Vo
	n5pxUsorXebfiFDBg1AO77iBFoX2hcyK3M6MpIsZhsPMkjc8d+2I3fEoF6HA6Sa8lCCZlhRjiaHl2
	DJeUa7knnR9e6OtPSOSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPeV-0008Qg-DP; Wed, 20 Feb 2019 11:02:59 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPeR-0008OT-0u
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:02:57 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1KB04HT012100; Wed, 20 Feb 2019 03:02:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=mE3l+LVoPLVNTervA4wn26Y5RpOuvSEnq/riY7qK5sw=;
 b=XpuBepAn0f5ZSo3+6yxK71DLjiQL8S2lbPtY+yxPts2bEJZAEsY1UUQ0TiSorjVtEW0i
 a8tvZ1KJPo/6Cx3cc9RYqbiIDQzo4KhteMiYW6X8SV/cR/eiC9XTlTIBJa6vCus42tfl
 VgJdxHHe4kQM3BzYfr8/7N++lyOUvpir/gaBp10L0es9gIPip4dObXo5Lo1PzOC/2wW8
 NxdqNz699MQzB8IvnMzcxnNGKCJ2hNcf/xtJ7O1tJsY3Ci92r7uPWHfLhg94iNInQaNt
 sisWDile9Wc8QlTxvWICHZ956XGCIXHOcvWflceZgcrOpsZn6j7b+R5tQrEUjFwrX4ZK kw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0b-0016f401.pphosted.com with ESMTP id 2qrh8xbr2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 20 Feb 2019 03:02:50 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:02:48 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:02:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE3l+LVoPLVNTervA4wn26Y5RpOuvSEnq/riY7qK5sw=;
 b=nqgPTjzoguSGlQ/4LU+8ukNYTFuW+VhHe8MUNl+3Fpr+f4ChlPaLJmHMoZlRgz+32aVxiK0MituMb6LQ74qjkAXsPQprhc2HsByIo5Hd+AhWg/M33LSzlDRXEyPt0M5c/h+WEwaNsLQB7Vi3V/e7gSClLwoUAC3YB3G88h+7npw=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB1350.namprd18.prod.outlook.com (10.173.247.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:02:44 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 11:02:44 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "sunil.kovvuri@gmail.com"
 <sunil.kovvuri@gmail.com>, "rric@kernel.org" <rric@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: [PATCH v3 3/8] net: thunderx: make CFG_DONE message to run through
 generic send-ack sequence
Thread-Topic: [PATCH v3 3/8] net: thunderx: make CFG_DONE message to run
 through generic send-ack sequence
Thread-Index: AQHUyQvNlb6mQ52TF0mUmIj359Ic1A==
Date: Wed, 20 Feb 2019 11:02:43 +0000
Message-ID: <20190220110225.9497-4-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20190220110225.9497-1-vlomovtsev@marvell.com>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16483b27-7724-4f33-c5aa-08d69722f10f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1350; 
x-ms-traffictypediagnostic: CY4PR18MB1350:
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1350;
 20:Omi+lUTunUZCC07Lxmo/+ehELBYJa5dJ6mnwRg4N/e2Bejxq8D9PlIkZhnhMLYPLe4SC84lDWJFOmjsLEkQWrg+TPL5tygaGhmfmhzl45gNhsyOUhnbEdi9YNCpsu5xd9wtNDvpEqxdMYRNQYmjil4W7OgQI2Zh49VQPqStC1IY=
x-microsoft-antispam-prvs: <CY4PR18MB13501CD4AD5E84F48830AC0CCD7D0@CY4PR18MB1350.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(86362001)(97736004)(478600001)(476003)(11346002)(2616005)(68736007)(446003)(6512007)(5660300002)(256004)(186003)(99286004)(14454004)(76176011)(2906002)(36756003)(6486002)(2201001)(102836004)(6506007)(2501003)(6436002)(26005)(316002)(8936002)(305945005)(15650500001)(7736002)(25786009)(1076003)(53936002)(71200400001)(54906003)(81156014)(4326008)(110136005)(106356001)(107886003)(66066001)(81166006)(6116002)(8676002)(71190400001)(105586002)(3846002)(486006)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1350;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3jnw5grPWzC6u/NAsbasrXnFFNH8YqLZ17QwUEAwtVBIE0Soh2oMXCxW6Bne0v/SLLVzt/Qb6Q+4X7LbwXL9X4MaKSrYj0+J8Fsk8mkJkHiOTS2P5pmNjSfwARsyIMGlAbS6LEur1ULDsSGGaVW/5OHhZpSAC9mepT+AD+tFmrhlJLsLIhwLD2SBiyJ04flVRUqxJTvMKozZAX3yU8ntSgoIs1sru8xzF1q66ObrpFRAxm0l3M/JgnHFdvvBMtciAbn6qnvKMDpyn3fP+oCWgLTZvDJPABIT9twR2ITO8Thb5oBVenkH3jU71YsY1aEHN1/htmTCFiAw31yCOxHPJty/uXsac75VTuFFxuItB8tLKZGM0mZC6GQhJ9IHAuVFVyQ75Jrbz9uf5TPUB+oxMXKxmLnTf7Gj8lxm9K8/uWs=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16483b27-7724-4f33-c5aa-08d69722f10f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:02:43.8590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1350
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_09:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=697 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_030255_229637_193627D6 
X-CRM114-Status: GOOD (  15.75  )
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

At the end of NIC VF initialization VF sends CFG_DONE message to PF without
using nicvf_msg_send_to_pf routine. This potentially could re-write data in
mailbox. This commit is to implement common way of sending CFG_DONE message
by the same way with other configuration messages by using
nicvf_send_msg_to_pf() routine.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c   |  2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

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
index abf24e7dff2d..19b58fc3ca41 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -169,6 +169,17 @@ static int nicvf_check_pf_ready(struct nicvf *nic)
 	return 1;
 }
 
+static void nicvf_send_cfg_done(struct nicvf *nic)
+{
+	union nic_mbx mbx = {};
+
+	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
+	if (nicvf_send_msg_to_pf(nic, &mbx)) {
+		netdev_err(nic->netdev,
+			   "PF didn't respond to CFG DONE msg\n");
+	}
+}
+
 static void nicvf_read_bgx_stats(struct nicvf *nic, struct bgx_stats_msg *bgx)
 {
 	if (bgx->rx)
@@ -1416,7 +1427,6 @@ int nicvf_open(struct net_device *netdev)
 	struct nicvf *nic = netdev_priv(netdev);
 	struct queue_set *qs = nic->qs;
 	struct nicvf_cq_poll *cq_poll = NULL;
-	union nic_mbx mbx = {};
 
 	/* wait till all queued set_rx_mode tasks completes if any */
 	drain_workqueue(nic->nicvf_rx_mode_wq);
@@ -1515,8 +1525,7 @@ int nicvf_open(struct net_device *netdev)
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
