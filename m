Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:30:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AC520657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P443ITbh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pwPfbRs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AC520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=h2zAyzBuIr6SdmVq3nRZa23H13Ai7wGBENF4iF/fwlk=; b=P443ITbhA5i512
	lcv9VXjNH4Xn7QwI0fyc9lcsDOpvDpZpJ0FTQFXOVKwkytpKw6enx19y7zzAf/y4G473OflH18pAZ
	d8fIsCuIsKQLRKTIGmN4lktQFoT/4zA0kw4z4TBUwY7gtLEJLSt0jPQ56mL39bf/IYQ5xrzld9PtV
	Qu9xTWJe2FAd0SyrvwiDZaUGjqAEPAr7B41+q9B3bhjgsWOIzLy/gAHGQ+m8pNPgbCl1kO68ZNBHe
	dWn1vE2A0jcsIeBy9JJEdlaBZrE5kJphqwCsMk+t24otVmTjjg71LfnzwmR52rYA6AkWp3J2wh5vJ
	+w4QRwR9tAb872QAVF9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNrW-00064p-0Z; Tue, 15 Jan 2019 12:30:34 +0000
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNrS-00064I-Lj
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 12:30:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6lG3oUOMh1sVI7QAaMcA0H54FRfLrrkuLTBRdBZ69c=;
 b=pwPfbRs35f8tDPPJXX7HwE7gyIoru1tbCDv4s7qIqC6HLiTjGtnLLaUMDDdoDxjP/eyVekBlqyXbCvmSxc38BfTddgHL0hZEnWrxUFu0V6T4vSGJfNB+5QBSA4zo/WkTa6y1jLlhbjMNY9M+7RSOqExAGa00rdiop/pWtuSJj28=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5277.eurprd04.prod.outlook.com (20.177.51.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Tue, 15 Jan 2019 12:30:23 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%5]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 12:30:23 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>
Subject: Re: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Thread-Topic: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Thread-Index: AQHUqXKJSi5DEBdu5UKeaKryAiY5Gg==
Date: Tue, 15 Jan 2019 12:30:23 +0000
Message-ID: <e892304bde543b86a9d0ad4409d0c6a1f509a312.camel@nxp.com>
References: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
 <20190114005600.GN11426@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5277;
 6:jHtDCYatfdSjjQNcj6Fk+AWgSTcXT8B1/LMpJ/qU+AhiUdWyFNogn/3Xx7U+b/OXp+XmzGXnDQf5HSIn1no1x/Kg8tk+6UViNeNXjfPoKTtapd0Rv5nzsagX4ayVJQ4a2366CbQ9XsAxb7D19A7JCuk8/NwhcANhq2W35bI2ppgKgtXwjXVMDej4D46iSO7GuVCvIGa8ezV7dcTR2RfZ4l8rf1cu4bLbZtzv/PYhQKGohwtFSv9Yr8V2bN7H69iuxcUfzDj12bi/3TwTa2pujIyP+BnyqEHjcK1JBXuAb2/q0QeqINRwwFjXEXGtWPBKVPLF2ad8Il+GYFXm13BaNWvJD40Ww67GyZhmAxjzqkG1qGwfhGXnFo+EseSN4VX7Lt40j4Oo1p+dx6fSHWkj7xlYr2OeA3whUeel2frhhYO+/Cz4d6JAxgmWwT3MNym0UHeoxfa0DyMsoIwaVrsoDA==;
 5:+sLzHyBNb1YgBA/8rqYLKGb5xOAUIu6Ymosl+R/Gtb1QPRrs/Jl9lK9IUC2+oAGN0vukdkgEgA1dzT40B9vhJygCC2wKvWealtHQYv0BgNoaQYHFEg5X6ATuOP05K+rPV19E47ZKWHE6NatWmWqxUiOhlBSaxqveZicGk+HCDIS6DFSZojS+fJKyB7de4CBKMA2+W3K5Gm8VldZB1udqpQ==;
 7:IszjyN8rvbekkePTOV42Bszxl/GLd5B0MYitlVBugU8AR4Xm5U2upqjP+NejJBzQEUX+1Iz19RxUP+UET6yUuVh8AgjQCclRimhpZbgU/iPCGPqMZSTpaL3GpU3foUL8Z9deBwyE+npUWDyeGV3BhQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2a8c069f-9a7f-421f-0dec-08d67ae538bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5277; 
x-ms-traffictypediagnostic: VI1PR04MB5277:
x-microsoft-antispam-prvs: <VI1PR04MB527724F34432504E213C0030EE810@VI1PR04MB5277.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(99286004)(4326008)(256004)(76176011)(14444005)(6506007)(316002)(118296001)(6246003)(26005)(446003)(186003)(53936002)(2616005)(66066001)(97736004)(86362001)(2906002)(36756003)(53546011)(102836004)(6116002)(3846002)(476003)(14454004)(966005)(106356001)(105586002)(6512007)(478600001)(110136005)(81166006)(68736007)(486006)(5660300001)(6306002)(71200400001)(71190400001)(54906003)(229853002)(8936002)(6436002)(50226002)(4744005)(8676002)(81156014)(2501003)(6486002)(44832011)(25786009)(7736002)(305945005)(99106002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5277;
 H:VI1PR04MB5533.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cGwwBz+WjcjCRSczItDPJwtsC6gfTamKcRcSZQkJPHC00zHzftbBq4fNLWtWUMG3+3meOHEb//0hrWACBshag4xusBoK6UasD8AM5vMF6NxLHe3GBaQJSHQfyCYBt5lb+M/5bagbB/JwTNV+GJ51v87W5KlIuS2+k//Sq/xyg5W0CvRT7opDPsrnRE013rK6sw4IAQ4L4FXI4ZhjozQTMpF3il/8cWDm5VORqQVm7TOVUBtcNOkZfx7w+889Eh/+fZMm80JdfMkPm0zVp6oG6dbNlxX7nEZx+7+kfF/xqE5BAnvcql0aAuduWOrDxJzMtCl0pZGQfngW5mnSDvRG4kivcNg9B1h+gJoxNl5GEncJJqYdNJWm8rBD4J3QLKec+9Gn++6pZawf9h3tY9QWXwN2aSar3vTKYkBnFQPq5Z0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <792730552A7B8A4E8B6CD2DF20208615@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8c069f-9a7f-421f-0dec-08d67ae538bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 12:30:23.6710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5277
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_043030_714949_5680AA6A 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: Anson Huang <anson.huang@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/14/19 2:56 AM, Shawn Guo wrote:
> On Fri, Jan 11, 2019 at 05:57:30AM +0000, Anson Huang wrote:
> > This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
> > states supported as below:
> > 
> > 1. WFI, just ARM wfi;
> > 2. WAIT mode, mapped to SoC's partial stop mode #3;
> > 3. STOP mode, mapped to SoC's partial stop mode #1.
> > 
> > In WAIT mode, system clock and bus clock will be enabled;
> > In STOP mode, system clock and bus clock will be disabled.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Applied, thanks.
> 

Hello,

I'm not sure if anyone else already noticed but it seems the
arch/arm/mach-imx/cpuidle-imx7ulp.c file was dropped?

It's not in your tree:

https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/soc&id=cf2d2d392906f5603cf0d0f3630f6386babf7e4b

This causes build failures in next-20190115 with imx_v6_v7_defconfig.

--
Regards,
Leonard
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
