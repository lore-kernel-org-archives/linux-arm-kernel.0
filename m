From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 16 Jan 2012 11:18:21 +0100
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
In-Reply-To: <WC20120116100344.4204CC@terrafix.co.uk>
References: <WC20120116100344.4204CC@terrafix.co.uk>
Message-ID: <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ linux-arm, Russell and Catalin

On Mon, Jan 16, 2012 at 11:03 AM, Joe Woodward <jw@terrafix.co.uk> wrote:
> The latest uBoot release (2011.12) disables the L2/outer cache during boot on OMAP boards.
>
> uBoot commit: "armv7: disable L2 cache in cleanup_before_linux()" on 6th Dec 2011 by Aneesh V adds the following to
> uBootSources/arch/arm/cpu/armv7/cpu.c:cleanup_before_linux():
> ?...
> ?v7_out_cache_disable();
>
> The commit message implies this change was to make booting reliable on OMAP4 by disabling L2 cache before jumping to Linux. Sadly
> this commit also affects OMAP3-based boards...
>
> Since switching to uBoot 2011.12 I'm seeing about half the performance on my GUSMTIX Overo (OMAP3530).
>
> In the kernel sources there seem to be OMAP4 specific functions for re-enabling the L2 cache (omap4-common.c:omap_l2_cache_init()),
> but none for OMAP3.
>
> So my question is... do we expect that Linux should be re-enabling the L2/outer cache during boot after uBoot has disabled it on OMAP3?
>
Yes. Kernel already does enabled L2 on A8 CPU's but OMAP3 needs a
secure call and then the patching becomes
that much difficult.

We need some kind of generic hook in proc*_setup() function where in
such secure bits can be turned ON.

Regards
Santosh
