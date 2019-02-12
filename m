Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3AEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:26:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FBF2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eVlMY9Gf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aMuAFxif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FBF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WXLGcj0VIFeaDXF1bz9mb7Aaw2oylIByyNWfanmLjjs=; b=eVlMY9GfuAYDlH
	8QD89qvJm7PJHXSGDjJ7J93vyHNKEMzBf+hrRmNtXxv2/0wue7je4gzBlos2jjlCb0ep3pIFCz5FB
	3zbO26dCmLG/ECoD0+s/nbsu1LQj1Mk/mSQuAV01/lykMreGfshi9g2Bl3uslHcIb1ZLZTMX94OZy
	fcU9dlhpEXpkVA06khFxVir4ZolLnq8WX89JGVMhq3OZwjIt8KpBLW41jqXbzB598ZeLe9N9ORnfF
	w0WhWRMvr8RSVuNCnndELl1mzu3AYgCzzRl+rtYgKrYfqLlIIXQwqF3/utkIYq+qeUuMJqE3cfICa
	zLT6oDZC1WD9xaiUrE+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtOiU-0000Vi-8y; Tue, 12 Feb 2019 03:26:38 +0000
Received: from mail-am5eur03on061a.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::61a]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtOiP-0000RJ-HO
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 03:26:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cGJnUie47PkY00wZ/25KG9+Jg5X0kx8tizzRaN4Nvg=;
 b=aMuAFxifxff0uACDVxvjK9drQIrrDw/HkDUKD3xf5MLknNuVCIZMJbUHj1uSZK83OXtiaqT9APMpkkEhE2DNnL1X1LizOBioieGB0T56Riksqy/VCmJqAs1hTFZYBG2NjrgSPUIifl9xezxIpRCSd/LBWBZqCrp1elpS7YgPhYs=
Received: from AM5PR0401MB2481.eurprd04.prod.outlook.com (10.169.244.137) by
 AM5PR0401MB2532.eurprd04.prod.outlook.com (10.169.245.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 03:26:24 +0000
Received: from AM5PR0401MB2481.eurprd04.prod.outlook.com
 ([fe80::a4ed:f8c5:3da7:f8bc]) by AM5PR0401MB2481.eurprd04.prod.outlook.com
 ([fe80::a4ed:f8c5:3da7:f8bc%8]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 03:26:24 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUvgABt0FSxwLfGkq2pK/QIZ0c6qXZ788AgAEnJsCAAHDssA==
Date: Tue, 12 Feb 2019 03:26:24 +0000
Message-ID: <AM5PR0401MB24818DB35D5DEF95DA710038F1650@AM5PR0401MB2481.eurprd04.prod.outlook.com>
References: <20190206150520.9683-1-pankaj.bansal@nxp.com>
 <20190211030010.GI22487@dragon>
 <AM6PR04MB5863A68D22DD06F81743AC8B8F640@AM6PR04MB5863.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB5863A68D22DD06F81743AC8B8F640@AM6PR04MB5863.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [49.36.132.159]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM5PR0401MB2532;
 6:NH9K3XGKHzQaojV2bRQcnDjzN7YNV86heAR9ko9Rnyd1+3PT9K4qLbdQVziEUOFtMATj5C/gnWllcxnESOIUnRUPllzsZlVlbX+oLnDg2iDqWlvt5S3vJAazxwq5jstc15FPSDLImUgyaWwzB71yMF56NKiS80f6o4XCozveB3OretondAizqZQ+EM+cSQOmlNndCyUNT+iU5ZVEXUrmRaoEk4MVBkqSHGsEZuytA4iNy2MjYdVrx3xosMmgvmaQGkM28y6fgBLR152IIZCahjGqa8KuK1pWoj+j7zEuYVwSH41aYmYiVNq8R7/Kif3mlzIJyTflI8RrlmhOz4T6a/eYx/x7JCoJtInlX58z1Fkg12w0PH2jAs7AfoOp8PPLQJDwe57CrbWDHbx9r4MyqQ9Vacv3uib1cI5oU8UjP5aFkvnIiQ+WrOEU2ern+zH1ly3dN+KfOuZ0F3cCIQJHZQ==;
 5:FQRezFsErpELUhr7bkUeiRdH2pXazHr9cFPwQlBz8JVUtDVX6taN1cO2b4ZGlfiGP/98ysG018voKzT9q9iBQSYmXc3vfZM3gP5TAGrwwda+goe1aKQf7LLJkxXD5Gh05Ufoj1uV325fvvkkss1Ohd42bEE3f4dJOCiI2+zHCSda2IFyi+JCDcm0JjgrQJxgKjHTjSUIDLSWconS41spQg==;
 7:J/AxZ8pLBKLz0fpel5DvWTSjPGtDyM4uZ0He+/ia+36zKgvUlrJtmoXt518RbkxnWAqy5L7xdTm0MpGSOT89WUn0VdfsAN3l89QSE0M2W6Jc7RqoTfUxFGan5iSpIurpLf8f4he2Gjd0XFGQwXktWQ==
x-ms-office365-filtering-correlation-id: 01b473f3-921f-47fc-0d4a-08d69099ddd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0401MB2532; 
x-ms-traffictypediagnostic: AM5PR0401MB2532:
x-microsoft-antispam-prvs: <AM5PR0401MB25321D30B9178DC5CE20FB16F1650@AM5PR0401MB2532.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(376002)(136003)(39860400002)(346002)(13464003)(199004)(189003)(6246003)(478600001)(446003)(86362001)(53936002)(11346002)(486006)(316002)(476003)(186003)(44832011)(8936002)(81156014)(74316002)(81166006)(305945005)(7736002)(8676002)(99286004)(66066001)(7696005)(76176011)(102836004)(53546011)(6506007)(26005)(68736007)(6116002)(3846002)(256004)(97736004)(106356001)(2906002)(55016002)(14444005)(105586002)(71200400001)(25786009)(71190400001)(110136005)(54906003)(4326008)(14454004)(9686003)(6436002)(229853002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0401MB2532;
 H:AM5PR0401MB2481.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MK60bj05IpVVb865vVsK6buHnfF7QdEoqNkiQqT5Jb8ncqAc2/kAcOgwg75bbZ4IcXSUOEIZp519G8hTLjyBZbTp/ieyTClpmd0g4Y2TKn9vJ+nfTL1Q3/OWdhnBdRW6+c2lCj96jB9yl86ssrrzct1/el3H2zGxHEULQ7bxqLtBpSCNPbVtc5gCbFzCdDCNX5dGOlbNIGbgY6qy+4ZgfzIAJRGUUCwsaHLwp2ROI5HQ/rUj1T0TW2Ku3gonK5ugAQAGK+GR6O0r1yyv0RiOUk/DYQfW3YosZpTKUCBPP+4mJw+HE2N3F2Db03QKzhxuJ/N7t2M0d2F+ASOzh7WsBASxW7X1VyZNbE5+ASL/+3eHRu31GJyD2OAM4vuOgrNGd3qHmISqYu2edEUsNd/KNtFrgKz2kYgPKuzs1ov8CLM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b473f3-921f-47fc-0d4a-08d69099ddd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 03:26:24.4913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2532
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_192633_942302_BB793F4C 
X-CRM114-Status: GOOD (  26.90  )
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
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Leo Li
> Sent: Tuesday, 12 February, 2019 02:14 AM
> To: Shawn Guo <shawnguo@kernel.org>; Pankaj Bansal
> <pankaj.bansal@nxp.com>
> Cc: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
> 
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Sunday, February 10, 2019 9:00 PM
> > To: Pankaj Bansal <pankaj.bansal@nxp.com>
> > Cc: Leo Li <leoyang.li@nxp.com>; Andrew Lunn <andrew@lunn.ch>; Florian
> > Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
> >
> > On Wed, Feb 06, 2019 at 09:40:33AM +0000, Pankaj Bansal wrote:
> > > The two external MDIO buses used to communicate with phy devices
> > > that are external to SOC are muxed in LX2160AQDS board.
> > >
> > > These buses can be routed to any one of the eight IO slots on
> > > LX2160AQDS board depending on value in fpga register 0x54.
> > >
> > > Additionally the external MDIO1 is used to communicate to the
> > > onboard RGMII phy devices.
> > >
> > > The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is
> > > controlled by bits 0-3 of fpga register.
> > >
> > > Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > ---
> > >
> > > Notes:
> > >     V3:
> > >     - Add status = disabled in soc file and status = okay in board file
> > >       for external MDIO nodes
> > >     - Add interrupts property in external mdio nodes in soc file
> > >     V2:
> > >     - removed unnecassary TODO statements
> > >     - removed device_type from mdio nodes
> > >     - change the case of hex number to lowercase
> > >     - removed board specific comments from soc file
> > >
> > >  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 123 +++++++++++++++++
> > >  .../boot/dts/freescale/fsl-lx2160a.dtsi      |  22 +++
> > >  2 files changed, 145 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > index 99a22abbe725..079264b391a2 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > @@ -35,6 +35,14 @@
> > >  	status = "okay";
> > >  };
> > >
> > > +&emdio1 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&emdio2 {
> > > +	status = "okay";
> > > +};
> > > +
> > >  &esdhc0 {
> > >  	status = "okay";
> > >  };
> > > @@ -46,6 +54,121 @@
> > >  &i2c0 {
> > >  	status = "okay";
> > >
> > > +	fpga@66 {
> > > +		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > > +		reg = <0x66>;
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		mdio-mux-1@54 {
> > > +			mdio-parent-bus = <&emdio1>;
> > > +			reg = <0x54>;		 /* BRDCFG4 */
> > > +			mux-mask = <0xf8>;      /* EMI1_MDIO */
> > > +			#address-cells=<1>;
> > > +			#size-cells = <0>;
> > > +
> > > +			mdio@0 {
> > > +				reg = <0x00>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> >
> > Please have a newline between nodes.  It doesn't deserve a respin
> > though.  I can fix them up when applying if Leo is fine with this version.
> 
> I think there should be a compatible string defined for the binding of parent
> node mdio-mux, probably "mdio-mux-regmap", and be used here in the device
> tree.

I have two concerns :
1. The regmap is linux s/w construct, while device tree is h/w representation and is s/w agnostic. can we use regmap in device tree?
2. By convention the device tree compatible binding is defined as "<manufacturer>,<model>" e.g. "fsl,mpc8349-uart". The mdio-mux node and it's sub nodes are a generic representation of mdio mux and it is not dependent on a particular manufacturer device. How to define the compatible in this case?

> 
> >
> > Shawn
> >
> > > +			mdio@40 {
> > > +				reg = <0x40>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@c0 {
> > > +				reg = <0xc0>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@c8 {
> > > +				reg = <0xc8>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@d0 {
> > > +				reg = <0xd0>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@d8 {
> > > +				reg = <0xd8>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@e0 {
> > > +				reg = <0xe0>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@e8 {
> > > +				reg = <0xe8>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@f0 {
> > > +				reg = <0xf0>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@f8 {
> > > +				reg = <0xf8>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +		};
> > > +
> > > +		mdio-mux-2@54 {
> > > +			mdio-parent-bus = <&emdio2>;
> > > +			reg = <0x54>;		 /* BRDCFG4 */
> > > +			mux-mask = <0x07>;      /* EMI2_MDIO */
> > > +			#address-cells=<1>;
> > > +			#size-cells = <0>;
> > > +
> > > +			mdio@0 {
> > > +				reg = <0x00>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@1 {
> > > +				reg = <0x01>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@2 {
> > > +				reg = <0x02>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@3 {
> > > +				reg = <0x03>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@4 {
> > > +				reg = <0x04>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@5 {
> > > +				reg = <0x05>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@6 {
> > > +				reg = <0x06>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +			mdio@7 {
> > > +				reg = <0x07>;
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +			};
> > > +		};
> > > +	};
> > > +
> > >  	i2c-mux@77 {
> > >  		compatible = "nxp,pca9547";
> > >  		reg = <0x77>;
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > index a79f5c1ea56d..7def5252ac1a 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > @@ -762,5 +762,27 @@
> > >  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> > >  			dma-coherent;
> > >  		};
> > > +
> > > +		/* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
> > > +		emdio1: mdio@8b96000 {
> > > +			compatible = "fsl,fman-memac-mdio";
> > > +			reg = <0x0 0x8b96000 0x0 0x1000>;
> > > +			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +			little-endian;	/* force the driver in LE mode */
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		/* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
> > > +		emdio2: mdio@8b97000 {
> > > +			compatible = "fsl,fman-memac-mdio";
> > > +			reg = <0x0 0x8b97000 0x0 0x1000>;
> > > +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +			little-endian;	/* force the driver in LE mode */
> > > +			status = "disabled";
> > > +		};
> > >  	};
> > >  };
> > > --
> > > 2.17.1
> > >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
