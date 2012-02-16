From: sam@ravnborg.org (Sam Ravnborg)
Date: Thu, 16 Feb 2012 18:25:51 +0100
Subject: [PATCH] ARM: amba: don't include <asm/sizes.h>
In-Reply-To: <20120216160525.GA30558@mail.gnudd.com>
References: <20120216160525.GA30558@mail.gnudd.com>
Message-ID: <20120216172551.GA31306@merkur.ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 05:05:25PM +0100, Alessandro Rubini wrote:
> The file uses no SZ_* symbol and some architectures miss sizes.h
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> ---
> 
> There a number of files including but not using it. This one
> in particular I need under x86 so the fix is trivial.
> 
> However, I remember different feelings about sizes.h . Should it die
> or should it proliferate to other archs using asm-generic/sizes.h ?

It would be good to have it included for all architectures.
It really has nothing arch specific in it so it ought to live in
include/linux:

    git mv include/asm-generic include/linux
    And a fix for the archs that will be broken by this.
    A small wrapper in arch/$ARCH/include/asm could do the trick


And speaking of this file I sometime have missed:
#define SZ_1K_BITS                       10
#define SZ_2K_BITS                       11

Or something similar.

	Sam
