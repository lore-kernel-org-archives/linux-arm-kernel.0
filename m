Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84028C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:42:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A41820878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bGqwKclj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SL9FaY4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A41820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a1P64SLImaBNgHrOm0futJ/BRD06x2Vqd3M0WWvpNdU=; b=bGqwKclj46b+2d
	xAHlowDCZU5xIhNoyqWbsK+brnPSVi+zd5ROYBFasp6us6LPEuoxdndbUdydpjEgoCoes2/ctl+R3
	oGF4UYek2XXCTO9p9LhFPWG1nlzIgXi0oucptF4MT2/p3YjT37K8Fl8yyw5BdxtJke0hF6ao457Ng
	qsj0mXxvy9rj8KxFUU3UB3RPHP1Q8KdxlsQLg8sNn1EKH3giz0lUraaA6gVmCGOjopdlUITYARtH+
	QeqwSXGl6+Zjo1rHFNJr+AgNHWE66A9PBDIFDUZ71I6/AnmrE52ZhDJhWFCxupFkadp4o/4mlm77h
	3u8x6UWTp+Y4ZvkxqXrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUhkA-0008NM-SX; Thu, 06 Dec 2018 00:42:18 +0000
Received: from mail-eopbgr140041.outbound.protection.outlook.com
 ([40.107.14.41] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUhk2-00089G-Pz
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 00:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrKfXeWBrKUYKfnRRJKT45YFYPFUWDQ93o5BtCwDp/s=;
 b=SL9FaY4p0Ip22AoAzM+fgiIpWWah2RqgNmJZauUkKQejSRpWZNyiFe7pr8eMqK2j1Hhxt47zCXqmAoJJaZ9yN5A5bdXwiiHRZhFhrcZ1AoZ4ATGFFqFZ7TPYLYed3Fn1o2Xj31PWW+b3XB3bn+eaenpOY3/UHD9L+t/T1OAKTI0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4004.eurprd04.prod.outlook.com (52.134.90.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 00:41:56 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 00:41:56 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V8 2/7] clk: imx: add scu clock common part
Thread-Topic: [PATCH V8 2/7] clk: imx: add scu clock common part
Thread-Index: AQHUgaQ57574XhcTGkWdT/7YvWkhRqVtaiMAgABvc/CAAsiUAIAAUjsQ
Date: Thu, 6 Dec 2018 00:41:56 +0000
Message-ID: <AM0PR04MB421147539902242C56E52BA880A90@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
 <1542809234-539-3-git-send-email-aisheng.dong@nxp.com>
 <154386202048.88331.5253991483966563852@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211FE93C147DB95181E8CBE80AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154403897845.88331.2924678136478578037@swboyd.mtv.corp.google.com>
In-Reply-To: <154403897845.88331.2924678136478578037@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4004;
 6:M7Vbu5coBJdTxU7+hy5np1LjzcWXjlNZeRaTecyu9WRjL59NCzcNNTTN3UYru+ciPp9tuC5zIzaZIkhPxLD+ubRunb/zEMmwgWoHuKMoWp/JmPJqp8A6NccQFjsfWxpxhV6S7KMYZaCsTp9k4/HQPs1ziwVOqOZM0pPRnnO4FVq2QPBf1TnuGhQpKsr9JgesTgPDtJQOuBz2x6qHXgd2PyZlYV/KJdz+SiFzqqji2vGCeMm8RHvBZpAL687I8eNVcJKbFCq/AQs0M4iKmhpXw4xbyX3I/A1yt6Vw1J4bmygI3NnfiOP0SOCCDT/SFxC82L5wWZ853R9Cp9rbrwj2CvCU/HjiqskOxpcqUpL/CGMz/QQSHyCBINZPA/X3kp2DOyLUof7lboB3dMZHLWCe8BrqXMSF8n7eeR1RwLIqGsg3xEwrDMZS6aOF03nn9AlU2psKxAZSu9x5EV19ImOHIA==;
 5:06s6AwWJvurS8B+fCY6uKHsWm7m8K7MnADeWOC7H8ABrqOXkbxgCj/RIoFjQ8/+Sudxsz2b7ICoUhY9+zOUdIGjAIEirmgE4aMJH7WBQ0JLEK5nJN4v/9UA7CUHqJ1gTUrtzyVN21aDieRkJWqwvHFAVSNEDAfDq0jX9nfUOGkM=;
 7:yXx0HLtBNcR0x0MUCZYs20SNlbfKY1kaKsoe6keFyHZXokCVApDvOlzCXtlFIT5zw21elzcdTO1Uyoj6QxNOwfTe8VuuZWKuIORZ1xM/ILul3H8EsEmY2qFi/VfC0zHQhdtB2Q/RT8wpyImA/+tKZw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b0a41567-0a21-4d7a-0521-08d65b13a019
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4004; 
x-ms-traffictypediagnostic: AM0PR04MB4004:
x-microsoft-antispam-prvs: <AM0PR04MB4004931615D00DA0994FE7AD80A90@AM0PR04MB4004.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4004; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4004; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(51914003)(189003)(199004)(13464003)(476003)(71190400001)(71200400001)(33656002)(486006)(6116002)(3846002)(44832011)(256004)(14444005)(99286004)(478600001)(966005)(54906003)(2906002)(8936002)(93886005)(86362001)(81156014)(446003)(7736002)(11346002)(8676002)(316002)(14454004)(81166006)(25786009)(110136005)(55016002)(5660300001)(6306002)(9686003)(97736004)(305945005)(74316002)(105586002)(106356001)(6246003)(4326008)(53936002)(26005)(186003)(2501003)(6436002)(102836004)(76176011)(7696005)(6506007)(68736007)(229853002)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4004;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NAMfY07+yAJdkO59LEVR4fp53OSBed2qBhMXftswv7tOf6ZzFy65puIDwU1ZMc2wHHdEiSQydBs6CHyTAMjY4zf8vl3RjljQ01dK1Qb7r3hb28D183HuU9CZibJ2eqbtJ8ozgsVDxrPAqvgjp/xmxgs/f104rWCbLZL4O1QHjjM4MKsff6n6Pdn1smj8Dttmc/hOlzhual+oX019Opo2w0W9PHyTH0HktDjqPOl4EETqRtJnHVXISn8kqfs2Tw37oIEuhyggYuQO/zmdHF0JeGJfN0eLTAAiGCiskWv/SngtpoPbJ6ExC8YtlofS5UBQg4MbeUq3/t5ZI/JBZTBDv43QtM1BZOJx/G6mmPRjqXA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a41567-0a21-4d7a-0521-08d65b13a019
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 00:41:56.7073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4004
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_164211_637967_09A56ED8 
X-CRM114-Status: GOOD (  18.67  )
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
> Quoting Aisheng DONG (2018-12-03 17:26:01)
> > > > +};
> > > > +
> > > > +/*
> > > > + * struct imx_sc_msg_get_clock_rate - clock get rate protocol
> > > > + * @hdr: SCU protocol header
> > > > + * @req: get rate request protocol
> > > > + * @resp: get rate response protocol
> > > > + *
> > > > + * This structure describes the SCU protocol of clock rate get
> > > > +*/ struct imx_sc_msg_get_clock_rate {
> > > > +       struct imx_sc_rpc_msg hdr;
> > > > +       union {
> > > > +               struct req_get_clock_rate req;
> > > > +               struct resp_get_clock_rate resp;
> > > > +       } data;
> > > > +} __packed;
> > >
> > > Does this need __packed? struct imx_sc_rpc_msg is naturally aligned
> > > so I think we don't need this.
> > >
> >
> > I think this is more safe way. But struct imx_sc_rpc_msg is unlikely to change.
> > So I guess it's safe to remove it.
> 
> If the struct is naturally aligned then I would say remove __packed and only
> add the marking if it is really needed. It makes more work now, but is cleaner
> to do it this way so we don't have to think about it later and we may be able
> to generate slightly better code if the compiler doesn't have to worry about
> packed either.

Thanks for the detailed explanation and it helps a further understanding.
I've removed it and sent a updated patch series with all your suggestions addressed.
https://patchwork.kernel.org/cover/10712007/
Please have a look at it.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
