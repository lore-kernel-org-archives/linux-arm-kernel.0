Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE7DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:29:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5BF2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dGqF8zpO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lHJu06y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5BF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sMYtuoZ2VN0LQsMaBPcQbYRVjYJU11Ue+GVz7tQGwU4=; b=dGqF8zpOy1UEk4
	INuRzGRsx9hcfKJVhyDASWO3s4NWGGHmBVvAzKK9OyWisUualSirgDcmjFC0DxFugOFYSaKSgWVk5
	21oYA/BXRt49Rr/xZPjMbV+RR4VTPfF2PINprlCf14TCQ9QlpcKoJKV3adFNlL05g0n7VyjtVmX9+
	0jpLkv2nhwf88kMH7qGaOC8h+PINgmXchfQcOtRMKNrpQw5dngi6esqu9SB1N/FW5l9dKZQgbBLMM
	m1OSSZ3IRmQ+r6U2H88Z8WtZigHYKqdd8Tqxd+7a3fHRK0wO+XxN0vqd+ALhBLL+a5jsR7926sEFt
	jHJS9s5S8TMbqGuFlOsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTzX0-0008Lu-DQ; Tue, 04 Dec 2018 01:29:46 +0000
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTzWx-0008LW-5D
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 01:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIuF8spFsMvJiPqd5S2k0AfyI1XX7tQaWL7yynqph6w=;
 b=lHJu06y4mChyMaTUJEiLNjgnSFh1iYvhGNGJHYwm7kYDEp+46QTxJzvuAA4iD/98v4SPif1gW6Pmi9rwejbdE/m5ADbHkwlPILvl2IKVlJHEMllS+b/DzUPy+pG+Q9FPQYHfEjFLfXeh4EZN1wuRbGXzpkvAjOcCWBi3Thbpix4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5281.eurprd04.prod.outlook.com (20.177.42.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Tue, 4 Dec 2018 01:29:29 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 01:29:29 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V6 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH V6 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUfBop1Xq5Us4kAEeJejcBpfY7TqVthW+AgABjuOA=
Date: Tue, 4 Dec 2018 01:29:29 +0000
Message-ID: <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
In-Reply-To: <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5281;
 6:pVyt9fnd7lBGoIIrTaXetOHt6h4cXxaxhD5tHe1cSc2wu7VUKSopUxhRcy+nfpSFOJtGMBW6eRRG55/P2jNZtZqpr0psMD3jBskxPbfC6Mrw5w5i40yYqurTvtQCkuwIsY+yaCLtFvGfToiBxDC1loiXsxHNdrY5MMOC3U5s7+QFQd1zpWJg18jwZlZMCKm/KnO4RofFsXmMcxCnIn2ThTI4jVn6ovK5IL4xl8wdusxgLWYnZtSb2fNGF3DsAqS6ayKevNMIbq2RI1jmtdf6eISuIkTSMZzUmUrfH3D9Ti+/x8LVRR+xM5tLx2K4dTj+qz0xm1tZDt+wKEjQRvOOiqwMJWakXCRaOcmZSQoeB3Q40LV+vCrbrCZzS1PJbabF72aTUtGutCrufeNDI9MGIQNnLjN0eU+jblMRDZ+GWp2hmr/fEcAzc9NQf+HcNyr9ym80jy/JWOeW1yh5L6jR5w==;
 5:SXmhNaQgXMxcf7mS6g7jxbyg+KUfzoAWHMSIyQaw/HiOT2fRJDeBeBBIor0se04jnmK3zc7aLkmOqUydgAGt2znngp8NWRJ1zdsCjrmT25A5ILi3tRYZKzvJG+yrtzUe0vzFRc/R/9dEswvU6aGivRwWI9Y8XQQtzz3NllpfRCI=;
 7:uN3cDRitl2I8MR5q8n34Q7VKMH9mGDn+TR65xTlaqYljkLxI6e3/TqJiaPQ0fb4vYqZwzvvgDcEODIKWF+CtQklBMsb1kyX5klZlopjnSSl4bUJFjU6bQloKRkJ39oaVZHy0YTs8Ncz+SRY+ne4/3A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 405910cf-df7e-4754-2dd7-08d65987efcb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5281; 
x-ms-traffictypediagnostic: AM0PR04MB5281:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB52813980F3C8F8D93C54CE0680AF0@AM0PR04MB5281.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231455)(999002)(944501493)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5281; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5281; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(13464003)(14454004)(2906002)(5660300001)(81166006)(8676002)(3846002)(6116002)(7696005)(68736007)(81156014)(54906003)(486006)(110136005)(99286004)(26005)(33656002)(8936002)(229853002)(4326008)(71200400001)(305945005)(7736002)(97736004)(71190400001)(53936002)(476003)(11346002)(14444005)(6436002)(256004)(66066001)(106356001)(6506007)(9686003)(74316002)(6246003)(25786009)(4001150100001)(478600001)(55016002)(105586002)(53546011)(2501003)(86362001)(76176011)(316002)(446003)(186003)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5281;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 98uTPsk7lCpVbGecP7D88OvTOZPJbVuConUIs0qPDu6/2W/WEfR5HKdg7HYihIFgxVA1xxhx1J7Z1VETR0y/0BOCDZINia26JRAfatULpwdBCDMRqczlhVVhYiGwtH8djHLv50AL4+YmpcBxT7yRHseRbev9Y4qc7C+GxIOZ1i8ixOCRjCWToKKhBNCzTs+XX10RP6Z4F1nCOyDOh2hgV13bq9sTtXUcMvp6Zs1G7/42EoTjlvl7+21qH4+w7vQIfn2VyArVuTWlKEnFsBaPJTd+X8oIdYOvEgqlrciBHfHKJybWc8H9WMfmm6QfJkWTWSsOisLBnzuB42WWGN5PWh8kYGeA20hk0AAjQ7lTsWM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405910cf-df7e-4754-2dd7-08d65987efcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 01:29:29.7330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_172943_203014_B1AE2A7E 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Tuesday, December 4, 2018 3:32 AM
> To: Aisheng DONG <aisheng.dong@nxp.com>; linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; shawnguo@kernel.org; Anson Huang
> <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; Aisheng DONG <aisheng.dong@nxp.com>
> Subject: Re: [PATCH V6 0/9] clk: add imx7ulp clk support
> 
> Quoting A.s. Dong (2018-11-14 05:01:31)
> > This patch series intends to add imx7ulp clk support.
> >
> > i.MX7ULP Clock functions are under joint control of the System Clock
> > Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> > Core Mode Controller (CMC)1 blocks
> >
> > The clocking scheme provides clear separation between M4 domain and A7
> > domain. Except for a few clock sources shared between two domains,
> > such as the System Oscillator clock, the Slow IRC (SIRC), and and the
> > Fast IRC clock (FIRCLK), clock sources and clock management are
> > separated and contained within each domain.
> >
> > M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> > A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> >
> > Note: this series only adds A7 clock domain support as M4 clock domain
> > will be handled by M4 seperately.
> >
> 
> I got:
> 
> drivers/clk/imx/clk-pllv4.c:152:15: warning: symbol 'imx_clk_pllv4' was not
> declared. Should it be static?
> drivers/clk/imx/clk-pfdv2.c:166:15: warning: symbol 'imx_clk_pfdv2' was not
> declared. Should it be static?
> drivers/clk/imx/clk-divider-gate.c:174:15: warning: symbol
> 'imx_clk_divider_gate' was not declared. Should it be static?
> drivers/clk/imx/clk-composite-7ulp.c:22:15: warning: symbol
> 'imx7ulp_clk_composite' was not declared. Should it be static?
> 
> which I can fix easily by throwing in clk.h into each file.

Thanks, I will double check it when I back to office.

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
