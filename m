From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Dec 2013 16:14:25 +0000
Subject: [PATCH 4/6] arm64: lib: Implement optimized memcmp routine
In-Reply-To: <CAK2p4sL7ao7rdhkZv1gFL163XShvvTJr9j=hx5vZAs50Q6RJTw@mail.gmail.com>
References: <1386743082-5231-1-git-send-email-zhichang.yuan@linaro.org>
 <1386743082-5231-5-git-send-email-zhichang.yuan@linaro.org>
 <20131216165647.GH20193@mudshark.cambridge.arm.com>
 <CAK2p4sL7ao7rdhkZv1gFL163XShvvTJr9j=hx5vZAs50Q6RJTw@mail.gmail.com>
Message-ID: <20131219161424.GB29174@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 08:18:59AM +0000, Deepak Saxena wrote:
> On 16 December 2013 08:56, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Dec 11, 2013 at 06:24:40AM +0000, zhichang.yuan at linaro.org wrote:
> >> From: "zhichang.yuan" <zhichang.yuan@linaro.org>
> >>
> >> This patch, based on Linaro's Cortex Strings library, adds
> >> an assembly optimized memcmp() function.
> >
> > [...]
> >
> >> +#ifndef      __ARM64EB__
> >> +     rev     diff, diff
> >> +     rev     data1, data1
> >> +     rev     data2, data2
> >> +#endif
> >
> > Given that I can't see you defining __ARM64EB__, I'd take a guess at you
> > never having tested this code on a big-endian machine.
> 
> We'll test it, but I believe __ARM64BE__ is a compiler constant that
> is automagically present when building big endian, similar to
> __ARMBE__

It's __AARCH64EB__ (that's how we spot people not testing on big-endian ;)).

-- 
Catalin
