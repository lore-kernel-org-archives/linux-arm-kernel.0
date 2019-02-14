Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:33:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4481F21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pDNJor/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4481F21B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YJz6kvAQcsii1oQ4anbcl2BnRE4Eg/bb+2dwUR4x81Q=; b=pDNJor/3kwCEui
	Iaa+aiM6aC0ep74eaBfJYrQemyFKTgYMI988whCMzeMH3cR2JdO6IvAdJcgPkZ4zOFfYhjl8butTE
	2/BcsYqfs7uI7EDxTbrkibZkiM6SKncHlNbV40iGlmchVtmNBjwEa6hCiFg4Cx4WRUcDnZmddFu6m
	BgWz6J7Ca66/8qnagiHS2umpgTqHfNpfYy+6WSX6jIgVSkoBWiq8YQRUPGpKT1weHTMc0cfD4gn14
	k++BtJ8F7vW9+cymbGKS8gIAOU6uCAWz9LDOv9b8E+0xCH5onlIOgFnAo76TuNthT/gcePGgvFYDe
	jRL17g+r680RyiHWPhtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guPZ4-0004Up-OS; Thu, 14 Feb 2019 22:33:06 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guPZ0-0004UO-S7
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 22:33:04 +0000
Received: by mail-ot1-f68.google.com with SMTP id n8so13382997otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 14:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dHdR0q6QQ/X07/rXUZ/iC2nvs1MP20COdweIbE5iHEw=;
 b=h/YZKa77y+CnOWtX/HKseemlJGhaVdINIC7NrBzIMy2Lx2B15KIFfoUP0i8+OawPye
 Ej8YJHDSDIMueyD1gbJSytNACJeNx0wsdXp62q/M91uRlkQgFd1PS3nXm0T9PS25GRA4
 NmCRkONr9w+juPOlIes7/gJAgKAOs0VqJvkxscMeb8xSYvNK3ZqoHDgu0afPefqB7SpP
 kq85ibbSA9b+d93ydll2j6qYrXTn42cpC2VxvA+IA+9xBvjJegtVE8zplyVwcdkPlUXu
 dPb4G/cVWcpZttrobm8BlSZg7OomcXRnrnPsUglAnAUIusxxwRAlIT/F9h2glFVRa9rf
 ZrKw==
X-Gm-Message-State: AHQUAubmo+g5necq2w0p5cuNvtVTDp7nDWawbrMyFjaOfk6HxIPEFNho
 D9qRb1gYlDz/3mf7sgDA/xxe0mnm
X-Google-Smtp-Source: AHgI3IbcOFxb9ULtUKKABVKo7ZVMGi+XCsHHToemEng7L5cSWNaeerXvKvYvFs0JaEBc3m0WfWuUQA==
X-Received: by 2002:aca:f244:: with SMTP id q65mr3744305oih.50.1550183581320; 
 Thu, 14 Feb 2019 14:33:01 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com.
 [209.85.210.46])
 by smtp.gmail.com with ESMTPSA id 11sm3150469oth.35.2019.02.14.14.33.00
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 14:33:00 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id u16so13348945otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 14:33:00 -0800 (PST)
X-Received: by 2002:a9d:2387:: with SMTP id t7mr3799777otb.68.1550183580168;
 Thu, 14 Feb 2019 14:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20190206150520.9683-1-pankaj.bansal@nxp.com>
 <20190211030010.GI22487@dragon>
 <AM6PR04MB5863A68D22DD06F81743AC8B8F640@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM5PR0401MB24818DB35D5DEF95DA710038F1650@AM5PR0401MB2481.eurprd04.prod.outlook.com>
 <CADRPPNTEE7beTyR-3ezSBuaNm-9vMAiUVKWYUkr_gd8nswMSYg@mail.gmail.com>
In-Reply-To: <CADRPPNTEE7beTyR-3ezSBuaNm-9vMAiUVKWYUkr_gd8nswMSYg@mail.gmail.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 14 Feb 2019 16:32:47 -0600
X-Gmail-Original-Message-ID: <CADRPPNTua4AmYC6_AkDYKbyOXXzpR+7a1nLTe=_Qn-KhXck=8w@mail.gmail.com>
Message-ID: <CADRPPNTua4AmYC6_AkDYKbyOXXzpR+7a1nLTe=_Qn-KhXck=8w@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
To: Pankaj Bansal <pankaj.bansal@nxp.com>, Rob Herring <robh+dt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_143302_912898_1B40155E 
X-CRM114-Status: GOOD (  32.68  )
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

On Tue, Feb 12, 2019 at 12:01 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Mon, Feb 11, 2019 at 9:28 PM Pankaj Bansal <pankaj.bansal@nxp.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Leo Li
> > > Sent: Tuesday, 12 February, 2019 02:14 AM
> > > To: Shawn Guo <shawnguo@kernel.org>; Pankaj Bansal
> > > <pankaj.bansal@nxp.com>
> > > Cc: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>;
> > > netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > Subject: RE: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Shawn Guo <shawnguo@kernel.org>
> > > > Sent: Sunday, February 10, 2019 9:00 PM
> > > > To: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > > Cc: Leo Li <leoyang.li@nxp.com>; Andrew Lunn <andrew@lunn.ch>; Florian
> > > > Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; linux-arm-
> > > > kernel@lists.infradead.org
> > > > Subject: Re: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
> > > >
> > > > On Wed, Feb 06, 2019 at 09:40:33AM +0000, Pankaj Bansal wrote:
> > > > > The two external MDIO buses used to communicate with phy devices
> > > > > that are external to SOC are muxed in LX2160AQDS board.
> > > > >
> > > > > These buses can be routed to any one of the eight IO slots on
> > > > > LX2160AQDS board depending on value in fpga register 0x54.
> > > > >
> > > > > Additionally the external MDIO1 is used to communicate to the
> > > > > onboard RGMII phy devices.
> > > > >
> > > > > The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is
> > > > > controlled by bits 0-3 of fpga register.
> > > > >
> > > > > Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > > > ---
> > > > >
> > > > > Notes:
> > > > >     V3:
> > > > >     - Add status = disabled in soc file and status = okay in board file
> > > > >       for external MDIO nodes
> > > > >     - Add interrupts property in external mdio nodes in soc file
> > > > >     V2:
> > > > >     - removed unnecassary TODO statements
> > > > >     - removed device_type from mdio nodes
> > > > >     - change the case of hex number to lowercase
> > > > >     - removed board specific comments from soc file
> > > > >
> > > > >  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 123 +++++++++++++++++
> > > > >  .../boot/dts/freescale/fsl-lx2160a.dtsi      |  22 +++
> > > > >  2 files changed, 145 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > > > index 99a22abbe725..079264b391a2 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > > > @@ -35,6 +35,14 @@
> > > > >   status = "okay";
> > > > >  };
> > > > >
> > > > > +&emdio1 {
> > > > > + status = "okay";
> > > > > +};
> > > > > +
> > > > > +&emdio2 {
> > > > > + status = "okay";
> > > > > +};
> > > > > +
> > > > >  &esdhc0 {
> > > > >   status = "okay";
> > > > >  };
> > > > > @@ -46,6 +54,121 @@
> > > > >  &i2c0 {
> > > > >   status = "okay";
> > > > >
> > > > > + fpga@66 {
> > > > > +         compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > > > > +         reg = <0x66>;
> > > > > +         #address-cells = <1>;
> > > > > +         #size-cells = <0>;
> > > > > +
> > > > > +         mdio-mux-1@54 {
> > > > > +                 mdio-parent-bus = <&emdio1>;
> > > > > +                 reg = <0x54>;            /* BRDCFG4 */
> > > > > +                 mux-mask = <0xf8>;      /* EMI1_MDIO */
> > > > > +                 #address-cells=<1>;
> > > > > +                 #size-cells = <0>;
> > > > > +
> > > > > +                 mdio@0 {
> > > > > +                         reg = <0x00>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > >
> > > > Please have a newline between nodes.  It doesn't deserve a respin
> > > > though.  I can fix them up when applying if Leo is fine with this version.
> > >
> > > I think there should be a compatible string defined for the binding of parent
> > > node mdio-mux, probably "mdio-mux-regmap", and be used here in the device
> > > tree.
> >
> > I have two concerns :
> > 1. The regmap is linux s/w construct, while device tree is h/w representation and is s/w agnostic. can we use regmap in device tree?
>
> Well, if we want to avoid using the regmap name, we probably can try
> "mdio-mux-reg" or "mdio-mux-syscon"?  With further search I also found
> a more generic mux binding at Documentation/devicetree/bindings/mux/,
> would be even better if we can use that to describe the mux.


To make it more clear, with the use of
Documentation/devicetree/bindings/mux/ binding, I think it would end
up with something like this:

i2c {
 fpga {
  compatible = "fsl,lx2160aqds-fpga", "syscon";
  ....
  mux: mux-controller {
   compatible = "mmio-mux"
   ...
  }
 }
...
}

mdio-mux {
 compatible = "mdio-mux"
 mux-controls = <&mux 0>;
 ....
 mdio {
  phy {
  }
  ...
 }
 mdio {
  ...
 }
 ...
}


}"

>
> > 2. By convention the device tree compatible binding is defined as "<manufacturer>,<model>" e.g. "fsl,mpc8349-uart". The mdio-mux node and it's sub nodes are a generic representation of mdio mux and it is not dependent on a particular manufacturer device. How to define the compatible in this case?
>
> The manufacturer prefix is for vendor specific bindings.  If the
> binding a suppose to be generic, we don't need the vendor prefix.
>
> >
> > >
> > > >
> > > > Shawn
> > > >
> > > > > +                 mdio@40 {
> > > > > +                         reg = <0x40>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@c0 {
> > > > > +                         reg = <0xc0>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@c8 {
> > > > > +                         reg = <0xc8>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@d0 {
> > > > > +                         reg = <0xd0>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@d8 {
> > > > > +                         reg = <0xd8>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@e0 {
> > > > > +                         reg = <0xe0>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@e8 {
> > > > > +                         reg = <0xe8>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@f0 {
> > > > > +                         reg = <0xf0>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@f8 {
> > > > > +                         reg = <0xf8>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +         };
> > > > > +
> > > > > +         mdio-mux-2@54 {
> > > > > +                 mdio-parent-bus = <&emdio2>;
> > > > > +                 reg = <0x54>;            /* BRDCFG4 */
> > > > > +                 mux-mask = <0x07>;      /* EMI2_MDIO */
> > > > > +                 #address-cells=<1>;
> > > > > +                 #size-cells = <0>;
> > > > > +
> > > > > +                 mdio@0 {
> > > > > +                         reg = <0x00>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@1 {
> > > > > +                         reg = <0x01>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@2 {
> > > > > +                         reg = <0x02>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@3 {
> > > > > +                         reg = <0x03>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@4 {
> > > > > +                         reg = <0x04>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@5 {
> > > > > +                         reg = <0x05>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@6 {
> > > > > +                         reg = <0x06>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +                 mdio@7 {
> > > > > +                         reg = <0x07>;
> > > > > +                         #address-cells = <1>;
> > > > > +                         #size-cells = <0>;
> > > > > +                 };
> > > > > +         };
> > > > > + };
> > > > > +
> > > > >   i2c-mux@77 {
> > > > >           compatible = "nxp,pca9547";
> > > > >           reg = <0x77>;
> > > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > > index a79f5c1ea56d..7def5252ac1a 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > > @@ -762,5 +762,27 @@
> > > > >                                <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> > > > >                   dma-coherent;
> > > > >           };
> > > > > +
> > > > > +         /* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
> > > > > +         emdio1: mdio@8b96000 {
> > > > > +                 compatible = "fsl,fman-memac-mdio";
> > > > > +                 reg = <0x0 0x8b96000 0x0 0x1000>;
> > > > > +                 interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +                 #address-cells = <1>;
> > > > > +                 #size-cells = <0>;
> > > > > +                 little-endian;  /* force the driver in LE mode */
> > > > > +                 status = "disabled";
> > > > > +         };
> > > > > +
> > > > > +         /* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
> > > > > +         emdio2: mdio@8b97000 {
> > > > > +                 compatible = "fsl,fman-memac-mdio";
> > > > > +                 reg = <0x0 0x8b97000 0x0 0x1000>;
> > > > > +                 interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +                 #address-cells = <1>;
> > > > > +                 #size-cells = <0>;
> > > > > +                 little-endian;  /* force the driver in LE mode */
> > > > > +                 status = "disabled";
> > > > > +         };
> > > > >   };
> > > > >  };
> > > > > --
> > > > > 2.17.1
> > > > >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
