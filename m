Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAD_ENC_HEADER,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:03:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D476E21920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pauVOBO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D476E21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2vrbJmvm7YD+8NuFl49D1WDAswwKbiOa9uPE6ciL+NA=; b=pauVOBO5YbZz+d
	tVYuvcdWkTzb/H5j3LtcuzoZqhowVe0Bdl0OnwzixSBkS7rlgtp0yIt8qDS60pgK63XA/Nk2uXMZ3
	cS/K18tqHrqPzN7jgItng+2ScDgNtv6xWO4b5XWO2W8pTEFDjtiUgA3pfypIJxCPA2SUgpvVAywun
	k8d+aE79EijQn1CsHtFxAlTX0IR5jTTXlDG5112sLk61dsdZhXKQ0jaQIHxJ9Sm9H0SuU7olwCXDD
	oogXwDGeApmyY4wyeUh3hcr+6oZzFP6oBKCo8a1HbhdUt2jzaR9o4nPZtxg/+S/NzKKKFKDZ0RM/G
	00/fm8HOg/L1zMZrbIUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucDQ-0004Ss-7e; Fri, 15 Feb 2019 12:03:36 +0000
Received: from mail-eopbgr780073.outbound.protection.outlook.com
 ([40.107.78.73] helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucDM-0004Sb-Ue
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:03:34 +0000
Received: from MWHPR02CA0014.namprd02.prod.outlook.com (2603:10b6:300:4b::24)
 by SN6PR02MB5024.namprd02.prod.outlook.com (2603:10b6:805:67::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Fri, 15 Feb
 2019 12:03:28 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by MWHPR02CA0014.outlook.office365.com
 (2603:10b6:300:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Fri, 15 Feb 2019 12:03:27 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=fail action=none
 header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Fri, 15 Feb 2019 12:03:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <shubhrajyoti.datta@gmail.com>)
 id 1gucDF-0000qJ-QW; Fri, 15 Feb 2019 04:03:25 -0800
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <shubhrajyoti.datta@gmail.com>)
 id 1gucDA-00039C-LI; Fri, 15 Feb 2019 04:03:20 -0800
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <shubhrajyoti.datta@gmail.com>)
 id 1gucD9-000392-Q0; Fri, 15 Feb 2019 04:03:20 -0800
From: <shubhrajyoti.datta@gmail.com>
To: <linux-i2c@vger.kernel.org>
Subject: [PATCH] i2c: cadence: Fix the driver in interrupt flurry case
Date: Fri, 15 Feb 2019 17:33:16 +0530
Message-ID: <1550232196-6567-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.453-7.0-31-1
X-imss-scan-details: No--4.453-7.0-31-1;No--4.453-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131947058077119578;
 (f9e945fa-a09a-4caa-7158-08d2eb1d8c44); ()
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(39850400004)(396003)(376002)(346002)(136003)(2980300002)(189003)(199004)(82202003)(6862004)(73972006)(107886003)(4326008)(83322999)(51416003)(356004)(2876002)(6666004)(2906002)(54906003)(498600001)(86362001)(86152003)(305945005)(9786002)(336012)(73392003)(106466001)(2616005)(476003)(126002)(486006)(87572001)(14444005)(426003)(316002)(81166006)(81156014)(16586007)(26005)(77096007)(8936002)(50226002)(8676002)(63266004)(76482006)(36756003)(105596002)(50466002)(48376002)(55446002)(2351001)(61266001)(47776003)(107986001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR02MB5024; H:xsj-pvapsmtpgw01; FPR:;
 SPF:SoftFail; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abdc5749-1432-41af-70dd-08d6933d984e
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(5600110)(711020)(4605077)(2017052603328);
 SRVR:SN6PR02MB5024; 
X-MS-TrafficTypeDiagnostic: SN6PR02MB5024:
X-Microsoft-Antispam-PRVS: <SN6PR02MB50249C55E96455633BF9E85D87600@SN6PR02MB5024.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09497C15EB
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; SN6PR02MB5024;
 23:5vRWu9uDxgs/huO0aN/A5e5RerdDh5BCb0yzsuM9S?=
 =?us-ascii?Q?1io0zab1yphJKkHpTNtD8ELQr+bi36LBUNAngkmACjxU1VQdKBvEByl4pxb6?=
 =?us-ascii?Q?A71S+BW8orZBWHBxwZlopHZaxNlZEcR2kwVpDN3exZikCqye5URQ/QNHUdM2?=
 =?us-ascii?Q?kpX0ZFMSQkFL3yLHl9E82a1pXkNBOgHXRKcTBbcPIKCN/Ck76qHl9P0N+Mh0?=
 =?us-ascii?Q?Xman9I5uf5p1yvb4gUdLetMHMTU+O6ISVYPu4TkTSgqMURnIEV6HbGxdC3VD?=
 =?us-ascii?Q?auDrLueSF7dXlVivsjBZ0zzX1o6TX/G/2HWCt8QCzEUkKrMGlFj5wLBL5a8/?=
 =?us-ascii?Q?pR98b553c6CViHQlcT57tNLwUBa/NT1bQASYv7TyTYw3Nn6lxIWsQyS3XUdc?=
 =?us-ascii?Q?HQn/SkUwSDECIXAKn1LDJHFtuH1uFAKoGLDYcmPyP0E0chA0QYTwp3Zs0yjI?=
 =?us-ascii?Q?qNBzndHzcdbiqWmjeAZoaoTzazienNgdu7wLs5kd92oP71uEa63DjQVrTl0u?=
 =?us-ascii?Q?lMVfSsY82cN8jkrk2emfBilsdHQXpLvYHq0du+W27CkHIVK28190BNQ56woi?=
 =?us-ascii?Q?r9DazCoFbxWx8bqtb4ysYCR66+7zGxy/yiAbmmk1AW8xCn+CPwpc7zLEc8OS?=
 =?us-ascii?Q?jQe4d9lPLs3i7TN8CwwRFq5w/jcdoq7AVVnWajs+N74cEppSYL6vKyCqbJvb?=
 =?us-ascii?Q?H2ZVssw5KCjpIp4fUAYl31UhdkqC4sLWoqcikgQEdsjU18Ya7Aw2N9vJmtiH?=
 =?us-ascii?Q?MT1/Q2tss+pLiKMhTQ7UnG3SsGKstqGZGZzFQp3DHGsMMGur3NruR2Xep7ym?=
 =?us-ascii?Q?Xnf+EIj36wjr/l1uaJAmG+6HR7y7kM9ANlHDx0oEsNWWky8LDlAj8uB5Cj/W?=
 =?us-ascii?Q?9fJBYZ0FnPxtq4mpKUs/a1mxsfVtQavhVK9Dca3OvhYoGzDjzJH6RfF8PiOw?=
 =?us-ascii?Q?Imds1VuS8tJ2kK/FlRftM773a0+cr9DIslcOD6/J0ly9XrTuQ9vmxuULUeN8?=
 =?us-ascii?Q?by3FawRXuQLAbKnHMzfE90W+4QeWL07zE97gh1gn2d9zcCL9skNJZIXwHHk3?=
 =?us-ascii?Q?wQnIgHGxRsrAlUXoNjZWerLgmA8iP5d3b678hshsBR+Y+qeFNW8c6rNEetyR?=
 =?us-ascii?Q?a67DMWPhFUBrme3eCursnvGfT2vjjAtqWqPeX+3H885Rw+0f/ZszfjMXqBoJ?=
 =?us-ascii?Q?qLwhu13Hf+dLFzF8HzR9McxsI71L8Tk3HBqx3XTXyaOdaZ3hWIsY72u/g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: wRwvgxQCmXdu6oHVkQlBAAx59es4rnHItnRqftUi6RwG4ffol0ze9Sq/MK493ZojlsNnwlusG49so6epDHHsMtR895Nyf6NXBGntCo4ENgjw6RoG4FDEGnD3AhH1vge4mO2+cTcXUfFXghNDIvFxSMzcaw5xZBK2kkNud0V5XbquFnwuwOLanQq9JQyhj2yVuihP1uNZj/DHo1kPeuixJzbF02MquWKz7fBM4++Epe7jIjQW+J3tnqJhrHyp6On6TdqdBayvdm7prginyeGNiJMdB9TdwYmYrAcitRNAryPL+SVaCBL8SOdQvPKRS/v/rzFmxI2yXvNxzAaqcjX1uFH9FZyTD1Y0ud51jxFspS2zfkT1vzK0z80P5W9sve6TQMsgXL0ACpZXR2MFzIMDHRXhhK56rG3BLA45cGU1MbY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2019 12:03:27.5812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abdc5749-1432-41af-70dd-08d6933d984e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_040332_992899_D3201FDC 
X-CRM114-Status: UNSURE (   5.30  )
X-CRM114-Notice: Please train this message.
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
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In case there are a lot of interrupts then the hold bit is not
released protect the code by making it atomic by disabling interrupts.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/i2c/busses/i2c-cadence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b136057..92829be 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -365,6 +365,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 {
 	unsigned int ctrl_reg;
 	unsigned int isr_status;
+	unsigned long flags;
 
 	id->p_recv_buf = id->p_msg->buf;
 	id->recv_count = id->p_msg->len;
@@ -405,6 +406,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 		cdns_i2c_writereg(id->recv_count, CDNS_I2C_XFER_SIZE_OFFSET);
 	}
 
+	local_irq_save(flags);
 	/* Set the slave address in address register - triggers operation */
 	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
 						CDNS_I2C_ADDR_OFFSET);
@@ -413,6 +415,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 		((id->p_msg->flags & I2C_M_RECV_LEN) != I2C_M_RECV_LEN) &&
 		(id->recv_count <= CDNS_I2C_FIFO_DEPTH))
 			cdns_i2c_clear_bus_hold(id);
+	local_irq_restore(flags);
 	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
 }
 
-- 
2.1.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
