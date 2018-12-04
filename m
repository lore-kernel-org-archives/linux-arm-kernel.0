Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F47C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:47:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9685D208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SmCzGAJV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="azIE8/IW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9685D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zoVwi8/KGOv9Fwj9RBbF9KRRkpkh9k/Ri5nTSEkzYrs=; b=SmCzGAJVzDlPZz
	ZjioH2AHpsy9Of+ShzJRElbzWViTx+Pzr94wTkTm2NyC17OK13tacBhofuXSiby2cHp82/NerB/9l
	nDhrq6ieaKPVRwJRJX1nsO/FyCQfJ4Qf1nxP/NQ+K+g+5nTQQX/vaJ2DiZK1g4uOTS7F8Ix87AaNu
	RUdeNCIpKNHJfsv/3NoTiQLCV5a95bgI6Ws4Z34D554DrpOGIUim3utqrw65nyAUpQq7H9DKXZVFn
	fGgvRchAy3JQd6nI3ljovIpKiy3IjyMvDaNb0jKVGHqwHOCZaqvK0cz+bExOkAQ9uTneR4pFpXC2U
	qQY+d880rLtifWstqGig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTznw-0001CM-6F; Tue, 04 Dec 2018 01:47:16 +0000
Received: from mail-eopbgr150084.outbound.protection.outlook.com
 ([40.107.15.84] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTzns-0001Bm-Uo
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 01:47:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RafUoOIYJDh8772VJvt04jBaPKZQTeETGrAlCewKquY=;
 b=azIE8/IWhXYcee1SCDUQxBv+kH/LQbKHKQpsJ9XCFW2d9oY1U129nGf7PlTIKKMSFupwu01jPaYrvQ9uw5+LAH9t5SSoqZtzy0hb0JTH9yuMw0PXdftJITiW3oaYezoq2+rKc9cz20T9Cg9R4JpRnYtTMXyi/mbFuVFYgyjn7OU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5793.eurprd04.prod.outlook.com (20.178.202.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 01:47:00 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 01:47:00 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V8 0/7] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V8 0/7] clk: imx: add imx8qxp clock support
Thread-Index: AQHUgaQ07UOrlEn65UOyxxVfjCE+w6VtfjwAgABky9A=
Date: Tue, 4 Dec 2018 01:46:59 +0000
Message-ID: <AM0PR04MB4211C1860A97045172987EEA80AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
 <154386633644.88331.14352445218056608664@swboyd.mtv.corp.google.com>
In-Reply-To: <154386633644.88331.14352445218056608664@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5793;
 6:2SfsrJM16MOXxJr204vSd1oQ+iQJFoiAWUVjORWQSiO/Ro0znllaQTa0FQQi8SZZTIEaqK5cgxtZrB8mAs10z9FF+HlkxGKc6SxybYLTOT2fQg0Xs7c9xMrp73RnisXDNRlNFl4tVfkc/SmrPXSzH5+/UMQYAj8cFU9Fm5Xn1P5GwJmQdzvFXcLu/QmeOMjy7nuu7IxoWvzDSdj4jLCQ2jI/SsYt+380zBJHyqLFNLRliZzOfbsD1jgKUfjnWnojQQ8dIu3P18oGTZF4q204xYUNuvk3cCUZ3VySGAFi0vHGVQ3Gmsgkx6SeUm+M0w7JAHhDmn8upWdEHpg+TtjeNySt40QDI9co/vTl9KEIVpcxi/3NAruB8HXfngsDWEQvvY02GOo76jqixXzvxxSUMpFGyoLtpfgFJL381KtdODj0FwKp9nchP+QZbyMvMN7uFZRznIfGR/W2HNHeKnrhDg==;
 5:rsUtglYSmVbvkfUdToKturYyhmlZPbUCne+wU8auxgOexl9A+PXZ5yPiYmTmFFVrGKPQphrd9BX09ZUfWx5yBqPGlvs4gbfSYcUMMsQ5mCnlBA4v2o8WCJsexYoIykKLxGBNdAZPxVvUzYvRsfcYigMRVU+SdfkUgi5E+KjIQK0=;
 7:aFir2jV5JiaomT1TnN+53cKya0vaGX9bQ3M+1/A1ygAXE8LhFlWey555dbZ2L9wCYUBuM+uJox/UGe/BzznVrHP4jYhn0trG0ZEC5QRQ4yu+MAD1KfX/BAHuHTMm9OHctchtxWO1zLdrxexz+R+9hQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ac32cbc8-22c6-4019-1a18-08d6598a61da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5793; 
x-ms-traffictypediagnostic: AM0PR04MB5793:
x-microsoft-antispam-prvs: <AM0PR04MB5793A0DD6FFD850F9137137480AF0@AM0PR04MB5793.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5793; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5793; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(13464003)(189003)(199004)(51914003)(7736002)(5660300001)(8676002)(6436002)(76176011)(53546011)(186003)(256004)(26005)(55016002)(6506007)(2501003)(9686003)(229853002)(8936002)(105586002)(7696005)(14454004)(53936002)(33656002)(99286004)(81166006)(81156014)(2906002)(476003)(446003)(486006)(71190400001)(6246003)(3846002)(71200400001)(316002)(54906003)(478600001)(6116002)(102836004)(68736007)(4326008)(110136005)(106356001)(11346002)(74316002)(25786009)(66066001)(4001150100001)(86362001)(305945005)(97736004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5793;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qo3gQcY5mxkulo5WN9Lx1EUI6Dc0HQQ4fZE+BmUf9wp20HWMRNr8i8ci45Mti5nUqHyKpbE1q4keOUKVeRlrEzNDdkJbhAgJU9cQw/uAurUJgKDHcFeYKI8wHkafkimxaKoe3eOq6LeuefGIfuOfJYtKitwSd5nzRWMraiPkJS6jHgmIKbK/vOwktkJMNMRxG4NJqhgeeRNNFiXQCBeKQQ2/Pex6Gv1zqYXO/RK42dMPn8D2PQQ+pbS1rUy9nsu49l7HWl8CxIf1M+7d9g0zd9DroYSWuhUCHL0Ih5kLjaypEEBHrVRXz5cYnnwp+j/7Z8bokfgHmQ6tmYVZlgbJ47COWiBnxTd9V6I6ZPbRsdI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac32cbc8-22c6-4019-1a18-08d6598a61da
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 01:47:00.0025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5793
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_174712_990408_BE7B143B 
X-CRM114-Status: GOOD (  14.49  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Tuesday, December 4, 2018 3:46 AM
> To: linux-clk@vger.kernel.org; Aisheng DONG <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> shawnguo@kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de; Aisheng DONG
> <aisheng.dong@nxp.com>
> Subject: Re: [PATCH V8 0/7] clk: imx: add imx8qxp clock support
> 
> Quoting Aisheng DONG (2018-11-21 06:12:16)
> > This patch series adds i.MX8QXP clock support which is based on the
> > clock service provided by SCU firmware.
> >
> > Note: It depends on SCU driver which has already been merged by Shawn.
> > So this patch series could go through Shawn's tree as well.
> 
> Any patches I didn't make comments on look good to go. Only a few
> comments to address and otherwise it looks good.

Great, I will address all your comments and re-send soon.
Thanks for the carefully review.

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
