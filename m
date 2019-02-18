Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4211C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7B0218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qWqrZcF7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jpylctmI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="P4JV9NP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7B0218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ke/qJuVDDywkXP1gT4sZJV2XtLQam/GoSMvjgQULzaQ=; b=qWqrZcF7SbE8xI
	wqhuTmyosmMjLOoWJ9CiyXDQmsbax5PDVmr4p88RjTCOFODppLq/Qn24kfunsBlt/Y8tdwqejqd0t
	eS9qpFc6u8YhjroolKEFmL2HtFu0HxMC/tZgpMEcCwiD2nZ0HP1tIBzQyDqFSDBeb2nTv5P0zbJM2
	PTRxhjqsOhmXzwxCihdfuUjtu7C+j1mACf4Xbb+/5waxRMf/hZN2mh0+r7u9q4rFJpScZ6cZrZ6tT
	yt90AUr22XkCP9griKvTZkxXbevwn+XauolkWzSmfIurQ/4mzAxLbOR1m51x2HFRhvQL20xc7YDNj
	AT5gZ7AZzfcKgZrIp8xA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfc5-0003BS-3I; Mon, 18 Feb 2019 09:53:25 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfbA-000284-C4
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:52:32 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1I9qE5c025142; Mon, 18 Feb 2019 01:52:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8HuPjuAyx5Cgb6PGzx3dlsIxRyRgs4rFgvx94nsHdyo=;
 b=jpylctmI+N2Zlc0lsCmajW0YE5f2rjOekncxGWrUGwGkArC04ErUR4+a7A5eVQaX0LvW
 EN16g7xlpzgZ94QSHxHma8J6HWvYn6f3wp3AEpq707V+E32HXHcFIBdwGkso4DLCUOti
 UbItbSMoZ1FbyfYxAAjElZ9tDCL6OjEsl0GeQYSOMm2iVXyjRHS10RbIK1uvU2zBt1z7
 avw6xMJ10Dse8FE3yutq1uwqkrS2BEbpzz+fKgO32a2D9HWAOFYH4S3DzqXH9H9SuFy0
 uGDDyNA99UszCniExtdk+wIOQVOZwiw8jUyTcpid1V6e5MEGd8LVc5iiXnLsgFKfRAto +Q== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 2qpjwpw14e-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 18 Feb 2019 01:52:23 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Feb
 2019 01:52:19 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Feb 2019 01:52:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HuPjuAyx5Cgb6PGzx3dlsIxRyRgs4rFgvx94nsHdyo=;
 b=P4JV9NP70DtospwluNupJ0r7C6xrAHcXMXadSUMLOQ6AsrR4jsIcRl1HqVkVEUuqTHS7NxALjH59xf0TDLrgZpYppfwgAqQ1GwHfC0tXJcRH6/1t/NUyj2/zFWbCT04lkC+eH22LXPNEXGA0EvJfGHAGMorxyIbuch9ehRndY+k=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB0968.namprd18.prod.outlook.com (10.173.182.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Mon, 18 Feb 2019 09:52:16 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 09:52:16 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "rric@kernel.org"
 <rric@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/8] net: thunderx: make CFG_DONE message to run through
 generic send-ack sequence
Thread-Topic: [PATCH v2 3/8] net: thunderx: make CFG_DONE message to run
 through generic send-ack sequence
Thread-Index: AQHUx2+gF6zWP2JT70e1Q1SDCmWuPg==
Date: Mon, 18 Feb 2019 09:52:14 +0000
Message-ID: <20190218095159.3847-4-vlomovtsev@marvell.com>
References: <20190218095159.3847-1-vlomovtsev@marvell.com>
In-Reply-To: <20190218095159.3847-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7ce6e53-aad5-4913-c271-08d69586c3bd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB0968; 
x-ms-traffictypediagnostic: CY4PR18MB0968:
x-microsoft-exchange-diagnostics: 1; CY4PR18MB0968;
 20:scXAofM8ih1J/9RJd34hUewBMK4bAe6DZq123y1pPd6YyHNVO9h1JXIJN9Iz6lxlvEpcYv0I4k8UpDpgtT1AtDrNv/OurVGPxT14wVo4ebJ/sHNensj3DXmhd7MNTlVCn4erFAm3j5Qof9WqdqzDWUdl/h0Jj8pOaKGpZAU00pk=
x-microsoft-antispam-prvs: <CY4PR18MB0968935AEC57C90A92BBE868CD630@CY4PR18MB0968.namprd18.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39850400004)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(486006)(7736002)(305945005)(316002)(4326008)(110136005)(54906003)(25786009)(99286004)(8936002)(476003)(5660300002)(186003)(2616005)(76176011)(81166006)(81156014)(6436002)(446003)(11346002)(14454004)(2906002)(8676002)(71190400001)(71200400001)(6506007)(256004)(68736007)(1076003)(2501003)(2201001)(36756003)(6486002)(53936002)(86362001)(106356001)(102836004)(26005)(15650500001)(97736004)(3846002)(105586002)(66066001)(6116002)(478600001)(6512007)(107886003)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB0968;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cLCDorH9vLud9bheYqpOR+KP8j9wlYIGwUA0wukW8HKa3mJ23RoNWUS7/9u+/h9xrH0uZo03MwXYP/4aTfrqUA6/ay60UKCWmn6Bzrh++ASc9Hk729sX4ET21J2yvlHWw/zdsCnAMVfEMtYpSE/oT/BTT5TyXdQtw8kzfrBVOyCpaV0dGd3fxVzDsExv0fRS03qCTW4d3llU4lbP6UhUo0rYznl7rb4cBMsCqpz3Hv/p3mmvXkgg4HQEJW99R0V+GQW9qZF+/awwNLDWfBaqV9xbUtAXB9dqDxPfmUK6RJqSNpz1VQHvivOv9PoBOpWzM5fnfodL5B6yxc35MvMq/ge00bIdUNV87L5p6WsgkAtApaJG/FywmY37HD8gQAPnt3RzGIcNEuaBZUHd3ji/+faP6dBRYn3hTdGGqH5iA/w=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ce6e53-aad5-4913-c271-08d69586c3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 09:52:14.9883 (UTC)
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
 mlxlogscore=763 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_015229_071391_5DEF11A8 
X-CRM114-Status: GOOD (  15.80  )
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
