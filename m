Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7580BC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:16:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446EA20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rmE3ry+3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sa3VOh05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446EA20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0DT287BrUeD72Ki7rawuk8sUz9tzr7879kmwTHIfH1w=; b=rmE3ry+3sIk3dg
	KZpE108fcbMB9gCvOCxo7E5qcj3DgeT3SK9VnDWc+dWNpIF0vaj/WsnqvvM2bMjeokPSk95g/aRVR
	s0NmDS6Trhtdu+Rn3Iwe7YuAmapKzL3K+621YJ8wC9+5FwxsYJcJd1IWyp3LdMi/w8BqXS1f6iRzT
	y0m8E7J1FRfJeUzd6Vuul98Bf9nCHueF9YEAlYayVZvlXh6uH+S9x+R2fWw2gWnI0EeTSTGmEqFIi
	YMTj8MJshba4SJtSC04UXT3teIr3KA7rUtADHa/z+6ldhKuIZOf4YihedL+SgmiW8KD1a2HNg26r0
	plbqdRoEANI+KsDPo7tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXglY-0000q2-EL; Fri, 14 Dec 2018 06:16:04 +0000
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXglG-0000MY-0q
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 06:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK8e9vEur2yMaG3gDpadpfvSLLAk5k8lij0WLx2+1V0=;
 b=sa3VOh05lpry+xw0Twi9UXZ2H2lsAMZ2ylHoBWT3fImyYF1yMWIV2X9olgPwew6BDuDTzJUjV6zht2ByoOgaxinc1oRWPo1D5hGWrOuk8ZDeA4dBdaspD7aOFDUQQ+2gqa+PrRXT2C+QL9Z7yOLD2r/LAwD6Ps2tXdXFXu2w08I=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4129.eurprd04.prod.outlook.com (52.134.125.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 06:15:32 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.028; Fri, 14 Dec 2018
 06:15:31 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Index: AQHUkvp+2I/kA9Gq1kKYOSfh1d+quqV9fQkAgAABMXCAABN6AIAAA+qggAAGT4CAAA3/QIAADGWAgAAKNwCAAADXMA==
Date: Fri, 14 Dec 2018 06:15:31 +0000
Message-ID: <AM0PR04MB421173833F56341C5445FAFD80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
 <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214031931.GD13243@dragon>
 <AM0PR04MB4211D692CBED348EF8C109A180A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214035606.GE13243@dragon>
 <AM0PR04MB4211CEFB586B7878BBB58FEB80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214053033.GF13243@dragon>
 <154476762849.19322.6761040252503231833@swboyd.mtv.corp.google.com>
In-Reply-To: <154476762849.19322.6761040252503231833@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4129;
 6:CHPwvXARw7awMrwqiWCz4+8nR/vYgPz7Ve26KXPsnSVTB2hM6W83q4DpdcRDDds/zMYUHKlgJ2wakTlTdwPs5Zdc8d0Gnkml2QkMWMNsHNvKyFeOgqvDZz7vi5WjVuexW9vv7ttNmd4BCeqwHzRNyNRUoNa8Ft6WruojevKKl3MO+l5DGX6SxXTLD/Fvu2lm5J8OQ5NIOK7emiQCKMxHO6GLDm11LVxTgLrHQ7gDggEr4XohfZozGau6/rXjrDNFM750ghzqju2Iht7EzDg4kUqzHSO2YUXjTSBWvIkoDCbpeYLp5ysH5h8xhFwkTKpScOzdLjzQNq0lpOhv4+0wuma+LkKrqQ9bHvMwmmoXaxocMbndXnFGIHayFH8xc30LkvkERVZrGWzNmk3BH5yp0Elnv6AyXpfJtfPoaSqb0hCPd5lMVisYQR9WwnIZM3PC9khTajBYMVEcXGLRau1icA==;
 5:zxPF0CHauMQu1+rGWGIKj+8Zc2+cWDBDaRFv5xR1M0jw4pLYEDacktVHWI3cIgljIOohoC8qV9KO8YsghxURUu3GM4vlPyzDYeyXVhk+oNNUP+pQPDPqnN9tc5f+9mZq1+6JJeHvDhx47dfwJhAA5cswktNSNBb0ELBUuW9Hj4E=;
 7:UefmllgpWwany1H/BPZuFT7CXTaTJHwa2AcwP+ft5tDuzB2RjnSLgl1nAIuFHsAQIVX0f5odgfXmuI830J27tRZoYohoOIOWlDjeX2DxQzgkdFO3Fp2rW/gbVWtUQH58rtFaQjx+0oFfSIXvu1P+ng==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a0170ab7-3edc-44a3-c3c2-08d6618b8d5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4129; 
x-ms-traffictypediagnostic: AM0PR04MB4129:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB412937D6757970054DD5279A80A10@AM0PR04MB4129.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4129; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4129; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(25786009)(110136005)(186003)(4326008)(9686003)(55016002)(81156014)(106356001)(81166006)(97736004)(229853002)(105586002)(8676002)(54906003)(316002)(33656002)(4001150100001)(26005)(71190400001)(6506007)(6246003)(102836004)(71200400001)(478600001)(99286004)(14454004)(7736002)(305945005)(74316002)(53936002)(86362001)(76176011)(7696005)(6436002)(5660300001)(256004)(66066001)(6116002)(3846002)(44832011)(8936002)(476003)(486006)(2906002)(68736007)(11346002)(446003)(93886005)(32563001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4129;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S84Jlx1xemyUyO+J/Gpve7uXu0qDeW0otxcdeg8v2UMeGluLGpXHv1eq5JCu04ccg70zLUWCk21nGNInhKdqInTvAszM1jCxcYrDPI2pQoAwFZRRJcrILHdqkytQQZ4pw0Zdr5FCtgSeDqZc0+Poh3ErTKyC2NVbli6hlmB2zGCAtuWs7nAkSjz2sI+u/jREojDNEHstFpZUid8wEe5PPwlUCbtNAnOSQuuExB3cdYdGmagfAPPR6x6at1UeTS2NpFKAKbV5ruN09nbEUJgKDah9oOCuWE4LZKI0GoIOr2GUQh+K9xuuggNJSas+7uiJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0170ab7-3edc-44a3-c3c2-08d6618b8d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 06:15:31.8342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_221547_028321_9D3DCC13 
X-CRM114-Status: GOOD (  11.45  )
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
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Quoting Shawn Guo (2018-12-13 21:30:35)
> >
> > In case Stephen is fine by pulling dependency from my tree, it's all
> > on branch below, which has been pulled/queued by arm-soc folks for
> > 4.21 merge window.
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> > imx/drivers
> >
> 
> I can pull just the first patch from this branch and then everything will compile?
> That should be OK.

It also needs the 4th patch "firmware: imx: add pm svc headfile".
But I can copy the required definitions into clk driver and clean up the original one later
after merge if you think it's ok.

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
