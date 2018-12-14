Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF2EC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:50:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1BE20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qlaEFKGV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dIaehzsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1BE20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RmEORN5ADXktQvmun1m1ZSpNtQGGsFicLlyT/J2kVkE=; b=qlaEFKGVC98+3o
	gb+uk3TM69Ej+NBW9OTf4QJsS5OIrAynczMmIel2g0KOTDKrxLS4/tK9857KWIyRVgUDXdHVqno/r
	s7/tbrvT4uYogngJYuMKtcMzgWMc5vO1bdUPhJB7zOmEvD9worQIbtU92LAJBnnttZZzd7MzsBN4i
	KWsEFAIQdosmRxIcYaOLGl8K+KGlunBOUFcECxwR4hH28xQejW8etRzuVr1tCeiSBiXTwx+G2FWQq
	CXeZZ5DBFzMdc7U/kDNbTmR9MZXVLQvyvJeFHfoJGRBZ2pzw2hlHwn9pCaUIfHY4XuffPaEWsEnvD
	XXlaiD4PnLO5gMhP/vPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXccn-0005t9-Jf; Fri, 14 Dec 2018 01:50:45 +0000
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXccj-0005sc-Qi
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 01:50:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kVXCPOXA7ftGkax5vHdDJ8qGcJPav0BzFUbXchckNk=;
 b=dIaehzsaUtQZrOaahQ3PaK5Lerl8paO3LmiSYYAhsA3iVpetSMef+gisxTXb5EB71rM6VguyABdSvJBwJQQeieGQBSGaqM1eEc0sOqxEwxaDCSOPftiZXmev2d8LNo7qhQe9ZywWORK6zxbQgMvvgH9Te3HH7B+1mPSihXxExX8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5011.eurprd04.prod.outlook.com (20.177.40.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 01:50:25 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 01:50:25 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUkoBFxXjd98YyekOIqi1bO3Y7g6V8TgAAgAA5bECAAO1DgIAABEuQ
Date: Fri, 14 Dec 2018 01:50:24 +0000
Message-ID: <AM0PR04MB42114B3AF8EEA0E8A29331FD80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
 <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211128F59A987F3D94AAD8F80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154475113520.19322.14425233247345284599@swboyd.mtv.corp.google.com>
In-Reply-To: <154475113520.19322.14425233247345284599@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5011;
 6:G6Nom2PgEGRLI/PYhVTXhTlhdGYEjkM49aXf3NFaej3iRDemjRS/ci9qz2YgevSnl/bjKmTD+wUwltDKXgv0fht2d73xRJ4MU+qD06h7tjeLP6H+5xJFo0JqLvVmuudiPslRf4ACsdskma2SjQ2w3ABS6rMWpCZ1ePf25IYTMEA57RtVUwlunqIJYcltU4nWrxkmNZ222D6lxTPWstIWDW7fqXSfVlO2ivHXJqP2mhiUSyYeSGYNsW1E0VnRa8fEKY1iZpoFnw6vmCj8VeXEt7AQNkICH6mEjYI/iQG8Md6ijTOGvLeq9l8C0k+t+XDNjgMkg1N9m0xBkqQRXuc1QLM0a53QQFsA6vz6Krik6Q0ltcWsl9v9RvFIsf82FuXTM9KTVoZ3HAXvlBH/FIojKZKTzrmsRRZeFqHG06KsUNy6pH11SJPci+seRGYmwLAcUM7CakFRhiPyBIe1EioDeQ==;
 5:b/Nl/ppcG5mdgHWyk2MwlyF5dVmSIeuXaK1KxNijca8JBe3AuB/qzrUbJiiGKftL1uN5rXpkQ4uStyJKfkJzgf9+mIZISilbRH58dCRrmTUYyv+wvJ7u2lpMVZYCqTH5mRuaOZxnl/UZq267I3i4SzpMXfeC66tLcQi4/DUpAIQ=;
 7:iSRxvubkPW84gMWSvDAGrFKfWkSSRS6APMJdNYFYtQQXHj6TouTxbA9x+ADaHhOYUsWCGlfGGhO0JumerhMvy5vcX+rQ2nUst8fxuEgiljEmHF+ln+R4e9fS3XY7LY2uP//ypq2pcU8b1wVks4mzYQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f81e33de-93a5-4c71-2b6a-08d661668418
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5011; 
x-ms-traffictypediagnostic: AM0PR04MB5011:
x-microsoft-antispam-prvs: <AM0PR04MB5011A93B8F3BE66D216AACBE80A10@AM0PR04MB5011.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5011; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5011; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(51914003)(229853002)(54906003)(186003)(256004)(105586002)(25786009)(97736004)(110136005)(486006)(2501003)(476003)(44832011)(6506007)(102836004)(446003)(11346002)(305945005)(76176011)(7736002)(7696005)(71190400001)(71200400001)(74316002)(26005)(66066001)(55016002)(5660300001)(99286004)(2906002)(4326008)(9686003)(86362001)(53936002)(6246003)(81156014)(14454004)(8936002)(81166006)(106356001)(478600001)(33656002)(68736007)(8676002)(316002)(93886005)(6436002)(6116002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5011;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HG1KpT611kxVQ2IAKiQjuxpi+oHve3QY354KZ+uXzOMxZRRMpJD0gI950MUw4piUuVuGIrgz6HeRTId0iO5C4ekUMHfDxfY3azDzi+Cm4R2W5nNtL5x86SNsUssvaK3yV2dOop+Z5RiwNvIrxtueWCeb54EqrlfN54sNtuNtaSb+4nO/tHltiVk5oJAHcErf4MUVHhH5OMQ8Q6Bm9t4e4B6VsinESneyLdpPODq3dlYAei5dvFpyQht2rCzCxwinf5Po4Vrhh2ChUSeeS3kZEunMLvJyPHWw1LuvAuTgIxAv1FabYKJMYPSoyqt+CfCh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81e33de-93a5-4c71-2b6a-08d661668418
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 01:50:24.9368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5011
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_175041_872311_27A7F5C2 
X-CRM114-Status: GOOD (  19.54  )
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 Olof Johansson <olof@lixom.net>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[...]
> >
> > It make sense to me. No actual damage as we support multiplatforms
> > using both MXC_CLK and MXC_CLK_SCU on ARMv8. And for users who want
> to
> > save one of them, they do can change via memuconfig later.
> > I will make it a def_bool ARCH_MXC.
> > Thanks for the suggestion.
> >
> > BTW, as I also introduced SOC_IMX8QXP in Patch 4 and 7.
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > +obj-$(CONFIG_SOC_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
> >
> > According to your former suggestion, I think we should remove it.
> > So I'm going to make imx8qxp clk an user selectable configuration
> > option which will select the common MXC_CLK_SCU. So a bit difference
> > from former discussion, MXC_CLK_SCU will still be kept a hide option.
> >
> > This way is mostly like how QCOM does and should work for IMX as well.
> >
> > Then it will look like:
> > config MXC_CLK_SCU
> >         bool
> >
> > config CLK_IMX8QXP
> >         bool "IMX8QXP SCU Clock"
> >         depends on ARCH_MXC && IMX_SCU && ARM64
> >         select MXC_CLK_SCU
> >         help
> >           Build the driver for IMX8QXP SCU based clocks.
> >
> > If any issue, please let me know.
> 
> Ok, so a library pattern, where MXC_CLK_SCU is the library of code that various
> SoC specific clk drivers use. Seems fine to me.

Thanks.
Can you help take a look at V12 series to see if this new approach
is okay to you?

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
