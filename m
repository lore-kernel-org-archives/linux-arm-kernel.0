Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D46C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:02:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529FF213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O0Jt7o9p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yL8T4cPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529FF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kv7IQLQbmCqfl28CuE6uZEyCmqwpBUuZKGo9emUViRw=; b=O0Jt7o9pQd52EA
	DwM/+Tad/UcqUs4/+Z1qOPPufCEaJazw9TIr4OQDhXicmCRc5f+U0+Z+2bUWi4yweqB8z8lanwTpp
	XX9vTPiCeZ1OhRYjbjk7y1e5eXFwhZr0sSvDEeFAanRakr4DefTlhTHIVSl920vDv0YV9at/a3LgO
	HgNqp3KMFgY8vesPPg136tNUv1/8JUkdfsVNDefAn/c+lkBDr2nozZaeTxh2HatC9BC/+cMGmpJX2
	BjniC1ASVoJ/0Tx5UfAKwWLRcKuhgm56KpDMAt1qkLzhOwgI+ktHM5o15vu092FbeiBUTt2nhBbIT
	FwXgPh8tfygmwZ0nMw7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyYck-0006lU-NA; Tue, 26 Feb 2019 09:02:02 +0000
Received: from mail-eopbgr20089.outbound.protection.outlook.com ([40.107.2.89]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyYcZ-0006Yi-Ca
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 09:01:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL9vYvjjIXfpcTXSlDNl4vQVejmjnjtenKNBKu52niE=;
 b=yL8T4cPfQY5s26GdV14HJSemNL8T8qe9IzctF5MR9PtsTZwyATwCQ/htDg4eqed7VufYn9enc3ibRYoKBDI1Vck26cPZPThrYiabxBZCTdDGbrIz5jumiiX/FB4/6UabYBqXz23Kvrg82gtNLkx0gJmy1TlF7looLeqGhc0QhHw=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4001.eurprd04.prod.outlook.com (52.134.93.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 09:01:48 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 09:01:48 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH v2 0/2] Add and document the i.MX8MQ OTP controller
Thread-Topic: [PATCH v2 0/2] Add and document the i.MX8MQ OTP controller
Thread-Index: AQHUuwj2Cc/A///8P0qiGlZUchVYHKXwwq+AgAEpxoCAAAFHgA==
Date: Tue, 26 Feb 2019 09:01:48 +0000
Message-ID: <20190226090147.fohb7ez7pprnxfvb@fsr-ub1664-175>
References: <20190202150638.13672-1-ccaione@baylibre.com>
 <20190225151127.elg2iuaxa4otdb46@fsr-ub1664-175>
 <e0af9818-86cf-c341-61a4-0a1406b07880@baylibre.com>
In-Reply-To: <e0af9818-86cf-c341-61a4-0a1406b07880@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a5bb616-e686-41c4-cff2-08d69bc90a76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4001; 
x-ms-traffictypediagnostic: AM0PR04MB4001:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM0PR04MB4001;
 23:4eXHnzgpI9TlLcb5ScFVFlfddQ+nvIPPQRouKUDNS?=
 =?us-ascii?Q?F698EaG73pQh7Yp+Zpewb8CcMt9SNAwtpcClMPH0oUOepRUz/PhJrW/Bymz6?=
 =?us-ascii?Q?rLU6st4D7OCuKzxMGo3EgMARZHNZtdVO3ZlAShOHg9DaDvWE+UU/tJkZVnRJ?=
 =?us-ascii?Q?hJvjVGhYSv2qhwnblEc2wT0cu+GDztdMyPqmIBUB8Zr1wn/Iif2qj8lnd0bH?=
 =?us-ascii?Q?xAilf9lUngIHht1VQm7Vh4M2XCgu1rEKVmo9cZ9wftIjkoD3nDuW4vDYrbEn?=
 =?us-ascii?Q?ZrclSVqa2tQAK9tSC9Lz810Q5Mx6yZ23nTqEa21zpcecCvIuM9cZV5gDcnun?=
 =?us-ascii?Q?Dy6iFaRa/IfT+ldT7lW7od4zYLjuRv9YYxFiJGWiy94lRuLlubPWSxvFWxHf?=
 =?us-ascii?Q?YUi0oBKfFZnCA10Dv8aFGBsHEjpzdP8fBD5d1L6HoZF/26ohIOoX7TbOKWCG?=
 =?us-ascii?Q?/HdE/ZZbsDe3lBlRFqaw8EOybdXBY+eYgFnK2EheyHTehQE75O4u02UNrx+c?=
 =?us-ascii?Q?yun0xFmqd8u5VzRVD2LTBwRK/F9D+cTXcXCYTIIdlMdCmqb127z6byy9l2in?=
 =?us-ascii?Q?x/zqewmqMMNgaBrCfo4+wv5GiYlQRdOycGpaYrPH3zx7K6rsatHIv57Lcf+k?=
 =?us-ascii?Q?xMu4qy/YBg4bbISe+XQdmYmRSrZOtwQN5iqENfpVI+hq0NFcdMRGcNZM2a/N?=
 =?us-ascii?Q?1lcvuNkrMgbSSPKy3mwTvx3mbD+Nq53vtNEhBLvkgQ/5O+Px9U4rlcoQ0eZd?=
 =?us-ascii?Q?+l56Q6saNoGZKS7Hp/MzyV/IpDovQdW8N+eYSfDuBEuoN8s9TsazLYlGIOwc?=
 =?us-ascii?Q?JrYBCWvx2+/5hqteiOCeJZ5v4gZCFUlAaw9sRlYcdJtypIe9R2HglV2u4OrG?=
 =?us-ascii?Q?fonFDZyLrBoi5zWgg4aI8pG+hrjRfcWA0I8aXgXoznl+uhRTFsl2x9zOXwmg?=
 =?us-ascii?Q?BShEgphubrlcQ30kjsRtwB1VwsIriQbcoH88X9htCwK3lTqnbs1HXUen+xDV?=
 =?us-ascii?Q?ZdDlwvwoflKrxDUxBKUBCEIxFfEjK6bHK7TynksHV9wVKl5AcY7MidZNTPcG?=
 =?us-ascii?Q?LulsnS5MYDOxgIBjkBDokukkV3a8m3OXe/Vg3o/PvxeQx6BltlQmiVnlTcbZ?=
 =?us-ascii?Q?64qG7wHZ8SKUeekIjfqv50akLOiweyiSht0Qd9a9YvPKdwBxorws1Q22kIcH?=
 =?us-ascii?Q?PlpcbOmCH/z/AXcRaRkUuPNcT8I4dGvyxA/ZO9ENzflcWAinVMyufTR10+RL?=
 =?us-ascii?Q?J+kBTNaUsCXK39n3FWv+u9jybt+eH7SRcvM30CKhkLjDFX7p4vWzoraBiPRw?=
 =?us-ascii?Q?M8OE90GpIcy5QVB7ZvbXbSJW5CcnzfXuUtw7qLbaLRE?=
x-microsoft-antispam-prvs: <AM0PR04MB40017881C2708F80ABACD716F67B0@AM0PR04MB4001.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(346002)(376002)(366004)(136003)(396003)(39860400002)(43544003)(189003)(199004)(446003)(478600001)(97736004)(76176011)(11346002)(66066001)(2906002)(99286004)(6116002)(3846002)(316002)(6486002)(7416002)(6436002)(54906003)(7736002)(305945005)(14454004)(6506007)(44832011)(476003)(486006)(26005)(8936002)(81166006)(186003)(1076003)(105586002)(9686003)(5660300002)(14444005)(256004)(71190400001)(71200400001)(25786009)(106356001)(53546011)(4326008)(8676002)(33716001)(53936002)(6916009)(102836004)(6346003)(81156014)(229853002)(6246003)(68736007)(86362001)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4001;
 H:AM0PR04MB5779.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1s/r+dVZxeC7ZBTdKeJe5NxoZinfGM7IeFnF6GQVX+l5WXWmaXiygetFRCJLcwNMHLr9bhXZxwi2A6fawAV9xO8EYIPKHM8oiiOMISoaH78GzkJDL0JL3aHvDUq+C2OwvPhaOaSbO6TURsK5BeHUurlCL0gnLCURLKx8oq8maWLIFIowun2QLBdWPP5RT2E8C15bHxGwHJvXy8baj7CYh+/UgrZ4T7RUu0Jv7t2IjZ+T+MTjsX2IoIAGQC8eNyaIQJ7aS8UzjPYI1Qf63bAvw+NJ6m1xeUeKM0MHd22jdGkm57Z/WjD6y/EK51CpjXgATTC13QAE8QF3v05hMInaBc3ajh96q3BIVs3niut4poAhN4mWArzj4YmNJjLACU5psqLf7r8NGQ3mWsxzaPEpZ1peKjosgypL2eKZ8kkTYDk=
Content-ID: <8DC7F742E4ADD548A54687F54AFAEB12@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5bb616-e686-41c4-cff2-08d69bc90a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 09:01:48.4403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_010151_746959_BF549F10 
X-CRM114-Status: GOOD (  19.40  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19-02-26 08:57:13, Carlo Caione wrote:
> On 25/02/2019 15:11, Abel Vesa wrote:
> > On 19-02-02 15:06:36, Carlo Caione wrote:
> > > Add a new node to enable the On-Chip OTP controller and add the new
> > > binding in the documentation.
> > > 
> > > Carlo Caione (2):
> > >    arm64: dts: imx8mq: Add on-chip OTP controller node
> > >    dt-bindings: imx-ocotp: Add i.MX8MQ compatible
> > > 
> > >   Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
> > >   arch/arm64/boot/dts/freescale/imx8mq.dtsi             | 8 ++++++++
> > >   2 files changed, 9 insertions(+)
> > > 
> > > -- 
> > > 2.19.1
> > > 
> > 
> > What's the status of this patchseries ?
> > 
> > It would help a lot if we would manage to get this in.
> 
> Uh, for some reason I thought Lucas was going to take care of this.
> I'll submit a v2 now.
> 

I tried this morning to apply and test both yours and Lucas's.

Your second patch overlaps with Lucas's.

Plus, Lucas's patch updates the the list in the description too.

So I would suggest you send only the dts update since Lucas's patch series
already has R-b and it's good to go.

> --
> Carlo Caione
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
