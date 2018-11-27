From: vkoul@kernel.org (Vinod Koul)
Date: Tue, 27 Nov 2018 20:29:11 +0530
Subject: [PATCH v4 0/2] dmaengine: add UniPhier MIO DMAC driver
In-Reply-To: <CAK7LNAR8Tk9iXPLnv4XDM0E=kTWwv2+UGz+xmtA-eJyjRFjFRw@mail.gmail.com>
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
 <20181124141616.GH3175@vkoul-mobl.Dlink>
 <CAK7LNAR8Tk9iXPLnv4XDM0E=kTWwv2+UGz+xmtA-eJyjRFjFRw@mail.gmail.com>
Message-ID: <20181127145911.GC3175@vkoul-mobl.Dlink>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-11-18, 22:53, Masahiro Yamada wrote:
> On Sat, Nov 24, 2018 at 11:16 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 12-10-18, 01:41, Masahiro Yamada wrote:
> > > 1/2: DT-binding
> > > 2/2: driver
> >
> > Applied this series, thanks
> 
> 
> Thanks.
> 
> 
> > While building I noticed that we get few warns when compiling with
> > C=1, I would prefer you fix them. Please send fixes on top of the
> > applied patches.
> 
> My code is fine.

Lets see..

> If you are talking about the following, your sparse is too old.
> Upgrade your sparse.

Not really!!

$ sparse --version
0.5.2

.. is the last released version!

Do you use from git?

> ./include/linux/overflow.h:285:13: error: undefined identifier
> '__builtin_mul_overflow'
> ./include/linux/overflow.h:285:13: error: incorrect type in conditional
> ./include/linux/overflow.h:285:13:    got void
> ./include/linux/overflow.h:287:13: error: undefined identifier
> '__builtin_add_overflow'
> ./include/linux/overflow.h:287:13: error: incorrect type in conditional
> ./include/linux/overflow.h:287:13:    got void
> ./include/linux/overflow.h:285:13: warning: call with no type!
> ./include/linux/overflow.h:287:13: warning: call with no type!

and I was also talking about:

arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
include/linux/slab.h:332:43: warning: dubious: x & !y

-- 
~Vinod
