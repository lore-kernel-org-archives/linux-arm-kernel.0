From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 10:22:29 +0000
Subject: [PATCH REPOST 1/5] ARM: kvm: replace push and pop with stdmb and
 ldmia instrs to enable assembler.h inclusion
In-Reply-To: <CAA3XUr3rpEBCWbE0HGu14qgGsmt6J21D_yDeK2nFvK6_-cjPag@mail.gmail.com>
References: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
 <1387558125-3460-2-git-send-email-victor.kamensky@linaro.org>
 <20140121011825.GI13432@cbox> <52DE44C4.20503@arm.com>
 <CAA3XUr3rpEBCWbE0HGu14qgGsmt6J21D_yDeK2nFvK6_-cjPag@mail.gmail.com>
Message-ID: <20140122102229.GB1621@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Nico, as the author of the push/pull macros. Background is that kvm
is using push to store to the stack and would now like to include assembler.h]

On Wed, Jan 22, 2014 at 06:41:09AM +0000, Victor Kamensky wrote:
> On 21 January 2014 01:58, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > How about trying this alternative approach:
> >
> > It looks like all the users of the push/pop macros are located in
> > arch/arm/lib (mostly checksumming code). Can't we move these macros to a
> > separate include file and leave the code that uses push/pop (as defined
> > by the assembler) alone?
> 
> Marc, personally I am OK with such proposal. I was considering something
> along these lines as one of the options. It works for me both ways. If
> others agree I am happy to recode it as your suggested. I choose
> proposed above patch because kvm arm code came after push and pop
> defines were introduced in asm/assembler.h and used in other places.
> I am OK either way. I agree that use of push and pop as define names
> seems a bit unfortunate, but I don't have any historic visibility here
> 
> Russell, Dave, Will, do you have any opinion on Marc's proposal to
> fix this issue?

I'm perfectly fine with moving those macros into a lib/-local header file.
An alternative is renaming push/pull to something like lspush and lspull
and updating the files under lib.

Will
