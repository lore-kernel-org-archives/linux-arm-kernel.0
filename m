From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 May 2015 11:23:19 -0700
Subject: [PATCHv2 02/27] clk: ti: move generic OMAP DPLL implementation
 under drivers/clk
In-Reply-To: <555CC7CA.2090104@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
 <1431334493-24455-3-git-send-email-t-kristo@ti.com>
 <20150520012053.GC31054@codeaurora.org> <555CC7CA.2090104@ti.com>
Message-ID: <20150520182319.GD4815@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20, Tero Kristo wrote:
> On 05/20/2015 04:20 AM, Stephen Boyd wrote:
> >On 05/11, Tero Kristo wrote:
> >>With the legacy clock data now gone, we can start moving OMAP clock
> >>type implementations under clock driver. Start this with moving the
> >>generic OMAP DPLL clock type under TI clock driver.
> >>
> >>Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>---
> >
> >How much of the code is the same from the original copy? Can you
> >generate these patches with -M -C so that we can see?
> 
> Looks like for the move patches the range is from 85%...95% exact
> copy. Shall I repost the patches in this format?

Sure, a resend would be nice to actually see what changed. If
that's too much mail, maybe you can share the diffstat for the
whole series with -M -C so we can see what's moved instead.

> Good hint for the
> -M -C btw, I wonder why those are not default options for
> git-format-patch.
> 

I think it isn't the default because 'patch' the program didn't
always support the diff format that git generates with the -M and
-C options. FWIW, I have

	[diff] 
		renames = copy

in my .gitconfig for this purpose.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
