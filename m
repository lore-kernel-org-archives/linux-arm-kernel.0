Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A09C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:45:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEEB20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UszDi0R4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Jqd52adI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="qyI3VM82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEEB20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=txhImTekqodGCkgfaHwsj5ahEgfK+aLFilqwpRZEKlE=; b=UszDi0R4v5k6QK
	IdzGRYvCzhKoKuphRMdwJQ8Kvz+KFIYCkkVsV0R61UvsSzOkcMUG+umka77p/L+cNpSRS+HcTx0hq
	horBHOn6RNZ8oAghGhE9SqB5tqc15cAZ8SwtQPA5NchWnTACXs1iHEAiQak0ZKdkfMlBISY6pDP9x
	1hHFvYluDiDBsypYjkQVwuEgi5Y0qinrIZJMZ26nQmFJpTPpjSChxv4HKgd5ICoxVgDOk4SRhnNrQ
	QfAysuXMq3c9NnXqazjB2M57k7ohBlq0rbinYrop+7rE+e2V4P4rdmBWdEuSSPEgHi673u6dmyYke
	waPOLBTJxZaBitP+nkww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggQWv-0004gd-1P; Mon, 07 Jan 2019 08:45:05 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggQWq-0004Hl-6R
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 08:45:03 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x078e8dW010404; Mon, 7 Jan 2019 00:44:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=3bS2OvzErYPW4uiJK+YvUo1YMJs4k1AWYuXUTlW4kaE=;
 b=Jqd52adIAcNisUEYURbqRYq1ZfKeTe46tm26s9eEfFnIgfxs8VT+MBFkzKym2pVkfzFY
 gjQw2TkBdQKnsMTsZCkp36f6wEsBjtOwX4ZeGL4SOgG/3qSJL079VqLTchcpEYVPJqNJ
 iii3IeSQTiGnlyr9aJS3apYUbGH92DL/iV7UeYotvPwd/4/72c7/IoyD3SSmpRg+++TX
 mxpiHM06GInTZUJDh4i25hvHU2ayKVzmPt2pYuWFcuYXQNcuC73k7Z/eZWRFmdHuBG2+
 PikG9wKz2GFJ/BcYlZDLfzeuvDOpjE0EUS2xggVoPyPiVKWSYP/9PAA2wpax4NQfKrZt Mw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 2ptvypdhtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 07 Jan 2019 00:44:50 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 7 Jan
 2019 00:44:49 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.52) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Jan 2019 00:44:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bS2OvzErYPW4uiJK+YvUo1YMJs4k1AWYuXUTlW4kaE=;
 b=qyI3VM82p2hk5vgWmoYIJ0S9N2oivvb2Lqi/sItkOGxcGSeXpgf5vlTfW9Ppfd5umDGgP5WP/fs+JVHJYtuoxJ3en/aFQysVK/qWZuhx/6KNw61JiFICU2ooVXQA8LA7Oq5LQMc5Ai9f25ZzBxXX34wIdcTOwMH+E0yEE9Bx/H0=
Received: from DM6PR18MB2460.namprd18.prod.outlook.com (20.179.104.155) by
 DM6PR18MB2940.namprd18.prod.outlook.com (20.179.52.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 08:44:48 +0000
Received: from DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::3c7d:da4:1834:1b92]) by DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::3c7d:da4:1834:1b92%2]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 08:44:47 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: "will.deacon@arm.com" <will.deacon@arm.com>
Subject: Re: performance regression of migrate_pages system call
Thread-Topic: performance regression of migrate_pages system call
Thread-Index: AQHUoqJXZ9ZqMomX3kCQrUKUMXNRWA==
Date: Mon, 7 Jan 2019 08:44:47 +0000
Message-ID: <DM6PR18MB2460B4DD47FA23A0F091B351D9890@DM6PR18MB2460.namprd18.prod.outlook.com>
References: <DM6PR18MB2460C36E0501F0ACF9493ADBD98C0@DM6PR18MB2460.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM6PR18MB2940;
 20:ls9DDYp+YCmJ0Xd/ub80qH5cYS7vvqo3DSVD/M/PFvBlC1mfQGh2ZQFXpOZUnXVjnpGJbGdtH2EtgO5j4fKGL8+lwa9JJ8m03a8dax0o8QKvZhl4iTypDzL3ohQR5Sa11dtvDCmJ8kuecIG6vIwvGkIgo16k3lX1aHkJjxFo/KQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(6116002)(5660300001)(2501003)(486006)(476003)(478600001)(2906002)(9686003)(316002)(3846002)(6306002)(76176011)(68736007)(14454004)(305945005)(6916009)(7696005)(966005)(54906003)(26005)(8936002)(102836004)(53546011)(6506007)(229853002)(7736002)(6246003)(55016002)(78486014)(5640700003)(6436002)(446003)(8676002)(81166006)(186003)(81156014)(86362001)(53936002)(25786009)(4326008)(74316002)(99286004)(33656002)(71200400001)(66066001)(2351001)(97736004)(256004)(105586002)(71190400001)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR18MB2940;
 H:DM6PR18MB2460.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-office365-filtering-correlation-id: 9f1ae751-8e05-4f38-e804-08d6747c6147
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:DM6PR18MB2940; 
x-ms-traffictypediagnostic: DM6PR18MB2940:
x-microsoft-antispam-prvs: <DM6PR18MB2940456BD7032BF12438F340D9890@DM6PR18MB2940.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(4982022)(52105112)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:DM6PR18MB2940; BCL:0; PCL:0; RULEID:; SRVR:DM6PR18MB2940; 
x-forefront-prvs: 0910AAF391
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LMa+HuCpDHLQ0u7+4xY+1/C7GHi65ZrUnGrEGIcWK+epoLZq4jKQX3THG16X6MSlvsq3MkLlCSqkNb68QY44RV9+i8RM81SqXCOyFumw+wiSxUAK5p2O3jX7OJFB9OoP3wNJeX6+3csBIE5psmQAXOAgZ/FO1/UoOVJ4E+hIdQz5Gs/X25YfaN941H7z36YnyYp4BIi70q6SikUcck+J8VDeGdZDnqEeS3l7gAjVLNR1wdAB3g6wqi6JatM0C5bJlEo4+jvPbRzpuVKtdPUAsotIZ8Z+0ZpoSWh/hWAx28nALd5ehPodFeiy34rFkYzF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1ae751-8e05-4f38-e804-08d6747c6147
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 08:44:47.5435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2940
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-07_03:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_004500_848737_871CC143 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
 Ganapatrao Kulkarni <gkulkarni@marvell.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On 01/02/2019 07:22 PM, Shijith Thotton wrote:
> Observed migrate_pages03 of LTP is failing on ARM with v4.19 kernel. Test was
> run on ThunderX2 99xx with 2 sockets. migrate_pages syscall was taking 1+
> seconds and caused a timeout in the test.
> 
> strace output:
> <...>
> [pid 35146] 14:11:14 migrate_pages(0, 64, [0x0000000000000001],
> [0x0000000000000002]) = 0 <1.099427>
> [pid 35146] 14:11:15 migrate_pages(0, 64, [0x0000000000000002],
> [0x0000000000000001]) = 0 <1.145143>
> <..>
> 
> Git bisect points to following change as the cause of regression.
> commit 3b8c9f
> arm64: IPI each CPU after invalidating the I-cache for kernel mappings
> 
> Regression happens with 4K page size and not with 64K pages.
> Please let me know if anyone is experiencing similar issue.
> 

Please comment if a solution like below (by modifying sync_icache_aliases) is 
possible for fixing the regression.
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/618866.html

Function trace:
migrate_pages()
   + unmap_and_move()
     + __unmap_and_move()
       + remove_migration_ptes()
         + set_pte_at()
           + __sync_icache_dcache()
             + sync_icache_aliases()
               + flush_icache_range()
                 + kick_all_cpus_sync()

Thanks,
Shijith



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
