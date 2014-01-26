From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 25 Jan 2014 21:25:01 -0300
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <52E4367B.3090608@elopez.com.ar>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <52E42D6A.5050508@elopez.com.ar> <52E43046.1030105@gmail.com>
 <52E4367B.3090608@elopez.com.ar>
Message-ID: <20140126002500.GA13741@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

Thanks for your help with this.

On Sat, Jan 25, 2014 at 07:11:07PM -0300, Emilio L?pez wrote:
[..]
> >
> > Ok, I'll look if using of_clk_get_parent_name will help here. But again,
> > I can see that clk-gating driver gets registered before core-clk driver.
> > There may be no code to give you the parent name at that time.
> 
> After looking at some of the armada*.dtsi, I see you don't list the 
> clock names on the coreclk node, so of_clk_get_parent_name may not be of 
> much value after all.
> 

IIRC, we faced a similar issue with the Core Divider clock and solved it by
specifying the clock names in the DT.

I meant to complete the core and gating clocks in a similar way
(providing names on the DT), but apparently (as discussed with Gregory Clement)
Mike Turquette and others are planning to remove the clock names from
the DT entirely.

Can you guys explain about this plan a bit further? Or do you think we
should specify the names on the DT for all the clocks instead?

Notice that the latter would remove lots of strings from the kernel
itself (right?)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
