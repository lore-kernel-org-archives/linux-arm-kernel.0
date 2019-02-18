Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D196C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:49:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7782184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZAwgDciq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VnN3K5bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7782184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/K3tsewaSMsiXEQvrZTC77ZyhoxX7DX422d+YjR0KbI=; b=ZAwgDciqY226HT
	JNCFMYXQz599sm72l0JW2UNe/llPW5ao4mPG39xmQg6I3sIEnKQpVGqN/Ea8tMtoW90TGz3JiW1I7
	7Kwq16INhEGrUwL76Ni3Vu/1lSvXKUVbj61zH0blt/wczs32IXt4pIm26pdCqdH1emZAUo2UT9JB6
	x6d2n8DoV5iKcpe//XDmCGk/mTKIsursJv7G1Jqe3JRWHJvfYjyGaso4Ly4kHZb2vzvlQDXUqjRK4
	X7rKkcD14MSRezYfKaiEZRzBhiLLUE7WGh449Z6R9QgZgZPPWNurzvYRyCOQYuxplqe55V7grAPo1
	ywJap4MFRGreCf6eG0JA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvbo1-0003ct-9h; Mon, 18 Feb 2019 05:49:29 +0000
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvbnw-0003cB-On
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 05:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbyedqodtC88vwWqkn1dXF5Rpg+MY9C9PaT4wTUvNSM=;
 b=VnN3K5bjXhEsaS4kNFZGuTL8tFlOPPFpMluPzRmHX+GsJJptTq4gP4YFPw/hSAnPSc5BpDCQTzIf6Q/sddDWz5o4ADkoH9B4oCmCm7PWr1fqyr7jLE8JGENf/37xDTOPsPxH5B687bIc0w69iw0PASiCmcMvdCj8KDXb1GlZFHA=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2223.eurprd04.prod.outlook.com (10.166.44.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 05:49:18 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1622.016; Mon, 18 Feb 2019
 05:49:18 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUvgABt0FSxwLfGkq2pK/QIZ0c6qXZ788AgAEnJsCAAHDssIAA9jCAgANwWoCABS+8wA==
Date: Mon, 18 Feb 2019 05:49:18 +0000
Message-ID: <VI1PR0401MB2496C24647AB1DF2EC7BA266F1630@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190206150520.9683-1-pankaj.bansal@nxp.com>
 <20190211030010.GI22487@dragon>
 <AM6PR04MB5863A68D22DD06F81743AC8B8F640@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM5PR0401MB24818DB35D5DEF95DA710038F1650@AM5PR0401MB2481.eurprd04.prod.outlook.com>
 <CADRPPNTEE7beTyR-3ezSBuaNm-9vMAiUVKWYUkr_gd8nswMSYg@mail.gmail.com>
 <CADRPPNTua4AmYC6_AkDYKbyOXXzpR+7a1nLTe=_Qn-KhXck=8w@mail.gmail.com>
In-Reply-To: <CADRPPNTua4AmYC6_AkDYKbyOXXzpR+7a1nLTe=_Qn-KhXck=8w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f20d7159-f54a-4193-b0d4-08d69564d2a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2223; 
x-ms-traffictypediagnostic: VI1PR0401MB2223:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDFNQjIyMjM7MjM6MS94MXBOa0JMM2E5V0M5L2xxbEJGZmtp?=
 =?utf-8?B?Z3E1RllCNHJZTnNzSkU5RnB0Zk1hdE9udTR6NUpCM3pkUVN0YTY1SVFWL0lo?=
 =?utf-8?B?TFNxaldBSU5iTUZUUU80NWcvWVNzZTl1a1ZHSkh5TGJBSER0ZmVoZ25zTXo2?=
 =?utf-8?B?Y3JXaDVQNnNraE5TZnliUUVUQjVoZm5vQXUxMXVObFBtYU83MHdMTUhYZVlh?=
 =?utf-8?B?NmxiWlYrbDUyUmJjK1hyMXJEcTNEQ3lQOFFhRDI0ck9Eb01zYzVUUS9WUVVZ?=
 =?utf-8?B?ZDBaUmpSVVpmWk5pN0ZsTkwvekFjY0Z4S3M0YmxDNHBKaHFnS3VBQitvcGlO?=
 =?utf-8?B?ZExvbnlRRzFsd0tUQkJsU3I0dXNOdCtyVWsyZ25uQTFsS3lSalV5M2NKT05u?=
 =?utf-8?B?dlYwaXE2RlhkMEQwY1NMRThpNDh6NTUzdnhzTzFMdVBreHc2Y2c4dml4eUYx?=
 =?utf-8?B?TGtpN3lvUURVbTBlN3gvd3ZRdVlSZWlJV2pVTVVxa2RDZm5iUjBUaXdkRllz?=
 =?utf-8?B?Mnd5ZVNjS3hERXBDcmhkckhBekNueDlsMVVnZUp6Ukx3N1owdHJ1N0RnUmUz?=
 =?utf-8?B?cjExUnRaMEptTWNac25iM0lEN3BrY0lRUHpEb2ZsT3h0VDZYZjRta1VHZkxF?=
 =?utf-8?B?ZFRab08rbDJzaHc5MTRqV0FqcXh5V1BrbzAyam5tYVE4Vjk2c3lVRlZCTnZY?=
 =?utf-8?B?UzNNeC9XUUxFMnJ6SVZjQk1lVmxYRllYbmd6Qk4zMGxPQis2S0oxVThvOGhM?=
 =?utf-8?B?ZERGbktTYU44YXFpeU1OVDFCdkgwbUJyeHZRR0d6dXo0azBNQ1NvSE5SUkJl?=
 =?utf-8?B?SnZldWk1dS9iTTdSN3FueEJVWGJvNFlaREdZWnd1cmlRbEkzbERKYzRHdDFu?=
 =?utf-8?B?UDNsUGFGdG1xajRVVmZENXU4WEhmaXd6RnNqNWRCT0JZK3ZGVDFmK212VEhI?=
 =?utf-8?B?MXkvZ3hSNFdvMzdGWHVMUFJ1NUVQSm5pc0IxMnlodnh3cTdidVBaUEVVYkth?=
 =?utf-8?B?VWc4c0FFNVlRd0QrNzE5b1VtM2FRNTdCazhxclNGOFRFa203YWI5L29wWGZX?=
 =?utf-8?B?UTVkQlp0ZldaMHpXNEFlVG81RkZpcUFKSTRrMmNuYVlJVlJ6ay9qa0pYeVN4?=
 =?utf-8?B?aW1zUUMza2VkYUQvV01SK0hFS2drNlhDWmoyMEVNeDhTR0VqQkpsT0hBMGtR?=
 =?utf-8?B?dFdmOWxmSUNTSy9TZHRVRkdGaGNwZ0pOWGhIaWJLK2gvcmZqRVNUdk1ndTQw?=
 =?utf-8?B?cGRjTHlXUXhmZDd1bVJEZnRxM3FKMXhjejEvT0F4MWpNcHczNnZYTDJKd3Ji?=
 =?utf-8?B?Q1B0RFVGUkU2UC90OG5VME5vNzZ1bUxsZUdOVUdCM2hXTHVEMlAyb0l5dXE4?=
 =?utf-8?B?NVhZQWNYUG5IU2N6S2s1SVd3eXVmZk5kdFdaTGkydC9vM1VqSmZNKzhCYkls?=
 =?utf-8?B?MGRQOTByMjM1NktqOEJKbExxSURiR3VuMXRqNkFYVnBueEw4VE9TYS9jK05W?=
 =?utf-8?B?bEVIZTAyc3lCVG1EOTdtRnJFR2g3Vm91Q0swMGk0UkpORXVUY2xIYnVPbnpo?=
 =?utf-8?B?dVpHVFF5RFlaekZvUmYvelBOQmpYbXdUVFRGZVR5Y1didHRzQVlhWXhFeDFF?=
 =?utf-8?B?OXhURHphOU9YQXYycVdlaGtjSmpqSzZGU3dKYzBRR2xjN250bW44Rjhud0dw?=
 =?utf-8?B?QVNZaVV2ZzdnSmNUd1FCOE9wekJ2YUJZajVmend4RkxIVGhiR1J1UzNvRE1D?=
 =?utf-8?B?cllHOC9iY1FLaGFrdVNoUmsvektnTFEvSksvaXZOL2ppckFwUWY1aUZscllD?=
 =?utf-8?B?dEk1WWRWeGJpNjlkZmZoYm1Cc3c2azVFanZqQnVLOExnRU8xUT09?=
x-microsoft-antispam-prvs: <VI1PR0401MB22239581C94693FEBEEF3BB8F1630@VI1PR0401MB2223.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(199004)(189003)(13464003)(305945005)(6116002)(6436002)(4326008)(478600001)(68736007)(3846002)(966005)(74316002)(99286004)(11346002)(446003)(486006)(476003)(66066001)(97736004)(256004)(14444005)(7736002)(33656002)(30864003)(76176011)(7696005)(81156014)(86362001)(81166006)(44832011)(8936002)(186003)(2906002)(5660300002)(6306002)(54906003)(8676002)(110136005)(25786009)(71190400001)(71200400001)(53936002)(106356001)(105586002)(93886005)(6506007)(229853002)(55016002)(102836004)(53546011)(26005)(14454004)(6246003)(316002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2223;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VPRk4cwB1t7GwH1sB5gtX1R5EhJKbd/GpGbLRJdEg7ZJOhHQBZw0CMmA4EjGwdMp2bHcVdErd3szcd5Br/41ABEZxIzC/kwMD6ijmZ0paCnlcBF9lJ7FRYVP+CwZYxolKvTLsepTMxTlOfYXk7FeG5XfWW0Fx7U9/4Yf9kXxbl+C7Yk18HL3th7GEboXwxkRiigGybAMb/yqaofLsXVhqmDmGMgG6+nuBDnzJDSULFkvuVq1nRPEjoyU1Gk4eUCfoHswRNtHGY3aGNX4vACP5bjkYzbfwQeudTJcB0j3t43/hqLTmwZ3TUID2a///je/Fnp8wtuAnlFP5Q2VgI9SrWKWvJQ8GX6YnrWBWFidzl+9T777dHpHDguKE+fUDqbGTJl5GK7y/v/tyGTg3GyteqiP5rSPfkuxD5rSz6BzEtg=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20d7159-f54a-4193-b0d4-08d69564d2a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 05:49:18.1673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2223
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_214924_960337_1D5C5788 
X-CRM114-Status: GOOD (  32.35  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Li Yang [mailto:leoyang.li@nxp.com]
> Sent: Friday, 15 February, 2019 04:03 AM
> To: Pankaj Bansal <pankaj.bansal@nxp.com>; Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>; Andrew Lunn <andrew@lunn.ch>;
> Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
> 
> On Tue, Feb 12, 2019 at 12:01 PM Li Yang <leoyang.li@nxp.com> wrote:
> >
> > On Mon, Feb 11, 2019 at 9:28 PM Pankaj Bansal <pankaj.bansal@nxp.com>
> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Leo Li
> > > > Sent: Tuesday, 12 February, 2019 02:14 AM
> > > > To: Shawn Guo <shawnguo@kernel.org>; Pankaj Bansal
> > > > <pankaj.bansal@nxp.com>
> > > > Cc: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli
> > > > <f.fainelli@gmail.com>; netdev@vger.kernel.org;
> > > > linux-arm-kernel@lists.infradead.org
> > > > Subject: RE: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Shawn Guo <shawnguo@kernel.org>
> > > > > Sent: Sunday, February 10, 2019 9:00 PM
> > > > > To: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > > > Cc: Leo Li <leoyang.li@nxp.com>; Andrew Lunn <andrew@lunn.ch>;
> > > > > Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org;
> > > > > linux-arm- kernel@lists.infradead.org
> > > > > Subject: Re: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux
> > > > > nodes
> > > > >
> > > > > On Wed, Feb 06, 2019 at 09:40:33AM +0000, Pankaj Bansal wrote:
> > > > > > The two external MDIO buses used to communicate with phy
> > > > > > devices that are external to SOC are muxed in LX2160AQDS board.
> > > > > >
> > > > > > These buses can be routed to any one of the eight IO slots on
> > > > > > LX2160AQDS board depending on value in fpga register 0x54.
> > > > > >
> > > > > > Additionally the external MDIO1 is used to communicate to the
> > > > > > onboard RGMII phy devices.
> > > > > >
> > > > > > The mdio1 is controlled by bits 4-7 of fpga register and mdio2
> > > > > > is controlled by bits 0-3 of fpga register.
> > > > > >
> > > > > > Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > > > > ---
> > > > > >
> > > > > > Notes:
> > > > > >     V3:
> > > > > >     - Add status = disabled in soc file and status = okay in board file
> > > > > >       for external MDIO nodes
> > > > > >     - Add interrupts property in external mdio nodes in soc file
> > > > > >     V2:
> > > > > >     - removed unnecassary TODO statements
> > > > > >     - removed device_type from mdio nodes
> > > > > >     - change the case of hex number to lowercase
> > > > > >     - removed board specific comments from soc file
> > > > > >
> > > > > >  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 123 +++++++++++++++++
> > > > > >  .../boot/dts/freescale/fsl-lx2160a.dtsi      |  22 +++
> > > > > >  2 files changed, 145 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > > > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > > > > index 99a22abbe725..079264b391a2 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > > > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > > > > @@ -35,6 +35,14 @@
> > > > > >   status = "okay";
> > > > > >  };
> > > > > >
> > > > > > +&emdio1 {
> > > > > > + status = "okay";
> > > > > > +};
> > > > > > +
> > > > > > +&emdio2 {
> > > > > > + status = "okay";
> > > > > > +};
> > > > > > +
> > > > > >  &esdhc0 {
> > > > > >   status = "okay";
> > > > > >  };
> > > > > > @@ -46,6 +54,121 @@
> > > > > >  &i2c0 {
> > > > > >   status = "okay";
> > > > > >
> > > > > > + fpga@66 {
> > > > > > +         compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > > > > > +         reg = <0x66>;
> > > > > > +         #address-cells = <1>;
> > > > > > +         #size-cells = <0>;
> > > > > > +
> > > > > > +         mdio-mux-1@54 {
> > > > > > +                 mdio-parent-bus = <&emdio1>;
> > > > > > +                 reg = <0x54>;            /* BRDCFG4 */
> > > > > > +                 mux-mask = <0xf8>;      /* EMI1_MDIO */
> > > > > > +                 #address-cells=<1>;
> > > > > > +                 #size-cells = <0>;
> > > > > > +
> > > > > > +                 mdio@0 {
> > > > > > +                         reg = <0x00>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > >
> > > > > Please have a newline between nodes.  It doesn't deserve a
> > > > > respin though.  I can fix them up when applying if Leo is fine with this
> version.
> > > >
> > > > I think there should be a compatible string defined for the
> > > > binding of parent node mdio-mux, probably "mdio-mux-regmap", and
> > > > be used here in the device tree.
> > >
> > > I have two concerns :
> > > 1. The regmap is linux s/w construct, while device tree is h/w representation
> and is s/w agnostic. can we use regmap in device tree?
> >
> > Well, if we want to avoid using the regmap name, we probably can try
> > "mdio-mux-reg" or "mdio-mux-syscon"?  With further search I also found
> > a more generic mux binding at Documentation/devicetree/bindings/mux/,
> > would be even better if we can use that to describe the mux.
> 
> 
> To make it more clear, with the use of
> Documentation/devicetree/bindings/mux/ binding, I think it would end up with
> something like this:
> 
> i2c {
>  fpga {
>   compatible = "fsl,lx2160aqds-fpga", "syscon";
>   ....
>   mux: mux-controller {
>    compatible = "mmio-mux"

The FPGA in LX2160AQDS is not mmio controlled but an I2c controlled FPGA.
As such there is no binding yet for mux nodes controlled by SPI or I2C devices.
Even the syscon binding is for MMIO controlled devices.
I have added such binding at https://patchwork.ozlabs.org/patch/1043790/
Let's see if this gets accepted or not? After that I will resend this patch.

>    ...
>   }
>  }
> ...
> }
> 
> mdio-mux {
>  compatible = "mdio-mux"
>  mux-controls = <&mux 0>;
>  ....
>  mdio {
>   phy {
>   }
>   ...
>  }
>  mdio {
>   ...
>  }
>  ...
> }
> 
> 
> }"
> 
> >
> > > 2. By convention the device tree compatible binding is defined as
> "<manufacturer>,<model>" e.g. "fsl,mpc8349-uart". The mdio-mux node and it's
> sub nodes are a generic representation of mdio mux and it is not dependent on a
> particular manufacturer device. How to define the compatible in this case?
> >
> > The manufacturer prefix is for vendor specific bindings.  If the
> > binding a suppose to be generic, we don't need the vendor prefix.
> >
> > >
> > > >
> > > > >
> > > > > Shawn
> > > > >
> > > > > > +                 mdio@40 {
> > > > > > +                         reg = <0x40>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@c0 {
> > > > > > +                         reg = <0xc0>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@c8 {
> > > > > > +                         reg = <0xc8>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@d0 {
> > > > > > +                         reg = <0xd0>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@d8 {
> > > > > > +                         reg = <0xd8>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@e0 {
> > > > > > +                         reg = <0xe0>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@e8 {
> > > > > > +                         reg = <0xe8>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@f0 {
> > > > > > +                         reg = <0xf0>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@f8 {
> > > > > > +                         reg = <0xf8>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +         };
> > > > > > +
> > > > > > +         mdio-mux-2@54 {
> > > > > > +                 mdio-parent-bus = <&emdio2>;
> > > > > > +                 reg = <0x54>;            /* BRDCFG4 */
> > > > > > +                 mux-mask = <0x07>;      /* EMI2_MDIO */
> > > > > > +                 #address-cells=<1>;
> > > > > > +                 #size-cells = <0>;
> > > > > > +
> > > > > > +                 mdio@0 {
> > > > > > +                         reg = <0x00>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@1 {
> > > > > > +                         reg = <0x01>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@2 {
> > > > > > +                         reg = <0x02>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@3 {
> > > > > > +                         reg = <0x03>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@4 {
> > > > > > +                         reg = <0x04>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@5 {
> > > > > > +                         reg = <0x05>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@6 {
> > > > > > +                         reg = <0x06>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +                 mdio@7 {
> > > > > > +                         reg = <0x07>;
> > > > > > +                         #address-cells = <1>;
> > > > > > +                         #size-cells = <0>;
> > > > > > +                 };
> > > > > > +         };
> > > > > > + };
> > > > > > +
> > > > > >   i2c-mux@77 {
> > > > > >           compatible = "nxp,pca9547";
> > > > > >           reg = <0x77>;
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > > > index a79f5c1ea56d..7def5252ac1a 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > > > @@ -762,5 +762,27 @@
> > > > > >                                <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> > > > > >                   dma-coherent;
> > > > > >           };
> > > > > > +
> > > > > > +         /* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
> > > > > > +         emdio1: mdio@8b96000 {
> > > > > > +                 compatible = "fsl,fman-memac-mdio";
> > > > > > +                 reg = <0x0 0x8b96000 0x0 0x1000>;
> > > > > > +                 interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > +                 #address-cells = <1>;
> > > > > > +                 #size-cells = <0>;
> > > > > > +                 little-endian;  /* force the driver in LE mode */
> > > > > > +                 status = "disabled";
> > > > > > +         };
> > > > > > +
> > > > > > +         /* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
> > > > > > +         emdio2: mdio@8b97000 {
> > > > > > +                 compatible = "fsl,fman-memac-mdio";
> > > > > > +                 reg = <0x0 0x8b97000 0x0 0x1000>;
> > > > > > +                 interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > +                 #address-cells = <1>;
> > > > > > +                 #size-cells = <0>;
> > > > > > +                 little-endian;  /* force the driver in LE mode */
> > > > > > +                 status = "disabled";
> > > > > > +         };
> > > > > >   };
> > > > > >  };
> > > > > > --
> > > > > > 2.17.1
> > > > > >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
