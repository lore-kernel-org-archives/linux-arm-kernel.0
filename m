Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6F2C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:12:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0157218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jySIWEpK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ktIo+OeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0157218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8mpp20eT+Xca/RK/nTftH9QtvhMkwV4lkI5mA6J2/x0=; b=jySIWEpKsgvMys
	E66SDfF4UvKbiDoICWjMLXvVg7WP5uxS/tGQK4n+4zMc3jgrDNTkmjNhYss6THhgWhsEJcfzfGfsJ
	KjgRox9yW42Phm2L+NnY8pjvibdo3m2o2KU9xAR+QlmK9Oae2IQR/AFX7RP/H+YddCgO5lG3PVPZ3
	lkWd3FvmewcvVW3M4RJI0RTYhYtGRvOx52MmwKq94/1iMMC8ou+wCky5W+EHUN/2nM0tV3rwv56v0
	Ct+ETVCLccbWOqrM1hKH6tKTMcK7SgI7D3Dzssednqr9tG0INgFavpoOLlD1WrmAXnfkYMcde+v4t
	yI7pxKv01HnY2qB5qdtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gopfM-0000XL-Kd; Wed, 30 Jan 2019 13:12:32 +0000
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gopfJ-0000Wp-SB
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:12:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8BbTiEmfTjgib/yt8bvr/LhNAB7SHb796LPPgcvNzw=;
 b=ktIo+OeLQERBFiQFrPt1XgfmJ8ikNp2wjN6rf4SBNCrdCVI65N9uTVevvVnbOlbxU/dO9W4nyU99CSthE+YORix8LroQk0Clqx48iaI/T6SSU1IVUc/OO8SH4N16h+I04Frr7T1voxKVLBHW8Sa6YSlXxv62BUHHd4hakMkxrOE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3325.eurprd04.prod.outlook.com (52.134.7.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 13:12:25 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:12:25 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "dongas86@gmail.com" <dongas86@gmail.com>
Subject: Re: [PATCH v2] firmware: imx: Add support to start/stop a CPU
Thread-Topic: [PATCH v2] firmware: imx: Add support to start/stop a CPU
Thread-Index: AQHUuIJIb5ERbmz8Z0ilGZjHtOs21aXHwqaAgAAHN4A=
Date: Wed, 30 Jan 2019 13:12:25 +0000
Message-ID: <fc0ef2f1709cb678f29cd37d618e28a7ed606791.camel@nxp.com>
References: <20190130095749.8952-1-daniel.baluta@nxp.com>
 <CAA+hA=Tz0p8Ea9f8wuqUZFkmuDrqMHj8_4sLvT8wi6qrTnaVKQ@mail.gmail.com>
In-Reply-To: <CAA+hA=Tz0p8Ea9f8wuqUZFkmuDrqMHj8_4sLvT8wi6qrTnaVKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3325;
 6:POv9+r9GP0ezFLNDHwGpagrpkaB0L7rxtDjHoxM0eGXQ6qDwioi3g69LADfLN+O0PO6bV0XZ7ZkyVxik/NcMxnDgTqML2rmlLa8CmVTVyKweA5DJMz2WmLyPw86HZ9QQ/iMVIlzKTw/exV9kLoWImRDoU2xNjAHd4cglyqF7oMaOQJXUZomW4OSQG2XHVhLj3xGKO8GQeshFQEmW8JuyykMeCfR9GhWhegqia2hZnl35pEcOy6q6DromUOO2HOyVz12pCQkhIQR5tNAgfeNLPyOVBJ+vnqn//YmCxHi2a8JIubbMoCqGjwGegGTjS9s+8ta19bfjrIX7fLQC4b6zN70nz4wmJzQH12Duq/wRL5uOe4/WOH4lyEIgaA8GkwBfM+f8NocS2q+eguwL2RiQz29dY2UZtqtt3NfQTek2DlRmAS2p50YBl3yRZOqA53iMrKLqdW8GeAjKyj2MThxVzQ==;
 5:n3XpJldxLDXSxGhfrHmPO71P3XwWrtEd0SuRkUywTl3nyQuj+oLEQXOkMPFn6dIX4m0CPblHSJ6+rA5qXH28x411uRNAIew9o99IYztxodpSRqaM0g/WLCn9BBTsQr5EU6y0oCA8DZQljDf5mWk2iQOtSLW1BzzrQDAxXWIpTLnNfjpREzou/s0NJMx+87Qax/TFWsFGDWY1p/CDjpszDA==;
 7:mrTcdnD/zSP/w/deay3Zal2IEC3K78CErWD0teqc2xzPtOjmsrrDEErHi+tQqt7ZG6ngcl+M4zvgQRbsqTWoaPvZ9vhkM1b0hQa/QByp4eJrVJVRkwcio+iIT81um2RmM/jLicV4Lz+o4ADs9rHAhw==
x-ms-office365-filtering-correlation-id: 8d1b9f81-e9cc-411d-53f5-08d686b49447
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3325; 
x-ms-traffictypediagnostic: VI1PR0402MB3325:
x-microsoft-antispam-prvs: <VI1PR0402MB332578725EC593001CD36D57F9900@VI1PR0402MB3325.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(316002)(6116002)(3846002)(66066001)(6916009)(478600001)(39060400002)(81156014)(81166006)(486006)(54906003)(446003)(11346002)(2616005)(476003)(4326008)(25786009)(44832011)(5640700003)(106356001)(99286004)(2351001)(68736007)(6506007)(105586002)(186003)(7736002)(26005)(305945005)(102836004)(6512007)(97736004)(76176011)(8676002)(71190400001)(6486002)(71200400001)(6436002)(53936002)(14454004)(118296001)(1411001)(6246003)(8936002)(2906002)(1361003)(86362001)(256004)(229853002)(36756003)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3325;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TOdKSgblq4bpmqRDd0CcHw7BQLC5ldDF2d2PIGAmihD6i5nJdsA8aB8gLaHHW7w8BRGFSeKksrOd3QDyo4WvIC65nMnl9f20+V4QmfTPzlRQSeH/XJsxxdaLGCfiamyW3KGB9DtZAFsItiSPgVOxeNjx6RB6536Fm8ar/L2yAScoVpnnoWoSHmG03xhHGcBd2/sSU5URDv6pC4qRA+x2rpGQOU4IAD/ct9ZSghM1mbWTCffTmCtxQOa0/7to6jD9FAr4B0BPrDFCOWLwi/Cjm+wcclUwasg6iFkUp6JxX0ZQJNhZdC92qes42/+PO4k8x4za1RtsE+nARjKaqhvupfXZqZrVJrmvPypjjldn+jUNm7mPmw7pSxM3HSE98BVOLF6MjPhBw5wvIKZm31k3wy/2ITn6e4e0uKz6fE/XwvA=
Content-ID: <5A7123B49DE5604F812E02A28FED717D@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1b9f81-e9cc-411d-53f5-08d686b49447
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:12:25.8320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3325
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_051229_907690_828FB712 
X-CRM114-Status: GOOD (  11.68  )
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
 "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks Aisheng for the comments!

<snip>

+int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > +                       bool enable, u64 address)
> > +{
> > +       struct imx_sc_msg_req_cpu_start msg;
> > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > +
> > +       hdr->ver = IMX_SC_RPC_VERSION;
> > +       hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
> > +       hdr->func = (uint8_t)IMX_SC_PM_FUNC_CPU_START;
> 
> pls drop the unneccesary unit8_t

Ok, I can do that. I had borrowed it from the already existing
functions imx_sc_misc_get_control / imx_sc_misc_set_control

> 
> > +       hdr->size = 4;
> > +
> > +       msg.address_hi = address >> 32;
> > +       msg.address_lo = address;
> > +       msg.resource = resource;
> > +       msg.enable = enable;
> > +
> > +       return imx_scu_call_rpc(ipc, &msg, false);
> 
> s/false/true

Nice catch!

Inded, the old API had a different semantic for this parameter.
> 
> > +}
> > +EXPORT_SYMBOL(imx_sc_pm_cpu_start);
> > diff --git a/include/linux/firmware/imx/svc/misc.h
> > b/include/linux/firmware/imx/svc/misc.h
> > index e21c49aba92f..c03bf2a23add 100644
> > --- a/include/linux/firmware/imx/svc/misc.h
> > +++ b/include/linux/firmware/imx/svc/misc.h
> > @@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc
> > *ipc, u32 resource,
> >  int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
> >                             u8 ctrl, u32 *val);
> > 
> > +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > +                       bool enable, u64 address);
> 
> Nitpick: phy_addr

Ok, will fix.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
