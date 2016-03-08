From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Mar 2016 20:55:04 +0000
Subject: [PATCH] ARM: mvebu: Fix of_clk_get() call in a non sleeping
 context
In-Reply-To: <20160308175147.7203734e@free-electrons.com>
References: <1457446733-7137-1-git-send-email-gregory.clement@free-electrons.com>
 <20160308164117.2a3ed3a7@free-electrons.com>
 <87a8m93pt0.fsf@free-electrons.com>
 <20160308173134.22a3ad64@free-electrons.com>
 <8760wx3oy4.fsf@free-electrons.com>
 <20160308175147.7203734e@free-electrons.com>
Message-ID: <20160308205503.GO19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 05:51:47PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 08 Mar 2016 17:38:11 +0100, Gregory CLEMENT wrote:
> 
> > And from clk_enable comment we have:
> > ""
> > clk_enable must not sleep, which differentiates it from clk_prepare.  In a
> > simple case, clk_enable can be used instead of clk_prepare to ungate a clk
> > if the operation will never sleep.
> > ""
> > 
> > Moreoever for me the "must" was to insist to the order of the call no to
> > the fact that both must be called.
> 
> Right make sense, thanks for correcting me on this. If that's OK from a
> clock maintainer point of view, I'm fine.

The comment Gregory quoted is an _implementation_ comment: it's saying
that you can implement the gating/ungating in either clk_prepare() or
clk_enable().

It isn't giving permission for users of the clk API to omit these calls.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
