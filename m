From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Jul 2015 15:18:14 +0200
Subject: [PATCH 01/10] ARM: ux500: delete UART static map
In-Reply-To: <2124704.Sx5NxN2EF7@wuerfel>
References: <1431619947-14850-1-git-send-email-linus.walleij@linaro.org>
 <2124704.Sx5NxN2EF7@wuerfel>
Message-ID: <CACRpkdb58T51Bcn3gCMNseT6UNR2T+KcquQ5TYuswYbGwAUqZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 3:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 14 May 2015 18:12:27 Linus Walleij wrote:
>> Delete the static maps for the Ux500 UARTs and rely
>> on debug_ll_io_init() to do the trick.
>> commit f87b95dd2e4a8832b1d6034f15a5324db42608a0
>> "ARM: ux500: move debugmacro to debug includes"
>> defined the necessary addruart macro two years ago.
>
> Hi Linus,
>
> The whole series turned out even nicer than I expected, great work!
>
> I've taken a closer look at the remaining early map for the soc ID
> and found that this is essentially not needed either. I also found
> some more dead code, so here is what I came up with. Does this
> look reasonable to you?

I got some spare cycles so I'm churning through this on a case-by-case
basis. Sometimes it doesn't work (regulators used for audio) sometimes
it needs a bigger workaround. Adding your Suggested-by to the resulting
patches as I go along. Also tidied up SMP boot and some more.

Yours,
Linus Walleij
