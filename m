Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05815C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:17:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CF1218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A+yotMpV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tXFeSD2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CF1218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z6IiNmEZsdvkvR411YnmEWnLPl18elSQIxIN2r3NF2U=; b=A+yotMpVB6+hsu
	xDFkOLyr0jMAjfqccLums8oCsV1bUvwSLVAJi9Ub/Tkd7CxdX1A0DrFClZ+Bust4GihXaqwn9YA6G
	uRFeQUU6jl7iVmGMcO1zYOvVePmzQIgaVZwi7DyOVL7ZxyDK5HuRHWoxxRNjUC4zNjETfF0wvgiTy
	MrcOo1G7eUdrJt96sc23K6EWZWJKzA3llYpoUWtdfa+MjPTKaIGzrRV0g66BfqdFUIZbMtenjqC7J
	wAHO+4R3RStRAdcYpSOWN6k+jZJGvweNRgihhtIvQeAKMZtZaRE7BbPilDuWzSwBrvyFWcglwKyCh
	wzz1lLrWFGnTub1pPOEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grUZb-0004x4-DZ; Wed, 06 Feb 2019 21:17:35 +0000
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grUZY-0004wM-9N
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 21:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOceI/F94sSOtysWHFelZLSa0pVPVbuN4S8V41M1esE=;
 b=tXFeSD2wBZnnW/pUlTDWVsPAzg5ZBt653TLyI0v5dZZbxyJgiO6jHuaHhr66WmKNCg0arJENYFvUeMLEY8ri6ZnCUgNnx2UaR9xjv5FnANZDAa3snvhT8MhIXwrZawhkfwijztJI0VoLYP7XVTUsTCJh2DoBG6/NA2hUWL9hNvg=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB4584.eurprd04.prod.outlook.com (20.177.39.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 21:17:26 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 21:17:26 +0000
From: Leo Li <leoyang.li@nxp.com>
To: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: RE: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUvGbiC8iYo4SL4Um4n0hI+dty16XRitIAgACaaaCAAQxf4A==
Date: Wed, 6 Feb 2019 21:17:26 +0000
Message-ID: <AM6PR04MB58636BDAAAAEA71B7B1DC7F28F6F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190204141641.18272-1-pankaj.bansal@nxp.com>
 <CADRPPNSnPoEwUFKK0=FE9RG9QfTUPKoTXkZPVEpskC13mD-R2A@mail.gmail.com>
 <VI1PR0401MB24968690F3E3677E5EE8DE49F16F0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB24968690F3E3677E5EE8DE49F16F0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [136.62.168.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB4584;
 6:vKPRlxTftDAZ4Pc9BFTlpCYLraASQERzxZgFnp3KfAQBYLXEHG2JMOzmm3sAOCtqAyjzLl15xz4ffeNuwjZgKW8X0OtWa1yyXECaeexjV/eOqFeWms0TSk9J2GBnFhG1fE/oAhr9FKCuyiqSqDxc+vzRUhZg0PBuS4pOrvciWDsdfoL3b34ppwj5LHzhscVWAS0q0sW0JKV8z2Yk4DODBDbUbSFHPyoUuX+dDTw23dwVQGpUtkCuhKyXwxCrkEYyQd3KetWSP9VJQsvQjZlKiTfk79ZDBJRWMt98tX/eHM3XJMBzZiqM3JGOdseuTepqOdKQo75INMHBnF+Sh07UdHN6FFJXn5LrCKrnbKzYk8VzqJA0amob3qNdc3Geemkppk01TO3SyjMSrSiTRpeBRMEdwm09LPguDMsAwCMJZZZgHrstyiSvC3WPvTntN20nouXSO9POwkcJGyZNZKN/eQ==;
 5:GAmBnGcJvzEEi4iix/b4QWbXCBnBeSVl3eUzJdnHUvcTLDNTUOxDogwLiDIBVH4K6Gl33UrqjoaZ1z1V0Qzjh2paEjWVadkytbtdhoddjYf5IbOZdi46EnOhmtbjJ/gvARraxwy4CwT3X8ILwqdAfrHnTL/488zbbVtxu0QDj5MXq9G5lM1qL9o3YvLpY/s4HDU6Ue57hc60Dibj+xlE9w==;
 7:FenRnykqoue9zIwF0WUnBg0ALcvAVTLG7IOWQtpOjQI0YTczKjmiXlyiq9JVY0axfHSQJiHpTmODtB2lkQ19DAL7znAOVA4czSkjUJb3q5prx6zA+uRISOBqjzoHnPHl5t79E6RRH7r4JzSClMaZ+g==
x-ms-office365-filtering-correlation-id: 2c2718be-d422-42db-93eb-08d68c787e83
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4584; 
x-ms-traffictypediagnostic: AM6PR04MB4584:
x-microsoft-antispam-prvs: <AM6PR04MB4584C3F530B446AEB9DAE8818F6F0@AM6PR04MB4584.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(366004)(39860400002)(396003)(13464003)(199004)(189003)(76176011)(229853002)(81156014)(54906003)(53546011)(6506007)(486006)(446003)(8936002)(33656002)(316002)(106356001)(476003)(11346002)(102836004)(186003)(4326008)(99286004)(7696005)(478600001)(71190400001)(71200400001)(6436002)(14454004)(53936002)(66066001)(68736007)(6246003)(6862004)(3846002)(26005)(6116002)(86362001)(256004)(25786009)(8676002)(7736002)(97736004)(81166006)(305945005)(2906002)(6636002)(55016002)(74316002)(105586002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4584;
 H:AM6PR04MB5863.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 21ILPjeqVDws7nC58yu1U9VrQdhJPJr2HrJrdhUSDbq4e7VvmKGRdI0YfLvETOC8+Qx5xvyBCUywNuFPhUREMjMMaQBOr/eD8Ix16g8e6/nEk/vn9ReYbjeLxM04O0fzJrSukyvpubJldKiIHRaJB4iAUYBiA/1mWDZlj4BTXYUUJg+Cx+yeaR7WjdHYudlEJETnropuE3tIqQPgwfcvdZUR+/cszQ2BZOnG1bf7bhKu8mlkr8Ux+nCn30+mVGA/BIWOT5cLCGDvkWjbhsbWGyQnHZXiirm6nwCy0uCs7H9kn9ObmI2gKrfspMiyzMTisgfkH06OhO+LfpABg7TCWQflqlVOOCgL2ohWSmIp9OHJMmLNkz1g+DlUGe3MnpfjD0Cy6iAFaZRgkGjYPLU0Q1fRQQ7hnCL4ZuwTE1j23NM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2718be-d422-42db-93eb-08d68c787e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 21:17:26.4799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4584
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_131732_509742_03F48028 
X-CRM114-Status: GOOD (  26.22  )
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
> From: Pankaj Bansal
> Sent: Tuesday, February 5, 2019 10:02 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Andrew Lunn <andrew@lunn.ch>;
> Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
> 
> 
> 
> > -----Original Message-----
> > From: Li Yang [mailto:leoyang.li@nxp.com]
> > Sent: Wednesday, 6 February, 2019 12:07 AM
> > To: Pankaj Bansal <pankaj.bansal@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Andrew Lunn
> <andrew@lunn.ch>;
> > Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org;
> > linux-arm- kernel@lists.infradead.org
> > Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
> >
> > On Mon, Feb 4, 2019 at 2:53 AM Pankaj Bansal <pankaj.bansal@nxp.com>
> > wrote:
> > >
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
> > >     V2:
> > >     - removed unnecassary TODO statements
> > >     - removed device_type from mdio nodes
> > >     - change the case of hex number to lowercase
> > >     - removed board specific comments from soc file
> >
> > There are still some comments from V1 haven't been addressed.
> >
> > >
> > >  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 115 +++++++++++++++++
> > >  .../boot/dts/freescale/fsl-lx2160a.dtsi      |  18 +++
> > >  2 files changed, 133 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > index 99a22abbe725..2c3020a72d41 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > @@ -46,6 +46,121 @@
> > >  &i2c0 {
> > >         status = "okay";
> > >
> > > +       fpga@66 {
> > > +               compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > > +               reg = <0x66>;
> > > +               #address-cells = <1>;
> > > +               #size-cells = <0>;
> > > +
> > > +               mdio-mux-1@54 {
> >
> > Still no compatible string defined for the node.  Probably should be
> > "mdio-mux- mmioreg", "mdio-mux"
> 
> it is not a specific device. MDIO mux is meant to be controlled by some
> registers of parent device (FPGA).
> Therefore, IMO this should not be a device and there should not be any
> "compatible" property for it.

If it is not a device why we are defining a device node for it?  It is probably not a physical device per se, but it can be considered a virtual device provided by FPGA.

This also bring up another question that why this device cannot reuse the existing drivers/net/phy/mdio-mux-mmioreg.c driver?  If we think regmap is a better solution, shall we replace the mmioreg driver with the regmap driver?

> 
> >
> > > +                       mdio-parent-bus = <&emdio1>;
> > > +                       reg = <0x54>;            /* BRDCFG4 */
> > > +                       mux-mask = <0xf8>;      /* EMI1_MDIO */
> > > +                       #address-cells=<1>;
> > > +                       #size-cells = <0>;
> > > +
> > > +                       mdio@0 {
> > > +                               reg = <0x00>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@40 {
> > > +                               reg = <0x40>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@c0 {
> > > +                               reg = <0xc0>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@c8 {
> > > +                               reg = <0xc8>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@d0 {
> > > +                               reg = <0xd0>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@d8 {
> > > +                               reg = <0xd8>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@e0 {
> > > +                               reg = <0xe0>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@e8 {
> > > +                               reg = <0xe8>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@f0 {
> > > +                               reg = <0xf0>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@f8 {
> > > +                               reg = <0xf8>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +               };
> > > +
> > > +               mdio-mux-2@54 {
> > > +                       mdio-parent-bus = <&emdio2>;
> > > +                       reg = <0x54>;            /* BRDCFG4 */
> > > +                       mux-mask = <0x07>;      /* EMI2_MDIO */
> > > +                       #address-cells=<1>;
> > > +                       #size-cells = <0>;
> > > +
> > > +                       mdio@0 {
> > > +                               reg = <0x00>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@1 {
> > > +                               reg = <0x01>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@2 {
> > > +                               reg = <0x02>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@3 {
> > > +                               reg = <0x03>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@4 {
> > > +                               reg = <0x04>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@5 {
> > > +                               reg = <0x05>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@6 {
> > > +                               reg = <0x06>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +                       mdio@7 {
> > > +                               reg = <0x07>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +                       };
> > > +               };
> > > +       };
> > > +
> > >         i2c-mux@77 {
> > >                 compatible = "nxp,pca9547";
> > >                 reg = <0x77>;
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > index a79f5c1ea56d..a74045ad22ad 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > @@ -762,5 +762,23 @@
> > >                                      <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> > >                         dma-coherent;
> > >                 };
> > > +
> > > +               /* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
> > > +               emdio1: mdio@8b96000 {
> > > +                       compatible = "fsl,fman-memac-mdio";
> > > +                       reg = <0x0 0x8b96000 0x0 0x1000>;
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <0>;
> > > +                       little-endian;  /* force the driver in LE
> > > + mode */
> >
> > Still doesn't fully align with the binding at
> > "Documentation/devicetree/bindings/powerpc/fsl/fman.txt".
> >
> > It should either have the "interrupts" property for external MDIO or
> > "fsl,fman- internal-mdio" for internal MDIO.
> 
> I see that for DPAA1 based SOCs, there was definitely an interrupt property
> in external MDIO node.
> BUT, for DPAA2 based devices none of the SOC has this property. I am
> looking further into this.
> 
> >
> > > +               };
> > > +
> > > +               /* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
> > > +               emdio2: mdio@8b97000 {
> > > +                       compatible = "fsl,fman-memac-mdio";
> > > +                       reg = <0x0 0x8b97000 0x0 0x1000>;
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <0>;
> > > +                       little-endian;  /* force the driver in LE mode */
> > > +               };
> > >         };
> > >  };
> > > --
> > > 2.17.1
> > >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
