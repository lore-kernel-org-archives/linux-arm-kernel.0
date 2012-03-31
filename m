From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 31 Mar 2012 20:54:43 +0800
Subject: [PATCH 2/2] regulator: rename function regulator_register_fixed
In-Reply-To: <20120331102507.GB3163@opensource.wolfsonmicro.com>
References: <1333182812-423-1-git-send-email-shawn.guo@linaro.org>
 <1333182812-423-2-git-send-email-shawn.guo@linaro.org>
 <20120331102507.GB3163@opensource.wolfsonmicro.com>
Message-ID: <20120331125440.GA2395@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 11:25:08AM +0100, Mark Brown wrote:
> On Sat, Mar 31, 2012 at 04:33:32PM +0800, Shawn Guo wrote:
> 
> > Function regulator_register_fixed() is only meant for registering
> > fixed dummy regulators.  Rename it to regulator_register_fixed_dummy()
> > for the explicit meaning, so that people do not attempt to register
> > those real fixed regulators with this function.
> 
> There's no harm in using it for regulators that physically exist if
> nothing cares about any of the information it can't provide

I do not think it's practical for physical regulator to use the
function, since the function forces microvolts to be 0.

> and renaming
> it now is going to cause annoyance with cross tree issues so I'm kind of
> reluctant to apply this.  Are there any concrete problems that have been
> caused by this or was it just something you noticed when looking at
> using it yourself?

I noticed it when I was trying to use the function to register a fixed
regulator which physically exist, and it turns out that I just was
misled by the function name.

> 
> > It also removes the kernel doc for @name which is not a parameter for
> > the function at all.
> 
> This is already done, I can't remember who sent the patch off the top of
> my head.

I did not see it on regulator/for-next branch.  But it's so trivial
and I do not care much.

-- 
Regards,
Shawn
