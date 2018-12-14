Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4495C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:38:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BAB20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LAIFxjSQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QmOIWbMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BAB20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6XOFujgkms/C9D7tp/d1KNcR97XDAde9DZPltCNHhNI=; b=LAIFxjSQ47eave
	hRPr/BWWw1YgqTP+pQ2lygWFgarkPUaJ+lRK1eGrbF8X2HKuCR22a8SJtYuqfTBMeavn0tRLD04Si
	YCkz9cHgTfemmfe8VUmggvxw+zi/8sKIUhCa0Oy1UMKFwGCRL1lpP46AyLGio6C6O7cu8ClaFPlXx
	CtbaGrZU6nizC51PeTJdgkuv+BRmvfC4nqvjGr+yl8X35dy5Q6W4f+q9yPrCnWyKPmwQvf212O/bl
	m+tJB2tUimuLnoTBA2HuBO6bmNBE3uOW36/FyfkP/RcygNFleHPKOCemyEzd/QoZo6VYd0y6eo6a1
	nNb9w6SQxeCsE9qId45A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXgB8-0003jv-LE; Fri, 14 Dec 2018 05:38:26 +0000
Received: from mail-ve1eur01on0629.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::629]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXgB5-0003jU-2X
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 05:38:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUgSVYkpwfiEGLIVytW9R/tAndMTjClOJ4ZvtK4/VEg=;
 b=QmOIWbMBWAa420nWqSVYCDIt4ieQoSBQEmUxjx5ZdoxhvBUZC5dnh+PksmSUqwEV0h5qnYW7mKmiZ3it8K/rgX5T1jc9I2c030LYiCxz0yjlv+Y5BTNuoPorF9AlRPWzpMiZOKrLTG66V3ACL/sAx2tICEhUQdUo9riQTVNICdg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5858.eurprd04.prod.outlook.com (20.178.202.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 05:38:08 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 05:38:08 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Index: AQHUkvp+2I/kA9Gq1kKYOSfh1d+quqV9fQkAgAABMXCAABN6AIAAA+qggAAGT4CAAA3/QIAADGWAgAABMpA=
Date: Fri, 14 Dec 2018 05:38:08 +0000
Message-ID: <AM0PR04MB421136352C4D0A3A0A543BBF80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
 <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214031931.GD13243@dragon>
 <AM0PR04MB4211D692CBED348EF8C109A180A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214035606.GE13243@dragon>
 <AM0PR04MB4211CEFB586B7878BBB58FEB80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214053033.GF13243@dragon>
In-Reply-To: <20181214053033.GF13243@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5858;
 6:Fhx6pp44A9Hh63JHO40JeFDkKw3E5j7JoCNcx12kGJiGulQWtG+9H8c+u+p9KcoVMURXslQRg5wN/hzDxYxAN3cTNaP2zUJJrKiY1ISulTsGuXf7aGUYWwCCI+9D2dQGXW2/dPcUZ0RcinFdOttUmWDW3np22MzU2ls6t4RAz81F8193xJiKUCXxC/VSiQjK76E0TLdwoDz6NqKX9unTT0koVMYfc0nVd4P1rp8VWKLXtJc4nqORjCQMxG+4tGmfQyOOuXpsC0NboSAIiJUouU0ZMKgU2nFYN5HZXiv/9eANOIdPTgiWgf5BnMZlj6SqshC2P2iD2ZhrWeQ+WCP6TTNNhWxFyJv2CmdgUrkPcEbwG4QQV2QnknEZClO08hqCtjcMdUwDD5hUVkUa2+GGxqDqRQriMtT7ll0q1zRYcxPsPVrnjS7MxWR9DeJ9mpMEjBYoVuX+JzYOPaoisufQRg==;
 5:gH56ZvBopTrcr+8GmfUlH94LeratCjf23saktvouA6YBDDDRf7jIXZCV0iYbSzi42ExPwbKk5c7D+bgeIx3FcNTvzkHnVqhcBJrgdySebpbFRQM/6IPjT4Hkw6fENHAiRNdVSLeyNfZJ07tSZxAKBl8k9MSv4TwDdh6hakev3lw=;
 7:S234+352CvCUCVpJuE1X/JzhOmym4VPX+TbTdFnB5rYYCju4Jxbe+VIc1wkNlyRubqEa58jQH+hP53hKiMO0S3246i67+22WUoTJ4FZS7g6IGRS9t2jxpygzoIgtz8gJkKAy8M5Bd9PdE3MZZhOoVQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 003e0556-629c-49c0-b1e9-08d6618653f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5858; 
x-ms-traffictypediagnostic: AM0PR04MB5858:
x-microsoft-antispam-prvs: <AM0PR04MB58589C236295050109E70C0B80A10@AM0PR04MB5858.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5858; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5858; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(346002)(396003)(366004)(136003)(189003)(51914003)(13464003)(199004)(71190400001)(99286004)(5660300001)(102836004)(25786009)(6246003)(229853002)(11346002)(14454004)(53936002)(105586002)(44832011)(7736002)(6116002)(6506007)(476003)(4326008)(106356001)(9686003)(486006)(71200400001)(3846002)(6436002)(86362001)(256004)(81156014)(8676002)(81166006)(55016002)(76176011)(2906002)(97736004)(7696005)(478600001)(93886005)(66066001)(54906003)(446003)(33656002)(74316002)(6916009)(186003)(305945005)(68736007)(316002)(8936002)(26005)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5858;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TB4W1hKwt3jVpkerkSy+F9jSBVEGrLpEv2PlEMg9AIMeEcIMh/uw9qe9MBpFttfV62bM2W95cTMrxl+SKYIy4vwyJ037C40pelPJjIlvqi+wnyzwBInj178gJFTCP74fa2dxHbeP5rj0QoGYCD9Bna00wmf6SqNfgghHuwSO2uCWXjDj2uF0egbAX3wEKd3YRSyl1m4pkpDL0SuNM4dcCUuvx4b+IFWJfCnSIs5n0Q7GzhL7HXLgqkgmFCa23E0qK5LYb0NMdZ2EUG4gocb62eeUa8isChifja8DqLerIGXglGz3vHjVJJ0gWyjNInca
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003e0556-629c-49c0-b1e9-08d6618653f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 05:38:08.0652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5858
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_213823_181668_37009C00 
X-CRM114-Status: GOOD (  25.12  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> On Fri, Dec 14, 2018 at 04:57:46AM +0000, Aisheng Dong wrote:
> > > -----Original Message-----
> > > From: Shawn Guo [mailto:shawnguo@kernel.org] On Fri, Dec 14, 2018 at
> > > 03:37:47AM +0000, Aisheng Dong wrote:
> > > > > -----Original Message-----
> > > > > From: Shawn Guo [mailto:shawnguo@kernel.org] On Fri, Dec 14,
> > > > > 2018 at 02:17:04AM +0000, Aisheng Dong wrote:
> > > > > > [...]
> > > > > > > > Note: It depends on SCU driver which has already been
> > > > > > > > merged by
> > > > > Shawn.
> > > > > > > > So this patch series could go through Shawn's tree as well.
> > > > > > >
> > > > > > > To be clear, I'm not going to take this via my tree, and it
> > > > > > > definitely needs to go through clk tree.  If there is a
> > > > > > > dependency on my tree, you will likely need to wait for the
> > > > > > > dependency to land on
> > > > > mainline and then retry.
> > > > > > >
> > > > > >
> > > > > > Sorry, I should have corrected that comment.
> > > > > > It's not depend on SCU driver which is already in the Stephen's tree.
> > > > > > It actually depends on the resource ID definitions[1] and the
> > > > > > centralized PM related service definitions headifle in in
> > > > > > power domain series which is already in your tree.
> > > > > >
> > > > > > [2] can be fixed by defining them in clock driver.
> > > > > > But [1] seems can't be fixed as resource ID is shared by power
> > > > > > domain and possible many other SCU client drivers.
> > > > > >
> > > > > > Any suggestion?
> > > > >
> > > > > After [1] and [2] land on v4.21-rc1, you rebase the series on that.
> > > > > The dependency will be gone, right?  This is what I suggested above.
> > > > >
> > > >
> > > > Okay, that may need a few more weeks.
> > > > BTW, after v4.21-rc1 is out, can the mx8qxp CLK and DTS hit the
> > > > final v4.21
> > > release?
> > > > As I understand, usually we don't receive new feature patch after
> > > > the first RC, right?
> > >
> > > Yes, they will have to land on 4.22 then.
> >
> > That's unfortunately and may need wait 3 more months.
> > I really wish we can hit v4.21-rc1, then other modules driver can
> > start their work based on it.
> 
> You can not always expect all the pieces get in with one merge window.
> It's very usual in upstreaming process that the dependant parts lands in
> mainline with multiple release cycles.
> 

Yes, i understand.
Thanks for the clarification.

> > Stephen,
> > What's your option?
> >
> > Can we try the same way as Shawn did for arch and dts part?
> 
> In case Stephen is fine by pulling dependency from my tree, it's all on branch
> below, which has been pulled/queued by arm-soc folks for 4.21 merge window.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/drivers
> 

Thanks

Regards
Dong Aisheng

> Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
