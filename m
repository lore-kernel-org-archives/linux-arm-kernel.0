From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 13:56:07 +0100
Subject: [PATCH 21/21] clk: ux500: Supply provider look-up functionality
 to support Device Tree
In-Reply-To: <CACRpkdaNMR=6JT+pi+9aqOJXW3gK9Yb4hztx3rOiY3c+f3UTRA@mail.gmail.com>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
 <1370266965-7901-22-git-send-email-lee.jones@linaro.org>
 <CACRpkdaNMR=6JT+pi+9aqOJXW3gK9Yb4hztx3rOiY3c+f3UTRA@mail.gmail.com>
Message-ID: <20130612125607.5C13E3E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jun 2013 12:57:06 +0200, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 3, 2013 at 3:42 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > In this patch we're populating a clk_data array, one clock per element to
> > act as a clk look-up using indexes supplied from Device Tree.
> >
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> This needs to be patch 1/21 because otherwise the rest of the
> stuff is non-bisectable right? It's being broken the first time
> you remove auxdata and not fixed until this patch.
> 
> The whole thing is very different from other DT clock things
> I've seen, usually you add a compatible node for each
> clock type, and a node for each physical gate. But there
> may be several ways to skin this cat...

The design choice made here is perfectly fine by me. There has never
been a requirement to expose every clock as a separate node, and for
SoCs with complex clock control blocks I can certainly appreciate not
wanting to expose how the internal clocks interact out to the device
tree, especially if only the leaf clocks ever get reverenced by device
drivers. As long as there is a driver there that understands the binding
and hands out the correct clock when asked, then this design is great.

g.
