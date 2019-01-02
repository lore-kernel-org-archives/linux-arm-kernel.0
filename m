Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D08E218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dy2wamrV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KJUcJtiX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="c+AuH1hV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D08E218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=A97bsHlBsTLpc5rVIp69VmUoMOREcpnw94IObVEh7eA=; b=dy2wamrVhEDZWx
	Xymkbh98WnRNLi/WzUvRy4jxgRUpu7+nSnXkakZZDMut7SNr6LgMJT+sRzoTH/MBqF7IJzij8GpLO
	LlN3+OOjHF7aIQPK3Qlvl7ziib2zIaf942Ai60MK7m3O4lznUA9QIzjK2Jeq7T7K5ouSSPSBWp19j
	+DI0rReFwzpAo6TiBZDybAf/hjKw9/YT/st107iYTDKrOJ59jJQne7EJ48WIc4mUZIaSk53wTjO1W
	0SfcvDdl7M8Nj/UikKUWwncCleE4w/EjqeOCRIwPDCZ1Y4Co5H9Dlt1fqH251jIYE+Lwhs6QO63sC
	Ej1zTVLYmTvQsuzzF/Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gegwR-0004qa-Ho; Wed, 02 Jan 2019 13:52:15 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gegwN-0004po-G5
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 13:52:13 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x02Dnh7Z017534
 for <linux-arm-kernel@lists.infradead.org>; Wed, 2 Jan 2019 05:52:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=nHKBODCwPAYjZNahV/8r94IQtjQhh/Y5Vg1K15++gpQ=;
 b=KJUcJtiX0tLoRAPRlkcr8P+ZuBXLqCvqZN5OU9YHm+ZzcIIGceuoDbdtukZiEOm6GVOh
 VeJQNqRKxb3857Jy7pB72WZRNKUT9CJyzlwud6SpRGeDpeBAFsko903XQRGmcj+IMeCi
 b3Ug8+F8uUm2zTFx4Lfi4NDhdvzhE+MyU6Vd9/vb7fWE7MXZPy2uUj5VrrU/gwr2cx3I
 tFVn0FDaKHSfxSTs7y511O3bb8XOpZQBbrX7a0ZW6jkgwWOrgAYmgdM4CG8ZoF2CtV3v
 CC5kBMjMPVe2h96c8/UWoqvDzHxJe3xNUpQN5kC0U1TkmCEipQhvnS4gb2Vdtjgx9rDi 7g== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 2prr4dhsrq-15
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Wed, 02 Jan 2019 05:52:07 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 2 Jan
 2019 05:52:06 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Jan 2019 05:52:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHKBODCwPAYjZNahV/8r94IQtjQhh/Y5Vg1K15++gpQ=;
 b=c+AuH1hVeqL+lnzOTUc7H5BR16d0Afwj32IdX90XcScZjSe1GlFgYoh8Q7IuYYRG5WWYBIK7TuKWcRm2SjHTzyNHDQnlq0svr86WYJ6vcckwceM28O4IpvM0GK2MDKYybMwqOwgF4rezUUTNAxoMyJ98OhjFSP21rWiuplwJ6w4=
Received: from DM6PR18MB2460.namprd18.prod.outlook.com (20.179.104.155) by
 DM6PR18MB2537.namprd18.prod.outlook.com (20.179.105.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 13:52:05 +0000
Received: from DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::3c7d:da4:1834:1b92]) by DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::3c7d:da4:1834:1b92%2]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 13:52:04 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: performance regression of migrate_pages system call
Thread-Topic: performance regression of migrate_pages system call
Thread-Index: AQHUoqJXZ9ZqMomX3kCQrUKUMXNRWA==
Date: Wed, 2 Jan 2019 13:52:04 +0000
Message-ID: <DM6PR18MB2460C36E0501F0ACF9493ADBD98C0@DM6PR18MB2460.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [106.51.106.249]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM6PR18MB2537;
 20:GNinhiVbN6fH30NgDGGPwX13MjXxu9xa4bpI+f1Xg5oUAtnelArryjt4HVsrGF8Tx8xNBBLZEy+4yQbdOy8c8k/QjlYZJhnf4JS1zQLRn94dJGHOwXLoUm/G0/k/Og/UlujCTdUCFzUtQj/cDTnEHmukdKedF/8o+ADI5n6aMcE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(53936002)(81166006)(105586002)(26005)(97736004)(78486014)(9686003)(8676002)(305945005)(99286004)(102836004)(7736002)(81156014)(3846002)(106356001)(55236004)(86362001)(486006)(107886003)(54906003)(71190400001)(4326008)(71200400001)(7696005)(186003)(8936002)(476003)(6116002)(9456002)(256004)(25786009)(6506007)(110136005)(66066001)(316002)(33656002)(68736007)(6436002)(5660300001)(74316002)(55016002)(2501003)(14454004)(2906002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR18MB2537;
 H:DM6PR18MB2460.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-office365-filtering-correlation-id: 6c37ab21-a591-43e5-919d-08d670b97a4d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DM6PR18MB2537; 
x-ms-traffictypediagnostic: DM6PR18MB2537:
x-microsoft-antispam-prvs: <DM6PR18MB2537BEA299897EE443046E55D98C0@DM6PR18MB2537.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:DM6PR18MB2537; BCL:0; PCL:0; RULEID:; SRVR:DM6PR18MB2537; 
x-forefront-prvs: 0905A6B2C7
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tMcbGssOyhHXaL+cOZqyhWQZlwSdCC4Ie4+DbpOHAILpZ8YF5NiD/tEOkqWPejTGa2hXfoutvIDWTffmVIo7uoRTRwqfenWd2D6+PeoNI36weH/3SLEUq77EQb8MZNcSinFDbSCSwA+vnS1omEpXkAs8VxRPQZVs9hvGQSjabBKxt94b9FzD7D6sr/JpCnqbbXuWWbT9n8ZBj1gNdcOrS5UDausW48s8jinob0hJoY/gtIZg7unTvBxjKxuqIsCkNvlmwQ2zBiyX6USo9AQ1MnP1e9YPMCLQRxx2XPE69emMPvy6ELjA/bezkGXnCk0t
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c37ab21-a591-43e5-919d-08d670b97a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 13:52:04.2043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2537
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-02_05:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=587 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901020126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_055212_120787_8DE01D73 
X-CRM114-Status: GOOD (  11.91  )
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
Cc: Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
 Ganapatrao Kulkarni <gkulkarni@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Observed migrate_pages03 of LTP is failing on ARM with v4.19 kernel. Test was 
run on ThunderX2 99xx with 2 sockets. migrate_pages syscall was taking 1+ 
seconds and caused a timeout in the test.

strace output:
<...>
[pid 35146] 14:11:14 migrate_pages(0, 64, [0x0000000000000001], 
[0x0000000000000002]) = 0 <1.099427>
[pid 35146] 14:11:15 migrate_pages(0, 64, [0x0000000000000002], 
[0x0000000000000001]) = 0 <1.145143>
<..>

Git bisect points to following change as the cause of regression.
commit 3b8c9f
arm64: IPI each CPU after invalidating the I-cache for kernel mappings

Regression happens with 4K page size and not with 64K pages.
Please let me know if anyone is experiencing similar issue.

Thanks,
Shijith


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
