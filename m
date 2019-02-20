Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC30C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:05:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B458220685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aRNDfAA6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZThYU8be";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="l69bHBuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B458220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ffcViRPQmj16J6XTErG1k8X8VtEYGhOZvyCr1SiAIig=; b=aRNDfAA6PBDYLj
	LHeGJl4mYwgXApIsu6ERPejyolPdftf7/FtnhvG7xrWriUDk/I4ueHtT9v58RXnfLo4JYl/vMRqj0
	IVjxjPQ2IV37i6ngIg5/E2G7kZUtxJsUVm31yH63bHldp5jcd7hmNwHqMEmenX7d7Y3uY2AmMmpMN
	msGFhf3RgbWqUiUJ4z0gUUixxno9lX3ypx15p1mf3hkTSHQp+CkP4ocpGoyt7fUxN7Y4cgPryISvI
	sNJOs1xfwWjSgm7BcR2S2OM7+u3fCS9ojPBTA+KAe3KPhK4CZ2ASSmafdNzCuNDfQKzIiU0wnOteO
	Dy3Z5NhPBuCNauyknzUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPgK-00026g-9L; Wed, 20 Feb 2019 11:04:52 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPeS-0008Q3-An
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:03:07 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1KB08VD012140; Wed, 20 Feb 2019 03:02:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=5tTNCyXElGO2nWNZhl//GZnpsQICqrJSkoi0YNHBgIA=;
 b=ZThYU8besTJ6VVp8HZBiVUy76P6DdBSxMP5ZvcgQTFjnwdLXi8SbZVqsFzLFunm6YQTI
 SUKI8IKznlYepSP6JpJqebm0gUFtNfXjJd+bsuBOKzqGAnxdaM5KGUx3lCBJ4Xc0Ggnx
 /3hoScxPEwXndU1glFsQjvF0mGD0KbhWOzc3Io/OmdWEe94qlcDgJKYoZROCqdTUmDZ8
 1d1aluXmIY6Vo1Wk83NF/TWDvvXU6hkP/bwgMJRFwInZ0fbMR5cvx5F66i/zZMV3OwMs
 X23VvfPCIFexUGvmqcLdy9TxorUqOTu9lseFSlkWR4wKtV/aCah9k1twANlR7RfFEIMK vw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 2qrh8xbr2r-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 20 Feb 2019 03:02:52 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:02:51 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:02:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tTNCyXElGO2nWNZhl//GZnpsQICqrJSkoi0YNHBgIA=;
 b=l69bHBuU3mbu9Glibo30um39mvY6H/KYjqUOCgv9r4gcc81J5rUJYdZI+wuJRkcVTFycdWc5GGAIlxCaaHhhmEwZYtfwkhLO/iqbqftBXZb6t9GqDbwO4h8zoshcARq1Ss8u4ryUfJGx2l2PzYs0d5GVUt+0m6nT4ZHvANWHHNQ=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB1350.namprd18.prod.outlook.com (10.173.247.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:02:46 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 11:02:46 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "sunil.kovvuri@gmail.com"
 <sunil.kovvuri@gmail.com>, "rric@kernel.org" <rric@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: [PATCH v3 7/8] net: thunderx: move link state polling function to VF
Thread-Topic: [PATCH v3 7/8] net: thunderx: move link state polling function
 to VF
Thread-Index: AQHUyQvOeMTHUI5Z20ii+cNR7DGtew==
Date: Wed, 20 Feb 2019 11:02:45 +0000
Message-ID: <20190220110225.9497-8-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20190220110225.9497-1-vlomovtsev@marvell.com>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4a0a04f-85a4-43b6-a7ce-08d69722f22d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1350; 
x-ms-traffictypediagnostic: CY4PR18MB1350:
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1350;
 20:+1pD+dYdyRM1osTgbY6VYZuc5auR5vDJUEig9IuSn+1bZZ6Eyu7gpOdb5UywzfRYCD8zNMEV5Ze2sYWEeXkCFQrCHb7Ab8xiV7QAlF2hZlORUlvJ1my6Ur6RQEhUHE3k7vs+DJ44UXpvPPNfkJYQJTfYEkpISLksSvE8gs3FlXU=
x-microsoft-antispam-prvs: <CY4PR18MB13506CA55B4F817AF3080AA0CD7D0@CY4PR18MB1350.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(86362001)(97736004)(478600001)(476003)(11346002)(2616005)(14444005)(68736007)(446003)(6512007)(5660300002)(256004)(186003)(99286004)(14454004)(76176011)(2906002)(36756003)(6486002)(2201001)(102836004)(6506007)(2501003)(6436002)(26005)(316002)(8936002)(305945005)(7736002)(25786009)(1076003)(53936002)(71200400001)(54906003)(81156014)(4326008)(110136005)(106356001)(107886003)(66066001)(81166006)(6116002)(8676002)(71190400001)(105586002)(3846002)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1350;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7NYT+5F9cXm2RT2vAmMMPpWwevpfAJh8U+a9eRcfgCP3PgHfTAJrHRRHpl5kCAaDVQJguvf+4+zEGfNXBaxC2TJUrx7PrsN+sM+NT06vFgYuTovJxqnR2RRMwpiwK2qNql+dXQcRf+a/x4+fGkg8Nu3AaZd6gENA6J/QOk7ixU/DXXc0vlRd6zVcRKpkMBoIMaod2Ocz3SXL3JdUxZOAAY1gXepmy9PlL9/aWmefyfy8evKsbFQxrBoMWAQQ5FMg+zpIaPJ7cQyLUHs4A0WlFe11HW0oTttfSC1IWq8CEMgQ07yEO9ru2sytX1xnGli/jMEmN9zpbWqCExGluvL7JmRrPiiQVm5NaEJLr7VuKjqCSrk1nnXYnKl+rdyPRe92BUNS8If9H+ykz4k7tPZ712F0eVa7hMS4G3EYQwxc9tA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a0a04f-85a4-43b6-a7ce-08d69722f22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:02:45.2992 (UTC)
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
 mlxlogscore=984 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_030256_492732_C1DE23A9 
X-CRM114-Status: GOOD (  16.89  )
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

Move the link change polling task to VF side in order to
prevent races between VF and PF while sending link change
message(s). This commit is to implement link change request
to be initiated by VF.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h     |  2 +-
 .../net/ethernet/cavium/thunder/nic_main.c    | 39 ++++++++++++--
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 52 +++++++++++++------
 3 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 86cda3f4b37b..62636c1ed141 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -331,7 +331,7 @@ struct nicvf {
 	struct workqueue_struct *nicvf_rx_mode_wq;
 	/* mutex to protect VF's mailbox contents from concurrent access */
 	struct mutex            rx_mode_mtx;
-
+	struct delayed_work	link_change_work;
 	/* PTP timestamp */
 	struct cavium_ptp	*ptp_clock;
 	/* Inbound timestamping is on */
diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 620dbe082ca0..8ab71dae3988 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -929,6 +929,35 @@ static void nic_config_timestamp(struct nicpf *nic, int vf, struct set_ptp *ptp)
 	nic_reg_write(nic, NIC_PF_PKIND_0_15_CFG | (pkind_idx << 3), pkind_val);
 }
 
+static void nic_link_status_get(struct nicpf *nic, u8 vf)
+{
+	union nic_mbx mbx = {};
+	struct bgx_link_status link;
+	u8 bgx, lmac;
+
+	mbx.link_status.msg = NIC_MBOX_MSG_BGX_LINK_CHANGE;
+
+	/* Get BGX, LMAC indices for the VF */
+	bgx = NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+	lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+
+	/* Get interface link status */
+	bgx_get_lmac_link_state(nic->node, bgx, lmac, &link);
+
+	nic->link[vf] = link.link_up;
+	nic->duplex[vf] = link.duplex;
+	nic->speed[vf] = link.speed;
+
+	/* Send a mbox message to VF with current link status */
+	mbx.link_status.link_up = link.link_up;
+	mbx.link_status.duplex = link.duplex;
+	mbx.link_status.speed = link.speed;
+	mbx.link_status.mac_type = link.mac_type;
+
+	/* reply with link status */
+	nic_send_msg_to_vf(nic, vf, &mbx);
+}
+
 /* Interrupt handler to handle mailbox messages from VFs */
 static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 {
@@ -1108,6 +1137,13 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 		lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		bgx_set_xcast_mode(nic->node, bgx, lmac, mbx.xcast.mode);
 		break;
+	case NIC_MBOX_MSG_BGX_LINK_CHANGE:
+		if (vf >= nic->num_vf_en) {
+			ret = -1; /* NACK */
+			break;
+		}
+		nic_link_status_get(nic, vf);
+		goto unlock;
 	default:
 		dev_err(&nic->pdev->dev,
 			"Invalid msg from VF%d, msg 0x%x\n", vf, mbx.msg.msg);
@@ -1419,9 +1455,6 @@ static int nic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_disable_sriov;
 	}
 
-	INIT_DELAYED_WORK(&nic->dwork, nic_poll_for_link);
-	queue_delayed_work(nic->check_link, &nic->dwork, 0);
-
 	return 0;
 
 err_disable_sriov:
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 2332e3e95e0e..503cfadff4ac 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -242,21 +242,24 @@ static void  nicvf_handle_mbx_intr(struct nicvf *nic)
 		break;
 	case NIC_MBOX_MSG_BGX_LINK_CHANGE:
 		nic->pf_acked = true;
-		nic->link_up = mbx.link_status.link_up;
-		nic->duplex = mbx.link_status.duplex;
-		nic->speed = mbx.link_status.speed;
-		nic->mac_type = mbx.link_status.mac_type;
-		if (nic->link_up) {
-			netdev_info(nic->netdev, "Link is Up %d Mbps %s duplex\n",
-				    nic->speed,
-				    nic->duplex == DUPLEX_FULL ?
-				    "Full" : "Half");
-			netif_carrier_on(nic->netdev);
-			netif_tx_start_all_queues(nic->netdev);
-		} else {
-			netdev_info(nic->netdev, "Link is Down\n");
-			netif_carrier_off(nic->netdev);
-			netif_tx_stop_all_queues(nic->netdev);
+		if (nic->link_up != mbx.link_status.link_up) {
+			nic->link_up = mbx.link_status.link_up;
+			nic->duplex = mbx.link_status.duplex;
+			nic->speed = mbx.link_status.speed;
+			nic->mac_type = mbx.link_status.mac_type;
+			if (nic->link_up) {
+				netdev_info(nic->netdev,
+					    "Link is Up %d Mbps %s duplex\n",
+					    nic->speed,
+					    nic->duplex == DUPLEX_FULL ?
+					    "Full" : "Half");
+				netif_carrier_on(nic->netdev);
+				netif_tx_start_all_queues(nic->netdev);
+			} else {
+				netdev_info(nic->netdev, "Link is Down\n");
+				netif_carrier_off(nic->netdev);
+				netif_tx_stop_all_queues(nic->netdev);
+			}
 		}
 		break;
 	case NIC_MBOX_MSG_ALLOC_SQS:
@@ -1325,6 +1328,8 @@ int nicvf_stop(struct net_device *netdev)
 	struct nicvf_cq_poll *cq_poll = NULL;
 	union nic_mbx mbx = {};
 
+	cancel_delayed_work_sync(&nic->link_change_work);
+
 	/* wait till all queued set_rx_mode tasks completes */
 	drain_workqueue(nic->nicvf_rx_mode_wq);
 
@@ -1427,6 +1432,18 @@ static int nicvf_update_hw_max_frs(struct nicvf *nic, int mtu)
 	return nicvf_send_msg_to_pf(nic, &mbx);
 }
 
+static void nicvf_link_status_check_task(struct work_struct *work_arg)
+{
+	struct nicvf *nic = container_of(work_arg,
+					 struct nicvf,
+					 link_change_work.work);
+	union nic_mbx mbx = {};
+	mbx.msg.msg = NIC_MBOX_MSG_BGX_LINK_CHANGE;
+	nicvf_send_msg_to_pf(nic, &mbx);
+	queue_delayed_work(nic->nicvf_rx_mode_wq,
+			   &nic->link_change_work, 2 * HZ);
+}
+
 int nicvf_open(struct net_device *netdev)
 {
 	int cpu, err, qidx;
@@ -1533,6 +1550,11 @@ int nicvf_open(struct net_device *netdev)
 	/* Send VF config done msg to PF */
 	nicvf_send_cfg_done(nic);
 
+	INIT_DELAYED_WORK(&nic->link_change_work,
+			  nicvf_link_status_check_task);
+	queue_delayed_work(nic->nicvf_rx_mode_wq,
+			   &nic->link_change_work, 0);
+
 	return 0;
 cleanup:
 	nicvf_disable_intr(nic, NICVF_INTR_MBOX, 0);
-- 
2.17.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
