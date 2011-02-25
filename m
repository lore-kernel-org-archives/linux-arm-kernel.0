From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Feb 2011 11:31:06 +0000
Subject: [TRIVIAL/PATCH] ARM: hw_breakpoint: Fix newlines in WARN messages
In-Reply-To: <19815.20063.647326.437650@ipc1.ka-ro>
References: <1298573739-25144-1-git-send-email-sboyd@codeaurora.org>
	<19815.20063.647326.437650@ipc1.ka-ro>
Message-ID: <1298633466.32588.1.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-25 at 06:38 +0000, Lothar Wa?mann wrote:
> Hi,
> 
Hello,

> Stephen Boyd writes:
> > These warnings are missing newlines and spaces causing confusing
> > looking output when they trigger.
> >
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  arch/arm/kernel/hw_breakpoint.c |   13 +++++++------
> >  1 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> > index d600bd3..5aab00e 100644
> > --- a/arch/arm/kernel/hw_breakpoint.c
> > +++ b/arch/arm/kernel/hw_breakpoint.c
> > @@ -238,8 +238,8 @@ static int enable_monitor_mode(void)
> >       ARM_DBG_READ(c1, 0, dscr);
> > 
> >       /* Ensure that halting mode is disabled. */
> > -     if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN, "halting debug mode enabled."
> > -                             "Unable to access hardware resources.")) {
> > +     if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN, "halting debug mode enabled. "
> > +                             "Unable to access hardware resources.\n")) {
> >
> I'd prefer the message text not to be line wrapped, even if it
> violates the general line length rule, because that makes it easier to
> grep for the message in the source code.


Ok, that's understandable. Moving the text onto its own line will limit
the damage to the line length too. Stephen - are you happy to make these
changes as part of your previous patch?

Thanks,

Will
