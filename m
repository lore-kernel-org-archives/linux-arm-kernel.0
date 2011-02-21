From: John.Linn@xilinx.com (John Linn)
Date: Mon, 21 Feb 2011 08:04:38 -0700
Subject: [PATCH V4 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <201102211548.36296.arnd@arndb.de>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com><201102210936.42098.arnd@arndb.de><c3cdf33d-2163-4417-bc64-7637f5c211e0@VA3EHSMHS021.ehs.local>
	<201102211548.36296.arnd@arndb.de>
Message-ID: <6c1f68a4-997a-4a8d-882e-5840e8bdf7af@VA3EHSMHS004.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Arnd Bergmann
> Sent: Monday, February 21, 2011 7:49 AM
> To: John Linn
> Cc: linux at arm.linux.org.uk; catalin.marinas at arm.com;
> glikely at secretlab.ca; linux-kernel at vger.kernel.org;
> jamie at jamieiles.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V4 3/4] ARM: Xilinx: base header files and
assembly
> macros
> 
> On Monday 21 February 2011, John Linn wrote:
> > > It would be better if you could avoid introducing new uses of
> > > CLOCK_TICK_RATE, because that will have to be removed before we
can
> > > move to a real multi-platform kernel. For instance, you can put
> > > PERIPHERAL_CLOCK_RATE in a hardware specific header and put a
bogus
> > > definition for CLOCK_TICK_RATE into timex.h
> >
> > Hi Arnd,
> >
> > I can remove the use of it from my timer code, but I still see
> > CLOCK_TICK_RATE
> > being used in linux/jiffies.h.
> >
> > I tried removing it and got build errors.  Am I missing something
> there?
> >
> 
> You still need to have some definition for CLOCK_TICK_RATE to make
> the jiffies code compile, but the actual value no longer matters.

I see. Now that I re-read your last response I get that from it.

> 
> Traditionally, this was the i386-style PIT timer frequency of 11.93
MHz
> for some things and the actual timer frequency for other things.
> The timer code tries to correct the jiffies value based on difference
> between the intended HZ frequency (100, 250 or 1000) and the actual
> on (something very close to that, but not exact).
> 
> You can e.g. set it to (100 * HZ) to make something up that won't
> hurt in that calculation.
> 

Gotcha. I now understand to stay away from using CLOCK_TICK_RATE.

Sounds like it's worth a comment in mach/timex.h that says it's not 
really used as it seems a bit misleading for others.

Thanks,
John

> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
