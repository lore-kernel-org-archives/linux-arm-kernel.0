Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4EAC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:17:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C752083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AsPO3U/b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nNAHO7l4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C752083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GtS1I0qV3nPFslnB7Y9Fe0kzh9Hl7CAhTsFOajBT68k=; b=AsPO3U/bmda/b2
	tuZHl2KuiIr/dPmwqaDdeIhkI9DWhwcdhVILITiyrw/Ixp1muv7zVfafx5UWXGwzV/ZQaZsdNOy2/
	E5+sACtYdXAi+7AFnpctrJV415B6nRq+bK+WB76Olr1cm0j4vvHS+OfzSBHbIM/SMCC6pv/V1LTXH
	s8uRJVFwhRXqf06ZyQoQ0M3zqvkUcOPjPMFqo5tdd1fKE3pEDI+dfIW4469+A+blSUu8mh2T7MmyH
	t1529/EJ9oDOKpiJg9YuOiDrfMpSthWD2MAFzeJqJMzdwnDrzSGiEAucsQjKVnMgf8ny/AOun0kmA
	RktIUKLxnwxa+75GBNTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVIoy-0000th-9A; Fri, 07 Dec 2018 16:17:44 +0000
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVIou-0000sy-W7
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:17:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WatkNR6r2Nj2+qeO3wCrUKBla1P5aMNK2IDKaGsDFSw=;
 b=nNAHO7l4bmu6oTKJh64oDF/n8uE5GAT7vS/I/jAqM9sDoAzs6eJ1akb2xmju0xwT7cMeocCizE7wLEXA4odnQy99h6oQy7zGLLWL9harI6bwFIPYMVEQL8bDyUUlEL/yf0l2aLLpPWO91IYViLpRGILr6PN4nr+BsiNWfoCQ190=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3623.eurprd04.prod.outlook.com (52.133.20.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 7 Dec 2018 16:17:25 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 16:17:25 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/6] arm64: add basic DTS for i.MX8MQ
Thread-Topic: [PATCH v4 2/6] arm64: add basic DTS for i.MX8MQ
Thread-Index: AQHUfELcnHGgzTZTVUSaNCzZm56coaVTDsYAgCCJYIA=
Date: Fri, 7 Dec 2018 16:17:24 +0000
Message-ID: <20181207161723.2u5z3sdobbpop4kz@fsr-ub1664-175>
References: <20181114175242.12468-1-l.stach@pengutronix.de>
 <20181114175242.12468-2-l.stach@pengutronix.de> <20181116232524.GA2013@bogus>
In-Reply-To: <20181116232524.GA2013@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3623;
 6:jtjA1a+8XfVfwfDqMC1VskotldbBDf5Qq3i1iYyorgkes6vGeOYuHA44txTfTRuN81TvjIiVY+UNd7atwwGFQymk6X2QRmAfGTF8nqbal4EbDshH4r8aY+BJIf2MlXo9uWNY/lKKN/L3IYX0+GNh1CDEMOOStxmbKMvEnsu5ocqWkL85ThgRGAzTtIyu+IyfIC8hkfX5VRZuvfqOniS0AXUCdos77vTGMyqbmQV4blQFiCS6PbZLYGE5qwgE+/PuUuu2X8SfipHhGfjgw4a6AehXS/68j4RdRFx5ObpEy4oU9EngBhV5WwpuUD74sr+ROIUH+lnVfz8k5w6z3XsQUbCAb+bD8qtYTK33IwDHbpYpbsvUi4u/KnIDAs9swJoSkGyd+XSGZQZFgH5PTl58GW7nfh2osKYmCpyMlzQabjS1pqW3ByfXd4Vv0Lhf/AchIO0NFmVEKf+V4C1OTqR2Zg==;
 5:63fMwYyup5DXh1d+5v9pWFX+r4i3n7PH+73Ol7Ug622cHRfB0TJojBGYT1G5KMHG7UZcf9o/NRBbH6yhWiNddQmN2O4P0zaqtJocSnUJyxglvXasjG36dFTYWGA0ExjZ0rjZEFw7kHmYKpPZ28BkPwqgnMfUuaRhPPpsGwnmn4c=;
 7:T7CWjWrVCjtwS/yuk9SZrr1w2VNlhhi6tmZ9yj/hQDdZJ8GffnXnWlWKw8522XI0J46jcRwJPIJ6Fhus28lvtJwtzB8g8ubGm+JowTDvhFBoMdtdTV9uMEZxSpEmyaMwHErpcvWrEKhKyk3zi/pymg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1ca2911c-299e-4b2f-6314-08d65c5f7991
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3623; 
x-ms-traffictypediagnostic: AM6PR0402MB3623:
x-microsoft-antispam-prvs: <AM6PR0402MB3623E5A44781052102CCC282F6AA0@AM6PR0402MB3623.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3623; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3623; 
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(446003)(11346002)(476003)(14454004)(44832011)(4326008)(25786009)(8676002)(486006)(6436002)(316002)(6506007)(102836004)(53936002)(26005)(229853002)(186003)(9686003)(6512007)(6306002)(6246003)(966005)(99286004)(66066001)(478600001)(33896004)(6486002)(54906003)(8936002)(81166006)(81156014)(76176011)(71190400001)(71200400001)(1076002)(6916009)(86362001)(106356001)(68736007)(305945005)(33716001)(256004)(7736002)(2906002)(97736004)(6116002)(3846002)(105586002)(5660300001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3623;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S3zw+J7/NS8XHoiUlwalF2teMKE9jXxEMAfgvUW/9JP4Vm48cAbw+byQ5oWuB6I5RYImYap7KuchRFl+dl8N5lLNMz3416BkJ20N4G47xya33Tc+L22Ne2T5r5VcijiC+ZWQE3ZWHNaJYmY5YpqSBwu9S2W7sbBBOebcEPeEtHmqeo8Unnb2dh/5jrosQwm4UhXgBgDZalUSTpAiSuCLnEwE2lZWJTQhyvwNhSdeNSPWYzuwYBDS+EgyNaqhUJtM4cAy50QW1xyLbhjpiBY5QXvg9UCW4cgst4/DewpLYpCQC/DVE5n7C5+QHxCZLSd3ta1LMWRJDLOrr++bRHO3O7TSLzP7IoSX4l5atio1rvg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <43241D4E8C10614A9FA91C524C802F09@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca2911c-299e-4b2f-6314-08d65c5f7991
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 16:17:24.9542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3623
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_081741_161100_365E4EEB 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 16, 2018 at 05:25:24PM -0600, Rob Herring wrote:

> > +
> > +	clk_ext1: clock-ext1 {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <133000000>;
> > +		clock-output-names = "clk_ext1";
> > +	};
> > +
> > +	clk_ext2: clock-ext2 {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <133000000>;
> > +		clock-output-names = "clk_ext2";
> > +	};
> > +
> > +	clk_ext3: clock-ext3 {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <133000000>;
> > +		clock-output-names = "clk_ext3";
> > +	};
> > +
> > +	clk_ext4: clock-ext4 {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency= <133000000>;
> > +		clock-output-names = "clk_ext4";
> > +	};
> 
> This is really 4 independent clocks or is 1 clock connected to 4 sinks?

According to the RM, yes, there are 4 independent clocks. Here is a link to the rm:

https://www.nxp.com/webapp/Download?colCode=IMX8MEVKBHUG (page 829)

Unfortunately, the old link (which worked without login) does not work anymore.

-- 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
