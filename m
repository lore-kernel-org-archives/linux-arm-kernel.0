From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Apr 2013 10:34:12 +0100
Subject: [PATCH 7/8] dmaengine: ste_dma40: Use the BIT macro to replace
 ugly '(1 << x)'s
In-Reply-To: <201304092112.56039.arnd@arndb.de>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-7-git-send-email-lee.jones@linaro.org>
 <CAHLZz133b6kydVwh0_Cn2yg-Q_MeUF+Z-7+CMY7TkB7KK2ssAQ@mail.gmail.com>
 <201304092112.56039.arnd@arndb.de>
Message-ID: <20130410093412.GI25316@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Apr 2013, Arnd Bergmann wrote:

> On Tuesday 09 April 2013, Harvey Harrison wrote:
> > 
> > On Tue, Apr 9, 2013 at 11:39 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > The aim is to make the code that little more readable.
> > >
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > 
> > >
> > >  #define MAX(a, b) (((a) < (b)) ? (b) : (a))
> > 
> > Not part of your patch, but probably a good idea to switch to the
> > generic MAX macro, this
> > one is evaluating its args twice.
> 
> Yes, good point. The macro is only used in one place, to compare
> two compile-time constant values, but we should define macros in
> drivers that are already provided by the kernel.

Okay, it looks like the generic implementation has brackets in it,
which isn't allowed for this particular usecase. I'll fix this one
instead.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
