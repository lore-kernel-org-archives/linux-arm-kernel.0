Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC90C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:24:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4755A20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MKkMH/Ww";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O4+tcsjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4755A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YVV6Mblm5epMP9hx2vOsS+LJqNnY2KY5kENdF3PmBcI=; b=MKkMH/WwBkRsOk
	J4ENkSh7/O6NjexmQ/e+c5HidGJJmXEbkUIx0sqOXQAB9ZiWt5ONEkTmlGkBBWoa1akfIcj1gP8Y5
	xjMMuh42ISn2pIhNfEF80D43WQKLuR91nANrd9BcUseB27uECyXZElFBp75FqOZrYm1yKZHN7new9
	kewCdHU65mIAewiUaKSZr5zSqUBz0hH2GFy0orQ53He/uBVbHQ7AH1eIxA6FLQKKb3UvYEarSw+O5
	rJgBB/bzYZliO76qdHEBFrwlRpEuXtwoO1xAGEHg+ajSGYnSKvRaoL2E9oT6BjD2+V21UtxZDeELY
	i0MC/0r/wJhjml03AbGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gisrL-0007YA-EX; Mon, 14 Jan 2019 03:24:19 +0000
Received: from mail-am5eur02on0605.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::605]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gisrI-0007Xc-CT
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 03:24:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYTVyccfW0npiaqefmvmHkZ2gYRT+pRX6ff1PEnpN3c=;
 b=O4+tcsjfVxeMHHXXTq1EPsMLgMrkppM78Dp/HWpSXEoZmulGCgD6JbqbD8n2To4gTMoa53X+ZUSkaUP8G9pHCmfFS1RFaZ+NVXb4NQayVjWz1A3B+OsA8o/k/Ur/tEp+8Po9touaji3CfGfg0mD1jjLogwlI/hI+6AFrxEB6fPk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5299.eurprd04.prod.outlook.com (20.177.42.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 03:24:12 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 03:24:12 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH V6 4/4] defconfig: arm64: add imx8qxp support
Thread-Topic: [PATCH V6 4/4] defconfig: arm64: add imx8qxp support
Thread-Index: AQHUqaINQb4f2cB3o0SMLCWYwIJ5AKWt+/AAgAAh2DA=
Date: Mon, 14 Jan 2019 03:24:12 +0000
Message-ID: <AM0PR04MB42115C5B0866D23F1F171DC480800@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
 <1547206279-26169-5-git-send-email-aisheng.dong@nxp.com>
 <20190114012223.GD15371@dragon>
In-Reply-To: <20190114012223.GD15371@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5299;
 6:CUrNoE8jRYhyplTRrarfT+4vI1EvE1sWPzscrsTH6i733fb+vNVq2q7xEaBh1yEXP4f5utF5p0SCQuk3ToDPXerlFc6UUA15GdMjo6qgPufEVk0DGKOhFQuAM3+9v5m5wb3jJP1V5Zin6wUkxEsdYWGA/5f4dWYLp8c+gsanB2BKiIfjJXf7l1qM7sEo7fi+zvP/Yrh7e9alXEjZnUyH96qCVcyHVJitEf+CPzyVCCZ/4VBKFrnrhd8DKikOOn4nGvuDzoQ2468dedEbtaRLK5uaeb8kmIBJxd9uw5OeB9ZMqEvBaJm6O/cLPmvXw9VmyxnlIC3aF+uYxMZRI+3NNOtg6FB3A9l3kg4ksas+Hw1raufIA6fjESWv7vQxvCE2c7+/3+KP9AlRuZgug0lKmw02v9fiIWb3g66Ja9Nb0PattS1hhhv1d1ZSyBZBd/9VOb0npqGolMgfqeHFwmIuDg==;
 5:XyUstWPaN3AMPu6tkg62L1fRQMzPAlF7QWwEyaziglYyolaDTGuCxfhItU6n1uti/C3utuavj1OwFRpO7hYuB1Wt4UxJNfN10v0EX1rKTuFdIAF4W4fESyUL1zZhIxi+OKhuOI82N27Nu7aLDz87RAAAa9uuk9SyATLBMP7K6WXDCxerfiaHeEBe7NkUL73JJTO7mU74xQO+VXIl59JTdA==;
 7:h2VOaykkShUtSxsoYZmOudM1/XdcW6ktUiWvIPpczV783fxi5RZBuE7ssTKUA6hMTfTHJ09KbxO3u2ofZ7ue1gTjaw4ndBGHQ4WmaziEckqv+OkYB+GpJtNRLPXZumBdo0ehHy/qjBWFjL5MVsEKqQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f91bf9f7-2efb-44b3-dfcb-08d679cfc122
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5299; 
x-ms-traffictypediagnostic: AM0PR04MB5299:
x-microsoft-antispam-prvs: <AM0PR04MB5299A39D257E31E18F6E1E1E80800@AM0PR04MB5299.eurprd04.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(136003)(396003)(39860400002)(346002)(51914003)(13464003)(199004)(189003)(8676002)(6246003)(256004)(105586002)(71200400001)(39060400002)(106356001)(9686003)(71190400001)(2906002)(5660300001)(6916009)(316002)(54906003)(53936002)(81156014)(81166006)(99286004)(74316002)(68736007)(8936002)(6436002)(478600001)(229853002)(86362001)(476003)(11346002)(33656002)(4744005)(446003)(4326008)(76176011)(26005)(14454004)(44832011)(102836004)(305945005)(186003)(25786009)(55016002)(66066001)(7696005)(3846002)(6116002)(6506007)(97736004)(7736002)(486006)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5299;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hBe1AXSp4J2LWbRMzFcw60OGFrDxtfchHRj3KNWxPIr5WU4UGMmUCKZ9fXl/nNzBxvy+BMQ7mhoFQ4eq88ws2uu1mNE6tAosJexT8N59mup+BJmgzDzvUN3UuEjMyrq2Kwxm2U759eGfeOw+v5b5VFQYVNJGJfhxIv/yaJZ6D6y18K2PcBeaiQahbpirZ+G5RQUdoeh9TlLRcCVhNlfJeyFD651KqLMO5GqI7RLJ4UpOtWdqeJ1BgiyRrGNhQQq6zFUNzMt0L32nHilOid4QKp99kXGDyMS/WYcZ6ZQnhP89QAJgY2nPfBicpdxaUYuQwk9MT+YnuHwZL8KWONMGxiEHRL4dmZgklsBQ03xDZj3Jzd2dqleDxPhQ113qRoSdv5RHomIBc/Pz+2P/pT/JjrYtdBLZM5SCXFbgrAkvobk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91bf9f7-2efb-44b3-dfcb-08d679cfc122
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 03:24:12.4232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5299
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_192416_419820_760105FE 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Monday, January 14, 2019 9:22 AM
> On Fri, Jan 11, 2019 at 11:37:37AM +0000, Aisheng Dong wrote:
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Please come up with a proper commit log, as it adds quite a lot of options.
> 

Thanks for the suggestion. Just resent, please help review.

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
