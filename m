Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D1EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:07:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D40C2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VndlPZZs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KxB/uFGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D40C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yXDP5JLqdDqFH7yUfnSZ8po73CGDmEoci9DHvI7LsRs=; b=VndlPZZs7cyL9l
	dKgNdMiMYjWEc9bssvm/LCeHmPifiaQET3lAkxIxPSMMK+apdLSqE2PIEB9QUg1xodGRu5wFg6PDh
	V+xbLPTgHHM/5avZhmSMKZyFjFDUjRuj5tSppL/nYf/g+vnjSDhrrVJdcM+49yuXwPxI3pPMqukl7
	KdX3iKqVdcFB/Dp7utrwk960E2b1ZhMDRgsixNM4zdsGJz8VqqCfVt0B+9kiXbfBe8wZwMa4oGjs8
	ZijGQwFIiIEBGH+BeRGdR93xSXdwEU60K4nN/MZn1ivXoeo/evDNymWfm9/gb5nWa/MRtu7qzZ5uJ
	dK6OTa2y1ZAjduQkb/Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyZeL-0000kP-Q8; Tue, 26 Feb 2019 10:07:45 +0000
Received: from mail-eopbgr140075.outbound.protection.outlook.com
 ([40.107.14.75] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyZeH-0000jh-Bz
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 10:07:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiELHKwKDW/yVffGGLtSWo0coGtO0e06PDu5ClMpgfI=;
 b=KxB/uFGHpKLHtZyOl/AvoiEVrqpM+UgX8BPaKIYOTsai+EGG0nUdomkOALCLvR9tyTlGH2PyMLmGpd9hjA9BeDrr/815XeQW41l6oSEEUy1uDOuLEDTTXu++dEMnWRUaefxrEICGvzHa6qh0C0Fahthxp6gzQ7agfSfrbYyxWhM=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5743.eurprd04.prod.outlook.com (20.178.127.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 10:07:35 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 10:07:35 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 2/4] dt-bindings: clock: imx-lpcg: add support to parse
 clocks from device tree
Thread-Topic: [PATCH 2/4] dt-bindings: clock: imx-lpcg: add support to parse
 clocks from device tree
Thread-Index: AQHUyg/Kxp1YOB0bxEaB6SXWVnNLZ6Xw8WgAgAB5y8A=
Date: Tue, 26 Feb 2019 10:07:34 +0000
Message-ID: <VI1PR04MB422296935D82A351A6A1DD92807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550771836-10014-1-git-send-email-aisheng.dong@nxp.com>
 <1550771836-10014-3-git-send-email-aisheng.dong@nxp.com>
 <155112397472.191923.18309287020361500256@swboyd.mtv.corp.google.com>
In-Reply-To: <155112397472.191923.18309287020361500256@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acd93274-bb78-4033-5b04-08d69bd23b2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5743; 
x-ms-traffictypediagnostic: VI1PR04MB5743:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1NzQzOzIzOkpySDBMNDl3OHlSYWxZWGRua0tsYVMyM053?=
 =?utf-8?B?TGtGbDR0dHhHYVUrWXBVaDhVSlYzT3l1bXBiUEhFdkU2L3hVMjRwYVhDTk1w?=
 =?utf-8?B?NlEyazZ4RCttam9sN0F1TVFmaFo3M0MvdGo3ZVZsZnZZNkJkN2pDbFRCV3Ju?=
 =?utf-8?B?S2E2UDR4UzZnRjBsTUdXenhUcjJzY1ltU2VDU3ova0tPeEFRQUVlM1RrQzZh?=
 =?utf-8?B?c3hFZ21LYmloUURUZ0ZpLzBCZE9wWmk1dllKUmorMnowR2xIM1lHcWY2eXNk?=
 =?utf-8?B?M3JWYkozMEYyanl5VEx0Q3dtVnJXbjMyN3hhMkV0c0VSWThmUUlqNnhTTldy?=
 =?utf-8?B?bzNZVGdoYjcvS0FUL0Z0ME9DMHk2TXRpYmRlc3hKQnpYQ2h0d1I1aTJDM016?=
 =?utf-8?B?NDNHTTlMZXpTK0luRTlwQ1hUNVp6NjRvV1NzZFZGc1drOVA5MW5ZZEdDSWdv?=
 =?utf-8?B?elNRNUtPYzFQaFhodkhYbGdJRk40ZDhzUk83SWJxZXlpUnFuNmc1S3BBZmV5?=
 =?utf-8?B?QlM1OFRpTHFOeTV5d05KdWMwWnJLNXQ0Nm01R243S2NSdXFnbStLNFlkNlR1?=
 =?utf-8?B?ODVjeS9JTWZaNk9JanBXR1R1aGN6eDgyR3A3QnZsSXZCUENwbmozSzhJbUNF?=
 =?utf-8?B?aTV4QUV1NHBlWWR4bzdmTzZ5MXlPMmw2S0JsZ0dGL0k5UVVaQklyemE5T0d4?=
 =?utf-8?B?UDBUMWNFZVgrQ2VRcEhrbWlONlpvZ1JkaFhZbHhDWnl5T1VOVzhkdFBwYUZy?=
 =?utf-8?B?U2NWaUF5SjJsNzJndnhiODMxTTh0YXZjTG41Q3VpYlorcldTNTZJU3RhVEJq?=
 =?utf-8?B?UFNBRDdNWHViMm8yalZQOE0yL1U2RDgwaU9MaVRJcTRRZnZ3VWx2cUVPaEZj?=
 =?utf-8?B?ZGVtb1E4dDI3MzJBcWlRVi90VlZCc3l5NEhwRlh3aVpQYjBCT2ZoRTVJdVk2?=
 =?utf-8?B?dTlnSXN3TkFWOGdnemsrRGErK2lRR2VyNndjL2hHS0dhTEN6THNUSVpOVStl?=
 =?utf-8?B?cWFIZkNLdnExWFN3MTVZSkFwUm9XaTNIZ29Ja1RVUlpjSmlNMDBmZ0hPQzhv?=
 =?utf-8?B?NkVYK0MwS3c5dXlGTzQ3anBlK0FIVEU5RXorRXJGU1ZRb2VKNUFBNGFTQzlL?=
 =?utf-8?B?dk1QemQyYXhUNjZEUzNJenBMSnBYWmtiQ1lqQ0dINnlRSmZBYk5oUDBJbUxP?=
 =?utf-8?B?Q0FmWWFyWFJIRzYvcmZjVC95d1d0SitmWU5uV2ViN2U1Q0VnQkEyeTN6NU83?=
 =?utf-8?B?TEZZVHlQSy9Da0p6ZWdRcmFVcEt1N3Q4ZlNGQWg3MmpYM25jbXVSZzAyc3Vr?=
 =?utf-8?B?cEd4M0V0SXNUQ0tFcmNzTzhIOHVOeEIrUDBtUWdLbS8rY1FtTWw1QlpXQU1y?=
 =?utf-8?B?cHlsY1lXQzRwUlorU2RDUkdNL3lBckp3OWtYdHExQ0QrKzBLbUhiWEhGRXQ1?=
 =?utf-8?B?U3o0S2xueHZ6SEFxWmFTSVhnOU5lM1BLTUhWZkdVUVp1VnZwODZ5aVM3RzVL?=
 =?utf-8?B?OWpJSFJudDBSeU5KUTFINjhkcW5URTdjRUF3ODBYMW8xMkhpd3hEVHQvM1Yr?=
 =?utf-8?B?R3kzNVhNUUw0cXU2WXFKU0I2MVh1SUdaZWZFVE15RzBBYTRyWDBDaWhTQVpX?=
 =?utf-8?B?ZW5ESS9Vblc4T3dmSUFDeXppdGd1cjlVN09EaUt0U2ZmVlp3UWdHQVRPRzFk?=
 =?utf-8?B?bnB0OWFyTjRqQ09SRVZmaFp2TFlxM3hxbHJCQVo2eU1wRTV1SlArczB1WHVa?=
 =?utf-8?B?S0RkdE01MzRzSEEwM3hwNjNobVlxa01sVzlTTERHQzhuYmpjdU9WbFBIM0RD?=
 =?utf-8?Q?brDPSBxActWOB?=
x-microsoft-antispam-prvs: <VI1PR04MB5743D865677114E86A3AB350807B0@VI1PR04MB5743.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(199004)(189003)(8676002)(81166006)(81156014)(446003)(6116002)(3846002)(11346002)(186003)(44832011)(476003)(486006)(7736002)(305945005)(74316002)(106356001)(229853002)(26005)(105586002)(14454004)(25786009)(4326008)(256004)(14444005)(6246003)(2906002)(6306002)(55016002)(9686003)(478600001)(52536013)(97736004)(71190400001)(71200400001)(966005)(33656002)(66066001)(8936002)(68736007)(316002)(86362001)(6436002)(76176011)(54906003)(5660300002)(99286004)(6506007)(102836004)(7696005)(53936002)(2501003)(110136005)(55214005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5743;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7OtxksT0OWNi20uOhtsPLS+0DIQhukZOYoBN2Dpfkefyw+wSxe55BHiKdn6xRUc4Ka6NhAwYmcuhAAcGZNcYhqcBR5WCfL2OZrhG1pTuMLOJzHr7cGGMh9WVqeHE3tTaXNS1ili1NXE4jEQnYem9epxMpsRKnGSNcGDUebiYjQpUlE4RkJZnWqJwktIEyixhB7ZUlfZ6W7/xWVJGHtmauGGpgjMDnF3rEQ1nxsXRcVGBJIKHZ2cRpfmDTIOmd5NDKUobXJfPnXVTVDBqyh6rr3263VjCpSr6Gf4/1idCKF0ImQ5y4fvhbv3R6V8h+wowK6KGZtfLZU/s7QKySBRx72SJjAgHGT5Fvm1tAMUub44x++Qa48Nd2Ycx/0P0FX3rw2QsyEAqz92PovHdgohOMHjiyt9vu8ZRCBOmhT6ADy4=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd93274-bb78-4033-5b04-08d69bd23b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 10:07:35.6013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5743
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_020741_927773_A3BFD8F6 
X-CRM114-Status: GOOD (  32.00  )
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
Cc: Rob Herring <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

Sorry for the long email, I want to describe things more clear to help the review.

First, i want to share some backgrounds on how this patch series comes from,
it mainly consists of three reasons:

1. New architecture to save a lot duplicated codes
We want to write a more generic <soc>-ss-<subsys>.dtsi shared by imx8qxp, imx8qm,
imx8dx, imx8dm according to HW characteristic then we'd better decouple the dependency
of Clock ID definitions from device tree due to the SS and device availability difference among them.
[00/14] arm64: dts: imx8: architecture improvement and adding imx8qm support
https://patchwork.kernel.org/cover/10824537/

2. Power domain requirements
Both SCU and LPCG clock access requires it's associated power domain enabled, CCF
already supports it and device tree seems to be the best place to describe it.
e.g. arch/arm64/boot/dts/exynos/exynos5433.dtsi
cmu_aud: clock-controller@114c0000 {
        compatible = "samsung,exynos5433-cmu-aud";
        #clock-cells = <1>;
		....
        power-domains = <&pd_aud>;
};

Furthermore, if the power domain is off (e.g. during system suspend) the clock state
Within this domain will be lost and we have to restored it after power domain is re-enabled.
We'd like to use common driver suspend/resume to handle it.
(In the future, we might support Runtime state save&restore as well in order to shut
down the whole SS if not used, that also need power domain info from DT).

3. Partition support
IMX SCU firmware supports Resource Partition service which allows each device resource
to be partitioned into different ownership groupings that are associated with different
execution environments including multiple operating systems executing on different
cores, TrustZone, and hypervisor.

That means we can't register all the clocks in Linux as some of them may not belong
to us and can't access. (we can check all the clocks via SCU RPC call before register, 
but that also needs a branch of time. However, LPCG not easy to check as it does not provide
resource id). Putting clocks of device in DT allows the dynamically configuration of it according
to the real partition requirements.
E.g. Remove some clock/device nodes once not belong to Linux OS partition or not exist in
hardware on this SoC SS.

And please see below for my replies to other of your questions:

> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Tuesday, February 26, 2019 3:46 AM
> Quoting Aisheng Dong (2019-02-21 10:03:47)
> > MX8QM and MX8QXP LPCG Clocks are mostly the same except they may
> > reside in different subsystems across CPUs and also vary a bit on the
> availability.
> >
> > Same as SCU clock, we want to move the clock definition into device
> > tree which can fully decouple the dependency of Clock ID definition
> > from device tree. And no frequent changes required in clock driver any
> > more to handle the difference.
> >
> > We can use the existence of clock nodes in device tree to address the
> > device and clock availability differences across different SoCs.
> 
> This sounds similar to what TI folks are doing with their new firmware.
> It leads to problems where we don't know what in the clk tree needs to be
> registered, 

AFAICT we know what clocks need to be registered according to the device availability
in each SS (Subsystem) in HW definition.
Am I missed something?

> debugfs is not super helpful in that case, 

Debugfs functions the same as defining clocks in driver.
Every cock defined in driver can be defined in device tree according to HW configuration
and displayed with debugfs. So I'm not quite get the point of the concern.
Can you help clarify a bit more?

> and late init only turns off
> clks that are found during probe (so nothing then?).

Same as above.

BTW, we did not support turn off clocks for LPCG during late init.
Probably won't support in the future as LPCG is the next level gates of SCU clocks.
Gating off LPCG clocks while SCU clocks disabled already looks not so meaningful, right?
And gate off such type LPCG is quite expensive as LPCG needs enable its power domain
to access and chip reset already ensures the LPCG clocks are off and the later LPCG
enable/disable also can sync the HW state.

For the parent SCU clocks, we also still don't have the plan to support late gate off because
SCU clock might be shared with M-Core OS or Secure SW (e.g. ATF, OPTee) and A core can't
Gate off those "unused" ones it believes. Currently what we're doing is ensure gate off
power&clocks after using in bootloader before hand over to kernel.

> 
> >
> > diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
> > b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
> > index 965cfa4..a317844 100644
> > --- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
> > +++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
> > @@ -11,6 +11,20 @@ enabled by these control bits, it might still not
> > be running based  on the base resource.
> >
> >  Required properties:
> > +- compatible:          Should be one of:
> > +                         "fsl,imx8qxp-lpcg"
> > +                         "fsl,imx8qm-lpcg" followed by
> "fsl,imx8qxp-lpcg".
> > +- reg:                 Address and length of the register set.
> > +- #clock-cells:                Should be 1. One LPCG supports multiple
> clocks.
> > +- clocks:              Input parent clocks phandle array for each clock.
> > +- bit-offset:          An integer array indicating the bit offset for each
> clock.
> > +- hw-autogate:         Boolean array indicating whether supports HW
> autogate for
> > +                       each clock.
> 
> This looks like one clk per node style of bindings which is a direction we don't
> want DT bindings to go in. It leads to a bunch of time parsing DT to generate
> clks and in general doesn't represent the clock controller hardware that is
> there. Basically, anything with 'bit-offset'
> in the binding is not going to be acceptable.
> 

It's one LPCG per node which represents a couple of clock output gates controlled by
this LPCG for one specific module.
For MX8QM/QXP platforms, there're separate LPCGs for each device resource.
LPCGs are independent with each other with separate io space, behaving separate module
clock controllers and they are distributed in different SS (subsystems).
Describing it separately in device tree is more comply with real hardware although
it sacrifices a bit parsing time.

Regards
Dong Aisheng

> > +- clock-output-names:  Shall be the corresponding names of the outputs.
> > +                       NOTE this property must be specified in the
> same order
> > +                       as the clock bit-offset and hw-autogate property.
> > +
> > +Legacy binding (DEPRECATED):
> >  - compatible:  Should be one of:
> >                   "fsl,imx8qxp-lpcg-adma",
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
