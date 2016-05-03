From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 May 2016 11:36:40 +0100
Subject: [PATCH v2 04/13] clkdev: Add clk_hw based registration APIs
In-Reply-To: <20160503003716.GH3492@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
 <1461277324-27185-5-git-send-email-sboyd@codeaurora.org>
 <20160503003716.GH3492@codeaurora.org>
Message-ID: <20160503103640.GO19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 05:37:16PM -0700, Stephen Boyd wrote:
> On 04/21, Stephen Boyd wrote:
> > Now that we have a clk registration API that doesn't return
> > struct clks, we need to have some way to hand out struct clks via
> > the clk_get() APIs that doesn't involve associating struct clk
> > pointers with a struct clk_lookup. Luckily, clkdev already
> > operates on struct clk_hw pointers, except for the registration
> > facing APIs where it converts struct clk pointers into struct
> > clk_hw pointers almost immediately.
> > 
> > Let's add clk_hw based registration APIs so that we can skip the
> > conversion step and provide a way for clk provider drivers to
> > operate exclusively on clk_hw structs. This way we clearly
> > split the API between consumers and providers.
> > 
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> 
> Applied to clk-next

It would have been nice if you could wait a little longer.  As I've just
explained in another email, I've been away last weekend from Thursday
21st through until Tuesday 26th.  I then spent Wednesday and Thursday
catching up with the resulting backlog of email, and last weekend (30th
through to the 2nd May) was a bank holiday weekend in the UK.  So
there's only been _one_ day that I could have looked at your patches,
but unfortunately the little matter of doing stuff for paying customers
got in the way.

A little more patience would have been nice.

I'll try to look at them this evening.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
