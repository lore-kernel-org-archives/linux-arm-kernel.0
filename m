From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jun 2013 22:52:03 +0200
Subject: [PATCH 21/21] clk: ux500: Supply provider look-up functionality
 to support Device Tree
In-Reply-To: <CACRpkdaNMR=6JT+pi+9aqOJXW3gK9Yb4hztx3rOiY3c+f3UTRA@mail.gmail.com>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
 <1370266965-7901-22-git-send-email-lee.jones@linaro.org>
 <CACRpkdaNMR=6JT+pi+9aqOJXW3gK9Yb4hztx3rOiY3c+f3UTRA@mail.gmail.com>
Message-ID: <201306042252.03340.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013, Linus Walleij wrote:
> The whole thing is very different from other DT clock things
> I've seen, usually you add a compatible node for each
> clock type, and a node for each physical gate. But there
> may be several ways to skin this cat...
> 

Based on the IRC discussion we had, I would think that the "prcc" clocks
would best be represented using multiple clock-cells since you can describe
them easily a tuple of register index, bit number some way to distinguish
the two types.

The "prcmu" clocks are harder, and we probably need either a more verbose
representation using one node per clock there, or have a single node
for the entire prcmu and not bother to describe them in DT but hardcode
everything in the source. The current patch does the latter, which is
easier now but means we cannot simplify the code much in the future
when we remove ATAGS boot support.

I hope Mike can give some better insight to what his preferences are.

	Arnd
