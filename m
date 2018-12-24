Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA4AC04ABA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:03:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB262171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BthWUsF2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uP1AZmVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB262171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VSMXsstoPLHwJY8670BxmcNPBydUeOhZ3EcT5LodFBs=; b=BthWUsF2zujxsX
	E6ZLBEt2G0Op7S+5Sa7Fh9Cjh4FfO3cVuDFKZNTOr9z8NyQZhxiLjgwS2R1dQpV4zp+F/+7OnjoKb
	eoiaoy1g+w0fXSpUl8Xtt70rmTHU27mK2D6kmH2Z4l8mJPYpHPO5OhNGhW3SmX4LyN9yqypAxLT2A
	YFi+4o4ZrcCfhepSNlgsP95yRxUUUOfLyg8XYvbQnDaDrC2fyzzI1NbpmcJhc/AZdIg48oR3QCK4E
	QABV5gXg48qvPtgdXMMyuzMXGnn3D/nAQIM7NkeYSWm4Mz4B/BQRRxKgrrjwCy1DB1xuwx1B3bEzt
	DzBDSbPcPOZc6qeuCVxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbM8z-0004B3-2R; Mon, 24 Dec 2018 09:03:25 +0000
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbM8v-00044v-VX
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 09:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvJJHunIA0dOFPojYvDatA2mJ0cOSRrRWN7jHv1NAhY=;
 b=uP1AZmVp2e0jFY3nAjDachZBHlyh9sgh1igs9ocwY1eKctWpsr6fAJ6w8WcWttVh8S7uK33o06oCBXS11/ikNWHS9lcpEBSXrCUkv7uCJC5OJAG/tGUCwjWdhNX1czMwB8+e7XkuffzBMj2VQRt+npE0OnElDnsPveeY4azFMyE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5235.eurprd04.prod.outlook.com (20.177.42.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.24; Mon, 24 Dec 2018 09:03:08 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:03:08 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 dl-linux-imx <linux-imx@nxp.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH] clk: imx: imx7ulp: use struct_size() in kzalloc()
Thread-Topic: [PATCH] clk: imx: imx7ulp: use struct_size() in kzalloc()
Thread-Index: AQHUm1OPkBqOOJvyT0mKdwNiqNhtGaWNlY6g
Date: Mon, 24 Dec 2018 09:03:08 +0000
Message-ID: <AM0PR04MB42110CE89585A5CA0703944280BB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181224064025.GA9588@embeddedor.com>
In-Reply-To: <20181224064025.GA9588@embeddedor.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5235;
 6:oXho+KqmEqjYCanWjUCwMupc3Pwbpk3KM8dDZZzLFiqr5NAy8DEFISLse4xyBefmXxLnidIhjHzFwmloZDD+JTVWy9hbvTG5/1m38DCY6yvfsYIA8zR/9VSB9nKMzjbnJIi+pjemTECZ3BjDZDvMNpC14Y1wjmREhIFOHdmFyy8nFZ3sYSoTqA8CNWME2v4G4u4vQENQBoJheFPL3Wf37EGUaxhB8yqZ8bYJybE6RfJoRUVkqaxw15Pb7mHhOQKuKW6ZTU8tqkkWrfvEfuPbItf+gRcTWBVzz4aqocIqdjrya82Gw4ss28TWTj5fu5LKmd0fiNi0eRekUp/cHrmAT/Nd18GRaWQrnvI7Ksqk6EJHVW7WL5aPNuq4ogI+rf+tv+ven1SBQVjj/iSOGjhWL7YuclCwgSZfagNnWHRLvoPkf/dIyB2WHapEAZQh7UedPGw2rCjDJE9rY4X4opkQZg==;
 5:t7V5eQd2MA0dlOxOXzohPJjovLC7GSm9kejYCnrqF7M6N1eSSBuJC5RojGbHiL1cpSTtwN0RMGfupR/PhL0ZkOcejkY/tYu3/LKipZbIVCRiSsXGmeE7xTwrJwylgGYm118PxLCEO1PX8nbmD7zEcGOo3IQOOVc8ssi7KAosOSk=;
 7:dhL9M/cEQdibAsIxsoi121mlFbiCh3BesKvKcZRifKBj0GCPIPZi0DDasA9faPcGEk3CrE57QM/j8TqyORlzO3LXBo9+NZ4RB5rHlNC1NKkMVAeJub6BFMKVjn+4LMJD2Uom4nUL/Uf81S4AX4hG1g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 05b81dd9-b081-4343-14d2-08d6697e9f9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5235; 
x-ms-traffictypediagnostic: AM0PR04MB5235:
x-microsoft-antispam-prvs: <AM0PR04MB52357BFD0541A249250B2CCA80BB0@AM0PR04MB5235.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5235; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5235; 
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(13464003)(199004)(189003)(81166006)(81156014)(99286004)(2906002)(76176011)(5660300001)(33656002)(8936002)(186003)(6116002)(229853002)(486006)(3846002)(476003)(4326008)(44832011)(478600001)(26005)(446003)(7696005)(11346002)(71190400001)(6506007)(6436002)(6246003)(66066001)(71200400001)(106356001)(14454004)(7736002)(105586002)(316002)(102836004)(110136005)(54906003)(25786009)(256004)(97736004)(68736007)(74316002)(9686003)(55016002)(53936002)(8676002)(86362001)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5235;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BM76e7ivDBLAK48d7J7eKbZ7888bGYNtC3JTexy378jmINcNQYSkpIW5x4hgH7neCdyR98FlA2lkmpAbDyUZPKLdO4DUzEuvyfLBWIMQVS/+AWJdfX7XNufR/A4khuq94Oe/nho2AVPjAKEjBR1EJXOtrosbLLZMcz6YPttsqTkJpGq7AxGSmzMqLUvU0w+uR1JP7/D3OyB648es9l1ZojOUBeh1p27uk3MXEUx2pr97EplhbfGxlFDW9XTNuMdqPVgd97e7lJYxPMJ8iYIisGXhDZl0UweZHeNUASWcWGt2Ro3sETkoSi5uYodYu6kk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b81dd9-b081-4343-14d2-08d6697e9f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:03:08.3521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5235
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_010322_028821_5688FCCB 
X-CRM114-Status: GOOD (  12.44  )
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
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com]
> Sent: Monday, December 24, 2018 2:40 PM
> 
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
