Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE1CC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:51:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E7B217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kc+F4O33";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="p3NtVJIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E7B217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6NQTY/+BmsZ1j9U1/4HFZWtVbY29PGgOgqg317fsKUE=; b=kc+F4O33IJZWSZ
	K9gIMVLilCHpB1JhSjBwwz910j/BRlX1vAGes0dptg5vXJoGL6UF/TQOcIyjuEz7ktlIhjZrE2Qz/
	iAI8Y3eMufJmhPtflz0Yc7buTxz5b/mYuwQ2/J+G0k/Ozt1d5/Xbfy015Eo78a5VSzvtJppmaiKK1
	/wLoxdTJLUvliKFgbnC+KHRC7yYxMKlnbJpnTj8T6jxbGvugwudiJVn5MkRj+nIqG8T1WrQjRF6Gu
	861OKZEDFcgx2enfUzbQsUfni3QzM+QsW+ymFAkosreueogr67c4ZBFasJW/H0cFArMH0FCbw148g
	JGjqxSGni8rILpUWGgZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz6Az-0000gz-Vq; Wed, 27 Feb 2019 20:51:37 +0000
Received: from mail-sn1nam04on0622.outbound.protection.outlook.com
 ([2a01:111:f400:fe4c::622]
 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz6Aw-0000gB-4X
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 20:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFGnTeoUogxOqPKWePNRFHV/PDyf3h5vhkGlCJJKUFE=;
 b=p3NtVJIXj79Fi6MsqUJN1p4thR3u3D6YpFRxcOhBMjCRyoxqXOzCl7WsKxZCJQ7+Hbl/0JldzrAnUjqDrIo9BoS+Suj+oLIatdg7ug6bAckhCyfX54micKwXmylH1s5vNsezScUh629vh8vT1Bm5rgjtUsiG2Pum952ZNd8htmk=
Received: from BL0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:207:3c::38)
 by DM5PR02MB2267.namprd02.prod.outlook.com (2603:10b6:3:4f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.16; Wed, 27 Feb
 2019 20:51:30 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BL0PR02CA0025.outlook.office365.com
 (2603:10b6:207:3c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.20 via Frontend
 Transport; Wed, 27 Feb 2019 20:51:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 20:51:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40418
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <jolly.shah@xilinx.com>)
 id 1gz6Aq-0001fk-Hn; Wed, 27 Feb 2019 12:51:28 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <jolly.shah@xilinx.com>)
 id 1gz6Al-0002WZ-Dc; Wed, 27 Feb 2019 12:51:23 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1RKpKEw007069; 
 Wed, 27 Feb 2019 12:51:20 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <jollys@xilinx.com>)
 id 1gz6Ah-0002Vn-V8; Wed, 27 Feb 2019 12:51:20 -0800
From: Jolly Shah <jolly.shah@xilinx.com>
To: <robh+dt@kernel.org>
Subject: [PATCH 0/2] Rename dt header and move clock binding
Date: Wed, 27 Feb 2019 12:51:08 -0800
Message-ID: <1551300670-6949-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(199004)(189003)(2906002)(26005)(14444005)(9786002)(7696005)(36386004)(36756003)(5660300002)(51416003)(106002)(77096007)(81156014)(81166006)(8676002)(8936002)(50226002)(107886003)(426003)(336012)(44832011)(126002)(486006)(305945005)(476003)(186003)(2616005)(6666004)(72206003)(16586007)(106466001)(356004)(316002)(4326008)(63266004)(478600001)(4744005)(50466002)(2351001)(48376002)(54906003)(47776003)(107986001)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR02MB2267; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com; A:1; MX:1;
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ab44d23-cc99-4a03-5a76-08d69cf558ff
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);
 SRVR:DM5PR02MB2267; 
X-MS-TrafficTypeDiagnostic: DM5PR02MB2267:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1; DM5PR02MB2267;
 20:WON5VEFTOG9P7xO04yIgkCgQDtY/a0WSbdkKTuxyEOS+aWOsF94dCsXgS/gnODNjUpsG1tvIu4jsojTFt3tJ/BulLy+TzMFPQpcfZzL8izz+GmLiTHJxq1OdL6EFOt77fowHd0WNrA1XhbtmKWUe2yG8oEeaNCqYV2jHXa1rMec0FhP5tc+BlYsBg0HRaXfE1BayKOzdiUfj6DtZnuUGUrnHo6U2sOK+o0h4LnVfy9fdfgoa/jHZ7erMXPJbvS/fuyYhGDwQpbujS6aLMKpHtdmnER2elPMt1udb90zXM761daJBn7kDLQnVqE6n+V65ftq0Y5Ji/HsyKPEiD+t0Mk2NjBFHoYuUCyHvSemtEiyX9h9QnFEMO5EDIiDI0tzydj6qO4DktSC/sHpsZf55jDHqeSkmCkrSFEt7qb9XB11Yo4C6OyHCxjt0rpKFJOB0sfSEDxzidT6VYpw/9KGYFsK0LoNqiJL7RhiPB67yhYAQ2pRiWUAQlGxqfRST5N7N
X-Microsoft-Antispam-PRVS: <DM5PR02MB22679A95165199A18F5B1B46B8740@DM5PR02MB2267.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DM5PR02MB2267;
 23:wtWQ37f/KpqXUkZv8bu1bpQGkR4tRRcXiPH0AEhzD?=
 =?us-ascii?Q?r3GLQdwlXmpo2f8n8iRIJnePrba9ULlGUXU+/LLv4yYTLO/ygLshu20mYQgv?=
 =?us-ascii?Q?/3PSCxXouzAf47Zg/4yJ95UVJLAF9XrXDQOgjbQwEqeGOpqLs9JeQQtZtX4g?=
 =?us-ascii?Q?MhNEAH3ClPKQw4g8CEuZUQBeK0Mzobz/LcWkQcJ6ErfNoc8BHbuffnQ76xRm?=
 =?us-ascii?Q?YhF2iOOExx3HHhdje0IQk740JbhOBZsAHUyMbQG5SPpl7/TdLUs6vou/a45T?=
 =?us-ascii?Q?YalAvaymn4PvCAUCFi2j+BdjThI5IZ696VR0+kH4yVZpuj6/id8sxDgdpzRa?=
 =?us-ascii?Q?rByBv5dkxqg1xohiS0km4kIRrEslYVhc8UH01qg2FbPwroMC5rLzb4JXZnVq?=
 =?us-ascii?Q?MaTkKAtjnd4gdMxE5ZujHeErombzkpK1yTFjo3pFnkGbaAWyzNd0Ss6zs+4v?=
 =?us-ascii?Q?AEUm2mHD5CPyUNuiyBXlFZeNxoUFM+Fp6Myzt2TIqrlSv+UBFgjNYHW6BQ6X?=
 =?us-ascii?Q?R1VS5MmqJg8H45oUxeUnfZSsONtC7b427Ty+xF5kAuk7YLiwh1Zgumw2VFHT?=
 =?us-ascii?Q?k999KseWjyrckEtH99xadJAPCzXJ9mJIn8502GwvZPwFhBK1IF4af28Cas68?=
 =?us-ascii?Q?ta1KcqUmyHEAL69C34kKbGuU+BfsmOC4tRKI1TwbmNKaxrywALC8Su3+q5xg?=
 =?us-ascii?Q?2HBms2QZgsbIdOBiN69KiLs536IZ0X4rO9Quti6AOtrNymGzrQQs2ypegc3r?=
 =?us-ascii?Q?kbeXewBbCUIyHnbMr6uOnXshs1736DEL906kjx2fjlCPhZR1chhwACc1ZyD+?=
 =?us-ascii?Q?is+l7nOJtyfBpH5Az8WISvULfPfivchhuGQbj2oJXnkBMSmv5wqBL+/MkmEx?=
 =?us-ascii?Q?eLFyIk/CiGHyY1hqaQAXNzdGFZOwRE/LB3bdu7jQirFqpj3UOEHXruVXJ896?=
 =?us-ascii?Q?YJdJdUUaI41PylBDTYQ2Yu5rC9HHhMx3/5QEz6Idcf7q+MERDdY12p65C6Up?=
 =?us-ascii?Q?iRtXRQJRYdJEnaC0zTTl7CNrNSGM87eMvfpLZGSQMm+veEraSG7ge8dw7/lD?=
 =?us-ascii?Q?csYS+DPKprEFdQn4hKexMuvbtwTl/N4DcwQRghFLZyrXpw7hj49/MTeNxs4t?=
 =?us-ascii?Q?HvGLZCEFHkM5VzsOVUlBVIQNoeutTXn?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gVhHkjqcvyo6Wfvn64eJCdz3tjPicc7feMbMhy9fy1ZKUVaRrrAma7JyBBBmtrY7LfAaXNN8zCxBufxXhTzZiPb+WmiOSvwMFpLtGRLtDcc/6EUnkbiJ+nwHoe86E/mG+FuAFkMKSH4BxXt9mORDzGLSpA/1RLXrKyhfOhcagFo7rmcDx+lj91YthZkzSuqlEXPH+vcIQwpMpMuNkY11YXfTTIgcSzQcqCp/wEXIHlej41/lV7AGRqfc1iYXOCpgXpdG7KJuX92+B5BgmmsOVWaW/oYB626RdApHTQgrXsPRjmrGlQgOwvG6FXX6iHaCIV1X8MWn9W85DdBis6u4xMVVnwkP0TvHKmAwP94fV7zNYBNOevIgB6uJo7cLgldLv2OlHPksmJet5Jb9fc0qYa8c7RV8kw6Ti7FjvaU513Q=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 20:51:29.1032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab44d23-cc99-4a03-5a76-08d69cf558ff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2267
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_125134_236720_867354B2 
X-CRM114-Status: UNSURE (   7.57  )
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
Cc: devicetree@vger.kernel.org, michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org, Jolly Shah <jollys@xilinx.com>,
 rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset renames clock dt include file to align with other incldues.
Other patch moves clock binding to a separate file under clock directory to
align with other firmware child binding documenetation.

Jolly Shah (1):
  include: dt-binding: clock: Rename zynqmp header file

Rajan Vaja (1):
  dt-bindings: xilinx: Separate clock binding from firmware doc

 .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  |  63 +++++++++++
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  54 +--------
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 -------------------
 include/dt-bindings/clock/xlnx-zynqmp-clk.h        | 126 +++++++++++++++++++++
 4 files changed, 190 insertions(+), 169 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
 delete mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
 create mode 100644 include/dt-bindings/clock/xlnx-zynqmp-clk.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
