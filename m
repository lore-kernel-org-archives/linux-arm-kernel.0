From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Jan 2014 09:57:42 +0000
Subject: [PATCH 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <CALicx6sax=SHv2NryhY5QSBtyv-_wbCpPR5hFt9gngD96yP0oQ@mail.gmail.com>
References: <1390401773-12100-1-git-send-email-vijay.kilari@gmail.com>
 <1390401773-12100-2-git-send-email-vijay.kilari@gmail.com>
 <20140122173117.GJ14108@mudshark.cambridge.arm.com>
 <CALicx6sax=SHv2NryhY5QSBtyv-_wbCpPR5hFt9gngD96yP0oQ@mail.gmail.com>
Message-ID: <20140123095741.GA5466@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 04:46:36AM +0000, Vijay Kilari wrote:
> On Wed, Jan 22, 2014 at 11:01 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> >> index 23586bd..774ad04 100644
> >> --- a/arch/arm64/kernel/debug-monitors.c
> >> +++ b/arch/arm64/kernel/debug-monitors.c
> >> @@ -51,7 +51,7 @@ u8 debug_monitors_arch(void)
> >>  static void mdscr_write(u32 mdscr)
> >>  {
> >>       unsigned long flags;
> >> -     local_dbg_save(flags);
> >> +     flags = local_dbg_save();
> >
> > Why are you changing the API? This is now pointlessly different to irqs.
> 
> To be in line with arch_local_irq_save & arch_local_save_flags in irqflags.h,
> I moved this macros into functions and accordingly changed the caller.
> I could not find any code using this local_dbg_{save, restore} except
> from debug-monitors.c file
> 
> If required, I can think of renaming local_dbg_{save,restore} as
> local_dbg_{save,restore}_flags

No, I'd rather local_dbg_{save, restore} were aligned with local_irq_{save,
restore} (as defined in include/linux/irqflags.h).

Will
