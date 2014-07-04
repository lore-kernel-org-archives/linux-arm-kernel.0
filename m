From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 04 Jul 2014 13:56:15 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140704092519.GC21766@n2100.arm.linux.org.uk>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com> <4840595.cpHbY6hJKL@wuerfel>
 <20140703183055.GC32514@n2100.arm.linux.org.uk>
 <20140704085745.GB16404@arm.com>
 <20140704092519.GC21766@n2100.arm.linux.org.uk>
Message-ID: <20140704125615.CC2E2C40A89@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Jul 2014 10:25:19 +0100, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Fri, Jul 04, 2014 at 09:57:45AM +0100, Catalin Marinas wrote:
> > On Thu, Jul 03, 2014 at 07:30:55PM +0100, Russell King - ARM Linux wrote:
> > > Even with SWP_EMULATE enabled and with the debug problem fixed... does
> > > it help warn people?  Only if you're running on a CPU with virtualisation
> > > extensions, because it silently continues to work on CPUs without.
> > 
> > Some clarification here. The virtualisation extensions made SWP
> > _optional_ (i.e. it may not be present at all). The ARMv7
> > multiprocessing extensions introduced the possibility to disable/trap
> > SWP via the SCTLR.SW bit because it was no longer atomic. So basically
> > native SWP only works (as expected, atomically) on ARMv7 UP and earlier.
> 
> Yes, but we've cocked this up - on ARMv7 SMP, we don't force SWP to be
> enabled.  So, you may have SWP in hardware, which may not be atomic,
> but as everyone seems to have SWP_EMULATE /disabled/ we don't know
> whether the instruction even exists in any programs or libraries.
> 
> It may be that it's been completely eliminated, but we don't know that,
> because we've never had the trapping enabled for SMP systems.
> 
> On the flip side (as I mentioned to Will) I don't think the situation is
> quite as serious as Grant makes it out to be for Android.
> 
> There, the user base is already used to apps which don't work with new
> Android devices.  For example, despite Android scaling the graphics to
> the screen size, there are apps that don't work merely because the screen
> is bigger, and the play store knows this and doesn't offer them.  However,
> it /is/ still possible to install them (and some people have) by
> downloading the .apk file and putting that on SD card.  In this case,
> the app (a game) worked perfectly except that the game controls were at
> an absolute screen position rather than a scaled position, which is why
> the game was no longer offered for the later devices.

I don't think I'm wrong about how serious the issue is. Read through
Colin's email again. He is talking about exactly the situation that I
described.

Nor do I think that "the user base is already used to app which don't
work" is even remotely a good justification for allowing things to
continue to suck. Android has matured a lot since the early days, and
the compatibility problems that plagued the early devices don't happen
so much anymore.

g.
