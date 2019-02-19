Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF42C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:21:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4D9208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qcwzsgkt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hhvtwbYE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Sr8w1q22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4D9208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eCPqUC8lySFp3nOpERWgg92wlkh0Eka6u1hWvvt917Q=; b=Qcwzsgktxtgm1l
	yoNy2arIIAFlYQ7Z/X2PuJHr2n1Yqn053fEr5VH2lIKvbXZocrcDOLcDdVzUazqumYszoXlXsDy/5
	jiJ5o57R6te3mLWO7q2mrZn9wMyU1SoGvB3XqXtE5N2TSACMZUjxjYt64nN4b4sL7dZrcsy1NbC9O
	pSA4IJO0rtkBpsDFyJd09smh2+qzBP1gq9WVTk90d4Ze3pr7Y6OkZn5k6ohWncXzy18qV3CApDDuv
	MsNXUthLmpBUftZL3u/x89qJq52Qha+cK5QOeW+f/bUxBlzPrbyOiumqkAK9Q8oltrMxIHaYMM1vK
	L74VbTJ873Q44T9XVhyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw3T0-00007l-4V; Tue, 19 Feb 2019 11:21:38 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw3Sv-00007P-Ma
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 11:21:36 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1JBK8cp020614; Tue, 19 Feb 2019 03:21:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Eid2AJCf1ss3QJ40lsbNJ6EdDY535K9ksqjVZ2u/7tk=;
 b=hhvtwbYEbz6OdbuN2lqHtAk+s4DnTkGvIR19YVodw3cTWEmkTFbwE+6mNs3SyPsf5IiY
 UXth47EHlQoSJJo5BSvulnz+xLTLxOTCiEbPncv1uAzzzfYsBgrwRaj1SdSz9b+Yt5RG
 5/OgKkNuDJadt8DFJHZwkBBFuwM7mBR4FM16/oGD1EbZKqst7Sr3XstLpcUTJzEpjLY9
 F2XxDb13r+FNwdXnjACVr7zYsGXJhi2+Wk9zznnT+PCG3pZ6Ump1WVRBArNvzz40HSI5
 ZyA7yLvx6c3BauOtuESEfRUQtPGeZd9aRBLzOiy8QysLJCU3ZlybIV1vdmlNX0xYltNd Ng== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 2qre18rjag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 19 Feb 2019 03:21:27 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 19 Feb
 2019 03:21:26 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Feb 2019 03:21:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eid2AJCf1ss3QJ40lsbNJ6EdDY535K9ksqjVZ2u/7tk=;
 b=Sr8w1q22Yko03+jjpZgqL8fob2I1IsQAbE+eCQE+JSaE3RH1VLCNaV7I7ILAI3dE3NrDHRU9iJxDcUUbBnhLlraba9mVqvUpfqX/XhDj5xo34HoHLt9PteHBtAPqgfvw9OmaV7NNIbYb+VcoqASrgvuDbRan33PtUL2/f6mKL9w=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB1447.namprd18.prod.outlook.com (10.172.176.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 11:21:25 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 11:21:25 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [EXT] Re: [PATCH v2 3/8] net: thunderx: make CFG_DONE message to
 run through generic send-ack sequence
Thread-Topic: [EXT] Re: [PATCH v2 3/8] net: thunderx: make CFG_DONE message to
 run through generic send-ack sequence
Thread-Index: AQHUx2+gF6zWP2JT70e1Q1SDCmWuPqXmNb4AgADF4QA=
Date: Tue, 19 Feb 2019 11:21:25 +0000
Message-ID: <20190219112124.GA5637@localhost.localdomain>
References: <20190218095159.3847-1-vlomovtsev@marvell.com>
 <20190218095159.3847-4-vlomovtsev@marvell.com>
 <20190218.153310.393264778478086662.davem@davemloft.net>
In-Reply-To: <20190218.153310.393264778478086662.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2d351cf-44f3-44e7-3a67-08d6965c62a3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1447; 
x-ms-traffictypediagnostic: CY4PR18MB1447:
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1447;
 20:rCOjgNlWiqb42Vcpy5KeFhzA454BoQ0szBpiBT+xCnJ6/xBE+d/cZ2omQge4pmMquYGzzOwcyOAljvkboKeDezkSZUVO586VQO0OwSklFzH/DcR19EMhOEvmTkbZXKuYvOZybTeT/OzAKn/z+n1x2S09VvMfUOaWuUJHuucYmOA=
x-microsoft-antispam-prvs: <CY4PR18MB1447DE0688634E7BDF15B5E2CD7C0@CY4PR18MB1447.namprd18.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(51744003)(189003)(199004)(8936002)(81156014)(81166006)(8676002)(71190400001)(71200400001)(105586002)(6916009)(68736007)(106356001)(33656002)(15650500001)(53936002)(2906002)(6436002)(316002)(476003)(6246003)(26005)(6512007)(9686003)(186003)(486006)(54906003)(7736002)(478600001)(76176011)(5660300002)(3846002)(99286004)(11346002)(446003)(61506002)(229853002)(66066001)(6486002)(14454004)(25786009)(305945005)(86362001)(14444005)(97736004)(6116002)(33896004)(6506007)(1076003)(4326008)(107886003)(102836004)(256004)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1447;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aBFjdU9xUeW4P6MfqstXUrhMYGNlBmM6+5KctO22FjiA8GSTa0UhNGgqoZnTjXiVduQr7kqJi3hhtXH4pssXEEGbHURu1GTVOX0j4+Yel0pB0Rw/ZE3NqV2pHZUydxslTNzCUEJpPr80P0oO/YfOJp1hO34NVQGm2VuDm4Pb9tPeRNo8mcYNWaPHnT3e44rFwiBKFfUYDnopbUtX8RGaUeof3V9MAeQ2l69SknjLWxqi666L7COKklbljIC0cf54rk5jfie7bc1LW0lox0P0DQH54tTD8w1YwTZBXOyTbpISKOruypkzBRWN7uE5bO0JBJhHUXLcqPGCXurDrNPQc2kMbP55YOmJkJcvaFzmfeYcY52jgEatunmiDXRY2s9wWoPUnSreuagXQm0svDK9WXF+9ALMH90yw1K1xFtlFyA=
Content-ID: <4D9BED71F59D8240920C7657BDD8FDC9@namprd18.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d351cf-44f3-44e7-3a67-08d6965c62a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 11:21:25.3734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-19_07:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=784 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_032134_350945_43F79EB4 
X-CRM114-Status: GOOD (  18.30  )
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
Cc: Vadim Lomovtsev <vlomovtsev@marvell.com>,
 "rric@kernel.org" <rric@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dnelson@redhat.com" <dnelson@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sgoutham@cavium.com" <sgoutham@cavium.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

On Mon, Feb 18, 2019 at 03:33:10PM -0800, David Miller wrote:
> From: Vadim Lomovtsev <vlomovtsev@marvell.com>
> Date: Mon, 18 Feb 2019 09:52:14 +0000
> 
> > @@ -169,6 +169,20 @@ static int nicvf_check_pf_ready(struct nicvf *nic)
> >  	return 1;
> >  }
> >  
> > +static int nicvf_send_cfg_done(struct nicvf *nic)
> > +{
> > +	union nic_mbx mbx = {};
> > +
> > +	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
> > +	if (nicvf_send_msg_to_pf(nic, &mbx)) {
> > +		netdev_err(nic->netdev,
> > +			   "PF didn't respond to CFG DONE msg\n");
> > +		return 0;
> > +	}
> > +
> > +	return 1;
> > +}
>  ...
> > @@ -1515,8 +1528,7 @@ int nicvf_open(struct net_device *netdev)
> >  		nicvf_enable_intr(nic, NICVF_INTR_RBDR, qidx);
> >  
> >  	/* Send VF config done msg to PF */
> > -	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
> > -	nicvf_write_to_mbx(nic, &mbx);
> > +	nicvf_send_cfg_done(nic);
> 
> If the one and only call site doesn't even bother to check the return
> value, just make it return void.
> 
> Thanks.

Thank you for your time and comments.
I'll update patch and re-submit.

WBR,
Vadim
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
