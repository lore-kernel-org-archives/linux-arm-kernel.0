Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDD2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:54:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D050217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IcT6Pmdn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQAW03xH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D050217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3gFIErGEEnXg+TWVZ1tsydJ+6uOI9fZ7IKlR2AYU+zA=; b=IcT6PmdnxW9iYN
	zU15gZBrtv3xXK4g6WjB9qup5cV4hC0JAK4VBpH3fmaksOJYs1wP38SBPhUNHy21fO4syRMyEVesq
	jkduSxkklk/epT5G6m+P1wAIRkjbzyvdSTBCvBg6aXswazbY+INazpiZTDL8Lf8EvI6Ze4Uy2JKsi
	deVKv9WmbFI2FKmIrXiTQZKvwTerQVU+/NC5oG576I7zJCKJhHeBtnVJyKOkSedCRsk6KJ0Am8xr9
	5lpGXnfFrfCoK+O7HCNCRN7Lpo7h61oVNFtRgZQwXhDOI7m4/oNfjZsDbcUFFEfTenhbbahfDw+Qw
	+VVzuUV4mSVrnZ6ZGIgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZB9T-0006pI-Kn; Tue, 18 Dec 2018 08:54:55 +0000
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZB9P-0006ns-OK
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:54:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeDFsE9MzEXWYxTH886l0FwATo2KAS3kZrunXM5qgnk=;
 b=WQAW03xHpuWTAUZCr7JbsS00CX2CbaQRQiMSsSAH4Myw6376Bl6/C5ZO6J1gE73A3Xo/yMRsfjvo+Ar524Zg6p5pb0b1Fz5FB54tVcO+RZ40D8lTwSsHg1Mp5OXXunkIofPnyXI+oSDuqjk2YY17ivCp10ahRc04SPhCpqAB5Ts=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Tue, 18 Dec 2018 08:54:37 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5%2]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 08:54:36 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Thread-Topic: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Thread-Index: AQHUlqsEL0ralr2LcEeLxz6y6GsB66WEMUIA
Date: Tue, 18 Dec 2018 08:54:36 +0000
Message-ID: <9ba5927dd322732b73f1fa0852ec20fdf918ba7b.camel@nxp.com>
References: <20181218082329.GB440@kadam>
In-Reply-To: <20181218082329.GB440@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB3247;
 6:L3PFK0zdamQawAfGhwVYIMDLb1bkDLbqGnXVAdWrWKFlGBDngcwT66pfZPuMAQxJOz1E8xiNgGm+lVAj0odxlj4zqI8mcytvAECcOTCkNFVUBpOhTXjEDyCqZgID5EEDv/GpmV8sqmxnEyHuMqEV2PeK2Ectpb2GrpvyrakMFZGb11kJdVnRDaPRxUUw0jkWQgQu2MDgY/ROB8bNS9Jrt5PzYTKd0ublI8/g9xz69bfp97s7dAV39i6nnh7BI20tsntMLYWAtqBJ/e/aBrSkJNj1nv1x+hWXrYjf7wTD5aOVB80D1/dSDqxCMqGH9+hSlfojRdcEXH8qWcgkLIC2uqbjTSNHL+oDUOo+VtWJf2GT8+NreoqB4SIndYDEyhXKLfWhR8D3x976dn2O/bE+lF2Cvksl1UOO5PMu4oQc2YHoWU1jM6rF2eM6rc0hFuSp0bPAQ6Ju9n6CAZha0ICvpw==;
 5:6LjoPFTrfD9K6E1pCaCOxUa7BhX9RHBLzpJIAXF8JB01O/Sax0sun2M1MpRwbHwEMwYamTmKsP4I1KG76UzpyZJX145nvevSxCSkDLIfj+th41JocexsoFq0hRSNFpQ8ENVIxq0/Z8BolrnnW6dt2Z0FFtrTxgCV4+KYxJLW07E=;
 7:Fc73ggdKH8iVqMM6vidnbdGNbavQknTm3pAxGBhi0sc9bFs1+DyB+y03n4k8lgDhkycWP7VL5TkwEk7kPjKI2TBo7V7egRMD9gEm6OO6fp+IMEbNC+DvrGgZHDS2yHIfehC4bGMdH0PAQ3CmlPM3jA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 407e27a0-19a8-4d43-3759-08d664c67039
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB3247; 
x-ms-traffictypediagnostic: VI1PR04MB3247:
x-microsoft-antispam-prvs: <VI1PR04MB32478BBFA6420664E68B7294EEBD0@VI1PR04MB3247.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB3247; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB3247; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(199004)(189003)(256004)(26005)(476003)(97736004)(66066001)(110136005)(118296001)(5660300001)(11346002)(54906003)(2616005)(2906002)(316002)(446003)(102836004)(76176011)(6506007)(7736002)(4001150100001)(486006)(478600001)(186003)(99286004)(2501003)(81166006)(81156014)(8936002)(44832011)(8676002)(4326008)(305945005)(25786009)(6246003)(14454004)(68736007)(36756003)(6486002)(6512007)(86362001)(6436002)(106356001)(105586002)(229853002)(71190400001)(6116002)(53936002)(71200400001)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3247;
 H:VI1PR04MB5533.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2iclC2E9h5JqERGMmVMeyd3idZeaTTnAomDgS+1xvinDHFQrwOsZ+rdslMM/IimjZLjtM6n4Fs31rDPY/8lH3cZ9Qz89FrkO9anbnGEaguPugbxJWXPQ0wf6VlAnmOfR3etqOdT+66RpHCIZEeX8pKfPBGNaU5DcnwUW6m4OvKXbIyqEhfrCUMB+Agg/KGfQ0yun4VzYMHJCxYSn4BefUUyAvxvpXDltHARYVtfDQ3t7WXBsfcSi9WQ0yfyT4BKeKfg12kvh2K6amyx6bSI++flSj3EVAl9QIICjHAongR2AON4MxyckUX39WW6UsZdY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <DDA3C0846313CB4A995BA11C6D3EDF86@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407e27a0-19a8-4d43-3759-08d664c67039
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 08:54:36.7373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3247
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_005451_793098_8B214A9F 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-18 at 11:23 +0300, Dan Carpenter wrote:
> The device_link_add() function doesn't return error pointers, it returns
> NULL if there is an error.
> 
> Fixes: 7a6991159bcd ("PCI: imx: Add multi-pd support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>

I assume this was found with a static checker?
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
