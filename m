From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Oct 2018 19:13:42 +0100
Subject: ARM: Call syscall_trace_exit even when system call skipped
In-Reply-To: <CAGXu5jK1Jkxg6gkOV9GqW4FE96UNoOaG3-f5JVq6h9gnk53ohg@mail.gmail.com>
References: <20180203152112.2449-1-T.E.Baldwin99@members.leeds.ac.uk>
 <20181008110047.GA3426@asgard.redhat.com>
 <CAGXu5jK1Jkxg6gkOV9GqW4FE96UNoOaG3-f5JVq6h9gnk53ohg@mail.gmail.com>
Message-ID: <20181008181341.GK30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 11:08:16AM -0700, Kees Cook wrote:
> On Mon, Oct 8, 2018 at 4:00 AM, Eugene Syromyatnikov <evgsyr@gmail.com> wrote:
> > From: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
> >
> > On at least x86 and ARM64, and as documented in the ptrace man page
> > a skipped system call will still cause a syscall exit ptrace stop.
> >
> > Previous to this commit 32-bit ARM did not, resulting in strace
> > being confused when seccomp skips system calls.
> >
> > This change also impacts programs that use ptrace to skip system calls.
> >
> > Fixes: ad75b51459ae ("ARM: 7579/1: arch/allow a scno of -1 to not cause a SIGILL")
> > Signed-off-by: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
> > Signed-off-by: Eugene Syromyatnikov <evgsyr@gmail.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Tested-by: Kees Cook <keescook@chromium.org>
> > Tested-by: Eugene Syromyatnikov <evgsyr@gmail.com>
> > ---
> > KernelVersion: 4.19-rc7
> 
> Did this actually make it into the patch tracker? I don't see it in Incoming...

No, rejected at SMTP time (so bounced) due to it being sent from a
gmail.com address but _not_ going through gmail servers (so no DKIM
signature.)  Hence, looks like all the other fake gmail crud and gets
rejected outright.

I guess if Eugene didn't get the bounce notification, then gmail
decided to discard that as fake too!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
