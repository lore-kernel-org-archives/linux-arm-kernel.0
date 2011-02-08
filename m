From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Feb 2011 18:01:20 +0530
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <20110208122205.GA5903@arm.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<20110208110808.GA22877@n2100.arm.linux.org.uk>
	<201102081311.52004.arnd@arndb.de> <20110208122205.GA5903@arm.com>
Message-ID: <99745ad4c4f07cc2eb0ac9241cf23956@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin at linaro.org]
> Sent: Tuesday, February 08, 2011 5:52 PM
> To: Arnd Bergmann
> Cc: linux-arm-kernel at lists.infradead.org; Russell King - ARM Linux;
> Nicolas Pitre; Tony Lindgren; Santosh Shilimkar; linux-
> omap at vger.kernel.org; Jean Pihet
> Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
>
> > > On Tue, Feb 08, 2011 at 11:01:25AM +0000, Dave Martin wrote:
> > > > For v6, wfi is architected as a defined MCR instruction, so
> > > > use that definition.
>
> [...]
>
> On Tue, Feb 08, 2011 at 01:11:51PM +0100, Arnd Bergmann wrote:
> > I don't see any users of the sev/wfe/wfi macros in the current
> kernel,
> > so removing them seems like a good strategy to avoid people from
> > using them incorrectly.
> >
> > If the definitions differ between v5/v6/v7 CPUs, any common code
> > using them would need to do either binary patching of some sort
> > or abstract the difference between the CPU in some other way.
> >
> > Dave, what code do you have in mind as a possible user?
>
> The OMAP BSP has its own version of this, which I'm suggesting
> to port to the more generic macros in system.h, now that they
> exist.
>
Omap 'sev' version is removed some time back. We were keeping
WFI opcode version because of V6 and V7 compatibility issue. With
resent CPU_32v6K from Russell, that should also get addressed.

I shall remove the omap wfi version as soon as RMK's series is
merged.

Regards,
Santosh
