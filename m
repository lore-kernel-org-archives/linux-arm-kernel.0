Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8941DC3E8A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3616D218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UEokkhEq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="tLjJ9SuK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="CK5NcKgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3616D218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4u71U4siyD7WTPQjetlOC609WMeaDa1wKXn5TpyQcWc=; b=UEokkhEqdFUyuP
	Jo4pOPfgAUY69C2mmx2vKMeB3b9bSpPJUO9J12r8/M2wJ6ZjuHt05XH09d8mMRGeTgs8qx1ITdeEY
	eJmoD5IhL0KUN9hrq/KUZgawYA5qLS0vdFDBnsQ+U1aQlGU4f0aIF6D90dZGoIe7eFooC/aMoDsUh
	wQ8gLrI8rWoLEGSEIXeThW4Ipl+L546M+DvTqxaNXf+wRKe4eq3kJVkd9xlZdTv86fD/5x+4RapK3
	gnKTtWm7NiIAKcqpgdLOsiTFJPjh3TFMiIqq2wisiA0gpZMi69IhxgJD56eCO66IqHok/TeJzKh/6
	7QrrLiwSw1igYxtAwhYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKDi-0007Pa-I6; Wed, 06 Feb 2019 10:14:18 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKDQ-0007Dx-TT
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:14:02 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16AAYJX017293; Wed, 6 Feb 2019 02:13:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=csOV2YYllGnDEBjH6hltxvx7y2V5CyHuh4TXDE3z1BQ=;
 b=tLjJ9SuKNZPIZMdt+XrQvx7n0X52lxPxIHz3ud/+GaYQiC7nyKmzC6NLp1ZhYryarssp
 vJ5YTcfn0UHN5H0Sr4/H8reHBxRjnK6mig1PC5B/0x71uEVa4Lx/zY4oYm2zvBq1WQPv
 PLQFmFJZORlnWdru7iEM7b9xijF2g4HFlqgnUPodTAeDZ2RC7ILGjnM1FxN5jK9RNdQM
 STBwWmOCWrdAuitncNOx4+NrWAal3yogLoDYxlGeHlgDuNnURG6o8kVCg8hKnvzWY7t8
 qC3YiBGlCINw9MB7HXDii+wVmhCibhfoYhFTOSkHM+NNViDymMyL1cRyLYPf+su2ljye UQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 2qfc2augun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 06 Feb 2019 02:13:56 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:13:55 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:13:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csOV2YYllGnDEBjH6hltxvx7y2V5CyHuh4TXDE3z1BQ=;
 b=CK5NcKgQyGdPfbKSD5VvOZXETHO0Ef7nXJrzz8o16fgEAFtW/fPTJIxs3Qg9RzKiIP1fqjsPa13vMRbtuOLlCMwK/eZkvOtGaf0liwxiJ1bxAHHJNDgm2J9g2tt2nSjm+UJzNH0vfvqFZ5ul3afrh+iKhngwgZ8n4uBH9pScXI4=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:13:54 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:13:54 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "rric@kernel.org"
 <rric@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] nic: thunderx: fix communication races betwen VF & PF
Thread-Topic: [PATCH 0/8] nic: thunderx: fix communication races betwen VF & PF
Thread-Index: AQHUvgSpBPe/7KzjM0eW2o3Q0wYXZA==
Date: Wed, 6 Feb 2019 10:13:54 +0000
Message-ID: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1238;
 20:/v4q5bDUNlnczPANFdLqa5oAoj5yxSf7KI9ot7uPI9/vJUuVPIjUJh0tu1tro3q93MYvyDR6gD3MzZpbq38W73uFIvdqc6tIfvZ7t2bd8fdmNKmsI5UXMKksHwS7EZEllQCp4fXD2NHqwiJbWvLFIBmbFYN+esmQ0/Y5A3kSKpg=
x-ms-office365-filtering-correlation-id: c5f4d21c-6c8c-4de0-eea1-08d68c1bcc88
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1238; 
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB1238ACA897A257BAEC0ADD1DCD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(107886003)(54906003)(110136005)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(6486002)(2906002)(476003)(25786009)(2616005)(53936002)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1238;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jf9YHk1zv+F9wbTRgCYKqWaW7lCrn6ePSGGpbZCA6MgHI2o3tCdG7dGEN6Z6rhgIugohfuSAkkDqU2wFQcl0fDqCPTLl1wrERPElLSbRZGHyxvjFgg2CT1MRrq5UcuUMGmmEgKUlaRJaudjxbZgRHyG87+lHJPhz9Eew+Ww820XMFuEZn6MKNOVoTTUIQseinFwc78oOWOhQUuFH8WNag1eQP4bselOFu0FbsX+QwaFUUOwvRSylLnvcnMddureWD5VQb27xeZa5oZEmbmqPKEwy73zkzlz4kpi2VLmCnvxJXg57o4RaZBkzd6CdlMSJwrNDvVo9FIRPzRb4tueyZ/nccCATYS+9yYbuDrkhzmjpB4O7J4krhy8JzMbyT8HKU5huJLwsOglBTcczMWArCCCqa6c2sG1+q8+mvqRu8Ds=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f4d21c-6c8c-4de0-eea1-08d68c1bcc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:54.2204 (UTC)
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
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=662 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_021401_059604_74B996CB 
X-CRM114-Status: GOOD (  12.35  )
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

The ThunderX CN88XX NIC Virtual Function driver uses mailbox interface 
to communicate to physical function driver. Each of VF has it's own pair
of mailbox registers to read from and write to. The mailbox registers
has no protection from possible races, so it has to be implemented
at software side.

After long term testing by loop of 'ip link set <ifname> up/down'
command it was found that there are two possible scenarios when
race condition appears:
 1. VF receives link change message from PF and VF send RX mode
configuration message to PF in the same time from separate thread.
 2. PF receives RX mode configuration from VF and in the same time,
in separate thread PF detects link status change and sends appropriate
message to particular VF.

Both cases leads to mailbox data to be rewritten, NIC VF messaging control
data to be updated incorrectly and communication sequence gets broken.

This patch series is to address race condition with VF & PF communication.

Vadim Lomovtsev (8):
  net: thunderx: correct typo in macro name
  net: thunderx: replace global nicvf_rx_mode_wq work queue for all VFs
    to private for each of them.
  net: thunderx: make CFG_DONE message to run through generic send-ack
    sequence
  net: thunderx: add nicvf_send_msg_to_pf result check for
    set_rx_mode_task
  net: thunderx: rework xcast message structure to make it fit into 64
    bit
  net: thunderx: add mutex to protect mailbox from concurrent calls for
    same VF
  net: thunderx: implement helpers to read mailbox IRQ status
  net: thunderx: check status of mailbox IRQ before sending a message

 drivers/net/ethernet/cavium/thunder/nic.h     | 12 +--
 .../net/ethernet/cavium/thunder/nic_main.c    | 58 +++++++------
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 82 +++++++++++++------
 .../ethernet/cavium/thunder/nicvf_queues.c    | 14 ++++
 .../ethernet/cavium/thunder/nicvf_queues.h    |  1 +
 .../net/ethernet/cavium/thunder/thunder_bgx.c |  2 +-
 .../net/ethernet/cavium/thunder/thunder_bgx.h |  2 +-
 7 files changed, 112 insertions(+), 59 deletions(-)

-- 
2.17.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
