Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85643C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:01:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFD120844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BEURtmXb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PNUy+YwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFD120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=no9X01ITUoFi8MHxzACnYHUUXWECOpbwlxTASwL9H7k=; b=BEURtmXbkI47qS
	jVW85Wl9io9kq9xcQu9jTZlwybxyqB8QFMuR4nn2lPC7wXH4p8hDuzqK9du68FxfUEN5c3aEyAJUf
	rpGRbjxrpiZhASRJLdimI+fMDoQTSDaaxOgqfGhXKe5FKGeuadKbZk71ipYfOusy6T6Nhu35rHHRS
	cDj5ElF+n3vkiw9wNJ6TBZ9imMsVCitoSP/AaQXNYBxdRbPMK1416Ghud2Bg3EuL9FgQIIhf1o++K
	eHKVq2MGp6udrXD6OPPY+X5NwfgYU5ptLW0KrFUiJt+DQZQ45LNeyRMZVCcScgOpSqOUrI0M/1vnE
	SxtDylXBv76JVMOWS5qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grEPB-0006Mi-Gc; Wed, 06 Feb 2019 04:01:45 +0000
Received: from mail-db3eur04on0603.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::603]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grEP6-0006MH-Bh
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 04:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbrI7kvRqd6dk3kVxCiXUjDBdqcDwVfp7LMNs1t/NQg=;
 b=PNUy+YwPmx7EFuP0/7O8lmbYEGK3EEQn1l7VjxWZkc56gDSpG+CXhNxbA63qxETTcvfmUCGoAEkRJGLBpkbaIM8iq88sHflzj3QDBiqvLBezm0GCoCeWSdgeBatJYVnrqdqe/7BnA0nbMAsn7Z5THjpPZSCNktenulRD63a3/ZQ=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2334.eurprd04.prod.outlook.com (10.169.133.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 04:01:35 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 04:01:35 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUvGbiC8iYo4SL4Um4n0hI+dty16XRitIAgACaaaA=
Date: Wed, 6 Feb 2019 04:01:35 +0000
Message-ID: <VI1PR0401MB24968690F3E3677E5EE8DE49F16F0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190204141641.18272-1-pankaj.bansal@nxp.com>
 <CADRPPNSnPoEwUFKK0=FE9RG9QfTUPKoTXkZPVEpskC13mD-R2A@mail.gmail.com>
In-Reply-To: <CADRPPNSnPoEwUFKK0=FE9RG9QfTUPKoTXkZPVEpskC13mD-R2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2334;
 6:ryZAhgNXTF5AEpBBZydsto7E5iGk7KdoC5KWSEzNgFWMPkguTXAAUgBcYYINKUvbktsRICMboetlmFBUPHryvJIv3V8A0HRbYF4kgh06fzObNL/cORM84hU0NLBF8hggP8FIfPz2gxJUPeomJVxeX+pszqATT8LKuWGwqABjmu51qhdSsj/krk9+mW9SkjL7nAGhMcr6KN99p2lTwPouF7Oqzok4gXQsqsQ1j2MzpbWwyX5BVfKreVAdf4zqr0cySNDCXwmoF1owVkXvLy+P4OIFBJWlZY71dNTKUajio0ziIyhjBl6fA3ZPT/bzoXPnUqHthNG6BwUD890DM2TVGwdP53MPSMJJ6v/G3rHDl5WYDnefJIXBFm0F4mOjzHpAZnrl2sfQ3hDwgGBx3NQy3Xsd2h0iUayow909EdppXw9f6oUalvvThFkpWEcHgL+Mb50hcdw0RdqVF2yP+NWqvA==;
 5:Gw3Nz+rdtzz9Z7yTc+HTC3kPHh9X0H5xQ5MuCRqFfcHWPoONQUe38+mJ1SojAsLD8/IiWkf+mPiCcAhrKhAmpjbsdEcrJDBit4k4xGwJ/khKntkcN1PxYBDFPb4sqCE1uEFEPLXPwDJtHO12bLYFpqf+gSD3IApqPokumu6ENaIyTkl4KFFlm5trXGPlHzdvH9UhM9KkFdmWWexr0FEPCg==;
 7:sJMuY+pZhtfCfWgpJh8wuiDzzZXM1+hPlbEARMXO6UcasyPu+h9JIbbMRQOK5oW9777Uq/+44hquuIy00bTJVHvi8EorrGr17OYR++p/htou1F1NlqgxCuUsUYWO3WPymqgttwHYnKnWse0XkmZmdw==
x-ms-office365-filtering-correlation-id: 2476dad7-375b-4c4f-1c17-08d68be7c97c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2334; 
x-ms-traffictypediagnostic: VI1PR0401MB2334:
x-microsoft-antispam-prvs: <VI1PR0401MB2334F92BC06F561006F5155BF16F0@VI1PR0401MB2334.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(13464003)(199004)(189003)(8936002)(8676002)(81166006)(81156014)(54906003)(44832011)(97736004)(256004)(99286004)(229853002)(486006)(25786009)(102836004)(53936002)(446003)(11346002)(74316002)(4326008)(6116002)(3846002)(6436002)(14454004)(478600001)(106356001)(86362001)(105586002)(6862004)(305945005)(186003)(476003)(316002)(6246003)(33656002)(6636002)(68736007)(71200400001)(9686003)(71190400001)(66066001)(53546011)(2906002)(6506007)(7736002)(55016002)(76176011)(7696005)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2334;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T/OCiykNlpr+eVygEKTVp/g2PCM6rZnNWUqkQNgQfEx69uTEXgpMjdx/b3ZmG7ys8s4F4RlDEQ8q9vQd/BEJsp8dxsBejRT0EQRLv2nDkTfjJ5rob1X09irz5ZdirAViIVCeqvv9U+zO2do9Ea/bCwnltRUczJ9xLSTeXddMNo66JnxvBSf6UUt6HfUdVCDm5kNthX2IOxAn5xB8AOzFWMaZ8u74iuncYroDdzvtqCFUZaVloWD9Simk7mq6dPDX5BLs8zwY6R/5Eg0PubYdjfP0W1WoulN+6UueP6jmubZKBMTBNibXGOehmxNBRVA3tuNDxeINwJhK7hFyC+zg2K0LvQ9Rm6pc7JUG2wIpn9TP+J3gatefM2JIuAKX2pRNMp9HxnQqW2olfqPQhO7IYCOyNXYSYltm6u0T8Gdekd0=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2476dad7-375b-4c4f-1c17-08d68be7c97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 04:01:35.2183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2334
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_200140_772990_8DF4F34A 
X-CRM114-Status: GOOD (  21.66  )
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
> Sent: Wednesday, 6 February, 2019 12:07 AM
> To: Pankaj Bansal <pankaj.bansal@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Andrew Lunn <andrew@lunn.ch>;
> Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
> 
> On Mon, Feb 4, 2019 at 2:53 AM Pankaj Bansal <pankaj.bansal@nxp.com>
> wrote:
> >
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
> >     V2:
> >     - removed unnecassary TODO statements
> >     - removed device_type from mdio nodes
> >     - change the case of hex number to lowercase
> >     - removed board specific comments from soc file
> 
> There are still some comments from V1 haven't been addressed.
> 
> >
> >  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 115 +++++++++++++++++
> >  .../boot/dts/freescale/fsl-lx2160a.dtsi      |  18 +++
> >  2 files changed, 133 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > index 99a22abbe725..2c3020a72d41 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > @@ -46,6 +46,121 @@
> >  &i2c0 {
> >         status = "okay";
> >
> > +       fpga@66 {
> > +               compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > +               reg = <0x66>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               mdio-mux-1@54 {
> 
> Still no compatible string defined for the node.  Probably should be "mdio-mux-
> mmioreg", "mdio-mux"

it is not a specific device. MDIO mux is meant to be controlled by some registers of parent device (FPGA).
Therefore, IMO this should not be a device and there should not be any "compatible" property for it.

> 
> > +                       mdio-parent-bus = <&emdio1>;
> > +                       reg = <0x54>;            /* BRDCFG4 */
> > +                       mux-mask = <0xf8>;      /* EMI1_MDIO */
> > +                       #address-cells=<1>;
> > +                       #size-cells = <0>;
> > +
> > +                       mdio@0 {
> > +                               reg = <0x00>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@40 {
> > +                               reg = <0x40>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@c0 {
> > +                               reg = <0xc0>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@c8 {
> > +                               reg = <0xc8>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@d0 {
> > +                               reg = <0xd0>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@d8 {
> > +                               reg = <0xd8>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@e0 {
> > +                               reg = <0xe0>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@e8 {
> > +                               reg = <0xe8>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@f0 {
> > +                               reg = <0xf0>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@f8 {
> > +                               reg = <0xf8>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +               };
> > +
> > +               mdio-mux-2@54 {
> > +                       mdio-parent-bus = <&emdio2>;
> > +                       reg = <0x54>;            /* BRDCFG4 */
> > +                       mux-mask = <0x07>;      /* EMI2_MDIO */
> > +                       #address-cells=<1>;
> > +                       #size-cells = <0>;
> > +
> > +                       mdio@0 {
> > +                               reg = <0x00>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@1 {
> > +                               reg = <0x01>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@2 {
> > +                               reg = <0x02>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@3 {
> > +                               reg = <0x03>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@4 {
> > +                               reg = <0x04>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@5 {
> > +                               reg = <0x05>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@6 {
> > +                               reg = <0x06>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +                       mdio@7 {
> > +                               reg = <0x07>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                       };
> > +               };
> > +       };
> > +
> >         i2c-mux@77 {
> >                 compatible = "nxp,pca9547";
> >                 reg = <0x77>;
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > index a79f5c1ea56d..a74045ad22ad 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -762,5 +762,23 @@
> >                                      <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> >                         dma-coherent;
> >                 };
> > +
> > +               /* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
> > +               emdio1: mdio@8b96000 {
> > +                       compatible = "fsl,fman-memac-mdio";
> > +                       reg = <0x0 0x8b96000 0x0 0x1000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       little-endian;  /* force the driver in LE mode
> > + */
> 
> Still doesn't fully align with the binding at
> "Documentation/devicetree/bindings/powerpc/fsl/fman.txt".
> 
> It should either have the "interrupts" property for external MDIO or "fsl,fman-
> internal-mdio" for internal MDIO.

I see that for DPAA1 based SOCs, there was definitely an interrupt property in external MDIO node.
BUT, for DPAA2 based devices none of the SOC has this property. I am looking further into this.

> 
> > +               };
> > +
> > +               /* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
> > +               emdio2: mdio@8b97000 {
> > +                       compatible = "fsl,fman-memac-mdio";
> > +                       reg = <0x0 0x8b97000 0x0 0x1000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       little-endian;  /* force the driver in LE mode */
> > +               };
> >         };
> >  };
> > --
> > 2.17.1
> >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
