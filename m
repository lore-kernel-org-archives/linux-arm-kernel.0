From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Jul 2018 13:08:39 +0100
Subject: [PATCH 0/7] arm64: PSR <-> SPSR_ELx mapping fixes
In-Reply-To: <20180704173347.GA9668@arm.com>
References: <20180625144421.11511-1-mark.rutland@arm.com>
 <20180704173347.GA9668@arm.com>
Message-ID: <20180705120839.n2juzbkjcdikm6t7@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 06:33:48PM +0100, Will Deacon wrote:
> Mark,
> 
> On Mon, Jun 25, 2018 at 03:44:14PM +0100, Mark Rutland wrote:
> > The SPSR_ELx format has diverged from the AArch32-native SPSR format since the
> > addition of DIT. Thus, we need to map between the two for certain compat
> > operations.
> > 
> > Also, when we added support for DIT, we forgot to account for this in
> > valid_user_regs(), causing PSTATE.DIT to be cleared upon sigreturn.
> > 
> > These patches (based on v4.18-rc2) fix those issues, cleaning up the COMPAT_PSR
> > definitions to try to avoid confusiong in future.
> > 
> > The COMPAT_PSR_ definitions are now used for the AArch32-native SPR format
> > (i.e. they are the compat userspace view), with PSR_AA32_ definitions used for
> > the AArch64 view of the PSR for AArch32 tasks.
> 
> I applied this, but it doesn't even build with defconfig :(
> 
> How much testing has this seen?

Quite evidently, none.

> I also get some other errors because code is trying to refer to COMPAT
> definitions that you've removed. So I've dropped all of this for now.

Understood.

I will fix these up, make sure that the resulting series builds cleanly
at every step, and send that out as a v2 shortly.

Sorry for this mess.

Mark.
