Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CB0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958DE20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gzx4laUB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AWWTGrfF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ByWMMxtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958DE20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ApMjChJEzj5yE5WmEx/pakCVCBW4pmq5Ys8jl1sC7kc=; b=gzx4laUBFTs1v/
	0pu6NryWFbfDXlNWT//+bFPhcHZlXql512hDHn+wrX61qzA+SISDwO6EruiBXv0g+z1u90KVp/odC
	XHUTbm9it2Dmbdvvof8ca6sRBCFB/XHxMwpOry9PTGJN1cOcIPVbKG2kftTVWk+PVYl882esHHuDH
	d6Q+EaWwJsr11LEi2M9MsJSsR6L0ZxI8s7M/sYLJRhsgcSIZrTNnwnxh2C7bdxylGSXaq1p6D/Lme
	pYPDOUldeGM5RsaEMXspXsxUQ1Q5lgKUqP9bYDniBZfeFAD0qNffWVATyYP4YvEyeytr5Z6M4u5Wk
	ajkNZQpzUrtOwWDNg0iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grO26-000753-7p; Wed, 06 Feb 2019 14:18:34 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grO21-00074G-9z
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:18:31 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16EFKn2027963; Wed, 6 Feb 2019 06:18:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=kHSjUBNNJuTILKTJuyUYjZ7KPuE3zKT07jSqhXZGBXk=;
 b=AWWTGrfFvrNW6mf+Gn5nU+56qIf2vlaTQtGwqBLXOpY1whyvQB3MnCNJM0MfqZ+9v+pI
 joMdwUayAs/WKrvP/sicZa0N1eHK48NC6sd2RWvH0H/2HzyBwMYffmjTDDTtFfAsh0BS
 JS7AtfwLFLq/81Q4d1Mn+I60UZGHpxfS/up2O2rQSmbptklwhuWxhiQL4YsfHwF+G4Yr
 XKRuSDuEHLNXfPPFCbwwfAI2+eFU4tpXkFyQQGNiDWlyXsbaJgyHlIPmGEqbBC8KQUAR
 1M0IHA6o0QmRTi+A3ebDkHBgl+1ePRjUBYl4iBumUp6wMOzoYZqPOxZ/j5XC4zUkZSs6 Jw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 2qfc2av80m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 06 Feb 2019 06:18:25 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 06:18:24 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 06:18:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHSjUBNNJuTILKTJuyUYjZ7KPuE3zKT07jSqhXZGBXk=;
 b=ByWMMxtbHUvSU7HixEqQRH8QFcJw6O7gKwAZ53YeYhB5qhKnjNWCDYYHCGEzvL9g2b226MQKlxBYsPTjkgn054lIaIz+08m6KyI+meTOV8fLVKrPJ0hEW/XqMWKgCmLZlZkZhRHpOxZHr9EG32LJzHZ0Lhfq9Ydsf7WK/7pdn5k=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1493.namprd18.prod.outlook.com (10.173.61.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 6 Feb 2019 14:18:19 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 14:18:19 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "rric@kernel.org"
 <rric@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] nic: thunderx: fix communication races betwen VF & PF
Thread-Topic: [PATCH 0/8] nic: thunderx: fix communication races betwen VF & PF
Thread-Index: AQHUvgSpBPe/7KzjM0eW2o3Q0wYXZKXS0ZMA
Date: Wed, 6 Feb 2019 14:18:19 +0000
Message-ID: <20190206141818.GA17226@localhost.localdomain>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1493;
 20:2THooIKTR1qaKgp0/7L6v64p77NH8M3S7PyXAiVJCiq2p7D6bruERJNY9QZwdIqRrBdbGwWi5YfjCHIucW/p5Wd5FObW/gUYF/OhRJZw09gOyh8VcqB+AVPjuamBbO7g8r1YtObBQNSYvs4Bi13MaaskYbmdT2J2Pa/h0pmvr+w=
x-ms-office365-filtering-correlation-id: c47a4cbe-4d88-41e1-061e-08d68c3df1a4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1493; 
x-ms-traffictypediagnostic: CY4PR18MB1493:
x-microsoft-antispam-prvs: <CY4PR18MB149377A442A79ACE00A33190CD6F0@CY4PR18MB1493.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(97736004)(229853002)(6486002)(71190400001)(71200400001)(66066001)(256004)(2501003)(33656002)(478600001)(2906002)(106356001)(14454004)(105586002)(76176011)(8936002)(7736002)(1076003)(26005)(305945005)(33896004)(186003)(316002)(4326008)(11346002)(476003)(486006)(3846002)(6116002)(68736007)(110136005)(99286004)(25786009)(446003)(9686003)(53936002)(6512007)(2201001)(81166006)(81156014)(61506002)(6506007)(6436002)(6246003)(8676002)(86362001)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1493;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h2v72U59AWdH9K2PlB2obrtfO2yOMayGr+/HSe0U2bQq+vFmvIJJW+E89QwBd/BJzbkFWE3asxawlBNJN3v2t0oabHKAaIik5O1uNLEAXYQyVyHbOxRKPQnv07yy2jq8fPkZxewkQ8c5LsqgLHfKnId9FfJKIrFo6UVHw6DD04qDHYjzS33pViebDafERfcbdztWOSaeQe1K/RyU8Ltbi8X/RSapwrS42km8rg/X2s1oSTB0MZ/yDd/l1aWkYZbJUx7Eb7RayuMRc7N1PhHUVX+FMf1eNJI7DdJXbIa5QL1HOEW7TTaQQP00z1IVHkJpHrre1vDSM0wqd+PCbDzWMh5pxObigT2V+TZtx/71jH3h5k/nRMzwLKAiKMxiheZVlMmvOmJfk1ERZ1E9+yTVOorUPuSptnswQ6y4tZ2PAT0=
Content-ID: <0690D04E9EA5794EAD52BDB0DD659DA8@namprd18.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c47a4cbe-4d88-41e1-061e-08d68c3df1a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 14:18:19.2954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1493
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_09:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_061829_765418_E57FFD01 
X-CRM114-Status: GOOD (  17.62  )
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
Cc: "dnelson@redhat.com" <dnelson@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

self-NACK here, some emails get's corrupted for some reasons,
along with some typos found.

sorry for inconvenience.

Vadim

On Wed, Feb 06, 2019 at 10:13:54AM +0000, Vadim Lomovtsev wrote:
> The ThunderX CN88XX NIC Virtual Function driver uses mailbox interface 
> to communicate to physical function driver. Each of VF has it's own pair
> of mailbox registers to read from and write to. The mailbox registers
> has no protection from possible races, so it has to be implemented
> at software side.
> 
> After long term testing by loop of 'ip link set <ifname> up/down'
> command it was found that there are two possible scenarios when
> race condition appears:
>  1. VF receives link change message from PF and VF send RX mode
> configuration message to PF in the same time from separate thread.
>  2. PF receives RX mode configuration from VF and in the same time,
> in separate thread PF detects link status change and sends appropriate
> message to particular VF.
> 
> Both cases leads to mailbox data to be rewritten, NIC VF messaging control
> data to be updated incorrectly and communication sequence gets broken.
> 
> This patch series is to address race condition with VF & PF communication.
> 
> Vadim Lomovtsev (8):
>   net: thunderx: correct typo in macro name
>   net: thunderx: replace global nicvf_rx_mode_wq work queue for all VFs
>     to private for each of them.
>   net: thunderx: make CFG_DONE message to run through generic send-ack
>     sequence
>   net: thunderx: add nicvf_send_msg_to_pf result check for
>     set_rx_mode_task
>   net: thunderx: rework xcast message structure to make it fit into 64
>     bit
>   net: thunderx: add mutex to protect mailbox from concurrent calls for
>     same VF
>   net: thunderx: implement helpers to read mailbox IRQ status
>   net: thunderx: check status of mailbox IRQ before sending a message
> 
>  drivers/net/ethernet/cavium/thunder/nic.h     | 12 +--
>  .../net/ethernet/cavium/thunder/nic_main.c    | 58 +++++++------
>  .../net/ethernet/cavium/thunder/nicvf_main.c  | 82 +++++++++++++------
>  .../ethernet/cavium/thunder/nicvf_queues.c    | 14 ++++
>  .../ethernet/cavium/thunder/nicvf_queues.h    |  1 +
>  .../net/ethernet/cavium/thunder/thunder_bgx.c |  2 +-
>  .../net/ethernet/cavium/thunder/thunder_bgx.h |  2 +-
>  7 files changed, 112 insertions(+), 59 deletions(-)
> 
> -- 
> 2.17.2
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
