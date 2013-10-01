From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Oct 2013 10:01:19 +0100
Subject: [PATCH 2/2] ARM: include: asm: use 'int' instead of 'unsigned
 long' for normal register variables within atomic.h
In-Reply-To: <524A2DE7.8040208@asianux.com>
References: <20130925160746.GC14502@mudshark.cambridge.arm.com>
 <5243953E.6010405@asianux.com>
 <20130926100422.GE2855@mudshark.cambridge.arm.com>
 <5244148F.6080405@asianux.com>
 <20130927110618.GB9520@mudshark.cambridge.arm.com>
 <5247A1D1.6080505@asianux.com> <5247A1FA.4030305@asianux.com>
 <5247A3FC.9020508@asianux.com>
 <20130930161149.GI26036@mudshark.cambridge.arm.com>
 <524A2DE7.8040208@asianux.com>
Message-ID: <20131001090119.GA17629@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 03:05:27AM +0100, Chen Gang wrote:
> On 10/01/2013 12:11 AM, Will Deacon wrote:
> > On Sun, Sep 29, 2013 at 04:52:28AM +0100, Chen Gang wrote:
> >> "arc/arm" will be never on 64-bit, it is mainly on 32-bit (may also can
> >> be on 16-bit).
> >>
> >> So better to use 'int' instead of 'unsigned long' for normal register
> >> variable (on 16-bit, 'int' is allowed to be 16-bit, so historically,
> >> often use 'int' for normal register variables).
> > 
> > This commit message doesn't make a blind bit of sense! arch/arm/ is a 32-bit
> > architecture in the sense that int will always be 32-bit there. This patch
> > is just a cosmetic change, bringing our atomic_t manipulation code inline
> > with the atomic_t type definition.
> > 
> 
> OK, thanks. That means: "arm means arm 32-bit, arm64 means arm 64-bit.
> The current Linux kernel main line does not support arm 16-bit".
> 
> Since "bringing our atomic_t ... with the atomic_t type definition", can
> we use 'atomic_t" instead of 'unsigned long'?
> 
> And can we use 'atomic64_t" instead of 'unsigned long' in atomic64_*()?

That's probably a bit dodgy, since they are typedefs to compound types
which, if ever extended, would fall to bits if we tried to pack them into a
single register.

Will
