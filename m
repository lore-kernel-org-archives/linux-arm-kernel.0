Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AACC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:37:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43622077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aqDxdEoK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yCLaE2m1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43622077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UeRfy/c5UfjJOzL8jF3xkHTsrdJ9dSgXOWJbJpcmsnA=; b=aqDxdEoKSZLfOg
	HRSx/vzwUaJjvsNHLvxZ54inMlsl82P1eNBIladq+P1gmzYs1W0Tms6ma9KhUE0aXqY0KoORqWOhX
	Y3oQ3digKAIVxZgCaNHd8v6Wa7ixY/SEy8KV2cz1Q2vFjIVvJSsqp0lXATVd8DaaH5N7LmnNxr/OP
	A0ruOOZ20qTFqyKMtYQWPzsU1KNoxHpbK7/mvSJM6q9uoiWJ9uaZl/lW98zbN1XxqJjYFPq1oJspt
	IkSvE7YkYyaKhCUycm5Op37kItLC2ZUjxx83fGMx5cLtZCBnn4cSQtM/sSWWEZ+4RdO5ECAAqgTTa
	uAYEidqbtsFgip1WijCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwypw-0000vL-NE; Fri, 22 Feb 2019 00:37:08 +0000
Received: from mail-eopbgr730052.outbound.protection.outlook.com
 ([40.107.73.52] helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwyps-0000us-Qe
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 00:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+YgeUvDROcFssml+cC8BThEPK/+QSDA57SEaQ9luGc=;
 b=yCLaE2m1xuyPsajFb8i/dZNG+Enl1n77Yi4A0tpoGuo+2AgEWQa4MBz1LpUomQzlyCqjb4oJ0mhy7gb0p2Rg7BFmWLooJceyflFoKLAPBEB7fLeZMx7jxt4EmZOfpOZhjC/J85Spk39ZxI9ErONyXmy4ec32+0IJY3njq6eXNn4=
Received: from SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) by BYAPR02MB4631.namprd02.prod.outlook.com
 (2603:10b6:a03:5f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.19; Fri, 22 Feb
 2019 00:37:01 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by SN4PR0201CA0056.outlook.office365.com
 (2603:10b6:803:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.14 via Frontend
 Transport; Fri, 22 Feb 2019 00:37:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 22 Feb 2019 00:37:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56899
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <wendy.liang@xilinx.com>)
 id 1gwypo-0003d4-7Z; Thu, 21 Feb 2019 16:37:00 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <wendy.liang@xilinx.com>)
 id 1gwypj-0007cn-3d; Thu, 21 Feb 2019 16:36:55 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1M0arwe007314; 
 Thu, 21 Feb 2019 16:36:53 -0800
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <wendy.liang@xilinx.com>)
 id 1gwyph-0007cY-46; Thu, 21 Feb 2019 16:36:53 -0800
From: Wendy Liang <wendy.liang@xilinx.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@xilinx.com>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH v8 0/2] Xilinx ZynqMP IPI Mailbox Controller Driver
Date: Thu, 21 Feb 2019 16:36:32 -0800
Message-ID: <1550795794-27594-1-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(199004)(189003)(478600001)(305945005)(77096007)(50226002)(107886003)(8936002)(8676002)(9786002)(81156014)(26005)(81166006)(14444005)(186003)(15650500001)(51416003)(7696005)(336012)(54906003)(486006)(47776003)(50466002)(2616005)(476003)(106002)(316002)(44832011)(110136005)(36386004)(2906002)(106466001)(126002)(63266004)(356004)(4326008)(36756003)(6666004)(48376002)(426003)(5660300002)(16586007)(107986001)(42866002)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4631; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com; A:1; MX:1;
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06c00413-5af8-4272-d629-08d6985ddbfc
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);
 SRVR:BYAPR02MB4631; 
X-MS-TrafficTypeDiagnostic: BYAPR02MB4631:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1; BYAPR02MB4631;
 20:0Es9X6Dum+5GHcyzdefIjCKPWKbgu/yi8BC0aA3apyyAQjRb7K5XIbOE6w7cZDgLZfAizMosvdkacpvGxx9ujIVnVUaTydtNu+wtcUkZGVFpkFsQ0j6g035bwD5j/3xJMHhMfnu8/irqAe1lq/tPaEZ4LEqdCrbiM7Dh1hnvBocGteaAYzQ693nhn3eFnTAhCYHYZa+pQikREoXMthTiDjGVzAkblReMR5DdXZURzCAG5KjODeEUQxSmnwXIWE0Jxwufse1aclt2hg1ww4s6iK5PXpXPWNE3O9Nf+V6qkmLrzPyRyCBc5YFYPLrUbfJ512Rjn6iSu2EQICHE7U8du9SRyVcinlQF4VvSOp2T6Cp2Q4JylXet55OCQYvU26hY4jRojMh0GfbJJ6HnzVaSEdS9xuXZEAPToliw4Mf+1ciDNQzZgJ1Y7BIeQ35prce2gOVSDPd/cb5EYi55Q8wCoMzBp3f+dLxPkP+IiqPuSUX27yhmeak6T3myheS8Kqdg
X-Microsoft-Antispam-PRVS: <BYAPR02MB46315E5EC760DC043B991AF8B07F0@BYAPR02MB4631.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09565527D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; BYAPR02MB4631;
 23:X9OQnhhj3QK/OdkkHg73VFVSUj9hUJOzX7GIJYW3d?=
 =?us-ascii?Q?XfntHxd3wOpo0NnCi4OTW2cgfpin11M5D3EnAYhGNoa3r/fQYKfyKTdoAqNy?=
 =?us-ascii?Q?p0tl+dOEPVmiGppxIqKfETwYJGB43S1RhO+5kUV4NEZFYOnJ7wb+bdRxqAW4?=
 =?us-ascii?Q?86F9Dc15t5wPtA5eq7tOYaMki1U+kRrKBHJX3Nj55y1TKKinwCZdIWZ1X+YB?=
 =?us-ascii?Q?sfkOCfHWwvqps77CoFvGFYoEiMHp4KuCEi5JMSUKsTjjzxlBatZ6/hlb38xT?=
 =?us-ascii?Q?0SIY1AWWjI14xq1rJRUIaWoW1gI4Qdnee/H4RP7l83bBHTgdGK0SRfOCZggz?=
 =?us-ascii?Q?n0Ji7UhqpnrnS1iSGLIGWMoGDpSPOxfSXFCCacKn4Y19FQaaGP7gOJaqYZf2?=
 =?us-ascii?Q?BgiBlBRiNrgG7JGUbRqqKA/dBLisPS2ZYWGi8iQTevgYmKgyWpd1mMrxsNi9?=
 =?us-ascii?Q?iRM/xJZm26DPxtIFJe36+zyAhalue0joKRiI8ZysSTeXovzXjW5cz0Vnx8ko?=
 =?us-ascii?Q?Wpnn5UDCg++YfR9k1g0YVdaB/WXhNxvTxxZlI4wJumGUcnGzr6sydrDtGu61?=
 =?us-ascii?Q?WAbJbtuedYSVbbJweQs9D6EU4rqshM5BfvzwXjR361lcsfH3tsvyj8pLcjqO?=
 =?us-ascii?Q?3+eD+a7jvXVWNsXIGTABAgNQgw7uXWKWH2oZOtpGLWtOghUf2tBT5fMCcHZ4?=
 =?us-ascii?Q?IbyE5KhNaenkp/l6bKGdXQhP+XsQ+0BXTsOJ6Fq4qJHRiFJLoCyEJi4gl1bk?=
 =?us-ascii?Q?yMYwSrmGRTojZb/LdZeTQdnPBo09YZ6Gp7JlG2y8UX/vKijtMTndXLyr6Rg3?=
 =?us-ascii?Q?Xx1DpyAg+ovd5fku1a/jyPWnzdQj+GgaQY66qQ81/M1p1P2u0Um5WhSEVsjb?=
 =?us-ascii?Q?r5F9aMUgZcetZFIlMbHeoGtJV/IlR3TWPC2BMfDXGqOq/THxauqdly27q3nE?=
 =?us-ascii?Q?FN9a3U6dTwz7nFCSijG/0BWn5kGqjL/0q1O+RelBZ74FF0VTLHl3YXUPCPM6?=
 =?us-ascii?Q?n7vkfZJFd4meno17MlT2852Xb15y2hxwowqDMfxhstARHeS/YRBpc7YrICcX?=
 =?us-ascii?Q?2rNmPEJDddXLVwXaHMeW5G//Bq3aT27nDR3QjoQnMtGCtYUUli2cgklY+uHA?=
 =?us-ascii?Q?wfVtKn6M6pyl0x+jdN8e1XXjx0gQEp/6spzYrf9axWn1530nmWoZg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ESDKciAqhTTWWwpEGcPkEQumiu2GTrAZlra47Sm4iCMBBLh3dFN58onQhkTD1hUCrO1Beinx9lkjSdF4NN8DwEr4N2foPx2iNgvykzn6Rq0lYN6vU95dF9n8t6RxqCORewqwoRblRTIgXTC0FkcD8RVfrHngaYDL+SezGkAeYQpRRFabcEZE2fkEtofTb0ozUKB3fytNe9MDxkadxkq89hEGGoatjbzBT33W+iVJX4gEXgP8JLFf9WW5LmiIehFXuX1SJ0HuXeXIBVjTmXVPut9c/377ZvQNENXbQsiR0D1BvH1RS212qEEkw2YVAMHG5mrQA1a/AEyCg+sYMgws8ppZE5qD6tk/dUt9I/NyIkRqiYbjB2wD7CdHuvRDVfuO0Ij6doQQD3QdDDbH72dQaCLx49lQ04vmjKVlwRfwAfE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2019 00:37:00.7920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c00413-5af8-4272-d629-08d6985ddbfc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4631
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_163705_203112_46AEB672 
X-CRM114-Status: UNSURE (   9.30  )
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
Cc: devicetree@vger.kernel.org, Wendy Liang <wendy.liang@xilinx.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Introduce mailbox controller driver for ZynqMP IPI(Inter-processor
interrupt) IP core.

v8:
 - Remove unused macros
 - Remove polling sending status from send_data
 - Remove calling receive callback from last_tx_done()
 - Use devm_mbox_controller_register()
 - Use of_get_child_count() to get the number of mailboxes.

v7:
 - Fix sparse warning, and documentation check.
 - Add emply block to the end of of_device_id.

v6:
 - dts-binding, remove compatible property from IPI subnode

v5:
 - fix check patch warning on write a paragraph to describe the kconfig
   symbol.

v4:
 - make IPI mailboxes as subnodes to the IPI agent device node to properly
   describe the hardware.

v3:
 - add NULL entry to of_device_id of IPI controller

v2:
 - change SPDX-License-Identifier license text style in .c file
 - replace xlnx-ipi-ids with xlnx,ipi-ids


Wendy Liang (2):
  mailbox: ZynqMP IPI mailbox controller
  dt-bindings: mailbox: Add Xilinx IPI Mailbox

 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 127 ++++
 drivers/mailbox/Kconfig                            |  11 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/zynqmp-ipi-mailbox.c               | 725 +++++++++++++++++++++
 include/linux/mailbox/zynqmp-ipi-message.h         |  20 +
 5 files changed, 885 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c
 create mode 100644 include/linux/mailbox/zynqmp-ipi-message.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
