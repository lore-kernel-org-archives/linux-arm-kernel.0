From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 Nov 2018 18:54:55 -0800
Subject: [PATCH] arm64: Explicitly mark 64-bit constant as unsigned long
In-Reply-To: <20181117022656.GB2470@brain-police>
References: <20181117015456.101222-1-olof@lixom.net>
 <20181117022656.GB2470@brain-police>
Message-ID: <CAOesGMgXmsGGmOAkoL7L-tZhWC=s2WwdBqsrgeR3-0c_iEgW4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 6:27 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Olof,
>
> On Fri, Nov 16, 2018 at 05:54:56PM -0800, Olof Johansson wrote:
> > Makes sparse happy. Before:
> >
> > arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  arch/arm64/include/asm/sysreg.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> The warning is bogus imo, but since it's harmless to fix it then we can do
> that. However, you've been beaten by:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/613179.html

Yeah, mostly bogus but still useful to silence warnings so you notice new ones.

Overlooked the duplicate, happy to ack that one instead.


-Olof
