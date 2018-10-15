From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 15 Oct 2018 09:48:33 -0700
Subject: [PATCH v4 5/6] arm64: dts: add QorIQ LX2160A SoC support
In-Reply-To: <VI1PR04MB4800C0AB214B258793AF9ABAF3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-6-git-send-email-vabhav.sharma@nxp.com>
 <20181008054510.GG3587@dragon>
 <VI1PR04MB4800C0AB214B258793AF9ABAF3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
Message-ID: <153962211360.5275.18031876744546062419@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Vabhav Sharma (2018-10-14 19:58:15)
> > > +
> > > +   pmu {
> > > +           compatible = "arm,cortex-a72-pmu";
> > > +           interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > > +   };
> > > +
> > > +   psci {
> > > +           compatible = "arm,psci-0.2";
> > > +           method = "smc";
> > > +   };
> > > +
> > > +   memory at 80000000 {
> > > +           // DRAM space - 1, size : 2 GB DRAM
> > > +           device_type = "memory";
> > > +           reg = <0x00000000 0x80000000 0 0x80000000>;
> > > +   };
> > > +
> > > +   ddr1: memory-controller at 1080000 {
> > > +           compatible = "fsl,qoriq-memory-controller";
> > > +           reg = <0x0 0x1080000 0x0 0x1000>;
> > > +           interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > > +           little-endian;
> > > +   };
> > > +
> > > +   ddr2: memory-controller at 1090000 {
> > > +           compatible = "fsl,qoriq-memory-controller";
> > > +           reg = <0x0 0x1090000 0x0 0x1000>;
> > > +           interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> > > +           little-endian;
> > > +   };
> > > +
> > > +   sysclk: sysclk {
> > 
> > Name the node a bit generic like clock-xxx.
> There is only one clock-unit, Bootloader(U-boot) require sysclk node during device tree fix-up as different platform support varied platform frequency as per reset configuration word used.
> Referred other ARM based platform with one clock using name as x: x

Please add a comment above this node with this information. Newcomers
reading this DTS file won't have any idea why this node is specially
named and a comment will help tremendously here.
