From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 May 2017 15:09:47 +0100
Subject: [RFC PATCH] arm64: neon: Remove support for nested or hardirq
 kernel-mode NEON
In-Reply-To: <CAKv+Gu-o5wofQwpC6Wp87GNniN2eTYmni_JGKNpPFFCWK48zWA@mail.gmail.com>
References: <1495193199-1291-1-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu8KKuD6Rgbq++kzJayHN8X-Kb7vrS-aj=N_kymqSnfVdQ@mail.gmail.com>
 <20170519134650.GE3559@e103592.cambridge.arm.com>
 <CAKv+Gu-o5wofQwpC6Wp87GNniN2eTYmni_JGKNpPFFCWK48zWA@mail.gmail.com>
Message-ID: <20170519140947.GG3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 02:56:20PM +0100, Ard Biesheuvel wrote:
> On 19 May 2017 at 14:46, Dave Martin <Dave.Martin@arm.com> wrote:

[...]

> > OK -- when do you expect your kernel-mode-neon series (or relevant bits
> > of it) to be merged?  With that in place, I can carry this patch in
> > the SVE series, or propose it to be merged separately.
> >
> 
> There is no reason for any of this to go through the crypto tree or
> mailing list. So for now, let's go with kernel_neon_allowed(), and I

Arg, I just changed it back...

What are the intended meanings of

	!kernel_neon_allowed() && !may_use_simd()
	!kernel_neon_allowed() && may_use_simd()
	kernel_neon_allowed() && !may_use_simd()
	kernel_neon_allowed() && may_use_simd()

?

I'm still a little confused here...

> can respin my patches against that and ask Catalin or Will to queue it
> for v4.13. I will be travelling next week, though, so no ETA yet.

OK.  It they get queued for v4.13 that's fine for me.

> > I'd also expect CONFIG_KERNEL_NEON_MODE_NEON_FALLBACK and
> > kernel_neon_need_fallback() to be folded in (=y and true respectively),
> > since removal of nesting support will mean that fallback code is always
> > needed for clients that may run elsewhere than in task context.
> 
> Yes. So we no longer have to reason about whether a fallback should be
> provided, which is an improvement imo.

Agreed, it seems simpler this way.

Cheers
---Dave
