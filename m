Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A61C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:02:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64A22082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="or5oacj9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LlHS/WUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64A22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hp/DAPDgmW7Net/zToEmusA5RiCUrPg9bReB1AfUm7M=; b=or5oacj9E9F6JL
	VqtQVLG+WAQ6B/o10SDOiDp6u/X4C8NZ5gZV2385BLjhC8drjf9bhs29FwzMJ5+zhjM6+ZwVkbEDH
	syV6PIZJpGpmxSFl6UZutKx8JqmBjtVOnMfATtnM0Cxx8rNQUg169l3QMal2DDwzLKDP/cHj/JMGI
	DCql4SkB4pU88HC4Z7WMbPCDb3WF9aGrGpqhfSnbWE/MIob1J4FJ/Cdf8bD2My8L4teDe6sS1LERV
	OLB7BvSmm1uBCdfVSI4o0WEsVlRQf/YMwV9jtkTeSvExnz+y+50CCH2G0+TXRw68WbiyEEOdwozHO
	jjPGdGjIMIt/Jyykr8+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gji1V-0008As-HK; Wed, 16 Jan 2019 10:02:13 +0000
Received: from mail-db5eur03on0618.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::618]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gji1S-0008AJ-FC
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:02:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjpuq6xQKLf3cHWyfFYYmXeE+3HWsK7WpyxJXj7wcCw=;
 b=LlHS/WUebdkk11L6DHTz9WqfcO55ltBkuK3kG/BBzE+QGnYPk7rH3y3MZDAJkDdvDRVEuYQdxYSv83LFVZaewonabVolRinisQunEicarlLbjjFq0BFAOuV7S0sn6yDrGskjIF6juzEGgTv3p72iM/A5efqyE4THbNWF+HbtG44=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3693.eurprd04.prod.outlook.com (52.134.15.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 16 Jan 2019 10:02:02 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::8c7b:7d91:36c7:1426%7]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 10:02:02 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2 platforms
Thread-Topic: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Index: AQHUmUIyF6ylLjPS3UibJyYT5PgWG6WrD8gAgAbCicA=
Date: Wed, 16 Jan 2019 10:02:01 +0000
Message-ID: <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
 <20190112024725.GO32649@dragon>
In-Reply-To: <20190112024725.GO32649@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3693;
 6:VMV2rgwytmBELYFSC4xiYOypRJVnFFnXmHog9PSMD6BuvkDI8IGYFyxiJN9t+0HERAzGYda84wMVQRgZYXGNqKt5HilVhkiUveVofUSb54n+DWuK/OESsoKLoFcLroGunTtdQlGo9mJyzvq0EBQjzOwOajLN0TwJu1T9RXKgU5LLnfhH1FJTGiKvhmBNww/uPqqkyyMx6iF5OGI9vbfNioJqX8CVy04fy3aIXXaHt2FwNruJsPFqfbS9DWOFfF4wmFz9xA6LSJ7YpCxgwaTMDcENDHge6IUpRBM3Idt7Og2uCO1cOT5ES7SpbkUyU/gRTMkCASlLLdnHr5xzfrZdhBUdFWSJpGI3MCt6OMb81c2oRa7b+R4Uwczo+sdyn0l5KI2CtMFNzrpyE7XehIdJGGXZjK00e1Pc73UbnBrsN88EWEfE+uLUPsalVULZshBFNkTMhtsAzP5XesR348owbA==;
 5:u4APyoMzkUHOmu8x+iPGyg+5u57GslESbymuO5KYQUS72EEXN9AH9lHiz1Xf7C2aBbZqchtyfxyX/O4XbIUEFa+IWXPYVmNY6kdM0Egadl/OJD2s6C7yT/bNPhJ3GrhUJ9ECVjbMfsHd3v0UdufpmJQHruU86o/Bdnf/t1GOvicUSKOFHCCFcmSMY5IhUPrMM9f5gLeHUcC/Moi+1gj5fg==;
 7:ja6LKHDweUr4KgWNKJewi93o34OY5MEaxfaPIVXo0MuqwnTmygkhRhYGMoouFJ3wiaik6f3tB4TyZ8raN7vVBuDsuXb4gkA2rqmEUx1BIR4fXHY/zCaaufYrs7sgY//0UOkrj48bPpDqQMgulMBTwQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3afc2003-0387-4607-ffcc-08d67b99a94b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3693; 
x-ms-traffictypediagnostic: VI1PR0402MB3693:
x-microsoft-antispam-prvs: <VI1PR0402MB3693B73540765872F2EAA590E0820@VI1PR0402MB3693.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(26005)(97736004)(446003)(229853002)(11346002)(66066001)(6436002)(478600001)(305945005)(256004)(55016002)(76176011)(6506007)(86362001)(186003)(476003)(7696005)(71200400001)(7736002)(71190400001)(8676002)(99286004)(2906002)(9686003)(44832011)(6246003)(81156014)(81166006)(14454004)(316002)(8936002)(486006)(53936002)(105586002)(6916009)(68736007)(102836004)(106356001)(54906003)(25786009)(74316002)(3846002)(33656002)(5660300001)(6116002)(4326008)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3693;
 H:VI1PR0402MB2800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PboTVS6JosOvDesUOGT+r00cStXbyB2EbF/8CYpRkJrSNeb7uV+d2hzl+6AY/3NlKEfb7Zt+NNsqlRDlZTWEQIHbcrd9KTEYxrRbJbU8CdfdCOPuRXaice8vSxtlpP6zG3Bu69QhmDi4oCyfhv7QkyxDEdyCP2hpuVEiLgu43isIYz9cOWJssJy3UDzLTV6ho3Aek+EutZGiQatt7p74tyI4vcnGrMW0k38yucwmuaBPg4cpuE8jJZQY1iq/5eLHKrmRYJ3vRUrZO/oI2ThUqxZS38efnsCAEvpoAt+yjF55LXk/yWzz3+No9UH7mDvkCs6xnXk7F6ZpLimbq/QhwxlNh/hIL14LM/PqJb8+BJhw+PDCOCZjBmVXrLe1FFGcZUAK1tM2dYuEi3CXdLc0YA5aEboQQ5RukOsiwJkHPXs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afc2003-0387-4607-ffcc-08d67b99a94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 10:02:01.9126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3693
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_020210_510549_04DACADC 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
> platforms
> 
> On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> > Add the dpaa2-console device tree node for the following
> > DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> DTS patch generally goes to the last in a series.

Should I resend this with the DTS patch the last?

Ioana

> 
> Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
