From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 29 Apr 2011 19:05:03 +0200 (CEST)
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
In-Reply-To: <20110429143435.GU5126@n2100.arm.linux.org.uk>
References: <20110426203756.GD17290@n2100.arm.linux.org.uk>
	<BANLkTi=Y0CdRt1ktCs7NwG4pLqWeZeLQPg@mail.gmail.com>
	<alpine.LFD.2.02.1104271015000.3323@ionos>
	<BANLkTi=WRw9pphieBAnDRhSH_WSdyUdb_A@mail.gmail.com>
	<20110428133826.GM17290@n2100.arm.linux.org.uk>
	<BANLkTi=rG8y=OeF8jc8R48tMLm=eH1=gqQ@mail.gmail.com>
	<20110428142822.GN17290@n2100.arm.linux.org.uk>
	<BANLkTin9_=zwLCkqVcAfg-_pGTXk9GaZsg@mail.gmail.com>
	<20110428182420.GF17290@n2100.arm.linux.org.uk>
	<BANLkTi=Xb7c9GeNJ_Our0+euEmumk_0-OA@mail.gmail.com>
	<20110429143435.GU5126@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1104291902370.3005@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:

> On Fri, Apr 29, 2011 at 07:56:56PM +0530, Vikram Narayanan wrote:
> > Can you also give some idea on how the system's RTC is hooked up with
> > the generic timekeeping code.
> > Is it hooked up in someway so that the walltime is calculated wrt the
> > initial value of the RTC?
> 
> I'd like to pass you over to the RTC folk, but I don't think they're
> very active anymore.
> 
> Suffice it to say that the RTC subsystem will set the system date/time
> on initialization from the RTC device if one is provided.  All I can
> suggest is to look at drivers/rtc and include/linux/rtc.h for the
> details.  The MAINTAINERS file should list who is responsible for RTC
> stuff as well as a mailing list for it.

read_persistant_clock() is used for boottime / resume time readouts of
a direct accessible RTC.

If the RTC sits behind a slow bus which is not accessible in early
boot, then the RTC framework will take care of updating the time once
the RTC becomes available.

John Stultz is the guy who knows all the details.

Thanks,

	tglx
