From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 25 Jan 2010 10:25:00 -0800
Subject: [RFC 17/18] arm: mm: Add SW emulation for ARM domain manager
	feature
In-Reply-To: <1264437609.6275.110.camel@pc1117.cambridge.arm.com>
References: <1263250057-26692-18-git-send-email-dwalker@codeaurora.org>
	<1264437609.6275.110.camel@pc1117.cambridge.arm.com>
Message-ID: <1264443900.16329.34.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-25 at 16:40 +0000, Catalin Marinas wrote:
> Hi Daniel,
> 
> On Mon, 2010-01-11 at 22:47 +0000, Daniel Walker wrote:
> > Do not set domain manager bits in cp15 dacr.  Emulate using SW.  Add
> > kernel hooks to handle domain changes, permission faults, and context
> > switches.
> 
> In case you were not aware, there's a patch around (I think since 2007)
> that removes the domain switching entirely from the kernel (given that
> they have been deprecated for some time and may disappear completely in
> the future):
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005616.html
> 
> It doesn't require handling domain faults and works on SMP as well.
> Another advantage is that we can re-implement functions like
> copy_from_user etc. only using LDR/LDM rather than LDRT with some
> performance improvements.

Not in mainline yet?

> Of course, being my patch, I'm pushing for it :-) but I think longer
> term is a better approach that the domains emulation. Any thoughts on
> this?

This is just to fix a hardware problem on MSM (can't enable the domain
manager), so it's not super interesting to me as a feature per se ..

If there are benefits that your creating by disabling the domain
manager, then that seems like something we would want over this patch
since all we're trying to do is fix defective hardware (not enhance the
kernel) ..

I'll try discussing your patch with the author, and see if it satisfies
our needs (maybe Dave E. on the CC list might want to jump in here.)

Daniel
