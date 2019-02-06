Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:15:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E43420823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P1/shfdT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="xXhuPOTA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Vnr0BGQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E43420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZrBnBzYWleVs5Q288q4XG8eby8pErO+rnoO1MMHngmE=; b=P1/shfdTa+gOd5
	t4wSbLLNA0amdn40HYnA6mWS3s+z5pbNevX5P3hmc8xU6cJlzlP933PfIHRqjYgNtj8R8Ri4iujww
	511aHNjYzKJBzfgOlmr14MAHQ4MP3UqPqpojVYV5AR4J7wJnBn16Yr5xnEa5JCyJeU+vISROGJ+7R
	bVhF6IpIMUo6vPJ/7cYoqWUFa3ktAEkie/KszjbzeNjo9b3qbpZq9Tt3n/K9INBpZYhV53wK4ioAV
	tIpUF/RWQMd08BE0vuZX1J7dS+46sQ+b7clbGz28hn6mEU9gbbTjAjv25kx/ejqiIv3YRSURem5dq
	8+HoWXUTKX3q3SZr/V7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKEN-00089Q-SP; Wed, 06 Feb 2019 10:15:00 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKDR-0007Dz-9B
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:14:04 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16AA75f016819; Wed, 6 Feb 2019 02:13:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=2EzC6rX36BewKhRwnhCbiJLmyghA4rQx8aJY3zkElXA=;
 b=xXhuPOTAjE8Ke6wkkW99ZPot8Zp/tRxo74XD21dRHRPllevbh+RjlJdln1b5o9ufoqST
 LYsKOtrizy8aKC7RCNV5vvfTQmDxzoaAXoIdJHfrZx7pPzE8x5Vt48Q+GPAg0196p2a5
 6XVbgs68v6JzLvGLwBJcQZdslhMQeGR71370Xj8MpAL/qDgvP+1nEqcj6JiIfUFZ97TU
 bnrO0nknMBbBIgICf835dBVoKGTvI9OG1h4ysJaJOKxVTQeSpZS/Iy1Jyr1dZEbAfXOC
 bd3mdGtlICPv105MqU8MjGQ0nNm0dDV4CddCxIFfFg4aXw9pFI+8NoRMJztOF5DIQd6e IA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 2qfc2augur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 06 Feb 2019 02:13:57 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:13:56 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:13:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EzC6rX36BewKhRwnhCbiJLmyghA4rQx8aJY3zkElXA=;
 b=Vnr0BGQPIQGlDgrscVDMgbHlMdGT+lHlttU7HVISNqr+5REvNWsp98+F25HUFNszkTYHTZ0ymvlvt6iEXd4Fl94VtSLA0LWqEoE1mSLFB5f44zzcNThI132PgW/fR3OvJwOYT73ruK6MqGnuMCQq2tIVOdgiyqOwlwqIn00BY0M=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:13:55 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:13:55 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "rric@kernel.org"
 <rric@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] net: thunderx: replace global nicvf_rx_mode_wq work queue
 for all VFs to private for each of them.
Thread-Topic: [PATCH 2/8] net: thunderx: replace global nicvf_rx_mode_wq work
 queue for all VFs to private for each of them.
Thread-Index: AQHUvgSqJujG22pOMUSRTWxWcKZECA==
Date: Wed, 6 Feb 2019 10:13:55 +0000
Message-ID: <20190206101351.16744-3-vlomovtsev@marvell.com>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1238;
 20:QsntwIyUEMR39oPQtwybWfMtWxRfvsT18CkYG0FghQsWJg7zrLbsh667CtXAUuAXNRBkJ7bNvHwf47n5AWGdf679RV1sj/vxIIqcdje8JOhipYATtZ8SnSv/fhzvKOgo6/ClDNHsz6ngWE9wyNUkbm15PVFXvmL49xxDcZsYa4M=
x-ms-office365-filtering-correlation-id: b9c8cfc3-4570-4153-82e2-08d68c1bcd68
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1238; 
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB12389F0DEF5E668F4FEA00F1CD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(14444005)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(11346002)(107886003)(54906003)(110136005)(76176011)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(6486002)(2906002)(476003)(25786009)(2616005)(446003)(53936002)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1238;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zhRgD3/dRi+Y8DAoAzGdJGpyp7Ywbzm5J6kvLW1/+f4mOf2eLQNnvP4+pppZFInO0zttEKgdbBZhl7/SHnfHWymjGDlZHxpoepsA+R2ZhGd6ae90lb2DrS/0nXs0F6ANs/1+R0mYdtxGlvwpj+XaoqHrFxHNbbqE+oNGUzW4pe6yxyAvvC8rUjQ7GW9WUYHZwMQxzXwNxQxsUm/1CemNYEgEuAWKr0m338y3tF7yqoXQ+nzYTsyX7K90Ss+7F82Z/JS6yRgZS98whuiBr1OU6eQWFl8xzKmQDYChdlcydk05MRWBS/+xrrxohjHEqaClN+uIEHQaff4qEkYG96EbPi5YGiW2QSptwLeRrBW77n41OsF5EkpJRBa2SYkO2ILxBVgXWg8FmnDZ+oPgscHKT3zFP3lD8MydakDzFNtkmsE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c8cfc3-4570-4153-82e2-08d68c1bcd68
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:55.0992 (UTC)
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
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_021401_465707_4D560167 
X-CRM114-Status: GOOD (  15.68  )
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

Having one work queue for receive mode configuration ndo_set_rx_mode()
call for all VFs results in making each of them wait till the
set_rx_mode() call completes for another VF if any of close, set
receive mode and change flags calls being already invoked. Potentially
this could cause device state change before appropriate call of receive
mode configuration completes, so the call itself became meaningless,
corrupt data or break configuration sequence.

We don't need any delays in NIC VF configuration sequence so having delayed
work call with 0 delay has no sense.

This commit is to implement one work queue for each NIC VF for set_rx_mode
task and to let them work independently and replacing delayed_work
with work_struct.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h     |  4 ++-
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 30 ++++++++++---------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index f4d81765221e..376a96bce33f 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -271,7 +271,7 @@ struct xcast_addr_list {
 };
 
 struct nicvf_work {
-	struct delayed_work    work;
+	struct work_struct     work;
 	u8                     mode;
 	struct xcast_addr_list *mc;
 };
@@ -327,6 +327,8 @@ struct nicvf {
 	struct nicvf_work       rx_mode_work;
 	/* spinlock to protect workqueue arguments from concurrent access */
 	spinlock_t              rx_mode_wq_lock;
+	/* workqueue for handling kernel ndo_set_rx_mode() calls */
+	struct workqueue_struct *nicvf_rx_mode_wq;
 
 	/* PTP timestamp */
 	struct cavium_ptp	*ptp_clock;
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 88f8a8fa93cd..abf24e7dff2d 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -68,9 +68,6 @@ module_param(cpi_alg, int, 0444);
 MODULE_PARM_DESC(cpi_alg,
 		 "PFC algorithm (0=none, 1=VLAN, 2=VLAN16, 3=IP Diffserv)");
 
-/* workqueue for handling kernel ndo_set_rx_mode() calls */
-static struct workqueue_struct *nicvf_rx_mode_wq;
-
 static inline u8 nicvf_netdev_qidx(struct nicvf *nic, u8 qidx)
 {
 	if (nic->sqs_mode)
@@ -1311,6 +1308,9 @@ int nicvf_stop(struct net_device *netdev)
 	struct nicvf_cq_poll *cq_poll = NULL;
 	union nic_mbx mbx = {};
 
+	/* wait till all queued set_rx_mode tasks completes */
+	drain_workqueue(nic->nicvf_rx_mode_wq);
+
 	mbx.msg.msg = NIC_MBOX_MSG_SHUTDOWN;
 	nicvf_send_msg_to_pf(nic, &mbx);
 
@@ -1418,6 +1418,9 @@ int nicvf_open(struct net_device *netdev)
 	struct nicvf_cq_poll *cq_poll = NULL;
 	union nic_mbx mbx = {};
 
+	/* wait till all queued set_rx_mode tasks completes if any */
+	drain_workqueue(nic->nicvf_rx_mode_wq);
+
 	netif_carrier_off(netdev);
 
 	err = nicvf_register_misc_interrupt(nic);
@@ -1973,7 +1976,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
 static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
 {
 	struct nicvf_work *vf_work = container_of(work_arg, struct nicvf_work,
-						  work.work);
+						  work);
 	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
 	u8 mode;
 	struct xcast_addr_list *mc;
@@ -2030,7 +2033,7 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
 	kfree(nic->rx_mode_work.mc);
 	nic->rx_mode_work.mc = mc_list;
 	nic->rx_mode_work.mode = mode;
-	queue_delayed_work(nicvf_rx_mode_wq, &nic->rx_mode_work.work, 0);
+	queue_work(nic->nicvf_rx_mode_wq, &nic->rx_mode_work.work);
 	spin_unlock(&nic->rx_mode_wq_lock);
 }
 
@@ -2187,7 +2190,10 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&nic->reset_task, nicvf_reset_task);
 
-	INIT_DELAYED_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
+	nic->nicvf_rx_mode_wq = alloc_ordered_workqueue("nicvf_rx_mode_wq_VF%d",
+							WQ_MEM_RECLAIM,
+							nic->vf_id);
+	INIT_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
 	spin_lock_init(&nic->rx_mode_wq_lock);
 
 	err = register_netdev(netdev);
@@ -2228,13 +2234,15 @@ static void nicvf_remove(struct pci_dev *pdev)
 	nic = netdev_priv(netdev);
 	pnetdev = nic->pnicvf->netdev;
 
-	cancel_delayed_work_sync(&nic->rx_mode_work.work);
-
 	/* Check if this Qset is assigned to different VF.
 	 * If yes, clean primary and all secondary Qsets.
 	 */
 	if (pnetdev && (pnetdev->reg_state == NETREG_REGISTERED))
 		unregister_netdev(pnetdev);
+	if (nic->nicvf_rx_mode_wq) {
+		destroy_workqueue(nic->nicvf_rx_mode_wq);
+		nic->nicvf_rx_mode_wq = NULL;
+	}
 	nicvf_unregister_interrupts(nic);
 	pci_set_drvdata(pdev, NULL);
 	if (nic->drv_stats)
@@ -2261,17 +2269,11 @@ static struct pci_driver nicvf_driver = {
 static int __init nicvf_init_module(void)
 {
 	pr_info("%s, ver %s\n", DRV_NAME, DRV_VERSION);
-	nicvf_rx_mode_wq = alloc_ordered_workqueue("nicvf_generic",
-						   WQ_MEM_RECLAIM);
 	return pci_register_driver(&nicvf_driver);
 }
 
 static void __exit nicvf_cleanup_module(void)
 {
-	if (nicvf_rx_mode_wq) {
-		destroy_workqueue(nicvf_rx_mode_wq);
-		nicvf_rx_mode_wq = NULL;
-	}
 	pci_unregister_driver(&nicvf_driver);
 }
 
-- 
2.17.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
