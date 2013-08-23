From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 20:01:59 +0200
Subject: [PATCH 21/33] clk: ux500: Add Device Tree support for the PRCC
 Kernel clock
In-Reply-To: <20130822092130.GB22023@lee--X1>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-22-git-send-email-lee.jones@linaro.org>
 <CACRpkdY2KOxX=oA7i9GUnzpwRKiK2rXqTBPVpg+zW082f2TJdg@mail.gmail.com>
 <20130821101448.GJ29850@lee--X1>
 <CACRpkdYjvFTJAUL6xKxjkVd_v=DHHRkswoB_eq0Npqj5Sw23KQ@mail.gmail.com>
 <20130822092130.GB22023@lee--X1>
Message-ID: <CACRpkdYLJdmhCqXpQ0s5nbxRoFdZ3bLn+hxAhkoGHYfvugc=7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 11:21 AM, Lee Jones <lee.jones@linaro.org> wrote:

>> I really do not like the approach of uglifying something and then
>> beautifying it later... I prefer each step in isolation to be good
>> looking, or you will be confused when traversing the history.
>
> So then we have a few options, some more realistic than others.
>
> 1. Duplicate each of the; clk_reg_prcmu_*(), clk_reg_prcc_pclk(),
> clk_reg_prcc_kclk() calls into your proposed u8500_clk_init_dt(),
> which, while keeping everything separate would be unrealistic.

I think this is perfectly realistic.

You're not going to duplicate each clk_register_clkdev(),
which makes it way smaller than the original function,
and since one of the function will be inside a

#ifdef CONFIG_OF
#endif

After we switch the entire platform to DT-only it will be pretty
obvious which big chunk of code that needs to go away, it's
a clean cut.

(Note: I know the #ifdef CONFIG_OF is not necessary anymore
since we switched to multiplatform, but I intend that marker for
humans, not machines.)

Yours,
Linus Walleij
