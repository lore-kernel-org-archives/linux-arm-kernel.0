From: horms@verge.net.au (Simon Horman)
Date: Fri, 27 Mar 2015 21:13:11 +0900
Subject: [PATCH] ARM: kvm: round HYP section to page size instead of log2
 upper bound
In-Reply-To: <CAKv+Gu9wAY5sx0=zvGpZwEjjO0oBbUpAHawMmRZ6nQUasj+Q1A@mail.gmail.com>
References: <1427451481-16053-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427451481-16053-2-git-send-email-ard.biesheuvel@linaro.org>
 <20150327110919.GC1562@arm.com>
 <CAKv+Gu9wAY5sx0=zvGpZwEjjO0oBbUpAHawMmRZ6nQUasj+Q1A@mail.gmail.com>
Message-ID: <20150327121311.GA16077@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard, Hi Will,

On Fri, Mar 27, 2015 at 12:12:00PM +0100, Ard Biesheuvel wrote:
> On 27 March 2015 at 12:09, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Mar 27, 2015 at 10:18:01AM +0000, Ard Biesheuvel wrote:
> >> Older binutils do not support expressions involving the values of
> >> external symbols so just round up the HYP region to the page size.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Thanks Ard. I managed to reproduce the failures in -next, and this solves
> > the problem for me (the only toolchain that chokes seems to be the one on
> > kernel.org, unfortunately).

For the record that is the one I am using.

> > I'll push an updated branch after a bit more testing. Let's not touch this
> > file ever again :)

:)

> Fingers crossed ...

I have tested this patch applied on top of next-20150326 and the build
problem I observed is gone. I have also tested that the resulting kernel
boots on a range of Renesas boards.

Tested-by: Simon Horman <horms+renesas@verge.net.au>
