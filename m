From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Feb 2014 11:57:07 +0100
Subject: [Linux-kernel] [PATCH 2/3] ARM: shmobile: r8a7790: specify
 multiple parents for cpg_clks
In-Reply-To: <52F21448.6060408@codethink.co.uk>
References: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
 <1565445.R9bPDKl3Py@avalon> <52F21448.6060408@codethink.co.uk>
Message-ID: <1949387.Spln3q4hDr@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Wednesday 05 February 2014 10:36:56 Ben Dooks wrote:
> On 05/02/14 10:32, Laurent Pinchart wrote:
> > On Wednesday 05 February 2014 09:15:31 Ben Dooks wrote:
> >> On 04/02/14 18:17, William Towle wrote:
> >>> The current drivers/clk/shmobile/clk-rcar-gen2.c uses the
> >>> extal_clk reference for the parent of all the clocks that
> >>> it registers. However the lb, qspi, sdh, sd0 and sd1 clocks
> >>> are all parented to either pll1 or pll1_div2 which means
> >>> that the clock rates are incorrect.
> >>> 
> >>> This is part of the fix that corrects the SDHI0 clock
> >>> 
> >>> rate error where it reports 1MHz instead of 97.5:
> >>>       sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 1
> >>>       MHz
> >>> 
> >>> Notes:
> >>> - May require cross-merge with clk-rcar-gen2.c fix
> >>> - Also not clear which clock "z" is to fix it.
> >> 
> >> Laurent, if you could give us an idea of how to fix this then
> >> it would be helpful to get this patch fully fixed.
> > 
> > I've already sent a patch that fixes this issue.
> > 
> > "clk: shmobile: rcar-gen2: Fix clock parent all non-PLL clocks"
> > 
> > (http://www.spinics.net/lists/linux-sh/msg27275.html)
> > 
> > I've just pinged Mike to ask him to pick it up for v3.14.
> 
> I just saw and commented on it. I think the DT is the nicer way
> of actually doing this, especially if the driver may get re-used
> in future.

I've replied to that in the other mail thread, we can continue the discussion 
there.

> There's also an issue with SDHI0/1 divider table which has been posted too.

I've replied to that patch as well.

-- 
Regards,

Laurent Pinchart
