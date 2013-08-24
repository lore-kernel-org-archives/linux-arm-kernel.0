From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 24 Aug 2013 10:00:01 +0200
Subject: [PATCH 21/33] clk: ux500: Add Device Tree support for the PRCC
 Kernel clock
In-Reply-To: <CACRpkdYLJdmhCqXpQ0s5nbxRoFdZ3bLn+hxAhkoGHYfvugc=7A@mail.gmail.com>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <20130822092130.GB22023@lee--X1>
 <CACRpkdYLJdmhCqXpQ0s5nbxRoFdZ3bLn+hxAhkoGHYfvugc=7A@mail.gmail.com>
Message-ID: <201308241000.01649.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 August 2013, Linus Walleij wrote:
> I think this is perfectly realistic.
> 
> You're not going to duplicate each clk_register_clkdev(),
> which makes it way smaller than the original function,
> and since one of the function will be inside a
> 
> #ifdef CONFIG_OF
> #endif
> 
> After we switch the entire platform to DT-only it will be pretty
> obvious which big chunk of code that needs to go away, it's
> a clean cut.
> 
> (Note: I know the #ifdef CONFIG_OF is not necessary anymore
> since we switched to multiplatform, but I intend that marker for
> humans, not machines.)
> 

You just reminded me that I'm still sitting on this old patch
to add lots of #ifdef CONFIG_ATAGS to ux500 in the places that need
to get cut out. I don't think I'm able to update that patch at
the moment, but I can send you the old version I have if you
are interested.

	Arnd
