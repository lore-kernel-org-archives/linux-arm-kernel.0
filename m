From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Sep 2013 12:08:29 -0700
Subject: [PATCH] ARM: ux500: disable outer cache debug
In-Reply-To: <1379334124-9703-1-git-send-email-linus.walleij@linaro.org>
References: <1379334124-9703-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130916190829.GA12524@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 02:22:04PM +0200, Linus Walleij wrote:
> This fixes a multiplatform regression on the Ux500.
> 
> When compiling the Ux500 platforms in multiplatform configurations
> both PL310_ERRATA_588369 and PL310_ERRATA_727915 would crash the
> platform when trying to launch the init process.
> 
> The Ux500 cannot access the debug registers of the PL310, it will
> just crash if you try this. So disable this by setting the debug
> callback to NULL when initializing the l2x0 on this platform.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC folks: this (hopefully) fixes the bug that made
> Snowball (and other Ux500) not boot properly on multi_v7.
> Please apply this patch directly to your fixes branch if you're
> happy with it.

Thanks, applied. As mentioned elsewhere, this plus the DTB_COMPAT config
change makes multi_v7_defconfig bootable on snowball.


-Olof
