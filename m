Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763DDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:22:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BB42083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y3zFN5NS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="uFe9SPoG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="BP0SAHj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BB42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dIWjSY93rUCYMmdwqqSa+Uf1oerNWRpgJ9d9Lft8V3o=; b=Y3zFN5NSfPUHHy
	pbuQPgf7iwe4zkvOqccbs/mrQB6RqU0IwNANP6uWvZ0DxIz3uHTvhVTF0+IA6ewP12OGIOS+1+mD7
	Chy/EBml0RVpipGe+KC88OuSXJKnqR3ha54M3ogqfLWrU9rXbrMVsYzWfgySAXVAf+rfm6HNxV+D8
	Isdv94onUzdpZiRsdYwLRAlXhHS24tv4ra7P96sU/ImoschbkId6l0AYHhSqmZxTaK5emhokjVce6
	Ru/lTG27wanO1Mw2UEfUb0ugSMIss6h1JH+WIX+OrHialQpw7ZWIMJLUd3VW72P8BjcWcqv51XUI0
	qC++2vP8TI+hGnKEDwSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKLO-0003uf-Fr; Wed, 06 Feb 2019 10:22:14 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKDU-0007Fn-GO
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:14:09 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16ABLZA017480; Wed, 6 Feb 2019 02:14:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=O2SpVsTIeRQ21GjoxTY+NHBEGN0ag/G9sRxxbPWUOiE=;
 b=uFe9SPoG6r6BY/LTotZ9HiKuEh8N0eF+0sBQl4eX/MAo6/Ly9xRr16/flPTAiODzu+5/
 Pxw5G1kZzpWIkr8p7M7T49Kz5IT0vp9xXzizD40ynBZ0qQGmw3ZixTYQEbvhSuJLql6z
 Lbe0Ef2SHJThNybAEq3cjI0YjrZzSt5K/zrCTez/1L6ZnghVXIn7jicxWR7IlQzQ1zDD
 9BGUHc9EzrGDQFYdqr5WEq1W8T6gXJJDJ8DrJ8zr/Wp3U/gKTZfRbTf6I/oUVhTXAHR+
 Pr3Cndn5vRadSCShdFucUnikfd1tOyJB87Vbi1sQeiyYAH1+smnLOlFypftOzDIJVxyJ ow== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0a-0016f401.pphosted.com with ESMTP id 2qfc2augvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 06 Feb 2019 02:14:02 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:14:00 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:14:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2SpVsTIeRQ21GjoxTY+NHBEGN0ag/G9sRxxbPWUOiE=;
 b=BP0SAHj1LMmbHGfprqN2JdP755bods2UHIBuVU3RwnsBKMQQ6jOlBZAz1Cc//ACRxNKF20HFxgOZe7Ce5zj86Aj23i87mlT4s9ewXpD63xCKloSUlVG/a8vGAFjOUZcrUHHieFjH5Wia2a8ybTx+SPND9f1kEYlqwRyoKRi56MQ=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:13:59 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:13:59 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "rric@kernel.org"
 <rric@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] net: thunderx: implement helpers to read mailbox IRQ
 status
Thread-Topic: [PATCH 7/8] net: thunderx: implement helpers to read mailbox IRQ
 status
Thread-Index: AQHUvgSsQrsOEKyqqkOJRC405BMp8w==
Date: Wed, 6 Feb 2019 10:13:57 +0000
Message-ID: <20190206101351.16744-8-vlomovtsev@marvell.com>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1238;
 20:PkDfyXhEG1ap+Hbh/NgiMkuvl35dvvPqrjkav0EhugpLJ1IpmtZ3zRZkaHBTFgLhhdvyZO7ADoE0KVbzHTTrze8IFAUrChMuk6Ut7ySD/Q+pAsjvCp64UJ3NnpH2/bOPPxDiAPD/kpREd3vFCLFu759XYeGN1nkbVGXP6DlntQw=
x-ms-office365-filtering-correlation-id: 38930cf9-950b-41d4-1728-08d68c1bcfaa
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1238; 
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB1238A76CA178047F3007ADA7CD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(14444005)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(11346002)(107886003)(54906003)(110136005)(76176011)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(15650500001)(6486002)(2906002)(476003)(25786009)(2616005)(446003)(53936002)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1238;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LwCPue04OLIa6kcsiKD0vSh6AbGPmJun+gFPLAYWzAP/W/3uPDS/OVNpgAXpS+YfEQazNu0Oeu27zews+h5n6ZIR9qnHYMRTW8P0LLGuqaqmhy7LEKTezZZdrWZD2rhjaRJ3V0icYSDPjrDB+IHNheA+n1ZLrWjeaRl5ONinnWGUHt7J0J7LRU8bi3+hulDEU5SzfyMqOKEoezQtnaNbO4hGw7g+oZgBRq//mAG1IgjstoImy8Uy/73uTkA6hmBu/Q+xJ/q60H1IVg7hFbZ+sEPKd6ECCEavXjHIP20/1AJNrMcIEx/TgKXvHDz2vCM7Yy6ynPfdOTY2xqkisMni6kwGxvyqu0/VWf/4hWc/k6WCr1q6Oy/ZiThPoyUjE2uskd2/iCNdqt/IoncEnmEmDpSI2OeHoNztaJcYWS9aHtY=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 38930cf9-950b-41d4-1728-08d68c1bcfaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:58.0227 (UTC)
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
 mlxlogscore=557 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_021404_884202_B44C3276 
X-CRM114-Status: GOOD (  14.50  )
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

This commit is to implement routines to read mailbox IRQ status
for particular VF at PF side, and for mailbox IRQ status
from PF at VF side.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c     | 13 +++++++++++++
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 14 ++++++++++++++
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 620dbe082ca0..a32c1bd75794 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -104,6 +104,19 @@ static u64 nic_reg_read(struct nicpf *nic, u64 offset)
 	return readq_relaxed(nic->reg_base + offset);
 }
 
+static int nic_is_mbox_intr_active(struct nicpf *nic, int vf_id)
+{
+	int ret = 0;
+
+	if (vf_id < NIC_VF_PER_MBX_REG) {
+		ret = nic_reg_read(nic, NIC_PF_MAILBOX_INT) & BIT_ULL(vf_id);
+	} else {
+		ret = nic_reg_read(nic, NIC_PF_MAILBOX_INT + sizeof(u64)) &
+			BIT_ULL(vf_id - NIC_VF_PER_MBX_REG);
+	}
+	return ret;
+}
+
 /* PF -> VF mailbox communication APIs */
 static void nic_enable_mbx_intr(struct nicpf *nic)
 {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 5b4d3badcb73..e7ee7005657c 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -1801,6 +1801,20 @@ void nicvf_clear_intr(struct nicvf *nic, int int_type, int q_idx)
 	nicvf_reg_write(nic, NIC_VF_INT, mask);
 }
 
+/* Check if interrupt is active */
+int nicvf_check_is_intr_active(struct nicvf *nic, int int_type, int q_idx)
+{
+	u64 mask = nicvf_int_type_to_mask(int_type, q_idx);
+
+	if (!mask) {
+		netdev_dbg(nic->netdev,
+			   "Failed to read interrupt status: unknown type\n");
+		return 0;
+	}
+
+	return (mask & nicvf_reg_read(nic, NIC_VF_INT));
+}
+
 /* Check if interrupt is enabled */
 int nicvf_is_intr_enabled(struct nicvf *nic, int int_type, int q_idx)
 {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
index 5e9a03cf1b4d..58f6fbe48bce 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
@@ -358,6 +358,7 @@ void nicvf_enable_intr(struct nicvf *nic, int int_type, int q_idx);
 void nicvf_disable_intr(struct nicvf *nic, int int_type, int q_idx);
 void nicvf_clear_intr(struct nicvf *nic, int int_type, int q_idx);
 int nicvf_is_intr_enabled(struct nicvf *nic, int int_type, int q_idx);
+int nicvf_check_is_intr_active(struct nicvf *nic, int int_type, int q_idx);
 
 /* Register access APIs */
 void nicvf_reg_write(struct nicvf *nic, u64 offset, u64 val);
-- 
2.17.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
