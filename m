Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFFDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:25:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4304720651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hqcwhwWj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AgpmqYnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4304720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5UvlLN9lZUenocIi9Yb1vLW52BhmdyBfafJkAAtHsyc=; b=hqcwhwWjLTBRU/
	yDvvjv50sgTtjWheV+b7InkpBnJZsmxo4WpfkA3wZv/OVWRKcchRzneoBk1aK4ASvqaF6f0/TK3mo
	fq1BXjRN2f1iat14G0EzyqTcB9jGMYI2rEXF2+sSG+srzso2Uqf8vwq0Glb1SVawzWt4gtPZEUlLp
	Px6PYe38TxZevxig2mwOMz+jfqJaW+XxfPtkvqZdvS+yqKEeK9d4n5MMpyfXONbAVSiqpPvyE3ksU
	YSQ7kVPqq6cdV81kU1ZoG+MDBzyaq/Pz4+NBUNfsn9R9OPh0Rx2Hr5B4tozBQl9Pf10o/sTpFiAlx
	/kSXpGLCpZzDFk9KpO/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlBj-0000tI-Ja; Wed, 16 Jan 2019 13:24:59 +0000
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlBf-0000sX-Vy
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:24:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK32LNF2QQX5PnMpHol5IcP8snf0+pXpiBwtLMCeZ5E=;
 b=AgpmqYnMqwOddDX1zLdSSB4epq2vBqvFmTuunkvIZsRjfRdTsyiK9pPpGdTMX5PuM5cgyYq6VpWCL1ZbxpfRdUwNIdn63P/nBrN5BS8tt1MdXdaUyATCChVGjlkQ2l6N0NXlmNj+LYFPAkGK6bm5z6vMU6ZDpxaFjldWtULaTUw=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2943.eurprd04.prod.outlook.com (10.175.24.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 16 Jan 2019 13:24:49 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 13:24:49 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Fix MU4_INT number
Thread-Topic: [PATCH] arm64: dts: imx: Fix MU4_INT number
Thread-Index: AQHUrPR8+s4T0qQiBEy8rhYNUN5cRKWx4EYAgAADhQA=
Date: Wed, 16 Jan 2019 13:24:49 +0000
Message-ID: <11058ce79d91a49e47be47bd369ddc111875fa23.camel@nxp.com>
References: <20190115170501.10952-1-daniel.baluta@nxp.com>
 <CAOMZO5D_kakB82dEcXrU4EZARLj90US8Zf+sGgaKkZvUG3t=PA@mail.gmail.com>
In-Reply-To: <CAOMZO5D_kakB82dEcXrU4EZARLj90US8Zf+sGgaKkZvUG3t=PA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB2943;
 6:gCagNyJPzS6ciyLYv2W6p7GCPTnZ6iZzkw3S70zem0+RMxKHKxMXH/uVWL4I8e0e0YA+J1PjCA+zrqiiCypjfd+HHadXEY8I4Bu30I7dyQrIqpVVcVjCIJTpsTR3TVzMX3H7JmLUgQ73vJddYjqclwmSAARRH82Jp08atvsV6WQju5ycwA5CBfAa7xL/Zv6Yo0Hb4lAph6d1HjxNZbxsUfzhWKatSbdC/D14SZIKrEWJF9XAAjTp6IIwfggd+W8vc7MlY/DACmU+oZa4vATyZvTLNc7eST0XEV83qubwH+jM/94hWnbMLM0OWVSx7Bg0AUt+ONvXvCTnaVWJNUdtxYZqCKVKVzambIdHdrBbiNvEWw/Ijd7Vcw0sJcAiyKa2cEBOzbhM2Tl9beeMTjdpzg4ec1X4UYximYbQXgfdTAw5B1Rtq5u1PJn1oUG2bHK4SRz5aMu6QvrMaP83WTNkwQ==;
 5:zJRf3SeKfOnF1J350kz4uoMvWRNZDVBq7iDsy3jWQTb0xoFRRLFTaFTQ1zRO3Zzc8VvS9nMshAtSs/n26uBCiqklu3aMBgvFtxE9VuPWRRF9UOPjJRIy50c39FNjLXOoIglb2/iqRRmxT4kV8dxPCPnYQw/kdEm3hYXUxFPIc7ovFzveKQMMRy8365GJwRebK/662X8Ktv1QKGHOv9TVBQ==;
 7:dl4l6nctxLRRhQbMCml7IWxmdPpINXuRt1wjiV/g9IjHI/pAuiK42nhqAKeFBBt92WEjuCKdubFQ1FA6Mjla/S0vQ9+NN7f9nm9G5vzGXPHsP327t/5m11OP9hO+p0Wg3A01+7WwP+Wdp5KkOtaHSQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3d3db9ae-a7ff-4549-00f6-08d67bb5fda4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2943; 
x-ms-traffictypediagnostic: VI1PR0402MB2943:
x-microsoft-antispam-prvs: <VI1PR0402MB2943D3BCFA4CE4C43A148584F9820@VI1PR0402MB2943.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(6506007)(6116002)(3846002)(25786009)(476003)(6436002)(6486002)(186003)(76176011)(44832011)(4326008)(229853002)(66066001)(86362001)(105586002)(106356001)(2351001)(1411001)(8676002)(486006)(54906003)(39060400002)(26005)(11346002)(81166006)(81156014)(2906002)(316002)(1730700003)(5640700003)(97736004)(8936002)(446003)(118296001)(1361003)(2616005)(53546011)(7736002)(102836004)(305945005)(36756003)(2501003)(14454004)(68736007)(6512007)(256004)(71190400001)(71200400001)(99286004)(478600001)(6246003)(5660300001)(53936002)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2943;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p5r2GrO2BG73MQ2cRzokyhxbKNL6aHd3oqOxoF5Fxss+KRtUuQzdYYM3Hd9JxuQjOLzOCAXd8vrJ2ZWcn01UJItEcAb/t9K8BLxqVbCRjcRQ9wNBVvLoCqVddNv1EMPg29ssMlrxxkhG8+c+yr1na/H9dx6Nh/tuyYnFgEHbxaO5soBW9SRet7GQIl81vdB4fvU14gd4Scucj+qvg/u9yZb+vhJUPvk1QjVFsXwthb01mMwnPukrva6oxmCjqlJtOSOUtYdhLPzueAgtoLaJ88K39GFNiTFjAGorrLBsOBFTHxUfYO92wW0sbjG9gfl4SdzoDJXclcdH9yMQ+XM/aKzhnUWoUZJ2oyERR+VrEyDCY9TVNCmT61tiG/gkAI3fOQe2HUJjbDrhQi21HAmpsI3on1JRHgoyJuYZ5LPwDqE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <7D477C7A82A01A469730D7380997E81C@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3db9ae-a7ff-4549-00f6-08d67bb5fda4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 13:24:49.2673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2943
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_052456_029143_389E38AF 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Anson Huang <anson.huang@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-16 at 11:12 -0200, Fabio Estevam wrote:
> Hi Daniel,
> 
> On Tue, Jan 15, 2019 at 3:05 PM Daniel Baluta <daniel.baluta@nxp.com>
> wrote:
> > 
> > MU4_INT correct number is 180, while 179 is for MU3_INT.
> > 
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Two nitpicks:
> 
> 1. In the Subject it would be better to specify the SoC name:
> arm64: dts: imx8qxp: Fix MU4_INT number
> 
> 2. It would be nice to add a Fixes tag
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks Fabio for review. Fixed in v2.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
