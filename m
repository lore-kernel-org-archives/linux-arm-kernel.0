From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Sep 2013 09:03:39 +0100
Subject: [PATCH] ARM: ux500: disable outer cache debug
In-Reply-To: <20130916190829.GA12524@quad.lixom.net>
References: <1379334124-9703-1-git-send-email-linus.walleij@linaro.org>
 <20130916190829.GA12524@quad.lixom.net>
Message-ID: <20130917080339.GR16984@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Sep 2013, Olof Johansson wrote:

> On Mon, Sep 16, 2013 at 02:22:04PM +0200, Linus Walleij wrote:
> > This fixes a multiplatform regression on the Ux500.
> > 
> > When compiling the Ux500 platforms in multiplatform configurations
> > both PL310_ERRATA_588369 and PL310_ERRATA_727915 would crash the
> > platform when trying to launch the init process.
> > 
> > The Ux500 cannot access the debug registers of the PL310, it will
> > just crash if you try this. So disable this by setting the debug
> > callback to NULL when initializing the l2x0 on this platform.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Hi ARM SoC folks: this (hopefully) fixes the bug that made
> > Snowball (and other Ux500) not boot properly on multi_v7.
> > Please apply this patch directly to your fixes branch if you're
> > happy with it.
> 
> Thanks, applied. As mentioned elsewhere, this plus the DTB_COMPAT config
> change makes multi_v7_defconfig bootable on snowball.

\o/

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
