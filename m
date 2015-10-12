From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Oct 2015 10:16:02 +0100
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <CAOZdJXXYXTCAJdFY2kkjtsX9RdsTePdo4eMRjRXFodiX=gaU5g@mail.gmail.com>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <CAOZdJXXYXTCAJdFY2kkjtsX9RdsTePdo4eMRjRXFodiX=gaU5g@mail.gmail.com>
Message-ID: <20151012091601.GA16124@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 12:39:25PM -0500, Timur Tabi wrote:
> On Tue, Sep 22, 2015 at 12:59 PM, Robert Richter <rric@kernel.org> wrote:
> >
> > -#define L1_CACHE_SHIFT         6
> > +#define L1_CACHE_SHIFT         7
> >  #define L1_CACHE_BYTES         (1 << L1_CACHE_SHIFT)
> 
> Would it be better if this were a Kconfig option, like it is on ARM32?
> 
> http://lxr.free-electrons.com/source/arch/arm/include/asm/cache.h#L7

I don't think it adds anything, to be honest. We really want one kernel
that runs everywhere and we don't (yet) have the SoC variation that exists
on arch/arm/, so we may as well just keep it as big as it needs to be.
Of course, if we start to get significant divergence between the minimum
and maximum value and that in turn shows a non-trivial impact on kernel
size and/or performance, then we could consider a Kconfig option but at
that point we'd probably also need to consider whether there are alternative
ways of providing this information to the kernel.

If somebody really wants to change it for their particular kernel build,
modifying the #define isn't exactly rocket science.

Will
