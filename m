Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000BFC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:43:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25402084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lT1IT3uA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BVQiI1ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25402084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=380TnODQBLKCcjxSkYMakZXYWwV3xKlIeU8ZdSYNorA=; b=lT1IT3uAoJUqTB
	MrgsUin9/JfEkb39U2aavc2dtbvKn35R4vOCXeWYWi9KTH8EwbK3tNcZ6C/k77+brw45V3TKB5M1H
	OYlPq1WjhVoMINaBXZABFSbAYe1mIadmW1uhXg/d30iH+60KqQJ4gaDUf0UmtwYcDegIXe7qg8OdY
	05pNzoTSbz9DW5VY2AcCOs+LGNivc4M4jXzvnVS4plsoCZQHGGHH8G9cQu3zy/HKSlPvJHa4xSJR0
	KKxrCk88A1KBwEXyMz80XRr+ejhkS5zxE2aVcMlqY/vQlNU9MNWVfEJEuob6aoRBPK3twTGle1I+g
	a/zGm040IN71iaZAp5+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grbX9-0002fT-2W; Thu, 07 Feb 2019 04:43:31 +0000
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grbX4-0002em-KB
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 04:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CLlfZ7k2HeW1miMbgDkUCdPIup3vMCFGjJo2yksDwM=;
 b=BVQiI1ugK1AOEUMylB5D2u+LkCgupSFrwrfX8LFwaip5IZINm7Dhhbnhfx+9sDvcOdyl27tuUxCz+FOYjpV2Xuq1KpoKYBbP93AKS38z2yHXMF+SwohtMDfse4cmQk/1EAdyS41fG12OerImPkfo4jPSYTUENUk4YGahmMSbL/c=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2367.eurprd04.prod.outlook.com (10.169.134.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 04:42:38 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 04:42:38 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUvGbiC8iYo4SL4Um4n0hI+dty16XRitIAgACaaaCAAQxf4IAAH+EAgAAgHICAAErHcA==
Date: Thu, 7 Feb 2019 04:42:37 +0000
Message-ID: <VI1PR0401MB24966218B333880762D931B5F1680@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190204141641.18272-1-pankaj.bansal@nxp.com>
 <CADRPPNSnPoEwUFKK0=FE9RG9QfTUPKoTXkZPVEpskC13mD-R2A@mail.gmail.com>
 <VI1PR0401MB24968690F3E3677E5EE8DE49F16F0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <AM6PR04MB58636BDAAAAEA71B7B1DC7F28F6F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <20190206214432.GB32483@lunn.ch>
 <CADRPPNRFfP1UHSF+99LJ_6QMCFeXi=QhmNJAhAtBPZ_pJ-jmgg@mail.gmail.com>
In-Reply-To: <CADRPPNRFfP1UHSF+99LJ_6QMCFeXi=QhmNJAhAtBPZ_pJ-jmgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [49.36.128.243]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2367;
 6:c/48yJ/IP07KhyLfuL9MwT2w8yX1Z6MK3Y2vecojEwXg57uBCb3fwsjalr1GAUtfjOCDQuidJhmGXhgMns/P1hoXxfHDTfHz+51LcAWObPRTkD7EyH9ENhnN3T4x5p/U0G/WHRXLpSulWQdTFkvO0XFslYodbXphXCrjHtFPVjf6PvbROD1eEaQyh9KYncxmHrUVj3QGZpSTDzTZUSjdJeNgcmUzAjjktZ/eG2tLQtDEN5va6MfmIXoXc2B4KmfSKupgKof2eGxnAvFGOtXIiZGXuQL08A7OFp0QneeY8WLUwBD53sERbuX2xQ0okkvWExGP0zqwKSvzxS0eq19LI+N0cVN94/8UfXle7ksvnOZrx0btXdF63/thc4xrqrWbr1lpBHme9CLVE679uMy9i7l4RsWEeK4A6yhHKEzi7u8YarUgy36ljLPghVP567cRT51kSXj7cAEceV24r5M2Jg==;
 5:XwR53LzChB1Kri9vAH32gQxxUqTkvvUB+5YQNnWWZarZLX2uZol6rTepxIDKgtVFK3QbZV53jA0NI6TOtInFl0Ay4HzQGhqme+ncnCbYOiATWwUCr8ODBuGuwx1mUIcgukNdToEcPsMIIDoj5P6uQ7g1DXv6FVd+xNtYZ7JSsv57No+fyWX8O2+Xx0f7XTyhIMzhU1ynZblfNATxqxrE2w==;
 7:FzP2jb5sN4xFl0mS/p3WXb6bjZYx2h7IENuj6yYNaH0TwZzYNvoeXf5vxfdULDbTBCPzTHPrQfRbynzlWeAf95PwlGa2mnFVgyJf7f6YpqfwyLMtwZVkAndAbJ30jQdfcpqTnkleelID8CIYQ9fbAg==
x-ms-office365-filtering-correlation-id: 58e0b01c-b09a-4fc3-95d7-08d68cb6afde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2367; 
x-ms-traffictypediagnostic: VI1PR0401MB2367:
x-microsoft-antispam-prvs: <VI1PR0401MB23672777C47836501581AF72F1680@VI1PR0401MB2367.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(13464003)(189003)(199004)(105586002)(14454004)(186003)(66066001)(478600001)(26005)(229853002)(55016002)(33656002)(102836004)(11346002)(6436002)(74316002)(71200400001)(106356001)(97736004)(71190400001)(446003)(93886005)(44832011)(2906002)(110136005)(5024004)(54906003)(3846002)(53936002)(81156014)(81166006)(476003)(25786009)(305945005)(4326008)(256004)(7696005)(86362001)(7736002)(316002)(6506007)(6306002)(966005)(53546011)(6246003)(8676002)(99286004)(76176011)(6116002)(9686003)(8936002)(486006)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2367;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v5GM/dvAqROTF0lEwp/krA6ZGLGfOCCiFu8zu6iQTKVE/EuktXgFpSCyXV2FyqnP9R2uOaFYL6FdLYK02C3yLI3mjfO70nnEU+zSErYCAODsFwS+kzaWDjbfUaBSY4QUqJrMQXXyF3h3ZiCbaAyVyXBTvJDWO2s0yVIVOOakSozPGdHD/QoTg8peRC05CS7T149sVFg0acN8aR14q3YVg2LqPBNtmhncv26ZyQZt1Cz+oH7IE3h0aaTthrzP/xYvqv96iji25x9nyfzEe6FllmMBa9cgStYHba8gkELedBsmb3zHwBS/X8Gr0Jm+uWBIsl+XfJTFNNOgZB+1ekuyjTTEJT1OIc/2VTEkBYq24mhaZJqymbGaLn98Et9pPS3bouXGB/lhl0Cz0J0HEShc9xI1BXL/iu3LOsGcuCigQzI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e0b01c-b09a-4fc3-95d7-08d68cb6afde
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 04:42:38.0999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2367
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_204326_750363_3ACCE0B4 
X-CRM114-Status: GOOD (  29.14  )
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Li Yang [mailto:leoyang.li@nxp.com]
> Sent: Thursday, 7 February, 2019 05:09 AM
> To: Andrew Lunn <andrew@lunn.ch>
> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>; Florian Fainelli <f.fainelli@gmail.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Rob Herring
> <robh+dt@kernel.org>
> Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
> 
> On Wed, Feb 6, 2019 at 3:46 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > > >  &i2c0 {
> > > > > >         status = "okay";
> > > > > >
> > > > > > +       fpga@66 {
> > > > > > +               compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > > > > > +               reg = <0x66>;
> > > > > > +               #address-cells = <1>;
> > > > > > +               #size-cells = <0>;
> > > > > > +
> > > > > > +               mdio-mux-1@54 {
> > > > >
> > > > > Still no compatible string defined for the node.  Probably
> > > > > should be
> > > > > "mdio-mux- mmioreg", "mdio-mux"
> > > >
> > > > it is not a specific device. MDIO mux is meant to be controlled by
> > > > some registers of parent device (FPGA).
> > > > Therefore, IMO this should not be a device and there should not be
> > > > any "compatible" property for it.
> >
> > > If it is not a device why we are defining a device node for it?  It
> > > is probably not a physical device per se, but it can be considered a
> > > virtual device provided by FPGA.
> >
> > It is a physical device. But it happens to be embedded inside another
> > device. And that embedded is not performed as a bus with devices on
> > it, so the device tree concepts don't fit directly.
> 
> Whether or not it is populated as a bus(which probably should as the FPGA does
> contain many different functions and these functions like the mdio-mux we are
> discussing about could have separate drivers), the node should have a new
> binding documentation similar to the mdio_mux_mmioreg binding or even
> covers the mmioreg too.  And the best way to match the node with the binding
> is through compatible strings IMO.  This is why I'm asking the node to have a
> compatible string.

The mdio_mux is NOT a device. FPGA is a device that provides the mdio mux functionality
(among other functions). The mdio mux is controlled via some bits In one of the FPGA register.

In my previous approach, I also used a compatible field for mdio_mux node in FPGA.
https://www.mail-archive.com/netdev@vger.kernel.org/msg252744.html
The FPGA driver would create as many platform devices for each subnode, and those devices
Would attach to mdio_mux_regmap driver based on compatible field.

BUT, this platform device creation is the problem. Since mdio_mux is not an actual device, how can
We create a platform device for it?

Which is why I removed the compatible field from mdio_mux nodes. The FPGA driver detects the mdio_mux
Using their name i.e. " mdio-mux-1@54". Like this: 
	for_each_child_of_node(dev->of_node, child) {
		if (!of_node_name_prefix(child, "mdio-mux"))

Refer : https://patchwork.kernel.org/patch/10797227/ 

> 
> >
> > > This also bring up another question that why this device cannot
> > > reuse the existing drivers/net/phy/mdio-mux-mmioreg.c driver?
> >
> > Because it is on an i2c bus, not an mmio bus.
> 
> Oops, I missed that.
> 
> >
> > > If we think regmap is a better solution, shall we replace the
> > > mmioreg driver with the regmap driver?
> >
> > regmap can be used with mmio. But for a single MMIO register it is a
> > huge framework. So it makes sense to keep mdio-mux-mmioreg simple.
> >
> > If however the device is already using regmap, adding one more
> > register is very little overhead. And it might be possible to use this
> > new mux with an mmio regmap, or an spi regmap, etc. So we seem to be
> > covering the best of both worlds.
> 
> Ya.  It would be ideal if the new driver can cover the legacy mdio-mux-mmioreg
> case too.

Refer : https://patchwork.kernel.org/patch/10797227/
The mdio_mux_regmap can be used by any FPGA be it i2c connected or MMIO based.

> 
> Regards,
> Leo
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
