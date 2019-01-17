Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB03C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A0120657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bVwTak3a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="PBb6289X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A0120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8hx5CgU54EMbGYcyfMb1peuuQFKZonKfTZbkXKCI+Dc=; b=bVwTak3afSQQcs
	frE8IqT5cKsAsRCwfSLnZYiuHSHbYNaY92JnY6b8JwFdKDeU6yrLKIu91Ka/1zH9ESkitCd59wLp2
	N36S685+GJhChD/BNUwURG1+iU8f+S7nUBdbjdPGxdV08wLYuRtWRE9aTJ68vJQ9ibT1z0CI2gDZr
	XxYb7PuJ4DwVbCOWok3MlR8e6O5Fza1Km409dcqKuyCijxRHRtacOOW4aC4KVuzQhZULmsdRc1N6q
	zcMJ8WfqKNH3BDxU9gg1brNPPkVBA4l+qdM8L9Duy6KwcrtFXwfx/CjB7zi4+BvBubTgYK9X45Swt
	pHqF9oi6Df+MphwZIorw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk5SK-00027I-Ke; Thu, 17 Jan 2019 11:03:28 +0000
Received: from mail-eopbgr140094.outbound.protection.outlook.com
 ([40.107.14.94] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk5SH-00026E-30
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 11:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTMOcm6mpEUT1VRVe9c5q95B/Rb9fJjFxB8n3bu3fYg=;
 b=PBb6289XORGB0/IMOvLsUWuEAyUyBOSgUQHGERMrvujD6b9KLRSBAmM3+2RC8UGelaXrpf56JwHRNBhFVM9gh1GFgFIZfBWwX0qGpRbuWXxH8y6x10HP68UEarFrf5ui2mrLkCkGXaBG6MuMMbYzakrVYdFFeupTtPpAF3rqyUo=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4360.eurprd02.prod.outlook.com (20.177.112.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Thu, 17 Jan 2019 11:03:20 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 11:03:20 +0000
From: Peter Rosin <peda@axentia.se>
To: YueHaibing <yuehaibing@huawei.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>, "fabio.estevam@nxp.com"
 <fabio.estevam@nxp.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "eha@deif.com"
 <eha@deif.com>, "linux@rempel-privat.de" <linux@rempel-privat.de>
Subject: Re: [PATCH -next] i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in
 i2c_imx_dma_request()
Thread-Topic: [PATCH -next] i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in
 i2c_imx_dma_request()
Thread-Index: AQHUrhIA0e/D3fVEHk6ncU1jxDeC26WzTGMA
Date: Thu, 17 Jan 2019 11:03:20 +0000
Message-ID: <e8c15a2a-6b59-42bb-0a1f-2ab53c01b0d6@axentia.se>
References: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0250.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::26) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR02MB4360;
 6:jt4ahFAY6voXRqkr/KoJn62og7B1H//3AN4SXJ1tdaSqAz+kYkw9ZL31ec/lyHqYjg+I58BNRV+MgoO025urZqgj/EyiJetDOpUVQUSCTSrUBV8JmTTytAwk9VxlZD6olVs8G+TnYIUl4QyJXESgCTRYgWNZJzzuSx4pUXJTJqbjLs/vjMquDdgPqWipNTFJOTY122cqbZWqcupj5XznpECJz4A/n+KeLEXaggyFK/0geWli46MoeMxy9kVfCRCBBioh/QpoST++S4l8matpRv7Fu82Xb1x6+44pUKEXc/mJEMx1F8tjlJu1qFlgDWCJh5nL3DvpUYiU1tSD7yofRBlFJo0rXsq/aO0IOAuTSf45IB4+bC3jys9P/qIe4BZQAVx5jXNVX+qXyq77ips38COo3MQSsMivmMTqY104NBHrnlrbtF0W+GzKZQQw7EVRKkGSJ7xo0fLzCgXR3g4lfQ==;
 5:lAkgddE23enXPdGrzoscehAOUAsgJNLQR2t1P0Nfm0suBZOwv0a7ObT5/AL3D3wMEqEFWSsQi4UO/mtKiI9BMGlagOpE+vA4IYiFHF/QkwNu+cRNWg8RnRDB1Leq7ArMivL+tPsVZRF07NX1PoEheKNS32gW+m7r7utgtWakgRx5SrVBB4kYs9Pf43Ax85yRAySFQyps3REfncKNHskV3Q==;
 7:6C3XPUmzFJWKUINMVCSyTTyf62wE7bKjVrLYEfSE/nEiYXXIYaSZDkSJwkyyUFYF7Jqe3mgNoU3AsbwYbcK+RctnZxUUbIPMHD8KLGLxFZ250rLGJL0XXLurIBu7WEvHYLzR9TGBSgGJAjRD+Z9NGw==
x-ms-office365-filtering-correlation-id: 41fda40d-a045-4bc1-b12d-08d67c6b63e8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB4360; 
x-ms-traffictypediagnostic: AM6PR02MB4360:
x-microsoft-antispam-prvs: <AM6PR02MB4360455A2229AD900E3D5AD2BC830@AM6PR02MB4360.eurprd02.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(136003)(396003)(346002)(39830400003)(199004)(189003)(2201001)(966005)(3846002)(6116002)(68736007)(86362001)(52116002)(31696002)(36756003)(71190400001)(71200400001)(2501003)(14454004)(65806001)(65956001)(66066001)(25786009)(486006)(97736004)(53936002)(6512007)(6306002)(6246003)(4326008)(2906002)(5660300001)(7416002)(186003)(65826007)(102836004)(26005)(81166006)(81156014)(74482002)(8936002)(8676002)(476003)(305945005)(2616005)(446003)(7736002)(11346002)(53546011)(31686004)(64126003)(76176011)(508600001)(386003)(6506007)(6486002)(229853002)(6436002)(105586002)(106356001)(14444005)(256004)(316002)(99286004)(54906003)(110136005)(58126008)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB4360;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ym6lC72b4YKTCMbBFlZz2YCTiOEjU6IGLrpXeRxeJ41WddJkIpkbo0UkBDs2tAm56/OLhPlWcP/ytDntY0zNQ935ysY5RVHRwghLNVi0AYDJMxYamMbckM2INbro97951Xl/lwQQUM0pd6nB9H8iIQhEG+JYCNWBmY0TSQju/yIaobz2kmIBMiD0kdJrbnSB+r4foVtF0XVxSJ8WidgNlwhwbqmpWh66YM16+s8Y9NE1sxOI3bRI60UNbfVmCGtoY2zZU8HgIGq4h+uNCUJNMK/F2Y/r1GH30zTjCRi46P4noBW8zZfOunLMR2ldFQ3Gyg4F/LXS0fpXUaVyRLJuShX8DZ6j9G9u1xGCV0QcXAukTRxeWj7OHVaMIKsK9RK/y5XC6SqE8V4TLwKi5mk1938sctzPwD61N4WpWXXHE1o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <218C6E902B3B834483E14FEA617778D0@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fda40d-a045-4bc1-b12d-08d67c6b63e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 11:03:19.0756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4360
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_030325_340037_14AE3F36 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-01-17 04:14, YueHaibing wrote:
> Change the call to PTR_ERR to access the value just tested by IS_ERR.
> 
> Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx_dma_request")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 09b1245..42fed40 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>  
>  	dma->chan_tx = dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->chan_tx)) {
> -		ret = PTR_ERR(dma->chan_rx);
> +		ret = PTR_ERR(dma->chan_tx);
>  		if (ret != -ENODEV && ret != -EPROBE_DEFER)
>  			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
>  		goto fail_al;
> 
> 
> 

You were beaten to it by Laurentiu Tudor, who sent the same patch [1] shortly
before you.

https://lore.kernel.org/patchwork/patch/1032511/

Cheers,
Peter
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
