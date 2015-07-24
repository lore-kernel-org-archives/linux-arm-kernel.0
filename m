From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jul 2015 17:56:42 +0100
Subject: [PATCH v4] arm64: kernel: Add support for Privileged Access Never
In-Reply-To: <55B2566E.2090905@arm.com>
References: <20150722170140.GR6650@arm.com>
 <1437588354-31278-1-git-send-email-james.morse@arm.com>
 <20150723130752.GC445@arm.com> <55B2566E.2090905@arm.com>
Message-ID: <20150724165642.GE21177@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 04:14:54PM +0100, James Morse wrote:
> On 23/07/15 14:07, Will Deacon wrote:
> > On Wed, Jul 22, 2015 at 07:05:54PM +0100, James Morse wrote:
> >> 'Privileged Access Never' is a new arm8.1 feature which prevents
> >> privileged code from accessing any virtual address where read or write
> >> access is also permitted at EL0.
> >>
> >> This patch enables the PAN feature on all CPUs, and modifies {get,put}_user
> >> helpers temporarily to permit access.
> >>
> >> This will catch kernel bugs where user memory is accessed directly.
> >> 'Unprivileged loads and stores' using ldtrb et al are unaffected by PAN.
> >>
> >> Signed-off-by: James Morse <james.morse@arm.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> ---
> >> This version is rebased against the arm64 'devel' branch, somewhere
> >> after Suzuki's "arm64: Generalise msr_s/mrs_s operations" patch.
> > 
> > Now, having spoken with Catalin, we reckon that it's probably best to
> > bite the bullet and add the enable parameter to the conditional alternative
> > asm macros anyway; it's still fairly early days for 4.3 so we've got time
> > to get this right.
> > 
> > In that light, I've got the following diff against this patch (see below)
> > and then another patch on top of that adding the extra parameters.
> > 
> > Could you take a look please? Sorry for messing you about.
> 
> Fine by me ...

Thanks, I'll merge it in.

Will
