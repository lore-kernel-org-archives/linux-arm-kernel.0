Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D2FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42253206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c3LWyLx2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uskJ22Q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42253206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eIJ93UDSYA64yeUUoF5rL/iDcBFIskrvxlR5ir7WqkQ=; b=c3LWyLx2sJFvFz
	BzOky70TMbmHoIkL4gYg3fNiaq9Iet/VloI9R3bKW6T9Z8oe6gpreuaEixU2/0EwSeknDZgyxYsfz
	H00DREeJgjZZlE46VUc1psrE0kgjncUph01IJDB8rB8mhRTCHXZzgFnebu9IygAm8MOlG2xSq37CM
	1peGaNaUKy054x1DOOgQ+LawwIW7dYj6UXB2ZX6LqSXOlPOqPz26gKZhug/7T3TcUZpK2ojM7gfIg
	bBGIqtTSmu7ytm0ubmyQAGdQQd5rgNYDoBm4VLE0gfxCk8VSS+1lcZBrKfSqWLgkz5zXRzWMugV6M
	9ZiNrzaWJF5EhtSfJUsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXpQ2-0001Xf-Q6; Fri, 14 Dec 2018 15:30:26 +0000
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXpPy-0001VZ-Hh
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha3GpKHNeK6I2npqRsWf31Jw0l0nbHMZy3kOuhgjvxE=;
 b=uskJ22Q9kpF7mzvZkCHcd8rzPUGRTel9sHrnEwnx2mHd2KKInTLZ285L4UZuf7XDDMfMqjXSKsTGfCEauz4OvcfdKTYy+4L+PFTFtoSaav23ppMq8NNiK+3uzv9yI+uxQhNUumK3wX7nsqTtI6nUmimKQjLWJyPopm6bIdejTtM=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 15:30:08 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Fri, 14 Dec 2018
 15:30:08 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <kernel@pengutronix.de>, Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
Thread-Topic: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
Thread-Index: AQHUk8HlzY+WhQB2ck6/TH6/+MaDIg==
Date: Fri, 14 Dec 2018 15:30:08 +0000
Message-ID: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::33) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3754;
 6:yd1MYxtAq4cDsZN/WvFR6BoXTgC2UqkY5q2mBeo6zwRNT0q5jRROpVhwQe7gkPBqxBTwt5sdBZyTi7QkCQKMOjgZaUMe655Cpfoz8QMsCRjWxtnkbIZ18+wSw9z1ZrjoIqzVlkVrxFyJ6VjMp6XbJZ2PFJ8AGE2bNC4n+UQWAkVUpwdw1JYaEjTvpQbYi+S9wV+96nq3CC0iGIQjpmnpcZf38IVl1wMJsNsWiDZB9pzkZ4btl2usnWQHTJqfh7PTJkaSpBw1O02eOpsUJvFeqKLjeQHuIbu2ZLaSaCZhJFO3pPUmbOYqSRSCBYXd5mrCrImqo+53DoobId8QkDHrsuB+qX/lsMTc2upbNQgMyC5xtF/83rif+cfaTAS4uo5dGErZGCa2Tt0FKJDTlpgxJfg8mKf2wyqbgAd1/5H96Gr7dCvs851G/Kjh7bwvGYuqc+DpSOeVMOQLxKC+Q9SBzA==;
 5:B0r9BcIKQwhRT8+63mCbTiCu3qfJz+K0olOtUcD1slDWBWNSvb2IHfqaN1IaJeFLyShK+cBxIIAko7I4VIJPuj2lQHHP1+vOR0RgXkTLcP0uXrhlXLtKEPMRgct9zfXxcIPPCqbLra7kIiP7YwYt3AQOFVnfUHPIhTD255Gf0ow=;
 7:aVJI0CEZtamO7Y+g2ddxHWGuD6wUXNKql6BIONpazf2q3bC70CusKnytiaPklyqRx35mlY/dDyfZbB7S4/UB5ZxDZmiJx6HYoQt6hCdSHgubadr0MhPk/SMr5XLPTGrtaGRsEWdwdZrLmHUXgEhozQ==
x-ms-office365-filtering-correlation-id: f402596a-b2a4-45ee-ccb9-08d661d9077b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3754; 
x-ms-traffictypediagnostic: DB3PR0402MB3754:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3754F6F4581BB5435D2CC3FCF6A10@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3754; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3754; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(2616005)(53936002)(6636002)(8936002)(186003)(66066001)(97736004)(52116002)(68736007)(4326008)(305945005)(36756003)(25786009)(14454004)(2906002)(6512007)(478600001)(5660300001)(386003)(316002)(26005)(99286004)(6486002)(6506007)(71200400001)(105586002)(54906003)(110136005)(81166006)(81156014)(8676002)(486006)(7736002)(3846002)(44832011)(6116002)(6436002)(86362001)(106356001)(71190400001)(102836004)(476003)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3754;
 H:DB3PR0402MB3658.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YD002cw7RFfUAsSbP3QcjK4dYsAN0cV3Oqu9os2TqNmTFeVxTqlEOlabqu3NDitTca0YV3ync2PW0CaU5iZoC2Agpr2VAv9vlKmR9oquC2I14Bw+pZtOPBdn7h6vQevScMxpOaQ0BWUZbyvR9EY6CivHCcb2klUdFQF9XT5shn5Z3Ayq2Ggg4XtW8B4HvQS/3HbpznOI/qWS159duVimhJZ8nlcz8g/fBcDWXU+2+cdGap9gLSfhVvOoZkgx5i+PNMz05V93Wf9qeNbcVr6B6gAzwu/LDvU+FxncV0zH+cjcpo5fPsYe1Aw0TWwa4tY6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f402596a-b2a4-45ee-ccb9-08d661d9077b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 15:30:08.3617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_073022_588001_4D3E1F0D 
X-CRM114-Status: UNSURE (   9.52  )
X-CRM114-Notice: Please train this message.
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
Cc: dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is mainly to shut up the checkpatch.pl script warnings about the
"static const char *" needing to be "static const char * const".

Abel Vesa (3):
  clk: imx: Make parent_names const pointer in composite-8m
  clk: imx: Make parents const pointer in mux wrappers
  clk: imx8mq: Make parent names arrays const pointers

 drivers/clk/imx/clk-composite-8m.c |   2 +-
 drivers/clk/imx/clk-imx8mq.c       | 194 ++++++++++++++++++-------------------
 drivers/clk/imx/clk.h              |   5 +-
 3 files changed, 101 insertions(+), 100 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
