From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Aug 2013 00:46:47 +0200
Subject: [PATCH 21/33] clk: ux500: Add Device Tree support for the PRCC
 Kernel clock
In-Reply-To: <20130821101448.GJ29850@lee--X1>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-22-git-send-email-lee.jones@linaro.org>
 <CACRpkdY2KOxX=oA7i9GUnzpwRKiK2rXqTBPVpg+zW082f2TJdg@mail.gmail.com>
 <20130821101448.GJ29850@lee--X1>
Message-ID: <CACRpkdYjvFTJAUL6xKxjkVd_v=DHHRkswoB_eq0Npqj5Sw23KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 12:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 21 Aug 2013, Linus Walleij wrote:

>> Isn't it possible to fork a function u8500_clk_init_dt() to add all the
>> clocks in the DT probe path and keep this function
>> u8500_clk_init() as it is?
>
> Yes, we probably could do that, but as we're ripping out ATAG booting
> support from the ux500 platform, I'll just remove the
> clk_register_clkdev()s during the process.

I really do not like the approach of uglifying something and then
beautifying it later... I prefer each step in isolation to be good
looking, or you will be confused when traversing the history.

Yours,
Linus Walleij
