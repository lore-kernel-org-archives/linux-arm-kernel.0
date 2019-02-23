Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AC5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:30:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CEF206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TivUj6qn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5fSDOWAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CEF206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Mh2A4axVkmsmmPoev8gf/G+w5q5wNttYu6pReNa3AD4=; b=TivUj6qnWB/ru6
	AAlAymzATH4ShV+PisHSqwCgqyYmF3J/QL8S0EbUWk6lzBcuHGu8gZlImCNO89dC3bpaaqXfPoq7E
	Uwb40E9fzDmUP+dk1TMJW5fvHRYBHF7jERK5rcmWN5l+U0QdXRWaJY7hC2ndNz8amCAo+lajZweAO
	KR03N+IquU9/vNt/R5rYBYxTH8icF/sidr6V6VMFXeouT8wyVGA4fOxq3L0lQOlyvP05EvEAdzBcD
	YzZgd3FS9JIDJwTU/uK/0P5bhuUgi6Gmw6oa09z6VhmNfu0L0iCO68qQdXvrsi+pG6CXG4U30ZXA4
	5Hy4w0yxEu/i2RsbsiiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxdwX-0006QU-Ac; Sat, 23 Feb 2019 20:30:41 +0000
Received: from mail-eopbgr720058.outbound.protection.outlook.com
 ([40.107.72.58] helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxdwT-0006PU-Fb
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 20:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSzeeC+6wwQQir1GUZg/NZYmgto3lAEWG9HR/Yg8dis=;
 b=5fSDOWAtg2iXyqCc119HCGAiL2KR1VmO2/uRXvKm9b4itckgGkuwIXOqrqvihN6Hf4ttIoUfSZbJBg4BueIodDYJsq3AwrovQmJxFm2iCkJAjPw1f3S3nNhV1dlF5f4XLUEyL3vlYCvQG3XFqRMntLXeHdhKyL+A32kPIGf5S+g=
Received: from CY4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:903:18::12)
 by DM2PR02MB1306.namprd02.prod.outlook.com (2a01:111:e400:50c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.19; Sat, 23 Feb
 2019 20:30:32 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CY4PR02CA0002.outlook.office365.com
 (2603:10b6:903:18::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.16 via Frontend
 Transport; Sat, 23 Feb 2019 20:30:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Sat, 23 Feb 2019 20:30:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60973
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <hyun.kwon@xilinx.com>)
 id 1gxdwM-00009p-RR; Sat, 23 Feb 2019 12:30:30 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <hyun.kwon@xilinx.com>)
 id 1gxdwH-0002w8-Jz; Sat, 23 Feb 2019 12:30:25 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1NKUOmL014447; 
 Sat, 23 Feb 2019 12:30:24 -0800
Received: from [172.19.2.244] (helo=xsjhyunkubuntu)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <hyunk@smtp.xilinx.com>)
 id 1gxdwG-0002vl-Ar; Sat, 23 Feb 2019 12:30:24 -0800
Received: by xsjhyunkubuntu (Postfix, from userid 13638)
 id 75B5C2C7382; Sat, 23 Feb 2019 12:28:41 -0800 (PST)
From: Hyun Kwon <hyun.kwon@xilinx.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 0/1] uio: Add dmabuf import ioctl
Date: Sat, 23 Feb 2019 12:28:16 -0800
Message-ID: <1550953697-7288-1-git-send-email-hyun.kwon@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(189003)(199004)(6306002)(48376002)(8936002)(36756003)(6266002)(16586007)(5660300002)(52956003)(42186006)(356004)(6666004)(8676002)(54906003)(50226002)(81156014)(107886003)(103686004)(2906002)(14444005)(305945005)(81166006)(316002)(50466002)(110136005)(4326008)(44832011)(426003)(63266004)(90966002)(106002)(966005)(486006)(2616005)(478600001)(476003)(106466001)(51416003)(126002)(26005)(47776003)(186003)(336012)(107986001)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM2PR02MB1306; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com; MX:1; A:1;
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 123df9b8-0c77-4fbb-4315-08d699cdc1b5
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);
 SRVR:DM2PR02MB1306; 
X-MS-TrafficTypeDiagnostic: DM2PR02MB1306:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1; DM2PR02MB1306;
 20:0pHNo50Oo6KfAkpYbknx/HmedrP+yoBjT0ydEMFHVrmDptfdFbTyNF6MnZRMd3D/U58/O0ML2MnghR7Oio4ivXokO3TOVEfeAyycuD/lu4qHLAEIyUIuDUzylz1o7VRPt7esgCbVO6wxKpS9a3cgaUpzCO/NyKN5Kjcw/eD5Sc89Ck0CML1TPRpayQvEU2ECogDkMCGqcpmbGeM/XpEQNl4vtRQLO7AJJVNrpC2aD41Ah9PS6zlLohvHZfYJ9a4n8bTK4tiu+5VU6bnXwl1iiB/87E/y6srK8U7qJKtrCtQBfnIKqreBvrK7Gd8leKAkU1D72jB9kIJfG1f9rjZmFyUYHeBmMrM3M+YL+t8cwhHs55v0h/wet1hpFMVt9vtgxl38TTzGLv3kXlssDXipBjF7TuppSSKjWFpetudOdX7WuOEQREDE1yrBIq9OQBKziosoYf3dhBlZSP1bsLY2CIkeI+2brmGllAtPgls8XgP6w5Vu9hjW7gRIgtu9zpxu
X-Microsoft-Antispam-PRVS: <DM2PR02MB1306D40C18BF3DBBFD9B604FD6780@DM2PR02MB1306.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0957AD37A0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DM2PR02MB1306;
 23:0QQjLP0if4Hgf06JDkkwV3+kqsQuukDa5RG3MDwc9?=
 =?us-ascii?Q?NODWZXR2hWTOER23bJFQFH9SR+D4o/RuvjyhhQvLA0iO9IdfqRjNE1EcIPfY?=
 =?us-ascii?Q?pDhRfQJGuZsdboFFaMqiOOSARZTCCqeyBG1hGUqKVvzYeE8cBl13IEjr91yZ?=
 =?us-ascii?Q?G+s1GlNAMcMbJmaXHM4XGgfOCzSD+X4TkbpnWE+qGEijSFe693C0qCerkdDY?=
 =?us-ascii?Q?L4fN6ERbb0Jey6ynQKNuFrK/AmRi5bHybVEuicF/rUQBZ0YQ1XsvLiobSX6l?=
 =?us-ascii?Q?F8hxxAgcd/jcvCT7wVzxKZgi65Y8pmNMwB0S5b/7FnZo6MQl8Kq0WptV6kAh?=
 =?us-ascii?Q?a/b42Q7aADjeaY4JQb/3mIao2xpIF/o5380GX9XSDFx0loJGb1/6IAU76nx9?=
 =?us-ascii?Q?/f77xenDOjzequzeJsukkpnXytMJU7z+Z3mpBtBAnn19rrBY5DfPHm6V4E+v?=
 =?us-ascii?Q?9yGLopgI/ob9sOSmCEQqEmMvo6l2Gb4jr7M9GwulT3aIyoJyNGPlzJCH3EOJ?=
 =?us-ascii?Q?zoyt1Os6bZO9vQgu4KjGpP5s8QaCHVZZnZs0XD82YiwFm7kmhwDJuxAWGs/t?=
 =?us-ascii?Q?eDrtvv1/LZiz3Va5AuNZ5GUQ4qDZSuIQFXjA21gLZX8zLNbZfAmK+55bI9Ia?=
 =?us-ascii?Q?74qlv8Q5q1/thLVtnrOowL52h9su1UkLrSSGNPQxboGK0MQEM7rPiDsi6Itk?=
 =?us-ascii?Q?KA1r9n0Cd0q2lrivw5lJund9t4wrxGBfVp6X9RCkt80ckQ1xhkpsxgjL9IYY?=
 =?us-ascii?Q?rFsSm9/w//zvrUcZ6qJXIsRkooAxWWKDQ2x+tCNgGOIxC94gAC0ew68qE+5l?=
 =?us-ascii?Q?r6zh0+z6UHmnbWERpG2+/fI3PXAldtQrplgiRuLoY62c4THvwRCP9ecmMaQK?=
 =?us-ascii?Q?9S+h9ME4gJKxmo4H1jPZaCVgaW2NgnI5lRmadv6W6bQPXNI6CuCwNnNjBRzI?=
 =?us-ascii?Q?oG1WarjyMctzGMcuFw1Nqc/U9XA6lKwW8ZkalRZAnff5kxrfOkC6RMNO84bu?=
 =?us-ascii?Q?W2uhHXgUOi+1CUQxLMAOmojiYelfL+oyCK7a30zbzlVxvAlGSezJUiNrJdyn?=
 =?us-ascii?Q?MfIaUOMaU2CJckWjBJeCFe2fh/M91XDgGy3a8JKIi75aeVJQ+wZn2nPoc/qr?=
 =?us-ascii?Q?K0396OhfFbTAs2lqnQdETs72pVeJMTpukThcztfiyJ4hxa0oEMQUw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: M14tFwuAc8GNSQixj+8P1J+H4Scy7fIHDAI7P5TCz0AKCvLIQBSmZGp0RLBYQTPXOihxgXidrhGMfltBwkyXVEACRlY+B10tS6UG+/XkPRdfzwuQkNV/q3wdAjhaSqY78XrKuiLHHAiNqxFQRkoqqSRm2jrVYCB0EnuLJ7fxSrHvtPBrv2Eew0YlVHLf+GckTfc1BqVm6fP8S9f7NxnxTiiGYB6irGzmpG1LoKESgNwa9W81xiQYMhxnl6jAuQOdnpdIsDhfFiMdEfos2etO98c6OuOjgfafiTICMwmlm5aOlGO6giM76fT21jse162kauQGFrH4kOkKizWXotxadWK6+k7E95mAACkFmNsOX+LjCdR2RZMmwMwuvc3rRKPcO901YFma3CHkc/GHhYupETfoELtEosw2HQbjqpeKk1w=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2019 20:30:31.3298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123df9b8-0c77-4fbb-4315-08d699cdc1b5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB1306
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_123037_569771_FE6FAC25 
X-CRM114-Status: GOOD (  11.57  )
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
Cc: Stefano Stabellini <stefanos@xilinx.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
 Sonal Santan <sonals@xilinx.com>, Cyril Chemparathy <cyrilc@xilinx.com>,
 Michal Simek <michal.simek@xilinx.com>, dri-devel@lists.freedesktop.org,
 Jiaying Liang <jliang@xilinx.com>, linaro-mm-sig@lists.linaro.org,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

I'm looking to enable platform independent device driver stacks on
Linux. Currently, I have some driver built on top of Linux UIO [1],
and possibly there can be more of such drivers: ex, soft IP drivers
programmed on FPGA. Some device includes data movers such as DMA, and
that requires some mechanism to import external buffers and program
the data movers from user space.

Thus this patch set adds a couple of ioctls to import the dmabuf
and return required information back to user. This allows the user
drivers to use dmabuf compatible external buffers: ex, it's tested
with ION allocator.

I'd like to understand if this is right approach which can be used
to develop the user space software stacks further, especially because
- adding new ioctls to generic uio
- security concerns from exposing low level information: dma addr
For example, vfio isn't option as iommu may not be available for
all such devices on all platforms. So any feedback to move forward
would be appreciated.

Thanks,
-hyun

[1] https://patchwork.kernel.org/patch/10774761/

Hyun Kwon (1):
  uio: Add dma-buf import ioctls

 drivers/uio/Makefile         |   2 +-
 drivers/uio/uio.c            |  43 +++++++++
 drivers/uio/uio_dmabuf.c     | 210 +++++++++++++++++++++++++++++++++++++++++++
 drivers/uio/uio_dmabuf.h     |  26 ++++++
 include/uapi/linux/uio/uio.h |  33 +++++++
 5 files changed, 313 insertions(+), 1 deletion(-)
 create mode 100644 drivers/uio/uio_dmabuf.c
 create mode 100644 drivers/uio/uio_dmabuf.h
 create mode 100644 include/uapi/linux/uio/uio.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
