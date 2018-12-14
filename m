Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC4C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:17:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3359320879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MdB3LoYy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iHjnivK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3359320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LrpEoHbAIikrLGxB1s4HKVd8u1S/utgdXTZprglaB4s=; b=MdB3LoYyN7OU6U
	zt1ngGKyjXN+wIYQ0xuATPTmO2ICqQyuUmyyNTnYhmmiB0tOY3dae7woYojrFMFHv7TT1r1UNENT+
	r+7UwRn0bUl4n26hBz2PB1Nzv8TqbSLKlu/61YMbvJa1zZxXI6NDA7Q3+fYz7gHsHDseiIfCB+8rY
	38vnulGi2U8APjTHfEQ/B1KdF1DaOHlyZqC+lzfRyFC3togzk92vXvatv9HSHkU0VsCK32j3Y4gUd
	s1sbxC1b+P7/Xto/b3VLoqgT700mdXE3MPIzqfJ6N0rHfPJKztlNHce0i1GrTlUxdRIU7lfmgQZ3R
	y+iVTDbL0+yOxPrAa3vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXd2Y-0006K9-RU; Fri, 14 Dec 2018 02:17:22 +0000
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXd2V-0006Jq-43
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 02:17:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7/hTkjYX9UsQ9l+mvxUMXqPG9XztVHZMKQMyRjJZas=;
 b=iHjnivK9RIlZ3+6am8tp7HgPG+cBWfRExPN5qDsVQ1157k1xfVYcoKnDJ6dCH5tHL10tNUB+VzfT3ubMAs5UgP4+WwlNjIYEAvwWxkvFJvqq2twwYY6gHYTiGC50kDKn8VhECgN4igH+ACPyKAvVdSjYwGv9wc61Bv6O8ui6tAc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4756.eurprd04.prod.outlook.com (20.176.215.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 02:17:04 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 02:17:04 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Index: AQHUkvp+2I/kA9Gq1kKYOSfh1d+quqV9fQkAgAABMXA=
Date: Fri, 14 Dec 2018 02:17:04 +0000
Message-ID: <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
In-Reply-To: <20181214020533.GC13243@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4756;
 6:4QIHHiXQTXP6wosEXxQEoNc1GzRMMUQSIRWUcIan5Hf800EWHbSfTFIPYGM9B02vVz42LwzcVmVT2rZG+osMlq5+a+K8S4bWfm1H01tjmt7eMHROl69PIAj2PzT1qsM6IqptlhT57TCWxrnD5jHaXtmJJoq09IacOnU4jfhj3HENE6DNKV+GMQIPYDoVGYvi/DBsIs6oousU9+VPqEAbcnZN+UKyFdlFXu4cm7vaq0Hv8udqQcYFRLWAWdoipOKVMvenfJh34dEfGYB78IxKsbNIsDjA9LyXwISqi7FMvotnuOHb092yd5MeYuBbrY6Nlazj7HFRTAi8iDmd+cuoqVJiTIPE7y2c2GW43cj/Cav2NQp0Mowx77jhWTmVrfhwvr431z3saF1C6eaVlITQ1YucZpilRWexHlr4DeEgwhYljxIT/Ix12wU7mUSRDLW7nNeGxfZk8PBz/eJPdU+QOQ==;
 5:4/S97ND/Lr8xXF0af2Qu7szMmyg8QT2emMaicifGIb1lT6hdErTTeBLuPAoUYNqqtiTFlcNJTmVix6hX1q+j0cMy2zMIF9FHcKqUW6xpskt6WiN0EzL/aslty6DKsR7zXpZ7VQnkEk83Hg3QgE14C/wALCqFfUeNw5G+8O/SMhY=;
 7:vuGJc3W7PohrBkWpDV4Yxe4nfh1O8gan92bKmY2c2/gFrjz7eDAtwH+yBPPQsFTiZtVrurGTeZLrAqXkJ6VsFbToCcVN5AMHhDMnakMnCB00kV+lBOYv+4xtAE2MP9RanDjN+WPFx+j6JmnKuctOUA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 46b146a6-e713-46fa-f392-08d6616a3d92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4756; 
x-ms-traffictypediagnostic: AM0PR04MB4756:
x-microsoft-antispam-prvs: <AM0PR04MB475637D06E5DF7CB8C55E89880A10@AM0PR04MB4756.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4756; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4756; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(39850400004)(346002)(366004)(136003)(199004)(189003)(6506007)(478600001)(86362001)(6306002)(5660300001)(186003)(4326008)(105586002)(97736004)(229853002)(54906003)(305945005)(7736002)(11346002)(9686003)(106356001)(53936002)(74316002)(14454004)(256004)(2906002)(102836004)(8936002)(26005)(7696005)(6116002)(3846002)(476003)(76176011)(44832011)(6916009)(99286004)(6246003)(66066001)(6436002)(33656002)(316002)(966005)(55016002)(8676002)(81156014)(81166006)(446003)(25786009)(71190400001)(486006)(68736007)(71200400001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4756;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4p6zGnBJynuIXgroL6otv7I9fDdWh0BSJXvetuR+k3a+osezY47FXmccbRzn6rgHhWNEZm/R0rRn7uJJ0SC7hqzGlmTStkFJikt68mRi8y8BrDwN8/Djf353tcbbEJ9pjgAz4G0QYAlCd6kFkqgv7VtPGur0EuwhhLGW6yJ8GZjbrx8Xl51FalJqBeb7CaZ4vVO5JHSO7k7mSkxvvQSo7Cdl9aC/sT6O+FICeHFVbHRRRNhnadzNLMPk2IfY/DcG38Ubnvy16KO90r92/4KptUQRqX2F1G6E/XuG1Kx5+s8FSOHpNCUt6lh3DwyV5eA4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b146a6-e713-46fa-f392-08d6616a3d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 02:17:04.6181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4756
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_181719_164538_126B5835 
X-CRM114-Status: GOOD (  12.96  )
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

[...]
> > Note: It depends on SCU driver which has already been merged by Shawn.
> > So this patch series could go through Shawn's tree as well.
> 
> To be clear, I'm not going to take this via my tree, and it definitely needs to go
> through clk tree.  If there is a dependency on my tree, you will likely need to
> wait for the dependency to land on mainline and then retry.
> 

Sorry, I should have corrected that comment.
It's not depend on SCU driver which is already in the Stephen's tree.
It actually depends on the resource ID definitions[1] and the centralized PM
related service definitions headifle in in power domain series which is already
in your tree.

1. https://patchwork.kernel.org/patch/10664125/
2. https://patchwork.kernel.org/patch/10664137/

[2] can be fixed by defining them in clock driver.
But [1] seems can't be fixed as resource ID is shared by power domain
and possible many other SCU client drivers.

Any suggestion?

Regards
Dong Aisheng

> Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
