Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09521C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:16:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8F92086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/qQtUC0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="cjOauXBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8F92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RR/XTqdHhc5HvJdj/m0hs6hEacDl0c+8vstyzUgf3/k=; b=j/qQtUC0aqFVg9
	2NO80oBuo2aG5sg5/zGeEvMnQOe0jZPXe6R1hj2IhUAXy2eIhKpSmozQWiGZ/0/ZifEuFI424tfun
	VPAdD5vh1K2vs/oAJ3X+mP4bydDEoArkV1Z4pFAhEl7EvYf2T6ZwLdPqfht/SOkGT+6OcWchNgAxJ
	Q/0nU66H1KU+nfPr0ZhfmsGwzE/j4aSD/wWv5QKqLl7oKUO6fRwU3i9V0S4+NSFKxyt3U08gSaomV
	1Qh0X3Ddvqr3FmtSw3+pq6aHsAfzIfrfvWIOe7SDVp7A/S1QanBAaVqq2qpfU9fvvTUi9Vd6lqKcO
	ok1NmEEyxQFb0yRxeAzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1groDP-0002AA-DU; Thu, 07 Feb 2019 18:15:59 +0000
Received: from mail-eopbgr760133.outbound.protection.outlook.com
 ([40.107.76.133] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1groDM-00029k-DY
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 18:15:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BerJN4BUCpKiYutBjMwenT9jGy+xfr6fVpz5HFZQsaY=;
 b=cjOauXBsK2kqS2OHKxvN1EP0pRWluSCs7jNKhdNfFeUwC4tJ497/b37Xg7vk+1j1/c6yFGGDsnevk1/khMjAcn1Xda1crQYP8yEjUwNIrq4VUjF6k6lGblWy8iOslzuECBueGa5mr91kkf+N2oFpMMXpYO0u5w4nssfCUhiLAYE=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3675.namprd06.prod.outlook.com (10.167.236.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 18:15:52 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 18:15:52 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Thread-Topic: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Thread-Index: AQHUvOg1I9SIwv2NIEC65G+x/YIYY6XUSEwAgABgM4A=
Date: Thu, 7 Feb 2019 18:15:52 +0000
Message-ID: <1549563351.3075.49.camel@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
 <20190205001721.18639-4-tpiepho@impinj.com>
 <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3675;
 6:oQBw5aoTaxgGHMQQu4wNF6OpfYoz7sFEDygc8c4YdaFDctan1wUCKFCefBbEdKZxBpww8nO2LgY9AADbvngfpHoK1gs1JTyO/EuomqaGCfsH2y6UCb0K6knc6FNqh/AFL7VhIekD5hYtFDXkjsJz80V+WlI1GtTAfBiX5Z61RRkXHdU31FU41VdxIWqe+NyGdj3npFwpHszzavIicYgYsXpsOQB6L0Cbsa5ls0McbipzJMYch2rMfmjahvx5FO4hWPNhwhdRMe7pPfLJem/DHJMmuUKKb8x8vtPGhg68iAs/7Seq3C7Ivb2x/ahS7ZzhRJGG+OADiX+Lh0CPWhZgGLO1g0VgwrUwSr/num5cmjtzuPKp6Y6ida+Lq23Ag/nWDtuIoyf1yzNPN6j3YgEbbifJHCrICfCkwwP4Y8+mENpioRiI6MuLZmwx7M30iGYH5A1jdUkHPnaalX3334Oaqw==;
 5:cL7Y88C7hvYKKU49NP6mOn7hWtn3i4AE/1FLePUAr70hq/zAFbPI2ZITouIQF9XrrhaK4gKq9GwfVnODDUUELczEyDP51jvI4qp+xKrxJ9fKKvVWdXIn71sjc9jezoHhov6/TVZxg394eGtna7zdXKRpr4GboRvHTv3OKX5vTSEz5YkZALX5dSyJ3388KB+cn866UqcRXsUblC2Qu0M8WQ==;
 7:HH6L6pj3AC/Bdoi/wpxOzmkooLC/66tAWKBpELxB6njVXoTH3MlHe5d06FypaklJbBc4eh76J/8z6ai1pK0HjUubu26nSpfhWxgh8UDIj5BBfQk/lkEFPr21AQJetkHGZIJDlOFrk3Rg21ymRIr08g==
x-ms-office365-filtering-correlation-id: b258832b-1e48-43cd-573b-08d68d284bc5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3675; 
x-ms-traffictypediagnostic: MWHPR0601MB3675:
x-microsoft-antispam-prvs: <MWHPR0601MB3675E910BBE4B2A2513A035CD3680@MWHPR0601MB3675.namprd06.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(39850400004)(396003)(199004)(189003)(4744005)(6486002)(2501003)(316002)(229853002)(14454004)(6436002)(5640700003)(6512007)(7736002)(6246003)(2906002)(53936002)(305945005)(6116002)(8676002)(81166006)(81156014)(3846002)(97736004)(54906003)(76176011)(14444005)(68736007)(4326008)(256004)(478600001)(8936002)(99286004)(25786009)(476003)(36756003)(105586002)(2616005)(86362001)(6506007)(106356001)(186003)(11346002)(71200400001)(71190400001)(103116003)(446003)(486006)(26005)(6916009)(2351001)(102836004)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3675;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LOExDB2iArfSpxmL3wnwBhwH0DWPcZ5Gpr/a/ckBTywKRWY0EjFs41I07ethVCIdRpEPR6nl0MYO5VGQIga2PR5nxPqZ4f+kEbYOIuT5KsEdDHZvfnY9My0tltRl+mvjB28T3e84RaBaKJs3aGM6VRmvaKc6oByvU5NjVcZB4mhDr0ahsOaK5oRpTDMUHMEIU+9L5AE17qqv46oBPxpHXihih4LgQjd0gDuY+gWDyo9KABEPe3BEY31c60e68ZoW+pI+IRfNcxVfM0TTtCFu67Ir7x5L9QIEWpLRZQE0Yp4qDurt4S7Og7hoGV7FB3hsBtaElhDs5oqi5ufyr2/TIn51PwiWqrzn1LK4V8M26T1LjjCpQW9xK3bJLzV5M+wdywJd+kvAPgTsZmbLRb0BBtOm8AQU9IjdkxZOtk5WV0k=
Content-ID: <D4EE99FA33ACB24EA8EF08725ECB446D@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b258832b-1e48-43cd-573b-08d68d284bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 18:15:52.7785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3675
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_101556_582353_492DBBAD 
X-CRM114-Status: UNSURE (   9.10  )
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-02-07 at 12:31 +0000, Lorenzo Pieralisi wrote:
> +			/* De-assert DCC_FB_EN */
> > +			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
> > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
> > +			/* Assert RX_EQS and RX_EQS_SEL */
> > +			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
> > +				| PCIE_PHY_CMN_REG24_RX_EQ,
> > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
> > +			/* Assert ATT_MODE */
> > +			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
> > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
> > +		} else {
> > +			dev_warn(dev, "DT lacks imx7d-pcie-phy, unable to apply ERR010728 workaround\n");
> 
> It is a nit but the warning log is not necessarily true ie you may not
> have a mapped address for other reasons as well. It is up to you but I
> would change the log message.

True, but I hardly want to enumerate every possible failure point in a
log message.  How about:

Unable to apply ERR010728 workaround.  DT lacks imx7d-pcie-phy?
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
