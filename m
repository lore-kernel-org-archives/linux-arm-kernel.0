From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Mar 2011 10:27:33 +0100
Subject: MACH_TYPE undeclared error
In-Reply-To: <AANLkTimsNOmK4H8MYMB2jjd+zkT4qcYD1dy+J1fxdd7w@mail.gmail.com>
References: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
	<20110329065457.GG30938@pengutronix.de>
	<AANLkTimsNOmK4H8MYMB2jjd+zkT4qcYD1dy+J1fxdd7w@mail.gmail.com>
Message-ID: <20110329092733.GA11236@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 02:01:10PM +0530, Madhavi Manchala wrote:
> Dear Uwe,
> 
> 2011/3/29 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Tue, Mar 29, 2011 at 12:01:40PM +0530, Madhavi Manchala wrote:
> >> Dear All,
> >>
> >> I have defined a MACHINE_START macro in my board C file as follows.
> >>
> >> MACHINE_START(S3C2510, "S3C2510")
> >> ? ? ? .init_irq ? ? ? = s3c2510_init_irq,
> >> ? ? ? .timer ? ? ? ? ?= &s3c2510_time_init,
> >> MACHINE_END
> >>
> >> When I try to compile this C file, I am seeing the following error message.
> >>
> >> arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
> >> undeclared here (not in a function)
> > you need a line defining S3C2510 in arch/arm/tools/mach-types.
> 
> Yeah. It is there in the arch/arm/tools/mach-types file. I did not add
> to it, but it is automatically generated. The few lines from the
> arch/arm/tools/mach-types file are as follows.
> 
> izarus		MACH_IZARUS		IZARUS		573
> pxa_rts		MACH_RTS		RTS			574
> se5100		MACH_SE5100		SE5100		575
> s3c2510		MACH_S3C2510	S3C2510		576
> csb437tl		MACH_CSB437TL	CSB437TL		577
> slauson		MACH_SLAUSON	SLAUSON		578
> pearlriver		MACH_PEARLRIVER	PEARLRIVER	579
> tdc_p210		MACH_TDC_P210	TDC_P210	580
> 
> The machine S3C2510 is there in that file.

S3C2510 sounds to me like a SoC name not a board name.  I delete anything
which sounds like a SoC name as that's not the purpose of the database.
It's for platforms and boards, not SoCs.
