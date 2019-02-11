Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2014EC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:43:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C6B2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WG1rW3jo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NsjA7JrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C6B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Se2Y6AxESPzMO4LmQ5Eq/w/pabIFcNxnyy8rromRtk=; b=WG1rW3joWmrm6K
	REnbXCmJ5eGFTpCzUlMxV54onDC83wZMn3rIrfT/4nyuQ95US++6IdohXXN+0DnIMAQy4A+NfnJYh
	k4yDzDJ/QGvePOz6XcGW0baVbdL/3VFsvhA5t2jwrl92DWxHUzKJGTtNSlB/yCnu/RCP9S9ZquUmu
	K7AtkHrd1dLMUU2fj9qF9NxvEoY8HLf8prTKOeb/cZ5yLudsw5Z+pjFXNqxsFUN3HTIyyzGkF/CiP
	bst5qI3YBtOmIKLmBor7bJ5yWDXDmZSTyUnqpubdhQ4KTA3n8HR3c3Hi80Z8pzTSglKJOarSeio98
	fqUZaA8SOORBuC6gqQtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtIQX-0007aW-Bn; Mon, 11 Feb 2019 20:43:41 +0000
Received: from mail-am5eur03on0605.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::605]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtIQS-0007Zk-KA
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 20:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyC51DTLcS6X14SSKIkvmYiHEttQ46/F1RZTLQ3y/tc=;
 b=NsjA7JrIhy06HjHBTP/7kDWmIazchClIcpdDwUM/kSNCdXXjKWxL/YKUvhzsQDAwGArjvTk4zBDouUS064QErtvQV6nh7hFtCLxLDTgUES2oXlYKXGchzpBbiZhVbQaHQzCKeDiQv+5TeVfTg7+Cg6zUSYu5WWUlzYM/u8Q3CnY=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB5765.eurprd04.prod.outlook.com (20.179.2.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Mon, 11 Feb 2019 20:43:30 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 20:43:30 +0000
From: Leo Li <leoyang.li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: RE: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUvgABt0FSxwLfGkq2pK/QIZ0c6qXZ788AgAEnJsA=
Date: Mon, 11 Feb 2019 20:43:30 +0000
Message-ID: <AM6PR04MB5863A68D22DD06F81743AC8B8F640@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190206150520.9683-1-pankaj.bansal@nxp.com>
 <20190211030010.GI22487@dragon>
In-Reply-To: <20190211030010.GI22487@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB5765;
 6:slX+dpNrDUzwhJenUiQau4Q/90GgEdG4DviYvXaGTp4iTzQILqIdp2Yv0DCIhuRodA+iCTtwwfjqK4tYhCbMwgFyJXX/xb0mxWI8q2J6i3YcOptyquy6QPDI1qs8Bgr3ec88+FDe6oLCNngdMFZ0gtntYVb4hZXxBdE9bvb54pCfetbx6Wx21HFM2H05MW6//c3zgXU5Rw0maYvaA63zyeu+xlHzsy79gzx2zk3T5mAsMd5geiXWkAFug4UwsegJ+bwFdu0wktwF+FpF17KMtsdWVPQ3g6vPNcUSpY37HG3WSKbCwGlBwYMG/cpIOvVzj4rBkgr9uA9kiN5JfXmcTNqnjgNqISUqe8+vwUSiV5RgELsNrBqVKLcXindEUSbiu75VG8COCpuehHfW5epDwnjV+jOU9x8QYJ+MdoIahMZAkkngI4XgkcJGam5n6dF28ZEnioWVcjIpvn5hF1WN4w==;
 5:oC7fJAWHLe9zWj9HygQHLSwlj99Z7QHKEO6qpGR2D580KZylY0on4Hl+EM9JYVvp9MhxGCSQ47r4jSvtJL+oUXuGIomK/2Q2jyq3KmGpTKsX4DTTjaEEnrB17ZwZyMmmG66J8sfNOh1oimsN5onc6hDwxhQLoikq4OaBp0gAw64dMm/xOGb3hQxuZijZHUwnsWSIDwRu9VoM3Q2c2Cwgsg==;
 7:un7LXa3g567Q3DdmhrMPVPozVV55U4CHjR9wRbOLLSBvf2ZC4uWKqZ2cSwCwZs+t1yVEAH0xS4a05A8oZB6rA4juflG9pxuK3fXp8u5qPybxdccWJBlZsHn3uQBu/Z0xlvxe7YSvXTbx9u4vaXx03g==
x-ms-office365-filtering-correlation-id: 7a45e2c3-e03b-4f0a-e032-08d6906194cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5765; 
x-ms-traffictypediagnostic: AM6PR04MB5765:
x-microsoft-antispam-prvs: <AM6PR04MB5765B7724DA9D075AA78AE2A8F640@AM6PR04MB5765.eurprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(13464003)(7696005)(478600001)(9686003)(102836004)(6506007)(106356001)(53546011)(26005)(256004)(55016002)(186003)(110136005)(86362001)(54906003)(316002)(6436002)(6636002)(8936002)(14444005)(105586002)(446003)(7736002)(76176011)(305945005)(11346002)(6116002)(476003)(14454004)(229853002)(68736007)(66066001)(74316002)(53936002)(486006)(25786009)(2906002)(81156014)(99286004)(33656002)(4326008)(8676002)(81166006)(71200400001)(6246003)(71190400001)(3846002)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5765;
 H:AM6PR04MB5863.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MgWJCxUVcKIBtMMeqdbtwqhsA4jPZiKazdxzUcuT2XmJk8sFWtGTNmqW6W9M/N+bb6vLoER5FFHHR+kPZN1nUeY3nTUXlme/pw47bf1Vgzd788OTjg6TTVZzho/rYPR9C0oHtW4IChDunT+cHTovHVR9OP8Hx2jvtd2sDZ403+oI1OUSwspnwtHl61RxYD/DEgjs1G21RWgncBlnU8rGimCTyR6dCJcAHojpEAtKFVGWi9Ni3s2N1HLkLweMsEVvbSO+GGOGmcgBg4ZGyd6TtKnsmYpxLn8xQadwaQ/4CkASBCUfp1bkTfOVl2ptImWnTlGIwuQw7KcdX74F+We6+8osdN+dZg5v+6BedCcjzM9h8ToeFIATK9iDAiEOlGxWib54ubhN9Y+oJmQidhs+qziXQQOec3zr3AO3mzPqtzY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a45e2c3-e03b-4f0a-e032-08d6906194cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 20:43:30.1415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5765
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_124336_996694_D81167F7 
X-CRM114-Status: GOOD (  22.84  )
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
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Sunday, February 10, 2019 9:00 PM
> To: Pankaj Bansal <pankaj.bansal@nxp.com>
> Cc: Leo Li <leoyang.li@nxp.com>; Andrew Lunn <andrew@lunn.ch>; Florian
> Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
> 
> On Wed, Feb 06, 2019 at 09:40:33AM +0000, Pankaj Bansal wrote:
> > The two external MDIO buses used to communicate with phy devices that
> > are external to SOC are muxed in LX2160AQDS board.
> >
> > These buses can be routed to any one of the eight IO slots on
> > LX2160AQDS board depending on value in fpga register 0x54.
> >
> > Additionally the external MDIO1 is used to communicate to the onboard
> > RGMII phy devices.
> >
> > The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is
> > controlled by bits 0-3 of fpga register.
> >
> > Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> > ---
> >
> > Notes:
> >     V3:
> >     - Add status = disabled in soc file and status = okay in board file
> >       for external MDIO nodes
> >     - Add interrupts property in external mdio nodes in soc file
> >     V2:
> >     - removed unnecassary TODO statements
> >     - removed device_type from mdio nodes
> >     - change the case of hex number to lowercase
> >     - removed board specific comments from soc file
> >
> >  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 123 +++++++++++++++++
> >  .../boot/dts/freescale/fsl-lx2160a.dtsi      |  22 +++
> >  2 files changed, 145 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > index 99a22abbe725..079264b391a2 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > @@ -35,6 +35,14 @@
> >  	status = "okay";
> >  };
> >
> > +&emdio1 {
> > +	status = "okay";
> > +};
> > +
> > +&emdio2 {
> > +	status = "okay";
> > +};
> > +
> >  &esdhc0 {
> >  	status = "okay";
> >  };
> > @@ -46,6 +54,121 @@
> >  &i2c0 {
> >  	status = "okay";
> >
> > +	fpga@66 {
> > +		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > +		reg = <0x66>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		mdio-mux-1@54 {
> > +			mdio-parent-bus = <&emdio1>;
> > +			reg = <0x54>;		 /* BRDCFG4 */
> > +			mux-mask = <0xf8>;      /* EMI1_MDIO */
> > +			#address-cells=<1>;
> > +			#size-cells = <0>;
> > +
> > +			mdio@0 {
> > +				reg = <0x00>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> 
> Please have a newline between nodes.  It doesn't deserve a respin though.  I
> can fix them up when applying if Leo is fine with this version.

I think there should be a compatible string defined for the binding of parent node mdio-mux, probably "mdio-mux-regmap", and be used here in the device tree.

> 
> Shawn
> 
> > +			mdio@40 {
> > +				reg = <0x40>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@c0 {
> > +				reg = <0xc0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@c8 {
> > +				reg = <0xc8>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@d0 {
> > +				reg = <0xd0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@d8 {
> > +				reg = <0xd8>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@e0 {
> > +				reg = <0xe0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@e8 {
> > +				reg = <0xe8>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@f0 {
> > +				reg = <0xf0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@f8 {
> > +				reg = <0xf8>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +		};
> > +
> > +		mdio-mux-2@54 {
> > +			mdio-parent-bus = <&emdio2>;
> > +			reg = <0x54>;		 /* BRDCFG4 */
> > +			mux-mask = <0x07>;      /* EMI2_MDIO */
> > +			#address-cells=<1>;
> > +			#size-cells = <0>;
> > +
> > +			mdio@0 {
> > +				reg = <0x00>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@1 {
> > +				reg = <0x01>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@2 {
> > +				reg = <0x02>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@3 {
> > +				reg = <0x03>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@4 {
> > +				reg = <0x04>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@5 {
> > +				reg = <0x05>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@6 {
> > +				reg = <0x06>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +			mdio@7 {
> > +				reg = <0x07>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +		};
> > +	};
> > +
> >  	i2c-mux@77 {
> >  		compatible = "nxp,pca9547";
> >  		reg = <0x77>;
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > index a79f5c1ea56d..7def5252ac1a 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -762,5 +762,27 @@
> >  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> >  			dma-coherent;
> >  		};
> > +
> > +		/* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
> > +		emdio1: mdio@8b96000 {
> > +			compatible = "fsl,fman-memac-mdio";
> > +			reg = <0x0 0x8b96000 0x0 0x1000>;
> > +			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			little-endian;	/* force the driver in LE mode */
> > +			status = "disabled";
> > +		};
> > +
> > +		/* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
> > +		emdio2: mdio@8b97000 {
> > +			compatible = "fsl,fman-memac-mdio";
> > +			reg = <0x0 0x8b97000 0x0 0x1000>;
> > +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			little-endian;	/* force the driver in LE mode */
> > +			status = "disabled";
> > +		};
> >  	};
> >  };
> > --
> > 2.17.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
