Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0612C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:17:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6792133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WSxqfPGZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="evt7yThr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6792133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/VO0J5Y3mdsjfGvLCH/6L1MsunVk+sQMbAG3v1Ygk5Y=; b=WSxqfPGZ+U2q/l
	FyOexuSDhhRiNKsu14gfeTcLuHzTzYCyebiBOEwBH8Juz/wOxcEX0p3yquvCg/QfXnclSMwIRZWln
	5HNIfN4tk9khPwGug0reIs0ZOCfc+qYLeFeKH1MJkRNb8tNGI1UlkZHR0D77VQ2ukaBrQoPK9GiLO
	NmTN9bvLRMqLizu2Yx7XwCGz4BfBPBI7gaF6HIgCGCSKm2ENY0ZoG+QSahFxMwBpKRmRvC5TSNBYC
	SXFokbJrTCfqsSqu/xwzd4eiHVlW7/50J0UcEl2NDQIrmtd1pgq75VO5fb1DbfC70iTqCk5KwE3pg
	N/PSTXbPwczQrl8OS7gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZbiw-0006SG-BP; Wed, 19 Dec 2018 13:17:18 +0000
Received: from mail-vi1eur04on0603.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::603]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZbis-0006Qq-U1
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 13:17:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iqOo3VJQePdEalkfAN7w1vwt/odNk2sA5cRZ49l16g=;
 b=evt7yThrxtmWH05JwP03x9bsXN5HdQtlnJJuUjpg0bEZ7CoOGyZyOjNP/RNGLlsM4TIJ1AtTwkqcR1EzdZlrkKot+n5AFhrb33n3zfj32B1jOKrakpz6Sl+F/owezoj+mJmtLc5YYFBJ3pt+VJ6XcjYnDyJg6zsRLGL7aMl9nxk=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3437.eurprd04.prod.outlook.com (52.134.3.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 13:16:54 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ec1a:b30c:84c2:89d3]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ec1a:b30c:84c2:89d3%6]) with mapi id 15.20.1425.021; Wed, 19 Dec 2018
 13:16:54 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Topic: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Index: AQHUl5hS3YQwM2HAUkyF1f0Av+JOLaWGCwaA
Date: Wed, 19 Dec 2018 13:16:54 +0000
Message-ID: <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com>
References: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
In-Reply-To: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3437;
 6:GJyoMd9FaLjNMDSslSvsloSYj1mUcYFCsUXenOmI/bQGMxzKlHK2A2jYEMN7v1Mkeua0cXSumE9c7oKMYgtP+L6w+OrucoEbou6i6R5Rr6fQi9fW+5pDZ4ijM/uNnRUBN0FAP6dpA/f3qXA06D3M2RtE30JIKwqhatvN8fgAJbnbfUxgswZbC8JFrKqUqWOdbfjhTfuqsjrfpy6sKe0e5sEp23KPohKwTtS9qQ2v8P2BnVL/jTQKwgZ3pYrSUS6d355iE28TzW3ZttBGnAQ7gBSiZqA7YXeLSPmarVJAYeUUPIVN9ZAzUGXOmiKAIy9V47Uid52x51JtLCEI2qFLMvgvLwAYRIq+g4RnQmZCCh9sa57ruw47JnVvgigM/zcWY2AIS2+RPR7kkQpRKT/W6sIrqwLxHavi0Pbtdl8hfZUN+Vo4PGdNX0bvQ/9bGCL6h8XMVQivHwdebB5IVPQnmA==;
 5:lC5Vy7B6lVIbCf6txqyItPyupMovWm8j7LHgJdM56yelfGZ5I2dLkwkabGHzvymhuGnpyHsH1kdqj5dM/Jgp18mBm5SVqb0yksASO/VNAIBnDN2dS9TryD/4isrhfunk4rPKHSFN/MaDgrzmDeRS0vmIxC+kDXZLtSusQu61YuM=;
 7:PDSe0Lmw0Hz9NIQQsK6thIqkIKafqvXP4AS/aMZyrGoUOOqbaRdGoZ3+ha0gVn3PUGMaS8LFlGmZ1LYAww9gzYCaI4q0qc634pWOTN/ZzUEJS6NnJ17mxUB99ZrZegD9kz6a7aW6tsHf23XneGWVLQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 86e05a59-c744-42c1-4599-08d665b43f2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3437; 
x-ms-traffictypediagnostic: VI1PR0402MB3437:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR0402MB34375EF3DCA33352168F57DEF9BE0@VI1PR0402MB3437.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB3437; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3437; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(6512007)(575784001)(305945005)(2616005)(8936002)(7736002)(6246003)(6116002)(2501003)(476003)(25786009)(36756003)(102836004)(5660300001)(8676002)(11346002)(446003)(81156014)(81166006)(66066001)(118296001)(14454004)(4326008)(6506007)(4001150100001)(53936002)(229853002)(44832011)(6436002)(110136005)(71200400001)(71190400001)(3846002)(106356001)(76176011)(316002)(2906002)(105586002)(26005)(478600001)(6486002)(99286004)(486006)(256004)(97736004)(186003)(86362001)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3437;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J0fLj8aB+RYBHLr3zeQ691Y3o3jfux7NoHIKHKBxxli6sl1O6XjCEJQ/rPtoiEwJo5NUWsY59q2g6USDgGH1uNeIKs5pxrKByJRnRuQ7rWAyqIh2Mf0au/oC0w/eLGyKvxbd4YECgV+kENJj22YXeEeD2VBAicxEqiPoIJ3ge/TxAo4zDDtAf5TcaNL7yd9KfNnAdSr7b+/aKSmDIo76JZCbOQXPvDmwBa0a7INR11S9wFCMHVrCCcs3KjCZDblSrahM6wqUFlMC9b78HjHNpdVWX+Y98lpz1bW/m4fUF4xSF93K6isWNZxBnGZxzrIa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <034BDCE48DE72D408E5BCF0A0D6ED83F@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e05a59-c744-42c1-4599-08d665b43f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 13:16:54.7014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_051714_967065_9A8CCE26 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Wed, 2018-12-19 at 12:42 +0000, Marcel Ziswiler wrote:
> Hi there
> 
> I noticed that at least today's and yesterdays -next won't build with
> the imx_v6_v7_defconfig giving the following error:
> 
>   LD      arch/arm/boot/compressed/vmlinux
> arch/arm/boot/compressed/head.o: In function `restart':
> (.text+0xa8): undefined reference to `__hyp_stub_vectors'
> (.text+0xac): undefined reference to `__hyp_stub_vectors'
> 
> Has anybody seen that as well and knows what is going on?

Hmm, works for me.

Using linux-next, master branch. HEAD commit:

commit 02fc169594e96f7c51c4f23114e12b7a18e85a0a (HEAD -> master, tag:
next-20181219, origin/master, origin/HEAD)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Wed Dec 19 18:42:46 2018 +1100

    Add linux-next specific files for 20181219
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>


Using gcc version 7.3.0 (GCC).
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
