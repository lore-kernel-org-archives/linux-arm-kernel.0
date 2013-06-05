From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 5 Jun 2013 09:05:22 +0100
Subject: [PATCH 21/21] clk: ux500: Supply provider look-up functionality
 to support Device Tree
In-Reply-To: <201306042252.03340.arnd@arndb.de>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
 <1370266965-7901-22-git-send-email-lee.jones@linaro.org>
 <CACRpkdaNMR=6JT+pi+9aqOJXW3gK9Yb4hztx3rOiY3c+f3UTRA@mail.gmail.com>
 <201306042252.03340.arnd@arndb.de>
Message-ID: <20130605080522.GP3370@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Jun 2013, Arnd Bergmann wrote:

> On Tuesday 04 June 2013, Linus Walleij wrote:
> > The whole thing is very different from other DT clock things
> > I've seen, usually you add a compatible node for each
> > clock type, and a node for each physical gate. But there
> > may be several ways to skin this cat...
> > 
> 
> Based on the IRC discussion we had, I would think that the "prcc" clocks
> would best be represented using multiple clock-cells since you can describe
> them easily a tuple of register index, bit number some way to distinguish
> the two types.
> 
> The "prcmu" clocks are harder, and we probably need either a more verbose
> representation using one node per clock there, or have a single node
> for the entire prcmu and not bother to describe them in DT but hardcode
> everything in the source. The current patch does the latter, which is
> easier now but means we cannot simplify the code much in the future
> when we remove ATAGS boot support.

As already discussed, in the PRCMU case I'm going to make 'enum
prcmu_clock {' look like register PRCM_YYCLKEN0_MGT_SET as described
by the design specification, and use that as our indexer.

> I hope Mike can give some better insight to what his preferences are.
> 
> 	Arnd

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
