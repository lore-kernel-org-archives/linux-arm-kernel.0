Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA12C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:24:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF942173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UafKh1PB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF942173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ROmo+d1kW3yipBVJ4IsD3JjRXd04WTqvGK3oJrV+fO8=; b=UafKh1PBaL60rE
	DhKbasjSziyoMVRiiueakMVzmuCrT2u1j5Q4cjw1dxzDxuY+M2neVDaUmVlRQgt7LpyiuyeLWrnc2
	nerMI9qrBW4K1HYVjXZxUKmUZ/hHOylfVozJSc5ZiwUl9JeqXRZbv/qT8uQiPsAW9FERHNGFKBgOw
	uFu/LKSWlLlU7gj6iFmoNGrmsmU2STrYqPUXvopiJryTREGUYPcpo3bgNBzpve2A9eBvmbPZvprcF
	u6u7jHxWc8O3/XGTVNXQsduXmjpuHHRGm2ShguWb5MSakS4FoAp1/lcI+BsvKqFSrAW6lqX3IDqrQ
	ZtNcrceuwp2315/60Cyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grt2L-0006kD-MG; Thu, 07 Feb 2019 23:24:53 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grt2H-0006jP-8d
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 23:24:51 +0000
Received: by mail-ot1-f66.google.com with SMTP id e24so2855845otp.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 15:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6wTQqodCjgzzQf0Uwkx+EiS20jdYm1xZBOrV7VUYZJY=;
 b=KpC+/CTckBO0N+GH/39nwwBNBp7LEa1Ga8RGDFXDnFepgurN+Dowvg9Nfc9vlzMpu2
 gmngL2erl7Qvl3czLvuDX7wsiQYruD5SPOI4lWn8ISz8kxmod8IMgRL59t3dkpUZTydU
 lp0sYSjEVc3DgGcDQoWX6VsqcZqLq1z+TTdJI8m6MIb8l1h2CTojVBDHjosVFPCdXr7Q
 X+dOtFZBhjnARIdUc01tLNU9rSwunoAVT/TSBCsTZ6AfZB3Q/DXm6ZVqtqSNvYeg4mdI
 4BmDwLIOghhsQbrjWmvxHA0g3vPuD1nG0F/eaKITqWnAWNIWYuGspInp7f4d8h2KBx3W
 rGBg==
X-Gm-Message-State: AHQUAuawxqJkFpoheFJXY/6VZcDbo0PM5V8T5amS1OxMnSTZ8HN0pOV5
 zrHJZPW/o09hSj/xuPNjOXClPzBO
X-Google-Smtp-Source: AHgI3IbXUKE8R0Kc/DuVITwGtijY1hOz9wLTl/n0mWfNS+3qAO8alfqtrSIizVP6qDKlc/D3NM9paQ==
X-Received: by 2002:aca:ba57:: with SMTP id k84mr343433oif.25.1549581887007;
 Thu, 07 Feb 2019 15:24:47 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com.
 [209.85.210.46])
 by smtp.gmail.com with ESMTPSA id t201sm166880oie.37.2019.02.07.15.24.45
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Feb 2019 15:24:46 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id v23so2879875otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 15:24:45 -0800 (PST)
X-Received: by 2002:a9d:6347:: with SMTP id y7mr2811806otk.331.1549581885319; 
 Thu, 07 Feb 2019 15:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20190204141641.18272-1-pankaj.bansal@nxp.com>
 <CADRPPNSnPoEwUFKK0=FE9RG9QfTUPKoTXkZPVEpskC13mD-R2A@mail.gmail.com>
 <VI1PR0401MB24968690F3E3677E5EE8DE49F16F0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <AM6PR04MB58636BDAAAAEA71B7B1DC7F28F6F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <20190206214432.GB32483@lunn.ch>
 <CADRPPNRFfP1UHSF+99LJ_6QMCFeXi=QhmNJAhAtBPZ_pJ-jmgg@mail.gmail.com>
 <VI1PR0401MB24966218B333880762D931B5F1680@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB24966218B333880762D931B5F1680@VI1PR0401MB2496.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 7 Feb 2019 17:24:33 -0600
X-Gmail-Original-Message-ID: <CADRPPNS3j49UKkjodKky4cyodnyhWsUu8WahwZ9BwXShK+Nakg@mail.gmail.com>
Message-ID: <CADRPPNS3j49UKkjodKky4cyodnyhWsUu8WahwZ9BwXShK+Nakg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
To: Pankaj Bansal <pankaj.bansal@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_152449_308369_78968703 
X-CRM114-Status: GOOD (  33.57  )
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
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 6, 2019 at 10:44 PM Pankaj Bansal <pankaj.bansal@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Li Yang [mailto:leoyang.li@nxp.com]
> > Sent: Thursday, 7 February, 2019 05:09 AM
> > To: Andrew Lunn <andrew@lunn.ch>
> > Cc: Pankaj Bansal <pankaj.bansal@nxp.com>; Shawn Guo
> > <shawnguo@kernel.org>; Florian Fainelli <f.fainelli@gmail.com>;
> > netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Rob Herring
> > <robh+dt@kernel.org>
> > Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
> >
> > On Wed, Feb 6, 2019 at 3:46 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > > > >  &i2c0 {
> > > > > > >         status = "okay";
> > > > > > >
> > > > > > > +       fpga@66 {
> > > > > > > +               compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > > > > > > +               reg = <0x66>;
> > > > > > > +               #address-cells = <1>;
> > > > > > > +               #size-cells = <0>;
> > > > > > > +
> > > > > > > +               mdio-mux-1@54 {
> > > > > >
> > > > > > Still no compatible string defined for the node.  Probably
> > > > > > should be
> > > > > > "mdio-mux- mmioreg", "mdio-mux"
> > > > >
> > > > > it is not a specific device. MDIO mux is meant to be controlled by
> > > > > some registers of parent device (FPGA).
> > > > > Therefore, IMO this should not be a device and there should not be
> > > > > any "compatible" property for it.
> > >
> > > > If it is not a device why we are defining a device node for it?  It
> > > > is probably not a physical device per se, but it can be considered a
> > > > virtual device provided by FPGA.
> > >
> > > It is a physical device. But it happens to be embedded inside another
> > > device. And that embedded is not performed as a bus with devices on
> > > it, so the device tree concepts don't fit directly.
> >
> > Whether or not it is populated as a bus(which probably should as the FPGA does
> > contain many different functions and these functions like the mdio-mux we are
> > discussing about could have separate drivers), the node should have a new
> > binding documentation similar to the mdio_mux_mmioreg binding or even
> > covers the mmioreg too.  And the best way to match the node with the binding
> > is through compatible strings IMO.  This is why I'm asking the node to have a
> > compatible string.
>
> The mdio_mux is NOT a device. FPGA is a device that provides the mdio mux functionality
> (among other functions). The mdio mux is controlled via some bits In one of the FPGA register.

With modern chips, it is likely to have multiple functions in a single
physical device that are covered by multiple subsystems.  We shouldn't
limit the concept of device to only physical devices.

>
> In my previous approach, I also used a compatible field for mdio_mux node in FPGA.
> https://www.mail-archive.com/netdev@vger.kernel.org/msg252744.html
> The FPGA driver would create as many platform devices for each subnode, and those devices
> Would attach to mdio_mux_regmap driver based on compatible field.
>
> BUT, this platform device creation is the problem. Since mdio_mux is not an actual device, how can
> We create a platform device for it?

Like I said platform device doesn't have to be a physically separate
device.  In this specific case, I think a multi-function device(MFD)
will be the best fit for this FPGA device.  The framework will help to
create sub-devices and help to share the regmap to all the
sub-function drivers.  Please check existing MFD drivers for more
details.

>
> Which is why I removed the compatible field from mdio_mux nodes. The FPGA driver detects the mdio_mux
> Using their name i.e. " mdio-mux-1@54". Like this:
>         for_each_child_of_node(dev->of_node, child) {
>                 if (!of_node_name_prefix(child, "mdio-mux"))
>
> Refer : https://patchwork.kernel.org/patch/10797227/
>
> >
> > >
> > > > This also bring up another question that why this device cannot
> > > > reuse the existing drivers/net/phy/mdio-mux-mmioreg.c driver?
> > >
> > > Because it is on an i2c bus, not an mmio bus.
> >
> > Oops, I missed that.
> >
> > >
> > > > If we think regmap is a better solution, shall we replace the
> > > > mmioreg driver with the regmap driver?
> > >
> > > regmap can be used with mmio. But for a single MMIO register it is a
> > > huge framework. So it makes sense to keep mdio-mux-mmioreg simple.
> > >
> > > If however the device is already using regmap, adding one more
> > > register is very little overhead. And it might be possible to use this
> > > new mux with an mmio regmap, or an spi regmap, etc. So we seem to be
> > > covering the best of both worlds.
> >
> > Ya.  It would be ideal if the new driver can cover the legacy mdio-mux-mmioreg
> > case too.
>
> Refer : https://patchwork.kernel.org/patch/10797227/
> The mdio_mux_regmap can be used by any FPGA be it i2c connected or MMIO based.
>
> >
> > Regards,
> > Leo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
