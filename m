From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 May 2013 16:43:47 +0200
Subject: [PATCH 1/7] ARM: u300: push down syscon registers
In-Reply-To: <CACRpkdZHRQqd277Qv8O0dek_jYb=eewhpLYfKtip-YLYx_ukUA@mail.gmail.com>
References: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
 <201305021939.48381.arnd@arndb.de>
 <CACRpkdZHRQqd277Qv8O0dek_jYb=eewhpLYfKtip-YLYx_ukUA@mail.gmail.com>
Message-ID: <201305031643.47527.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013, Linus Walleij wrote:
> I could do something similar by creating a U300 syscon node
> and referring to it from the clk node, so the clk looks up its
> syscon to find the base.
> 
> If so, I can build this on top of the current patch series
> with multiplatform and all, as I convert the clocks to DT
> (which is the next and final step).

Yes, I think this is a good plan. If there are just two drivers,
that is probably the easiest way to do it. Using the syscon
driver is not very different in the end and avoids mapping the
same physical address range multiple times (having a static mapping
avoids this too), and I'd prefer that if you have more drivers
that need to get to the same registers.

	Arnd
