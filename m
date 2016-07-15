From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Jul 2016 10:19:54 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate
 application method
In-Reply-To: <64d0c1e2-d818-0806-7c92-c10603b4f6f5@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com>
 <20160630204001.GC5485@lukather>
 <64d0c1e2-d818-0806-7c92-c10603b4f6f5@megous.com>
Message-ID: <20160715081954.GQ4761@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 02:53:52AM +0200, Ond?ej Jirman wrote:
> On 30.6.2016 22:40, Maxime Ripard wrote:
> > Hi,
> > 
> > On Sat, Jun 25, 2016 at 05:45:03AM +0200, megous at megous.com wrote:
> >> From: Ondrej Jirman <megous@megous.com>
> >>
> >> PLL1 on H3 requires special factors application algorithm,
> >> when the rate is changed. This algorithm was extracted
> >> from the arisc code that handles frequency scaling
> >> in the BSP kernel.
> >>
> >> This commit adds optional apply function to
> >> struct factors_data, that can implement non-trivial
> >> factors application method, when necessary.
> >>
> >> Also struct clk_factors_config is extended with position
> >> of the PLL lock flag.
> > 
> > Have you tested the current implementation, and found that it was not
> > working, or did you duplicate the arisc code directly?
> 
> Also of note is that similar code probably doesn't crash in u-boot,
> because there, before changing the PLL1 clock, the cpu is switched to
> 24MHz osc, so it is not overclocked, even if factors align in such a way
> that you'd get the behavior I described in the other email.

That's also something that we can do.

See Meson's clk-cpu clock notifiers for example.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/235bbbce/attachment-0001.sig>
