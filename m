From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Mon, 29 Aug 2016 21:10:09 +0000
Subject: [PATCH 1/2] arm64: dts: updates serial aliases for ls1043a rdb
 and qds boards
In-Reply-To: <201608292238.17985.arnd@arndb.de>
References: <1472244381-1766-1-git-send-email-stuart.yoder@nxp.com>
 <8035333.yr2FRs5mHk@wuerfel>
 <VI1PR0401MB2638BCBA99A6305262FD3EE78DE10@VI1PR0401MB2638.eurprd04.prod.outlook.com>
 <201608292238.17985.arnd@arndb.de>
Message-ID: <VI1PR0401MB263861544E640ED526373EC78DE10@VI1PR0401MB2638.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, August 29, 2016 3:38 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Stuart Yoder <stuart.yoder@nxp.com>; devicetree at vger.kernel.org; shawnguo at kernel.org
> Subject: Re: [PATCH 1/2] arm64: dts: updates serial aliases for ls1043a rdb and qds boards
> 
> On Monday 29 August 2016, Stuart Yoder wrote:
> > > -----Original Message-----
> > > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > > Sent: Monday, August 29, 2016 6:01 AM
> > > To: Stuart Yoder <stuart.yoder@nxp.com>
> > > Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; shawnguo at kernel.org
> > > Subject: Re: [PATCH 1/2] arm64: dts: updates serial aliases for ls1043a rdb and qds boards
> > >
> > > On Friday, August 26, 2016 3:46:20 PM CEST Stuart Yoder wrote:
> > > > -               serial0 = &lpuart0;
> > > > -               serial1 = &lpuart1;
> > > > -               serial2 = &lpuart2;
> > > > -               serial3 = &lpuart3;
> > > > -               serial4 = &lpuart4;
> > > > -               serial5 = &lpuart5;
> > > > +               serial0 = &duart0;
> > > > +               serial1 = &duart1;
> > > > +               serial2 = &duart2;
> > > > +               serial3 = &duart3;
> > >
> > > It looks like your board has six uarts that are all driven with the
> > > lpuart driver, but after the change, you only list four. Should
> > > the serial4 and serial5 aliases keep pointing at lpuart devices
> > > so you can still drive all physical connectors?
> >
> > The only existing reference I can find to the serial aliases is if the
> > OF_STDOUT_VIA_ALIAS is enabled in u-boot to specify the console.  The
> > standard ls1043aqds_defconfig in u-boot specifies DUARTs for the console,
> > which is why I'm proposing making the 4 DUARTs the default serial aliases
> > in the device tree.
> 
> Ok, so they are mutually exclusive, and the last two ports are
> unavailable in the default configuration?

Yes, that's the case with u-boot's defconfig.  I'm still trying to
find out whether that mutual exlusivity was a firmware decision or
a hardware limitation.

Stuart
